Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B98132DE2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 01:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbhCEAA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 19:00:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:20843 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhCEAAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 19:00:55 -0500
IronPort-SDR: hcUwStuTMKn2n1Ox8GoyuUp2+5bFNjOJY+J8M6BFTNMIW5PETMCAg/uzI62QxhJapOHSnyUtcI
 Ns69OnVdJ9zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="272534078"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="272534078"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 16:00:55 -0800
IronPort-SDR: IIrHKLv/Wbw781jrLXP6GGfcAJlfl0o9ZnUffbWw0Ke+Yb4AZjJaCp5TBcrfIVW05FRDUp2ct8
 QOsGwLB1Skwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="428851624"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2021 16:00:54 -0800
Subject: [PATCH 07/10] mm/vmscan: add helper for querying ability to age anonymous pages
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        rientjes@google.com, ying.huang@intel.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 04 Mar 2021 16:00:02 -0800
References: <20210304235949.7922C1C3@viggo.jf.intel.com>
In-Reply-To: <20210304235949.7922C1C3@viggo.jf.intel.com>
Message-Id: <20210305000002.D171810D@viggo.jf.intel.com>
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
Cc: David Rientjes <rientjes@google.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: osalvador <osalvador@suse.de>
---

 b/mm/vmscan.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff -puN mm/vmscan.c~mm-vmscan-anon-can-be-aged mm/vmscan.c
--- a/mm/vmscan.c~mm-vmscan-anon-can-be-aged	2021-03-04 15:35:58.935806422 -0800
+++ b/mm/vmscan.c	2021-03-04 15:35:58.942806422 -0800
@@ -2517,6 +2517,26 @@ out:
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
@@ -2626,7 +2646,8 @@ static void shrink_lruvec(struct lruvec
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (total_swap_pages && inactive_is_low(lruvec, LRU_INACTIVE_ANON))
+	if (anon_should_be_aged(lruvec) &&
+	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
 }
@@ -3455,10 +3476,11 @@ static void age_active_anon(struct pglis
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
