Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F56032BD68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbhCCP6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:58:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:21474 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350464AbhCCLAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:00:48 -0500
IronPort-SDR: YRvNEM5+XjKpUz8t5pQFotp/ZIaJZB5zmpk/FJK1arNerem95SowVE/HD32Bn3KEdfxlC6MmeV
 kvx0RsahEnwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174802706"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174802706"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 02:21:40 -0800
IronPort-SDR: 5Jfm/bphJbdhsQhRUAzskLG9h5ZYFkXQpu2B/9pPlpoB5A6cP+s4KMmLlXegyOf21t5Xuyt1xN
 7xz8BloUHRRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445200316"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 02:21:36 -0800
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
Subject: [PATCH v3 10/14] mm/mempolicy: VMA allocation for many preferred
Date:   Wed,  3 Mar 2021 18:20:54 +0800
Message-Id: <1614766858-90344-11-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
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
index ceee90e..0cb92ab 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2259,8 +2259,6 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 {
 	struct mempolicy *pol;
 	struct page *page;
-	int preferred_nid;
-	nodemask_t *nmask;
 
 	pol = get_vma_policy(vma, addr);
 
@@ -2274,6 +2272,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 	}
 
 	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
+		nodemask_t *nmask;
 		int hpage_node = node;
 
 		/*
@@ -2287,10 +2286,26 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
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
@@ -2316,9 +2331,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
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

