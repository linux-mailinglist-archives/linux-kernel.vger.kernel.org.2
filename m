Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB98C437F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhJVUv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234354AbhJVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA17611F2;
        Fri, 22 Oct 2021 20:48:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sx-000QEk-9W;
        Fri, 22 Oct 2021 16:48:39 -0400
Message-ID: <20211022204839.127821897@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 06/40] bootconfig: Add xbc_get_info() for the node information
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add xbc_get_info() API which allows user to get the
number of used xbc_nodes and the size of bootconfig
data. This is also useful for checking the bootconfig
is initialized or not.

Link: https://lkml.kernel.org/r/163177340877.682366.4360676589783197627.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/bootconfig.h |  2 ++
 init/main.c                |  1 +
 lib/bootconfig.c           | 21 +++++++++++++++++++++
 tools/bootconfig/main.c    |  1 +
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
index d894989d86bc..afaed805de19 100644
--- a/init/main.c
+++ b/init/main.c
@@ -450,6 +450,7 @@ static void __init setup_boot_config(void)
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
-- 
2.33.0
