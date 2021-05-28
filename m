Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107223943CA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhE1OI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:08:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:63291 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhE1OIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:08:50 -0400
IronPort-SDR: +yGYn+A0i1XHcJi95swMeJuEPDAg2ZFmNpf3TdTLhREKaf4IGzmiG6GoyJbRIC9NjeHLNXKU4h
 PCVNsYITfzpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9998"; a="202734930"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="202734930"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 07:07:15 -0700
IronPort-SDR: GBw+ws5G6JB6/9mkIZj2InyUOkDjTZoY3BtWlyPqF9WCTIhda0x+ZpuyOOrPcq2IzI7Oqh0IqM
 OQR2hLMIkBNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="481059680"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 28 May 2021 07:07:12 -0700
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
Subject: [v2 PATCH 2/3] mm/mempolicy: don't handle MPOL_LOCAL like a fake MPOL_PREFERRED policy
Date:   Fri, 28 May 2021 22:07:02 +0800
Message-Id: <1622210823-61911-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622210823-61911-1-git-send-email-feng.tang@intel.com>
References: <1622210823-61911-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPOL_LOCAL policy has been setup as a real policy, but it is still
handled like a faked POL_PREFERRED policy with one internal
MPOL_F_LOCAL flag bit set, and there are many places having to
judge the real 'prefer' or the 'local' policy, which are quite
confusing.

In current code, there are 4 cases that MPOL_LOCAL are used:
1. user specifies 'local' policy
2. user specifies 'prefer' policy, but with empty nodemask
3. system 'default' policy is used
4. 'prefer' policy + valid 'preferred' node with MPOL_F_STATIC_NODES
   flag set, and when it is 'rebind' to a nodemask which doesn't
   contains the 'preferred' node, it will perform as 'local' policy

So make 'local' a real policy instead of a fake 'prefer' one, and kill
MPOL_F_LOCAL bit, which can greatly reduce the confusion for code
reading.

For case 4, in theory it used to be able to be changed back to
'prefer' policy if it is rebind to a valid nodemask for the second
time, but that will involves dirty tricky manipulation and is kind
of over-engineering, as 'perfer' is just a hint and if it is once
rebind to an invalid nodemask and acts as 'local', it doesn't make
much sense to stick to underlying 'prefer' policy. So just handle
it as 'local' policy.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/uapi/linux/mempolicy.h |   1 -
 mm/mempolicy.c                 | 124 +++++++++++++++++++++--------------------
 2 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 4832fd0..19a00bc 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -60,7 +60,6 @@ enum {
  * are never OR'ed into the mode in mempolicy API arguments.
  */
 #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
-#define MPOL_F_LOCAL   (1 << 1)	/* preferred local allocation */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6795a6a..f9ab05b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -121,8 +121,7 @@ enum zone_type policy_zone = 0;
  */
 static struct mempolicy default_policy = {
 	.refcnt = ATOMIC_INIT(1), /* never free it */
-	.mode = MPOL_PREFERRED,
-	.flags = MPOL_F_LOCAL,
+	.mode = MPOL_LOCAL,
 };
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
@@ -200,12 +199,9 @@ static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
 
 static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
 {
-	if (!nodes)
-		pol->flags |= MPOL_F_LOCAL;	/* local allocation */
-	else if (nodes_empty(*nodes))
-		return -EINVAL;			/*  no allowed nodes */
-	else
-		pol->v.preferred_node = first_node(*nodes);
+	if (nodes_empty(*nodes))
+		return -EINVAL;
+	pol->v.preferred_node = first_node(*nodes);
 	return 0;
 }
 
@@ -217,6 +213,11 @@ static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
 	return 0;
 }
 
+static int mpol_new_local(struct mempolicy *pol, const nodemask_t *nodes)
+{
+	return 0;
+}
+
 /*
  * mpol_set_nodemask is called after mpol_new() to set up the nodemask, if
  * any, for the new policy.  mpol_new() has already validated the nodes
@@ -239,25 +240,19 @@ static int mpol_set_nodemask(struct mempolicy *pol,
 		  cpuset_current_mems_allowed, node_states[N_MEMORY]);
 
 	VM_BUG_ON(!nodes);
-	if (pol->mode == MPOL_PREFERRED && nodes_empty(*nodes))
-		nodes = NULL;	/* explicit local allocation */
-	else {
-		if (pol->flags & MPOL_F_RELATIVE_NODES)
-			mpol_relative_nodemask(&nsc->mask2, nodes, &nsc->mask1);
-		else
-			nodes_and(nsc->mask2, *nodes, nsc->mask1);
 
-		if (mpol_store_user_nodemask(pol))
-			pol->w.user_nodemask = *nodes;
-		else
-			pol->w.cpuset_mems_allowed =
-						cpuset_current_mems_allowed;
-	}
+	if (pol->flags & MPOL_F_RELATIVE_NODES)
+		mpol_relative_nodemask(&nsc->mask2, nodes, &nsc->mask1);
+	else
+		nodes_and(nsc->mask2, *nodes, nsc->mask1);
 
-	if (nodes)
-		ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
+	if (mpol_store_user_nodemask(pol))
+		pol->w.user_nodemask = *nodes;
 	else
-		ret = mpol_ops[pol->mode].create(pol, NULL);
+		pol->w.cpuset_mems_allowed =
+					cpuset_current_mems_allowed;
+
+	ret = mpol_ops[pol->mode].create(pol, &nsc->mask2);
 	return ret;
 }
 
@@ -290,13 +285,14 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 			if (((flags & MPOL_F_STATIC_NODES) ||
 			     (flags & MPOL_F_RELATIVE_NODES)))
 				return ERR_PTR(-EINVAL);
+
+			mode = MPOL_LOCAL;
 		}
 	} else if (mode == MPOL_LOCAL) {
 		if (!nodes_empty(*nodes) ||
 		    (flags & MPOL_F_STATIC_NODES) ||
 		    (flags & MPOL_F_RELATIVE_NODES))
 			return ERR_PTR(-EINVAL);
-		mode = MPOL_PREFERRED;
 	} else if (nodes_empty(*nodes))
 		return ERR_PTR(-EINVAL);
 	policy = kmem_cache_alloc(policy_cache, GFP_KERNEL);
@@ -351,13 +347,18 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
 
 		if (node_isset(node, *nodes)) {
 			pol->v.preferred_node = node;
-			pol->flags &= ~MPOL_F_LOCAL;
-		} else
-			pol->flags |= MPOL_F_LOCAL;
+		} else {
+			/*
+			 * If there is no valid node, change the mode to
+			 * MPOL_LOCAL
+			 */
+			pol->mode = MPOL_LOCAL;
+			pol->flags &= ~MPOL_F_STATIC_NODES;
+		}
 	} else if (pol->flags & MPOL_F_RELATIVE_NODES) {
 		mpol_relative_nodemask(&tmp, &pol->w.user_nodemask, nodes);
 		pol->v.preferred_node = first_node(tmp);
-	} else if (!(pol->flags & MPOL_F_LOCAL)) {
+	} else {
 		pol->v.preferred_node = node_remap(pol->v.preferred_node,
 						   pol->w.cpuset_mems_allowed,
 						   *nodes);
@@ -376,7 +377,7 @@ static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
 {
 	if (!pol)
 		return;
-	if (!mpol_store_user_nodemask(pol) && !(pol->flags & MPOL_F_LOCAL) &&
+	if (!mpol_store_user_nodemask(pol) &&
 	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
 		return;
 
@@ -427,6 +428,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_bind,
 		.rebind = mpol_rebind_nodemask,
 	},
+	[MPOL_LOCAL] = {
+		.create = mpol_new_local,
+		.rebind = mpol_rebind_default,
+	},
 };
 
 static int migrate_page_add(struct page *page, struct list_head *pagelist,
@@ -919,10 +924,12 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
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
@@ -1894,9 +1901,9 @@ nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
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
@@ -1933,14 +1940,11 @@ unsigned int mempolicy_slab_node(void)
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
@@ -1960,6 +1964,8 @@ unsigned int mempolicy_slab_node(void)
 							&policy->v.nodes);
 		return z->zone ? zone_to_nid(z->zone) : node;
 	}
+	case MPOL_LOCAL:
+		return node;
 
 	default:
 		BUG();
@@ -2072,16 +2078,18 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
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
+		break;
+
+	case MPOL_LOCAL:
+		nid = numa_node_id();
+		init_nodemask_of_node(mask, nid);
 		break;
 
 	default:
@@ -2188,7 +2196,7 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 		 * If the policy is interleave, or does not allow the current
 		 * node in its nodemask, we allocate the standard way.
 		 */
-		if (pol->mode == MPOL_PREFERRED && !(pol->flags & MPOL_F_LOCAL))
+		if (pol->mode == MPOL_PREFERRED)
 			hpage_node = pol->v.preferred_node;
 
 		nmask = policy_nodemask(gfp, pol);
@@ -2324,10 +2332,9 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_INTERLEAVE:
 		return !!nodes_equal(a->v.nodes, b->v.nodes);
 	case MPOL_PREFERRED:
-		/* a's ->flags is the same as b's */
-		if (a->flags & MPOL_F_LOCAL)
-			return true;
 		return a->v.preferred_node == b->v.preferred_node;
+	case MPOL_LOCAL:
+		return true;
 	default:
 		BUG();
 		return false;
@@ -2465,10 +2472,11 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		break;
 
 	case MPOL_PREFERRED:
-		if (pol->flags & MPOL_F_LOCAL)
-			polnid = numa_node_id();
-		else
-			polnid = pol->v.preferred_node;
+		polnid = pol->v.preferred_node;
+		break;
+
+	case MPOL_LOCAL:
+		polnid = numa_node_id();
 		break;
 
 	case MPOL_BIND:
@@ -2835,9 +2843,6 @@ void numa_default_policy(void)
  * Parse and format mempolicy from/to strings
  */
 
-/*
- * "local" is implemented internally by MPOL_PREFERRED with MPOL_F_LOCAL flag.
- */
 static const char * const policy_modes[] =
 {
 	[MPOL_DEFAULT]    = "default",
@@ -2915,7 +2920,6 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		 */
 		if (nodelist)
 			goto out;
-		mode = MPOL_PREFERRED;
 		break;
 	case MPOL_DEFAULT:
 		/*
@@ -2959,7 +2963,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	else if (nodelist)
 		new->v.preferred_node = first_node(nodes);
 	else
-		new->flags |= MPOL_F_LOCAL;
+		new->mode = MPOL_LOCAL;
 
 	/*
 	 * Save nodes for contextualization: this will be used to "clone"
@@ -3005,12 +3009,10 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 
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

