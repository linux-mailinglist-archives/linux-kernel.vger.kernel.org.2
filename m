Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B4A437F80
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhJVUvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234360AbhJVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9248161362;
        Fri, 22 Oct 2021 20:48:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sx-000QFw-LT;
        Fri, 22 Oct 2021 16:48:39 -0400
Message-ID: <20211022204839.501300512@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 08/40] bootconfig: Rename xbc_destroy_all() to xbc_exit()
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Avoid using this noisy name and use more calm one.
This is just a name change. No functional change.

Link: https://lkml.kernel.org/r/163187295918.2366983.5231840238429996027.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/bootconfig.h | 2 +-
 init/main.c                | 2 +-
 lib/bootconfig.c           | 8 ++++----
 tools/bootconfig/main.c    | 2 +-
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
index afaed805de19..f1428234e1e4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -462,7 +462,7 @@ static void __init setup_boot_config(void)
 
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
-- 
2.33.0
