Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25BB3F4BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhHWN0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237432AbhHWN0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:26:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 482C160F92;
        Mon, 23 Aug 2021 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629725132;
        bh=R3X8HkItH3+N8iKPEsdpdaWvVVC+BHaWBQTAjMphu68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6qYRBiAWvooxPFis1nz0VKfN+Fp5cAxTp/CHgiyDAbtp5+lGMy/y5fAdJdtYbtAZ
         a+8IQea9wKZCzTpNFxK+/QP5NVAN9gY9GjV3tg87WvMdLOr1hO367foEuUVjj8XTzB
         26kKqm52EiLqU7hc3uAt2zrRLujiRxNtMUljnNFAddEjkGsORzRv96pTKDoNE3p67L
         bqypbD5isjPihqdGiZDS/74xx8bDzfnhYp5VpOXZSky7gOPEAUnuj8pYGAE+hFgLoF
         s45T2klRFD0OdOW5Kc1gCsANL0N4cvZX6qDzudQKvzMNWWM3TS7BQGTqSqVhIA8/mw
         h1YQr63EYJn7Q==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/4] mm/page_alloc: introduce __GFP_PTE_MAPPED flag to allocate pte-mapped pages
Date:   Mon, 23 Aug 2021 16:25:12 +0300
Message-Id: <20210823132513.15836-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210823132513.15836-1-rppt@kernel.org>
References: <20210823132513.15836-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

When __GFP_PTE_MAPPED flag is passed to an allocation request of order 0,
the allocated page will be mapped at PTE level in the direct map.

To reduce the direct map fragmentation, maintain a cache of 4K pages that
are already mapped at PTE level in the direct map. Whenever the cache
should be replenished, try to allocate 2M page and split it to 4K pages
to localize shutter of the direct map. If the allocation of 2M page fails,
fallback to a single page allocation at expense of the direct map
fragmentation.

The cache registers a shrinker that releases free pages from the cache to
the page allocator.

The __GFP_PTE_MAPPED and caching of 4K pages are enabled only if an
architecture selects ARCH_WANTS_PTE_MAPPED_CACHE in its Kconfig.

[
cache management are mostly copied from 
https://lore.kernel.org/lkml/20210505003032.489164-4-rick.p.edgecombe@intel.com/
]

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/Kconfig                    |   8 +
 arch/x86/Kconfig                |   1 +
 include/linux/gfp.h             |  11 +-
 include/linux/mm.h              |   2 +
 include/linux/pageblock-flags.h |  26 ++++
 init/main.c                     |   1 +
 mm/internal.h                   |   3 +-
 mm/page_alloc.c                 | 261 +++++++++++++++++++++++++++++++-
 8 files changed, 309 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 129df498a8e1..2db95331201b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -243,6 +243,14 @@ config ARCH_HAS_SET_MEMORY
 config ARCH_HAS_SET_DIRECT_MAP
 	bool
 
+#
+# Select if the architecture wants to minimize fragmentation of its
+# direct/linear map cauesd by set_memory and set_direct_map operations
+#
+config ARCH_WANTS_PTE_MAPPED_CACHE
+	bool
+	depends on ARCH_HAS_SET_MEMORY || ARCH_HAS_SET_DIRECT_MAP
+
 #
 # Select if the architecture provides the arch_dma_set_uncached symbol to
 # either provide an uncached segment alias for a DMA allocation, or
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 88fb922c23a0..9b4e6cf4a6aa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -118,6 +118,7 @@ config X86
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_LD_ORPHAN_WARN
+	select ARCH_WANTS_PTE_MAPPED_CACHE
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select BUILDTIME_TABLE_SORT
 	select CLKEVT_I8253
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 55b2ec1f965a..c9006e3c67ad 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -55,8 +55,9 @@ struct vm_area_struct;
 #define ___GFP_ACCOUNT		0x400000u
 #define ___GFP_ZEROTAGS		0x800000u
 #define ___GFP_SKIP_KASAN_POISON	0x1000000u
+#define ___GFP_PTE_MAPPED	0x2000000u
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x2000000u
+#define ___GFP_NOLOCKDEP	0x4000000u
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
@@ -101,12 +102,18 @@ struct vm_area_struct;
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
+ *
+ * %__GFP_PTE_MAPPED returns a page that is mapped with PTE in the
+ * direct map. On architectures that use higher page table levels to map
+ * physical memory, this flag will casue split of large pages in the direct
+ * mapping. Has effect only if CONFIG_ARCH_WANTS_PTE_MAPPED_CACHE is set.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
+#define __GFP_PTE_MAPPED ((__force gfp_t)___GFP_PTE_MAPPED)
 
 /**
  * DOC: Watermark modifiers
@@ -249,7 +256,7 @@ struct vm_area_struct;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7ca22e6e694a..350ec98b82d2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3283,5 +3283,7 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 	return 0;
 }
 
+void pte_mapped_cache_init(void);
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index 973fd731a520..4faf8c542b00 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -21,6 +21,8 @@ enum pageblock_bits {
 			/* 3 bits required for migrate types */
 	PB_migrate_skip,/* If set the block is skipped by compaction */
 
+	PB_pte_mapped, /* If set the block is mapped with PTEs in direct map */
+
 	/*
 	 * Assume the bits will always align on a word. If this assumption
 	 * changes then get/set pageblock needs updating.
@@ -88,4 +90,28 @@ static inline void set_pageblock_skip(struct page *page)
 }
 #endif /* CONFIG_COMPACTION */
 
+#ifdef CONFIG_ARCH_WANTS_PTE_MAPPED_CACHE
+#define get_pageblock_pte_mapped(page)				\
+	get_pfnblock_flags_mask(page, page_to_pfn(page),	\
+			(1 << (PB_pte_mapped)))
+#define clear_pageblock_pte_mapped(page) \
+	set_pfnblock_flags_mask(page, 0, page_to_pfn(page),	\
+			(1 << PB_pte_mapped))
+#define set_pageblock_pte_mapped(page) \
+	set_pfnblock_flags_mask(page, (1 << PB_pte_mapped),	\
+			page_to_pfn(page),			\
+			(1 << PB_pte_mapped))
+#else /* CONFIG_ARCH_WANTS_PTE_MAPPED_CACHE */
+static inline bool get_pageblock_pte_mapped(struct page *page)
+{
+	return false;
+}
+static inline void clear_pageblock_pte_mapped(struct page *page)
+{
+}
+static inline void set_pageblock_pte_mapped(struct page *page)
+{
+}
+#endif /* CONFIG_ARCH_WANTS_PTE_MAPPED_CACHE */
+
 #endif	/* PAGEBLOCK_FLAGS_H */
diff --git a/init/main.c b/init/main.c
index f5b8246e8aa1..c0d59a183a39 100644
--- a/init/main.c
+++ b/init/main.c
@@ -828,6 +828,7 @@ static void __init mm_init(void)
 	page_ext_init_flatmem_late();
 	kmem_cache_init();
 	kmemleak_init();
+	pte_mapped_cache_init();
 	pgtable_init();
 	debug_objects_mem_init();
 	vmalloc_init();
diff --git a/mm/internal.h b/mm/internal.h
index 31ff935b2547..0557ece6ebf4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -24,7 +24,8 @@
 			__GFP_ATOMIC)
 
 /* The GFP flags allowed during early boot */
-#define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|__GFP_FS))
+#define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|__GFP_FS|\
+					   __GFP_PTE_MAPPED))
 
 /* Control allocation cpuset and node placement constraints */
 #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 856b175c15a4..7936d8dcb80b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -72,6 +72,7 @@
 #include <linux/padata.h>
 #include <linux/khugepaged.h>
 #include <linux/buffer_head.h>
+#include <linux/set_memory.h>
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -107,6 +108,14 @@ typedef int __bitwise fpi_t;
  */
 #define FPI_TO_TAIL		((__force fpi_t)BIT(1))
 
+/*
+ * Free page directly to the page allocator rather than check if it should
+ * be placed into the cache of pte_mapped pages.
+ * Used by the pte_mapped cache shrinker.
+ * Has effect only when pte-mapped cache is enabled
+ */
+#define FPI_NO_PTE_MAP		((__force fpi_t)BIT(2))
+
 /*
  * Don't poison memory with KASAN (only for the tag-based modes).
  * During boot, all non-reserved memblock memory is exposed to page_alloc.
@@ -225,6 +234,19 @@ static inline void set_pcppage_migratetype(struct page *page, int migratetype)
 	page->index = migratetype;
 }
 
+#ifdef CONFIG_ARCH_WANTS_PTE_MAPPED_CACHE
+static struct page *alloc_page_pte_mapped(gfp_t gfp);
+static void free_page_pte_mapped(struct page *page);
+#else
+static inline struct page *alloc_page_pte_mapped(gfp_t gfp)
+{
+	return NULL;
+}
+static void free_page_pte_mapped(struct page *page)
+{
+}
+#endif
+
 #ifdef CONFIG_PM_SLEEP
 /*
  * The following functions are used by the suspend/hibernate code to temporarily
@@ -536,7 +558,7 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	unsigned long bitidx, word_bitidx;
 	unsigned long old_word, word;
 
-	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
+	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 5);
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
 
 	bitmap = get_pageblock_bitmap(page, pfn);
@@ -1352,6 +1374,16 @@ static __always_inline bool free_pages_prepare(struct page *page,
 					   PAGE_SIZE << order);
 	}
 
+	/*
+	 * Unless are we shrinking pte_mapped cache return a page from
+	 * a pageblock mapped with PTEs to that cache.
+	 */
+	if (!order && !(fpi_flags & FPI_NO_PTE_MAP) &&
+	    get_pageblock_pte_mapped(page)) {
+		free_page_pte_mapped(page);
+		return false;
+	}
+
 	kernel_poison_pages(page, 1 << order);
 
 	/*
@@ -3445,6 +3477,13 @@ void free_unref_page_list(struct list_head *list)
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
 		pfn = page_to_pfn(page);
+
+		if (get_pageblock_pte_mapped(page)) {
+			list_del(&page->lru);
+			free_page_pte_mapped(page);
+			continue;
+		}
+
 		if (!free_unref_page_prepare(page, pfn, 0))
 			list_del(&page->lru);
 
@@ -5381,6 +5420,12 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
 			&alloc_gfp, &alloc_flags))
 		return NULL;
 
+	if ((alloc_gfp & __GFP_PTE_MAPPED) && order == 0) {
+		page = alloc_page_pte_mapped(alloc_gfp);
+		if (page)
+			goto out;
+	}
+
 	/*
 	 * Forbid the first pass from falling back to types that fragment
 	 * memory until all local zones are considered.
@@ -5681,6 +5726,220 @@ void free_pages_exact(void *virt, size_t size)
 }
 EXPORT_SYMBOL(free_pages_exact);
 
+#ifdef CONFIG_ARCH_WANTS_PTE_MAPPED_CACHE
+
+struct pte_mapped_cache {
+	struct shrinker shrinker;
+	struct list_lru lru;
+	atomic_t nid_round_robin;
+	unsigned long free_cnt;
+};
+
+static struct pte_mapped_cache pte_mapped_cache;
+
+static struct page *pte_mapped_cache_get(struct pte_mapped_cache *cache)
+{
+	unsigned long start_nid, i;
+	struct list_head *head;
+	struct page *page = NULL;
+
+	start_nid = atomic_fetch_inc(&cache->nid_round_robin) % nr_node_ids;
+	for (i = 0; i < nr_node_ids; i++) {
+		int cur_nid = (start_nid + i) % nr_node_ids;
+
+		head = list_lru_get_mru(&cache->lru, cur_nid);
+		if (head) {
+			page = list_entry(head, struct page, lru);
+			break;
+		}
+	}
+
+	return page;
+}
+
+static void pte_mapped_cache_add(struct pte_mapped_cache *cache,
+				 struct page *page)
+{
+	INIT_LIST_HEAD(&page->lru);
+	list_lru_add_node(&cache->lru, &page->lru, page_to_nid(page));
+	set_page_count(page, 0);
+}
+
+static void pte_mapped_cache_add_neighbour_pages(struct page *page)
+{
+#if 0
+	/*
+	 * TODO: if pte_mapped_cache_replenish() had to fallback to order-0
+	 * allocation, the large page in the direct map will be split
+	 * anyway and if there are free pages in the same pageblock they
+	 * can be added to pte_mapped cache.
+	 */
+	unsigned int order = (1 << HUGETLB_PAGE_ORDER);
+	unsigned int nr_pages = (1 << order);
+	unsigned long pfn = page_to_pfn(page);
+	struct page *page_head = page - (pfn & (order - 1));
+
+	for (i = 0; i < nr_pages; i++) {
+		page = page_head + i;
+		if (is_free_buddy_page(page)) {
+			take_page_off_buddy(page);
+			pte_mapped_cache_add(&pte_mapped_cache, page);
+		}
+	}
+#endif
+}
+
+static struct page *pte_mapped_cache_replenish(struct pte_mapped_cache *cache,
+					       gfp_t gfp)
+{
+	unsigned int order = HUGETLB_PAGE_ORDER;
+	unsigned int nr_pages;
+	struct page *page;
+	int i, err;
+
+	gfp &= ~__GFP_PTE_MAPPED;
+
+	page = alloc_pages(gfp, order);
+	if (!page) {
+		order = 0;
+		page = alloc_pages(gfp, order);
+		if (!page)
+			return NULL;
+	}
+
+	nr_pages = (1 << order);
+	err = set_memory_4k((unsigned long)page_address(page), nr_pages);
+	if (err)
+		goto err_free_pages;
+
+	if (order)
+		split_page(page, order);
+	else
+		pte_mapped_cache_add_neighbour_pages(page);
+
+	for (i = 1; i < nr_pages; i++)
+		pte_mapped_cache_add(cache, page + i);
+
+	set_pageblock_pte_mapped(page);
+
+	return page;
+
+err_free_pages:
+	__free_pages(page, order);
+	return NULL;
+}
+
+static struct page *alloc_page_pte_mapped(gfp_t gfp)
+{
+	struct pte_mapped_cache *cache = &pte_mapped_cache;
+	struct page *page;
+
+	page = pte_mapped_cache_get(cache);
+	if (page) {
+		prep_new_page(page, 0, gfp, 0);
+		goto out;
+	}
+
+	page = pte_mapped_cache_replenish(cache, gfp);
+
+out:
+	return page;
+}
+
+static void free_page_pte_mapped(struct page *page)
+{
+	pte_mapped_cache_add(&pte_mapped_cache, page);
+}
+
+static struct pte_mapped_cache *pte_mapped_cache_from_sc(struct shrinker *sh)
+{
+	return container_of(sh, struct pte_mapped_cache, shrinker);
+}
+
+static unsigned long pte_mapped_cache_shrink_count(struct shrinker *shrinker,
+						   struct shrink_control *sc)
+{
+	struct pte_mapped_cache *cache = pte_mapped_cache_from_sc(shrinker);
+	unsigned long count = list_lru_shrink_count(&cache->lru, sc);
+
+	return count ? count : SHRINK_EMPTY;
+}
+
+static enum lru_status pte_mapped_cache_shrink_isolate(struct list_head *item,
+						       struct list_lru_one *lst,
+						       spinlock_t *lock,
+						       void *cb_arg)
+{
+	struct list_head *freeable = cb_arg;
+
+	list_lru_isolate_move(lst, item, freeable);
+
+	return LRU_REMOVED;
+}
+
+static unsigned long pte_mapped_cache_shrink_scan(struct shrinker *shrinker,
+						  struct shrink_control *sc)
+{
+	struct pte_mapped_cache *cache = pte_mapped_cache_from_sc(shrinker);
+	struct list_head *cur, *next;
+	unsigned long isolated;
+	LIST_HEAD(freeable);
+
+	isolated = list_lru_shrink_walk(&cache->lru, sc,
+					pte_mapped_cache_shrink_isolate,
+					&freeable);
+
+	list_for_each_safe(cur, next, &freeable) {
+		struct page *page = list_entry(cur, struct page, lru);
+
+		list_del(cur);
+		__free_pages_ok(page, 0, FPI_NO_PTE_MAP);
+	}
+
+	/* Every item walked gets isolated */
+	sc->nr_scanned += isolated;
+
+	return isolated;
+}
+
+static int __pte_mapped_cache_init(struct pte_mapped_cache *cache)
+{
+	int err;
+
+	err = list_lru_init(&cache->lru);
+	if (err)
+		return err;
+
+	cache->shrinker.count_objects = pte_mapped_cache_shrink_count;
+	cache->shrinker.scan_objects = pte_mapped_cache_shrink_scan;
+	cache->shrinker.seeks = DEFAULT_SEEKS;
+	cache->shrinker.flags = SHRINKER_NUMA_AWARE;
+
+	err = register_shrinker(&cache->shrinker);
+	if (err)
+		goto err_list_lru_destroy;
+
+	return 0;
+
+err_list_lru_destroy:
+	list_lru_destroy(&cache->lru);
+	return err;
+}
+
+void __init pte_mapped_cache_init(void)
+{
+	if (gfp_allowed_mask & __GFP_PTE_MAPPED)
+		return;
+
+	if (!__pte_mapped_cache_init(&pte_mapped_cache))
+		gfp_allowed_mask |= __GFP_PTE_MAPPED;
+}
+#else
+void __init pte_mapped_cache_init(void)
+{
+}
+#endif /* CONFIG_ARCH_WANTS_PTE_MAPPED_CACHE */
+
 /**
  * nr_free_zone_pages - count number of pages beyond high watermark
  * @offset: The zone index of the highest zone
-- 
2.28.0

