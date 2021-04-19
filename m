Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BCE3645CB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbhDSOQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:16:10 -0400
Received: from outbound-smtp54.blacknight.com ([46.22.136.238]:49209 "EHLO
        outbound-smtp54.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238976AbhDSOQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:16:08 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp54.blacknight.com (Postfix) with ESMTPS id 63B3BFAE2E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:15:34 +0100 (IST)
Received: (qmail 16842 invoked from network); 19 Apr 2021 14:15:34 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 19 Apr 2021 14:15:34 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 10/10] mm/page_alloc: Embed per_cpu_pages locking within the per-cpu structure
Date:   Mon, 19 Apr 2021 15:13:41 +0100
Message-Id: <20210419141341.26047-11-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210419141341.26047-1-mgorman@techsingularity.net>
References: <20210419141341.26047-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct per_cpu_pages is protected by the pagesets lock but it can be
embedded within struct per_cpu_pages at a minor cost. This is possible
because per-cpu lookups are based on offsets. Paraphrasing an explanation
from Peter Ziljstra

  The whole thing relies on:

    &per_cpu_ptr(msblk->stream, cpu)->lock == per_cpu_ptr(&msblk->stream->lock, cpu)

  Which is true because the lhs:

    (local_lock_t *)((zone->per_cpu_pages + per_cpu_offset(cpu)) + offsetof(struct per_cpu_pages, lock))

  and the rhs:

    (local_lock_t *)((zone->per_cpu_pages + offsetof(struct per_cpu_pages, lock)) + per_cpu_offset(cpu))

  are identical, because addition is associative.

More details are included in mmzone.h. This embedding is not completely
free for three reasons.

1. As local_lock does not return a per-cpu structure, the PCP has to
   be looked up twice -- first to acquire the lock and again to get the
   PCP pointer.

2. For PREEMPT_RT and CONFIG_DEBUG_LOCK_ALLOC, local_lock is potentially
   a spinlock or has lock-specific tracking. In both cases, it becomes
   necessary to release/acquire different locks when freeing a list of
   pages in free_unref_page_list.

3. For most kernel configurations, local_lock_t is empty and no storage is
   required. By embedding the lock, the memory consumption on PREEMPT_RT
   and CONFIG_DEBUG_LOCK_ALLOC is higher.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h | 31 ++++++++++++++++-
 mm/page_alloc.c        | 78 +++++++++++++++++++++++++++---------------
 2 files changed, 81 insertions(+), 28 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d3b8889b76ab..a1f458f939db 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -338,8 +338,37 @@ enum zone_watermarks {
 #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
 #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
 
-/* Fields and list protected by pagesets local_lock in page_alloc.c */
+/*
+ * struct per_cpu_pages is a per-cpu structure protected by a lock
+ * embedded within the structure. This is subtle because ordinarily
+ * that would imply the PCP structure must first be located when
+ * the task is not yet pinned to the CPU e.g.
+ *
+ *   migrate_disable();
+ *   pcp = this_cpu_ptr(zone->per_cpu_pageset);
+ *   local_lock_irqsave(&pcp->lock, flags);
+ *
+ * However, because per-cpu addresses are calculated based on offsets,
+ * the following is true
+ *
+ *   &per_cpu_ptr(zone->per_cpu_pageset, cpu)->lock == per_cpu_ptr(&zone->per_cpu_pageset->lock, cpu)
+ *
+ * This is true because the LHS is
+ *
+ *   (local_lock_t *)((zone->per_cpu_pageset + per_cpu_offset(cpu)) + offsetof(struct per_cpu_pageset, lock))
+ *
+ * while the RHS is
+ *
+ *   (local_lock_t *)((zone->per_cpu_pageset + offsetof(struct per_cpu_pageset, lock)) + per_cpu_offset(cpu))
+ *
+ * local_lock will first disable preempt, migration or IRQs depending on
+ * the kernel configuration prior to the per_cpu_offset is calculated.
+ * Hence, the following is safe for both PREEMPT_RT and !PREEMPT_RT.
+ *
+ *   local_lock_irqsave(&zone->per_cpu_pageset->lock, flags);
+ */
 struct per_cpu_pages {
+	local_lock_t lock;
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 44a5eb067b38..52ce688b6c73 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -112,13 +112,6 @@ typedef int __bitwise fpi_t;
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_FRACTION	(8)
 
-struct pagesets {
-	local_lock_t lock;
-};
-static DEFINE_PER_CPU(struct pagesets, pagesets) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-};
-
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -2985,12 +2978,12 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 	unsigned long flags;
 	int to_drain, batch;
 
-	local_lock_irqsave(&pagesets.lock, flags);
+	local_lock_irqsave(&pcp->lock, flags);
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0)
 		free_pcppages_bulk(zone, to_drain, pcp);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	local_unlock_irqrestore(&pcp->lock, flags);
 }
 #endif
 
@@ -3006,13 +2999,13 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 	unsigned long flags;
 	struct per_cpu_pages *pcp;
 
-	local_lock_irqsave(&pagesets.lock, flags);
+	local_lock_irqsave(&zone->per_cpu_pageset->lock, flags);
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	if (pcp->count)
 		free_pcppages_bulk(zone, pcp->count, pcp);
 
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	local_unlock_irqrestore(&zone->per_cpu_pageset->lock, flags);
 }
 
 /*
@@ -3232,10 +3225,9 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn)
 	return true;
 }
 
-static void free_unref_page_commit(struct page *page, unsigned long pfn,
-				   int migratetype)
+static void free_unref_page_commit(struct page *page, struct zone *zone,
+				   unsigned long pfn, int migratetype)
 {
-	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
 
 	__count_vm_event(PGFREE);
@@ -3251,6 +3243,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
  */
 void free_unref_page(struct page *page)
 {
+	struct zone *zone;
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
@@ -3274,9 +3267,10 @@ void free_unref_page(struct page *page)
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	local_lock_irqsave(&pagesets.lock, flags);
-	free_unref_page_commit(page, pfn, migratetype);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	zone = page_zone(page);
+	local_lock_irqsave(&zone->per_cpu_pageset->lock, flags);
+	free_unref_page_commit(page, zone, pfn, migratetype);
+	local_unlock_irqrestore(&zone->per_cpu_pageset->lock, flags);
 }
 
 /*
@@ -3284,11 +3278,15 @@ void free_unref_page(struct page *page)
  */
 void free_unref_page_list(struct list_head *list)
 {
+	struct zone *locked_zone;
 	struct page *page, *next;
 	unsigned long flags, pfn;
 	int batch_count = 0;
 	int migratetype;
 
+	if (list_empty(list))
+		return;
+
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
 		pfn = page_to_pfn(page);
@@ -3311,25 +3309,49 @@ void free_unref_page_list(struct list_head *list)
 		set_page_private(page, pfn);
 	}
 
-	local_lock_irqsave(&pagesets.lock, flags);
+	/* Acquire the lock required for the first page. */
+	page = list_first_entry(list, struct page, lru);
+	locked_zone = page_zone(page);
+	local_lock_irqsave(&locked_zone->per_cpu_pageset->lock, flags);
+
 	list_for_each_entry_safe(page, next, list, lru) {
+		struct zone *zone = page_zone(page);
 		pfn = page_private(page);
 		set_page_private(page, 0);
 		migratetype = get_pcppage_migratetype(page);
 		trace_mm_page_free_batched(page);
-		free_unref_page_commit(page, pfn, migratetype);
+
+		/*
+		 * Switch locks if the zone changes.
+		 *
+		 * It is only necessary to do this for PREEMPT_RT and
+		 * DEBUG_LOCK_ALLOC. For !PREEMPT_RT, switching zones just
+		 * enables local IRQs and disables them again which is
+		 * unnecessary. On PREEMPT_RT, local_lock may be a spinlock
+		 * so switching is required. For DEBUG_LOCK_ALLOC, the
+		 * lock dependencies should be properly checked.
+		 */
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_DEBUG_LOCK_ALLOC)
+		if (locked_zone != zone) {
+			local_unlock_irqrestore(&locked_zone->per_cpu_pageset->lock, flags);
+			local_lock_irqsave(&zone->per_cpu_pageset->lock, flags);
+			locked_zone = zone;
+		}
+#endif
+
+		free_unref_page_commit(page, zone, pfn, migratetype);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
 		 * a large list of pages to free.
 		 */
 		if (++batch_count == SWAP_CLUSTER_MAX) {
-			local_unlock_irqrestore(&pagesets.lock, flags);
+			local_unlock_irqrestore(&locked_zone->per_cpu_pageset->lock, flags);
 			batch_count = 0;
-			local_lock_irqsave(&pagesets.lock, flags);
+			local_lock_irqsave(&locked_zone->per_cpu_pageset->lock, flags);
 		}
 	}
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	local_unlock_irqrestore(&locked_zone->per_cpu_pageset->lock, flags);
 }
 
 /*
@@ -3487,11 +3509,11 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct page *page;
 	unsigned long flags;
 
-	local_lock_irqsave(&pagesets.lock, flags);
+	local_lock_irqsave(&zone->per_cpu_pageset->lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list = &pcp->lists[migratetype];
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	local_unlock_irqrestore(&zone->per_cpu_pageset->lock, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone, 1);
@@ -5090,7 +5112,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto failed;
 
 	/* Attempt the batch allocation */
-	local_lock_irqsave(&pagesets.lock, flags);
+	local_lock_irqsave(&zone->per_cpu_pageset->lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp_list = &pcp->lists[ac.migratetype];
 
@@ -5120,7 +5142,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	local_unlock_irqrestore(&zone->per_cpu_pageset->lock, flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
@@ -5128,7 +5150,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	return nr_populated;
 
 failed_irq:
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	local_unlock_irqrestore(&zone->per_cpu_pageset->lock, flags);
 
 failed:
 	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);
@@ -6616,6 +6638,8 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	memset(pcp, 0, sizeof(*pcp));
 	memset(pzstats, 0, sizeof(*pzstats));
 
+	local_lock_init(&pcp->lock);
+
 	for (migratetype = 0; migratetype < MIGRATE_PCPTYPES; migratetype++)
 		INIT_LIST_HEAD(&pcp->lists[migratetype]);
 
-- 
2.26.2

