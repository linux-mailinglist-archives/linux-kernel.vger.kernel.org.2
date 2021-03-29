Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D08B34CFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 14:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhC2MIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 08:08:16 -0400
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:50934 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231715AbhC2MHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 08:07:51 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id 2B68FBEB72
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 13:07:50 +0100 (IST)
Received: (qmail 20025 invoked from network); 29 Mar 2021 12:07:49 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 29 Mar 2021 12:07:49 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5/6] mm/page_alloc: Batch the accounting updates in the bulk allocator
Date:   Mon, 29 Mar 2021 13:06:47 +0100
Message-Id: <20210329120648.19040-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210329120648.19040-1-mgorman@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the zone_statistics are a simple counter that does not require
special protection, the bulk allocator accounting updates can be
batch updated without requiring IRQs to be disabled.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/vmstat.h |  8 ++++++++
 mm/page_alloc.c        | 30 +++++++++++++-----------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index dde4dec4e7dd..8473b8fa9756 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -246,6 +246,14 @@ __count_numa_event(struct zone *zone, enum numa_stat_item item)
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
 extern void __count_numa_event(struct zone *zone, enum numa_stat_item item);
 extern unsigned long sum_zone_node_page_state(int node,
 					      enum zone_stat_item item);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7eb48632bcac..32c64839c145 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3398,7 +3398,8 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
  *
  * Must be called with interrupts disabled.
  */
-static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
+static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
+				   long nr_account)
 {
 #ifdef CONFIG_NUMA
 	enum numa_stat_item local_stat = NUMA_LOCAL;
@@ -3411,12 +3412,12 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
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
 
@@ -3462,7 +3463,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
-		zone_statistics(preferred_zone, zone);
+		zone_statistics(preferred_zone, zone, 1);
 	}
 	local_unlock_irqrestore(&pagesets.lock, flags);
 	return page;
@@ -3523,7 +3524,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 				  get_pcppage_migratetype(page));
 
 	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
-	zone_statistics(preferred_zone, zone);
+	zone_statistics(preferred_zone, zone, 1);
 	local_irq_restore(flags);
 
 out:
@@ -5006,7 +5007,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags;
-	int nr_populated = 0;
+	int nr_populated = 0, nr_account = 0;
 
 	if (unlikely(nr_pages <= 0))
 		return 0;
@@ -5079,15 +5080,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
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
@@ -5097,6 +5090,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
+	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
+	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
+
 	local_unlock_irqrestore(&pagesets.lock, flags);
 
 	return nr_populated;
-- 
2.26.2

