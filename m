Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5B53645C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbhDSOPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:15:18 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:53021 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240246AbhDSOPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:15:14 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id 67DE9F84B7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:14:43 +0100 (IST)
Received: (qmail 12718 invoked from network); 19 Apr 2021 14:14:43 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 19 Apr 2021 14:14:43 -0000
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
Subject: [PATCH 05/10] mm/page_alloc: Batch the accounting updates in the bulk allocator
Date:   Mon, 19 Apr 2021 15:13:36 +0100
Message-Id: <20210419141341.26047-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210419141341.26047-1-mgorman@techsingularity.net>
References: <20210419141341.26047-1-mgorman@techsingularity.net>
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
index c1d2c316ce7d..9bf194d507e7 100644
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
index 9d0f047647e3..cff0f1c98b28 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3411,7 +3411,8 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
  *
  * Must be called with interrupts disabled.
  */
-static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
+static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
+				   long nr_account)
 {
 #ifdef CONFIG_NUMA
 	enum numa_stat_item local_stat = NUMA_LOCAL;
@@ -3424,12 +3425,12 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
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
 
@@ -3475,7 +3476,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
-		zone_statistics(preferred_zone, zone);
+		zone_statistics(preferred_zone, zone, 1);
 	}
 	local_unlock_irqrestore(&pagesets.lock, flags);
 	return page;
@@ -3536,7 +3537,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 				  get_pcppage_migratetype(page));
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
-	zone_statistics(preferred_zone, zone);
+	zone_statistics(preferred_zone, zone, 1);
 	local_irq_restore(flags);
 
 out:
@@ -5019,7 +5020,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
-	int nr_populated = 0;
+	int nr_populated = 0, nr_account = 0;
 
 	if (unlikely(nr_pages <= 0))
 		return 0;
@@ -5092,15 +5093,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
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
@@ -5110,6 +5103,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
+	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
+	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
+
 	local_unlock_irqrestore(&pagesets.lock, flags);
 
 	return nr_populated;
-- 
2.26.2

