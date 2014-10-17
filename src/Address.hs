{-# OPTIONS_GHC -Wall #-}

module Address (
  Address(..),
  prvKey2Address,
  rlp2Address,
  address2RLP
  ) where

import Crypto.Hash.SHA3
import Data.Binary
import qualified Data.ByteString.Lazy as BL
import qualified Data.ByteString.Lazy.Char8 as BLC
import Network.Haskoin.Crypto hiding (Address)
import Network.Haskoin.Internals hiding (Address)
import Numeric

import Colors
import Format
import RLP
import Util

newtype Address = Address Word160 deriving (Show, Eq)

instance Format Address where
  format (Address x) = yellow $ padZeros 40 $ showHex x ""

prvKey2Address::PrvKey->Address
prvKey2Address prvKey =
  Address $ fromInteger $ byteString2Integer $ hash 256 $ BL.toStrict $ encode x `BL.append` encode y
  --B16.encode $ hash 256 $ BL.toStrict $ encode x `BL.append` encode y
  where
    PubKey point = derivePubKey prvKey
    x =
      case getX point of
        Just val -> val
        _ -> error "getX failed in prvKey2Address"
    y =
      case getY point of
        Just val -> val
        _ -> error "getY failed in prvKey2Address"


address2RLP::Address->RLPObject
address2RLP (Address a) = RLPString $ BLC.unpack $ encode a

rlp2Address::RLPObject->Address
rlp2Address (RLPString s) = Address $ decode $ BLC.pack s
rlp2Address x = error ("Malformed rlp object sent to rlp2Address: " ++ show x)