{-# LANGUAGE OverloadedStrings #-}

module Block (
  BlockData(..),
  Block(..)
  ) where

import Crypto.Hash.SHA3
import Data.Bits
import qualified Data.ByteString as B
import Data.ByteString.Base16
import Data.ByteString.Internal
import Data.Time
import Data.Word
import Numeric

import ExtendedECDSA

import Format
import PrettyBytes
import RLP
import Util

import Debug.Trace

data TransactionReceipt = TransactionReceipt deriving (Show)

data BlockData = BlockData {
  parentHash::Integer,
  unclesHash::Integer,
  coinbase::Integer,
  stateRoot::Integer,
  transactionsTrie::Integer,
  difficulty::Integer,
  number::Integer,
  minGasPrice::Integer,
  gasLimit::Integer,
  gasUsed::Integer,
  timestamp::UTCTime,
  extraData::Integer,
  nonce::Integer
} deriving (Show)

data Block = Block BlockData [BlockData] [TransactionReceipt] deriving (Show)
