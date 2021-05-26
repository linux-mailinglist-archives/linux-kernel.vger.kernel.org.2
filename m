Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3046C390FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 07:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhEZFDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 01:03:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:50422 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231321AbhEZFDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 01:03:39 -0400
IronPort-SDR: BilWowgGPVPobMel1FEV0oE8k5F9PImiB8RGfdmPKL1nEhML9SlC0g6aYDnPnc6O1CB56KrNoV
 w59voX5fXu2g==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="189500110"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="189500110"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 22:01:50 -0700
IronPort-SDR: rHJTpW6ue71FjKcagiwVlhtoj6dWxRqE9aEHOu+VCRNJw6PuzQq0hdq/IBaFGfJO8T2JhV48Jy
 xCdE/41/iYXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="479700238"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2021 22:01:47 -0700
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
Subject: [PATCH v1 1/4] mm/mempolicy: skip nodemask intersect check for 'interleave' when oom
Date:   Wed, 26 May 2021 13:01:39 +0800
Message-Id: <1622005302-23027-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
References: <1622005302-23027-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mempolicy_nodemask_intersects() is used in oom case to check if a
task may have memory allocated on some memory nodes.

Currently, the nodes_intersects() is run for both 'bind' and 'interleave'
policies. But they are different regarding memory allocation, the nodemask
is a forced requirement for 'bind', while just a hint for 'interleave'.
Like in alloc_pages_vma():

	nmask = policy_nodemask(gfp, pol);
        preferred_nid = policy_node(gfp, pol, node);
        page = __alloc_pages(gfp, order, preferred_nid, nmask);

in plicy_nodemask(), only 'bind' policy may return its desired nodemask,
while others return NULL.  And this 'NULL' enables the 'interleave' policy
can get memory from other nodes than its nodemask.

So skip the nodemask intersect check for 'interleave' policy.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/mempolicy.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d79fa29..1964cca 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2098,7 +2098,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
  *
  * If tsk's mempolicy is "default" [NULL], return 'true' to indicate default
  * policy.  Otherwise, check for intersection between mask and the policy
- * nodemask for 'bind' or 'interleave' policy.  For 'preferred' or 'local'
+ * nodemask for 'bind' policy.  For 'interleave', 'preferred' or 'local'
  * policy, always return true since it may allocate elsewhere on fallback.
  *
  * Takes task_lock(tsk) to prevent freeing of its mempolicy.
@@ -2111,29 +2111,13 @@ bool mempolicy_nodemask_intersects(struct task_struct *tsk,
 
 	if (!mask)
 		return ret;
+
 	task_lock(tsk);
 	mempolicy = tsk->mempolicy;
-	if (!mempolicy)
-		goto out;
-
-	switch (mempolicy->mode) {
-	case MPOL_PREFERRED:
-		/*
-		 * MPOL_PREFERRED and MPOL_F_LOCAL are only preferred nodes to
-		 * allocate from, they may fallback to other nodes when oom.
-		 * Thus, it's possible for tsk to have allocated memory from
-		 * nodes in mask.
-		 */
-		break;
-	case MPOL_BIND:
-	case MPOL_INTERLEAVE:
+	if (mempolicy && mempolicy->mode == MPOL_BIND)
 		ret = nodes_intersects(mempolicy->v.nodes, *mask);
-		break;
-	default:
-		BUG();
-	}
-out:
 	task_unlock(tsk);
+
 	return ret;
 }
 
-- 
2.7.4

