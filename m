Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA2037F390
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhEMH1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:27:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:12367 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231496AbhEMH1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:27:00 -0400
IronPort-SDR: INRg/qpeSk1USfhQeqKuMOUk27WcYswv2t5UdqknfEcPqUjt4cqRa4LVvz+Fotf6yMM0piQ0hl
 gzw7SiCCheSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187018305"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187018305"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 00:25:51 -0700
IronPort-SDR: 2/89DI7Qd1OGI7j9NFiige8lhu5wLqCqRVHcvqun/EH8D/Nuf0jCqC5ae0dTR9ETtrqNqG3CgN
 zHBogAA0x1vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="542392755"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2021 00:25:46 -0700
Date:   Thu, 13 May 2021 15:25:45 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: [RFC PATCH 2/2] mempolicy: kill MPOL_F_LOCAL bit
Message-ID: <20210513072545.GC44993@shbuild999.sh.intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-4-git-send-email-feng.tang@intel.com>
 <YHblLevoUZ6+AvVZ@dhcp22.suse.cz>
 <20210420071625.GB48282@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420071625.GB48282@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mempolicy: kill MPOL_F_LOCAL bit

Now the only remaining case of actual 'local' policy faked by
'prefer' policy plus MPOL_F_LOCAL bit is:

A valid 'prefer' policy with a valid 'preferred' node is 'rebind'
to a nodemask which doesn't contains the 'preferred' node, then it
will handle allocation with 'local' policy.

Add a new 'MPOL_F_LOCAL_TEMP' bit for this case, and kill the
MPOL_F_LOCAL bit, which could simplify the code much.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/uapi/linux/mempolicy.h |  1 +
 mm/mempolicy.c                 | 80 +++++++++++++++++++++++-------------------
 2 files changed, 45 insertions(+), 36 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 4832fd0..2f71177 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -63,6 +63,7 @@ enum {
 #define MPOL_F_LOCAL   (1 << 1)	/* preferred local allocation */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
+#define MPOL_F_LOCAL_TEMP  (1 << 5)	/* MPOL_PREFERRED policy temporarily change to MPOL_LOCAL */
 
 /*
  * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2f20f079..9cdbb78 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -332,6 +332,22 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
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
@@ -342,13 +358,19 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
 
 		if (node_isset(node, *nodes)) {
 			pol->v.preferred_node = node;
-			pol->flags &= ~MPOL_F_LOCAL;
-		} else
-			pol->flags |= MPOL_F_LOCAL;
+		} else {
+			/*
+			 * If there is no valid node, change the mode to
+			 * MPOL_LOCAL, which will be restored back when
+			 * next rebind() see a valid node.
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
@@ -367,7 +389,7 @@ static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
 {
 	if (!pol)
 		return;
-	if (!mpol_store_user_nodemask(pol) && !(pol->flags & MPOL_F_LOCAL) &&
+	if (!mpol_store_user_nodemask(pol) &&
 	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
 		return;
 
@@ -419,7 +441,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.rebind = mpol_rebind_nodemask,
 	},
 	[MPOL_LOCAL] = {
-		.rebind = mpol_rebind_default,
+		.rebind = mpol_rebind_local,
 	},
 };
 
@@ -913,10 +935,12 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
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
@@ -1888,9 +1912,9 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
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
@@ -1927,14 +1951,11 @@ unsigned int mempolicy_slab_node(void)
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
@@ -2068,16 +2089,13 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
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
@@ -2119,8 +2137,9 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 
 	switch (mempolicy->mode) {
 	case MPOL_PREFERRED:
+	case MPOL_LOCAL:
 		/*
-		 * MPOL_PREFERRED and MPOL_F_LOCAL are only preferred nodes to
+		 * MPOL_PREFERRED and MPOL_LOCAL are only preferred nodes to
 		 * allocate from, they may fallback to other nodes when oom.
 		 * Thus, it's possible for tsk to have allocated memory from
 		 * nodes in mask.
@@ -2205,7 +2224,7 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * If the policy is interleave, or does not allow the current
 		 * node in its nodemask, we allocate the standard way.
 		 */
-		if (pol->mode == MPOL_PREFERRED && !(pol->flags & MPOL_F_LOCAL))
+		if (pol->mode == MPOL_PREFERRED )
 			hpage_node = pol->v.preferred_node;
 
 		nmask = policy_nodemask(gfp, pol);
@@ -2341,9 +2360,6 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_INTERLEAVE:
 		return !!nodes_equal(a->v.nodes, b->v.nodes);
 	case MPOL_PREFERRED:
-		/* a's ->flags is the same as b's */
-		if (a->flags & MPOL_F_LOCAL)
-			return true;
 		return a->v.preferred_node == b->v.preferred_node;
 	case MPOL_LOCAL:
 		return true;
@@ -2484,10 +2500,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		break;
 
 	case MPOL_PREFERRED:
-		if (pol->flags & MPOL_F_LOCAL)
-			polnid = numa_node_id();
-		else
-			polnid = pol->v.preferred_node;
+		polnid = pol->v.preferred_node;
 		break;
 
 	case MPOL_LOCAL:
@@ -2858,9 +2871,6 @@ void numa_default_policy(void)
  * Parse and format mempolicy from/to strings
  */
 
-/*
- * "local" is implemented internally by MPOL_PREFERRED with MPOL_F_LOCAL flag.
- */
 static const char * const policy_modes[] =
 {
 	[MPOL_DEFAULT]    = "default",
@@ -3027,12 +3037,10 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 
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

