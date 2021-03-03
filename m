Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3A232BD59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452482AbhCCPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:51:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:57266 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383117AbhCCKuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:50:37 -0500
IronPort-SDR: SPdeQfjIsNkHQyjMJF74OqmYfYIRTn4PxS2aj2nj3yusrPjLXVrwgTdm8/2xw8FMMdi+HvOUrg
 9gBLZW5mZEVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174802618"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174802618"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 02:21:14 -0800
IronPort-SDR: HFMXJJmFdTgCDnHo3vKHCM4nuKMwa7AL9OpxQf7jMO04J3VuYt9nOMvdfSbBt9kGgU2l1Jrt5E
 at3X+BkJf7oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445200101"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 02:21:10 -0800
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3 03/14] mm/mempolicy: Add MPOL_PREFERRED_MANY for multiple preferred nodes
Date:   Wed,  3 Mar 2021 18:20:47 +0800
Message-Id: <1614766858-90344-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
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
index 8f4a32a..79258b2 100644
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
@@ -914,6 +923,9 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	case MPOL_INTERLEAVE:
 		*nodes = p->v.nodes;
 		break;
+	case MPOL_PREFERRED_MANY:
+		*nodes = p->v.preferred_nodes;
+		break;
 	case MPOL_PREFERRED:
 		if (!(p->flags & MPOL_F_LOCAL))
 			*nodes = p->v.preferred_nodes;
@@ -1885,7 +1897,9 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
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
@@ -1928,6 +1942,7 @@ unsigned int mempolicy_slab_node(void)
 		return node;
 
 	switch (policy->mode) {
+	case MPOL_PREFERRED_MANY:
 	case MPOL_PREFERRED:
 		/*
 		 * handled MPOL_F_LOCAL above
@@ -2062,6 +2077,9 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	task_lock(current);
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
+	case MPOL_PREFERRED_MANY:
+		*mask = mempolicy->v.preferred_nodes;
+		break;
 	case MPOL_PREFERRED:
 		if (mempolicy->flags & MPOL_F_LOCAL)
 			nid = numa_node_id();
@@ -2116,6 +2134,9 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 		 * nodes in mask.
 		 */
 		break;
+	case MPOL_PREFERRED_MANY:
+		ret = nodes_intersects(mempolicy->v.preferred_nodes, *mask);
+		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		ret = nodes_intersects(mempolicy->v.nodes, *mask);
@@ -2200,10 +2221,13 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
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
@@ -2339,6 +2363,9 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		return !!nodes_equal(a->v.nodes, b->v.nodes);
+	case MPOL_PREFERRED_MANY:
+		return !!nodes_equal(a->v.preferred_nodes,
+				     b->v.preferred_nodes);
 	case MPOL_PREFERRED:
 		/* a's ->flags is the same as b's */
 		if (a->flags & MPOL_F_LOCAL)
@@ -2507,6 +2534,8 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		polnid = zone_to_nid(z->zone);
 		break;
 
+		/* case MPOL_PREFERRED_MANY: */
+
 	default:
 		BUG();
 	}
@@ -2858,6 +2887,7 @@ static const char * const policy_modes[] =
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
 	[MPOL_LOCAL]      = "local",
+	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
 
 
@@ -2937,6 +2967,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		if (!nodelist)
 			err = 0;
 		goto out;
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 		/*
 		 * Insist on a nodelist
@@ -3019,6 +3050,9 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
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

