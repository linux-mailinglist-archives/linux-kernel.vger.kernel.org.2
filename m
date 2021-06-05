Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3759839C6B0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 09:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFEHyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 03:54:21 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4364 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFEHyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 03:54:19 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FxsFj3lLVz5sk7;
        Sat,  5 Jun 2021 15:48:41 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 5 Jun
 2021 15:52:28 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <sjenning@redhat.com>,
        <ddstreet@ieee.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/2] mm/zbud: don't export any zbud API
Date:   Sat, 5 Jun 2021 15:51:41 +0800
Message-ID: <20210605075141.1359969-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210605075141.1359969-1-linmiaohe@huawei.com>
References: <20210605075141.1359969-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zbud doesn't need to export any API and it is meant to be used via
zpool API since the commit 12d79d64bfd3 ("mm/zpool: update zswap to use
zpool"). So we can remove the unneeded zbud.h and move down zpool API
to avoid any forward declaration.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 MAINTAINERS          |   1 -
 include/linux/zbud.h |  23 -----
 mm/zbud.c            | 219 ++++++++++++++++++++++---------------------
 3 files changed, 112 insertions(+), 131 deletions(-)
 delete mode 100644 include/linux/zbud.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d8648ee43199..625d66d7aacc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20264,7 +20264,6 @@ M:	Seth Jennings <sjenning@redhat.com>
 M:	Dan Streetman <ddstreet@ieee.org>
 L:	linux-mm@kvack.org
 S:	Maintained
-F:	include/linux/zbud.h
 F:	mm/zbud.c
 
 ZD1211RW WIRELESS DRIVER
diff --git a/include/linux/zbud.h b/include/linux/zbud.h
deleted file mode 100644
index b1eaf6e31735..000000000000
--- a/include/linux/zbud.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ZBUD_H_
-#define _ZBUD_H_
-
-#include <linux/types.h>
-
-struct zbud_pool;
-
-struct zbud_ops {
-	int (*evict)(struct zbud_pool *pool, unsigned long handle);
-};
-
-struct zbud_pool *zbud_create_pool(gfp_t gfp, const struct zbud_ops *ops);
-void zbud_destroy_pool(struct zbud_pool *pool);
-int zbud_alloc(struct zbud_pool *pool, size_t size, gfp_t gfp,
-	unsigned long *handle);
-void zbud_free(struct zbud_pool *pool, unsigned long handle);
-int zbud_reclaim_page(struct zbud_pool *pool, unsigned int retries);
-void *zbud_map(struct zbud_pool *pool, unsigned long handle);
-void zbud_unmap(struct zbud_pool *pool, unsigned long handle);
-u64 zbud_get_pool_size(struct zbud_pool *pool);
-
-#endif /* _ZBUD_H_ */
diff --git a/mm/zbud.c b/mm/zbud.c
index 91543be47e3d..3a048f603255 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -51,7 +51,6 @@
 #include <linux/preempt.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/zbud.h>
 #include <linux/zpool.h>
 
 /*****************
@@ -73,6 +72,12 @@
 #define ZHDR_SIZE_ALIGNED CHUNK_SIZE
 #define NCHUNKS		((PAGE_SIZE - ZHDR_SIZE_ALIGNED) >> CHUNK_SHIFT)
 
+struct zbud_pool;
+
+struct zbud_ops {
+	int (*evict)(struct zbud_pool *pool, unsigned long handle);
+};
+
 /**
  * struct zbud_pool - stores metadata for each zbud pool
  * @lock:	protects all pool fields and first|last_chunk fields of any
@@ -122,104 +127,6 @@ struct zbud_header {
 	bool under_reclaim;
 };
 
-/*****************
- * zpool
- ****************/
-
-#ifdef CONFIG_ZPOOL
-
-static int zbud_zpool_evict(struct zbud_pool *pool, unsigned long handle)
-{
-	if (pool->zpool && pool->zpool_ops && pool->zpool_ops->evict)
-		return pool->zpool_ops->evict(pool->zpool, handle);
-	else
-		return -ENOENT;
-}
-
-static const struct zbud_ops zbud_zpool_ops = {
-	.evict =	zbud_zpool_evict
-};
-
-static void *zbud_zpool_create(const char *name, gfp_t gfp,
-			       const struct zpool_ops *zpool_ops,
-			       struct zpool *zpool)
-{
-	struct zbud_pool *pool;
-
-	pool = zbud_create_pool(gfp, zpool_ops ? &zbud_zpool_ops : NULL);
-	if (pool) {
-		pool->zpool = zpool;
-		pool->zpool_ops = zpool_ops;
-	}
-	return pool;
-}
-
-static void zbud_zpool_destroy(void *pool)
-{
-	zbud_destroy_pool(pool);
-}
-
-static int zbud_zpool_malloc(void *pool, size_t size, gfp_t gfp,
-			unsigned long *handle)
-{
-	return zbud_alloc(pool, size, gfp, handle);
-}
-static void zbud_zpool_free(void *pool, unsigned long handle)
-{
-	zbud_free(pool, handle);
-}
-
-static int zbud_zpool_shrink(void *pool, unsigned int pages,
-			unsigned int *reclaimed)
-{
-	unsigned int total = 0;
-	int ret = -EINVAL;
-
-	while (total < pages) {
-		ret = zbud_reclaim_page(pool, 8);
-		if (ret < 0)
-			break;
-		total++;
-	}
-
-	if (reclaimed)
-		*reclaimed = total;
-
-	return ret;
-}
-
-static void *zbud_zpool_map(void *pool, unsigned long handle,
-			enum zpool_mapmode mm)
-{
-	return zbud_map(pool, handle);
-}
-static void zbud_zpool_unmap(void *pool, unsigned long handle)
-{
-	zbud_unmap(pool, handle);
-}
-
-static u64 zbud_zpool_total_size(void *pool)
-{
-	return zbud_get_pool_size(pool) * PAGE_SIZE;
-}
-
-static struct zpool_driver zbud_zpool_driver = {
-	.type =		"zbud",
-	.sleep_mapped = true,
-	.owner =	THIS_MODULE,
-	.create =	zbud_zpool_create,
-	.destroy =	zbud_zpool_destroy,
-	.malloc =	zbud_zpool_malloc,
-	.free =		zbud_zpool_free,
-	.shrink =	zbud_zpool_shrink,
-	.map =		zbud_zpool_map,
-	.unmap =	zbud_zpool_unmap,
-	.total_size =	zbud_zpool_total_size,
-};
-
-MODULE_ALIAS("zpool-zbud");
-#endif /* CONFIG_ZPOOL */
-
 /*****************
  * Helpers
 *****************/
@@ -306,7 +213,7 @@ static int num_free_chunks(struct zbud_header *zhdr)
  * Return: pointer to the new zbud pool or NULL if the metadata allocation
  * failed.
  */
-struct zbud_pool *zbud_create_pool(gfp_t gfp, const struct zbud_ops *ops)
+static struct zbud_pool *zbud_create_pool(gfp_t gfp, const struct zbud_ops *ops)
 {
 	struct zbud_pool *pool;
 	int i;
@@ -330,7 +237,7 @@ struct zbud_pool *zbud_create_pool(gfp_t gfp, const struct zbud_ops *ops)
  *
  * The pool should be emptied before this function is called.
  */
-void zbud_destroy_pool(struct zbud_pool *pool)
+static void zbud_destroy_pool(struct zbud_pool *pool)
 {
 	kfree(pool);
 }
@@ -354,7 +261,7 @@ void zbud_destroy_pool(struct zbud_pool *pool)
  * gfp arguments are invalid or -ENOMEM if the pool was unable to allocate
  * a new page.
  */
-int zbud_alloc(struct zbud_pool *pool, size_t size, gfp_t gfp,
+static int zbud_alloc(struct zbud_pool *pool, size_t size, gfp_t gfp,
 			unsigned long *handle)
 {
 	int chunks, i, freechunks;
@@ -429,7 +336,7 @@ int zbud_alloc(struct zbud_pool *pool, size_t size, gfp_t gfp,
  * only sets the first|last_chunks to 0.  The page is actually freed
  * once both buddies are evicted (see zbud_reclaim_page() below).
  */
-void zbud_free(struct zbud_pool *pool, unsigned long handle)
+static void zbud_free(struct zbud_pool *pool, unsigned long handle)
 {
 	struct zbud_header *zhdr;
 	int freechunks;
@@ -501,7 +408,7 @@ void zbud_free(struct zbud_pool *pool, unsigned long handle)
  * no pages to evict or an eviction handler is not registered, -EAGAIN if
  * the retry limit was hit.
  */
-int zbud_reclaim_page(struct zbud_pool *pool, unsigned int retries)
+static int zbud_reclaim_page(struct zbud_pool *pool, unsigned int retries)
 {
 	int i, ret, freechunks;
 	struct zbud_header *zhdr;
@@ -583,7 +490,7 @@ int zbud_reclaim_page(struct zbud_pool *pool, unsigned int retries)
  *
  * Returns: a pointer to the mapped allocation
  */
-void *zbud_map(struct zbud_pool *pool, unsigned long handle)
+static void *zbud_map(struct zbud_pool *pool, unsigned long handle)
 {
 	return (void *)(handle);
 }
@@ -593,7 +500,7 @@ void *zbud_map(struct zbud_pool *pool, unsigned long handle)
  * @pool:	pool in which the allocation resides
  * @handle:	handle associated with the allocation to be unmapped
  */
-void zbud_unmap(struct zbud_pool *pool, unsigned long handle)
+static void zbud_unmap(struct zbud_pool *pool, unsigned long handle)
 {
 }
 
@@ -604,11 +511,109 @@ void zbud_unmap(struct zbud_pool *pool, unsigned long handle)
  * Returns: size in pages of the given pool.  The pool lock need not be
  * taken to access pages_nr.
  */
-u64 zbud_get_pool_size(struct zbud_pool *pool)
+static u64 zbud_get_pool_size(struct zbud_pool *pool)
 {
 	return pool->pages_nr;
 }
 
+/*****************
+ * zpool
+ ****************/
+
+#ifdef CONFIG_ZPOOL
+
+static int zbud_zpool_evict(struct zbud_pool *pool, unsigned long handle)
+{
+	if (pool->zpool && pool->zpool_ops && pool->zpool_ops->evict)
+		return pool->zpool_ops->evict(pool->zpool, handle);
+	else
+		return -ENOENT;
+}
+
+static const struct zbud_ops zbud_zpool_ops = {
+	.evict =	zbud_zpool_evict
+};
+
+static void *zbud_zpool_create(const char *name, gfp_t gfp,
+			       const struct zpool_ops *zpool_ops,
+			       struct zpool *zpool)
+{
+	struct zbud_pool *pool;
+
+	pool = zbud_create_pool(gfp, zpool_ops ? &zbud_zpool_ops : NULL);
+	if (pool) {
+		pool->zpool = zpool;
+		pool->zpool_ops = zpool_ops;
+	}
+	return pool;
+}
+
+static void zbud_zpool_destroy(void *pool)
+{
+	zbud_destroy_pool(pool);
+}
+
+static int zbud_zpool_malloc(void *pool, size_t size, gfp_t gfp,
+			unsigned long *handle)
+{
+	return zbud_alloc(pool, size, gfp, handle);
+}
+static void zbud_zpool_free(void *pool, unsigned long handle)
+{
+	zbud_free(pool, handle);
+}
+
+static int zbud_zpool_shrink(void *pool, unsigned int pages,
+			unsigned int *reclaimed)
+{
+	unsigned int total = 0;
+	int ret = -EINVAL;
+
+	while (total < pages) {
+		ret = zbud_reclaim_page(pool, 8);
+		if (ret < 0)
+			break;
+		total++;
+	}
+
+	if (reclaimed)
+		*reclaimed = total;
+
+	return ret;
+}
+
+static void *zbud_zpool_map(void *pool, unsigned long handle,
+			enum zpool_mapmode mm)
+{
+	return zbud_map(pool, handle);
+}
+static void zbud_zpool_unmap(void *pool, unsigned long handle)
+{
+	zbud_unmap(pool, handle);
+}
+
+static u64 zbud_zpool_total_size(void *pool)
+{
+	return zbud_get_pool_size(pool) * PAGE_SIZE;
+}
+
+static struct zpool_driver zbud_zpool_driver = {
+	.type =		"zbud",
+	.sleep_mapped = true,
+	.owner =	THIS_MODULE,
+	.create =	zbud_zpool_create,
+	.destroy =	zbud_zpool_destroy,
+	.malloc =	zbud_zpool_malloc,
+	.free =		zbud_zpool_free,
+	.shrink =	zbud_zpool_shrink,
+	.map =		zbud_zpool_map,
+	.unmap =	zbud_zpool_unmap,
+	.total_size =	zbud_zpool_total_size,
+};
+
+MODULE_ALIAS("zpool-zbud");
+#endif /* CONFIG_ZPOOL */
+
 static int __init init_zbud(void)
 {
 	/* Make sure the zbud header will fit in one chunk */
-- 
2.23.0

