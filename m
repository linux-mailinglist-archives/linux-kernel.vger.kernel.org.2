Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C019C4560CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhKRQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:45:52 -0500
Received: from foss.arm.com ([217.140.110.172]:42974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233601AbhKRQpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:45:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 787986D;
        Thu, 18 Nov 2021 08:42:50 -0800 (PST)
Received: from dell3630.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B4083F766;
        Thu, 18 Nov 2021 08:42:48 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/fair: Replace CFS internal cpu_util() with cpu_util_cfs()
Date:   Thu, 18 Nov 2021 17:42:40 +0100
Message-Id: <20211118164240.623551-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_util_cfs() was created by commit d4edd662ac16 ("sched/cpufreq: Use
the DEADLINE utilization signal") to enable the access to CPU
utilization from the Schedutil CPUfreq governor.

Commit a07630b8b2c1 ("sched/cpufreq/schedutil: Use util_est for OPP
selection") added util_est support later.

The only thing cpu_util() is doing on top of what cpu_util_cfs() already
does is to clamp the return value to the [0..capacity_orig] capacity
range of the CPU. Integrating this into cpu_util_cfs() is not harming
the existing users (Schedutil and CPUfreq cooling (latter via
sched_cpu_util() wrapper)).

For straightforwardness, prefer to keep using `int cpu` as the function
parameter over using `struct rq *rq` which might avoid some calls to
cpu_rq(cpu) -> per_cpu(runqueues, cpu) -> RELOC_HIDE().
Update cfs_util()'s documentation and reuse it for cpu_util_cfs().
Remove cpu_util().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c              |  2 +-
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/fair.c              | 71 ++++----------------------------
 kernel/sched/sched.h             | 44 ++++++++++++++++++--
 4 files changed, 50 insertions(+), 69 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f2611b9cf503..a86865ebbe2f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7123,7 +7123,7 @@ unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 
 unsigned long sched_cpu_util(int cpu, unsigned long max)
 {
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu_rq(cpu)), max,
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), max,
 				  ENERGY_UTIL, NULL);
 }
 #endif /* CONFIG_SMP */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e7af18857371..26778884d9ab 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -168,7 +168,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
-	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(rq), max,
+	sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu), max,
 					  FREQUENCY_UTIL, NULL);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 13950beb01a2..6ddc2013e033 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1502,7 +1502,6 @@ struct task_numa_env {
 
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
-static unsigned long cpu_util(int cpu);
 static inline long adjust_numa_imbalance(int imbalance,
 					int dst_running, int dst_weight);
 
@@ -1569,7 +1568,7 @@ static void update_numa_stats(struct task_numa_env *env,
 
 		ns->load += cpu_load(rq);
 		ns->runnable += cpu_runnable(rq);
-		ns->util += cpu_util(cpu);
+		ns->util += cpu_util_cfs(cpu);
 		ns->nr_running += rq->cfs.h_nr_running;
 		ns->compute_capacity += capacity_of(cpu);
 
@@ -3240,7 +3239,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 		 * As is, the util number is not freq-invariant (we'd have to
 		 * implement arch_scale_freq_capacity() for that).
 		 *
-		 * See cpu_util().
+		 * See cpu_util_cfs().
 		 */
 		cpufreq_update_util(rq, flags);
 	}
@@ -5509,11 +5508,9 @@ static inline void hrtick_update(struct rq *rq)
 #endif
 
 #ifdef CONFIG_SMP
-static inline unsigned long cpu_util(int cpu);
-
 static inline bool cpu_overutilized(int cpu)
 {
-	return !fits_capacity(cpu_util(cpu), capacity_of(cpu));
+	return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
 }
 
 static inline void update_overutilized_status(struct rq *rq)
@@ -6456,58 +6453,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	return target;
 }
 
-/**
- * cpu_util - Estimates the amount of capacity of a CPU used by CFS tasks.
- * @cpu: the CPU to get the utilization of
- *
- * The unit of the return value must be the one of capacity so we can compare
- * the utilization with the capacity of the CPU that is available for CFS task
- * (ie cpu_capacity).
- *
- * cfs_rq.avg.util_avg is the sum of running time of runnable tasks plus the
- * recent utilization of currently non-runnable tasks on a CPU. It represents
- * the amount of utilization of a CPU in the range [0..capacity_orig] where
- * capacity_orig is the cpu_capacity available at the highest frequency
- * (arch_scale_freq_capacity()).
- * The utilization of a CPU converges towards a sum equal to or less than the
- * current capacity (capacity_curr <= capacity_orig) of the CPU because it is
- * the running time on this CPU scaled by capacity_curr.
- *
- * The estimated utilization of a CPU is defined to be the maximum between its
- * cfs_rq.avg.util_avg and the sum of the estimated utilization of the tasks
- * currently RUNNABLE on that CPU.
- * This allows to properly represent the expected utilization of a CPU which
- * has just got a big task running since a long sleep period. At the same time
- * however it preserves the benefits of the "blocked utilization" in
- * describing the potential for other tasks waking up on the same CPU.
- *
- * Nevertheless, cfs_rq.avg.util_avg can be higher than capacity_curr or even
- * higher than capacity_orig because of unfortunate rounding in
- * cfs.avg.util_avg or just after migrating tasks and new task wakeups until
- * the average stabilizes with the new running time. We need to check that the
- * utilization stays within the range of [0..capacity_orig] and cap it if
- * necessary. Without utilization capping, a group could be seen as overloaded
- * (CPU0 utilization at 121% + CPU1 utilization at 80%) whereas CPU1 has 20% of
- * available capacity. We allow utilization to overshoot capacity_curr (but not
- * capacity_orig) as it useful for predicting the capacity required after task
- * migrations (scheduler-driven DVFS).
- *
- * Return: the (estimated) utilization for the specified CPU
- */
-static inline unsigned long cpu_util(int cpu)
-{
-	struct cfs_rq *cfs_rq;
-	unsigned int util;
-
-	cfs_rq = &cpu_rq(cpu)->cfs;
-	util = READ_ONCE(cfs_rq->avg.util_avg);
-
-	if (sched_feat(UTIL_EST))
-		util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));
-
-	return min_t(unsigned long, util, capacity_orig_of(cpu));
-}
-
 /*
  * cpu_util_without: compute cpu utilization without any contributions from *p
  * @cpu: the CPU which utilization is requested
@@ -6528,7 +6473,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 
 	/* Task has no contribution or is new */
 	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
-		return cpu_util(cpu);
+		return cpu_util_cfs(cpu);
 
 	cfs_rq = &cpu_rq(cpu)->cfs;
 	util = READ_ONCE(cfs_rq->avg.util_avg);
@@ -6592,7 +6537,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 	/*
 	 * Utilization (estimated) can exceed the CPU capacity, thus let's
 	 * clamp to the maximum CPU capacity to ensure consistency with
-	 * the cpu_util call.
+	 * cpu_util.
 	 */
 	return min_t(unsigned long, util, capacity_orig_of(cpu));
 }
@@ -6624,7 +6569,7 @@ static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
 		 * During wake-up, the task isn't enqueued yet and doesn't
 		 * appear in the cfs_rq->avg.util_est.enqueued of any rq,
 		 * so just add it (if needed) to "simulate" what will be
-		 * cpu_util() after the task has been enqueued.
+		 * cpu_util after the task has been enqueued.
 		 */
 		if (dst_cpu == cpu)
 			util_est += _task_util_est(p);
@@ -8681,7 +8626,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		struct rq *rq = cpu_rq(i);
 
 		sgs->group_load += cpu_load(rq);
-		sgs->group_util += cpu_util(i);
+		sgs->group_util += cpu_util_cfs(i);
 		sgs->group_runnable += cpu_runnable(rq);
 		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
@@ -9699,7 +9644,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 			break;
 
 		case migrate_util:
-			util = cpu_util(cpu_of(rq));
+			util = cpu_util_cfs(i);
 
 			/*
 			 * Don't try to pull utilization from a CPU with one
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f0b249ec581d..2733f15c5859 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2942,16 +2942,52 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 	return READ_ONCE(rq->avg_dl.util_avg);
 }
 
-static inline unsigned long cpu_util_cfs(struct rq *rq)
+/**
+ * cpu_util_cfs() - Estimates the amount of CPU capacity used by CFS tasks.
+ * @cpu: the CPU to get the utilization for.
+ *
+ * The unit of the return value must be the same as the one of CPU capacity
+ * so that CPU utilization can be compared with CPU capacity.
+ *
+ * CPU utilization is the sum of running time of runnable tasks plus the
+ * recent utilization of currently non-runnable tasks on that CPU.
+ * It represents the amount of CPU capacity currently used by CFS tasks in
+ * the range [0..max CPU capacity] with max CPU capacity being the CPU
+ * capacity at f_max.
+ *
+ * The estimated CPU utilization is defined as the maximum between CPU
+ * utilization and sum of the estimated utilization of the currently
+ * runnable tasks on that CPU. It preserves a utilization "snapshot" of
+ * previously-executed tasks, which helps better deduce how busy a CPU will
+ * be when a long-sleeping task wakes up. The contribution to CPU utilization
+ * of such a task would be significantly decayed at this point of time.
+ *
+ * CPU utilization can be higher than the current CPU capacity
+ * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because
+ * of rounding errors as well as task migrations or wakeups of new tasks.
+ * CPU utilization has to be capped to fit into the [0..max CPU capacity]
+ * range. Otherwise a group of CPUs (CPU0 util = 121% + CPU1 util = 80%)
+ * could be seen as over-utilized even though CPU1 has 20% of spare CPU
+ * capacity. CPU utilization is allowed to overshoot current CPU capacity
+ * though since this is useful for predicting the CPU capacity required
+ * after task migrations (scheduler-driven DVFS).
+ *
+ * Return: (Estimated) utilization for the specified CPU.
+ */
+static inline unsigned long cpu_util_cfs(int cpu)
 {
-	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
+	struct cfs_rq *cfs_rq;
+	unsigned long util;
+
+	cfs_rq = &cpu_rq(cpu)->cfs;
+	util = READ_ONCE(cfs_rq->avg.util_avg);
 
 	if (sched_feat(UTIL_EST)) {
 		util = max_t(unsigned long, util,
-			     READ_ONCE(rq->cfs.avg.util_est.enqueued));
+			     READ_ONCE(cfs_rq->avg.util_est.enqueued));
 	}
 
-	return util;
+	return min(util, capacity_orig_of(cpu));
 }
 
 static inline unsigned long cpu_util_rt(struct rq *rq)
-- 
2.25.1

