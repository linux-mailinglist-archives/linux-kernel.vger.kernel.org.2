Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084EC3575F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356113AbhDGU1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:27:07 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:54129 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356262AbhDGU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:26:09 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id F388E15004F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:25:56 +0100 (IST)
Received: (qmail 17364 invoked from network); 7 Apr 2021 20:25:56 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 7 Apr 2021 20:25:56 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 08/11] mm/page_alloc: Remove duplicate checks if migratetype should be isolated
Date:   Wed,  7 Apr 2021 21:24:20 +0100
Message-Id: <20210407202423.16022-9-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210407202423.16022-1-mgorman@techsingularity.net>
References: <20210407202423.16022-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both free_pcppages_bulk() and free_one_page() have very similar
checks about whether a pages migratetype has changed under the
zone lock. Use a common helper.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bd75102ef1e1..1bb5b522a0f9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1354,6 +1354,23 @@ static inline void prefetch_buddy(struct page *page)
 	prefetch(buddy);
 }
 
+/*
+ * The migratetype of a page may have changed due to isolation so check.
+ * Assumes the caller holds the zone->lock to serialise against page
+ * isolation.
+ */
+static inline int
+check_migratetype_isolated(struct zone *zone, struct page *page, unsigned long pfn, int migratetype)
+{
+	/* If isolating, check if the migratetype has changed */
+	if (unlikely(has_isolate_pageblock(zone) ||
+		is_migrate_isolate(migratetype))) {
+		migratetype = get_pfnblock_migratetype(page, pfn);
+	}
+
+	return migratetype;
+}
+
 /*
  * Frees a number of pages from the PCP lists
  * Assumes all pages on list are in same zone, and of same order.
@@ -1371,7 +1388,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	int migratetype = 0;
 	int batch_free = 0;
 	int prefetch_nr = READ_ONCE(pcp->batch);
-	bool isolated_pageblocks;
 	struct page *page, *tmp;
 	LIST_HEAD(head);
 
@@ -1433,21 +1449,20 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
 	 */
 	spin_lock(&zone->lock);
-	isolated_pageblocks = has_isolate_pageblock(zone);
 
 	/*
 	 * Use safe version since after __free_one_page(),
 	 * page->lru.next will not point to original list.
 	 */
 	list_for_each_entry_safe(page, tmp, &head, lru) {
+		unsigned long pfn = page_to_pfn(page);
 		int mt = get_pcppage_migratetype(page);
+
 		/* MIGRATE_ISOLATE page should not go to pcplists */
 		VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
-		/* Pageblock could have been isolated meanwhile */
-		if (unlikely(isolated_pageblocks))
-			mt = get_pageblock_migratetype(page);
 
-		__free_one_page(page, page_to_pfn(page), zone, 0, mt, FPI_NONE);
+		mt = check_migratetype_isolated(zone, page, pfn, mt);
+		__free_one_page(page, pfn, zone, 0, mt, FPI_NONE);
 		trace_mm_page_pcpu_drain(page, 0, mt);
 	}
 	spin_unlock(&zone->lock);
@@ -1459,10 +1474,7 @@ static void free_one_page(struct zone *zone,
 				int migratetype, fpi_t fpi_flags)
 {
 	spin_lock(&zone->lock);
-	if (unlikely(has_isolate_pageblock(zone) ||
-		is_migrate_isolate(migratetype))) {
-		migratetype = get_pfnblock_migratetype(page, pfn);
-	}
+	migratetype = check_migratetype_isolated(zone, page, pfn, migratetype);
 	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
 	spin_unlock(&zone->lock);
 }
-- 
2.26.2

