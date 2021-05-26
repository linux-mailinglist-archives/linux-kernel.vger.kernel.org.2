Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E98390FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 07:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhEZFDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 01:03:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:29582 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhEZFDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 01:03:39 -0400
IronPort-SDR: +sG/1fdmgSrwisBrG+z4/GRZp8BAHC9GdRDm2CXAnfEtwKY1rnRxqIMMyVanmjFINMn4B106vP
 cmKd1Qliy4/A==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="202395919"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="202395919"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 22:02:05 -0700
IronPort-SDR: DhbrCxNEq6gxkIKSq9OyZS9MbW0Q5HHyQY9MnRyocXoBhKT3wngJ0JnXf6oMiCRifgXF0ycl2V
 +cR+FD+x+aQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="479700325"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 22:02:02 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v1 4/4] mm/mempolicy: kill MPOL_F_LOCAL bit
Date:   Wed, 26 May 2021 13:01:42 +0800
Message-Id: <1622005302-23027-5-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the only remaining case of a real 'local' policy faked by
'prefer' policy plus MPOL_F_LOCAL bit is:

A valid 'prefer' policy with a valid 'preferred' node is 'rebind'
to a nodemask which doesn't contains the 'preferred' node, then it
will handle allocation with 'local' policy.

Add a new 'MPOL_F_LOCAL_TEMP' bit for this case, and kill the
MPOL_F_LOCAL bit, which could simplify the code much.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/uapi/linux/mempolicy.h |  1 +
 mm/mempolicy.c                 | 77 +++++++++++++++++++++++-------------------
 2 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 4832fd0..942844a 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -63,6 +63,7 @@ enum {
 #define MPOL_F_LOCAL   (1 << 1)	/* preferred local allocation */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
+#define MPOL_F_LOCAL_TEMP  (1 << 5) /* a policy temporarily changed from 'prefer' to 'local' */
 
 /*
  * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d97839d..6046196 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -337,6 +337,22 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 	pol->v.nodes = tmp;
 }
 
+static void mpol_rebind_local(struct mempolicy *pol,
+				const nodemask_t *nodes)
+{
+	if (unlikely(pol->flags & MPOL_F_STATIC_NODES)) {
+		int node = first_node(pol->w.user_nodemask);
+
+		BUG_ON(!(pol->flags & MPOL_F_LOCAL_TEMP));
+
+		if (node_isset(node, *nodes)) {
+			pol->v.preferred_node = node;
+			pol->mode = MPOL_PREFERRED;
+			pol->flags &= ~MPOL_F_LOCAL_TEMP;
+		}
+	}
+}
+
 static void mpol_rebind_preferred(struct mempolicy *pol,
 						const nodemask_t *nodes)
 {
@@ -347,13 +363,19 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
 
 		if (node_isset(node, *nodes)) {
 			pol->v.preferred_node = node;
-			pol->flags &= ~MPOL_F_LOCAL;
-		} else
-			pol->flags |= MPOL_F_LOCAL;
+		} else {
+			/*
+			 * If there is no valid node, change the mode to
+			 * MPOL_LOCAL, which will be restored back when
+			 * next rebind() sees a valid node.
+			 */
+			pol->mode = MPOL_LOCAL;
+			pol->flags |= MPOL_F_LOCAL_TEMP;
+		}
 	} else if (pol->flags & MPOL_F_RELATIVE_NODES) {
 		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
 		pol->v.preferred_node = first_node(tmp);
-	} else if (!(pol->flags & MPOL_F_LOCAL)) {
+	} else {
 		pol->v.preferred_node = node_remap(pol->v.preferred_node,
 						   pol->w.cpuset_mems_allowed,
 						   *nodes);
@@ -372,7 +394,7 @@ static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
 {
 	if (!pol)
 		return;
-	if (!mpol_store_user_nodemask(pol) && !(pol->flags & MPOL_F_LOCAL) &&
+	if (!mpol_store_user_nodemask(pol) &&
 	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
 		return;
 
@@ -425,7 +447,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 	},
 	[MPOL_LOCAL] = {
 		.create = mpol_new_local,
-		.rebind = mpol_rebind_default,
+		.rebind = mpol_rebind_local,
 	},
 };
 
@@ -919,10 +941,12 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	case MPOL_INTERLEAVE:
 		*nodes = p->v.nodes;
 		break;
+	case MPOL_LOCAL:
+		/* return empty node mask for local allocation */
+		break;
+
 	case MPOL_PREFERRED:
-		if (!(p->flags & MPOL_F_LOCAL))
-			node_set(p->v.preferred_node, *nodes);
-		/* else return empty node mask for local allocation */
+		node_set(p->v.preferred_node, *nodes);
 		break;
 	default:
 		BUG();
@@ -1899,9 +1923,9 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 /* Return the node id preferred by the given mempolicy, or the given id */
 static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
 {
-	if (policy->mode == MPOL_PREFERRED && !(policy->flags & MPOL_F_LOCAL))
+	if (policy->mode == MPOL_PREFERRED) {
 		nd = policy->v.preferred_node;
-	else {
+	} else {
 		/*
 		 * __GFP_THISNODE shouldn't even be used with the bind policy
 		 * because we might easily break the expectation to stay on the
@@ -1938,14 +1962,11 @@ unsigned int mempolicy_slab_node(void)
 		return node;
 
 	policy = current->mempolicy;
-	if (!policy || policy->flags & MPOL_F_LOCAL)
+	if (!policy)
 		return node;
 
 	switch (policy->mode) {
 	case MPOL_PREFERRED:
-		/*
-		 * handled MPOL_F_LOCAL above
-		 */
 		return policy->v.preferred_node;
 
 	case MPOL_INTERLEAVE:
@@ -2079,16 +2100,13 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
 	case MPOL_PREFERRED:
-		if (mempolicy->flags & MPOL_F_LOCAL)
-			nid = numa_node_id();
-		else
-			nid = mempolicy->v.preferred_node;
+		nid = mempolicy->v.preferred_node;
 		init_nodemask_of_node(mask, nid);
 		break;
 
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		*mask =  mempolicy->v.nodes;
+		*mask = mempolicy->v.nodes;
 		break;
 
 	case MPOL_LOCAL:
@@ -2200,7 +2218,7 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * If the policy is interleave, or does not allow the current
 		 * node in its nodemask, we allocate the standard way.
 		 */
-		if (pol->mode == MPOL_PREFERRED && !(pol->flags & MPOL_F_LOCAL))
+		if (pol->mode == MPOL_PREFERRED)
 			hpage_node = pol->v.preferred_node;
 
 		nmask = policy_nodemask(gfp, pol);
@@ -2336,9 +2354,6 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_INTERLEAVE:
 		return !!nodes_equal(a->v.nodes, b->v.nodes);
 	case MPOL_PREFERRED:
-		/* a's ->flags is the same as b's */
-		if (a->flags & MPOL_F_LOCAL)
-			return true;
 		return a->v.preferred_node == b->v.preferred_node;
 	case MPOL_LOCAL:
 		return true;
@@ -2479,10 +2494,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		break;
 
 	case MPOL_PREFERRED:
-		if (pol->flags & MPOL_F_LOCAL)
-			polnid = numa_node_id();
-		else
-			polnid = pol->v.preferred_node;
+		polnid = pol->v.preferred_node;
 		break;
 
 	case MPOL_LOCAL:
@@ -2853,9 +2865,6 @@ void numa_default_policy(void)
  * Parse and format mempolicy from/to strings
  */
 
-/*
- * "local" is implemented internally by MPOL_PREFERRED with MPOL_F_LOCAL flag.
- */
 static const char * const policy_modes[] =
 {
 	[MPOL_DEFAULT]    = "default",
@@ -3022,12 +3031,10 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 
 	switch (mode) {
 	case MPOL_DEFAULT:
+	case MPOL_LOCAL:
 		break;
 	case MPOL_PREFERRED:
-		if (flags & MPOL_F_LOCAL)
-			mode = MPOL_LOCAL;
-		else
-			node_set(pol->v.preferred_node, nodes);
+		node_set(pol->v.preferred_node, nodes);
 		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-- 
2.7.4

