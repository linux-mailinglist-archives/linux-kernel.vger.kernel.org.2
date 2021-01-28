Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65699307E44
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhA1Skr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:40:47 -0500
Received: from foss.arm.com ([217.140.110.172]:37442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232145AbhA1SfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:35:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF35814BF;
        Thu, 28 Jan 2021 10:32:15 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 547373F719;
        Thu, 28 Jan 2021 10:32:14 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 6/8] sched/fair: Filter out locally-unsolvable misfit imbalances
Date:   Thu, 28 Jan 2021 18:31:39 +0000
Message-Id: <20210128183141.28097-7-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128183141.28097-1-valentin.schneider@arm.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider the following (hypothetical) asymmetric CPU capacity topology,
with some amount of capacity pressure (RT | DL | IRQ | thermal):

  DIE [          ]
  MC  [    ][    ]
       0  1  2  3

  | CPU | capacity_orig | capacity |
  |-----+---------------+----------|
  |   0 |           870 |      860 |
  |   1 |           870 |      600 |
  |   2 |          1024 |      850 |
  |   3 |          1024 |      860 |

If CPU1 has a misfit task, then CPU0, CPU2 and CPU3 are valid candidates to
grant the task an uplift in CPU capacity. Consider CPU0 and CPU3 as
sufficiently busy, i.e. don't have enough spare capacity to accommodate
CPU1's misfit task. This would then fall on CPU2 to pull the task.

This currently won't happen, because CPU2 will fail

  capacity_greater(capacity_of(CPU2), sg->sgc->max_capacity)

in update_sd_pick_busiest(), where 'sg' is the [0, 1] group at DIE
level. In this case, the max_capacity is that of CPU0's, which is at this
point in time greater than that of CPU2's. This comparison doesn't make
much sense, given that the only CPUs we should care about in this scenario
are CPU1 (the CPU with the misfit task) and CPU2 (the load-balance
destination CPU).

Aggregate a misfit task's load into sgs->group_misfit_task_load only if
env->dst_cpu would grant it a capacity uplift. Separately track whether a
sched_group contains a misfit task to still classify it as
group_misfit_task and not pick it as busiest group when pulling from a
lower-capacity CPU (which is the current behaviour and prevents
down-migration).

Since find_busiest_queue() can now iterate over CPUs with a higher capacity
than the local CPU's, add a capacity check there.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef44474b8fbf..0ac2f876b86f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5765,6 +5765,12 @@ static unsigned long capacity_of(int cpu)
 	return cpu_rq(cpu)->cpu_capacity;
 }
 
+/* Is CPU a's capacity noticeably greater than CPU b's? */
+static inline bool cpu_capacity_greater(int a, int b)
+{
+	return capacity_greater(capacity_of(a), capacity_of(b));
+}
+
 static void record_wakee(struct task_struct *p)
 {
 	/*
@@ -8093,7 +8099,8 @@ struct sg_lb_stats {
 	unsigned int group_weight;
 	enum group_type group_type;
 	unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
-	unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
+	unsigned long group_misfit_task_load; /* Task load that can be uplifted */
+	int           group_has_misfit_task; /* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
@@ -8364,7 +8371,7 @@ group_type group_classify(unsigned int imbalance_pct,
 	if (sgs->group_asym_packing)
 		return group_asym_packing;
 
-	if (sgs->group_misfit_task_load)
+	if (sgs->group_has_misfit_task)
 		return group_misfit_task;
 
 	if (!group_has_capacity(imbalance_pct, sgs))
@@ -8450,11 +8457,21 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			continue;
 
 		/* Check for a misfit task on the cpu */
-		if (sd_has_asym_cpucapacity(env->sd) &&
-		    sgs->group_misfit_task_load < rq->misfit_task_load) {
-			sgs->group_misfit_task_load = rq->misfit_task_load;
-			*sg_status |= SG_OVERLOAD;
-		}
+		if (!sd_has_asym_cpucapacity(env->sd) ||
+		    !rq->misfit_task_load)
+			continue;
+
+		*sg_status |= SG_OVERLOAD;
+		sgs->group_has_misfit_task = true;
+
+		/*
+		 * Don't attempt to maximize load for misfit tasks that can't be
+		 * granted a CPU capacity uplift.
+		 */
+		if (cpu_capacity_greater(env->dst_cpu, i))
+			sgs->group_misfit_task_load = max(
+				sgs->group_misfit_task_load,
+				rq->misfit_task_load);
 	}
 
 	/* Check if dst CPU is idle and preferred to this group */
@@ -8504,7 +8521,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	/* Don't try to pull misfit tasks we can't help */
 	if (static_branch_unlikely(&sched_asym_cpucapacity) &&
 	    sgs->group_type == group_misfit_task &&
-	    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
+	    (!sgs->group_misfit_task_load ||
 	     sds->local_stat.group_type != group_has_spare))
 		return false;
 
@@ -9464,15 +9481,18 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		case migrate_misfit:
 			/*
 			 * For ASYM_CPUCAPACITY domains with misfit tasks we
-			 * simply seek the "biggest" misfit task.
+			 * simply seek the "biggest" misfit task we can
+			 * accommodate.
 			 */
+			if (!cpu_capacity_greater(env->dst_cpu, i))
+				continue;
+
 			if (rq->misfit_task_load > busiest_load) {
 				busiest_load = rq->misfit_task_load;
 				busiest = rq;
 			}
 
 			break;
-
 		}
 	}
 
-- 
2.27.0

