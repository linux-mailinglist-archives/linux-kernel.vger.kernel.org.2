Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913613FC467
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbhHaIkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:40:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:6039 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240190AbhHaIkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:40:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="304005105"
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="304005105"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 01:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="600844367"
Received: from shbuild999.sh.intel.com ([10.239.146.151])
  by fmsmga001.fm.intel.com with ESMTP; 31 Aug 2021 01:38:06 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>
Subject: [RFC PATCH] mm/oom: detect and kill task which has allocation forbidden by cpuset limit
Date:   Tue, 31 Aug 2021 16:38:05 +0800
Message-Id: <1630399085-70431-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was report that starting an Ubuntu in docker while using cpuset
to bind it to movlabe nodes (a node only has movable zone, like a node
for hotplug or a PMEM node in normal usage) will fail due to memory
allocation failure, and then OOM is involved and many other innocent
processes got killed. It can be reproduced with command:
$docker run -it --rm  --cpuset-mems 4 ubuntu:latest bash -c
"grep Mems_allowed /proc/self/status" (node 4 is a movable node)

The reason is, in the case, the target cpuset nodes only have movable
zone, while the creation of an OS in docker sometimes needs to allocate
memory in non-movable zones (dma/dma32/normal) like GFP_HIGHUSER, and
the cpuset limit forbids the allocation, then out-of-memory killing is
involved even when normal nodes and movable nodes both have many free
memory.

We've posted patches to LKML trying to make the usage working by
loosening the check, which is not agreed as the cpuset binding should
be respected, and should not be bypassed [1]

But still there is another problem, that when the usage fails as it's an
mission impossible due to the cpuset limit, the allocating should just
be killed first, before any other innocent processes get killed.

Add detection for cases like this, and kill the allocating task only.

[1].https://lore.kernel.org/lkml/1604470210-124827-1-git-send-email-feng.tang@intel.com/

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/oom.h |  1 +
 mm/oom_kill.c       | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 2db9a1432511..bf470d8cc421 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -18,6 +18,7 @@ struct task_struct;
 enum oom_constraint {
 	CONSTRAINT_NONE,
 	CONSTRAINT_CPUSET,
+	CONSTRAINT_CPUSET_NONE,	/* no available zone from cpuset's mem nodes */
 	CONSTRAINT_MEMORY_POLICY,
 	CONSTRAINT_MEMCG,
 };
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 431d38c3bba8..021ec8954279 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -247,6 +247,7 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 static const char * const oom_constraint_text[] = {
 	[CONSTRAINT_NONE] = "CONSTRAINT_NONE",
 	[CONSTRAINT_CPUSET] = "CONSTRAINT_CPUSET",
+	[CONSTRAINT_CPUSET_NONE] = "CONSTRAINT_CPUSET_NONE",
 	[CONSTRAINT_MEMORY_POLICY] = "CONSTRAINT_MEMORY_POLICY",
 	[CONSTRAINT_MEMCG] = "CONSTRAINT_MEMCG",
 };
@@ -275,6 +276,14 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 
 	if (!oc->zonelist)
 		return CONSTRAINT_NONE;
+
+	if (cpusets_enabled() && (oc->gfp_mask & __GFP_HARDWALL)) {
+		z = first_zones_zonelist(oc->zonelist,
+			highest_zoneidx, &cpuset_current_mems_allowed);
+		if (!z->zone)
+			return CONSTRAINT_CPUSET_NONE;
+	}
+
 	/*
 	 * Reach here only when __GFP_NOFAIL is used. So, we should avoid
 	 * to kill current.We have to random task kill in this case.
@@ -1093,7 +1102,9 @@ bool out_of_memory(struct oom_control *oc)
 		oc->nodemask = NULL;
 	check_panic_on_oom(oc);
 
-	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
+	if (!is_memcg_oom(oc) &&
+	    (sysctl_oom_kill_allocating_task ||
+	       oc->constraint == CONSTRAINT_CPUSET_NONE) &&
 	    current->mm && !oom_unkillable_task(current) &&
 	    oom_cpuset_eligible(current, oc) &&
 	    current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
-- 
2.14.1

