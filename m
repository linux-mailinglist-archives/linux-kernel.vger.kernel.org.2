Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E483B3D73
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhFYHgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:36:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:21955 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhFYHfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:35:44 -0400
IronPort-SDR: QdW2GneXjRcvwm0uPtz+KFJAU1JEVrDNBh4Vhlloiuy7631TmJrwJrINlMXejQU2yH8y8wUnnr
 YW5EuQe/asXw==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="194769118"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="194769118"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:33:23 -0700
IronPort-SDR: 2icSWzt6rWD+2fbPcof3C2ftYHnf8CgTFEGMhJuMQbta5jytMGXZk9CLADDun3rSaZkqZ5Cpuw
 KygWu+rK+PmA==
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="488085867"
Received: from msun2-mobl1.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.50])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 00:33:17 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH -V9 6/9] mm/vmscan: add helper for querying ability to age anonymous pages
Date:   Fri, 25 Jun 2021 15:32:01 +0800
Message-Id: <20210625073204.1005986-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210625073204.1005986-1-ying.huang@intel.com>
References: <20210625073204.1005986-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Anonymous pages are kept on their own LRU(s).  These lists could
theoretically always be scanned and maintained.  But, without swap,
there is currently nothing the kernel can *do* with the results of a
scanned, sorted LRU for anonymous pages.

A check for '!total_swap_pages' currently serves as a valid check as
to whether anonymous LRUs should be maintained.  However, another
method will be added shortly: page demotion.

Abstract out the 'total_swap_pages' checks into a helper, give it a
logically significant name, and check for the possibility of page
demotion.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Greg Thelen <gthelen@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Xu <weixugc@google.com>
Cc: osalvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>

Changes since 20210618:
 * Rename function per Oscar's comments.
 * Change parameter per Wei's comments.
 * Make the function static.
 * Consider whether demotion is disabled.
---
 mm/vmscan.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 78b3bae71520..55f6192b2a51 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2716,6 +2716,26 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	}
 }
 
+/*
+ * Anonymous LRU management is a waste if there is
+ * ultimately no way to reclaim the memory.
+ */
+static bool anon_can_be_aged(struct pglist_data *pgdat,
+			     struct scan_control *sc)
+{
+	/* Aging the anon LRU is valuable if swap is present: */
+	if (total_swap_pages > 0)
+		return true;
+
+	/* Also valuable if anon pages can be demoted: */
+	if (!sc->no_demotion &&
+	    next_demotion_node(pgdat->node_id) != NUMA_NO_NODE)
+		return true;
+
+	/* No way to reclaim anon pages.  Should not age anon LRUs: */
+	return false;
+}
+
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	unsigned long nr[NR_LRU_LISTS];
@@ -2825,7 +2845,8 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (total_swap_pages && inactive_is_low(lruvec, LRU_INACTIVE_ANON))
+	if (anon_can_be_aged(lruvec_pgdat(lruvec), sc) &&
+	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
 }
@@ -3654,7 +3675,7 @@ static void age_active_anon(struct pglist_data *pgdat,
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
-	if (!total_swap_pages)
+	if (!anon_can_be_aged(pgdat, sc))
 		return;
 
 	lruvec = mem_cgroup_lruvec(NULL, pgdat);
-- 
2.30.2

