Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141203AC3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhFRGXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:23:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:4823 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232394AbhFRGU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:20:58 -0400
IronPort-SDR: Er3bHynbi9kGG7/Qin4BPa2cDQZqsPxiAt5a3bPpqEiU/BZFLpYYU9J53XiaUL5SsJsi9AUEPD
 Sl7YdCo+G+wA==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193815273"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="193815273"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:30 -0700
IronPort-SDR: mrsrbjnulGResonwwRAnorHqJvjiY+JLvv3kupci1kC/8rUC8uavMvKXythzg0Q+B3ODTUMlpC
 4xdFSkDDd8YA==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485573705"
Received: from mzhou6-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:27 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: [PATCH -V8 08/10] mm/vmscan: Consider anonymous pages without swap
Date:   Fri, 18 Jun 2021 14:15:35 +0800
Message-Id: <20210618061537.434999-9-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618061537.434999-1-ying.huang@intel.com>
References: <20210618061537.434999-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Reclaim anonymous pages if a migration path is available now that
demotion provides a non-swap recourse for reclaiming anon pages.

Note that this check is subtly different from the
anon_should_be_aged() checks.  This mechanism checks whether a
specific page in a specific context *can* actually be reclaimed, given
current swap space and cgroup limits

anon_should_be_aged() is a much simpler and more preliminary check
which just says whether there is a possibility of future reclaim.

Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>

--

Changes from Dave 10/2020:
 * remove 'total_swap_pages' modification

Changes from Dave 06/2020:
 * rename reclaim_anon_pages()->can_reclaim_anon_pages()

Note: Keith's Intel SoB is commented out because he is no
longer at Intel and his @intel.com mail will bounce.
---
 mm/vmscan.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8654cec65522..bf52329f29dd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -516,6 +516,34 @@ static long add_nr_deferred(long nr, struct shrinker *shrinker,
 	return atomic_long_add_return(nr, &shrinker->nr_deferred[nid]);
 }
 
+static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
+					  int node_id)
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
+	if (next_demotion_node(node_id) >= 0)
+		return true;
+
+	/* No way to reclaim anon pages */
+	return false;
+}
+
 /*
  * This misses isolated pages which are not accounted for to save counters.
  * As the data only determines if reclaim or compaction continues, it is
@@ -527,7 +555,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
 
 	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
 		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
+	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
 
@@ -2521,6 +2549,7 @@ enum scan_balance {
 static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 			   unsigned long *nr)
 {
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long anon_cost, file_cost, total_cost;
 	int swappiness = mem_cgroup_swappiness(memcg);
@@ -2531,7 +2560,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	enum lru_list lru;
 
 	/* If we have no swap space, do not bother scanning anon pages. */
-	if (!sc->may_swap || mem_cgroup_get_nr_swap_pages(memcg) <= 0) {
+	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2906,7 +2935,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (get_nr_swap_pages() > 0)
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 
 	return inactive_lru_pages > pages_for_compaction;
-- 
2.30.2

