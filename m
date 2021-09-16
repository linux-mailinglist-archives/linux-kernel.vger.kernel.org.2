Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD5440D326
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhIPGYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 02:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234569AbhIPGYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 02:24:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7DAF611CE;
        Thu, 16 Sep 2021 06:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631773403;
        bh=/mzaUD2d9akaAwvFkDgrigFT4t5fTa72cmL+q0QWvg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0GeuSsr4FJMqu42IPgaGS3jhH7OPsG31ZG22HnqFbdajQUxCg5NeXKmyI43dHRIP
         ykj2clvM6YASAHW8E/TGm9qetM9Z1BC7xiea9FgZFkVs0H/LzNfEjh4tuco7vyVuKY
         64KIyQausHc3LNcbPy0hnVNOz+R1kiZylAmnlYR71M/cCR0bGmiu3mEpF4bip7S+GF
         lBvPOaY/pbMekfYANVjN+aj94SoV4M6a0hSkU7XgF0pXPldbwCRbxDdGs1VcHtiBxz
         kLdUWvWsbBYt/2BD08X8JEHl5sDBaXDHyLtcEyLnuIKiUNHRntNeNUSEQXrDHc9pK5
         NcXAlO+ISny8A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 2/4] bootconfig: Allocate xbc_data inside xbc_init()
Date:   Thu, 16 Sep 2021 15:23:20 +0900
Message-Id: <163177339986.682366.898762699429769117.stgit@devnote2>
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

Allocate 'xbc_data' in the xbc_init() so that it does
not need to care about the ownership of the copied
data.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/bootconfig.h |    2 +-
 init/main.c                |   13 ++-----------
 lib/bootconfig.c           |   33 +++++++++++++++++++++------------
 tools/bootconfig/main.c    |    6 +++---
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
index 0b054fff8e92..77c309ed9f17 100644
--- a/init/main.c
+++ b/init/main.c
@@ -410,7 +410,7 @@ static void __init setup_boot_config(void)
 	const char *msg;
 	int pos;
 	u32 size, csum;
-	char *data, *copy, *err;
+	char *data, *err;
 	int ret;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
@@ -443,16 +443,7 @@ static void __init setup_boot_config(void)
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

