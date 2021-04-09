Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD980359E63
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhDIMKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:10:14 -0400
Received: from outbound-smtp54.blacknight.com ([46.22.136.238]:42267 "EHLO
        outbound-smtp54.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233572AbhDIMKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:10:12 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp54.blacknight.com (Postfix) with ESMTPS id 384ABFABF7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 13:09:59 +0100 (IST)
Received: (qmail 12263 invoked from network); 9 Apr 2021 12:09:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Apr 2021 12:09:59 -0000
Date:   Fri, 9 Apr 2021 13:09:57 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm/memory_hotplug: Make unpopulated zones PCP structures
 unreachable during hot remove
Message-ID: <20210409120957.GM3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zone_pcp_reset allegedly protects against a race with drain_pages
using local_irq_save but this is bogus. local_irq_save only operates
on the local CPU. If memory hotplug is running on CPU A and drain_pages
is running on CPU B, disabling IRQs on CPU A does not affect CPU B and
offers no protection.

This patch reorders memory hotremove such that the PCP structures
relevant to the zone are no longer reachable by the time the structures
are freed.  With this reordering, no protection is required to prevent
a use-after-free and the IRQs can be left enabled. zone_pcp_reset is
renamed to zone_pcp_destroy to make it clear that the per-cpu structures
are deleted when the function returns.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/internal.h       |  2 +-
 mm/memory_hotplug.c | 10 +++++++---
 mm/page_alloc.c     | 22 ++++++++++++++++------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 09adf152a10b..cc34ce4461b7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -203,7 +203,7 @@ extern void free_unref_page(struct page *page);
 extern void free_unref_page_list(struct list_head *list);
 
 extern void zone_pcp_update(struct zone *zone);
-extern void zone_pcp_reset(struct zone *zone);
+extern void zone_pcp_destroy(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0cdbbfbc5757..3d059c9f9c2d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1687,12 +1687,16 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-	zone_pcp_enable(zone);
-
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
 	zone->present_pages -= nr_pages;
 
+	/*
+	 * Restore PCP after managed pages has been updated. Unpopulated
+	 * zones PCP structures will remain unusable.
+	 */
+	zone_pcp_enable(zone);
+
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
 	zone->zone_pgdat->node_present_pages -= nr_pages;
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
@@ -1700,8 +1704,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	init_per_zone_wmark_min();
 
 	if (!populated_zone(zone)) {
-		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
+		zone_pcp_destroy(zone);
 	} else
 		zone_pcp_update(zone);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5e8aedb64b57..d6c3db853552 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8946,18 +8946,29 @@ void zone_pcp_disable(struct zone *zone)
 
 void zone_pcp_enable(struct zone *zone)
 {
-	__zone_set_pageset_high_and_batch(zone, zone->pageset_high, zone->pageset_batch);
+	/*
+	 * If the zone is populated, restore the high and batch counts.
+	 * If unpopulated, leave the high and batch count as 0 and 1
+	 * respectively as done by zone_pcp_disable. The per-cpu
+	 * structures will later be freed by zone_pcp_destroy.
+	 */
+	if (populated_zone(zone))
+		__zone_set_pageset_high_and_batch(zone, zone->pageset_high, zone->pageset_batch);
+
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
-void zone_pcp_reset(struct zone *zone)
+/*
+ * Called when a zone has been hot-removed. At this point, the PCP has been
+ * drained, disabled and the zone is removed from the zonelists so the
+ * structures are no longer in use. PCP was disabled/drained by
+ * zone_pcp_disable. This function will drain any remaining vmstat deltas.
+ */
+void zone_pcp_destroy(struct zone *zone)
 {
-	unsigned long flags;
 	int cpu;
 	struct per_cpu_pageset *pset;
 
-	/* avoid races with drain_pages()  */
-	local_irq_save(flags);
 	if (zone->pageset != &boot_pageset) {
 		for_each_online_cpu(cpu) {
 			pset = per_cpu_ptr(zone->pageset, cpu);
@@ -8966,7 +8977,6 @@ void zone_pcp_reset(struct zone *zone)
 		free_percpu(zone->pageset);
 		zone->pageset = &boot_pageset;
 	}
-	local_irq_restore(flags);
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
