Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213B23D0922
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 08:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhGUGD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 02:03:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:44391 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234258AbhGUF7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:59:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272496396"
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="272496396"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:39:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="511390036"
Received: from yhuang6-desk2.sh.intel.com ([10.239.159.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 23:39:53 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: [PATCH -V11 7/9] mm/vmscan: Consider anonymous pages without swap
Date:   Wed, 21 Jul 2021 14:39:24 +0800
Message-Id: <20210721063926.3024591-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721063926.3024591-1-ying.huang@intel.com>
References: <20210721063926.3024591-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Reclaim anonymous pages if a migration path is available now that demotion
provides a non-swap recourse for reclaiming anon pages.

Note that this check is subtly different from the can_age_anon_pages()
checks.  This mechanism checks whether a specific page in a specific
context can actually be reclaimed, given current swap space and cgroup
limits.

can_age_anon_pages() is a much simpler and more preliminary check which
just says whether there is a possibility of future reclaim.

Link: https://lkml.kernel.org/r/20210715055145.195411-8-ying.huang@intel.com
Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Wei Xu <weixugc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Greg Thelen <gthelen@google.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/vmscan.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d79bf91700de..67a320c6571d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -521,7 +521,7 @@ static long add_nr_deferred(long nr, struct shrinker *shrinker,
 
 static bool can_demote(int nid, struct scan_control *sc)
 {
-	if (sc->no_demotion)
+	if (sc && sc->no_demotion)
 		return false;
 	if (next_demotion_node(nid) == NUMA_NO_NODE)
 		return false;
@@ -530,6 +530,31 @@ static bool can_demote(int nid, struct scan_control *sc)
 	return false;
 }
 
+static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
+					  int nid,
+					  struct scan_control *sc)
+{
+	if (memcg == NULL) {
+		/*
+		 * For non-memcg reclaim, is there
+		 * space in any swap device?
+		 */
+		if (get_nr_swap_pages() > 0)
+			return true;
+	} else {
+		/* Is the memcg below its swap limit? */
+		if (mem_cgroup_get_nr_swap_pages(memcg) > 0)
+			return true;
+	}
+
+	/*
+	 * The page can not be swapped.
+	 *
+	 * Can it be reclaimed from this node via demotion?
+	 */
+	return can_demote(nid, sc);
+}
+
 /*
  * This misses isolated pages which are not accounted for to save counters.
  * As the data only determines if reclaim or compaction continues, it is
@@ -541,7 +566,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
 
 	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
 		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
+	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
 
@@ -2544,6 +2569,7 @@ enum scan_balance {
 static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 			   unsigned long *nr)
 {
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long anon_cost, file_cost, total_cost;
 	int swappiness = mem_cgroup_swappiness(memcg);
@@ -2554,7 +2580,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	enum lru_list lru;
 
 	/* If we have no swap space, do not bother scanning anon pages. */
-	if (!sc->may_swap || mem_cgroup_get_nr_swap_pages(memcg) <= 0) {
+	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2924,7 +2950,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 
 	return inactive_lru_pages > pages_for_compaction;
-- 
2.30.2

