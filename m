Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4720437B9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhELJ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:57:16 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:60347 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230347AbhELJ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:57:13 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 6B729BEBD4
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 10:56:01 +0100 (IST)
Received: (qmail 28746 invoked from network); 12 May 2021 09:56:01 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 12 May 2021 09:56:01 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5/9] mm/page_alloc: Batch the accounting updates in the bulk allocator
Date:   Wed, 12 May 2021 10:54:54 +0100
Message-Id: <20210512095458.30632-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210512095458.30632-1-mgorman@techsingularity.net>
References: <20210512095458.30632-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the zone_statistics are simple counters that do not require
special protection, the bulk allocator accounting updates can be batch
updated without adding too much complexity with protected RMW updates or
using xchg.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/vmstat.h |  8 ++++++++
 mm/page_alloc.c        | 30 +++++++++++++-----------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index fe32a2210e73..d6a6cf53b127 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -247,6 +247,14 @@ __count_numa_event(struct zone *zone, enum numa_stat_item item)
 	raw_cpu_inc(pzstats->vm_numa_event[item]);
 }
 
+static inline void
+__count_numa_events(struct zone *zone, enum numa_stat_item item, long delta)
+{
+	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
+
+	raw_cpu_add(pzstats->vm_numa_event[item], delta);
+}
+
 extern unsigned long sum_zone_node_page_state(int node,
 					      enum zone_stat_item item);
 extern unsigned long sum_zone_numa_event_state(int node, enum numa_stat_item item);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eb1df4e3c956..7970efa142b0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3456,7 +3456,8 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
  *
  * Must be called with interrupts disabled.
  */
-static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
+static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
+				   long nr_account)
 {
 #ifdef CONFIG_NUMA
 	enum numa_stat_item local_stat = NUMA_LOCAL;
@@ -3469,12 +3470,12 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
 		local_stat = NUMA_OTHER;
 
 	if (zone_to_nid(z) == zone_to_nid(preferred_zone))
-		__count_numa_event(z, NUMA_HIT);
+		__count_numa_events(z, NUMA_HIT, nr_account);
 	else {
-		__count_numa_event(z, NUMA_MISS);
-		__count_numa_event(preferred_zone, NUMA_FOREIGN);
+		__count_numa_events(z, NUMA_MISS, nr_account);
+		__count_numa_events(preferred_zone, NUMA_FOREIGN, nr_account);
 	}
-	__count_numa_event(z, local_stat);
+	__count_numa_events(z, local_stat, nr_account);
 #endif
 }
 
@@ -3520,7 +3521,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
-		zone_statistics(preferred_zone, zone);
+		zone_statistics(preferred_zone, zone, 1);
 	}
 	local_unlock_irqrestore(&pagesets.lock, flags);
 	return page;
@@ -3581,7 +3582,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 				  get_pcppage_migratetype(page));
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
-	zone_statistics(preferred_zone, zone);
+	zone_statistics(preferred_zone, zone, 1);
 	local_irq_restore(flags);
 
 out:
@@ -5063,7 +5064,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
-	int nr_populated = 0;
+	int nr_populated = 0, nr_account = 0;
 
 	if (unlikely(nr_pages <= 0))
 		return 0;
@@ -5136,15 +5137,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 				goto failed_irq;
 			break;
 		}
-
-		/*
-		 * Ideally this would be batched but the best way to do
-		 * that cheaply is to first convert zone_statistics to
-		 * be inaccurate per-cpu counter like vm_events to avoid
-		 * a RMW cycle then do the accounting with IRQs enabled.
-		 */
-		__count_zid_vm_events(PGALLOC, zone_idx(zone), 1);
-		zone_statistics(ac.preferred_zoneref->zone, zone);
+		nr_account++;
 
 		prep_new_page(page, 0, gfp, 0);
 		if (page_list)
@@ -5154,6 +5147,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
+	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
+	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
+
 	local_unlock_irqrestore(&pagesets.lock, flags);
 
 	return nr_populated;
-- 
2.26.2

