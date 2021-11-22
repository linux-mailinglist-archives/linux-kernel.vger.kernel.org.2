Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB974587C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 02:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhKVBdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 20:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhKVBdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 20:33:54 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA84C061574;
        Sun, 21 Nov 2021 17:30:48 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id r138so4298041pgr.13;
        Sun, 21 Nov 2021 17:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dZKWJhZzTjmnE7DsfZ02p2XlIMa+d3z82dVT8OwB3qw=;
        b=LDoy3Id/f1/iYFO1Z3JJlp/2QCxf/ab4EVYGcxRCH4Sb9DRFaiOHvJxqA4PtF6RP9f
         Vtj6dE/B7mfUcJwzW7oE+iZtDfw/Vpc2reuuAx9bTKH2CAcy23Wl91TRQAm0ylsEzSU6
         tSQEVVfCVHdJmz3HKDhqHkNT67I8AcYNoFiMb970XxKA1RBOYYNYn9eB/GZ5JWbTvc+M
         Q5la9TRJefk+qAJKIAR5oD33zef7CIRjapo1LJv7Nuj51qzKZ61VFf8kRnthPW37cyCF
         +sz1VfroBN7ruy/UyUjJ2gnMszzetAiq1qfkqDtFNWBmW97rYlk8N3f7TAtoCaHg7RC5
         ff8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dZKWJhZzTjmnE7DsfZ02p2XlIMa+d3z82dVT8OwB3qw=;
        b=gS5Fd2JhCl9YlbZmKvBdpAHxs2iDou5tkFKAZ7RVPbWxTumKAwXysUwak/0hCjXttT
         AJ4milz2fplwtKoYPuliha4KuZfhllKOUnuVYfcOh2trvIlywffuiPY11u/R7OcJTrU1
         nzmPxfrEXT87TJOg6Eepg/oZoUCnceFTIowMRBTBIIw058DiRRJEc1Q960f1eKTclTH7
         TkZX/gQ1ocEy4iVf6Ufj5/24P9I6AlKMKeYqJRRAtryEVH7f8QFqWx3HLB24M41b7SGa
         6yMag4SHAmvBxMDAvNcskQEMVNa/CC2cWrkwhT1DOVNuDvaTRFV7Va9qLJYqh/U+upj/
         8xAQ==
X-Gm-Message-State: AOAM533xZL+w9OBW1+9GSyHBlApcVhIysazGKouDO8RYgF92fQJC+19V
        zkW4pigourytiKgfx0zy4HI=
X-Google-Smtp-Source: ABdhPJyyBOG2+fLdE2HOuYg8n8vzTmgOcBE2mGOP+wpjY+QMMNPjrzDM062Ke6hNFRnhahwA2ECBtg==
X-Received: by 2002:a62:9202:0:b0:4a4:f09e:7d75 with SMTP id o2-20020a629202000000b004a4f09e7d75mr2830562pfd.33.1637544647728;
        Sun, 21 Nov 2021 17:30:47 -0800 (PST)
Received: from nuc10.amust.local (d50-92-229-34.bchsia.telus.net. [50.92.229.34])
        by smtp.gmail.com with ESMTPSA id t12sm16276874pjo.44.2021.11.21.17.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 17:30:47 -0800 (PST)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, dvyukov@google.com,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH v4] slob: add size header to all allocations
Date:   Sun, 21 Nov 2021 17:30:26 -0800
Message-Id: <20211122013026.909933-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's prepend both kmalloc() and kmem_cache_alloc() allocations with the
size header.
It simplifies the slab API and guarantees that both kmem_cache_alloc()
and kmalloc() memory could be freed by kfree().

meminfo right after the system boot, x86-64 on xfs, without the patch:
Slab:              34700 kB

the same, with the patch:
Slab:              35752 kB

Link: https://lore.kernel.org/lkml/20210929212347.1139666-1-rkovhaev@gmail.com
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
v4:
 - Drop the align_offset parameter and pass size unchanged to
   slob_alloc()
 - Add SLOB_HDR_SIZE to size in slob_alloc()

v3:
 - Add SLOB_HDR_SIZE define
 - Remove references to minalign
 - Improve documentation wording

v2:
 - Allocate compound pages in slob_alloc_node()
 - Use slob_free_pages() in kfree()
 - Update documentation
---
 Documentation/core-api/memory-allocation.rst |  12 +-
 mm/slob.c                                    | 140 +++++++++----------
 2 files changed, 72 insertions(+), 80 deletions(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
index 5954ddf6ee13..31806d5ebeec 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -170,7 +170,11 @@ should be used if a part of the cache might be copied to the userspace.
 After the cache is created kmem_cache_alloc() and its convenience
 wrappers can allocate memory from that cache.
 
-When the allocated memory is no longer needed it must be freed. You can
-use kvfree() for the memory allocated with `kmalloc`, `vmalloc` and
-`kvmalloc`. The slab caches should be freed with kmem_cache_free(). And
-don't forget to destroy the cache with kmem_cache_destroy().
+When the allocated memory is no longer needed it must be freed.
+Objects allocated by `kmalloc` can be freed with `kfree` or `kvfree`.
+Objects allocated by `kmem_cache_alloc` can be freed with `kmem_cache_free`
+or also by `kfree` or `kvfree`.
+Memory allocated by `vmalloc` can be freed with `vfree` or `kvfree`.
+Memory allocated by `kvmalloc` can be freed with `kvfree`.
+Caches created by `kmem_cache_create` should be freed with
+`kmem_cache_destroy`.
diff --git a/mm/slob.c b/mm/slob.c
index 03deee1e6a94..5cc49102e070 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -25,23 +25,18 @@
  * into the free list in address order, so this is effectively an
  * address-ordered first fit.
  *
- * Above this is an implementation of kmalloc/kfree. Blocks returned
- * from kmalloc are prepended with a 4-byte header with the kmalloc size.
- * If kmalloc is asked for objects of PAGE_SIZE or larger, it calls
- * alloc_pages() directly, allocating compound pages so the page order
- * does not have to be separately tracked.
- * These objects are detected in kfree() because PageSlab()
- * is false for them.
+ * Blocks that are less than (PAGE_SIZE - SLOB_HDR_SIZE) are prepended with
+ * a 4-byte header with the size. Larger blocks do not have the header and
+ * SLOB calls alloc_pages() directly, allocating compound pages so the
+ * page order does not have to be separately tracked. These objects are
+ * detected in kfree() because PageSlab() is false for them.
  *
  * SLAB is emulated on top of SLOB by simply calling constructors and
  * destructors for every SLAB allocation. Objects are returned with the
  * 4-byte alignment unless the SLAB_HWCACHE_ALIGN flag is set, in which
  * case the low-level allocator will fragment blocks to create the proper
- * alignment. Again, objects of page-size or greater are allocated by
- * calling alloc_pages(). As SLAB objects know their size, no separate
- * size bookkeeping is necessary and there is essentially no allocation
- * space overhead, and compound pages aren't needed for multi-page
- * allocations.
+ * alignment. Again, objects of (PAGE_SIZE - SLOB_HDR_SIZE) or greater are
+ * allocated by calling alloc_pages().
  *
  * NUMA support in SLOB is fairly simplistic, pushing most of the real
  * logic down to the page allocator, and simply doing the node accounting
@@ -88,6 +83,8 @@ typedef s16 slobidx_t;
 typedef s32 slobidx_t;
 #endif
 
+#define SLOB_HDR_SIZE max(ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN)
+
 struct slob_block {
 	slobidx_t units;
 };
@@ -207,12 +204,14 @@ static void *slob_new_pages(gfp_t gfp, int order, int node)
 	return page_address(page);
 }
 
-static void slob_free_pages(void *b, int order)
+static void slob_free_pages(struct page *sp, int order)
 {
-	struct page *sp = virt_to_page(b);
-
-	if (current->reclaim_state)
-		current->reclaim_state->reclaimed_slab += 1 << order;
+	if (PageSlab(sp)) {
+		__ClearPageSlab(sp);
+		page_mapcount_reset(sp);
+		if (current->reclaim_state)
+			current->reclaim_state->reclaimed_slab += 1 << order;
+	}
 
 	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
 			    -(PAGE_SIZE << order));
@@ -247,9 +246,7 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align,
 		/*
 		 * 'aligned' will hold the address of the slob block so that the
 		 * address 'aligned'+'align_offset' is aligned according to the
-		 * 'align' parameter. This is for kmalloc() which prepends the
-		 * allocated block with its size, so that the block itself is
-		 * aligned when needed.
+		 * 'align' parameter.
 		 */
 		if (align) {
 			aligned = (slob_t *)
@@ -298,8 +295,7 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align,
 /*
  * slob_alloc: entry point into the slob allocator.
  */
-static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
-							int align_offset)
+static void *slob_alloc(size_t size, gfp_t gfp, int align, int node)
 {
 	struct page *sp;
 	struct list_head *slob_list;
@@ -307,6 +303,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
 	unsigned long flags;
 	bool _unused;
 
+	size += SLOB_HDR_SIZE;
 	if (size < SLOB_BREAK1)
 		slob_list = &free_slob_small;
 	else if (size < SLOB_BREAK2)
@@ -330,7 +327,7 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
 		if (sp->units < SLOB_UNITS(size))
 			continue;
 
-		b = slob_page_alloc(sp, size, align, align_offset, &page_removed_from_list);
+		b = slob_page_alloc(sp, size, align, SLOB_HDR_SIZE, &page_removed_from_list);
 		if (!b)
 			continue;
 
@@ -367,31 +364,32 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
 		INIT_LIST_HEAD(&sp->slab_list);
 		set_slob(b, SLOB_UNITS(PAGE_SIZE), b + SLOB_UNITS(PAGE_SIZE));
 		set_slob_page_free(sp, slob_list);
-		b = slob_page_alloc(sp, size, align, align_offset, &_unused);
+		b = slob_page_alloc(sp, size, align, SLOB_HDR_SIZE, &_unused);
 		BUG_ON(!b);
 		spin_unlock_irqrestore(&slob_lock, flags);
 	}
 	if (unlikely(gfp & __GFP_ZERO))
 		memset(b, 0, size);
-	return b;
+	/* Write size in the header */
+	*(unsigned int *)b = size - SLOB_HDR_SIZE;
+	return (void *)b + SLOB_HDR_SIZE;
 }
 
 /*
  * slob_free: entry point into the slob allocator.
  */
-static void slob_free(void *block, int size)
+static void slob_free(void *block)
 {
 	struct page *sp;
-	slob_t *prev, *next, *b = (slob_t *)block;
+	slob_t *prev, *next, *b = block - SLOB_HDR_SIZE;
+	unsigned int size;
 	slobidx_t units;
 	unsigned long flags;
 	struct list_head *slob_list;
 
-	if (unlikely(ZERO_OR_NULL_PTR(block)))
-		return;
-	BUG_ON(!size);
-
-	sp = virt_to_page(block);
+	size = *(unsigned int *)b + SLOB_HDR_SIZE;
+	BUG_ON(!size || size >= PAGE_SIZE);
+	sp = virt_to_page(b);
 	units = SLOB_UNITS(size);
 
 	spin_lock_irqsave(&slob_lock, flags);
@@ -401,9 +399,7 @@ static void slob_free(void *block, int size)
 		if (slob_page_free(sp))
 			clear_slob_page_free(sp);
 		spin_unlock_irqrestore(&slob_lock, flags);
-		__ClearPageSlab(sp);
-		page_mapcount_reset(sp);
-		slob_free_pages(b, 0);
+		slob_free_pages(sp, 0);
 		return;
 	}
 
@@ -476,36 +472,29 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 static __always_inline void *
 __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 {
-	unsigned int *m;
-	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 	void *ret;
 
 	gfp &= gfp_allowed_mask;
 
 	might_alloc(gfp);
 
-	if (size < PAGE_SIZE - minalign) {
-		int align = minalign;
+	if (size < PAGE_SIZE - SLOB_HDR_SIZE) {
+		int align = SLOB_HDR_SIZE;
 
 		/*
 		 * For power of two sizes, guarantee natural alignment for
 		 * kmalloc()'d objects.
 		 */
 		if (is_power_of_2(size))
-			align = max(minalign, (int) size);
+			align = max(align, (int) size);
 
 		if (!size)
 			return ZERO_SIZE_PTR;
 
-		m = slob_alloc(size + minalign, gfp, align, node, minalign);
-
-		if (!m)
-			return NULL;
-		*m = size;
-		ret = (void *)m + minalign;
+		ret = slob_alloc(size, gfp, align, node);
 
 		trace_kmalloc_node(caller, ret,
-				   size, size + minalign, gfp, node);
+				   size, size + SLOB_HDR_SIZE, gfp, node);
 	} else {
 		unsigned int order = get_order(size);
 
@@ -553,26 +542,17 @@ void kfree(const void *block)
 	kmemleak_free(block);
 
 	sp = virt_to_page(block);
-	if (PageSlab(sp)) {
-		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
-		unsigned int *m = (unsigned int *)(block - align);
-		slob_free(m, *m + align);
-	} else {
-		unsigned int order = compound_order(sp);
-		mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
-				    -(PAGE_SIZE << order));
-		__free_pages(sp, order);
-
-	}
+	if (PageSlab(sp))
+		slob_free((void *)block);
+	else
+		slob_free_pages(sp, compound_order(sp));
 }
 EXPORT_SYMBOL(kfree);
 
-/* can't use ksize for kmem_cache_alloc memory, only kmalloc */
 size_t __ksize(const void *block)
 {
 	struct page *sp;
-	int align;
-	unsigned int *m;
+	unsigned int size;
 
 	BUG_ON(!block);
 	if (unlikely(block == ZERO_SIZE_PTR))
@@ -582,9 +562,8 @@ size_t __ksize(const void *block)
 	if (unlikely(!PageSlab(sp)))
 		return page_size(sp);
 
-	align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
-	m = (unsigned int *)(block - align);
-	return SLOB_UNITS(*m) * SLOB_UNIT;
+	size = *(unsigned int *)(block - SLOB_HDR_SIZE);
+	return SLOB_UNITS(size) * SLOB_UNIT;
 }
 EXPORT_SYMBOL(__ksize);
 
@@ -606,16 +585,19 @@ static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 
 	might_alloc(flags);
 
-	if (c->size < PAGE_SIZE) {
-		b = slob_alloc(c->size, flags, c->align, node, 0);
+	if (c->size < PAGE_SIZE - SLOB_HDR_SIZE) {
+		b = slob_alloc(c->size, flags, c->align, node);
 		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
-					    SLOB_UNITS(c->size) * SLOB_UNIT,
+					    SLOB_UNITS(c->size + SLOB_HDR_SIZE) * SLOB_UNIT,
 					    flags, node);
 	} else {
-		b = slob_new_pages(flags, get_order(c->size), node);
+		unsigned int order = get_order(c->size);
+
+		if (likely(order))
+			flags |= __GFP_COMP;
+		b = slob_new_pages(flags, order, node);
 		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
-					    PAGE_SIZE << get_order(c->size),
-					    flags, node);
+					    PAGE_SIZE << order, flags, node);
 	}
 
 	if (b && c->ctor) {
@@ -647,12 +629,18 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int node)
 EXPORT_SYMBOL(kmem_cache_alloc_node);
 #endif
 
-static void __kmem_cache_free(void *b, int size)
+static void __kmem_cache_free(void *b)
 {
-	if (size < PAGE_SIZE)
-		slob_free(b, size);
+	struct page *sp;
+
+	if (unlikely(ZERO_OR_NULL_PTR(b)))
+		return;
+
+	sp = virt_to_page(b);
+	if (PageSlab(sp))
+		slob_free(b);
 	else
-		slob_free_pages(b, get_order(size));
+		slob_free_pages(sp, compound_order(sp));
 }
 
 static void kmem_rcu_free(struct rcu_head *head)
@@ -660,7 +648,7 @@ static void kmem_rcu_free(struct rcu_head *head)
 	struct slob_rcu *slob_rcu = (struct slob_rcu *)head;
 	void *b = (void *)slob_rcu - (slob_rcu->size - sizeof(struct slob_rcu));
 
-	__kmem_cache_free(b, slob_rcu->size);
+	__kmem_cache_free(b);
 }
 
 void kmem_cache_free(struct kmem_cache *c, void *b)
@@ -673,7 +661,7 @@ void kmem_cache_free(struct kmem_cache *c, void *b)
 		slob_rcu->size = c->size;
 		call_rcu(&slob_rcu->head, kmem_rcu_free);
 	} else {
-		__kmem_cache_free(b, c->size);
+		__kmem_cache_free(b);
 	}
 }
 EXPORT_SYMBOL(kmem_cache_free);
-- 
2.30.2

