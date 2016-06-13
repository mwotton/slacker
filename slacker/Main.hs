{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
import           Control.Applicative       ((<$>))
import           Control.Monad.IO.Class    (liftIO)
import           Control.Monad.State.Class

import qualified Data.Text                 as T
import           System.Directory
import           System.Environment        (getArgs)
import           System.Exit
import qualified Web.Slack                 as S
import qualified Web.Slack.Message         as S
import qualified Web.Slack.Types.Id        as SI

echoBot user slack channel stuff S.Hello = do
  liftIO $ print "hello"
  r <- map S._channelId . filter ((=="automated_alerts") . S._channelName ) . S._slackGroups . S._session <$> get
  case r of
    [] -> liftIO $ print ("no such channel", channel) >> exitFailure
    [r] -> do
      S.sendMessage r (T.pack $ concat stuff)
      liftIO exitSuccess

echoBot a b c d e = liftIO $ print "somethingelse" >> print (a,b,c,d,e)

main :: IO ()
main = do
  (user:slack:channel:stuff) <- getArgs
  print "doin stuff"
  token <- (head . lines) <$> (readFile . (++("/.slack/tokens/" ++ slack)) =<< getHomeDirectory)
 --  Right x <- runSlack token $ channels
--  mapM_ print x

  S.runBot (S.SlackConfig token) (echoBot user slack channel stuff) ()

--   print =<< (runSlack token $ (postMessage user (unwords stuff) =<<     channelFromName channel))
