Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800003645BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhDSOPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:15:01 -0400
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:56429 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240956AbhDSOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:14:55 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id 096F5198E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 15:14:23 +0100 (IST)
Received: (qmail 11146 invoked from network); 19 Apr 2021 14:14:22 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 19 Apr 2021 14:14:22 -0000
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
Subject: [PATCH 03/10] mm/vmstat: Convert NUMA statistics to basic NUMA counters
Date:   Mon, 19 Apr 2021 15:13:34 +0100
Message-Id: <20210419141341.26047-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210419141341.26047-1-mgorman@techsingularity.net>
References: <20210419141341.26047-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA statistics are maintained on the zone level for hits, misses, foreign
etc but nothing relies on them being perfectly accurate for functional
correctness. The counters are used by userspace to get a general overview
of a workloads NUMA behaviour but the page allocator incurs a high cost to
maintain perfect accuracy similar to what is required for a vmstat like
NR_FREE_PAGES. There even is a sysctl vm.numa_stat to allow userspace to
turn off the collection of NUMA statistics like NUMA_HIT.

This patch converts NUMA_HIT and friends to be NUMA events with similar
accuracy to VM events. There is a possibility that slight errors will be
introduced but the overall trend as seen by userspace will be similar.
The counters are no longer updated from vmstat_refresh context as it is
unnecessary overhead for counters that may never be read by userspace.
Note that counters could be maintained at the node level to save space
but it would have a user-visible impact due to /proc/zoneinfo.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 drivers/base/node.c    |  18 ++--
 include/linux/mmzone.h |  13 ++-
 include/linux/vmstat.h |  43 +++++-----
 mm/mempolicy.c         |   2 +-
 mm/page_alloc.c        |  12 +--
 mm/vmstat.c            | 184 +++++++++++++++--------------------------
 6 files changed, 113 insertions(+), 159 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index f449dbb2c746..443a609db428 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -484,6 +484,7 @@ static DEVICE_ATTR(meminfo, 0444, node_read_meminfo, NULL);
 static ssize_t node_read_numastat(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
+	fold_vm_numa_events();
 	return sysfs_emit(buf,
 			  "numa_hit %lu\n"
 			  "numa_miss %lu\n"
@@ -491,12 +492,12 @@ static ssize_t node_read_numastat(struct device *dev,
 			  "interleave_hit %lu\n"
 			  "local_node %lu\n"
 			  "other_node %lu\n",
-			  sum_zone_numa_state(dev->id, NUMA_HIT),
-			  sum_zone_numa_state(dev->id, NUMA_MISS),
-			  sum_zone_numa_state(dev->id, NUMA_FOREIGN),
-			  sum_zone_numa_state(dev->id, NUMA_INTERLEAVE_HIT),
-			  sum_zone_numa_state(dev->id, NUMA_LOCAL),
-			  sum_zone_numa_state(dev->id, NUMA_OTHER));
+			  sum_zone_numa_event_state(dev->id, NUMA_HIT),
+			  sum_zone_numa_event_state(dev->id, NUMA_MISS),
+			  sum_zone_numa_event_state(dev->id, NUMA_FOREIGN),
+			  sum_zone_numa_event_state(dev->id, NUMA_INTERLEAVE_HIT),
+			  sum_zone_numa_event_state(dev->id, NUMA_LOCAL),
+			  sum_zone_numa_event_state(dev->id, NUMA_OTHER));
 }
 static DEVICE_ATTR(numastat, 0444, node_read_numastat, NULL);
 
@@ -514,10 +515,11 @@ static ssize_t node_read_vmstat(struct device *dev,
 				     sum_zone_node_page_state(nid, i));
 
 #ifdef CONFIG_NUMA
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
+	fold_vm_numa_events();
+	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++)
 		len += sysfs_emit_at(buf, len, "%s %lu\n",
 				     numa_stat_name(i),
-				     sum_zone_numa_state(nid, i));
+				     sum_zone_numa_event_state(nid, i));
 
 #endif
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 106da8fbc72a..d3b8889b76ab 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -135,10 +135,10 @@ enum numa_stat_item {
 	NUMA_INTERLEAVE_HIT,	/* interleaver preferred this zone */
 	NUMA_LOCAL,		/* allocation from local node */
 	NUMA_OTHER,		/* allocation from other node */
-	NR_VM_NUMA_STAT_ITEMS
+	NR_VM_NUMA_EVENT_ITEMS
 };
 #else
-#define NR_VM_NUMA_STAT_ITEMS 0
+#define NR_VM_NUMA_EVENT_ITEMS 0
 #endif
 
 enum zone_stat_item {
@@ -357,7 +357,12 @@ struct per_cpu_zonestat {
 	s8 stat_threshold;
 #endif
 #ifdef CONFIG_NUMA
-	u16 vm_numa_stat_diff[NR_VM_NUMA_STAT_ITEMS];
+	/*
+	 * Low priority inaccurate counters that are only folded
+	 * on demand. Use a large type to avoid the overhead of
+	 * folding during refresh_cpu_vm_stats.
+	 */
+	unsigned long vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
 #endif
 };
 
@@ -609,7 +614,7 @@ struct zone {
 	ZONE_PADDING(_pad3_)
 	/* Zone statistics */
 	atomic_long_t		vm_stat[NR_VM_ZONE_STAT_ITEMS];
-	atomic_long_t		vm_numa_stat[NR_VM_NUMA_STAT_ITEMS];
+	atomic_long_t		vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
 } ____cacheline_internodealigned_in_smp;
 
 enum pgdat_flags {
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 1736ea9d24a7..b120c58cae82 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -138,34 +138,27 @@ static inline void vm_events_fold_cpu(int cpu)
  * Zone and node-based page accounting with per cpu differentials.
  */
 extern atomic_long_t vm_zone_stat[NR_VM_ZONE_STAT_ITEMS];
-extern atomic_long_t vm_numa_stat[NR_VM_NUMA_STAT_ITEMS];
 extern atomic_long_t vm_node_stat[NR_VM_NODE_STAT_ITEMS];
+extern atomic_long_t vm_numa_event[NR_VM_NUMA_EVENT_ITEMS];
 
 #ifdef CONFIG_NUMA
-static inline void zone_numa_state_add(long x, struct zone *zone,
-				 enum numa_stat_item item)
+static inline void zone_numa_event_add(long x, struct zone *zone,
+				enum numa_stat_item item)
 {
-	atomic_long_add(x, &zone->vm_numa_stat[item]);
-	atomic_long_add(x, &vm_numa_stat[item]);
+	atomic_long_add(x, &zone->vm_numa_event[item]);
+	atomic_long_add(x, &vm_numa_event[item]);
 }
 
-static inline unsigned long global_numa_state(enum numa_stat_item item)
+static inline unsigned long zone_numa_event_state(struct zone *zone,
+					enum numa_stat_item item)
 {
-	long x = atomic_long_read(&vm_numa_stat[item]);
-
-	return x;
+	return atomic_long_read(&zone->vm_numa_event[item]);
 }
 
-static inline unsigned long zone_numa_state_snapshot(struct zone *zone,
-					enum numa_stat_item item)
+static inline unsigned long
+global_numa_event_state(enum numa_stat_item item)
 {
-	long x = atomic_long_read(&zone->vm_numa_stat[item]);
-	int cpu;
-
-	for_each_online_cpu(cpu)
-		x += per_cpu_ptr(zone->per_cpu_zonestats, cpu)->vm_numa_stat_diff[item];
-
-	return x;
+	return atomic_long_read(&vm_numa_event[item]);
 }
 #endif /* CONFIG_NUMA */
 
@@ -245,18 +238,22 @@ static inline unsigned long zone_page_state_snapshot(struct zone *zone,
 }
 
 #ifdef CONFIG_NUMA
-extern void __inc_numa_state(struct zone *zone, enum numa_stat_item item);
+extern void __count_numa_event(struct zone *zone, enum numa_stat_item item);
 extern unsigned long sum_zone_node_page_state(int node,
 					      enum zone_stat_item item);
-extern unsigned long sum_zone_numa_state(int node, enum numa_stat_item item);
+extern unsigned long sum_zone_numa_event_state(int node, enum numa_stat_item item);
 extern unsigned long node_page_state(struct pglist_data *pgdat,
 						enum node_stat_item item);
 extern unsigned long node_page_state_pages(struct pglist_data *pgdat,
 					   enum node_stat_item item);
+extern void fold_vm_numa_events(void);
 #else
 #define sum_zone_node_page_state(node, item) global_zone_page_state(item)
 #define node_page_state(node, item) global_node_page_state(item)
 #define node_page_state_pages(node, item) global_node_page_state_pages(item)
+static inline void fold_vm_numa_events(void)
+{
+}
 #endif /* CONFIG_NUMA */
 
 #ifdef CONFIG_SMP
@@ -428,7 +425,7 @@ static inline const char *numa_stat_name(enum numa_stat_item item)
 static inline const char *node_stat_name(enum node_stat_item item)
 {
 	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
-			   NR_VM_NUMA_STAT_ITEMS +
+			   NR_VM_NUMA_EVENT_ITEMS +
 			   item];
 }
 
@@ -440,7 +437,7 @@ static inline const char *lru_list_name(enum lru_list lru)
 static inline const char *writeback_stat_name(enum writeback_stat_item item)
 {
 	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
-			   NR_VM_NUMA_STAT_ITEMS +
+			   NR_VM_NUMA_EVENT_ITEMS +
 			   NR_VM_NODE_STAT_ITEMS +
 			   item];
 }
@@ -449,7 +446,7 @@ static inline const char *writeback_stat_name(enum writeback_stat_item item)
 static inline const char *vm_event_name(enum vm_event_item item)
 {
 	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
-			   NR_VM_NUMA_STAT_ITEMS +
+			   NR_VM_NUMA_EVENT_ITEMS +
 			   NR_VM_NODE_STAT_ITEMS +
 			   NR_VM_WRITEBACK_STAT_ITEMS +
 			   item];
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index cd0295567a04..99c06a9ae7ee 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2146,7 +2146,7 @@ static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
 		return page;
 	if (page && page_to_nid(page) == nid) {
 		preempt_disable();
-		__inc_numa_state(page_zone(page), NUMA_INTERLEAVE_HIT);
+		__count_numa_event(page_zone(page), NUMA_INTERLEAVE_HIT);
 		preempt_enable();
 	}
 	return page;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4e92d43c25f6..9d0f047647e3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3424,12 +3424,12 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
 		local_stat = NUMA_OTHER;
 
 	if (zone_to_nid(z) == zone_to_nid(preferred_zone))
-		__inc_numa_state(z, NUMA_HIT);
+		__count_numa_event(z, NUMA_HIT);
 	else {
-		__inc_numa_state(z, NUMA_MISS);
-		__inc_numa_state(preferred_zone, NUMA_FOREIGN);
+		__count_numa_event(z, NUMA_MISS);
+		__count_numa_event(preferred_zone, NUMA_FOREIGN);
 	}
-	__inc_numa_state(z, local_stat);
+	__count_numa_event(z, local_stat);
 #endif
 }
 
@@ -6700,8 +6700,8 @@ void __init setup_per_cpu_pageset(void)
 	 */
 	for_each_possible_cpu(cpu) {
 		struct per_cpu_zonestat *pzstats = &per_cpu(boot_zonestats, cpu);
-		memset(pzstats->vm_numa_stat_diff, 0,
-		       sizeof(pzstats->vm_numa_stat_diff));
+		memset(pzstats->vm_numa_event, 0,
+		       sizeof(pzstats->vm_numa_event));
 	}
 #endif
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8a8f1a26b231..97558cb607ac 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -31,8 +31,6 @@
 
 #include "internal.h"
 
-#define NUMA_STATS_THRESHOLD (U16_MAX - 2)
-
 #ifdef CONFIG_NUMA
 int sysctl_vm_numa_stat = ENABLE_NUMA_STAT;
 
@@ -41,11 +39,12 @@ static void zero_zone_numa_counters(struct zone *zone)
 {
 	int item, cpu;
 
-	for (item = 0; item < NR_VM_NUMA_STAT_ITEMS; item++) {
-		atomic_long_set(&zone->vm_numa_stat[item], 0);
-		for_each_online_cpu(cpu)
-			per_cpu_ptr(zone->per_cpu_zonestats, cpu)->vm_numa_stat_diff[item]
+	for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++) {
+		atomic_long_set(&zone->vm_numa_event[item], 0);
+		for_each_online_cpu(cpu) {
+			per_cpu_ptr(zone->per_cpu_zonestats, cpu)->vm_numa_event[item]
 						= 0;
+		}
 	}
 }
 
@@ -63,8 +62,8 @@ static void zero_global_numa_counters(void)
 {
 	int item;
 
-	for (item = 0; item < NR_VM_NUMA_STAT_ITEMS; item++)
-		atomic_long_set(&vm_numa_stat[item], 0);
+	for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++)
+		atomic_long_set(&vm_numa_event[item], 0);
 }
 
 static void invalid_numa_statistics(void)
@@ -161,10 +160,9 @@ void vm_events_fold_cpu(int cpu)
  * vm_stat contains the global counters
  */
 atomic_long_t vm_zone_stat[NR_VM_ZONE_STAT_ITEMS] __cacheline_aligned_in_smp;
-atomic_long_t vm_numa_stat[NR_VM_NUMA_STAT_ITEMS] __cacheline_aligned_in_smp;
 atomic_long_t vm_node_stat[NR_VM_NODE_STAT_ITEMS] __cacheline_aligned_in_smp;
+atomic_long_t vm_numa_event[NR_VM_NUMA_EVENT_ITEMS] __cacheline_aligned_in_smp;
 EXPORT_SYMBOL(vm_zone_stat);
-EXPORT_SYMBOL(vm_numa_stat);
 EXPORT_SYMBOL(vm_node_stat);
 
 #ifdef CONFIG_SMP
@@ -706,8 +704,7 @@ EXPORT_SYMBOL(dec_node_page_state);
  * Fold a differential into the global counters.
  * Returns the number of counters updated.
  */
-#ifdef CONFIG_NUMA
-static int fold_diff(int *zone_diff, int *numa_diff, int *node_diff)
+static int fold_diff(int *zone_diff, int *node_diff)
 {
 	int i;
 	int changes = 0;
@@ -718,12 +715,6 @@ static int fold_diff(int *zone_diff, int *numa_diff, int *node_diff)
 			changes++;
 	}
 
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-		if (numa_diff[i]) {
-			atomic_long_add(numa_diff[i], &vm_numa_stat[i]);
-			changes++;
-	}
-
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
 		if (node_diff[i]) {
 			atomic_long_add(node_diff[i], &vm_node_stat[i]);
@@ -731,26 +722,34 @@ static int fold_diff(int *zone_diff, int *numa_diff, int *node_diff)
 	}
 	return changes;
 }
-#else
-static int fold_diff(int *zone_diff, int *node_diff)
+
+#ifdef CONFIG_NUMA
+static void fold_vm_zone_numa_events(struct zone *zone)
 {
-	int i;
-	int changes = 0;
+	int zone_numa_events[NR_VM_NUMA_EVENT_ITEMS] = { 0, };
+	int cpu;
+	enum numa_stat_item item;
 
-	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
-		if (zone_diff[i]) {
-			atomic_long_add(zone_diff[i], &vm_zone_stat[i]);
-			changes++;
-	}
+	for_each_online_cpu(cpu) {
+		struct per_cpu_zonestat *pzstats;
 
-	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-		if (node_diff[i]) {
-			atomic_long_add(node_diff[i], &vm_node_stat[i]);
-			changes++;
+		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
+		for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++)
+			zone_numa_events[item] += xchg(&pzstats->vm_numa_event[item], 0);
 	}
-	return changes;
+
+	for (item = 0; item < NR_VM_NUMA_EVENT_ITEMS; item++)
+		zone_numa_event_add(zone_numa_events[item], zone, item);
 }
-#endif /* CONFIG_NUMA */
+
+void fold_vm_numa_events(void)
+{
+	struct zone *zone;
+
+	for_each_populated_zone(zone)
+		fold_vm_zone_numa_events(zone);
+}
+#endif
 
 /*
  * Update the zone counters for the current cpu.
@@ -774,9 +773,6 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 	struct zone *zone;
 	int i;
 	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
-#ifdef CONFIG_NUMA
-	int global_numa_diff[NR_VM_NUMA_STAT_ITEMS] = { 0, };
-#endif
 	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
 	int changes = 0;
 
@@ -799,17 +795,6 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 			}
 		}
 #ifdef CONFIG_NUMA
-		for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++) {
-			int v;
-
-			v = this_cpu_xchg(pzstats->vm_numa_stat_diff[i], 0);
-			if (v) {
-
-				atomic_long_add(v, &zone->vm_numa_stat[i]);
-				global_numa_diff[i] += v;
-				__this_cpu_write(pcp->expire, 3);
-			}
-		}
 
 		if (do_pagesets) {
 			cond_resched();
@@ -857,12 +842,7 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 		}
 	}
 
-#ifdef CONFIG_NUMA
-	changes += fold_diff(global_zone_diff, global_numa_diff,
-			     global_node_diff);
-#else
 	changes += fold_diff(global_zone_diff, global_node_diff);
-#endif
 	return changes;
 }
 
@@ -877,9 +857,6 @@ void cpu_vm_stats_fold(int cpu)
 	struct zone *zone;
 	int i;
 	int global_zone_diff[NR_VM_ZONE_STAT_ITEMS] = { 0, };
-#ifdef CONFIG_NUMA
-	int global_numa_diff[NR_VM_NUMA_STAT_ITEMS] = { 0, };
-#endif
 	int global_node_diff[NR_VM_NODE_STAT_ITEMS] = { 0, };
 
 	for_each_populated_zone(zone) {
@@ -887,7 +864,7 @@ void cpu_vm_stats_fold(int cpu)
 
 		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 
-		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
+		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 			if (pzstats->vm_stat_diff[i]) {
 				int v;
 
@@ -896,19 +873,19 @@ void cpu_vm_stats_fold(int cpu)
 				atomic_long_add(v, &zone->vm_stat[i]);
 				global_zone_diff[i] += v;
 			}
-
+		}
 #ifdef CONFIG_NUMA
-		for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-			if (pzstats->vm_numa_stat_diff[i]) {
+		for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++) {
+			if (pzstats->vm_numa_event[i]) {
 				int v;
 
-				v = pzstats->vm_numa_stat_diff[i];
-				pzstats->vm_numa_stat_diff[i] = 0;
-				atomic_long_add(v, &zone->vm_numa_stat[i]);
-				global_numa_diff[i] += v;
+				v = pzstats->vm_numa_event[i];
+				pzstats->vm_numa_event[i] = 0;
+				zone_numa_event_add(v, zone, i);
 			}
-#endif
+		}
 	}
+#endif
 
 	for_each_online_pgdat(pgdat) {
 		struct per_cpu_nodestat *p;
@@ -926,11 +903,7 @@ void cpu_vm_stats_fold(int cpu)
 			}
 	}
 
-#ifdef CONFIG_NUMA
-	fold_diff(global_zone_diff, global_numa_diff, global_node_diff);
-#else
 	fold_diff(global_zone_diff, global_node_diff);
-#endif
 }
 
 /*
@@ -939,43 +912,36 @@ void cpu_vm_stats_fold(int cpu)
  */
 void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
 {
-	int i;
+	int i, v;
 
-	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
+	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
 		if (pzstats->vm_stat_diff[i]) {
-			int v = pzstats->vm_stat_diff[i];
+			v = pzstats->vm_stat_diff[i];
 			pzstats->vm_stat_diff[i] = 0;
-			atomic_long_add(v, &zone->vm_stat[i]);
-			atomic_long_add(v, &vm_zone_stat[i]);
+			zone_page_state_add(v, zone, i);
 		}
+	}
 
 #ifdef CONFIG_NUMA
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-		if (pzstats->vm_numa_stat_diff[i]) {
-			int v = pzstats->vm_numa_stat_diff[i];
-
-			pzstats->vm_numa_stat_diff[i] = 0;
-			atomic_long_add(v, &zone->vm_numa_stat[i]);
-			atomic_long_add(v, &vm_numa_stat[i]);
+	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++) {
+		if (pzstats->vm_numa_event[i]) {
+			v = pzstats->vm_numa_event[i];
+			pzstats->vm_numa_event[i] = 0;
+			zone_numa_event_add(v, zone, i);
 		}
+	}
 #endif
 }
 #endif
 
 #ifdef CONFIG_NUMA
-void __inc_numa_state(struct zone *zone,
+/* See __count_vm_event comment on why raw_cpu_inc is used. */
+void __count_numa_event(struct zone *zone,
 				 enum numa_stat_item item)
 {
 	struct per_cpu_zonestat __percpu *pzstats = zone->per_cpu_zonestats;
-	u16 __percpu *p = pzstats->vm_numa_stat_diff + item;
-	u16 v;
 
-	v = __this_cpu_inc_return(*p);
-
-	if (unlikely(v > NUMA_STATS_THRESHOLD)) {
-		zone_numa_state_add(v, zone, item);
-		__this_cpu_write(*p, 0);
-	}
+	raw_cpu_inc(pzstats->vm_numa_event[item]);
 }
 
 /*
@@ -996,19 +962,16 @@ unsigned long sum_zone_node_page_state(int node,
 	return count;
 }
 
-/*
- * Determine the per node value of a numa stat item. To avoid deviation,
- * the per cpu stat number in vm_numa_stat_diff[] is also included.
- */
-unsigned long sum_zone_numa_state(int node,
+/* Determine the per node value of a numa stat item. */
+unsigned long sum_zone_numa_event_state(int node,
 				 enum numa_stat_item item)
 {
 	struct zone *zones = NODE_DATA(node)->node_zones;
-	int i;
 	unsigned long count = 0;
+	int i;
 
 	for (i = 0; i < MAX_NR_ZONES; i++)
-		count += zone_numa_state_snapshot(zones + i, item);
+		count += zone_numa_event_state(zones + i, item);
 
 	return count;
 }
@@ -1679,9 +1642,9 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 			   zone_page_state(zone, i));
 
 #ifdef CONFIG_NUMA
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
+	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++)
 		seq_printf(m, "\n      %-12s %lu", numa_stat_name(i),
-			   zone_numa_state_snapshot(zone, i));
+			   zone_numa_event_state(zone, i));
 #endif
 
 	seq_printf(m, "\n  pagesets");
@@ -1735,7 +1698,7 @@ static const struct seq_operations zoneinfo_op = {
 };
 
 #define NR_VMSTAT_ITEMS (NR_VM_ZONE_STAT_ITEMS + \
-			 NR_VM_NUMA_STAT_ITEMS + \
+			 NR_VM_NUMA_EVENT_ITEMS + \
 			 NR_VM_NODE_STAT_ITEMS + \
 			 NR_VM_WRITEBACK_STAT_ITEMS + \
 			 (IS_ENABLED(CONFIG_VM_EVENT_COUNTERS) ? \
@@ -1750,6 +1713,7 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 		return NULL;
 
 	BUILD_BUG_ON(ARRAY_SIZE(vmstat_text) < NR_VMSTAT_ITEMS);
+	fold_vm_numa_events();
 	v = kmalloc_array(NR_VMSTAT_ITEMS, sizeof(unsigned long), GFP_KERNEL);
 	m->private = v;
 	if (!v)
@@ -1759,9 +1723,9 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 	v += NR_VM_ZONE_STAT_ITEMS;
 
 #ifdef CONFIG_NUMA
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-		v[i] = global_numa_state(i);
-	v += NR_VM_NUMA_STAT_ITEMS;
+	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++)
+		v[i] = global_numa_event_state(i);
+	v += NR_VM_NUMA_EVENT_ITEMS;
 #endif
 
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
@@ -1864,16 +1828,6 @@ int vmstat_refresh(struct ctl_table *table, int write,
 			err = -EINVAL;
 		}
 	}
-#ifdef CONFIG_NUMA
-	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++) {
-		val = atomic_long_read(&vm_numa_stat[i]);
-		if (val < 0) {
-			pr_warn("%s: %s %ld\n",
-				__func__, numa_stat_name(i), val);
-			err = -EINVAL;
-		}
-	}
-#endif
 	if (err)
 		return err;
 	if (write)
@@ -1922,11 +1876,7 @@ static bool need_update(int cpu)
 		if (memchr_inv(pzstats->vm_stat_diff, 0, NR_VM_ZONE_STAT_ITEMS *
 			       sizeof(pzstats->vm_stat_diff[0])))
 			return true;
-#ifdef CONFIG_NUMA
-		if (memchr_inv(pzstats->vm_numa_stat_diff, 0, NR_VM_NUMA_STAT_ITEMS *
-			       sizeof(pzstats->vm_numa_stat_diff[0])))
-			return true;
-#endif
+
 		if (last_pgdat == zone->zone_pgdat)
 			continue;
 		last_pgdat = zone->zone_pgdat;
-- 
2.26.2

