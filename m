Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134C533E7CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCQDlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:41:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:48803 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhCQDkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:40:39 -0400
IronPort-SDR: FjOzzSC6A30yQtuA1qnn1uXF34Xw2XlCXXtg8YSS4sJRtm/CJN0Zb3QIJ+Gc4qKfOV19PJJ7s0
 p39XDHiA08HQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="186021888"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="186021888"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:40:39 -0700
IronPort-SDR: M381zsLOSRwH5Wrt/ikyk3g4mZ71WgLw/dvoG/CJO4nQbyoMK61+tc44qzB6fm5rXfMlTBziWE
 FtTWQRmp54KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602075916"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 20:40:36 -0700
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
Subject: [PATCH v4 07/13] mm/mempolicy: handle MPOL_PREFERRED_MANY like BIND
Date:   Wed, 17 Mar 2021 11:40:04 +0800
Message-Id: <1615952410-36895-8-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
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
index eba207e..d945f29 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -963,8 +963,6 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
 	switch (p->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		*nodes = p->nodes;
-		break;
 	case MPOL_PREFERRED_MANY:
 		*nodes = p->nodes;
 		break;
@@ -1928,7 +1926,8 @@ static int apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy)
 {
 	/* Lower zones don't get a nodemask applied for MPOL_BIND */
-	if (unlikely(policy->mode == MPOL_BIND) &&
+	if (unlikely(policy->mode == MPOL_BIND ||
+		     policy->mode == MPOL_PREFERRED_MANY) &&
 	    apply_policy_zone(policy, gfp_zone(gfp)) &&
 	    cpuset_nodemask_valid_mems_allowed(&policy->nodes))
 		return &policy->nodes;
@@ -1984,7 +1983,6 @@ unsigned int mempolicy_slab_node(void)
 		return node;
 
 	switch (policy->mode) {
-	case MPOL_PREFERRED_MANY:
 	case MPOL_PREFERRED:
 		/*
 		 * handled MPOL_F_LOCAL above
@@ -1994,6 +1992,7 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
 
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND: {
 		struct zoneref *z;
 
@@ -2119,9 +2118,6 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	task_lock(current);
 	mempolicy = current->mempolicy;
 	switch (mempolicy->mode) {
-	case MPOL_PREFERRED_MANY:
-		*mask = mempolicy->nodes;
-		break;
 	case MPOL_PREFERRED:
 		if (mempolicy->flags & MPOL_F_LOCAL)
 			nid = numa_node_id();
@@ -2132,6 +2128,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_PREFERRED_MANY:
 		*mask = mempolicy->nodes;
 		break;
 
@@ -2175,12 +2172,11 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
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
@@ -2404,7 +2400,6 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	switch (a->mode) {
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
-		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_PREFERRED_MANY:
 		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_PREFERRED:
@@ -2558,6 +2553,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 			polnid = first_node(pol->nodes);
 		break;
 
+	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 		/* Optimize placement among multiple nodes via NUMA balancing */
 		if (pol->flags & MPOL_F_MORON) {
@@ -2580,8 +2576,6 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		polnid = zone_to_nid(z->zone);
 		break;
 
-		/* case MPOL_PREFERRED_MANY: */
-
 	default:
 		BUG();
 	}
@@ -3094,15 +3088,13 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
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

