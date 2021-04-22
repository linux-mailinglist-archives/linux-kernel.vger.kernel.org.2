Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6CA367F66
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbhDVLQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:16:56 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:40031 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236116AbhDVLQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:16:49 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 7EEA21C3A47
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:16:13 +0100 (IST)
Received: (qmail 15674 invoked from network); 22 Apr 2021 11:16:13 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.248])
  by 81.17.254.9 with ESMTPA; 22 Apr 2021 11:16:13 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 8/9] mm/page_alloc: Avoid conflating IRQs disabled with zone->lock
Date:   Thu, 22 Apr 2021 12:14:40 +0100
Message-Id: <20210422111441.24318-9-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210422111441.24318-1-mgorman@techsingularity.net>
References: <20210422111441.24318-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically when freeing pages, free_one_page() assumed that callers
had IRQs disabled and the zone->lock could be acquired with spin_lock().
This confuses the scope of what local_lock_irq is protecting and what
zone->lock is protecting in free_unref_page_list in particular.

This patch uses spin_lock_irqsave() for the zone->lock in
free_one_page() instead of relying on callers to have disabled
IRQs. free_unref_page_commit() is changed to only deal with PCP pages
protected by the local lock. free_unref_page_list() then first frees
isolated pages to the buddy lists with free_one_page() and frees the rest
of the pages to the PCP via free_unref_page_commit(). The end result
is that free_one_page() is no longer depending on side-effects of
local_lock to be correct.

Note that this may incur a performance penalty while memory hot-remove
is running but that is not a common operation.

[lkp@intel.com: Ensure CMA pages get addded to correct pcp list]
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 75 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c6e8da942905..6dd2ea78eddb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1458,13 +1458,15 @@ static void free_one_page(struct zone *zone,
 				unsigned int order,
 				int migratetype, fpi_t fpi_flags)
 {
-	spin_lock(&zone->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&zone->lock, flags);
 	if (unlikely(has_isolate_pageblock(zone) ||
 		is_migrate_isolate(migratetype))) {
 		migratetype = get_pfnblock_migratetype(page, pfn);
 	}
 	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
 static void __meminit __init_single_page(struct page *page, unsigned long pfn,
@@ -3229,31 +3231,13 @@ static bool free_unref_page_prepare(struct page *page, unsigned long pfn)
 	return true;
 }
 
-static void free_unref_page_commit(struct page *page, unsigned long pfn)
+static void free_unref_page_commit(struct page *page, unsigned long pfn,
+				   int migratetype)
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
-	int migratetype;
 
-	migratetype = get_pcppage_migratetype(page);
 	__count_vm_event(PGFREE);
-
-	/*
-	 * We only track unmovable, reclaimable and movable on pcp lists.
-	 * Free ISOLATE pages back to the allocator because they are being
-	 * offlined but treat HIGHATOMIC as movable pages so we can get those
-	 * areas back if necessary. Otherwise, we may have to free
-	 * excessively into the page allocator
-	 */
-	if (migratetype >= MIGRATE_PCPTYPES) {
-		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(zone, page, pfn, 0, migratetype,
-				      FPI_NONE);
-			return;
-		}
-		migratetype = MIGRATE_MOVABLE;
-	}
-
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	list_add(&page->lru, &pcp->lists[migratetype]);
 	pcp->count++;
@@ -3268,12 +3252,29 @@ void free_unref_page(struct page *page)
 {
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(page);
+	int migratetype;
 
 	if (!free_unref_page_prepare(page, pfn))
 		return;
 
+	/*
+	 * We only track unmovable, reclaimable and movable on pcp lists.
+	 * Place ISOLATE pages on the isolated list because they are being
+	 * offlined but treat HIGHATOMIC as movable pages so we can get those
+	 * areas back if necessary. Otherwise, we may have to free
+	 * excessively into the page allocator
+	 */
+	migratetype = get_pcppage_migratetype(page);
+	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
+		if (unlikely(is_migrate_isolate(migratetype))) {
+			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
+			return;
+		}
+		migratetype = MIGRATE_MOVABLE;
+	}
+
 	local_lock_irqsave(&pagesets.lock, flags);
-	free_unref_page_commit(page, pfn);
+	free_unref_page_commit(page, pfn, migratetype);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
@@ -3285,22 +3286,44 @@ void free_unref_page_list(struct list_head *list)
 	struct page *page, *next;
 	unsigned long flags, pfn;
 	int batch_count = 0;
+	int migratetype;
 
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
 		pfn = page_to_pfn(page);
 		if (!free_unref_page_prepare(page, pfn))
 			list_del(&page->lru);
+
+		/*
+		 * Free isolated pages directly to the allocator, see
+		 * comment in free_unref_page.
+		 */
+		migratetype = get_pcppage_migratetype(page);
+		if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
+			if (unlikely(is_migrate_isolate(migratetype))) {
+				list_del(&page->lru);
+				free_one_page(page_zone(page), page, pfn, 0,
+							migratetype, FPI_NONE);
+				continue;
+			}
+
+			/*
+			 * Non-isolated types over MIGRATE_PCPTYPES get added
+			 * to the MIGRATE_MOVABLE pcp list.
+			 */
+			set_pcppage_migratetype(page, MIGRATE_MOVABLE);
+		}
+
 		set_page_private(page, pfn);
 	}
 
 	local_lock_irqsave(&pagesets.lock, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
-		unsigned long pfn = page_private(page);
-
+		pfn = page_private(page);
 		set_page_private(page, 0);
+		migratetype = get_pcppage_migratetype(page);
 		trace_mm_page_free_batched(page);
-		free_unref_page_commit(page, pfn);
+		free_unref_page_commit(page, pfn, migratetype);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
-- 
2.26.2

