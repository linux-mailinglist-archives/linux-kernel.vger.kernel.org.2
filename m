Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569E43AC3C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 08:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhFRGXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 02:23:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:5064 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233890AbhFRGVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 02:21:51 -0400
IronPort-SDR: 0P6b3BcPh+pjV+/Gvl4JGMNb/m0Dvw79ZREJZBVrzXh+f7V0BclSLdJoGNKN2SzQHdZSayYSD8
 rbXd+RK07c8g==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193815278"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="193815278"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:33 -0700
IronPort-SDR: Mp4PPuZxQUF1g9hn/6wpr51YKi9u7JaITeNgfSupFvUomqbc8vW7nGxVXVz1vEtyE39fHyehPN
 yz1WrL4GUqgQ==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485573726"
Received: from mzhou6-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.155])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 23:16:30 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        osalvador <osalvador@suse.de>
Subject: [PATCH -V8 09/10] mm/vmscan: never demote for memcg reclaim
Date:   Fri, 18 Jun 2021 14:15:36 +0800
Message-Id: <20210618061537.434999-10-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618061537.434999-1-ying.huang@intel.com>
References: <20210618061537.434999-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Global reclaim aims to reduce the amount of memory used on
a given node or set of nodes.  Migrating pages to another
node serves this purpose.

memcg reclaim is different.  Its goal is to reduce the
total memory consumption of the entire memcg, across all
nodes.  Migration does not assist memcg reclaim because
it just moves page contents between nodes rather than
actually reducing memory consumption.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Yang Shi <yang.shi@linux.alibaba.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
---
 mm/vmscan.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bf52329f29dd..13a60426c12f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -517,7 +517,8 @@ static long add_nr_deferred(long nr, struct shrinker *shrinker,
 }
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
-					  int node_id)
+					  int node_id,
+					  struct scan_control *sc)
 {
 	if (memcg == NULL) {
 		/*
@@ -555,7 +556,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
 
 	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
 		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
+	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
 
@@ -1260,7 +1261,8 @@ static enum page_references page_check_references(struct page *page,
 	return PAGEREF_RECLAIM;
 }
 
-static bool migrate_demote_page_ok(struct page *page)
+static bool migrate_demote_page_ok(struct page *page,
+				   struct scan_control *sc)
 {
 	int next_nid = next_demotion_node(page_to_nid(page));
 
@@ -1268,6 +1270,10 @@ static bool migrate_demote_page_ok(struct page *page)
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	/* It is pointless to do demotion in memcg reclaim */
+	if (cgroup_reclaim(sc))
+		return false;
+
 	if (next_nid == NUMA_NO_NODE)
 		return false;
 	if (PageTransHuge(page) && !thp_migration_supported())
@@ -1525,7 +1531,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 		 * Before reclaiming the page, try to relocate
 		 * its contents to another node.
 		 */
-		if (do_demote_pass && migrate_demote_page_ok(page)) {
+		if (do_demote_pass && migrate_demote_page_ok(page, sc)) {
 			list_add(&page->lru, &demote_pages);
 			unlock_page(page);
 			continue;
@@ -2560,7 +2566,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	enum lru_list lru;
 
 	/* If we have no swap space, do not bother scanning anon pages. */
-	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
+	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2935,7 +2941,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, pgdat->node_id))
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 
 	return inactive_lru_pages > pages_for_compaction;
-- 
2.30.2

