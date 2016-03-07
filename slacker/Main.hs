import           Control.Applicative ((<$>))
import           Network.Slack
import           System.Directory
import           System.Environment  (getArgs)

main :: IO ()
main = do
  (user:slack:channel:stuff) <- getArgs
  token <- (head . lines) <$> (readFile . (++("/.slack/tokens/" ++ slack)) =<< getHomeDirectory)
  print =<< (runSlack token $
    postMessage user (unwords stuff) =<<     channelFromName channel)
