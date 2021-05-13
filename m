Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5574837FB05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhEMPvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 11:51:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:24114 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhEMPvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 11:51:11 -0400
IronPort-SDR: Yurrh/jaGsPedI2v9JOnPeHrniGLKJzZYaMwDNH5U+nQ09FKaxLOiS6oHTC6Ow0mOtGQ9agWuB
 PPfH5a52wIQA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="179568912"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="179568912"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 08:50:00 -0700
IronPort-SDR: q7QczRcl1XBX4sxwj+cgkQE//bgGGfiL3J03CmVzNgU6C8uVs81nnIHNESe1rENMF/0qvDyJIa
 3IPqGEL/Ydew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="610418838"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2021 08:50:00 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 4/6] sched/fair: Carve out logic to mark a group for asymmetric packing
Date:   Thu, 13 May 2021 08:49:07 -0700
Message-Id: <20210513154909.6385-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when balancing load, a candidate busiest group is marked for
asymmetric packing if, among other factors, dst_cpu has higher priority
than the preferred CPU of the candidate busiest group. However, other
factors influence the decision, such as the state of the SMT siblings of
dst_cpu, if any.

Thus, create a separate function, sched_asym(), in which logic for such
decisions can be implemented. A subsequent changeset will introduce logic
to deal with SMT.

Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Quentin Perret <qperret@google.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
  * Introduced this patch.

Changes since v1:
  * N/A
---
 kernel/sched/fair.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c8c04e9d0d3b..c8b66a5d593e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8447,6 +8447,20 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+static inline bool
+sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
+	   struct sched_group *group)
+{
+	/*
+	 * Because sd->groups starts with the local group, anything that isn't
+	 * the local group will have access to the local state.
+	 */
+	if (group == sds->local)
+		return false;
+
+	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -8507,18 +8521,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		}
 	}
 
+	sgs->group_capacity = group->sgc->capacity;
+
+	sgs->group_weight = group->group_weight;
+
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
-	    env->idle != CPU_NOT_IDLE &&
-	    sgs->sum_h_nr_running &&
-	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
+	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
+	    sched_asym(env, sds, sgs, group)) {
 		sgs->group_asym_packing = 1;
 	}
 
-	sgs->group_capacity = group->sgc->capacity;
-
-	sgs->group_weight = group->group_weight;
-
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
 	/* Computing avg_load makes sense only when group is overloaded */
-- 
2.17.1

