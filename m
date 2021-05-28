Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDFC3943C9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhE1OIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:08:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:63300 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236437AbhE1OIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:08:46 -0400
IronPort-SDR: QLTuJMZvhwdfYSbPIhDa49MuEmVcmaRChW/t+DNWuuok91RSaFQaz93P5GmYe1FccCS4sxj3iV
 VdUYI7IEDO0A==
X-IronPort-AV: E=McAfee;i="6200,9189,9998"; a="202734912"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="202734912"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 07:07:11 -0700
IronPort-SDR: 83l8S3umKFlRwCDCS43tU+hG0YvaTV42ty2okM3iYks0hv85yleRNWszz5hY5wqkNJybUsmYoe
 AuyVTKEoTCMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="481059653"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga002.fm.intel.com with ESMTP; 28 May 2021 07:07:08 -0700
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
Subject: [v2 PATCH 1/3] mm/mempolicy: cleanup nodemask intersection check for oom
Date:   Fri, 28 May 2021 22:07:01 +0800
Message-Id: <1622210823-61911-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622210823-61911-1-git-send-email-feng.tang@intel.com>
References: <1622210823-61911-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mempolicy_nodemask_intersects() is used in oom case to check if a
task may have memory allocated on some memory nodes.

As it's only used by OOM check, rename it to mempolicy_in_oom_domain()
to reduce confusion.

As only for 'bind' policy, the nodemask is a force requirement for
from where to allocate memory, only do the intesection check for it,
and return true for all other policies.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/mempolicy.h |  2 +-
 mm/mempolicy.c            | 34 +++++++++-------------------------
 mm/oom_kill.c             |  2 +-
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 5f1c74d..8773c55 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -150,7 +150,7 @@ extern int huge_node(struct vm_area_struct *vma,
 				unsigned long addr, gfp_t gfp_flags,
 				struct mempolicy **mpol, nodemask_t **nodemask);
 extern bool init_nodemask_of_mempolicy(nodemask_t *mask);
-extern bool mempolicy_nodemask_intersects(struct task_struct *tsk,
+extern bool mempolicy_in_oom_domain(struct task_struct *tsk,
 				const nodemask_t *mask);
 extern nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *policy);
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d79fa29..6795a6a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2094,16 +2094,16 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 #endif
 
 /*
- * mempolicy_nodemask_intersects
+ * mempolicy_in_oom_domain
  *
- * If tsk's mempolicy is "default" [NULL], return 'true' to indicate default
- * policy.  Otherwise, check for intersection between mask and the policy
- * nodemask for 'bind' or 'interleave' policy.  For 'preferred' or 'local'
- * policy, always return true since it may allocate elsewhere on fallback.
+ * If tsk's mempolicy is "bind", check for intersection between mask and
+ * the policy nodemask. Otherwise, return true for all other policies
+ * including "interleave", as a tsk with "interleave" policy may have
+ * memory allocated from all nodes in system.
  *
  * Takes task_lock(tsk) to prevent freeing of its mempolicy.
  */
-bool mempolicy_nodemask_intersects(struct task_struct *tsk,
+bool mempolicy_in_oom_domain(struct task_struct *tsk,
 					const nodemask_t *mask)
 {
 	struct mempolicy *mempolicy;
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
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eefd3f5..fcc29e9 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -104,7 +104,7 @@ static bool oom_cpuset_eligible(struct task_struct *start,
 			 * mempolicy intersects current, otherwise it may be
 			 * needlessly killed.
 			 */
-			ret = mempolicy_nodemask_intersects(tsk, mask);
+			ret = mempolicy_in_oom_domain(tsk, mask);
 		} else {
 			/*
 			 * This is not a mempolicy constrained oom, so only
-- 
2.7.4

