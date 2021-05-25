Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FCB38FC59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhEYIOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:14:09 -0400
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:34351 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231474AbhEYINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:13:25 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id E0622FAB74
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:02:00 +0100 (IST)
Received: (qmail 5713 invoked from network); 25 May 2021 08:02:00 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPA; 25 May 2021 08:02:00 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/6] mm/page_alloc: Adjust pcp->high after CPU hotplug events
Date:   Tue, 25 May 2021 09:01:16 +0100
Message-Id: <20210525080119.5455-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525080119.5455-1-mgorman@techsingularity.net>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCP high watermark is based on the number of online CPUs so the
watermarks must be adjusted during CPU hotplug. At the time of
hot-remove, the number of online CPUs is already adjusted but during
hot-add, a delta needs to be applied to update PCP to the correct
value. After this patch is applied, the high watermarks are adjusted
correctly.

  # grep high: /proc/zoneinfo  | tail -1
              high:  649
  # echo 0 > /sys/devices/system/cpu/cpu4/online
  # grep high: /proc/zoneinfo  | tail -1
              high:  664
  # echo 1 > /sys/devices/system/cpu/cpu4/online
  # grep high: /proc/zoneinfo  | tail -1
              high:  649

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/cpuhotplug.h |  2 +-
 mm/internal.h              |  2 +-
 mm/memory_hotplug.c        |  4 ++--
 mm/page_alloc.c            | 38 +++++++++++++++++++++++++++-----------
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 4a62b3980642..47e13582d9fc 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -54,7 +54,7 @@ enum cpuhp_state {
 	CPUHP_MM_MEMCQ_DEAD,
 	CPUHP_PERCPU_CNT_DEAD,
 	CPUHP_RADIX_DEAD,
-	CPUHP_PAGE_ALLOC_DEAD,
+	CPUHP_PAGE_ALLOC,
 	CPUHP_NET_DEV_DEAD,
 	CPUHP_PCI_XGENE_DEAD,
 	CPUHP_IOMMU_IOVA_DEAD,
diff --git a/mm/internal.h b/mm/internal.h
index 54bd0dc2c23c..651250e59ef5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -221,7 +221,7 @@ extern int user_min_free_kbytes;
 extern void free_unref_page(struct page *page);
 extern void free_unref_page_list(struct list_head *list);
 
-extern void zone_pcp_update(struct zone *zone);
+extern void zone_pcp_update(struct zone *zone, int cpu_online);
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 70620d0dd923..bebb3cead810 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -961,7 +961,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, struct zone *z
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
-	zone_pcp_update(zone);
+	zone_pcp_update(zone, 0);
 
 	/* Basic onlining is complete, allow allocation of onlined pages. */
 	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
@@ -1835,7 +1835,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 		zone_pcp_reset(zone);
 		build_all_zonelists(NULL);
 	} else
-		zone_pcp_update(zone);
+		zone_pcp_update(zone, 0);
 
 	node_states_clear_node(node, &arg);
 	if (arg.status_change_nid >= 0) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c0536e5d088a..dc4ac309bc21 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6628,7 +6628,7 @@ static int zone_batchsize(struct zone *zone)
 #endif
 }
 
-static int zone_highsize(struct zone *zone, int batch)
+static int zone_highsize(struct zone *zone, int batch, int cpu_online)
 {
 #ifdef CONFIG_MMU
 	int high;
@@ -6639,9 +6639,10 @@ static int zone_highsize(struct zone *zone, int batch)
 	 * so that if they are full then background reclaim will not be
 	 * started prematurely. The value is split across all online CPUs
 	 * local to the zone. Note that early in boot that CPUs may not be
-	 * online yet.
+	 * online yet and that during CPU hotplug that the cpumask is not
+	 * yet updated when a CPU is being onlined.
 	 */
-	nr_local_cpus = max(1U, cpumask_weight(cpumask_of_node(zone_to_nid(zone))));
+	nr_local_cpus = max(1U, cpumask_weight(cpumask_of_node(zone_to_nid(zone)))) + cpu_online;
 	high = low_wmark_pages(zone) / nr_local_cpus;
 
 	/*
@@ -6715,12 +6716,12 @@ static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long h
  * Calculate and set new high and batch values for all per-cpu pagesets of a
  * zone based on the zone's size.
  */
-static void zone_set_pageset_high_and_batch(struct zone *zone)
+static void zone_set_pageset_high_and_batch(struct zone *zone, int cpu_online)
 {
 	int new_high, new_batch;
 
 	new_batch = max(1, zone_batchsize(zone));
-	new_high = zone_highsize(zone, new_batch);
+	new_high = zone_highsize(zone, new_batch, cpu_online);
 
 	if (zone->pageset_high == new_high &&
 	    zone->pageset_batch == new_batch)
@@ -6750,7 +6751,7 @@ void __meminit setup_zone_pageset(struct zone *zone)
 		per_cpu_pages_init(pcp, pzstats);
 	}
 
-	zone_set_pageset_high_and_batch(zone);
+	zone_set_pageset_high_and_batch(zone, 0);
 }
 
 /*
@@ -8008,6 +8009,7 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
 
 static int page_alloc_cpu_dead(unsigned int cpu)
 {
+	struct zone *zone;
 
 	lru_add_drain_cpu(cpu);
 	drain_pages(cpu);
@@ -8028,6 +8030,19 @@ static int page_alloc_cpu_dead(unsigned int cpu)
 	 * race with what we are doing.
 	 */
 	cpu_vm_stats_fold(cpu);
+
+	for_each_populated_zone(zone)
+		zone_pcp_update(zone, 0);
+
+	return 0;
+}
+
+static int page_alloc_cpu_online(unsigned int cpu)
+{
+	struct zone *zone;
+
+	for_each_populated_zone(zone)
+		zone_pcp_update(zone, 1);
 	return 0;
 }
 
@@ -8053,8 +8068,9 @@ void __init page_alloc_init(void)
 		hashdist = 0;
 #endif
 
-	ret = cpuhp_setup_state_nocalls(CPUHP_PAGE_ALLOC_DEAD,
-					"mm/page_alloc:dead", NULL,
+	ret = cpuhp_setup_state_nocalls(CPUHP_PAGE_ALLOC,
+					"mm/page_alloc:pcp",
+					page_alloc_cpu_online,
 					page_alloc_cpu_dead);
 	WARN_ON(ret < 0);
 }
@@ -8192,7 +8208,7 @@ static void __setup_per_zone_wmarks(void)
 		 * The watermark size have changed so update the pcpu batch
 		 * and high limits or the limits may be inappropriate.
 		 */
-		zone_set_pageset_high_and_batch(zone);
+		zone_set_pageset_high_and_batch(zone, 0);
 
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
@@ -9014,10 +9030,10 @@ EXPORT_SYMBOL(free_contig_range);
  * The zone indicated has a new number of managed_pages; batch sizes and percpu
  * page high values need to be recalculated.
  */
-void __meminit zone_pcp_update(struct zone *zone)
+void zone_pcp_update(struct zone *zone, int cpu_online)
 {
 	mutex_lock(&pcp_batch_high_lock);
-	zone_set_pageset_high_and_batch(zone);
+	zone_set_pageset_high_and_batch(zone, cpu_online);
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
-- 
2.26.2

