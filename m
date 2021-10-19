Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3DF4331FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhJSJST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbhJSJSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:18:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0DEC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:16:00 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z77-20020a1c7e50000000b0030db7b70b6bso1965268wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hJF0qVyDCfrGBp8OB6VoPxisLENdyRqq4ZhJDY0r8c=;
        b=i6AaVg1iz0V1R/fgiVVtlSvjancWXj1lAKGn2HWwZWKBB7v2UCCHWCZcrlrSLun2aZ
         dfD6NTRvzpSgqQ/lbd1uTLEpJxGE2szb2ys1ru5hXX96vDgBvxOpUdCXjOxfukv58T01
         hLLvQN57dmTwNndsxjlQ4OdK1XxeQoNHLIfjPq6DzRfjxCTxCqvKC1my4cYQzTuyupfq
         dPF/D1l6oc+4YzSu9/PrwPDMVbODmR8Yk7SlWMDCvRSMM6eammU/hFBc3zzjQ7BjHoHo
         UtmDdPTsy7dL/8DI781OKOw+RWnu3OOINpjaeh8FXMNQuyIng19mO3CM1aVxnO1C2s11
         niNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hJF0qVyDCfrGBp8OB6VoPxisLENdyRqq4ZhJDY0r8c=;
        b=e+3PssevHTaG6tvD7CNcZIX+8bKJQJCLMs9N2rbxwE2Jrlnrny0F3b5N9BkAWfAZb8
         DgmHmJyEzxtiiqsngvb6PQXCEwEIrw9UQzlO0C+xpwkMVV7LrJLu2sS/hehAhwXFLaRF
         Va1Jy7hvggQXwYn4gGNIKs/viqScU0tjgehlDODqcCPM8cKssrDzFSXLctq2h/bT7L3+
         vRVaq+YvqYwM/ijkIIefebp3li+0+oUufSjGsa1ykMmln+T9ANNcH4ARWaeACFNf3yyn
         6r+NEu3raK+y7ZZIDqG13m7AxKoeIOvcKRAQ83VNtb0exjNukuRxxhYFogqkTovF6JyB
         kDJw==
X-Gm-Message-State: AOAM531uTqbpNyNIBq5CbjMn9yAjmS2WfIAomceQZjExFncEHgDq+A9c
        o6R3t4gJu8T3hQGxX5NGu/4=
X-Google-Smtp-Source: ABdhPJyfBYsS6EGY2mmJnlyQ4Ec3tRD/3oq4J3FIVFsenlsmAMZdILMFCNKzTYTLNaHgN2was/iuUw==
X-Received: by 2002:a05:600c:4ece:: with SMTP id g14mr4688263wmq.95.1634634959050;
        Tue, 19 Oct 2021 02:15:59 -0700 (PDT)
Received: from precision.. (aftr-62-216-202-35.dynamic.mnet-online.de. [62.216.202.35])
        by smtp.gmail.com with ESMTPSA id y191sm2029281wmc.36.2021.10.19.02.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 02:15:53 -0700 (PDT)
From:   Mete Polat <metepolat2000@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Mete Polat <metepolat2000@gmail.com>
Subject: [PATCH 2/2] rbtree: add verified oracle with testing harness
Date:   Tue, 19 Oct 2021 11:13:49 +0200
Message-Id: <20211019091349.39788-3-metepolat2000@gmail.com>
In-Reply-To: <20211019091349.39788-1-metepolat2000@gmail.com>
References: <20211019091349.39788-1-metepolat2000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The folder rbtree_oracle hosts a Haskell project that consists of:
- the verified Haskell RBT implementation (RBT/Verified.hs)
- a Haskell interface to communicate to the kernel module that exposes
  some rbtree operations (RBT/Kernel.hs)
- two different test strategies (Strategy.hs) which propose test cases
  that are then applied on the oracle (the verified implementation
  RBT/Verified.hs) and on the kernel rbt using the kernel module
  interface.
- a entry point for the executable (Main.hs) which also compares the
  kernel and verified rbtree after executing a test case
- an Isabelle (the proof assistant in which the verified RBT was
  formalized and proved) export file to export the proved RBT
  implementation to Haskell (RBT/Verified.hs; requires Isabelle to
  export).
- files to build the Haskell project with cabal (a build system for
  Haskell)

The whole test suite is in the functional programming language Haskell
because the verified RBT (the oracle) is also written in a functional
language (Isabelle/HOL).

Use 'cabal run rbtTestHarness -- <OPTIONS>' to build and run the test
harness with the specified options. This requires the GHC Haskell
compiler and the Haskell cabal build system.

$ cabal run --verbose=0 rbtTestHarness -- --help
Testing harness for comparing the Linux Red-Black trees against a
verified oracle. The harness immediately stops when a kernel RBT
violates an RBT invariant and prints an error message.

Usage: rbtTestHarness [-v] COMMAND

Available options:
  -v                       Print all executed operations and the
                           resulting trees.
  -h,--help                Show this help text

Available commands:
  random                   Randomly call insert and delete operations on
                           the kernel and oracle without resetting their
			   trees. Will lead to large trees.
  exhaustive               Try (almost) all combinations up to a limit.

$ cabal run --verbose=0 rbtTestHarness -- random --help
Usage: rbtTestHarness random -n ARG [-s <seed>]
  Randomly call insert and delete operations on the kernel and oracle
  without resetting their trees. Will lead to large trees.

Available options:
  -s <seed>                Seed for the pseudo-random-number generator
                           (default: 42)
  -h,--help                Show this help text

$ cabal run --verbose=0 rbtTestHarness -- exhaustive --help
Usage: rbtTestHarness exhaustive -n ARG
  Try (almost) all combinations up to a limit.

Available options:
  -h,--help                Show this help text
---
 tools/testing/rbtree_oracle/.gitignore        |   1 +
 tools/testing/rbtree_oracle/Main.hs           | 128 +++++++++
 tools/testing/rbtree_oracle/RBT/Kernel.hs     |  64 +++++
 tools/testing/rbtree_oracle/RBT/Verified.hs   | 253 ++++++++++++++++++
 tools/testing/rbtree_oracle/RBT_export.thy    |  41 +++
 tools/testing/rbtree_oracle/Setup.hs          |   2 +
 tools/testing/rbtree_oracle/Strategy.hs       |  72 +++++
 .../rbtree_oracle/rbtTestHarness.cabal        |  15 ++
 8 files changed, 576 insertions(+)
 create mode 100644 tools/testing/rbtree_oracle/.gitignore
 create mode 100644 tools/testing/rbtree_oracle/Main.hs
 create mode 100644 tools/testing/rbtree_oracle/RBT/Kernel.hs
 create mode 100644 tools/testing/rbtree_oracle/RBT/Verified.hs
 create mode 100644 tools/testing/rbtree_oracle/RBT_export.thy
 create mode 100644 tools/testing/rbtree_oracle/Setup.hs
 create mode 100644 tools/testing/rbtree_oracle/Strategy.hs
 create mode 100644 tools/testing/rbtree_oracle/rbtTestHarness.cabal

diff --git a/tools/testing/rbtree_oracle/.gitignore b/tools/testing/rbtree_oracle/.gitignore
new file mode 100644
index 000000000000..cfe7d10d198f
--- /dev/null
+++ b/tools/testing/rbtree_oracle/.gitignore
@@ -0,0 +1 @@
+dist-*
diff --git a/tools/testing/rbtree_oracle/Main.hs b/tools/testing/rbtree_oracle/Main.hs
new file mode 100644
index 000000000000..13a83c1b3ce3
--- /dev/null
+++ b/tools/testing/rbtree_oracle/Main.hs
@@ -0,0 +1,128 @@
+{- SPDX-License-Identifier: GPL-2.0-or-later -}
+{- Copyright (C) 2021 Mete Polat -}
+
+module Main where
+
+import Control.Monad
+import Control.Monad.Reader
+import Data.Monoid
+import Data.Word
+import Options.Applicative
+import RBT.Kernel (IRBT, Cmd(..))
+import RBT.Verified
+import Strategy
+import qualified RBT.Kernel as Kernel
+import qualified RBT.Verified as RBT (empty, equal_tree)
+import qualified RBT.Verified as Verified (insert, delete)
+
+data Options = Options {
+  verbose :: Bool,
+  strategy :: Strategy }
+
+type OptionsT m a = ReaderT Options m a
+
+data RandomOptions = RandomOptions {
+  n :: Word64,
+  seed :: Int }
+
+data ExhaustiveOptions = ExhaustiveOptions { n :: Word64 }
+
+data Strategy = Random RandomOptions | Exhaustive ExhaustiveOptions
+
+restartHeader = "------Restart------\n"
+
+
+main :: IO ()
+main = do
+  options@Options{..} <- execParser options
+
+  let rss = case strategy of
+        Random (RandomOptions n seed) -> Strategy.random n seed
+        Exhaustive (ExhaustiveOptions n) -> Strategy.exhaustive n
+
+  unless (null rss) $ do
+    hdl <- Kernel.init
+
+    forM_ rss $ \rs -> do
+      Kernel.reset hdl
+      when verbose $ putStrLn restartHeader
+      runReaderT (checkResults rs RBT.empty hdl) options
+
+    Kernel.cleanup hdl
+
+
+invariantCompare :: IRBT -> IRBT -> Either [String] ()
+invariantCompare vTree kTree = unless (rbt kTree && inorder kTree == inorder vTree) $
+  Left $ map fst $ filter (not . snd) [
+      ("color"     ,  invc kTree) ,
+      ("height"    ,  invh kTree) ,
+      ("root_black",  rootBlack kTree) ,
+      ("inorder"   ,  inorder vTree == inorder kTree) ]
+
+
+printTrees :: Input -> IRBT -> IRBT -> IRBT -> [String] -> IO ()
+printTrees (cmd,key) vTree kTree kTreePrev invs = do
+  putStrLn $ unwords $ if null invs
+  then [show cmd, show key]
+  else ["After", show cmd, show key, "following invariants failed:"] ++ invs
+  putStrLn $ "Kernel tree before:  " ++ show kTreePrev
+  putStrLn $ "Kernel tree after:   " ++ show kTree
+  putStrLn $ "Verified tree after: " ++ show vTree
+  putStrLn ""
+
+
+checkResults :: [Result] -> IRBT -> Kernel.Handle -> OptionsT IO ()
+checkResults [] _ _  = liftIO $ return ()
+checkResults (Result{..}:rs) kTreePrev hdl = do
+  kTree <- liftIO $ kTreeIO hdl
+  case invariantCompare vTree kTree of
+    Left invs -> liftIO $
+      printTrees input vTree kTree kTreePrev invs
+    Right _ -> do
+      v <- asks verbose
+      when v $ liftIO $ printTrees input vTree kTree kTreePrev []
+      checkResults rs kTree hdl
+
+
+{- HLINT ignore options "Monoid law, left identity" -}
+options :: ParserInfo Options
+options = info (opts <**> helper) desc where
+  desc = fullDesc <> header "Testing harness for comparing the \
+    \Linux Red-Black trees against a verified oracle. The harness immediately stops\
+    \ when a kernel RBT violates an RBT invariant and prints an error message."
+  opts = Options
+    <$> switch (short 'v' <> help "Print all executed operations and the resulting trees.")
+    <*> strategies
+
+  randomDesc = progDesc "Randomly call insert and delete operations \
+    \on the kernel and oracle without resetting their trees. Will lead to \
+    \large trees."
+
+  exhaustiveDesc = progDesc "Try (almost) all combinations up to a limit."
+
+  strategies :: Parser Strategy
+  strategies = hsubparser $ mempty
+    <> command "random" (info randomOpts randomDesc)
+    <> command "exhaustive" (info exhaustiveOpts exhaustiveDesc)
+
+  naturalParser :: (Integral i, Read i) => ReadM i
+  naturalParser = eitherReader $ \s ->
+    if 0 <= read s
+    then Right $ read s
+    else Left "Not a positive value"
+
+  numberParser :: (Integral i, Read i) => Parser i
+  numberParser = option naturalParser (short 'n')
+
+  randomOpts :: Parser Strategy
+  randomOpts = fmap Random $ RandomOptions
+    <$> numberParser
+    <*> option auto (mempty
+          <> short 's'
+          <> metavar "<seed>"
+          <> showDefault
+          <> value 42
+          <> help "Seed for the pseudo-random-number generator" )
+
+  exhaustiveOpts :: Parser Strategy
+  exhaustiveOpts = Exhaustive <$> ExhaustiveOptions <$> numberParser
diff --git a/tools/testing/rbtree_oracle/RBT/Kernel.hs b/tools/testing/rbtree_oracle/RBT/Kernel.hs
new file mode 100644
index 000000000000..d1dae30502fc
--- /dev/null
+++ b/tools/testing/rbtree_oracle/RBT/Kernel.hs
@@ -0,0 +1,64 @@
+{- SPDX-License-Identifier: GPL-2.0-or-later -}
+{- Copyright (C) 2021 Mete Polat -}
+
+module RBT.Kernel(Cmd(..), IRBT, RBT.Kernel.Handle, RBT.Kernel.init, cleanup, reset, insert, delete) where
+
+import Control.Exception
+import Control.Monad.Extra
+import Data.Word
+import GHC.IO.Handle
+import RBT.Verified (Tree, Color)
+import System.IO
+import qualified RBT.Verified as RBT
+
+type IRBT = Tree (Word64, Color)
+
+keyFile = "/sys/kernel/debug/rbt_if/key"
+cmdFile = "/sys/kernel/debug/rbt_if/cmd"
+
+data Cmd = Reset | Insert | Delete deriving (Enum, Bounded)
+
+printCmd hdl = hPrint hdl . fromEnum
+
+instance Show Cmd where
+  show Reset = "resetting"
+  show Insert = "inserting"
+  show Delete = "deleting"
+
+data Handle = Handle {
+  keyHdl :: GHC.IO.Handle.Handle,
+  cmdHdl :: GHC.IO.Handle.Handle }
+
+init :: IO RBT.Kernel.Handle
+init = do
+  keyHdl <- openFile keyFile WriteMode
+  cmdHdl <- openFile cmdFile ReadWriteMode
+  let hdl = Handle{..}
+  hSetBuffering keyHdl LineBuffering
+  hSetBuffering cmdHdl LineBuffering
+  reset hdl
+  return hdl
+
+cleanup :: RBT.Kernel.Handle -> IO ()
+cleanup hdl = do
+  reset hdl
+  hClose $ keyHdl hdl
+  hClose $ cmdHdl hdl
+
+exec :: Cmd -> Maybe Word64 -> RBT.Kernel.Handle -> IO IRBT
+exec cmd x Handle{..} = do
+  whenJust x $ hPrint keyHdl
+  printCmd cmdHdl cmd
+  hSeek cmdHdl AbsoluteSeek 0
+  read <$> hGetLine cmdHdl
+
+reset :: RBT.Kernel.Handle -> IO IRBT
+reset hdl = do
+  tree <- exec Reset Nothing hdl
+  assert (RBT.equal_tree RBT.empty tree) $ return tree
+
+insert :: RBT.Kernel.Handle -> Word64 -> IO IRBT
+insert hdl x = exec Insert (Just x) hdl
+
+delete :: RBT.Kernel.Handle -> Word64 -> IO IRBT
+delete hdl x = exec Delete (Just x) hdl
diff --git a/tools/testing/rbtree_oracle/RBT/Verified.hs b/tools/testing/rbtree_oracle/RBT/Verified.hs
new file mode 100644
index 000000000000..74be4722cab6
--- /dev/null
+++ b/tools/testing/rbtree_oracle/RBT/Verified.hs
@@ -0,0 +1,253 @@
+{- SPDX-License-Identifier: BSD-3-Clause -}
+{- Copyright (c) 1986-2021,
+   University of Cambridge,
+   Technische Universitaet Muenchen,
+   and contributors.
+
+   All rights reserved.
+-}
+
+{-# LANGUAGE EmptyDataDecls, RankNTypes, ScopedTypeVariables #-}
+
+module
+  RBT.Verified(Color, Nat, Tree, equal_tree, invc, invh, empty, inorder, delete,
+                insert, rootBlack, rbt)
+  where {
+
+import Prelude ((==), (/=), (<), (<=), (>=), (>), (+), (-), (*), (/), (**),
+  (>>=), (>>), (=<<), (&&), (||), (^), (^^), (.), ($), ($!), (++), (!!), Eq,
+  error, id, return, not, fst, snd, map, filter, concat, concatMap, reverse,
+  zip, null, takeWhile, dropWhile, all, any, Integer, negate, abs, divMod,
+  String, Bool(True, False), Maybe(Nothing, Just));
+import qualified Prelude;
+
+data Color = Red | Black deriving (Prelude.Read, Prelude.Show);
+
+equal_color :: Color -> Color -> Bool;
+equal_color Red Black = False;
+equal_color Black Red = False;
+equal_color Black Black = True;
+equal_color Red Red = True;
+
+instance Eq Color where {
+  a == b = equal_color a b;
+};
+
+newtype Nat = Nat Integer deriving (Prelude.Read, Prelude.Show);
+
+data Num = One | Bit0 Num | Bit1 Num deriving (Prelude.Read, Prelude.Show);
+
+data Tree a = Leaf | Node (Tree a) a (Tree a)
+  deriving (Prelude.Read, Prelude.Show);
+
+data Cmp_val = LT | EQ | GT deriving (Prelude.Read, Prelude.Show);
+
+cmp :: forall a. (Eq a, Prelude.Ord a) => a -> a -> Cmp_val;
+cmp x y = (if x < y then LT else (if x == y then EQ else GT));
+
+paint :: forall a. Color -> Tree (a, Color) -> Tree (a, Color);
+paint c Leaf = Leaf;
+paint c (Node l (a, uu) r) = Node l (a, c) r;
+
+baliR :: forall a. Tree (a, Color) -> a -> Tree (a, Color) -> Tree (a, Color);
+baliR t1 a (Node t2 (b, Red) (Node t3 (c, Red) t4)) =
+  Node (Node t1 (a, Black) t2) (b, Red) (Node t3 (c, Black) t4);
+baliR t1 a (Node (Node t2 (b, Red) t3) (c, Red) Leaf) =
+  Node (Node t1 (a, Black) t2) (b, Red) (Node t3 (c, Black) Leaf);
+baliR t1 a (Node (Node t2 (b, Red) t3) (c, Red) (Node v (vc, Black) vb)) =
+  Node (Node t1 (a, Black) t2) (b, Red)
+    (Node t3 (c, Black) (Node v (vc, Black) vb));
+baliR t1 a Leaf = Node t1 (a, Black) Leaf;
+baliR t1 a (Node v (vc, Black) vb) = Node t1 (a, Black) (Node v (vc, Black) vb);
+baliR t1 a (Node Leaf va Leaf) = Node t1 (a, Black) (Node Leaf va Leaf);
+baliR t1 a (Node (Node vb (ve, Black) vd) va Leaf) =
+  Node t1 (a, Black) (Node (Node vb (ve, Black) vd) va Leaf);
+baliR t1 a (Node Leaf va (Node vc (vf, Black) ve)) =
+  Node t1 (a, Black) (Node Leaf va (Node vc (vf, Black) ve));
+baliR t1 a (Node (Node vb (vh, Black) vg) va (Node vc (vf, Black) ve)) =
+  Node t1 (a, Black)
+    (Node (Node vb (vh, Black) vg) va (Node vc (vf, Black) ve));
+
+baldL :: forall a. Tree (a, Color) -> a -> Tree (a, Color) -> Tree (a, Color);
+baldL (Node t1 (a, Red) t2) b t3 = Node (Node t1 (a, Black) t2) (b, Red) t3;
+baldL Leaf a (Node t2 (b, Black) t3) = baliR Leaf a (Node t2 (b, Red) t3);
+baldL (Node v (vc, Black) vb) a (Node t2 (b, Black) t3) =
+  baliR (Node v (vc, Black) vb) a (Node t2 (b, Red) t3);
+baldL Leaf a (Node (Node t2 (b, Black) t3) (c, Red) t4) =
+  Node (Node Leaf (a, Black) t2) (b, Red) (baliR t3 c (paint Red t4));
+baldL (Node v (vc, Black) vb) a (Node (Node t2 (b, Black) t3) (c, Red) t4) =
+  Node (Node (Node v (vc, Black) vb) (a, Black) t2) (b, Red)
+    (baliR t3 c (paint Red t4));
+baldL Leaf a Leaf = Node Leaf (a, Red) Leaf;
+baldL Leaf a (Node Leaf (vc, Red) vb) =
+  Node Leaf (a, Red) (Node Leaf (vc, Red) vb);
+baldL Leaf a (Node (Node va (vf, Red) ve) (vc, Red) vb) =
+  Node Leaf (a, Red) (Node (Node va (vf, Red) ve) (vc, Red) vb);
+baldL (Node v (vc, Black) vb) a Leaf =
+  Node (Node v (vc, Black) vb) (a, Red) Leaf;
+baldL (Node v (vc, Black) vb) a (Node Leaf (vf, Red) ve) =
+  Node (Node v (vc, Black) vb) (a, Red) (Node Leaf (vf, Red) ve);
+baldL (Node v (vc, Black) vb) a (Node (Node vd (vi, Red) vh) (vf, Red) ve) =
+  Node (Node v (vc, Black) vb) (a, Red)
+    (Node (Node vd (vi, Red) vh) (vf, Red) ve);
+
+join :: forall a. Tree (a, Color) -> Tree (a, Color) -> Tree (a, Color);
+join Leaf t = t;
+join (Node v va vb) Leaf = Node v va vb;
+join (Node t1 (a, Red) t2) (Node t3 (c, Red) t4) =
+  (case join t2 t3 of {
+    Leaf -> Node t1 (a, Red) (Node Leaf (c, Red) t4);
+    Node u2 (b, Red) u3 ->
+      Node (Node t1 (a, Red) u2) (b, Red) (Node u3 (c, Red) t4);
+    Node u2 (b, Black) u3 ->
+      Node t1 (a, Red) (Node (Node u2 (b, Black) u3) (c, Red) t4);
+  });
+join (Node t1 (a, Black) t2) (Node t3 (c, Black) t4) =
+  (case join t2 t3 of {
+    Leaf -> baldL t1 a (Node Leaf (c, Black) t4);
+    Node u2 (b, Red) u3 ->
+      Node (Node t1 (a, Black) u2) (b, Red) (Node u3 (c, Black) t4);
+    Node u2 (b, Black) u3 ->
+      baldL t1 a (Node (Node u2 (b, Black) u3) (c, Black) t4);
+  });
+join (Node v (vc, Black) vb) (Node t2 (a, Red) t3) =
+  Node (join (Node v (vc, Black) vb) t2) (a, Red) t3;
+join (Node t1 (a, Red) t2) (Node v (vc, Black) vb) =
+  Node t1 (a, Red) (join t2 (Node v (vc, Black) vb));
+
+baliL :: forall a. Tree (a, Color) -> a -> Tree (a, Color) -> Tree (a, Color);
+baliL (Node (Node t1 (a, Red) t2) (b, Red) t3) c t4 =
+  Node (Node t1 (a, Black) t2) (b, Red) (Node t3 (c, Black) t4);
+baliL (Node Leaf (a, Red) (Node t2 (b, Red) t3)) c t4 =
+  Node (Node Leaf (a, Black) t2) (b, Red) (Node t3 (c, Black) t4);
+baliL (Node (Node v (vc, Black) vb) (a, Red) (Node t2 (b, Red) t3)) c t4 =
+  Node (Node (Node v (vc, Black) vb) (a, Black) t2) (b, Red)
+    (Node t3 (c, Black) t4);
+baliL Leaf a t2 = Node Leaf (a, Black) t2;
+baliL (Node Leaf (v, Black) vb) a t2 =
+  Node (Node Leaf (v, Black) vb) (a, Black) t2;
+baliL (Node Leaf va Leaf) a t2 = Node (Node Leaf va Leaf) (a, Black) t2;
+baliL (Node Leaf va (Node v (ve, Black) vd)) a t2 =
+  Node (Node Leaf va (Node v (ve, Black) vd)) (a, Black) t2;
+baliL (Node (Node vc (vf, Black) ve) (v, Black) vb) a t2 =
+  Node (Node (Node vc (vf, Black) ve) (v, Black) vb) (a, Black) t2;
+baliL (Node (Node vc (vf, Black) ve) va Leaf) a t2 =
+  Node (Node (Node vc (vf, Black) ve) va Leaf) (a, Black) t2;
+baliL (Node (Node vc (vf, Black) ve) va (Node v (vh, Black) vg)) a t2 =
+  Node (Node (Node vc (vf, Black) ve) va (Node v (vh, Black) vg)) (a, Black) t2;
+baliL (Node v (vc, Black) vb) a t2 = Node (Node v (vc, Black) vb) (a, Black) t2;
+
+baldR :: forall a. Tree (a, Color) -> a -> Tree (a, Color) -> Tree (a, Color);
+baldR t1 a (Node t2 (b, Red) t3) = Node t1 (a, Red) (Node t2 (b, Black) t3);
+baldR (Node t1 (a, Black) t2) b Leaf = baliL (Node t1 (a, Red) t2) b Leaf;
+baldR (Node t1 (a, Black) t2) b (Node v (vc, Black) vb) =
+  baliL (Node t1 (a, Red) t2) b (Node v (vc, Black) vb);
+baldR (Node t1 (a, Red) (Node t2 (b, Black) t3)) c Leaf =
+  Node (baliL (paint Red t1) a t2) (b, Red) (Node t3 (c, Black) Leaf);
+baldR (Node t1 (a, Red) (Node t2 (b, Black) t3)) c (Node v (vc, Black) vb) =
+  Node (baliL (paint Red t1) a t2) (b, Red)
+    (Node t3 (c, Black) (Node v (vc, Black) vb));
+baldR Leaf a Leaf = Node Leaf (a, Red) Leaf;
+baldR (Node v (vc, Red) Leaf) a Leaf =
+  Node (Node v (vc, Red) Leaf) (a, Red) Leaf;
+baldR (Node v (vc, Red) (Node va (vf, Red) ve)) a Leaf =
+  Node (Node v (vc, Red) (Node va (vf, Red) ve)) (a, Red) Leaf;
+baldR Leaf a (Node v (vc, Black) vb) =
+  Node Leaf (a, Red) (Node v (vc, Black) vb);
+baldR (Node va (vf, Red) Leaf) a (Node v (vc, Black) vb) =
+  Node (Node va (vf, Red) Leaf) (a, Red) (Node v (vc, Black) vb);
+baldR (Node va (vf, Red) (Node vd (vi, Red) vh)) a (Node v (vc, Black) vb) =
+  Node (Node va (vf, Red) (Node vd (vi, Red) vh)) (a, Red)
+    (Node v (vc, Black) vb);
+
+equal_tree :: forall a. (Eq a) => Tree a -> Tree a -> Bool;
+equal_tree Leaf (Node x21 x22 x23) = False;
+equal_tree (Node x21 x22 x23) Leaf = False;
+equal_tree (Node x21 x22 x23) (Node y21 y22 y23) =
+  equal_tree x21 y21 && x22 == y22 && equal_tree x23 y23;
+equal_tree Leaf Leaf = True;
+
+color :: forall a. Tree (a, Color) -> Color;
+color Leaf = Black;
+color (Node uu (uv, c) uw) = c;
+
+del ::
+  forall a. (Eq a, Prelude.Ord a) => a -> Tree (a, Color) -> Tree (a, Color);
+del x Leaf = Leaf;
+del x (Node l (a, uu) r) =
+  (case cmp x a of {
+    LT -> (if not (equal_tree l Leaf) && equal_color (color l) Black
+            then baldL (del x l) a r else Node (del x l) (a, Red) r);
+    EQ -> join l r;
+    GT -> (if not (equal_tree r Leaf) && equal_color (color r) Black
+            then baldR l a (del x r) else Node l (a, Red) (del x r));
+  });
+
+ins ::
+  forall a. (Eq a, Prelude.Ord a) => a -> Tree (a, Color) -> Tree (a, Color);
+ins x Leaf = Node Leaf (x, Red) Leaf;
+ins x (Node l (a, Black) r) = (case cmp x a of {
+                                LT -> baliL (ins x l) a r;
+                                EQ -> Node l (a, Black) r;
+                                GT -> baliR l a (ins x r);
+                              });
+ins x (Node l (a, Red) r) = (case cmp x a of {
+                              LT -> Node (ins x l) (a, Red) r;
+                              EQ -> Node l (a, Red) r;
+                              GT -> Node l (a, Red) (ins x r);
+                            });
+
+invc :: forall a. Tree (a, Color) -> Bool;
+invc Leaf = True;
+invc (Node l (a, c) r) =
+  (if equal_color c Red
+    then equal_color (color l) Black && equal_color (color r) Black
+    else True) &&
+    invc l && invc r;
+
+integer_of_nat :: Nat -> Integer;
+integer_of_nat (Nat x) = x;
+
+equal_nat :: Nat -> Nat -> Bool;
+equal_nat m n = integer_of_nat m == integer_of_nat n;
+
+zero_nat :: Nat;
+zero_nat = Nat (0 :: Integer);
+
+plus_nat :: Nat -> Nat -> Nat;
+plus_nat m n = Nat (integer_of_nat m + integer_of_nat n);
+
+one_nat :: Nat;
+one_nat = Nat (1 :: Integer);
+
+bheight :: forall a. Tree (a, Color) -> Nat;
+bheight Leaf = zero_nat;
+bheight (Node l (x, c) r) =
+  (if equal_color c Black then plus_nat (bheight l) one_nat else bheight l);
+
+invh :: forall a. Tree (a, Color) -> Bool;
+invh Leaf = True;
+invh (Node l (x, c) r) = equal_nat (bheight l) (bheight r) && invh l && invh r;
+
+empty :: forall a. Tree (a, Color);
+empty = Leaf;
+
+inorder :: forall a b. Tree (a, b) -> [a];
+inorder Leaf = [];
+inorder (Node l (a, uu) r) = inorder l ++ a : inorder r;
+
+delete ::
+  forall a. (Eq a, Prelude.Ord a) => a -> Tree (a, Color) -> Tree (a, Color);
+delete x t = paint Black (del x t);
+
+insert ::
+  forall a. (Eq a, Prelude.Ord a) => a -> Tree (a, Color) -> Tree (a, Color);
+insert x t = paint Black (ins x t);
+
+rootBlack :: forall a. Tree (a, Color) -> Bool;
+rootBlack t = equal_color (color t) Black;
+
+rbt :: forall a. Tree (a, Color) -> Bool;
+rbt t = invc t && invh t && rootBlack t;
+
+}
diff --git a/tools/testing/rbtree_oracle/RBT_export.thy b/tools/testing/rbtree_oracle/RBT_export.thy
new file mode 100644
index 000000000000..4d4f916ce0e3
--- /dev/null
+++ b/tools/testing/rbtree_oracle/RBT_export.thy
@@ -0,0 +1,41 @@
+(* SPDX-License-Identifier: GPL-2.0-or-later *)
+(* Copyright (C) 2021 Mete Polat *)
+
+theory RBT_export
+imports
+  "HOL-Data_Structures.RBT_Set"
+  "HOL-Data_Structures.Tree2"
+  "HOL-Library.Code_Target_Numeral"
+begin
+
+(*
+Map all the different orderings to Haskell's linorder class.
+This is fine because the RBT interface only uses linorder.
+*)
+
+code_printing
+  type_class ord \<rightharpoonup> (Haskell) "Prelude.Ord"
+| constant Orderings.less \<rightharpoonup> (Haskell) infixl 4 "<"
+| constant Orderings.less_eq \<rightharpoonup> (Haskell) infixl 4 "<="
+| type_class order \<rightharpoonup> (Haskell) "Prelude.Ord"
+| type_class preorder \<rightharpoonup> (Haskell) "Prelude.Ord"
+| type_class linorder \<rightharpoonup> (Haskell) "Prelude.Ord"
+
+definition rootBlack :: "'a rbt \<Rightarrow> bool" where
+"rootBlack t \<equiv> color t = Black"
+
+definition rbt :: "'a rbt \<Rightarrow> bool" where
+"rbt t \<equiv> invc t \<and> invh t \<and> rootBlack t"
+
+lemma "RBT_Set.rbt t \<equiv> rbt t"
+  by (simp add: RBT_Set.rbt_def rbt_def rootBlack_def)
+
+export_code
+  rootBlack rbt
+  RBT_Set.invc RBT_Set.invh
+  RBT_Set.empty RBT_Set.insert RBT_Set.delete
+  Tree2.inorder
+  equal_tree_inst.equal_tree
+in Haskell module_name RBT.Verified (string_classes)
+
+end
diff --git a/tools/testing/rbtree_oracle/Setup.hs b/tools/testing/rbtree_oracle/Setup.hs
new file mode 100644
index 000000000000..9a994af677b0
--- /dev/null
+++ b/tools/testing/rbtree_oracle/Setup.hs
@@ -0,0 +1,2 @@
+import Distribution.Simple
+main = defaultMain
diff --git a/tools/testing/rbtree_oracle/Strategy.hs b/tools/testing/rbtree_oracle/Strategy.hs
new file mode 100644
index 000000000000..e929ef8e4172
--- /dev/null
+++ b/tools/testing/rbtree_oracle/Strategy.hs
@@ -0,0 +1,72 @@
+{- SPDX-License-Identifier: GPL-2.0-or-later -}
+{- Copyright (C) 2021 Mete Polat -}
+
+module Strategy (Result(..), Input, TestCase, random, exhaustive) where
+
+
+import Control.Applicative
+import Control.Monad
+import Data.Bifunctor
+import Data.List
+import Data.Word
+import RBT.Kernel (IRBT, Cmd(..))
+import RBT.Verified (Tree, Color)
+import System.Random (uniform, mkStdGen)
+import System.Random.Stateful (Uniform, uniformM, uniformRM)
+import qualified RBT.Kernel as Kernel
+import qualified RBT.Verified as RBT (empty)
+import qualified RBT.Verified as Verified (insert, delete)
+
+type Input = (Cmd,Word64)
+type TestCase a = [a]
+
+data Result = Result {
+  input :: Input,
+  vTree :: IRBT,
+  kTreeIO :: Kernel.Handle -> IO IRBT }
+
+instance Uniform Cmd where
+  uniformM g = toEnum <$> uniformRM (succ minCmd, maxCmd) g
+    where
+      minCmd = fromEnum (minBound :: Cmd)
+      maxCmd = fromEnum (maxBound :: Cmd)
+
+cmdMap :: Cmd -> (Word64 -> IRBT -> IRBT, Kernel.Handle -> Word64 -> IO IRBT)
+cmdMap Insert = (Verified.insert, Kernel.insert)
+cmdMap Delete = (Verified.delete, Kernel.delete)
+cmdMap Reset = undefined
+
+vCmd :: IRBT -> Input -> IRBT
+vCmd t (c,x) = (fst $ cmdMap c) x t
+
+kCmd :: Input -> Kernel.Handle -> IO IRBT
+kCmd (c,x) hdl = (snd $ cmdMap c) hdl x
+
+buildInput :: [Word64] -> [Word64] -> [Cmd] -> TestCase Input
+buildInput _ _ [] = []
+buildInput (i:is) ds (Insert : cs) = (Insert, i) : buildInput is ds cs
+buildInput is (d:ds) (Delete : cs) = (Delete, d) : buildInput is ds cs
+buildInput _ _ _ = undefined
+
+buildResults :: [TestCase Input] -> [TestCase Result]
+buildResults testCases = do
+  inputs <- testCases
+  let vTrees = tail $ scanl vCmd RBT.empty inputs
+  let kTrees = map kCmd inputs
+  return $ zipWith3 Result inputs vTrees kTrees
+
+random :: Word64 -> Int -> [TestCase Result]
+random runs seed = do
+  let rndCmds = randoms seed
+  let rndXs = randoms seed
+  let inputs = genericTake runs (buildInput rndXs rndXs rndCmds)
+  buildResults [inputs]
+  where
+    randoms :: Uniform a => Int -> [a]
+    randoms = unfoldr (Just . uniform) . mkStdGen
+
+exhaustive :: Word64 -> [TestCase Result]
+exhaustive n = do
+  let distributions = [genericReplicate i Insert ++ genericReplicate (n-i) Delete | i <- [n,n-1..]]
+  let inputRuns = concatMap (permutations . buildInput [1..n] [1..n]) distributions
+  buildResults inputRuns
diff --git a/tools/testing/rbtree_oracle/rbtTestHarness.cabal b/tools/testing/rbtree_oracle/rbtTestHarness.cabal
new file mode 100644
index 000000000000..f2e403d1dd8f
--- /dev/null
+++ b/tools/testing/rbtree_oracle/rbtTestHarness.cabal
@@ -0,0 +1,15 @@
+cabal-version:       2.4
+name:                rbtTestHarness
+version:             1.0.0.0
+
+executable rbtTestHarness
+  main-is:             Main.hs
+  other-modules:       Strategy RBT.Kernel RBT.Verified
+  build-depends:       base ^>=4.15,
+                       random,
+                       optparse-applicative,
+                       extra,
+                       mtl
+  default-language:    Haskell2010
+  default-extensions:  RecordWildCards, DuplicateRecordFields
+  license:             GPL-2.0
-- 
2.33.1

