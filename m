Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D48040D328
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhIPGZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234648AbhIPGY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:24:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30F68611CE;
        Thu, 16 Sep 2021 06:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631773419;
        bh=jUOjgA/pqgEKUiSJMHB1W97cBrtZ/aj/ifdF80aUG88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=des2/O1EBnaGhU1MX6s/eikyoHDaUEeMGiBmkJGhQHSmMwuvKGqEibLwdm7HTKoBY
         m4ZMS/gZfVVaTptewRGoawoyxgKj71OPGGSJBNP4YKxSJMUSe0nHGVYv38TdlFGtfA
         2a93FKqD1dBrgIlGg7u4dx4VDunp+t6BsFpI7B4BqH3+6pWmgUt8/bhPfIxv/QDAWf
         STm/Z0twzrwuHtLveM982iNt6yCEPzEwCr6A0K+sl6FQKNE4FfPJgiOYibv/Q4QI8y
         sQQmK1l/qSrVbHVanWqRjaVPG0y6nkmG8qxY/iTFJLVlJFkbOEPq652oKuESXH9lRC
         geqCXkcZnfomw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 4/4] bootconfig: Rename xbc_destroy_all() to xbc_fini()
Date:   Thu, 16 Sep 2021 15:23:36 +0900
Message-Id: <163177341667.682366.1520674275752512771.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <163177338366.682366.5998343833719057348.stgit@devnote2>
References: <163177338366.682366.5998343833719057348.stgit@devnote2>
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
 include/linux/bootconfig.h |    2 +-
 init/main.c                |    2 +-
 lib/bootconfig.c           |    8 ++++----
 tools/bootconfig/main.c    |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index f955bb7eabbb..ba40194a339c 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -277,7 +277,7 @@ int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
 int __init xbc_get_info(int *node_size, size_t *data_size);
 
 /* XBC cleanup data structures */
-void __init xbc_destroy_all(void);
+void __init xbc_fini(void);
 
 /* Debug dump functions */
 void __init xbc_debug_dump(void);
diff --git a/init/main.c b/init/main.c
index 747b4fd38a1a..99a23324d4a1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -463,7 +463,7 @@ static void __init setup_boot_config(void)
 
 static void __init exit_boot_config(void)
 {
-	xbc_destroy_all();
+	xbc_fini();
 }
 
 #else	/* !CONFIG_BOOT_CONFIG */
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index b088fe5c0001..43a402b02748 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -802,13 +802,13 @@ static int __init xbc_verify_tree(void)
 }
 
 /**
- * xbc_destroy_all() - Clean up all parsed bootconfig
+ * xbc_fini() - Clean up all parsed bootconfig
  *
  * This clears all data structures of parsed bootconfig on memory.
  * If you need to reuse xbc_init() with new boot config, you can
  * use this.
  */
-void __init xbc_destroy_all(void)
+void __init xbc_fini(void)
 {
 	memblock_free_ptr(xbc_data, xbc_data_size);
 	xbc_data = NULL;
@@ -869,7 +869,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 	if (!xbc_nodes) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig nodes";
-		xbc_destroy_all();
+		xbc_fini();
 		return -ENOMEM;
 	}
 	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
@@ -925,7 +925,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 			*epos = xbc_err_pos;
 		if (emsg)
 			*emsg = xbc_err_msg;
-		xbc_destroy_all();
+		xbc_fini();
 	} else
 		ret = xbc_node_num;
 
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 4f2a8d884745..84808a1871f0 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -397,7 +397,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	printf("\tChecksum: %d\n", (unsigned int)csum);
 
 	/* TODO: Check the options by schema */
-	xbc_destroy_all();
+	xbc_fini();
 	free(buf);
 
 	/* Remove old boot config if exists */

