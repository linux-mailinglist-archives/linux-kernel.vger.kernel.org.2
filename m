Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13727437F85
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 22:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbhJVUvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 16:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234372AbhJVUu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:50:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 466596124D;
        Fri, 22 Oct 2021 20:48:41 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1me1Sy-000QI8-E5;
        Fri, 22 Oct 2021 16:48:40 -0400
Message-ID: <20211022204840.257309807@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 16:48:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 12/40] bootconfig: Replace u16 and u32 with uint16_t and uint32_t
References: <20211022204756.099054287@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Replace u16 and u32 with uint16_t and uint32_t so
that the tools/bootconfig only needs <stdint.h>.

Link: https://lkml.kernel.org/r/163187298835.2366983.9838262576854319669.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/bootconfig.h              | 12 ++++++------
 lib/bootconfig.c                        | 16 ++++++++--------
 tools/bootconfig/include/linux/kernel.h |  4 +---
 tools/bootconfig/main.c                 | 20 ++++++++++----------
 4 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 85cdfd381877..a6f8dc51f168 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -25,10 +25,10 @@
  * The checksum will be used with the BOOTCONFIG_MAGIC and the size for
  * embedding the bootconfig in the initrd image.
  */
-static inline __init u32 xbc_calc_checksum(void *data, u32 size)
+static inline __init uint32_t xbc_calc_checksum(void *data, uint32_t size)
 {
 	unsigned char *p = data;
-	u32 ret = 0;
+	uint32_t ret = 0;
 
 	while (size--)
 		ret += *p++;
@@ -38,10 +38,10 @@ static inline __init u32 xbc_calc_checksum(void *data, u32 size)
 
 /* XBC tree node */
 struct xbc_node {
-	u16 next;
-	u16 child;
-	u16 parent;
-	u16 data;
+	uint16_t next;
+	uint16_t child;
+	uint16_t parent;
+	uint16_t data;
 } __attribute__ ((__packed__));
 
 #define XBC_KEY		0
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 953789171858..a2f5f582181d 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -244,7 +244,7 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 				      struct xbc_node *node,
 				      char *buf, size_t size)
 {
-	u16 keys[XBC_DEPTH_MAX];
+	uint16_t keys[XBC_DEPTH_MAX];
 	int depth = 0, ret = 0, total = 0;
 
 	if (!node || node == root)
@@ -359,21 +359,21 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 
 /* XBC parse and tree build */
 
-static int __init xbc_init_node(struct xbc_node *node, char *data, u32 flag)
+static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag)
 {
 	unsigned long offset = data - xbc_data;
 
 	if (WARN_ON(offset >= XBC_DATA_MAX))
 		return -EINVAL;
 
-	node->data = (u16)offset | flag;
+	node->data = (uint16_t)offset | flag;
 	node->child = 0;
 	node->next = 0;
 
 	return 0;
 }
 
-static struct xbc_node * __init xbc_add_node(char *data, u32 flag)
+static struct xbc_node * __init xbc_add_node(char *data, uint32_t flag)
 {
 	struct xbc_node *node;
 
@@ -403,7 +403,7 @@ static inline __init struct xbc_node *xbc_last_child(struct xbc_node *node)
 	return node;
 }
 
-static struct xbc_node * __init __xbc_add_sibling(char *data, u32 flag, bool head)
+static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, bool head)
 {
 	struct xbc_node *sib, *node = xbc_add_node(data, flag);
 
@@ -430,17 +430,17 @@ static struct xbc_node * __init __xbc_add_sibling(char *data, u32 flag, bool hea
 	return node;
 }
 
-static inline struct xbc_node * __init xbc_add_sibling(char *data, u32 flag)
+static inline struct xbc_node * __init xbc_add_sibling(char *data, uint32_t flag)
 {
 	return __xbc_add_sibling(data, flag, false);
 }
 
-static inline struct xbc_node * __init xbc_add_head_sibling(char *data, u32 flag)
+static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint32_t flag)
 {
 	return __xbc_add_sibling(data, flag, true);
 }
 
-static inline __init struct xbc_node *xbc_add_child(char *data, u32 flag)
+static inline __init struct xbc_node *xbc_add_child(char *data, uint32_t flag)
 {
 	struct xbc_node *node = xbc_add_sibling(data, flag);
 
diff --git a/tools/bootconfig/include/linux/kernel.h b/tools/bootconfig/include/linux/kernel.h
index c4854b8e7023..39f306c18dd0 100644
--- a/tools/bootconfig/include/linux/kernel.h
+++ b/tools/bootconfig/include/linux/kernel.h
@@ -3,11 +3,9 @@
 #define _SKC_LINUX_KERNEL_H
 
 #include <stdlib.h>
+#include <stdint.h>
 #include <stdbool.h>
 
-typedef unsigned short u16;
-typedef unsigned int   u32;
-
 #define unlikely(cond)	(cond)
 
 #define __init
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index adc6c6e73fa9..fb7c9fb953d7 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -178,7 +178,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
 {
 	struct stat stat;
 	int ret;
-	u32 size = 0, csum = 0, rcsum;
+	uint32_t size = 0, csum = 0, rcsum;
 	char magic[BOOTCONFIG_MAGIC_LEN];
 	const char *msg;
 
@@ -202,11 +202,11 @@ static int load_xbc_from_initrd(int fd, char **buf)
 	if (lseek(fd, -(8 + BOOTCONFIG_MAGIC_LEN), SEEK_END) < 0)
 		return pr_errno("Failed to lseek for size", -errno);
 
-	if (read(fd, &size, sizeof(u32)) < 0)
+	if (read(fd, &size, sizeof(uint32_t)) < 0)
 		return pr_errno("Failed to read size", -errno);
 	size = le32toh(size);
 
-	if (read(fd, &csum, sizeof(u32)) < 0)
+	if (read(fd, &csum, sizeof(uint32_t)) < 0)
 		return pr_errno("Failed to read checksum", -errno);
 	csum = le32toh(csum);
 
@@ -364,7 +364,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	size_t total_size;
 	struct stat stat;
 	const char *msg;
-	u32 size, csum;
+	uint32_t size, csum;
 	int pos, pad;
 	int ret, fd;
 
@@ -378,7 +378,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
 
 	/* Backup the bootconfig data */
 	data = calloc(size + BOOTCONFIG_ALIGN +
-		      sizeof(u32) + sizeof(u32) + BOOTCONFIG_MAGIC_LEN, 1);
+		      sizeof(uint32_t) + sizeof(uint32_t) + BOOTCONFIG_MAGIC_LEN, 1);
 	if (!data)
 		return -ENOMEM;
 	memcpy(data, buf, size);
@@ -426,17 +426,17 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	}
 
 	/* To align up the total size to BOOTCONFIG_ALIGN, get padding size */
-	total_size = stat.st_size + size + sizeof(u32) * 2 + BOOTCONFIG_MAGIC_LEN;
+	total_size = stat.st_size + size + sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN;
 	pad = ((total_size + BOOTCONFIG_ALIGN - 1) & (~BOOTCONFIG_ALIGN_MASK)) - total_size;
 	size += pad;
 
 	/* Add a footer */
 	p = data + size;
-	*(u32 *)p = htole32(size);
-	p += sizeof(u32);
+	*(uint32_t *)p = htole32(size);
+	p += sizeof(uint32_t);
 
-	*(u32 *)p = htole32(csum);
-	p += sizeof(u32);
+	*(uint32_t *)p = htole32(csum);
+	p += sizeof(uint32_t);
 
 	memcpy(p, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
 	p += BOOTCONFIG_MAGIC_LEN;
-- 
2.33.0
