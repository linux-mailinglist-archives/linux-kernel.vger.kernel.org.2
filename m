Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38013307E17
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhA1Sfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:35:47 -0500
Received: from foss.arm.com ([217.140.110.172]:37326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232137AbhA1Scy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:32:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B08143D;
        Thu, 28 Jan 2021 10:32:09 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ADAE23F719;
        Thu, 28 Jan 2021 10:32:07 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Subject: [PATCH 2/8] sched/fair: Add more sched_asym_cpucapacity static branch checks
Date:   Thu, 28 Jan 2021 18:31:35 +0000
Message-Id: <20210128183141.28097-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128183141.28097-1-valentin.schneider@arm.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rik noted a while back that a handful of

  sd->flags & SD_ASYM_CPUCAPACITY

& family in the CFS load-balancer code aren't guarded by the
sched_asym_cpucapacity static branch.

The load-balancer is already doing a humongous amount of work, but turning
those checks into NOPs for those who don't need it is fairly
straightforward, so do that.

Suggested-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c  | 11 ++++++-----
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f6a4e58ce3c..7d01fa0bfc7e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8465,7 +8465,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			continue;
 
 		/* Check for a misfit task on the cpu */
-		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
+		if (sd_has_asym_cpucapacity(env->sd) &&
 		    sgs->group_misfit_task_load < rq->misfit_task_load) {
 			sgs->group_misfit_task_load = rq->misfit_task_load;
 			*sg_status |= SG_OVERLOAD;
@@ -8522,7 +8522,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * CPUs in the group should either be possible to resolve
 	 * internally or be covered by avg_load imbalance (eventually).
 	 */
-	if (sgs->group_type == group_misfit_task &&
+	if (static_branch_unlikely(&sched_asym_cpucapacity) &&
+	    sgs->group_type == group_misfit_task &&
 	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
 	     sds->local_stat.group_type != group_has_spare))
 		return false;
@@ -8605,7 +8606,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * throughput. Maximize throughput, power/energy consequences are not
 	 * considered.
 	 */
-	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
+	if (sd_has_asym_cpucapacity(env->sd) &&
 	    (sgs->group_type <= group_fully_busy) &&
 	    (group_smaller_min_cpu_capacity(sds->local, sg)))
 		return false;
@@ -8728,7 +8729,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 	}
 
 	/* Check if task fits in the group */
-	if (sd->flags & SD_ASYM_CPUCAPACITY &&
+	if (sd_has_asym_cpucapacity(sd) &&
 	    !task_fits_capacity(p, group->sgc->max_capacity)) {
 		sgs->group_misfit_task_load = 1;
 	}
@@ -9419,7 +9420,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * Higher per-CPU capacity is considered better than balancing
 		 * average load.
 		 */
-		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
+		if (sd_has_asym_cpucapacity(env->sd) &&
 		    capacity_of(env->dst_cpu) < capacity &&
 		    nr_running == 1)
 			continue;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 045b01064c1e..21bd71f58c06 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1482,6 +1482,12 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
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
2.27.0

