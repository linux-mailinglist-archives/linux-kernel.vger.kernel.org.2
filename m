Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C533B4EA6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 15:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFZNIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 09:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhFZNH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 09:07:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F9E61C36;
        Sat, 26 Jun 2021 13:05:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lx807-000EfP-6Q; Sat, 26 Jun 2021 09:05:35 -0400
Message-ID: <20210626130535.039561132@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 26 Jun 2021 09:04:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 03/24] tools/bootconfig: Support mixed value and subkey test cases
References: <20210626130404.033700863@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Update test case to support mixed value and subkey on a key.

Link: https://lkml.kernel.org/r/162262195568.264090.12431204030021242896.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/samples/bad-override.bconf                 | 3 ---
 tools/bootconfig/samples/bad-override2.bconf                | 3 ---
 tools/bootconfig/samples/good-mixed-append.bconf            | 4 ++++
 .../samples/{bad-mixed-kv1.bconf => good-mixed-kv1.bconf}   | 0
 .../samples/{bad-mixed-kv2.bconf => good-mixed-kv2.bconf}   | 0
 tools/bootconfig/samples/good-mixed-kv3.bconf               | 6 ++++++
 tools/bootconfig/samples/good-mixed-override.bconf          | 4 ++++
 7 files changed, 14 insertions(+), 6 deletions(-)
 delete mode 100644 tools/bootconfig/samples/bad-override.bconf
 delete mode 100644 tools/bootconfig/samples/bad-override2.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-append.bconf
 rename tools/bootconfig/samples/{bad-mixed-kv1.bconf => good-mixed-kv1.bconf} (100%)
 rename tools/bootconfig/samples/{bad-mixed-kv2.bconf => good-mixed-kv2.bconf} (100%)
 create mode 100644 tools/bootconfig/samples/good-mixed-kv3.bconf
 create mode 100644 tools/bootconfig/samples/good-mixed-override.bconf

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
diff --git a/tools/bootconfig/samples/bad-mixed-kv1.bconf b/tools/bootconfig/samples/good-mixed-kv1.bconf
similarity index 100%
rename from tools/bootconfig/samples/bad-mixed-kv1.bconf
rename to tools/bootconfig/samples/good-mixed-kv1.bconf
diff --git a/tools/bootconfig/samples/bad-mixed-kv2.bconf b/tools/bootconfig/samples/good-mixed-kv2.bconf
similarity index 100%
rename from tools/bootconfig/samples/bad-mixed-kv2.bconf
rename to tools/bootconfig/samples/good-mixed-kv2.bconf
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
-- 
2.30.2
