Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D4640D327
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhIPGY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234539AbhIPGYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:24:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CF8760E76;
        Thu, 16 Sep 2021 06:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631773411;
        bh=HDO3TKu02v6+e848DWht3XEAfdCaWsoKu5YHLC4JMMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYocb8eZ7/3/FZNxFtfy4rmfts/5jPeYqyzVudGgOhlnWeo6URPWpIH3jWe52h5RX
         umQmP3i1EXTTYgHvUaL9k017EwR/ZfRY+XVrkZjs2A2K9wvrTQ82e6tt3R8MKirRh0
         VJq9joDDkXgjpSz91ti03fq2lxmNdoi79vrlsBhZYHryLqKdDog1c2PMnevdET7go6
         aC1673yP/ACsgylD1rXW0dNbCpjgyqGBX4/c1g8lW0T+75YMN0K8mcQxYeRhOpr4R6
         gdV2GL1pARj4BYvFZEIkuB86pPUsttzpJUWx6SAdVLK+y9I5z5+A5OSu+fKW7zrnXE
         PheReHNkSBAkA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 3/4] bootconfig: Add xbc_get_info() for the node information
Date:   Thu, 16 Sep 2021 15:23:29 +0900
Message-Id: <163177340877.682366.4360676589783197627.stgit@devnote2>
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

Add xbc_get_info() API which allows user to get the
number of used xbc_nodes and the size of bootconfig
data. This is also useful for checking the bootconfig
is initialized or not.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/bootconfig.h |    2 ++
 init/main.c                |    1 +
 lib/bootconfig.c           |   21 +++++++++++++++++++++
 tools/bootconfig/main.c    |    1 +
 4 files changed, 25 insertions(+)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 62e09b788172..f955bb7eabbb 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -273,6 +273,8 @@ static inline int __init xbc_node_compose_key(struct xbc_node *node,
 /* XBC node initializer */
 int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
 
+/* XBC node and size information */
+int __init xbc_get_info(int *node_size, size_t *data_size);
 
 /* XBC cleanup data structures */
 void __init xbc_destroy_all(void);
diff --git a/init/main.c b/init/main.c
index 77c309ed9f17..747b4fd38a1a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -451,6 +451,7 @@ static void __init setup_boot_config(void)
 			pr_err("Failed to parse bootconfig: %s at %d.\n",
 				msg, pos);
 	} else {
+		xbc_get_info(&ret, NULL);
 		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 66b02fddfea8..b088fe5c0001 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -34,6 +34,27 @@ static int xbc_err_pos __initdata;
 static int open_brace[XBC_DEPTH_MAX] __initdata;
 static int brace_index __initdata;
 
+/**
+ * xbc_get_info() - Get the information of loaded boot config
+ * node_size: A pointer to store the number of nodes.
+ * data_size: A pointer to store the size of bootconfig data.
+ *
+ * Get the number of used nodes in @node_size if it is not NULL,
+ * and the size of bootconfig data in @data_size if it is not NULL.
+ * Return 0 if the boot config is initialized, or return -ENODEV.
+ */
+int __init xbc_get_info(int *node_size, size_t *data_size)
+{
+	if (!xbc_data)
+		return -ENODEV;
+
+	if (node_size)
+		*node_size = xbc_node_num;
+	if (data_size)
+		*data_size = xbc_data_size;
+	return 0;
+}
+
 static int __init xbc_parse_error(const char *msg, const char *p)
 {
 	xbc_err_msg = msg;
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 7269c9e35335..4f2a8d884745 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -391,6 +391,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 		return ret;
 	}
 	printf("Apply %s to %s\n", xbc_path, path);
+	xbc_get_info(&ret, NULL);
 	printf("\tNumber of nodes: %d\n", ret);
 	printf("\tSize: %u bytes\n", (unsigned int)size);
 	printf("\tChecksum: %d\n", (unsigned int)csum);

