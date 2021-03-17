Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A9133E7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCQDlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:41:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:57774 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhCQDk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:40:57 -0400
IronPort-SDR: bCOcquYUwdNo/I11qGXeq6UX4D43sCes42JbEazFD8NmkjaN4uA493DlshnSg0VGvN81dW3P7S
 GfHA2UMb/P/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="274426054"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="274426054"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:40:57 -0700
IronPort-SDR: D4DIn8Q1zHs7AzCJq/fLGQ0WGwcybIcZdIIeXYqq/rGoySNanbHfI2piUeHNDAyIsmth+LpUvI
 TeYAcNkulFQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602076048"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 20:40:53 -0700
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
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v4 11/13] mm/mempolicy: huge-page allocation for many preferred
Date:   Wed, 17 Mar 2021 11:40:08 +0800
Message-Id: <1615952410-36895-12-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
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

[ feng: add NOWARN flag, and skip the direct reclaim to speedup allocation
  in some case ]

Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/hugetlb.c   | 26 +++++++++++++++++++++++---
 mm/mempolicy.c |  3 ++-
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8fb42c6..9dfbfa3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1105,7 +1105,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 				unsigned long address, int avoid_reserve,
 				long chg)
 {
-	struct page *page;
+	struct page *page = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask;
 	nodemask_t *nodemask;
@@ -1126,7 +1126,17 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
-	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
+		gfp_t gfp_mask1 = gfp_mask | __GFP_NOWARN;
+
+		gfp_mask1 &= ~__GFP_DIRECT_RECLAIM;
+		page = dequeue_huge_page_nodemask(h,
+				gfp_mask1, nid, nodemask);
+		if (!page)
+			page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
+	} else {
+		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
+	}
 	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
 		SetHPageRestoreReserve(page);
 		h->resv_huge_pages--;
@@ -1883,7 +1893,17 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 	nodemask_t *nodemask;
 
 	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
-	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
+		gfp_t gfp_mask1 = gfp_mask | __GFP_NOWARN;
+
+		gfp_mask1 &= ~__GFP_DIRECT_RECLAIM;
+		page = alloc_surplus_huge_page(h,
+				gfp_mask1, nid, nodemask);
+		if (!page)
+			alloc_surplus_huge_page(h, gfp_mask, nid, NULL);
+	} else {
+		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
+	}
 	mpol_cond_put(mpol);
 
 	return page;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8fe76a7..40d32cb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2085,7 +2085,8 @@ int huge_node(struct vm_area_struct *vma, unsigned long addr, gfp_t gfp_flags,
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

