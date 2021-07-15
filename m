Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7A93C988F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 07:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbhGOFz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 01:55:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:22887 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239994AbhGOFzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:55:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="197661960"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="197661960"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 22:52:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="505591629"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2021 22:52:29 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH -V10 6/9] mm/vmscan: add helper for querying ability to age anonymous pages
Date:   Thu, 15 Jul 2021 13:51:42 +0800
Message-Id: <20210715055145.195411-7-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715055145.195411-1-ying.huang@intel.com>
References: <20210715055145.195411-1-ying.huang@intel.com>
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

Changes since 20210625:
 * Rename function to be more consistent with other similar functions.

Changes since 20210618:
 * Rename function per Oscar's comments.
 * Change parameter per Wei's comments.
 * Make the function static.
 * Consider whether demotion is disabled.
---
 mm/vmscan.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 35913e35369d..302f8d6e7b65 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2724,6 +2724,21 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	}
 }
 
+/*
+ * Anonymous LRU management is a waste if there is
+ * ultimately no way to reclaim the memory.
+ */
+static bool can_age_anon_pages(struct pglist_data *pgdat,
+			       struct scan_control *sc)
+{
+	/* Aging the anon LRU is valuable if swap is present: */
+	if (total_swap_pages > 0)
+		return true;
+
+	/* Also valuable if anon pages can be demoted: */
+	return can_demote_anon_pages(pgdat->node_id, sc);
+}
+
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	unsigned long nr[NR_LRU_LISTS];
@@ -2833,7 +2848,8 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (total_swap_pages && inactive_is_low(lruvec, LRU_INACTIVE_ANON))
+	if (can_age_anon_pages(lruvec_pgdat(lruvec), sc) &&
+	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
 }
@@ -3662,7 +3678,7 @@ static void age_active_anon(struct pglist_data *pgdat,
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
-	if (!total_swap_pages)
+	if (!can_age_anon_pages(pgdat, sc))
 		return;
 
 	lruvec = mem_cgroup_lruvec(NULL, pgdat);
-- 
2.30.2

