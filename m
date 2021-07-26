Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6865D3D576D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhGZJoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:44:08 -0400
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:50221 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233080AbhGZJoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:44:05 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id D0161FA8D3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:24:30 +0100 (IST)
Received: (qmail 24802 invoked from network); 26 Jul 2021 10:24:30 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 26 Jul 2021 10:24:30 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 9/9] sched/core: Delete SIS_PROP and rely on the idle cpu mask
Date:   Mon, 26 Jul 2021 11:22:47 +0100
Message-Id: <20210726102247.21437-10-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726102247.21437-1-mgorman@techsingularity.net>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is an idle CPU mask that is approximately up to date, the
proportional scan depth can be removed and the scan depth is limited by
the estimated number of idle CPUs instead.

The plus side of this patch is that the time accounting overhead is gone.
The downside is that in some circumstances, this will scan more than
proportional scanning depending on whether an idle core is being scanned
or the accuracy of the idle CPU mask.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/core.c     | 22 ++++----------
 kernel/sched/fair.c     | 65 ++---------------------------------------
 kernel/sched/features.h |  5 ----
 kernel/sched/sched.h    |  5 ----
 4 files changed, 8 insertions(+), 89 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2751614ce0cb..9fcf9d1ae21c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3333,9 +3333,6 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 		if (rq->avg_idle > max)
 			rq->avg_idle = max;
 
-		rq->wake_stamp = jiffies;
-		rq->wake_avg_idle = rq->avg_idle / 2;
-
 		rq->idle_stamp = 0;
 	}
 #endif
@@ -8648,18 +8645,11 @@ int sched_cpu_activate(unsigned int cpu)
 	balance_push_set(cpu, false);
 
 #ifdef CONFIG_SCHED_SMT
-	do {
-		int weight = cpumask_weight(cpu_smt_mask(cpu));
-
-		if (weight > sched_smt_weight)
-			sched_smt_weight = weight;
-
-		/*
-		 * When going up, increment the number of cores with SMT present.
-		 */
-		if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-			static_branch_inc_cpuslocked(&sched_smt_present);
-	} while (0);
+	/*
+	 * When going up, increment the number of cores with SMT present.
+	 */
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+		static_branch_inc_cpuslocked(&sched_smt_present);
 #endif
 	set_cpu_active(cpu, true);
 
@@ -9029,8 +9019,6 @@ void __init sched_init(void)
 		rq->online = 0;
 		rq->idle_stamp = 0;
 		rq->avg_idle = 2*sysctl_sched_migration_cost;
-		rq->wake_stamp = jiffies;
-		rq->wake_avg_idle = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
 		rq->last_idle_state = 1;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fe87af2ccc80..70b6d840426a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6076,8 +6076,6 @@ static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
 
-int __read_mostly sched_smt_weight = 1;
-
 static inline void set_idle_cores(int cpu, int val)
 {
 	struct sched_domain_shared *sds;
@@ -6196,8 +6194,6 @@ static inline bool test_idle_cores(int cpu, bool def)
 	return def;
 }
 
-#define sched_smt_weight 1
-
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return __select_idle_cpu(core, p);
@@ -6210,8 +6206,6 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 
 #endif /* CONFIG_SCHED_SMT */
 
-#define sis_min_cores	2
-
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6220,12 +6214,8 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int i, cpu, idle_cpu = -1, nr = INT_MAX;
-	struct rq *this_rq = this_rq();
-	int this = smp_processor_id();
+	int i, cpu, idle_cpu = -1;
 	struct sched_domain *this_sd;
-	u64 time = 0;
-
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
 		return -1;
@@ -6237,69 +6227,20 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	 */
 	cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP)) {
-		u64 avg_cost, avg_idle, span_avg;
-		unsigned long now = jiffies;
-
-		/*
-		 * If we're busy, the assumption that the last idle period
-		 * predicts the future is flawed; age away the remaining
-		 * predicted idle time.
-		 */
-		if (unlikely(this_rq->wake_stamp < now)) {
-			while (this_rq->wake_stamp < now && this_rq->wake_avg_idle) {
-				this_rq->wake_stamp++;
-				this_rq->wake_avg_idle >>= 1;
-			}
-		}
-
-		avg_idle = this_rq->wake_avg_idle;
-		avg_cost = this_sd->avg_scan_cost + 1;
-
-		span_avg = sd->span_weight * avg_idle;
-		if (span_avg > sis_min_cores * avg_cost)
-			nr = div_u64(span_avg, avg_cost);
-		else
-			nr = sis_min_cores;
-
-		nr *= sched_smt_weight;
-		time = cpu_clock(this);
-	}
-
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
 			if ((unsigned int)i < nr_cpumask_bits)
 				break;
-
-			nr -= sched_smt_weight;
 		} else {
 			idle_cpu = __select_idle_cpu(cpu, p);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
-			nr--;
 		}
-
-		if (nr < 0)
-			break;
 	}
 
-	if ((unsigned int)idle_cpu < nr_cpumask_bits) {
-		if (has_idle_core)
-			set_idle_cores(target, false);
-
-		if (sched_feat(SIS_PROP)) {
-			time = cpu_clock(this) - time;
-
-			/*
-			 * Account for the scan cost of wakeups against the average
-			 * idle time.
-			 */
-			this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
-
-			update_avg(&this_sd->avg_scan_cost, time);
-		}
-	}
+	if ((unsigned int)idle_cpu < nr_cpumask_bits && has_idle_core)
+		set_idle_cores(target, false);
 
 	return idle_cpu;
 }
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7f8dace0964c..4bb29c830b9d 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -52,11 +52,6 @@ SCHED_FEAT(NONTASK_CAPACITY, true)
  */
 SCHED_FEAT(TTWU_QUEUE, true)
 
-/*
- * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
- */
-SCHED_FEAT(SIS_PROP, true)
-
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
  * in a single rq->lock section. Default disabled because the
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2d6456fa15cb..35a0b591a2de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1024,9 +1024,6 @@ struct rq {
 	u64			idle_stamp;
 	u64			avg_idle;
 
-	unsigned long		wake_stamp;
-	u64			wake_avg_idle;
-
 	/* This is used to determine avg_idle's max value */
 	u64			max_idle_balance_cost;
 
@@ -1352,8 +1349,6 @@ do {						\
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
 
-extern int sched_smt_weight;
-
 static inline void update_idle_core(struct rq *rq)
 {
 	if (static_branch_unlikely(&sched_smt_present))
-- 
2.26.2

