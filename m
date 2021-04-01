Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0E1351EF7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbhDASvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:51:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:63346 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238776AbhDASfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:35:14 -0400
IronPort-SDR: iRBxs5jYHgBt23urYbx9NXwh/ocSQPsIUYL/9bQ6Cr6wfEXF2E9WKQ2P4i33IKIavfIwCYiJv2
 KB2JqW/Xpy+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="192412480"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192412480"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:35:14 -0700
IronPort-SDR: jb4EYmBM3xnvyXm1cU7TVJzlpbBHz7DA9S4CyT7hKiXrg9w0ycHN15yLBwOuxZjlDa6ZlfL8kH
 0pmytepETlFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="377806278"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga003.jf.intel.com with ESMTP; 01 Apr 2021 11:35:14 -0700
Subject: [PATCH 09/10] mm/vmscan: never demote for memcg reclaim
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, shy828301@gmail.com,
        weixugc@google.com, rientjes@google.com, ying.huang@intel.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 01 Apr 2021 11:32:33 -0700
References: <20210401183216.443C4443@viggo.jf.intel.com>
In-Reply-To: <20210401183216.443C4443@viggo.jf.intel.com>
Message-Id: <20210401183233.64A91C97@viggo.jf.intel.com>
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
Suggested-by: Yang Shi <yang.shi@linux.alibaba.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Wei Xu <weixugc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
---

 b/mm/vmscan.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff -puN mm/vmscan.c~never-demote-for-memcg-reclaim mm/vmscan.c
--- a/mm/vmscan.c~never-demote-for-memcg-reclaim	2021-03-31 15:17:20.476000239 -0700
+++ b/mm/vmscan.c	2021-03-31 15:17:20.487000239 -0700
@@ -288,7 +288,8 @@ static bool writeback_throttling_sane(st
 #endif
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
-					  int node_id)
+					  int node_id,
+					  struct scan_control *sc)
 {
 	if (memcg == NULL) {
 		/*
@@ -326,7 +327,7 @@ unsigned long zone_reclaimable_pages(str
 
 	nr = zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_FILE) +
 		zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone)))
+	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
 
@@ -1064,7 +1065,8 @@ static enum page_references page_check_r
 	return PAGEREF_RECLAIM;
 }
 
-static bool migrate_demote_page_ok(struct page *page)
+static bool migrate_demote_page_ok(struct page *page,
+				   struct scan_control *sc)
 {
 	int next_nid = next_demotion_node(page_to_nid(page));
 
@@ -1072,6 +1074,10 @@ static bool migrate_demote_page_ok(struc
 	VM_BUG_ON_PAGE(PageHuge(page), page);
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
+	/* It is pointless to do demotion in memcg reclaim */
+	if (cgroup_reclaim(sc))
+		return false;
+
 	if (next_nid == NUMA_NO_NODE)
 		return false;
 	if (PageTransHuge(page) && !thp_migration_supported())
@@ -1328,7 +1334,7 @@ retry:
 		 * Before reclaiming the page, try to relocate
 		 * its contents to another node.
 		 */
-		if (do_demote_pass && migrate_demote_page_ok(page)) {
+		if (do_demote_pass && migrate_demote_page_ok(page, sc)) {
 			list_add(&page->lru, &demote_pages);
 			unlock_page(page);
 			continue;
@@ -2362,7 +2368,7 @@ static void get_scan_count(struct lruvec
 	enum lru_list lru;
 
 	/* If we have no swap space, do not bother scanning anon pages. */
-	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id)) {
+	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
@@ -2737,7 +2743,7 @@ static inline bool should_continue_recla
 	 */
 	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
-	if (can_reclaim_anon_pages(NULL, pgdat->node_id))
+	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
 
 	return inactive_lru_pages > pages_for_compaction;
_
