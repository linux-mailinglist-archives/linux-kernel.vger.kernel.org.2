Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E872233691E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCKApr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:45:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:39171 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhCKApN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:45:13 -0500
IronPort-SDR: 0VJn+wJo1xQD8CEivPFuMktdzELiXvg2sQo/nRVB76y/L0B56WHnhZDfgpJ4KTGEgascnOwK+4
 6/MXxMrp831Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="176185871"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="176185871"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 16:45:12 -0800
IronPort-SDR: Ps234FXqzH4qwxm4AKvRuzA80q4gQ8Wdd9S7lx4ZBji95xYi9ILFaMyZlRvDQqFfxdfEDPEo9s
 nRl5arLtZJtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="603321625"
Received: from yhuang-dev.sh.intel.com ([10.239.159.130])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2021 16:45:09 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH] vmscan: retry without cache trim mode if nothing scanned
Date:   Thu, 11 Mar 2021 08:44:49 +0800
Message-Id: <20210311004449.1170308-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huang Ying <ying.huang@intel.com>

In shrink_node(), to determine whether to enable cache trim mode, the
LRU size is gotten via lruvec_page_state().  That gets the value from
a per-CPU counter (mem_cgroup_per_node->lruvec_stat[]).  The error of
the per-CPU counter from CPU local counting and the descendant memory
cgroups may cause some issues.  We run into this in 0-Day performance
test.

0-Day uses the RAM file system as root file system, so the number of
the reclaimable file pages is very small.  In the swap testing, the
inactive file LRU list will become almost empty soon.  But the size of
the inactive file LRU list gotten from the per-CPU counter may keep a
much larger value (say, 33, 50, etc.).  This will enable cache trim
mode, but nothing can be scanned in fact.  The following pattern
repeats for long time in the test,

priority	inactive_file_size	cache_trim_mode
12		33			0
11		33			0
...
6		33			0
5		33			1
...
1		33			1

That is, the cache_trim_mode will be enabled wrongly when the scan
priority decreases to 5.  And the problem will not be recovered for
long time.

It's hard to get the more accurate size of the inactive file list
without much more overhead.  And it's hard to estimate the error of
the per-CPU counter too, because there may be many descendant memory
cgroups.  But after the actual scanning, if nothing can be scanned
with the cache trim mode, it should be wrong to enable the cache trim
mode.  So we can retry with the cache trim mode disabled.  This patch
implement this policy.

The test results for pmbench with normal access address distribution
and 2 NVMe disks as swap on a Intel server for the base and patched
kernel are as follows.

      base     change    patched
----------     ------  ---------
 122100000      18.6%  144800000   pmbench.throughput.aps
    164078     -56.3%      71686   vmstat.swap.si
    166511     -20.8%     131957   vmstat.swap.so
      1992     -52.2%     953.17   proc-vmstat.kswapd_high_wmark_hit_quickly
    230.20     -63.8%      83.33   proc-vmstat.kswapd_low_wmark_hit_quickly
      2318     -41.4%       1358   proc-vmstat.pageoutrun

From the above table, with the patch, the page reclaiming algorithm
runs more smoothly, the hot/cold pages distinguishing works better, so
the swap in/out throughput decreases considerably, and the benchmark
throughput increases 18.6%.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/vmscan.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fea6b43bc1f9..1304e3c98a14 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2606,7 +2606,8 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	return inactive_lru_pages > pages_for_compaction;
 }
 
-static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
+static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc,
+			       bool skip_slab)
 {
 	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
 	struct mem_cgroup *memcg;
@@ -2652,8 +2653,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		shrink_lruvec(lruvec, sc);
 
-		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
-			    sc->priority);
+		if (!skip_slab)
+			shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
+				    sc->priority);
 
 		/* Record the group's reclaim efficiency */
 		vmpressure(sc->gfp_mask, memcg, false,
@@ -2669,6 +2671,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	unsigned long nr_reclaimed, nr_scanned;
 	struct lruvec *target_lruvec;
 	bool reclaimable = false;
+	bool skip_slab;
 	unsigned long file;
 
 	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
@@ -2767,7 +2770,15 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			anon >> sc->priority;
 	}
 
-	shrink_node_memcgs(pgdat, sc);
+	skip_slab = false;
+retry:
+	shrink_node_memcgs(pgdat, sc, skip_slab);
+	/* Nothing can be scanned with cache trim mode, retry without it */
+	if (sc->cache_trim_mode && sc->nr_scanned == nr_scanned) {
+		sc->cache_trim_mode = 0;
+		skip_slab = true;
+		goto retry;
+	}
 
 	if (reclaim_state) {
 		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
-- 
2.30.1

