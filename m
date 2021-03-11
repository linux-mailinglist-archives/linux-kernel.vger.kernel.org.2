Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66A7337207
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhCKMGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:06:06 -0500
Received: from foss.arm.com ([217.140.110.172]:34054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232532AbhCKMFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:05:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8D5A11B3;
        Thu, 11 Mar 2021 04:05:40 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27FE53F793;
        Thu, 11 Mar 2021 04:05:39 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>, Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: [PATCH v3 3/7] sched/fair: Add more sched_asym_cpucapacity static branch checks
Date:   Thu, 11 Mar 2021 12:05:23 +0000
Message-Id: <20210311120527.167870-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311120527.167870-1-valentin.schneider@arm.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rik noted a while back that a handful of

  sd->flags & SD_ASYM_CPUCAPACITY

& family in the CFS load-balancer code aren't guarded by the
sched_asym_cpucapacity static branch.

Turning those checks into NOPs for those who don't need it is fairly
straightforward, and hiding it in a helper doesn't change code size in all
but one spot. It also gives us a place to document the differences between
checking the static key and checking the SD flag.

Suggested-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c  | 21 ++++++++-------------
 kernel/sched/sched.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f50a902bdf24..db892f6e222f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6300,15 +6300,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * sd_asym_cpucapacity rather than sd_llc.
 	 */
 	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+		/* See sd_has_asym_cpucapacity() */
 		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
-		/*
-		 * On an asymmetric CPU capacity system where an exclusive
-		 * cpuset defines a symmetric island (i.e. one unique
-		 * capacity_orig value through the cpuset), the key will be set
-		 * but the CPUs within that cpuset will not have a domain with
-		 * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
-		 * capacity path.
-		 */
 		if (sd) {
 			i = select_idle_capacity(p, sd, target);
 			return ((unsigned)i < nr_cpumask_bits) ? i : target;
@@ -8467,7 +8460,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			continue;
 
 		/* Check for a misfit task on the cpu */
-		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
+		if (sd_has_asym_cpucapacity(env->sd) &&
 		    sgs->group_misfit_task_load < rq->misfit_task_load) {
 			sgs->group_misfit_task_load = rq->misfit_task_load;
 			*sg_status |= SG_OVERLOAD;
@@ -8524,7 +8517,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * CPUs in the group should either be possible to resolve
 	 * internally or be covered by avg_load imbalance (eventually).
 	 */
-	if (sgs->group_type == group_misfit_task &&
+	if (static_branch_unlikely(&sched_asym_cpucapacity) &&
+	    sgs->group_type == group_misfit_task &&
 	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
 	     sds->local_stat.group_type != group_has_spare))
 		return false;
@@ -8607,7 +8601,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * throughput. Maximize throughput, power/energy consequences are not
 	 * considered.
 	 */
-	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
+	if (sd_has_asym_cpucapacity(env->sd) &&
 	    (sgs->group_type <= group_fully_busy) &&
 	    (group_smaller_min_cpu_capacity(sds->local, sg)))
 		return false;
@@ -8730,7 +8724,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 	}
 
 	/* Check if task fits in the group */
-	if (sd->flags & SD_ASYM_CPUCAPACITY &&
+	if (sd_has_asym_cpucapacity(sd) &&
 	    !task_fits_capacity(p, group->sgc->max_capacity)) {
 		sgs->group_misfit_task_load = 1;
 	}
@@ -9408,7 +9402,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * Higher per-CPU capacity is considered better than balancing
 		 * average load.
 		 */
-		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
+		if (sd_has_asym_cpucapacity(env->sd) &&
 		    capacity_of(env->dst_cpu) < capacity &&
 		    nr_running == 1)
 			continue;
@@ -10225,6 +10219,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		}
 	}
 
+	 /* See sd_has_asym_cpucapacity(). */
 	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
 	if (sd) {
 		/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2e09a647c4f..27bf70bc86c7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1492,6 +1492,39 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
+/*
+ * Note that the static key is system-wide, but the visibility of
+ * SD_ASYM_CPUCAPACITY isn't. Thus the static key being enabled does not
+ * imply all CPUs can see asymmetry.
+ *
+ * Consider an asymmetric CPU capacity system such as:
+ *
+ * MC [           ]
+ *     0 1 2 3 4 5
+ *     L L L L B B
+ *
+ * w/ arch_scale_cpu_capacity(L) < arch_scale_cpu_capacity(B)
+ *
+ * By default, booting this system will enable the sched_asym_cpucapacity
+ * static key, and all CPUs will see SD_ASYM_CPUCAPACITY set at their MC
+ * sched_domain.
+ *
+ * Further consider exclusive cpusets creating a "symmetric island":
+ *
+ * MC [   ][      ]
+ *     0 1  2 3 4 5
+ *     L L  L L B B
+ *
+ * Again, booting this will enable the static key, but CPUs 0-1 will *not* have
+ * SD_ASYM_CPUCAPACITY set in any of their sched_domain. This is the intended
+ * behaviour, as CPUs 0-1 should be treated as a regular, isolated SMP system.
+ */
+static inline bool sd_has_asym_cpucapacity(struct sched_domain *sd)
+{
+	return static_branch_unlikely(&sched_asym_cpucapacity) &&
+		sd->flags & SD_ASYM_CPUCAPACITY;
+}
+
 struct sched_group_capacity {
 	atomic_t		ref;
 	/*
-- 
2.25.1

