Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF6232BD50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451390AbhCCPon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:44:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:57583 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231768AbhCCKwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:52:02 -0500
IronPort-SDR: EOSUHXpTD/eZoyqEMZdoscJ7UtFcyECneCa8jlKJN4hBuGCgZDt6TntFzc+e4GIk+bRMxe8Pw8
 pUZNYBd96ikg==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="174802655"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="174802655"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 02:21:29 -0800
IronPort-SDR: +PuQ+EoQPBbh167kHFpmBFDlW2VkXHTMPWlrkuvktDUdKr4PIGQ0X6fCRjbBXUnam+TWrD/t8a
 /WM044BZ4MmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="445200240"
Received: from shbuild999.sh.intel.com ([10.239.146.165])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2021 02:21:25 -0800
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
Subject: [PATCH v3 07/14] mm/mempolicy: handle MPOL_PREFERRED_MANY like BIND
Date:   Wed,  3 Mar 2021 18:20:51 +0800
Message-Id: <1614766858-90344-8-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
References: <1614766858-90344-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Begin the real plumbing for handling this new policy. Now that the
internal representation for preferred nodes and bound nodes is the same,
and we can envision what multiple preferred nodes will behave like,
there are obvious places where we can simply reuse the bind behavior.

In v1 of this series, the moral equivalent was:
"mm: Finish handling MPOL_PREFERRED_MANY". Like that, this attempts to
implement the easiest spots for the new policy. Unlike that, this just
reuses BIND.

Link: https://lore.kernel.org/r/20200630212517.308045-8-ben.widawsky@intel.com
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index fe1d83c..80cb554 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -953,8 +953,6 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	switch (p->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		*nodes = p->nodes;
-		break;
 	case MPOL_PREFERRED_MANY:
 		*nodes = p->nodes;
 		break;
@@ -1918,7 +1916,8 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 {
 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
-	if (unlikely(policy->mode == MPOL_BIND) &&
+	if (unlikely(policy->mode == MPOL_BIND ||
+		     policy->mode == MPOL_PREFERRED_MANY) &&
 	    apply_policy_zone(policy, gfp_zone(gfp)) &&
 	    cpuset_nodemask_valid_mems_allowed(&policy->nodes))
 		return &policy->nodes;
@@ -1974,7 +1973,6 @@ unsigned int mempolicy_slab_node(void)
 		return node;
 
 	switch (policy->mode) {
-	case MPOL_PREFERRED_MANY:
 	case MPOL_PREFERRED:
 		/*
 		 * handled MPOL_F_LOCAL above
@@ -1984,6 +1982,7 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
 
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND: {
 		struct zoneref *z;
 
@@ -2109,9 +2108,6 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	task_lock(current);
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
-	case MPOL_PREFERRED_MANY:
-		*mask = mempolicy->nodes;
-		break;
 	case MPOL_PREFERRED:
 		if (mempolicy->flags & MPOL_F_LOCAL)
 			nid = numa_node_id();
@@ -2122,6 +2118,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_MANY:
 		*mask = mempolicy->nodes;
 		break;
 
@@ -2165,12 +2162,11 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 		 * Thus, it's possible for tsk to have allocated memory from
 		 * nodes in mask.
 		 */
-		break;
-	case MPOL_PREFERRED_MANY:
 		ret = nodes_intersects(mempolicy->nodes, *mask);
 		break;
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_MANY:
 		ret = nodes_intersects(mempolicy->nodes, *mask);
 		break;
 	default:
@@ -2394,7 +2390,6 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	switch (a->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_PREFERRED_MANY:
 		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_PREFERRED:
@@ -2548,6 +2543,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 			polnid = first_node(pol->nodes);
 		break;
 
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 
 		/*
@@ -2564,8 +2560,6 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		polnid = zone_to_nid(z->zone);
 		break;
 
-		/* case MPOL_PREFERRED_MANY: */
-
 	default:
 		BUG();
 	}
@@ -3078,15 +3072,13 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	switch (mode) {
 	case MPOL_DEFAULT:
 		break;
-	case MPOL_PREFERRED_MANY:
-		WARN_ON(flags & MPOL_F_LOCAL);
-		fallthrough;
 	case MPOL_PREFERRED:
 		if (flags & MPOL_F_LOCAL)
 			mode = MPOL_LOCAL;
 		else
 			nodes_or(nodes, nodes, pol->nodes);
 		break;
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
 		nodes = pol->nodes;
-- 
2.7.4

