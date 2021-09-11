Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE63240745B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 03:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhIKBVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 21:21:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:21357 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235051AbhIKBUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 21:20:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="208325819"
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="208325819"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 18:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,284,1624345200"; 
   d="scan'208";a="695261642"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2021 18:19:08 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 5/6] sched/fair: Carve out logic to mark a group for asymmetric packing
Date:   Fri, 10 Sep 2021 18:18:18 -0700
Message-Id: <20210911011819.12184-6-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com>
References: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a separate function, sched_asym(). A subsequent changeset will
introduce logic to deal with SMT in conjunction with asmymmetric
packing. Such logic will need the statistics of the scheduling
group provided as argument. Update them before calling sched_asym().

Cc: Aubrey Li <aubrey.li@intel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Quentin Perret <qperret@google.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Len Brown <len.brown@intel.com>
Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
  * None

Changes since v3:
  * Remove a redundant check for the local group in sched_asym().
    (Dietmar)
  * Reworded commit message for clarity. (Len)

Changes since v2:
  * Introduced this patch.

Changes since v1:
  * N/A
---
 kernel/sched/fair.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c5851260b4d8..26db017c14a3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8597,6 +8597,13 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+static inline bool
+sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
+	   struct sched_group *group)
+{
+	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -8657,18 +8664,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
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

