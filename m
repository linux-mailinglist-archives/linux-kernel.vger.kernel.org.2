Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695A837F38A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhEMHZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:25:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:29100 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231626AbhEMHZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:25:21 -0400
IronPort-SDR: aKlQupy4DDdl5UQdyYVgT7D9PmfEoRbE059RU7C0JDNYqZwubq+bBM086AU7+lNScsQ8UBhmkf
 qpQWcQ/p7VJQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="261138254"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="261138254"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 00:23:56 -0700
IronPort-SDR: Fxhbhcb7CPja7qc1bALQnbiZn28dcWXEFArRdDaRF8+q934+FIp4adQrHUwPFBlmiyes6I/Xo8
 bvjTvev1KfbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="393101595"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2021 00:23:51 -0700
Date:   Thu, 13 May 2021 15:23:50 +0800
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
Subject: Re: [PATCH v4 03/13] mm/mempolicy: Add MPOL_PREFERRED_MANY for
 multiple preferred nodes
Message-ID: <20210513072350.GB44993@shbuild999.sh.intel.com>
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

mempolicy: don't handle MPOL_LOCAL as a fake MPOL_PREFERRED policy

MPOL_LOCAL policy has been setup as a real policy, but it is still
handled as a faked POL_PREFERRED policy with one internal
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
instead of a fake 'prefer' one, this will reduce confusion and
make it easier to integrate our new 'prefer-many' policy

And next optional patch will kill the 'MPOL_F_LOCAL' bit.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 60 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d79fa29..2f20f079 100644
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
@@ -1960,6 +1954,8 @@ unsigned int mempolicy_slab_node(void)
 							&policy->v.nodes);
 		return z->zone ? zone_to_nid(z->zone) : node;
 	}
+	case MPOL_LOCAL:
+		return node;
 
 	default:
 		BUG();
@@ -2084,6 +2080,11 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
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
@@ -2344,6 +2345,8 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 		if (a->flags & MPOL_F_LOCAL)
 			return true;
 		return a->v.preferred_node == b->v.preferred_node;
+	case MPOL_LOCAL:
+		return true;
 	default:
 		BUG();
 		return false;
@@ -2487,6 +2490,10 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 			polnid = pol->v.preferred_node;
 		break;
 
+	case MPOL_LOCAL:
+		polnid = numa_node_id();
+		break;
+
 	case MPOL_BIND:
 		/* Optimize placement among multiple nodes via NUMA balancing */
 		if (pol->flags & MPOL_F_MORON) {
@@ -2931,7 +2938,6 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		 */
 		if (nodelist)
 			goto out;
-		mode = MPOL_PREFERRED;
 		break;
 	case MPOL_DEFAULT:
 		/*
@@ -2975,7 +2981,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	else if (nodelist)
 		new->v.preferred_node = first_node(nodes);
 	else
-		new->flags |= MPOL_F_LOCAL;
+		new->mode = MPOL_LOCAL;
 
 	/*
 	 * Save nodes for contextualization: this will be used to "clone"
-- 
2.7.4

