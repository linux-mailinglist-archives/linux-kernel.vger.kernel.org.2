Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C7736118C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 19:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhDOR7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:59:23 -0400
Received: from foss.arm.com ([217.140.110.172]:51812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232759AbhDOR7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:59:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6188C1396;
        Thu, 15 Apr 2021 10:58:59 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC68A3FA45;
        Thu, 15 Apr 2021 10:58:57 -0700 (PDT)
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
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: [PATCH 1/2] sched/fair: Filter out locally-unsolvable misfit imbalances
Date:   Thu, 15 Apr 2021 18:58:45 +0100
Message-Id: <20210415175846.494385-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415175846.494385-1-valentin.schneider@arm.com>
References: <20210415175846.494385-1-valentin.schneider@arm.com>
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
env->dst_cpu would grant it a capacity uplift.

Note that the aforementioned capacity vs sgc->max_capacity comparison was
meant to prevent misfit task downmigration: candidate groups classified as
group_misfit_task but with a higher (max) CPU capacity than the destination CPU
would be discarded. This change makes it so said group_misfit_task
classification can't happen anymore, which may cause some undesired
downmigrations.

Further tweak find_busiest_queue() to ensure this doesn't happen. Also note
find_busiest_queue() can now iterate over CPUs with a higher capacity than
the local CPU's, so add a capacity check there.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 63 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9b8ae02f1994..d2d1a69d7aa7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5759,6 +5759,12 @@ static unsigned long capacity_of(int cpu)
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
@@ -7486,6 +7492,7 @@ struct lb_env {
 
 	enum fbq_type		fbq_type;
 	enum migration_type	migration_type;
+	enum group_type         src_grp_type;
 	struct list_head	tasks;
 };
 
@@ -8447,6 +8454,32 @@ static bool update_nohz_stats(struct rq *rq)
 #endif
 }
 
+static inline void update_sg_lb_misfit_stats(struct lb_env *env,
+					     struct sched_group *group,
+					     struct sg_lb_stats *sgs,
+					     int *sg_status,
+					     int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (!(env->sd->flags & SD_ASYM_CPUCAPACITY) ||
+	    !rq->misfit_task_load)
+		return;
+
+	*sg_status |= SG_OVERLOAD;
+
+	/*
+	 * Don't attempt to maximize load for misfit tasks that can't be
+	 * granted a CPU capacity uplift.
+	 */
+	if (cpu_capacity_greater(env->dst_cpu, cpu)) {
+		sgs->group_misfit_task_load = max(
+			sgs->group_misfit_task_load,
+			rq->misfit_task_load);
+	}
+
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -8498,12 +8531,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (local_group)
 			continue;
 
-		/* Check for a misfit task on the cpu */
-		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
-		    sgs->group_misfit_task_load < rq->misfit_task_load) {
-			sgs->group_misfit_task_load = rq->misfit_task_load;
-			*sg_status |= SG_OVERLOAD;
-		}
+		update_sg_lb_misfit_stats(env, group, sgs, sg_status, i);
 	}
 
 	/* Check if dst CPU is idle and preferred to this group */
@@ -8550,15 +8578,9 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	if (!sgs->sum_h_nr_running)
 		return false;
 
-	/*
-	 * Don't try to pull misfit tasks we can't help.
-	 * We can use max_capacity here as reduction in capacity on some
-	 * CPUs in the group should either be possible to resolve
-	 * internally or be covered by avg_load imbalance (eventually).
-	 */
+	/* Don't try to pull misfit tasks we can't help */
 	if (sgs->group_type == group_misfit_task &&
-	    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
-	     sds->local_stat.group_type != group_has_spare))
+	     sds->local_stat.group_type != group_has_spare)
 		return false;
 
 	if (sgs->group_type > busiest->group_type)
@@ -9288,6 +9310,8 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 	if (!sds.busiest)
 		goto out_balanced;
 
+	env->src_grp_type = busiest->group_type;
+
 	/* Misfit tasks should be dealt with regardless of the avg load */
 	if (busiest->group_type == group_misfit_task)
 		goto force_balance;
@@ -9441,8 +9465,8 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * average load.
 		 */
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
-		    !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
-		    nr_running == 1)
+		    env->src_grp_type <= group_fully_busy &&
+		    !capacity_greater(capacity_of(env->dst_cpu), capacity))
 			continue;
 
 		switch (env->migration_type) {
@@ -9504,15 +9528,18 @@ static struct rq *find_busiest_queue(struct lb_env *env,
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
2.25.1

