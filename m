Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E79040F58C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343992AbhIQKEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343934AbhIQKEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:04:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C68161250;
        Fri, 17 Sep 2021 10:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631872997;
        bh=BCesXfSMK9Sbw5EvEpjmYq2nF85T5FeRkpkC3PAoIf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJS7/OkrP1DYWoU7ajuUPMXCOegni85Ep/yTw1H2XzePnd+6K71aHpAyDXArI6SwJ
         GfG0mkUiPpLI+mp0AOC/J3LNHiOMVWG87OKJTT76+i1kQ7T76XRVBhALseKkQiOqf2
         OX4gZMqBQzI88+PadX9wZo0v9tx/xbdq5Y9X4Wu7pOPZU/L3cV8LQiP40pFp23riv4
         lUbHzmMU9Fk2+LBZM9LsiyyEOsuQBeGVyRV2ShCl12uitl9LjX5sLWTQ6+nq5497XY
         0sIFQiz6UsXPZ+u1cImFwq3+D1lygPepegbEsZxrgPIu0hLAbZwdG0R/ONNX5s3KsG
         xDHeRFrmAgLxw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 7/7] bootconfig: Cleanup dummy headers in tools/bootconfig
Date:   Fri, 17 Sep 2021 19:03:16 +0900
Message-Id: <163187299574.2366983.18371329724128746091.stgit@devnote2>
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

Cleanup dummy headers in tools/bootconfig/include except
for tools/bootconfig/include/linux/bootconfig.h.
For this change, I uses __KERNEL__ macro to split kernel
header #include and introduce xbc_alloc_mem() and
xbc_free_mem().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/bootconfig.h                  |   10 ++++++
 lib/bootconfig.c                            |   43 +++++++++++++++++++++++---
 tools/bootconfig/Makefile                   |    2 +
 tools/bootconfig/include/linux/bootconfig.h |   45 ++++++++++++++++++++++++++-
 tools/bootconfig/include/linux/bug.h        |   12 -------
 tools/bootconfig/include/linux/ctype.h      |    7 ----
 tools/bootconfig/include/linux/errno.h      |    7 ----
 tools/bootconfig/include/linux/kernel.h     |   14 --------
 tools/bootconfig/include/linux/memblock.h   |   11 -------
 tools/bootconfig/include/linux/string.h     |   32 -------------------
 tools/bootconfig/main.c                     |    1 -
 11 files changed, 93 insertions(+), 91 deletions(-)
 delete mode 100644 tools/bootconfig/include/linux/bug.h
 delete mode 100644 tools/bootconfig/include/linux/ctype.h
 delete mode 100644 tools/bootconfig/include/linux/errno.h
 delete mode 100644 tools/bootconfig/include/linux/kernel.h
 delete mode 100644 tools/bootconfig/include/linux/memblock.h
 delete mode 100644 tools/bootconfig/include/linux/string.h

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index a6f8dc51f168..a4665c7ab07c 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -7,8 +7,18 @@
  * Author: Masami Hiramatsu <mhiramat@kernel.org>
  */
 
+#ifdef __KERNEL__
 #include <linux/kernel.h>
 #include <linux/types.h>
+#else /* !__KERNEL__ */
+/*
+ * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
+ * run the parser sanity test.
+ * This does NOT mean linux/bootconfig.h is available in the user space.
+ * However, if you change this file, please make sure the tools/bootconfig
+ * has no issue on building and running.
+ */
+#endif
 
 #define BOOTCONFIG_MAGIC	"#BOOTCONFIG\n"
 #define BOOTCONFIG_MAGIC_LEN	12
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index a2f5f582181d..a056ae137750 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -4,6 +4,7 @@
  * Masami Hiramatsu <mhiramat@kernel.org>
  */
 
+#ifdef __KERNEL__
 #include <linux/bootconfig.h>
 #include <linux/bug.h>
 #include <linux/ctype.h>
@@ -11,6 +12,16 @@
 #include <linux/kernel.h>
 #include <linux/memblock.h>
 #include <linux/string.h>
+#else /* !__KERNEL__ */
+/*
+ * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
+ * run the parser sanity test.
+ * This does NOT mean lib/bootconfig.c is available in the user space.
+ * However, if you change this file, please make sure the tools/bootconfig
+ * has no issue on building and running.
+ */
+#include <linux/bootconfig.h>
+#endif
 
 /*
  * Extra Boot Config (XBC) is given as tree-structured ascii text of
@@ -31,6 +42,29 @@ static int xbc_err_pos __initdata;
 static int open_brace[XBC_DEPTH_MAX] __initdata;
 static int brace_index __initdata;
 
+#ifdef __KERNEL__
+static inline void *xbc_alloc_mem(size_t size)
+{
+	return memblock_alloc(size, SMP_CACHE_BYTES);
+}
+
+static inline void xbc_free_mem(void *addr, size_t size)
+{
+	memblock_free_ptr(addr, size);
+}
+
+#else /* !__KERNEL__ */
+
+static inline void *xbc_alloc_mem(size_t size)
+{
+	return malloc(size);
+}
+
+static inline void xbc_free_mem(void *addr, size_t size)
+{
+	free(addr);
+}
+#endif
 /**
  * xbc_get_info() - Get the information of loaded boot config
  * node_size: A pointer to store the number of nodes.
@@ -859,11 +893,11 @@ static int __init xbc_parse_tree(void)
  */
 void __init xbc_exit(void)
 {
-	memblock_free_ptr(xbc_data, xbc_data_size);
+	xbc_free_mem(xbc_data, xbc_data_size);
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	memblock_free_ptr(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
+	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
 	xbc_nodes = NULL;
 	brace_index = 0;
 }
@@ -902,7 +936,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 		return -ERANGE;
 	}
 
-	xbc_data = memblock_alloc(size + 1, SMP_CACHE_BYTES);
+	xbc_data = xbc_alloc_mem(size + 1);
 	if (!xbc_data) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig data";
@@ -912,8 +946,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 	xbc_data[size] = '\0';
 	xbc_data_size = size + 1;
 
-	xbc_nodes = memblock_alloc(sizeof(struct xbc_node) * XBC_NODE_MAX,
-				   SMP_CACHE_BYTES);
+	xbc_nodes = xbc_alloc_mem(sizeof(struct xbc_node) * XBC_NODE_MAX);
 	if (!xbc_nodes) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig nodes";
diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
index f1eec3ccbe18..566c3e0ee561 100644
--- a/tools/bootconfig/Makefile
+++ b/tools/bootconfig/Makefile
@@ -17,7 +17,7 @@ ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 all: $(ALL_PROGRAMS) test
 
-$(OUTPUT)bootconfig: main.c $(LIBSRC)
+$(OUTPUT)bootconfig: main.c include/linux/bootconfig.h $(LIBSRC)
 	$(CC) $(filter %.c,$^) $(CFLAGS) -o $@
 
 test: $(ALL_PROGRAMS) test-bootconfig.sh
diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
index de7f30f99af3..6784296a0692 100644
--- a/tools/bootconfig/include/linux/bootconfig.h
+++ b/tools/bootconfig/include/linux/bootconfig.h
@@ -2,10 +2,53 @@
 #ifndef _BOOTCONFIG_LINUX_BOOTCONFIG_H
 #define _BOOTCONFIG_LINUX_BOOTCONFIG_H
 
-#include "../../../../include/linux/bootconfig.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <ctype.h>
+#include <errno.h>
+#include <string.h>
+
 
 #ifndef fallthrough
 # define fallthrough
 #endif
 
+#define WARN_ON(cond)	\
+	((cond) ? printf("Internal warning(%s:%d, %s): %s\n",	\
+			__FILE__, __LINE__, __func__, #cond) : 0)
+
+#define unlikely(cond)	(cond)
+
+/* Copied from lib/string.c */
+static inline char *skip_spaces(const char *str)
+{
+	while (isspace(*str))
+		++str;
+	return (char *)str;
+}
+
+static inline char *strim(char *s)
+{
+	size_t size;
+	char *end;
+
+	size = strlen(s);
+	if (!size)
+		return s;
+
+	end = s + size - 1;
+	while (end >= s && isspace(*end))
+		end--;
+	*(end + 1) = '\0';
+
+	return skip_spaces(s);
+}
+
+#define __init
+#define __initdata
+
+#include "../../../../include/linux/bootconfig.h"
+
 #endif
diff --git a/tools/bootconfig/include/linux/bug.h b/tools/bootconfig/include/linux/bug.h
deleted file mode 100644
index 7b65a389c0dd..000000000000
--- a/tools/bootconfig/include/linux/bug.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _SKC_LINUX_BUG_H
-#define _SKC_LINUX_BUG_H
-
-#include <stdio.h>
-#include <stdlib.h>
-
-#define WARN_ON(cond)	\
-	((cond) ? printf("Internal warning(%s:%d, %s): %s\n",	\
-			__FILE__, __LINE__, __func__, #cond) : 0)
-
-#endif
diff --git a/tools/bootconfig/include/linux/ctype.h b/tools/bootconfig/include/linux/ctype.h
deleted file mode 100644
index c56ecc136448..000000000000
--- a/tools/bootconfig/include/linux/ctype.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _SKC_LINUX_CTYPE_H
-#define _SKC_LINUX_CTYPE_H
-
-#include <ctype.h>
-
-#endif
diff --git a/tools/bootconfig/include/linux/errno.h b/tools/bootconfig/include/linux/errno.h
deleted file mode 100644
index 5d9f91ec2fda..000000000000
--- a/tools/bootconfig/include/linux/errno.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _SKC_LINUX_ERRNO_H
-#define _SKC_LINUX_ERRNO_H
-
-#include <asm/errno.h>
-
-#endif
diff --git a/tools/bootconfig/include/linux/kernel.h b/tools/bootconfig/include/linux/kernel.h
deleted file mode 100644
index 39f306c18dd0..000000000000
--- a/tools/bootconfig/include/linux/kernel.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _SKC_LINUX_KERNEL_H
-#define _SKC_LINUX_KERNEL_H
-
-#include <stdlib.h>
-#include <stdint.h>
-#include <stdbool.h>
-
-#define unlikely(cond)	(cond)
-
-#define __init
-#define __initdata
-
-#endif
diff --git a/tools/bootconfig/include/linux/memblock.h b/tools/bootconfig/include/linux/memblock.h
deleted file mode 100644
index f2e506f7d57f..000000000000
--- a/tools/bootconfig/include/linux/memblock.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _XBC_LINUX_MEMBLOCK_H
-#define _XBC_LINUX_MEMBLOCK_H
-
-#include <stdlib.h>
-
-#define SMP_CACHE_BYTES	0
-#define memblock_alloc(size, align)	malloc(size)
-#define memblock_free_ptr(paddr, size)	free(paddr)
-
-#endif
diff --git a/tools/bootconfig/include/linux/string.h b/tools/bootconfig/include/linux/string.h
deleted file mode 100644
index 8267af75153a..000000000000
--- a/tools/bootconfig/include/linux/string.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _SKC_LINUX_STRING_H
-#define _SKC_LINUX_STRING_H
-
-#include <string.h>
-
-/* Copied from lib/string.c */
-static inline char *skip_spaces(const char *str)
-{
-	while (isspace(*str))
-		++str;
-	return (char *)str;
-}
-
-static inline char *strim(char *s)
-{
-	size_t size;
-	char *end;
-
-	size = strlen(s);
-	if (!size)
-		return s;
-
-	end = s + size - 1;
-	while (end >= s && isspace(*end))
-		end--;
-	*(end + 1) = '\0';
-
-	return skip_spaces(s);
-}
-
-#endif
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index fb7c9fb953d7..156b62a163c5 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -12,7 +12,6 @@
 #include <errno.h>
 #include <endian.h>
 
-#include <linux/kernel.h>
 #include <linux/bootconfig.h>
 
 #define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)

