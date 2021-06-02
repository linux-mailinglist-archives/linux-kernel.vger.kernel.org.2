Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D73D3983F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhFBIVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232487AbhFBIVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:21:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7812D6100A;
        Wed,  2 Jun 2021 08:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622621959;
        bh=/AkyYMBWlTA6G5Cm36+jQhlcRYLFU3nwA5Jw1zR2vbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gn24w2rs9iJks1JoqmmFeTu/kShR7ta1UUbPY1uCPBdo0GK2CN7cguK3CLlk0PLLI
         SxMYojBAlCNygtNKucSp4BQTMh57eW/xKxOQcM+XTY6oY7ZdBW5umkqT/NIZ1+hNYL
         bJlA4b/7MnNz8GFfXyue6KVEC3YxQWZKxBMPQkIdFrtltVzTGr3oq3Sma0AbfT4Syy
         rxw65vm37gJNV5Nr1s/ePLT3jeFXmPeCnF0wjZRf463smLpVmJ+267ILGtGq5UB2jF
         8kq4VG+09CEH+1BzFDtmtjf3H4nTgjcdvDYsyi1fm4UWlv+hymk0mZIxBUNfaNgEgZ
         7oY9GlbmQ8zug==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v4 4/6] tools/bootconfig: Support mixed value and subkey test cases
Date:   Wed,  2 Jun 2021 17:19:15 +0900
Message-Id: <162262195568.264090.12431204030021242896.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162262192121.264090.6540508908529705156.stgit@devnote2>
References: <162262192121.264090.6540508908529705156.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update test case to support mixed value and subkey on a key.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/samples/bad-mixed-kv1.bconf       |    3 ---
 tools/bootconfig/samples/bad-mixed-kv2.bconf       |    3 ---
 tools/bootconfig/samples/bad-override.bconf        |    3 ---
 tools/bootconfig/samples/bad-override2.bconf       |    3 ---
 tools/bootconfig/samples/good-mixed-append.bconf   |    4 ++++
 tools/bootconfig/samples/good-mixed-kv1.bconf      |    3 +++
 tools/bootconfig/samples/good-mixed-kv2.bconf      |    3 +++
 tools/bootconfig/samples/good-mixed-kv3.bconf      |    6 ++++++
 tools/bootconfig/samples/good-mixed-override.bconf |    4 ++++
 9 files changed, 20 insertions(+), 12 deletions(-)
 delete mode 100644 tools/bootconfig/samples/bad-mixed-kv1.bconf
 delete mode 100644 tools/bootconfig/samples/bad-mixed-kv2.bconf
 delete mode 100644 tools/bootconfig/samples/bad-override.bconf
 delete mode 100644 tools/bootconfig/samples/bad-override2.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-append.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-kv1.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-kv2.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-kv3.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-override.bconf

diff --git a/tools/bootconfig/samples/bad-mixed-kv1.bconf b/tools/bootconfig/samples/bad-mixed-kv1.bconf
deleted file mode 100644
index 1761547dd05c..000000000000
--- a/tools/bootconfig/samples/bad-mixed-kv1.bconf
+++ /dev/null
@@ -1,3 +0,0 @@
-# value -> subkey pattern
-key = value
-key.subkey = another-value
diff --git a/tools/bootconfig/samples/bad-mixed-kv2.bconf b/tools/bootconfig/samples/bad-mixed-kv2.bconf
deleted file mode 100644
index 6b32e0c3878c..000000000000
--- a/tools/bootconfig/samples/bad-mixed-kv2.bconf
+++ /dev/null
@@ -1,3 +0,0 @@
-# subkey -> value pattern
-key.subkey = value
-key = another-value
diff --git a/tools/bootconfig/samples/bad-override.bconf b/tools/bootconfig/samples/bad-override.bconf
deleted file mode 100644
index fde6c561512e..000000000000
--- a/tools/bootconfig/samples/bad-override.bconf
+++ /dev/null
@@ -1,3 +0,0 @@
-key.subkey = value
-# We can not override pre-defined subkeys with value
-key := value
diff --git a/tools/bootconfig/samples/bad-override2.bconf b/tools/bootconfig/samples/bad-override2.bconf
deleted file mode 100644
index 688587cb023c..000000000000
--- a/tools/bootconfig/samples/bad-override2.bconf
+++ /dev/null
@@ -1,3 +0,0 @@
-key = value
-# We can not override pre-defined value with subkey
-key.subkey := value
diff --git a/tools/bootconfig/samples/good-mixed-append.bconf b/tools/bootconfig/samples/good-mixed-append.bconf
new file mode 100644
index 000000000000..b99a089a05f5
--- /dev/null
+++ b/tools/bootconfig/samples/good-mixed-append.bconf
@@ -0,0 +1,4 @@
+key = foo
+keyx.subkey = value
+key += bar
+
diff --git a/tools/bootconfig/samples/good-mixed-kv1.bconf b/tools/bootconfig/samples/good-mixed-kv1.bconf
new file mode 100644
index 000000000000..1761547dd05c
--- /dev/null
+++ b/tools/bootconfig/samples/good-mixed-kv1.bconf
@@ -0,0 +1,3 @@
+# value -> subkey pattern
+key = value
+key.subkey = another-value
diff --git a/tools/bootconfig/samples/good-mixed-kv2.bconf b/tools/bootconfig/samples/good-mixed-kv2.bconf
new file mode 100644
index 000000000000..6b32e0c3878c
--- /dev/null
+++ b/tools/bootconfig/samples/good-mixed-kv2.bconf
@@ -0,0 +1,3 @@
+# subkey -> value pattern
+key.subkey = value
+key = another-value
diff --git a/tools/bootconfig/samples/good-mixed-kv3.bconf b/tools/bootconfig/samples/good-mixed-kv3.bconf
new file mode 100644
index 000000000000..2ce2b02224b8
--- /dev/null
+++ b/tools/bootconfig/samples/good-mixed-kv3.bconf
@@ -0,0 +1,6 @@
+# mixed key and subkeys with braces
+key = value
+key {
+	subkey1
+	subkey2 = foo
+}
diff --git a/tools/bootconfig/samples/good-mixed-override.bconf b/tools/bootconfig/samples/good-mixed-override.bconf
new file mode 100644
index 000000000000..18195b2873b6
--- /dev/null
+++ b/tools/bootconfig/samples/good-mixed-override.bconf
@@ -0,0 +1,4 @@
+key.foo = bar
+key = value
+# mixed key value can be overridden
+key := value2

