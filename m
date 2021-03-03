Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BADC32BD5E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452614AbhCCPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:52:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:21474 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232430AbhCCLF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:05:57 -0500
IronPort-SDR: xAP99qYVDlmXtXUKlc23OCXXwDqE9+1NdZxUL97XNQ23oBAjf1i/ei9nmVatymAAfjHhKnw0Fp
 GOYADruFyJyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174802716"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174802716"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 02:21:43 -0800
IronPort-SDR: HSu42u1kR4AT0B/qmPXrhnbj0wc+SCAlWmoRFD5p1Cpw98kRJxD/KS6MWKHHgsiv8vTUx6hXd6
 EiJ4XxVn+A5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445200345"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 02:21:40 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi leen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 11/14] mm/mempolicy: huge-page allocation for many preferred
Date:   Wed,  3 Mar 2021 18:20:55 +0800
Message-Id: <1614766858-90344-12-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Implement the missing huge page allocation functionality while obeying
the preferred node semantics.

This uses a fallback mechanism to try multiple preferred nodes first,
and then all other nodes. It cannot use the helper function that was
introduced because huge page allocation already has its own helpers and
it was more LOC, and effort to try to consolidate that.

The weirdness is MPOL_PREFERRED_MANY can't be called yet because it is
part of the UAPI we haven't yet exposed. Instead of make that define
global, it's simply changed with the UAPI patch.

v3: add __GFP_NOWARN for first try of prefer_many allocation (Feng)

Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/hugetlb.c   | 22 +++++++++++++++++++---
 mm/mempolicy.c |  3 ++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4bdb58a..c7c9ef3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1110,7 +1110,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 				unsigned long address, int avoid_reserve,
 				long chg)
 {
-	struct page *page;
+	struct page *page = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask;
 	nodemask_t *nodemask;
@@ -1131,7 +1131,15 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
+		page = dequeue_huge_page_nodemask(h,
+				gfp_mask | __GFP_RETRY_MAYFAIL | __GFP_NOWARN,
+				nid, nodemask);
+		if (!page)
+			page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
+	} else {
+		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	}
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
 		SetPagePrivate(page);
 		h->resv_huge_pages--;
@@ -1935,7 +1943,15 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	nodemask_t *nodemask;
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
-	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
+		page = alloc_surplus_huge_page(h,
+				gfp_mask | __GFP_RETRY_MAYFAIL | __GFP_NOWARN,
+				nid, nodemask);
+		if (!page)
+			alloc_surplus_huge_page(h, gfp_mask, nid, NULL);
+	} else {
+		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	}
 	mpol_cond_put(mpol);
 
 	return page;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0cb92ab..f9b2167 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2075,7 +2075,8 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
 					huge_page_shift(hstate_vma(vma)));
 	} else {
 		nid = policy_node(gfp_flags, *mpol, numa_node_id());
-		if ((*mpol)->mode == MPOL_BIND)
+		if ((*mpol)->mode == MPOL_BIND ||
+		    (*mpol)->mode == MPOL_PREFERRED_MANY)
 			*nodemask = &(*mpol)->nodes;
 	}
 	return nid;
-- 
2.7.4

