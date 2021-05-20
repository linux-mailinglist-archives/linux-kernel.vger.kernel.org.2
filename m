Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449BC389FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhETIb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 04:31:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:61362 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231211AbhETIb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 04:31:57 -0400
IronPort-SDR: vDetwh9YCVHRbtdHpyoEC15OLU87RMFxO22+nmyQrs4Ybp+BcS+N1mvVP1olgyIz7qDGIutNUu
 wWj5LCH5pSfg==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="198088166"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="198088166"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 01:30:15 -0700
IronPort-SDR: v1wQCbBUT3aWfY0Cm3DhdLDmQJeIfEP4e3JYnUQnAfONRhH6N0bAgFZR9Rf8qDZqRAEcFnXKim
 bL2UVqCIHMow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="473899320"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 20 May 2021 01:30:09 -0700
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
Subject: [RFC Patch v2 1/4] mm/mempolicy: skip nodemask intersect check for 'interleave' when oom
Date:   Thu, 20 May 2021 16:30:01 +0800
Message-Id: <1621499404-67756-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621499404-67756-1-git-send-email-feng.tang@intel.com>
References: <1621499404-67756-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mempolicy_nodemask_intersects() is used in oom case to check if a
task may have memory allocated on some memory nodes.

MPOL_INTERLEAVE has set a nodemask, which is not a forced requirement,
but just a hint for chosing a node to allocate memory from, and the
task may have memory allocated on other nodes than this nodemask. So
skip the check.

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

