Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE63D576B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhGZJny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:43:54 -0400
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:56065 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232619AbhGZJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:43:53 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id A9D39FA8E9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:24:20 +0100 (IST)
Received: (qmail 24428 invoked from network); 26 Jul 2021 10:24:20 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 26 Jul 2021 10:24:20 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 8/9] sched/fair: select idle cpu from idle cpumask for task wakeup
Date:   Mon, 26 Jul 2021 11:22:46 +0100
Message-Id: <20210726102247.21437-9-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726102247.21437-1-mgorman@techsingularity.net>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aubrey Li <aubrey.li@linux.intel.com>

Add idle cpumask to track idle cpus in sched domain. Every time
a CPU enters idle, the CPU is set in idle cpumask to be a wakeup
target. And if the CPU is not in idle, the CPU is cleared in idle
cpumask during scheduler tick to ratelimit idle cpumask update.

When a task wakes up to select an idle cpu, scanning idle cpumask
has lower cost than scanning all the cpus in last level cache domain,
especially when the system is heavily loaded.

v10-v11:
- Forward port to 5.13-rc5 based kernel

v9->v10:
- Update scan cost only when the idle cpumask is scanned, i.e, the
  idle cpumask is not empty

v8->v9:
- rebase on top of tip/sched/core, no code change

v7->v8:
- refine update_idle_cpumask, no functionality change
- fix a suspicious RCU usage warning with CONFIG_PROVE_RCU=y

v6->v7:
- place the whole idle cpumask mechanism under CONFIG_SMP

v5->v6:
- decouple idle cpumask update from stop_tick signal, set idle CPU
  in idle cpumask every time the CPU enters idle

v4->v5:
- add update_idle_cpumask for s2idle case
- keep the same ordering of tick_nohz_idle_stop_tick() and update_
  idle_cpumask() everywhere

v3->v4:
- change setting idle cpumask from every idle entry to tickless idle
  if cpu driver is available
- move clearing idle cpumask to scheduler_tick to decouple nohz mode

v2->v3:
- change setting idle cpumask to every idle entry, otherwise schbench
  has a regression of 99th percentile latency
- change clearing idle cpumask to nohz_balancer_kick(), so updating
  idle cpumask is ratelimited in the idle exiting path
- set SCHED_IDLE cpu in idle cpumask to allow it as a wakeup target

v1->v2:
- idle cpumask is updated in the nohz routines, by initializing idle
  cpumask with sched_domain_span(sd), nohz=off case remains the original
  behavior

[mgorman@techsingularity.net: RCU protection in update_idle_cpumask]
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jiang Biao <benbjiang@gmail.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/sched/topology.h | 13 ++++++++++
 kernel/sched/core.c            |  2 ++
 kernel/sched/fair.c            | 46 +++++++++++++++++++++++++++++++++-
 kernel/sched/idle.c            |  5 ++++
 kernel/sched/sched.h           |  4 +++
 kernel/sched/topology.c        |  3 ++-
 6 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8f0f778b7c91..905e382ece1a 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -74,8 +74,21 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+	/*
+	 * Span of all idle CPUs in this domain.
+	 *
+	 * NOTE: this field is variable length. (Allocated dynamically
+	 * by attaching extra space to the end of the structure,
+	 * depending on how many CPUs the kernel has booted up with)
+	 */
+	unsigned long	idle_cpus_span[];
 };
 
+static inline struct cpumask *sds_idle_cpus(struct sched_domain_shared *sds)
+{
+	return to_cpumask(sds->idle_cpus_span);
+}
+
 struct sched_domain {
 	/* These fields must be setup */
 	struct sched_domain __rcu *parent;	/* top domain must be null terminated */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7c073b67f1ea..2751614ce0cb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4965,6 +4965,7 @@ void scheduler_tick(void)
 
 #ifdef CONFIG_SMP
 	rq->idle_balance = idle_cpu(cpu);
+	update_idle_cpumask(cpu, rq->idle_balance);
 	trigger_load_balance(rq);
 #endif
 }
@@ -9031,6 +9032,7 @@ void __init sched_init(void)
 		rq->wake_stamp = jiffies;
 		rq->wake_avg_idle = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
+		rq->last_idle_state = 1;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b180205e6b25..fe87af2ccc80 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6230,7 +6230,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	if (!this_sd)
 		return -1;
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	/*
+	 * sched_domain_shared is set only at shared cache level,
+	 * this works only because select_idle_cpu is called with
+	 * sd_llc.
+	 */
+	cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
 
 	if (sched_feat(SIS_PROP)) {
 		u64 avg_cost, avg_idle, span_avg;
@@ -7018,6 +7023,45 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	return newidle_balance(rq, rf) != 0;
 }
+
+/*
+ * Update cpu idle state and record this information
+ * in sd_llc_shared->idle_cpus_span.
+ *
+ * This function is called with interrupts disabled.
+ */
+void update_idle_cpumask(int cpu, bool idle)
+{
+	struct sched_domain *sd;
+	struct rq *rq = cpu_rq(cpu);
+	int idle_state;
+
+	/*
+	 * Also set SCHED_IDLE cpu in idle cpumask to
+	 * allow SCHED_IDLE cpu as a wakeup target.
+	 */
+	idle_state = idle || sched_idle_cpu(cpu);
+	/*
+	 * No need to update idle cpumask if the state
+	 * does not change.
+	 */
+	if (rq->last_idle_state == idle_state)
+		return;
+
+	rcu_read_lock();
+	sd = per_cpu(sd_llc, cpu);
+	if (unlikely(!sd))
+		goto unlock;
+
+	if (idle_state)
+		cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
+	else
+		cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
+
+	rq->last_idle_state = idle_state;
+unlock:
+	rcu_read_unlock();
+}
 #endif /* CONFIG_SMP */
 
 static unsigned long wakeup_gran(struct sched_entity *se)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 912b47aa99d8..86bfe81cc280 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -289,6 +289,11 @@ static void do_idle(void)
 			cpuhp_report_idle_dead();
 			arch_cpu_idle_dead();
 		}
+		/*
+		 * The CPU is about to go idle, set it in idle cpumask
+		 * to be a wake up target.
+		 */
+		update_idle_cpumask(cpu, true);
 
 		arch_cpu_idle_enter();
 		rcu_nocb_flush_deferred_wakeup();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4d47a0969710..2d6456fa15cb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -998,6 +998,7 @@ struct rq {
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
+	unsigned char		last_idle_state;
 
 	unsigned long		misfit_task_load;
 
@@ -1846,6 +1847,8 @@ static inline unsigned int group_first_cpu(struct sched_group *group)
 
 extern int group_balance_cpu(struct sched_group *sg);
 
+void update_idle_cpumask(int cpu, bool idle);
+
 #ifdef CONFIG_SCHED_DEBUG
 void update_sched_domain_debugfs(void);
 void dirty_sched_domain_sysctl(int cpu);
@@ -1864,6 +1867,7 @@ extern void flush_smp_call_function_from_idle(void);
 
 #else /* !CONFIG_SMP: */
 static inline void flush_smp_call_function_from_idle(void) { }
+static inline void update_idle_cpumask(int cpu, bool idle) { }
 #endif
 
 #include "stats.h"
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b77ad49dc14f..2075bc417b90 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1611,6 +1611,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+		cpumask_copy(sds_idle_cpus(sd->shared), sched_domain_span(sd));
 	}
 
 	sd->private = sdd;
@@ -1970,7 +1971,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;
-- 
2.26.2

