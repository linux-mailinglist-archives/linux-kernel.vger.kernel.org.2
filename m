Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6379F33E7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCQDkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:40:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:48803 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhCQDkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:40:25 -0400
IronPort-SDR: VNNfmG3W3as8ekVPrA2R8NrxcP+ZafOAfTl7ELCHzrDYq1ycqB0HNPedterC7+EpomW8+QRFDf
 ptJOlirEN1uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="186021870"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="186021870"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:40:25 -0700
IronPort-SDR: /bYkgj9pbrV3Px6aALK4/i/Owmy0VW7vzNn5MLNCAPLYv3AtnrFbdchpEj+k3iB3hWFXYO6TeK
 SBJ+IaMNBX7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602075824"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 20:40:22 -0700
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v4 03/13] mm/mempolicy: Add MPOL_PREFERRED_MANY for multiple preferred nodes
Date:   Wed, 17 Mar 2021 11:40:00 +0800
Message-Id: <1615952410-36895-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

MPOL_PREFERRED honors only a single node set in the nodemask.  Add the
bare define for a new mode which will allow more than one.

The patch does all the plumbing without actually adding the new policy
type.

v2:
Plumb most MPOL_PREFERRED_MANY without exposing UAPI (Ben)
Fixes for checkpatch (Ben)

Link: https://lore.kernel.org/r/20200630212517.308045-4-ben.widawsky@intel.com
Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2b1e0e4..1228d8e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -31,6 +31,9 @@
  *                but useful to set in a VMA when you have a non default
  *                process policy.
  *
+ * preferred many Try a set of nodes first before normal fallback. This is
+ *                similar to preferred without the special case.
+ *
  * default        Allocate on the local node first, or when on a VMA
  *                use the process policy. This is what Linux always did
  *		  in a NUMA aware kernel and still does by, ahem, default.
@@ -105,6 +108,8 @@
 
 #include "internal.h"
 
+#define MPOL_PREFERRED_MANY MPOL_MAX
+
 /* Internal flags */
 #define MPOL_MF_DISCONTIG_OK (MPOL_MF_INTERNAL << 0)	/* Skip checks for continuous vmas */
 #define MPOL_MF_INVERT (MPOL_MF_INTERNAL << 1)		/* Invert check for nodemask */
@@ -175,7 +180,7 @@ struct mempolicy *get_task_policy(struct task_struct *p)
 static const struct mempolicy_operations {
 	int (*create)(struct mempolicy *pol, const nodemask_t *nodes);
 	void (*rebind)(struct mempolicy *pol, const nodemask_t *nodes);
-} mpol_ops[MPOL_MAX];
+} mpol_ops[MPOL_MAX + 1];
 
 static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
 {
@@ -415,7 +420,7 @@ void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 	mmap_write_unlock(mm);
 }
 
-static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
+static const struct mempolicy_operations mpol_ops[MPOL_MAX + 1] = {
 	[MPOL_DEFAULT] = {
 		.rebind = mpol_rebind_default,
 	},
@@ -432,6 +437,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.rebind = mpol_rebind_nodemask,
 	},
 	/* [MPOL_LOCAL] - see mpol_new() */
+	[MPOL_PREFERRED_MANY] = {
+		.create = NULL,
+		.rebind = NULL,
+	},
 };
 
 static int migrate_page_add(struct page *page, struct list_head *pagelist,
@@ -924,6 +933,9 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	case MPOL_INTERLEAVE:
 		*nodes = p->v.nodes;
 		break;
+	case MPOL_PREFERRED_MANY:
+		*nodes = p->v.preferred_nodes;
+		break;
 	case MPOL_PREFERRED:
 		if (!(p->flags & MPOL_F_LOCAL))
 			*nodes = p->v.preferred_nodes;
@@ -1895,7 +1907,9 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 /* Return the node id preferred by the given mempolicy, or the given id */
 static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 {
-	if (policy->mode == MPOL_PREFERRED && !(policy->flags & MPOL_F_LOCAL)) {
+	if ((policy->mode == MPOL_PREFERRED ||
+	     policy->mode == MPOL_PREFERRED_MANY) &&
+	    !(policy->flags & MPOL_F_LOCAL)) {
 		nd = first_node(policy->v.preferred_nodes);
 	} else {
 		/*
@@ -1938,6 +1952,7 @@ unsigned int mempolicy_slab_node(void)
 		return node;
 
 	switch (policy->mode) {
+	case MPOL_PREFERRED_MANY:
 	case MPOL_PREFERRED:
 		/*
 		 * handled MPOL_F_LOCAL above
@@ -2072,6 +2087,9 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	task_lock(current);
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
+	case MPOL_PREFERRED_MANY:
+		*mask = mempolicy->v.preferred_nodes;
+		break;
 	case MPOL_PREFERRED:
 		if (mempolicy->flags & MPOL_F_LOCAL)
 			nid = numa_node_id();
@@ -2126,6 +2144,9 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 		 * nodes in mask.
 		 */
 		break;
+	case MPOL_PREFERRED_MANY:
+		ret = nodes_intersects(mempolicy->v.preferred_nodes, *mask);
+		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		ret = nodes_intersects(mempolicy->v.nodes, *mask);
@@ -2210,10 +2231,13 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * node and don't fall back to other nodes, as the cost of
 		 * remote accesses would likely offset THP benefits.
 		 *
-		 * If the policy is interleave, or does not allow the current
-		 * node in its nodemask, we allocate the standard way.
+		 * If the policy is interleave or multiple preferred nodes, or
+		 * does not allow the current node in its nodemask, we allocate
+		 * the standard way.
 		 */
-		if (pol->mode == MPOL_PREFERRED && !(pol->flags & MPOL_F_LOCAL))
+		if ((pol->mode == MPOL_PREFERRED ||
+		     pol->mode == MPOL_PREFERRED_MANY) &&
+		    !(pol->flags & MPOL_F_LOCAL))
 			hpage_node = first_node(pol->v.preferred_nodes);
 
 		nmask = policy_nodemask(gfp, pol);
@@ -2349,6 +2373,9 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		return !!nodes_equal(a->v.nodes, b->v.nodes);
+	case MPOL_PREFERRED_MANY:
+		return !!nodes_equal(a->v.preferred_nodes,
+				     b->v.preferred_nodes);
 	case MPOL_PREFERRED:
 		/* a's ->flags is the same as b's */
 		if (a->flags & MPOL_F_LOCAL)
@@ -2523,6 +2550,8 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		polnid = zone_to_nid(z->zone);
 		break;
 
+		/* case MPOL_PREFERRED_MANY: */
+
 	default:
 		BUG();
 	}
@@ -2874,6 +2903,7 @@ static const char * const policy_modes[] =
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
 	[MPOL_LOCAL]      = "local",
+	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
 
 
@@ -2953,6 +2983,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		if (!nodelist)
 			err = 0;
 		goto out;
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 		/*
 		 * Insist on a nodelist
@@ -3035,6 +3066,9 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	switch (mode) {
 	case MPOL_DEFAULT:
 		break;
+	case MPOL_PREFERRED_MANY:
+		WARN_ON(flags & MPOL_F_LOCAL);
+		fallthrough;
 	case MPOL_PREFERRED:
 		if (flags & MPOL_F_LOCAL)
 			mode = MPOL_LOCAL;
-- 
2.7.4

