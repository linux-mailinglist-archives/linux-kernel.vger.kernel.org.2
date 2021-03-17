Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5844533E7D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhCQDlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:41:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:57774 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhCQDky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:40:54 -0400
IronPort-SDR: NoUvEeOvSZk0d8EX8EoqmMFnFvn1L6Rxil8sz2zs8cxPKjeCYNdMuFYqUlW+rdk4M3EuF5wEDq
 OA/HSxFlZKIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="274426039"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="274426039"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:40:53 -0700
IronPort-SDR: 4vwbH6Z/ahRYL2orn84BJ3eInG5KLsKjmAHC/BYgdECvLTe5fkHBq8b0NeMhOQ3DrEzBCTfLMU
 TaPTbpRhSrng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602076014"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 20:40:47 -0700
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
Subject: [PATCH v4 10/13] mm/mempolicy: VMA allocation for many preferred
Date:   Wed, 17 Mar 2021 11:40:07 +0800
Message-Id: <1615952410-36895-11-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

This patch implements MPOL_PREFERRED_MANY for alloc_pages_vma(). Like
alloc_pages_current(), alloc_pages_vma() needs to support policy based
decisions if they've been configured via mbind(2).

The temporary "hack" of treating MPOL_PREFERRED and MPOL_PREFERRED_MANY
can now be removed with this, too.

All the actual machinery to make this work was part of
("mm/mempolicy: Create a page allocator for policy")

Link: https://lore.kernel.org/r/20200630212517.308045-11-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a92efe7..8fe76a7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2273,8 +2273,6 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 {
 	struct mempolicy *pol;
 	struct page *page;
-	int preferred_nid;
-	nodemask_t *nmask;
 
 	pol = get_vma_policy(vma, addr);
 
@@ -2288,6 +2286,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 	}
 
 	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
+		nodemask_t *nmask;
 		int hpage_node = node;
 
 		/*
@@ -2301,10 +2300,26 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * does not allow the current node in its nodemask, we allocate
 		 * the standard way.
 		 */
-		if ((pol->mode == MPOL_PREFERRED ||
-		     pol->mode == MPOL_PREFERRED_MANY) &&
-		    !(pol->flags & MPOL_F_LOCAL))
+		if (pol->mode == MPOL_PREFERRED || !(pol->flags & MPOL_F_LOCAL)) {
 			hpage_node = first_node(pol->nodes);
+		} else if (pol->mode == MPOL_PREFERRED_MANY) {
+			struct zoneref *z;
+
+			/*
+			 * In this policy, with direct reclaim, the normal
+			 * policy based allocation will do the right thing - try
+			 * twice using the preferred nodes first, and all nodes
+			 * second.
+			 */
+			if (gfp & __GFP_DIRECT_RECLAIM) {
+				page = alloc_pages_policy(pol, gfp, order, NUMA_NO_NODE);
+				goto out;
+			}
+
+			z = first_zones_zonelist(node_zonelist(numa_node_id(), GFP_HIGHUSER),
+						 gfp_zone(GFP_HIGHUSER), &pol->nodes);
+			hpage_node = zone_to_nid(z->zone);
+		}
 
 		nmask = policy_nodemask(gfp, pol);
 		if (!nmask || node_isset(hpage_node, *nmask)) {
@@ -2330,9 +2345,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		}
 	}
 
-	nmask = policy_nodemask(gfp, pol);
-	preferred_nid = policy_node(gfp, pol, node);
-	page = __alloc_pages_nodemask(gfp, order, preferred_nid, nmask);
+	page = alloc_pages_policy(pol, gfp, order, NUMA_NO_NODE);
 	mpol_cond_put(pol);
 out:
 	return page;
-- 
2.7.4

