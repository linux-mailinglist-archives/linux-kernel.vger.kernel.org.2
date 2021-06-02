Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CA9398116
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 08:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhFBG0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 02:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231239AbhFBG0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 02:26:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4107460234;
        Wed,  2 Jun 2021 06:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622615102;
        bh=vBS98iwYpvDZIn3Opzo/os6+tYp62KqlsLH1DmA4hpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9nbMybWz0C8nEetyPXFvNAX9hDnwzQqO9jOciT14RWBohuupNriQPD1qjAPmsNks
         oxI1lrCZaPsuA3imB5YJsaFeO5yJabn3FwLDgWVNgLB2x0x0vNEGVLlkiT4FZFqgLV
         xERsJoYQdfhj044u0wCH+MCFALqdD4y4eDuBF2LsHAXcNpNEhSd+w4/65qMVWb/wOW
         6joQRNbe3mHsrw1xT+Qhv9LDiDNIzwE9f84jKYvyZwZToANFSn1TgXmz0tFmHMfDdd
         a4Aefsjvii+ifsDu5U3uJMbAoyuT14OhU8qbJtHde5xUWSpNqV1HE2PvK51y8pNGfO
         0OXoIMPz3H4UQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Devin Moore <devinmoore@google.com>
Subject: [PATCH v3 4/6] tools/bootconfig: Support mixed value and subkey test cases
Date:   Wed,  2 Jun 2021 15:24:58 +0900
Message-Id: <162261509855.255316.9188322424474893934.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <162261506232.255316.12147562546699211199.stgit@devnote2>
References: <162261506232.255316.12147562546699211199.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

