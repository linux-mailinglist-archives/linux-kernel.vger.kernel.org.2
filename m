Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F027F389FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhETIcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:32:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:61362 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231224AbhETIb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:31:59 -0400
IronPort-SDR: sn3rNsT55P3PQJKKAEs7/ZOB1wnrKgwn0daQom79w4mdy+XIDMoabGjnRnvfs5mqJBeGaS+RH/
 4AyFwXAiHw+Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="198088183"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="198088183"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 01:30:22 -0700
IronPort-SDR: 7EwOJOstGBDvnGyEkD+yH2gTui2CgXZWZ+sj0n/M6c6omrxpGBa5lo/xJVtX5kO6eQ4rgZjPQ+
 2u9kGT1oIhxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="473899349"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 20 May 2021 01:30:19 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>
Subject: [RFC Patch v2 3/4] mm/mempolicy: don't handle MPOL_LOCAL like a fake MPOL_PREFERRED policy
Date:   Thu, 20 May 2021 16:30:03 +0800
Message-Id: <1621499404-67756-4-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621499404-67756-1-git-send-email-feng.tang@intel.com>
References: <1621499404-67756-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPOL_LOCAL policy has been setup as a real policy, but it is still
handled like a faked POL_PREFERRED policy with one internal
MPOL_F_LOCAL flag bit set, and there are many places having to
judge the real 'prefer' or the 'local' policy, which are quite
confusing.

In current code, there are four cases that MPOL_LOCAL are used:
* user specifies 'local' policy
* user specifies 'prefer' policy, but with empty nodemask
* system 'default' policy is used
* 'prefer' policy + valid 'preferred' node with MPOL_F_STATIC_NODES
  flag set, and when it is 'rebind' to a nodemask which doesn't
  contains the 'preferred' node, it will add the MPOL_F_LOCAL bit
  and performs as 'local' policy. In future if it is 'rebind' again
  with valid nodemask, the policy will be restored back to 'prefer'

So for the first three cases, we make 'local' a real policy
instead of a fake 'prefer' one, this will reduce confusion for
reading code.

And next optional patch will kill the 'MPOL_F_LOCAL' bit.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 60 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0f5bf60..833ed2d 100644
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
 
@@ -239,25 +235,19 @@ static int mpol_set_nodemask(struct mempolicy *pol,
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
 
@@ -290,13 +280,14 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
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
@@ -427,6 +418,9 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_bind,
 		.rebind = mpol_rebind_nodemask,
 	},
+	[MPOL_LOCAL] = {
+		.rebind = mpol_rebind_default,
+	},
 };
 
 static int migrate_page_add(struct page *page, struct list_head *pagelist,
@@ -1952,6 +1946,8 @@ unsigned int mempolicy_slab_node(void)
 							&policy->v.nodes);
 		return z->zone ? zone_to_nid(z->zone) : node;
 	}
+	case MPOL_LOCAL:
+		return node;
 
 	default:
 		BUG();
@@ -2076,6 +2072,11 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 		*mask =  mempolicy->v.nodes;
 		break;
 
+	case MPOL_LOCAL:
+		nid = numa_node_id();
+		init_nodemask_of_node(mask, nid);
+		break;
+
 	default:
 		BUG();
 	}
@@ -2320,6 +2321,8 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 		if (a->flags & MPOL_F_LOCAL)
 			return true;
 		return a->v.preferred_node == b->v.preferred_node;
+	case MPOL_LOCAL:
+		return true;
 	default:
 		BUG();
 		return false;
@@ -2463,6 +2466,10 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 			polnid = pol->v.preferred_node;
 		break;
 
+	case MPOL_LOCAL:
+		polnid = numa_node_id();
+		break;
+
 	case MPOL_BIND:
 		/* Optimize placement among multiple nodes via NUMA balancing */
 		if (pol->flags & MPOL_F_MORON) {
@@ -2907,7 +2914,6 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		 */
 		if (nodelist)
 			goto out;
-		mode = MPOL_PREFERRED;
 		break;
 	case MPOL_DEFAULT:
 		/*
@@ -2951,7 +2957,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	else if (nodelist)
 		new->v.preferred_node = first_node(nodes);
 	else
-		new->flags |= MPOL_F_LOCAL;
+		new->mode = MPOL_LOCAL;
 
 	/*
 	 * Save nodes for contextualization: this will be used to "clone"
-- 
2.7.4

