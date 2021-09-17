Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CD40F581
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343709AbhIQKEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343671AbhIQKED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:04:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DCEA60FA0;
        Fri, 17 Sep 2021 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631872961;
        bh=96563LYZdN3pniAAZz5umNJfrud+6MaxbK8JxucxLpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbkDlbKNPDxqTH7gWmsKJ3bXPYfZ1ZpMv8t24dxfDYiP892ywHNVrMX60fxR6CaA0
         788UUPPNcxm3DG6d5TjpdbTbBlx/S5O0C1GdNEWjk6L/X/5BjLITW4mTj1qsdsI9rT
         UZnP7klhf/w7+SD9NQaFdBpJD8e7MMQ+RIDcbcgeY3V/Ng4Isi0R8KjmvRDa8uZMVl
         hZJbVxEjerYJ53hoIxkuRrT4MeoFKT4YotdTV3fbtDuC0wrRtPUsJ2cQVDaxxJGZ3/
         vcr0PHJtZt2pKwteTEp7lq7vm0pInD2ciAVwrgTivWcusmZbGW0pkZes8dhxyiH06w
         C+U1s2F9VNirA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/7] bootconfig: Rename xbc_destroy_all() to xbc_exit()
Date:   Fri, 17 Sep 2021 19:02:39 +0900
Message-Id: <163187295918.2366983.5231840238429996027.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163187294400.2366983.7393164788107844569.stgit@devnote2>
References: <163187294400.2366983.7393164788107844569.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid using this noisy name and use more calm one.
This is just a name change. No functional change.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v5:
   - Use _exit suffix instead of _fini.
---
 include/linux/bootconfig.h |    2 +-
 init/main.c                |    2 +-
 lib/bootconfig.c           |    8 ++++----
 tools/bootconfig/main.c    |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index f955bb7eabbb..7eb7a7f8ade7 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -277,7 +277,7 @@ int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
 int __init xbc_get_info(int *node_size, size_t *data_size);
 
 /* XBC cleanup data structures */
-void __init xbc_destroy_all(void);
+void __init xbc_exit(void);
 
 /* Debug dump functions */
 void __init xbc_debug_dump(void);
diff --git a/init/main.c b/init/main.c
index 747b4fd38a1a..e5464067ca7a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -463,7 +463,7 @@ static void __init setup_boot_config(void)
 
 static void __init exit_boot_config(void)
 {
-	xbc_destroy_all();
+	xbc_exit();
 }
 
 #else	/* !CONFIG_BOOT_CONFIG */
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index b088fe5c0001..a3ce5a0c3ca4 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -802,13 +802,13 @@ static int __init xbc_verify_tree(void)
 }
 
 /**
- * xbc_destroy_all() - Clean up all parsed bootconfig
+ * xbc_exit() - Clean up all parsed bootconfig
  *
  * This clears all data structures of parsed bootconfig on memory.
  * If you need to reuse xbc_init() with new boot config, you can
  * use this.
  */
-void __init xbc_destroy_all(void)
+void __init xbc_exit(void)
 {
 	memblock_free_ptr(xbc_data, xbc_data_size);
 	xbc_data = NULL;
@@ -869,7 +869,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 	if (!xbc_nodes) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig nodes";
-		xbc_destroy_all();
+		xbc_exit();
 		return -ENOMEM;
 	}
 	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
@@ -925,7 +925,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 			*epos = xbc_err_pos;
 		if (emsg)
 			*emsg = xbc_err_msg;
-		xbc_destroy_all();
+		xbc_exit();
 	} else
 		ret = xbc_node_num;
 
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 4f2a8d884745..4252c23bd35d 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -397,7 +397,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	printf("\tChecksum: %d\n", (unsigned int)csum);
 
 	/* TODO: Check the options by schema */
-	xbc_destroy_all();
+	xbc_exit();
 	free(buf);
 
 	/* Remove old boot config if exists */

