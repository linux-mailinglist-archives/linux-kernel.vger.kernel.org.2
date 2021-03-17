Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87D33E7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCQDlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:41:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:48803 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhCQDkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:40:43 -0400
IronPort-SDR: RNoEvPULR0JG16L62qalz8gqGfY6hO5+2OrkipSpiY1ue24Osc2KzkkDS5KRZ23XIcK7gCtp41
 2YGBOk/8lniA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="186021892"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="186021892"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:40:43 -0700
IronPort-SDR: gOh4cGWysJyppcFDDpf/okBQ9aviOEoKXOr3vICqoZYKkIwy4fzUG2+muI6VcsGKesrr8O1RoF
 XwwVj6UAOBYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602075935"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 20:40:39 -0700
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
Subject: [PATCH v4 08/13] mm/mempolicy: Create a page allocator for policy
Date:   Wed, 17 Mar 2021 11:40:05 +0800
Message-Id: <1615952410-36895-9-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Add a helper function which takes care of handling multiple preferred
nodes. It will be called by future patches that need to handle this,
specifically VMA based page allocation, and task based page allocation.
Huge pages don't quite fit the same pattern because they use different
underlying page allocation functions. This consumes the previous
interleave policy specific allocation function to make a one stop shop
for policy based allocation.

With this, MPOL_PREFERRED_MANY's semantic is more like MPOL_PREFERRED
that it will first try the preferred node/nodes, and fallback to all
other nodes when first try fails. Thanks to Michal Hocko for suggestions
on this.

For now, only interleaved policy will be used so there should be no
functional change yet. However, if bisection points to issues in the
next few commits, it was likely the fault of this patch.

Similar functionality is offered via policy_node() and
policy_nodemask(). By themselves however, neither can achieve this
fallback style of sets of nodes.

[ Feng: for the first try, add NOWARN flag, and skip the direct reclaim
  to speedup allocation in some case ]

Link: https://lore.kernel.org/r/20200630212517.308045-9-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d945f29..d21105b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2187,22 +2187,60 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 	return ret;
 }
 
-/* Allocate a page in interleaved policy.
-   Own path because it needs to do special accounting. */
-static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
-					unsigned nid)
+/* Handle page allocation for all but interleaved policies */
+static struct page *alloc_pages_policy(struct mempolicy *pol, gfp_t gfp,
+				       unsigned int order, int preferred_nid)
 {
 	struct page *page;
+	gfp_t gfp_mask = gfp;
 
-	page = __alloc_pages(gfp, order, nid);
-	/* skip NUMA_INTERLEAVE_HIT counter update if numa stats is disabled */
-	if (!static_branch_likely(&vm_numa_stat_key))
+	if (pol->mode == MPOL_INTERLEAVE) {
+		page = __alloc_pages(gfp, order, preferred_nid);
+		/* skip NUMA_INTERLEAVE_HIT counter update if numa stats is disabled */
+		if (!static_branch_likely(&vm_numa_stat_key))
+			return page;
+		if (page && page_to_nid(page) == preferred_nid) {
+			preempt_disable();
+			__inc_numa_state(page_zone(page), NUMA_INTERLEAVE_HIT);
+			preempt_enable();
+		}
 		return page;
-	if (page && page_to_nid(page) == nid) {
-		preempt_disable();
-		__inc_numa_state(page_zone(page), NUMA_INTERLEAVE_HIT);
-		preempt_enable();
 	}
+
+	VM_BUG_ON(preferred_nid != NUMA_NO_NODE);
+
+	preferred_nid = numa_node_id();
+
+	/*
+	 * There is a two pass approach implemented here for
+	 * MPOL_PREFERRED_MANY. In the first pass we try the preferred nodes
+	 * but allow the allocation to fail. The below table explains how
+	 * this is achieved.
+	 *
+	 * | Policy                        | preferred nid | nodemask   |
+	 * |-------------------------------|---------------|------------|
+	 * | MPOL_DEFAULT                  | local         | NULL       |
+	 * | MPOL_PREFERRED                | best          | NULL       |
+	 * | MPOL_INTERLEAVE               | ERR           | ERR        |
+	 * | MPOL_BIND                     | local         | pol->nodes |
+	 * | MPOL_PREFERRED_MANY           | best          | pol->nodes |
+	 * | MPOL_PREFERRED_MANY (round 2) | local         | NULL       |
+	 * +-------------------------------+---------------+------------+
+	 */
+	if (pol->mode == MPOL_PREFERRED_MANY) {
+		gfp_mask |=  __GFP_NOWARN;
+
+		/* Skip direct reclaim, as there will be a second try */
+		gfp_mask &= ~__GFP_DIRECT_RECLAIM;
+	}
+
+	page = __alloc_pages_nodemask(gfp_mask, order,
+				      policy_node(gfp, pol, preferred_nid),
+				      policy_nodemask(gfp, pol));
+
+	if (unlikely(!page && pol->mode == MPOL_PREFERRED_MANY))
+		page = __alloc_pages_nodemask(gfp, order, preferred_nid, NULL);
+
 	return page;
 }
 
@@ -2244,8 +2282,8 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned nid;
 
 		nid = interleave_nid(pol, vma, addr, PAGE_SHIFT + order);
+		page = alloc_pages_policy(pol, gfp, order, nid);
 		mpol_cond_put(pol);
-		page = alloc_page_interleave(gfp, order, nid);
 		goto out;
 	}
 
@@ -2329,7 +2367,8 @@ struct page *alloc_pages_current(gfp_t gfp, unsigned order)
 	 * nor system default_policy
 	 */
 	if (pol->mode == MPOL_INTERLEAVE)
-		page = alloc_page_interleave(gfp, order, interleave_nodes(pol));
+		page = alloc_pages_policy(pol, gfp, order,
+					  interleave_nodes(pol));
 	else
 		page = __alloc_pages_nodemask(gfp, order,
 				policy_node(gfp, pol, numa_node_id()),
-- 
2.7.4

