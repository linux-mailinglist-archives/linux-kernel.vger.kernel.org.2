Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E583399D01
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFCIsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:48:39 -0400
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:48284 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229880AbhFCIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:48:37 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id 63A1ABEC35
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 09:46:52 +0100 (IST)
Received: (qmail 8587 invoked from network); 3 Jun 2021 08:46:52 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 3 Jun 2021 08:46:52 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] mm/page_alloc: Allow high-order pages to be stored on the per-cpu lists
Date:   Thu,  3 Jun 2021 09:46:21 +0100
Message-Id: <20210603084621.24109-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210603084621.24109-1-mgorman@techsingularity.net>
References: <20210603084621.24109-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-cpu page allocator (PCP) only stores order-0 pages. This means
that all THP and "cheap" high-order allocations including SLUB contends
on the zone->lock. This patch extends the PCP allocator to store THP and
"cheap" high-order pages. Note that struct per_cpu_pages increases in
size to 256 bytes (4 cache lines) on x86-64.

Note that this is not necessarily a universal performance win because of
how it is implemented. High-order pages can cause pcp->high to be exceeded
prematurely for lower-orders so for example, a large number of THP pages
being freed could release order-0 pages from the PCP lists. Hence, much
depends on the allocation/free pattern as observed by a single CPU to
determine if caching helps or hurts a particular workload.

That said, basic performance testing passed. The following is a netperf
UDP_STREAM test which hits the relevant patches as some of the network
allocations are high-order.

netperf-udp
                                 5.13.0-rc2             5.13.0-rc2
                           mm-pcpburst-v3r4   mm-pcphighorder-v1r7
Hmean     send-64         261.46 (   0.00%)      266.30 *   1.85%*
Hmean     send-128        516.35 (   0.00%)      536.78 *   3.96%*
Hmean     send-256       1014.13 (   0.00%)     1034.63 *   2.02%*
Hmean     send-1024      3907.65 (   0.00%)     4046.11 *   3.54%*
Hmean     send-2048      7492.93 (   0.00%)     7754.85 *   3.50%*
Hmean     send-3312     11410.04 (   0.00%)    11772.32 *   3.18%*
Hmean     send-4096     13521.95 (   0.00%)    13912.34 *   2.89%*
Hmean     send-8192     21660.50 (   0.00%)    22730.72 *   4.94%*
Hmean     send-16384    31902.32 (   0.00%)    32637.50 *   2.30%*

From a functional point of view, a patch like this is necessary to
make bulk allocation of high-order pages work with similar performance
to order-0 bulk allocations. The bulk allocator is not updated in this
series as it would have to be determined by bulk allocation users how
they want to track the order of pages allocated with the bulk allocator.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h |  20 +++++-
 mm/internal.h          |   2 +-
 mm/page_alloc.c        | 159 +++++++++++++++++++++++++++++------------
 mm/swap.c              |   2 +-
 4 files changed, 135 insertions(+), 48 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0ed61f32d898..1ceaa5f44db6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -333,6 +333,24 @@ enum zone_watermarks {
 	NR_WMARK
 };
 
+/*
+ * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER plus one additional
+ * for pageblock size for THP if configured.
+ */
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define NR_PCP_THP 1
+#else
+#define NR_PCP_THP 0
+#endif
+#define NR_PCP_LISTS (MIGRATE_PCPTYPES * (PAGE_ALLOC_COSTLY_ORDER + 1 + NR_PCP_THP))
+
+/*
+ * Shift to encode migratetype in order in the least significant bits and
+ * migratetype in the higher bits.
+ */
+#define NR_PCP_ORDER_SHIFT 8
+#define NR_PCP_ORDER_MASK ((1<<NR_PCP_ORDER_SHIFT) - 1)
+
 #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
 #define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)
 #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
@@ -349,7 +367,7 @@ struct per_cpu_pages {
 #endif
 
 	/* Lists of pages, one per migrate type stored on the pcp-lists */
-	struct list_head lists[MIGRATE_PCPTYPES];
+	struct list_head lists[NR_PCP_LISTS];
 };
 
 struct per_cpu_zonestat {
diff --git a/mm/internal.h b/mm/internal.h
index 8fd61e344966..4f5c22dd8987 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -203,7 +203,7 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern int user_min_free_kbytes;
 
-extern void free_unref_page(struct page *page);
+extern void free_unref_page(struct page *page, unsigned int order);
 extern void free_unref_page_list(struct list_head *list);
 
 extern void zone_pcp_update(struct zone *zone, int cpu_online);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 99ddac0ffece..ffd2d07060eb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -687,10 +687,53 @@ static void bad_page(struct page *page, const char *reason)
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
 
+static inline unsigned int order_to_pindex(int migratetype, int order)
+{
+	int base = order;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (order > PAGE_ALLOC_COSTLY_ORDER) {
+		VM_BUG_ON(order != pageblock_order);
+		base = PAGE_ALLOC_COSTLY_ORDER + 1;
+	}
+#else
+	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
+#endif
+
+	return (MIGRATE_PCPTYPES * base) + migratetype;
+}
+
+static inline int pindex_to_order(unsigned int pindex)
+{
+	int order = pindex / PAGE_ALLOC_COSTLY_ORDER;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (order > PAGE_ALLOC_COSTLY_ORDER) {
+		order = pageblock_order;
+		VM_BUG_ON(order != pageblock_order);
+	}
+#else
+	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
+#endif
+
+	return order;
+}
+
+static inline bool pcp_allowed_order(unsigned int order)
+{
+	if (order <= PAGE_ALLOC_COSTLY_ORDER)
+		return true;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (order == pageblock_order)
+		return true;
+#endif
+	return false;
+}
+
 static inline void free_the_page(struct page *page, unsigned int order)
 {
-	if (order == 0)		/* Via pcp? */
-		free_unref_page(page);
+	if (pcp_allowed_order(order))		/* Via pcp? */
+		free_unref_page(page, order);
 	else
 		__free_pages_ok(page, order, FPI_NONE);
 }
@@ -713,7 +756,7 @@ static inline void free_the_page(struct page *page, unsigned int order)
 void free_compound_page(struct page *page)
 {
 	mem_cgroup_uncharge(page);
-	__free_pages_ok(page, compound_order(page), FPI_NONE);
+	free_the_page(page, compound_order(page));
 }
 
 void prep_compound_page(struct page *page, unsigned int order)
@@ -1363,9 +1406,9 @@ static __always_inline bool free_pages_prepare(struct page *page,
  * to pcp lists. With debug_pagealloc also enabled, they are also rechecked when
  * moved from pcp lists to free lists.
  */
-static bool free_pcp_prepare(struct page *page)
+static bool free_pcp_prepare(struct page *page, unsigned int order)
 {
-	return free_pages_prepare(page, 0, true, FPI_NONE);
+	return free_pages_prepare(page, order, true, FPI_NONE);
 }
 
 static bool bulkfree_pcp_prepare(struct page *page)
@@ -1382,12 +1425,12 @@ static bool bulkfree_pcp_prepare(struct page *page)
  * debug_pagealloc enabled, they are checked also immediately when being freed
  * to the pcp lists.
  */
-static bool free_pcp_prepare(struct page *page)
+static bool free_pcp_prepare(struct page *page, unsigned int order)
 {
 	if (debug_pagealloc_enabled_static())
-		return free_pages_prepare(page, 0, true, FPI_NONE);
+		return free_pages_prepare(page, order, true, FPI_NONE);
 	else
-		return free_pages_prepare(page, 0, false, FPI_NONE);
+		return free_pages_prepare(page, order, false, FPI_NONE);
 }
 
 static bool bulkfree_pcp_prepare(struct page *page)
@@ -1419,8 +1462,10 @@ static inline void prefetch_buddy(struct page *page)
 static void free_pcppages_bulk(struct zone *zone, int count,
 					struct per_cpu_pages *pcp)
 {
-	int migratetype = 0;
+	int pindex = 0;
 	int batch_free = 0;
+	int nr_freed = 0;
+	unsigned int order;
 	int prefetch_nr = READ_ONCE(pcp->batch);
 	bool isolated_pageblocks;
 	struct page *page, *tmp;
@@ -1431,7 +1476,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	 * below while (list_empty(list)) loop.
 	 */
 	count = min(pcp->count, count);
-	while (count) {
+	while (count > 0) {
 		struct list_head *list;
 
 		/*
@@ -1443,24 +1488,31 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		 */
 		do {
 			batch_free++;
-			if (++migratetype == MIGRATE_PCPTYPES)
-				migratetype = 0;
-			list = &pcp->lists[migratetype];
+			if (++pindex == NR_PCP_LISTS)
+				pindex = 0;
+			list = &pcp->lists[pindex];
 		} while (list_empty(list));
 
 		/* This is the only non-empty list. Free them all. */
-		if (batch_free == MIGRATE_PCPTYPES)
+		if (batch_free == NR_PCP_LISTS)
 			batch_free = count;
 
+		order = pindex_to_order(pindex);
+		BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_SHIFT));
 		do {
 			page = list_last_entry(list, struct page, lru);
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->lru);
-			pcp->count--;
+			nr_freed += 1 << order;
+			count -= 1 << order;
 
 			if (bulkfree_pcp_prepare(page))
 				continue;
 
+			/* Encode order with the migratetype */
+			page->index <<= NR_PCP_ORDER_SHIFT;
+			page->index |= order;
+
 			list_add_tail(&page->lru, &head);
 
 			/*
@@ -1476,8 +1528,9 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 				prefetch_buddy(page);
 				prefetch_nr--;
 			}
-		} while (--count && --batch_free && !list_empty(list));
+		} while (count > 0 && --batch_free && !list_empty(list));
 	}
+	pcp->count -= nr_freed;
 
 	/*
 	 * local_lock_irq held so equivalent to spin_lock_irqsave for
@@ -1492,14 +1545,19 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	 */
 	list_for_each_entry_safe(page, tmp, &head, lru) {
 		int mt = get_pcppage_migratetype(page);
+
+		/* mt has been encoded with the order (see above) */
+		order = mt & NR_PCP_ORDER_MASK;
+		mt >>= NR_PCP_ORDER_SHIFT;
+
 		/* MIGRATE_ISOLATE page should not go to pcplists */
 		VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
 		/* Pageblock could have been isolated meanwhile */
 		if (unlikely(isolated_pageblocks))
 			mt = get_pageblock_migratetype(page);
 
-		__free_one_page(page, page_to_pfn(page), zone, 0, mt, FPI_NONE);
-		trace_mm_page_pcpu_drain(page, 0, mt);
+		__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
+		trace_mm_page_pcpu_drain(page, order, mt);
 	}
 	spin_unlock(&zone->lock);
 }
@@ -3276,11 +3334,12 @@ void mark_free_pages(struct zone *zone)
 }
 #endif /* CONFIG_PM */
 
-static bool free_unref_page_prepare(struct page *page, unsigned long pfn)
+static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
+							unsigned int order)
 {
 	int migratetype;
 
-	if (!free_pcp_prepare(page))
+	if (!free_pcp_prepare(page, order))
 		return false;
 
 	migratetype = get_pfnblock_migratetype(page, pfn);
@@ -3330,16 +3389,18 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
 }
 
 static void free_unref_page_commit(struct page *page, unsigned long pfn,
-				   int migratetype)
+				   int migratetype, unsigned int order)
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
 	int high;
+	int pindex;
 
 	__count_vm_event(PGFREE);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	list_add(&page->lru, &pcp->lists[migratetype]);
-	pcp->count++;
+	pindex = order_to_pindex(migratetype, order);
+	list_add(&page->lru, &pcp->lists[pindex]);
+	pcp->count += 1 << order;
 	high = nr_pcp_high(pcp, zone);
 	if (pcp->count >= high) {
 		int batch = READ_ONCE(pcp->batch);
@@ -3349,15 +3410,15 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
 }
 
 /*
- * Free a 0-order page
+ * Free a pcp page
  */
-void free_unref_page(struct page *page)
+void free_unref_page(struct page *page, unsigned int order)
 {
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
 
-	if (!free_unref_page_prepare(page, pfn))
+	if (!free_unref_page_prepare(page, pfn, order))
 		return;
 
 	/*
@@ -3370,14 +3431,14 @@ void free_unref_page(struct page *page)
 	migratetype = get_pcppage_migratetype(page);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
+			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
 			return;
 		}
 		migratetype = MIGRATE_MOVABLE;
 	}
 
 	local_lock_irqsave(&pagesets.lock, flags);
-	free_unref_page_commit(page, pfn, migratetype);
+	free_unref_page_commit(page, pfn, migratetype, order);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
@@ -3394,7 +3455,7 @@ void free_unref_page_list(struct list_head *list)
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
 		pfn = page_to_pfn(page);
-		if (!free_unref_page_prepare(page, pfn))
+		if (!free_unref_page_prepare(page, pfn, 0))
 			list_del(&page->lru);
 
 		/*
@@ -3426,7 +3487,7 @@ void free_unref_page_list(struct list_head *list)
 		set_page_private(page, 0);
 		migratetype = get_pcppage_migratetype(page);
 		trace_mm_page_free_batched(page);
-		free_unref_page_commit(page, pfn, migratetype);
+		free_unref_page_commit(page, pfn, migratetype, 0);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
@@ -3562,7 +3623,8 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
 
 /* Remove page from the per-cpu list, caller must protect the list */
 static inline
-struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
+struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
+			int migratetype,
 			unsigned int alloc_flags,
 			struct per_cpu_pages *pcp,
 			struct list_head *list)
@@ -3571,16 +3633,22 @@ struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
 
 	do {
 		if (list_empty(list)) {
-			pcp->count += rmqueue_bulk(zone, 0,
-					READ_ONCE(pcp->batch), list,
+			int batch = READ_ONCE(pcp->batch);
+			int alloced;
+
+			batch = max(batch >> order, 2);
+			alloced = rmqueue_bulk(zone, order,
+					batch, list,
 					migratetype, alloc_flags);
+
+			pcp->count += alloced << order;
 			if (unlikely(list_empty(list)))
 				return NULL;
 		}
 
 		page = list_first_entry(list, struct page, lru);
 		list_del(&page->lru);
-		pcp->count--;
+		pcp->count -= 1 << order;
 	} while (check_new_pcp(page));
 
 	return page;
@@ -3588,8 +3656,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
 
 /* Lock and remove page from the per-cpu list */
 static struct page *rmqueue_pcplist(struct zone *preferred_zone,
-			struct zone *zone, gfp_t gfp_flags,
-			int migratetype, unsigned int alloc_flags)
+			struct zone *zone, unsigned int order,
+			gfp_t gfp_flags, int migratetype,
+			unsigned int alloc_flags)
 {
 	struct per_cpu_pages *pcp;
 	struct list_head *list;
@@ -3605,8 +3674,8 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	 */
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp->free_factor >>= 1;
-	list = &pcp->lists[migratetype];
-	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
+	list = &pcp->lists[order_to_pindex(migratetype, order)];
+	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
@@ -3627,15 +3696,15 @@ struct page *rmqueue(struct zone *preferred_zone,
 	unsigned long flags;
 	struct page *page;
 
-	if (likely(order == 0)) {
+	if (likely(pcp_allowed_order(order))) {
 		/*
 		 * MIGRATE_MOVABLE pcplist could have the pages on CMA area and
 		 * we need to skip it when CMA area isn't allowed.
 		 */
 		if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
 				migratetype != MIGRATE_MOVABLE) {
-			page = rmqueue_pcplist(preferred_zone, zone, gfp_flags,
-					migratetype, alloc_flags);
+			page = rmqueue_pcplist(preferred_zone, zone, order,
+					gfp_flags, migratetype, alloc_flags);
 			goto out;
 		}
 	}
@@ -5220,7 +5289,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		page = __rmqueue_pcplist(zone, ac.migratetype, alloc_flags,
+		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
 								pcp, pcp_list);
 		if (unlikely(!page)) {
 			/* Try and get at least one page */
@@ -6766,13 +6835,13 @@ static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
 
 static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonestat *pzstats)
 {
-	int migratetype;
+	int pindex;
 
 	memset(pcp, 0, sizeof(*pcp));
 	memset(pzstats, 0, sizeof(*pzstats));
 
-	for (migratetype = 0; migratetype < MIGRATE_PCPTYPES; migratetype++)
-		INIT_LIST_HEAD(&pcp->lists[migratetype]);
+	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++)
+		INIT_LIST_HEAD(&pcp->lists[pindex]);
 
 	/*
 	 * Set batch and high values safe for a boot pageset. A true percpu
diff --git a/mm/swap.c b/mm/swap.c
index 1958d5feb148..19600430e536 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -95,7 +95,7 @@ static void __put_single_page(struct page *page)
 {
 	__page_cache_release(page);
 	mem_cgroup_uncharge(page);
-	free_unref_page(page);
+	free_unref_page(page, 0);
 }
 
 static void __put_compound_page(struct page *page)
-- 
2.26.2

