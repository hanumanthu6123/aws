{-# LANGUAGE RecordWildCards, MultiParamTypeClasses, FlexibleInstances, FlexibleContexts #-}

module Aws.SimpleDb.CreateDomain
where

import           Aws.Query
import           Aws.SimpleDb.Error
import           Aws.SimpleDb.Info
import           Aws.SimpleDb.Response
import           Aws.Transaction
import           Control.Applicative
import           Text.XML.Monad
import qualified Control.Failure       as F

data CreateDomain
    = CreateDomain {
        cdDomainName :: String
      }
    deriving (Show)

data CreateDomainResponse 
    = CreateDomainResponse
    deriving (Show)
             
createDomain :: String -> CreateDomain
createDomain name = CreateDomain { cdDomainName = name }
             
instance AsQuery CreateDomain SdbInfo where
    asQuery i CreateDomain{..} = addQuery [("Action", "CreateDomain"), ("DomainName", cdDomainName)] (sdbiBaseQuery i)

instance SdbFromResponse CreateDomainResponse where
    sdbFromResponse = CreateDomainResponse <$ testElementNameUI "CreateDomainResponse"

instance Transaction CreateDomain SdbInfo (SdbResponse CreateDomainResponse)