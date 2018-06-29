module Main where

import Parser
import Ast
import Text.Megaparsec
import System.Directory
import Control.Monad
import Data.List (isSuffixOf)

main :: IO ()
main = do
  passingTests <- filter (isSuffixOf ".mc") <$> listDirectory "tests/pass"
  forM_ passingTests $ \file -> withCurrentDirectory "tests/pass" $ do
    contents <- readFile file
    putStrLn contents
    let parseTree = runParser programP file contents 
    case parseTree of
      Left err -> print err
      Right success -> print success
    