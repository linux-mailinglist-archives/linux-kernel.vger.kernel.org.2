Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B4A437F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhJVUvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234215AbhJVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 502FD610D0;
        Fri, 22 Oct 2021 20:48:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sx-000QED-3V;
        Fri, 22 Oct 2021 16:48:39 -0400
Message-ID: <20211022204838.945182353@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 05/40] bootconfig: Allocate xbc_data inside xbc_init()
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Allocate 'xbc_data' in the xbc_init() so that it does
not need to care about the ownership of the copied
data.

Link: https://lkml.kernel.org/r/163177339986.682366.898762699429769117.stgit@devnote2

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/bootconfig.h |  2 +-
 init/main.c                | 13 ++-----------
 lib/bootconfig.c           | 33 +++++++++++++++++++++------------
 tools/bootconfig/main.c    |  6 +++---
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 537e1b991f11..62e09b788172 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -271,7 +271,7 @@ static inline int __init xbc_node_compose_key(struct xbc_node *node,
 }
 
 /* XBC node initializer */
-int __init xbc_init(char *buf, const char **emsg, int *epos);
+int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
 
 
 /* XBC cleanup data structures */
diff --git a/init/main.c b/init/main.c
index 81a79a77db46..d894989d86bc 100644
--- a/init/main.c
+++ b/init/main.c
@@ -409,7 +409,7 @@ static void __init setup_boot_config(void)
 	const char *msg;
 	int pos;
 	u32 size, csum;
-	char *data, *copy, *err;
+	char *data, *err;
 	int ret;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
@@ -442,16 +442,7 @@ static void __init setup_boot_config(void)
 		return;
 	}
 
-	copy = memblock_alloc(size + 1, SMP_CACHE_BYTES);
-	if (!copy) {
-		pr_err("Failed to allocate memory for bootconfig\n");
-		return;
-	}
-
-	memcpy(copy, data, size);
-	copy[size] = '\0';
-
-	ret = xbc_init(copy, &msg, &pos);
+	ret = xbc_init(data, size, &msg, &pos);
 	if (ret < 0) {
 		if (pos < 0)
 			pr_err("Failed to init bootconfig: %s.\n", msg);
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 5ae248b29373..66b02fddfea8 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -789,6 +789,7 @@ static int __init xbc_verify_tree(void)
  */
 void __init xbc_destroy_all(void)
 {
+	memblock_free_ptr(xbc_data, xbc_data_size);
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
@@ -799,19 +800,20 @@ void __init xbc_destroy_all(void)
 
 /**
  * xbc_init() - Parse given XBC file and build XBC internal tree
- * @buf: boot config text
+ * @data: The boot config text original data
+ * @size: The size of @data
  * @emsg: A pointer of const char * to store the error message
  * @epos: A pointer of int to store the error position
  *
- * This parses the boot config text in @buf. @buf must be a
- * null terminated string and smaller than XBC_DATA_MAX.
+ * This parses the boot config text in @data. @size must be smaller
+ * than XBC_DATA_MAX.
  * Return the number of stored nodes (>0) if succeeded, or -errno
  * if there is any error.
  * In error cases, @emsg will be updated with an error message and
  * @epos will be updated with the error position which is the byte offset
  * of @buf. If the error is not a parser error, @epos will be -1.
  */
-int __init xbc_init(char *buf, const char **emsg, int *epos)
+int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 {
 	char *p, *q;
 	int ret, c;
@@ -824,28 +826,35 @@ int __init xbc_init(char *buf, const char **emsg, int *epos)
 			*emsg = "Bootconfig is already initialized";
 		return -EBUSY;
 	}
-
-	ret = strlen(buf);
-	if (ret > XBC_DATA_MAX - 1 || ret == 0) {
+	if (size > XBC_DATA_MAX || size == 0) {
 		if (emsg)
-			*emsg = ret ? "Config data is too big" :
+			*emsg = size ? "Config data is too big" :
 				"Config data is empty";
 		return -ERANGE;
 	}
 
+	xbc_data = memblock_alloc(size + 1, SMP_CACHE_BYTES);
+	if (!xbc_data) {
+		if (emsg)
+			*emsg = "Failed to allocate bootconfig data";
+		return -ENOMEM;
+	}
+	memcpy(xbc_data, data, size);
+	xbc_data[size] = '\0';
+	xbc_data_size = size + 1;
+
 	xbc_nodes = memblock_alloc(sizeof(struct xbc_node) * XBC_NODE_MAX,
 				   SMP_CACHE_BYTES);
 	if (!xbc_nodes) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig nodes";
+		xbc_destroy_all();
 		return -ENOMEM;
 	}
 	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
-	xbc_data = buf;
-	xbc_data_size = ret + 1;
-	last_parent = NULL;
 
-	p = buf;
+	last_parent = NULL;
+	p = xbc_data;
 	do {
 		q = strpbrk(p, "{}=+;:\n#");
 		if (!q) {
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index fd67496a947f..7269c9e35335 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -229,7 +229,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 		return -EINVAL;
 	}
 
-	ret = xbc_init(*buf, &msg, NULL);
+	ret = xbc_init(*buf, size, &msg, NULL);
 	/* Wrong data */
 	if (ret < 0) {
 		pr_err("parse error: %s.\n", msg);
@@ -269,7 +269,7 @@ static int init_xbc_with_error(char *buf, int len)
 	if (!copy)
 		return -ENOMEM;
 
-	ret = xbc_init(buf, &msg, &pos);
+	ret = xbc_init(buf, len, &msg, &pos);
 	if (ret < 0)
 		show_xbc_error(copy, msg, pos);
 	free(copy);
@@ -382,7 +382,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	memcpy(data, buf, size);
 
 	/* Check the data format */
-	ret = xbc_init(buf, &msg, &pos);
+	ret = xbc_init(buf, size, &msg, &pos);
 	if (ret < 0) {
 		show_xbc_error(data, msg, pos);
 		free(data);
-- 
2.33.0
