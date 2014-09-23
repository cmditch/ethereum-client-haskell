{-# OPTIONS_GHC -Wall #-}

module Wire (
  Message(..),
  Capability(..),
  obj2WireMessage,
  wireMessage2Obj
  ) where

import Data.Bits
import Data.ByteString.Internal
import Data.Functor
import Data.List
import Data.Time.Clock.POSIX
import Data.Word

import Block
import Colors
import Format
import Transaction
import RLP
import Debug.Trace



--instance Show Block where
--  show x = "<BLOCK>"

data Capability =
  ProvidesPeerDiscoveryService | 
  ProvidesTransactionRelayingService | 
  ProvidesBlockChainQueryingService deriving (Show)

capValue::Capability->Word8
capValue ProvidesPeerDiscoveryService = 0x01
capValue ProvidesTransactionRelayingService = 0x02 
capValue ProvidesBlockChainQueryingService = 0x04



data IPAddr = IPAddr Word8 Word8 Word8 Word8 deriving (Show)

instance Format IPAddr where
  format (IPAddr v1 v2 v3 v4) = show v1 ++ "." ++ show v2 ++ "." ++ show v3 ++ "." ++ show v4 

data Peer = Peer {
  ipAddr::IPAddr,
  peerPort::Word16,
  uniqueId::String
  } deriving (Show)

instance Format Peer where
  format peer = format (ipAddr peer) ++ ":" ++ show (peerPort peer)


data Message =
  Hello { version::Int, clientId::String, capability::[Capability], port::Int, nodeId::String } |
  Ping |
  Pong |
  GetPeers |
  Peers [Peer] |
  Transactions [Transaction] | 
  Blocks [Block] |
  GetChain { parentSHAs::[String], numChildItems::Int } |
  GetTransactions deriving (Show)

instance Format Message where
  format (Peers peers) = blue "Peers: " ++ intercalate ", " (format <$> peers)
  format x = show x

getStringFromRLP::RLPObject->String
getStringFromRLP (RLPString theString) = theString
getStringFromRLP x = error ("getStringFromRLP called on non string object: " ++ show x)

getBlockDataFromRLP::RLPObject->BlockData
getBlockDataFromRLP (RLPArray [v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13]) =
  BlockData {
    parentHash = fromIntegral $ getNumber v1,
    unclesHash = fromIntegral $ getNumber v2,
    coinbase = fromIntegral $ getNumber v3,
    stateRoot = fromIntegral $ getNumber v4,
    transactionsTrie = fromIntegral $ getNumber v5,
    difficulty = fromIntegral $ getNumber v6,
    number = fromIntegral $ getNumber v7,
    minGasPrice = fromIntegral $ getNumber v8,
    gasLimit = fromIntegral $ getNumber v9,
    gasUsed = fromIntegral $ getNumber v10,
    timestamp = posixSecondsToUTCTime $ fromIntegral $ getNumber v11,
    extraData = fromIntegral $ getNumber v12,
    nonce =fromIntegral $ getNumber v13
    }  
getBlockDataFromRLP (RLPArray arr) = error ("getBlockDataFromRLP called on object with wrong amount of data, length arr = " ++ show (length arr))
getBlockDataFromRLP x = error ("getBlockDataFromRLP called on non block object: " ++ show x)

getBlockFromRLP::RLPObject->Block
getBlockFromRLP (RLPArray [blockData, RLPArray uncles, transactionReceipt]) =
  trace (show transactionReceipt) $
  Block (getBlockDataFromRLP blockData) (getBlockDataFromRLP <$> uncles) []
getBlockFromRLP (RLPArray arr) = error ("getBlockFromRLP called on object with wrong amount of data, length arr = " ++ show (length arr))
getBlockFromRLP x = error ("getBlockFromRLP called on non block object: " ++ show x)

rlpArray2Peer::RLPObject->Peer
rlpArray2Peer (RLPArray [RLPString [c1, c2, c3, c4], RLPNumber p, RLPString id]) =
  Peer {
    ipAddr = IPAddr (c2w c1) (c2w c2) (c2w c3) (c2w c4),
    peerPort = fromIntegral p,
    uniqueId = id
    }
rlpArray2Peer x = error ("rlpArray2Peer called on non block object: " ++ show x)

rlpArray2Transaction::RLPObject->Transaction
rlpArray2Transaction (RLPArray [n, gp, gl, to, val, i, v, r, s]) =
  Transaction {
    tNonce = fromIntegral $ getNumber n,
    gasPrice = fromIntegral $ getNumber gp,
    tGasLimit = fromIntegral $ getNumber gl,
    to = fromIntegral $ getNumber to,
    value = fromIntegral $ getNumber val,
    tInit = fromIntegral $ getNumber i,
    v = fromIntegral $ getNumber v,
    r = fromIntegral $ getNumber r,
    s = fromIntegral $ getNumber s
    }
rlpArray2Transaction x = error ("rlpArray2Transaction called on non block object: " ++ show x)

obj2WireMessage::RLPObject->Message
obj2WireMessage (RLPArray (RLPNumber 0x00:RLPNumber v:RLPNumber 0:RLPString cId:RLPNumber cap:RLPNumber p:RLPString nId:[])) =
  Hello v cId capList p nId
  where
    capList = 
      (if cap .&. 1 /= 0 then [ProvidesPeerDiscoveryService] else []) ++
      (if cap .&. 2 /= 0 then [ProvidesTransactionRelayingService] else []) ++
      (if cap .&. 3 /= 0 then [ProvidesBlockChainQueryingService] else [])
obj2WireMessage (RLPArray [RLPNumber 0x02]) = Ping
obj2WireMessage (RLPArray [RLPNumber 0x03]) = Pong
obj2WireMessage (RLPArray [RLPNumber 0x10]) = GetPeers
obj2WireMessage (RLPArray (RLPNumber 0x11:peers)) = Peers $ rlpArray2Peer <$> peers
obj2WireMessage (RLPArray (RLPNumber 0x12:transactions)) =
  Transactions $ rlpArray2Transaction <$> transactions
obj2WireMessage (RLPArray (RLPNumber 0x13:blocks)) =
  Blocks $ getBlockFromRLP <$> blocks

obj2WireMessage (RLPArray (RLPNumber 0x14:items)) =
  GetChain parentSHAs numChildren
  where
    RLPNumber numChildren = last items
    parentSHAs = getStringFromRLP <$> init items

obj2WireMessage (RLPArray [RLPNumber 0x16]) = GetTransactions

obj2WireMessage (RLPArray x) = error ("Missing message: " ++ show x)


wireMessage2Obj::Message->RLPObject
wireMessage2Obj Hello { version = v,
                        clientId = cId,
                        capability = cap,
                        port = p,
                        nodeId = nId } =
  RLPArray [
    RLPNumber 0x00,
    RLPNumber v,
    RLPNumber 0,
    RLPString cId,
    RLPNumber $ fromIntegral $ foldl (.|.) 0x00 $ capValue <$> cap,
    RLPNumber p,
    RLPString nId
    ]

wireMessage2Obj (Transactions transactions) =
  RLPArray (RLPNumber 0x12:(transaction2RLP <$> transactions))
  where
    transaction2RLP t =
      RLPArray [
        rlpNumber $ tNonce t,
        rlpNumber $ gasPrice t,
        RLPNumber $ tGasLimit t,
        rlpNumber $ to t,
        rlpNumber $ value t,
        RLPNumber $ tInit t,
        RLPNumber $ fromIntegral $ v t,
        rlpNumber $ r t,
        rlpNumber $ s t
        ]