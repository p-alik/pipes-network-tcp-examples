module Examples.ServePipes (main) where

import           Data.Word8        (toUpper)
import           Pipes
import qualified Pipes.ByteString  as Bytes
import           Pipes.Network.TCP (HostPreference (Host), fromSocket, serve,
                                    toSocket)
import qualified Pipes.Prelude     as P

main :: IO ()
main = serve (Host "127.0.0.1") "4000" $ \(client,_) ->
       runEffect $ fromSocket client 4096
                   >-> Bytes.map toUpper
                   >-> toSocket client





-- --------------------------------------------------------------
--
-- {-# LANGUAGE OverloadedStrings #-}
-- import           Conduit
-- import           Data.Conduit.Network
-- import           Data.Word8           (toUpper)
--
-- main :: IO ()
-- main = runTCPServer (serverSettings 4000 "*") $ \appData ->
--     appSource appData $$ omapCE toUpper =$ appSink appData
