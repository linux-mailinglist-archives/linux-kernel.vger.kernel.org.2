Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB143351F04
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbhDASv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:51:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:34992 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235002AbhDASgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:36:01 -0400
IronPort-SDR: UNbV0P/tARofzvapUZwNPzgyh8gjw/KSLpNo9SHCrPIC5h55iPJztpqME3DxyVGlB9asc8/Oo9
 8SKdvFUDZjwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179440343"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179440343"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 11:35:11 -0700
IronPort-SDR: MUOX7IE8/T7TeaI2sqHDVNlpB9hmB1fxUw7+cEC5lgvs/yQQEVohpdDcKcryrncoGh7s5h/oTS
 S5og1YYvxpQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="456098971"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2021 11:35:10 -0700
Subject: [PATCH 07/10] mm/vmscan: add helper for querying ability to age anonymous pages
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, shy828301@gmail.com,
        gthelen@google.com, weixugc@google.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com,
        osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 01 Apr 2021 11:32:29 -0700
References: <20210401183216.443C4443@viggo.jf.intel.com>
In-Reply-To: <20210401183216.443C4443@viggo.jf.intel.com>
Message-Id: <20210401183229.B2360AEA@viggo.jf.intel.com>
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
Reviewed-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Greg Thelen <gthelen@google.com>
Cc: Wei Xu <weixugc@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
---

 b/mm/vmscan.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~mm-vmscan-anon-can-be-aged mm/vmscan.c
--- a/mm/vmscan.c~mm-vmscan-anon-can-be-aged	2021-03-31 15:17:18.325000245 -0700
+++ b/mm/vmscan.c	2021-03-31 15:17:18.333000245 -0700
@@ -2508,6 +2508,26 @@ out:
 	}
 }
 
+/*
+ * Anonymous LRU management is a waste if there is
+ * ultimately no way to reclaim the memory.
+ */
+bool anon_should_be_aged(struct lruvec *lruvec)
+{
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+
+	/* Aging the anon LRU is valuable if swap is present: */
+	if (total_swap_pages > 0)
+		return true;
+
+	/* Also valuable if anon pages can be demoted: */
+	if (next_demotion_node(pgdat->node_id) >= 0)
+		return true;
+
+	/* No way to reclaim anon pages.  Should not age anon LRUs: */
+	return false;
+}
+
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	unsigned long nr[NR_LRU_LISTS];
@@ -2617,7 +2637,8 @@ static void shrink_lruvec(struct lruvec
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (total_swap_pages && inactive_is_low(lruvec, LRU_INACTIVE_ANON))
+	if (anon_should_be_aged(lruvec) &&
+	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
 }
@@ -3446,10 +3467,11 @@ static void age_active_anon(struct pglis
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
 
-	if (!total_swap_pages)
+	lruvec = mem_cgroup_lruvec(NULL, pgdat);
+
+	if (!anon_should_be_aged(lruvec))
 		return;
 
-	lruvec = mem_cgroup_lruvec(NULL, pgdat);
 	if (!inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		return;
 
_
