Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3243820C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 08:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhJWGoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 02:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhJWGoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 02:44:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAADC061764;
        Fri, 22 Oct 2021 23:41:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d9so5608359pfl.6;
        Fri, 22 Oct 2021 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lqvQc54VfM8/DrixkH7MhvxvzHeF17H+ppwD4DGDz5k=;
        b=dadpVEqL3MsJoubMxiLSdfpwBWO7xqGKzaXs9XpODZBeGMLqyNq8NA1YyMT6f6xqCZ
         KXn+H7KYiqEPg+gZRAoxsqUyU+lbeIHd9QxBRnDBSpir++BBaV61n9TRgx+zN6DPoaEx
         eCsIkVhSXQRAGsjNeA7r1NVyKvkFcyifjsZ/FqIeoc+5iMSbbwBGZW/d4IxLr6kdWa8+
         Dzh3DttVnQq/QGhPzF4WDAJBW6TSR0RZKQ5+9wuDGlL7O4MmeKjPOz6VsXNfoRPlvZIc
         OunNvMoqa/Yytiba6OYlQS7NWEPKTEECfT8bEvT4NhZt1s3ySH5W0g784tNPQaTIWeRS
         TPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lqvQc54VfM8/DrixkH7MhvxvzHeF17H+ppwD4DGDz5k=;
        b=hoqfk88OeHtQdqUl6sNiH5q0LO1mtBYPU6+Nl3IZ0aIO25nt2Vw4n1VGFoGdF4iScT
         bfY43wR9d2qNuMedZPTN5ltUzFuDkHllAUXRHEHuvUO2et40vUp6lHpiQf1uzH6ubWpt
         dtvLEVUJLx0nHo48OOyZ3xrNMND3n/xluwhSlgP4/g6pprt6Kw9PhAXp1Oobe2vz8UVy
         qsMvJxfYznWAzykNeNZ0CgopI2VhSrG2vXATzlaeusTMwoqEflkGqZPcKlmbSO+0Pyk1
         alpNNXGign6Ep7RbTeVxLTgY27ei+ylcQM8WorfDIcWAVVyPulUMFP6SoXLoCzhd3VMn
         bk9A==
X-Gm-Message-State: AOAM532NNde3yC+R5iMUkzLJJfxXiviuxJhpmNbIbeXg3BCmGSEC6gOb
        4D1aWWibEwgL/rg4uTTOSyA=
X-Google-Smtp-Source: ABdhPJz8naF+O/wUXjPWAMz8I8gXxepEqPf76NyjzTbs3KShqjj3RJaFWoVLDCbQkwUxzaFiEuECdQ==
X-Received: by 2002:a63:874a:: with SMTP id i71mr816701pge.200.1634971308384;
        Fri, 22 Oct 2021 23:41:48 -0700 (PDT)
Received: from nuc10.. (d50-92-229-34.bchsia.telus.net. [50.92.229.34])
        by smtp.gmail.com with ESMTPSA id i11sm10477024pgp.18.2021.10.22.23.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 23:41:48 -0700 (PDT)
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, dvyukov@google.com,
        Rustam Kovhaev <rkovhaev@gmail.com>
Subject: [PATCH v2] slob: add size header to all allocations
Date:   Fri, 22 Oct 2021 23:41:14 -0700
Message-Id: <20211023064114.708532-1-rkovhaev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1dfb7a79-3e66-a9fe-ee7c-1277d7ff5950@suse.cz>
References: <1dfb7a79-3e66-a9fe-ee7c-1277d7ff5950@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's prepend both kmalloc() and kmem_cache_alloc() allocations with the
size header.
It simplifies the slab API and guarantees that both kmem_cache_alloc()
and kmalloc() memory could be freed by kfree().

meminfo right after the system boot, without the patch:
Slab:              35456 kB

the same, with the patch:
Slab:              36160 kB

Link: https://lore.kernel.org/lkml/20210929212347.1139666-1-rkovhaev@gmail.com
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
---
v2:
 - Allocate compound pages in slob_alloc_node()
 - Use slob_free_pages() in kfree()
 - Update documentation

 Documentation/core-api/memory-allocation.rst |   4 +-
 mm/slob.c                                    | 114 +++++++++----------
 2 files changed, 55 insertions(+), 63 deletions(-)

diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
index 5954ddf6ee13..fea0ed11a7c5 100644
--- a/Documentation/core-api/memory-allocation.rst
+++ b/Documentation/core-api/memory-allocation.rst
@@ -172,5 +172,5 @@ wrappers can allocate memory from that cache.
 
 When the allocated memory is no longer needed it must be freed. You can
 use kvfree() for the memory allocated with `kmalloc`, `vmalloc` and
-`kvmalloc`. The slab caches should be freed with kmem_cache_free(). And
-don't forget to destroy the cache with kmem_cache_destroy().
+`kvmalloc`. The slab caches can be freed with kmem_cache_free() or kvfree().
+And don't forget to destroy the cache with kmem_cache_destroy().
diff --git a/mm/slob.c b/mm/slob.c
index 74d3f6e60666..0cba0b569877 100644
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
+ * Blocks that are less than (PAGE_SIZE - minalign) are prepended with a
+ * 4-byte header with the size. Larger blocks do not have the header and
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
+ * alignment. Again, objects of (PAGE_SIZE - minalign) or greater are
+ * allocated by calling alloc_pages().
  *
  * NUMA support in SLOB is fairly simplistic, pushing most of the real
  * logic down to the page allocator, and simply doing the node accounting
@@ -207,12 +202,14 @@ static void *slob_new_pages(gfp_t gfp, int order, int node)
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
@@ -247,9 +244,7 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align,
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
@@ -373,25 +368,28 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
 	}
 	if (unlikely(gfp & __GFP_ZERO))
 		memset(b, 0, size);
+	/* Write size in the header */
+	*(unsigned int *)b = size - align_offset;
+	b = (void *)b + align_offset;
 	return b;
 }
 
 /*
  * slob_free: entry point into the slob allocator.
  */
-static void slob_free(void *block, int size)
+static void slob_free(void *block)
 {
 	struct page *sp;
-	slob_t *prev, *next, *b = (slob_t *)block;
+	int align_offset = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
+	void *hdr = block - align_offset;
+	unsigned int size = *(unsigned int *)hdr + align_offset;
+	slob_t *prev, *next, *b = hdr;
 	slobidx_t units;
 	unsigned long flags;
 	struct list_head *slob_list;
 
-	if (unlikely(ZERO_OR_NULL_PTR(block)))
-		return;
-	BUG_ON(!size);
-
-	sp = virt_to_page(block);
+	BUG_ON(!size || size >= PAGE_SIZE);
+	sp = virt_to_page(hdr);
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
 
@@ -476,7 +472,6 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 static __always_inline void *
 __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 {
-	unsigned int *m;
 	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 	void *ret;
 
@@ -497,12 +492,7 @@ __do_kmalloc_node(size_t size, gfp_t gfp, int node, unsigned long caller)
 		if (!size)
 			return ZERO_SIZE_PTR;
 
-		m = slob_alloc(size + minalign, gfp, align, node, minalign);
-
-		if (!m)
-			return NULL;
-		*m = size;
-		ret = (void *)m + minalign;
+		ret = slob_alloc(size + minalign, gfp, align, node, minalign);
 
 		trace_kmalloc_node(caller, ret,
 				   size, size + minalign, gfp, node);
@@ -553,21 +543,13 @@ void kfree(const void *block)
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
@@ -600,22 +582,26 @@ int __kmem_cache_create(struct kmem_cache *c, slab_flags_t flags)
 
 static void *slob_alloc_node(struct kmem_cache *c, gfp_t flags, int node)
 {
+	int minalign = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
 	void *b;
 
 	flags &= gfp_allowed_mask;
 
 	might_alloc(flags);
 
-	if (c->size < PAGE_SIZE) {
-		b = slob_alloc(c->size, flags, c->align, node, 0);
+	if (c->size < PAGE_SIZE - minalign) {
+		b = slob_alloc(c->size + minalign, flags, c->align, node, minalign);
 		trace_kmem_cache_alloc_node(_RET_IP_, b, c->object_size,
-					    SLOB_UNITS(c->size) * SLOB_UNIT,
+					    SLOB_UNITS(c->size + minalign) * SLOB_UNIT,
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
@@ -647,12 +633,18 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t gfp, int node)
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
@@ -660,7 +652,7 @@ static void kmem_rcu_free(struct rcu_head *head)
 	struct slob_rcu *slob_rcu = (struct slob_rcu *)head;
 	void *b = (void *)slob_rcu - (slob_rcu->size - sizeof(struct slob_rcu));
 
-	__kmem_cache_free(b, slob_rcu->size);
+	__kmem_cache_free(b);
 }
 
 void kmem_cache_free(struct kmem_cache *c, void *b)
@@ -672,7 +664,7 @@ void kmem_cache_free(struct kmem_cache *c, void *b)
 		slob_rcu->size = c->size;
 		call_rcu(&slob_rcu->head, kmem_rcu_free);
 	} else {
-		__kmem_cache_free(b, c->size);
+		__kmem_cache_free(b);
 	}
 
 	trace_kmem_cache_free(_RET_IP_, b, c->name);
-- 
2.30.2

