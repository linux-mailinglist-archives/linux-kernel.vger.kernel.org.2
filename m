Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FFC314AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhBII5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:57:42 -0500
Received: from m12-11.163.com ([220.181.12.11]:49030 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhBIIsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PSfy/
        +QXOlQZc11vd+kllhwGR1ZJsPSV13Tkt44bFbQ=; b=KZoWqjm8nV5Wc7CLYsv9x
        YGm3v3norKnmx+wH+WoIUCAMQWOVBU9qB5Y/VUQ2izPfnU8+rbVtSP5CAD49Uzl1
        UgIHbcvVpWAA1cycVg23bknA1NS6D8bK9jyeh1EQV49472nWHAOtzs2JJTmOx0M/
        cYmWjHm5Wo70auxpofxw+A=
Received: from localhost.localdomain (unknown [58.33.102.73])
        by smtp7 (Coremail) with SMTP id C8CowABnNa5zRiJg2f0CNA--.10017S4;
        Tue, 09 Feb 2021 16:23:16 +0800 (CST)
From:   zhou <xianrong_zhou@163.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        vbabka@suse.cz, rientjes@google.com, willy@linux.intel.com,
        pankaj.gupta.linux@gmail.com, bhe@redhat.com, ying.huang@intel.com,
        iamjoonsoo.kim@lge.com, minchan@kernel.org,
        ruxian.feng@transsion.com, kai.cheng@transsion.com,
        zhao.xu@transsion.com, yunfeng.lan@transsion.com,
        zhouxianrong@tom.com, zhou xianrong <xianrong.zhou@transsion.com>
Subject: [PATCH] kswapd: no need reclaim cma pages triggered by unmovable allocation
Date:   Tue,  9 Feb 2021 16:23:13 +0800
Message-Id: <20210209082313.21969-1-xianrong_zhou@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowABnNa5zRiJg2f0CNA--.10017S4
X-Coremail-Antispam: 1Uf129KBjvAXoW3ZrWkJw1DAryDGF1xZw4ktFb_yoW8GFWUXo
        WSkrsIyw1SgryjvwnY9FykJF4UXF1kAr4xZF1jva9xC3ZxZrWrJa90kw47JFWfXF4rtF1r
        Xr10k3srtFs5t3Z7n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq1v3UUUUU
X-Originating-IP: [58.33.102.73]
X-CM-SenderInfo: h0ld02prqjs6xkrxqiywtou0bp/xtbBzxQ0z1aD9+RkqQAAsr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhou xianrong <xianrong.zhou@transsion.com>

For purpose of better migration cma pages are allocated after
failure movalbe allocations and are used normally for file pages
or anonymous pages.

In reclaim path so many cma pages if configurated are reclaimed
from lru lists in kswapd mainly or direct reclaim triggered by
unmovable or reclaimable allocations. But these cma pages can not
be used by original unmovable or reclaimable allocations. So the
reclaim are unnecessary.

In a same system if the cma pages were configurated to large then
more failture unmovable (vmalloc etc.) or reclaimable (slab etc.)
allocations are arised and then more kswapd rounds are triggered
and then more cma pages are reclaimed.

So this maybe cause vicious cycle. It causes that when we are under
low memory and still there are many cma pages that can not be
allocated due to unnecessary cma reclaim and cma fallback allocations
. So cma pages are not used sufficiently.

The modification is straightforward that skips reclaiming cma pages
in reclaim procedure which is triggered only by unmovable or
reclaimable allocations. This optimization can avoid ~3% unnecessary
cma isolations (cma isolated / total isolated).

Signed-off-by: zhou xianrong <xianrong.zhou@transsion.com>
---
 include/linux/mmzone.h        |  6 ++--
 include/trace/events/vmscan.h | 20 +++++++----
 mm/page_alloc.c               |  5 +--
 mm/vmscan.c                   | 63 +++++++++++++++++++++++++++++------
 4 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b593316bff3d..7dd38d7372b9 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -301,6 +301,8 @@ struct lruvec {
 #define ISOLATE_ASYNC_MIGRATE	((__force isolate_mode_t)0x4)
 /* Isolate unevictable pages */
 #define ISOLATE_UNEVICTABLE	((__force isolate_mode_t)0x8)
+/* Isolate none cma pages */
+#define ISOLATE_NONCMA		((__force isolate_mode_t)0x10)
 
 /* LRU Isolation modes. */
 typedef unsigned __bitwise isolate_mode_t;
@@ -756,7 +758,7 @@ typedef struct pglist_data {
 	wait_queue_head_t pfmemalloc_wait;
 	struct task_struct *kswapd;	/* Protected by
 					   mem_hotplug_begin/end() */
-	int kswapd_order;
+	int kswapd_order, kswapd_migratetype;
 	enum zone_type kswapd_highest_zoneidx;
 
 	int kswapd_failures;		/* Number of 'reclaimed == 0' runs */
@@ -840,7 +842,7 @@ static inline bool pgdat_is_empty(pg_data_t *pgdat)
 
 void build_all_zonelists(pg_data_t *pgdat);
 void wakeup_kswapd(struct zone *zone, gfp_t gfp_mask, int order,
-		   enum zone_type highest_zoneidx);
+		   int migratetype, enum zone_type highest_zoneidx);
 bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			 int highest_zoneidx, unsigned int alloc_flags,
 			 long free_pages);
diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 2070df64958e..41bbafdfde84 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -51,37 +51,41 @@ TRACE_EVENT(mm_vmscan_kswapd_sleep,
 
 TRACE_EVENT(mm_vmscan_kswapd_wake,
 
-	TP_PROTO(int nid, int zid, int order),
+	TP_PROTO(int nid, int zid, int order, int mt),
 
-	TP_ARGS(nid, zid, order),
+	TP_ARGS(nid, zid, order, mt),
 
 	TP_STRUCT__entry(
 		__field(	int,	nid	)
 		__field(	int,	zid	)
 		__field(	int,	order	)
+		__field(	int,	mt	)
 	),
 
 	TP_fast_assign(
 		__entry->nid	= nid;
 		__entry->zid    = zid;
 		__entry->order	= order;
+		__entry->mt	= mt;
 	),
 
-	TP_printk("nid=%d order=%d",
+	TP_printk("nid=%d order=%d migratetype=%d",
 		__entry->nid,
-		__entry->order)
+		__entry->order,
+		__entry->mt)
 );
 
 TRACE_EVENT(mm_vmscan_wakeup_kswapd,
 
-	TP_PROTO(int nid, int zid, int order, gfp_t gfp_flags),
+	TP_PROTO(int nid, int zid, int order, int mt, gfp_t gfp_flags),
 
-	TP_ARGS(nid, zid, order, gfp_flags),
+	TP_ARGS(nid, zid, order, mt, gfp_flags),
 
 	TP_STRUCT__entry(
 		__field(	int,	nid		)
 		__field(	int,	zid		)
 		__field(	int,	order		)
+		__field(	int,	mt		)
 		__field(	gfp_t,	gfp_flags	)
 	),
 
@@ -89,12 +93,14 @@ TRACE_EVENT(mm_vmscan_wakeup_kswapd,
 		__entry->nid		= nid;
 		__entry->zid		= zid;
 		__entry->order		= order;
+		__entry->mt		= mt;
 		__entry->gfp_flags	= gfp_flags;
 	),
 
-	TP_printk("nid=%d order=%d gfp_flags=%s",
+	TP_printk("nid=%d order=%d migratetype=%d gfp_flags=%s",
 		__entry->nid,
 		__entry->order,
+		__entry->mt,
 		show_gfp_flags(__entry->gfp_flags))
 );
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 519a60d5b6f7..45ceb15721b8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3517,7 +3517,7 @@ struct page *rmqueue(struct zone *preferred_zone,
 	/* Separate test+clear to avoid unnecessary atomics */
 	if (test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags)) {
 		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
-		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
+		wakeup_kswapd(zone, 0, 0, migratetype, zone_idx(zone));
 	}
 
 	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
@@ -4426,11 +4426,12 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 	struct zone *zone;
 	pg_data_t *last_pgdat = NULL;
 	enum zone_type highest_zoneidx = ac->highest_zoneidx;
+	int migratetype = ac->migratetype;
 
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist, highest_zoneidx,
 					ac->nodemask) {
 		if (last_pgdat != zone->zone_pgdat)
-			wakeup_kswapd(zone, gfp_mask, order, highest_zoneidx);
+			wakeup_kswapd(zone, gfp_mask, order, migratetype, highest_zoneidx);
 		last_pgdat = zone->zone_pgdat;
 	}
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b1b574ad199d..e61ec8747a40 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -99,6 +99,9 @@ struct scan_control {
 	/* Can pages be swapped as part of reclaim? */
 	unsigned int may_swap:1;
 
+	/* Can cma pages be reclaimed? */
+	unsigned int may_cma:1;
+
 	/*
 	 * Cgroups are not reclaimed below their configured memory.low,
 	 * unless we threaten to OOM. If any cgroups are skipped due to
@@ -286,6 +289,11 @@ static bool writeback_throttling_sane(struct scan_control *sc)
 }
 #endif
 
+static bool movable_reclaim(gfp_t gfp_mask)
+{
+	return is_migrate_movable(gfp_migratetype(gfp_mask));
+}
+
 /*
  * This misses isolated pages which are not accounted for to save counters.
  * As the data only determines if reclaim or compaction continues, it is
@@ -1499,6 +1507,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 		.gfp_mask = GFP_KERNEL,
 		.priority = DEF_PRIORITY,
 		.may_unmap = 1,
+		.may_cma = 1,
 	};
 	struct reclaim_stat stat;
 	unsigned int nr_reclaimed;
@@ -1593,6 +1602,9 @@ int __isolate_lru_page_prepare(struct page *page, isolate_mode_t mode)
 	if ((mode & ISOLATE_UNMAPPED) && page_mapped(page))
 		return ret;
 
+	if ((mode & ISOLATE_NONCMA) && is_migrate_cma(get_pageblock_migratetype(page)))
+		return ret;
+
 	return 0;
 }
 
@@ -1647,7 +1659,10 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
 	unsigned long skipped = 0;
 	unsigned long scan, total_scan, nr_pages;
 	LIST_HEAD(pages_skipped);
-	isolate_mode_t mode = (sc->may_unmap ? 0 : ISOLATE_UNMAPPED);
+	isolate_mode_t mode;
+
+	mode = (sc->may_unmap ? 0 : ISOLATE_UNMAPPED);
+	mode |= (sc->may_cma ? 0 : ISOLATE_NONCMA);
 
 	total_scan = 0;
 	scan = 0;
@@ -2125,6 +2140,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
 		.may_writepage = 1,
 		.may_unmap = 1,
 		.may_swap = 1,
+		.may_cma = 1,
 	};
 
 	while (!list_empty(page_list)) {
@@ -3253,6 +3269,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
 		.may_writepage = !laptop_mode,
 		.may_unmap = 1,
 		.may_swap = 1,
+		.may_cma = movable_reclaim(gfp_mask),
 	};
 
 	/*
@@ -3298,6 +3315,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.may_swap = !noswap,
+		.may_cma = 1,
 	};
 
 	WARN_ON_ONCE(!current->reclaim_state);
@@ -3341,6 +3359,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_writepage = !laptop_mode,
 		.may_unmap = 1,
 		.may_swap = may_swap,
+		.may_cma = 1,
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
@@ -3548,7 +3567,7 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
  * or lower is eligible for reclaim until at least one usable zone is
  * balanced.
  */
-static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
+static int balance_pgdat(pg_data_t *pgdat, int order, int migratetype, int highest_zoneidx)
 {
 	int i;
 	unsigned long nr_soft_reclaimed;
@@ -3650,6 +3669,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		 */
 		sc.may_writepage = !laptop_mode && !nr_boost_reclaim;
 		sc.may_swap = !nr_boost_reclaim;
+		sc.may_cma = is_migrate_movable(migratetype);
 
 		/*
 		 * Do some background aging of the anon list, to give
@@ -3771,8 +3791,15 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
 	return curr_idx == MAX_NR_ZONES ? prev_highest_zoneidx : curr_idx;
 }
 
+static int kswapd_migratetype(pg_data_t *pgdat, int prev_migratetype)
+{
+	int curr_migratetype = READ_ONCE(pgdat->kswapd_migratetype);
+
+	return curr_migratetype == MIGRATE_TYPES ? prev_migratetype : curr_migratetype;
+}
+
 static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
-				unsigned int highest_zoneidx)
+				int migratetype, unsigned int highest_zoneidx)
 {
 	long remaining = 0;
 	DEFINE_WAIT(wait);
@@ -3807,8 +3834,8 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 		remaining = schedule_timeout(HZ/10);
 
 		/*
-		 * If woken prematurely then reset kswapd_highest_zoneidx and
-		 * order. The values will either be from a wakeup request or
+		 * If woken prematurely then reset kswapd_highest_zoneidx, order
+		 * and migratetype. The values will either be from a wakeup request or
 		 * the previous request that slept prematurely.
 		 */
 		if (remaining) {
@@ -3818,6 +3845,10 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
 
 			if (READ_ONCE(pgdat->kswapd_order) < reclaim_order)
 				WRITE_ONCE(pgdat->kswapd_order, reclaim_order);
+
+			if (!is_migrate_movable(READ_ONCE(pgdat->kswapd_migratetype)))
+				WRITE_ONCE(pgdat->kswapd_migratetype,
+						kswapd_migratetype(pgdat, migratetype));
 		}
 
 		finish_wait(&pgdat->kswapd_wait, &wait);
@@ -3870,6 +3901,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
  */
 static int kswapd(void *p)
 {
+	int migratetype = 0;
 	unsigned int alloc_order, reclaim_order;
 	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
 	pg_data_t *pgdat = (pg_data_t*)p;
@@ -3895,23 +3927,27 @@ static int kswapd(void *p)
 	set_freezable();
 
 	WRITE_ONCE(pgdat->kswapd_order, 0);
+	WRITE_ONCE(pgdat->kswapd_migratetype, MIGRATE_TYPES);
 	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
 	for ( ; ; ) {
 		bool ret;
 
 		alloc_order = reclaim_order = READ_ONCE(pgdat->kswapd_order);
+		migratetype = kswapd_migratetype(pgdat, migratetype);
 		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
 							highest_zoneidx);
 
 kswapd_try_sleep:
 		kswapd_try_to_sleep(pgdat, alloc_order, reclaim_order,
-					highest_zoneidx);
+					migratetype, highest_zoneidx);
 
 		/* Read the new order and highest_zoneidx */
 		alloc_order = READ_ONCE(pgdat->kswapd_order);
+		migratetype = kswapd_migratetype(pgdat, migratetype);
 		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
 							highest_zoneidx);
 		WRITE_ONCE(pgdat->kswapd_order, 0);
+		WRITE_ONCE(pgdat->kswapd_migratetype, MIGRATE_TYPES);
 		WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
 
 		ret = try_to_freeze();
@@ -3934,8 +3970,8 @@ static int kswapd(void *p)
 		 * request (alloc_order).
 		 */
 		trace_mm_vmscan_kswapd_wake(pgdat->node_id, highest_zoneidx,
-						alloc_order);
-		reclaim_order = balance_pgdat(pgdat, alloc_order,
+						alloc_order, migratetype);
+		reclaim_order = balance_pgdat(pgdat, alloc_order, migratetype,
 						highest_zoneidx);
 		if (reclaim_order < alloc_order)
 			goto kswapd_try_sleep;
@@ -3954,10 +3990,11 @@ static int kswapd(void *p)
  * needed.
  */
 void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
-		   enum zone_type highest_zoneidx)
+		   int migratetype, enum zone_type highest_zoneidx)
 {
 	pg_data_t *pgdat;
 	enum zone_type curr_idx;
+	int curr_migratetype;
 
 	if (!managed_zone(zone))
 		return;
@@ -3967,6 +4004,7 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 
 	pgdat = zone->zone_pgdat;
 	curr_idx = READ_ONCE(pgdat->kswapd_highest_zoneidx);
+	curr_migratetype = READ_ONCE(pgdat->kswapd_migratetype);
 
 	if (curr_idx == MAX_NR_ZONES || curr_idx < highest_zoneidx)
 		WRITE_ONCE(pgdat->kswapd_highest_zoneidx, highest_zoneidx);
@@ -3974,6 +4012,9 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 	if (READ_ONCE(pgdat->kswapd_order) < order)
 		WRITE_ONCE(pgdat->kswapd_order, order);
 
+	if (curr_migratetype == MIGRATE_TYPES || is_migrate_movable(migratetype))
+		WRITE_ONCE(pgdat->kswapd_migratetype, migratetype);
+
 	if (!waitqueue_active(&pgdat->kswapd_wait))
 		return;
 
@@ -3994,7 +4035,7 @@ void wakeup_kswapd(struct zone *zone, gfp_t gfp_flags, int order,
 	}
 
 	trace_mm_vmscan_wakeup_kswapd(pgdat->node_id, highest_zoneidx, order,
-				      gfp_flags);
+				      migratetype, gfp_flags);
 	wake_up_interruptible(&pgdat->kswapd_wait);
 }
 
@@ -4017,6 +4058,7 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
 		.may_writepage = 1,
 		.may_unmap = 1,
 		.may_swap = 1,
+		.may_cma = 1,
 		.hibernation_mode = 1,
 	};
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
@@ -4176,6 +4218,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		.may_writepage = !!(node_reclaim_mode & RECLAIM_WRITE),
 		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
 		.may_swap = 1,
+		.may_cma = movable_reclaim(gfp_mask),
 		.reclaim_idx = gfp_zone(gfp_mask),
 	};
 
-- 
2.25.1

