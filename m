Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3436A3332F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhCJCEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:04:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:39777 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhCJCD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:03:57 -0500
IronPort-SDR: W6RnDNDuQCN3R8YEpsRhrltosA4gLF4AFYWoDnXjERcrPll7PKJ389kOnheN1FdGxehFCLNOet
 IsDccuB3yggw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="167636768"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="167636768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 18:03:57 -0800
IronPort-SDR: 3m1K0pJmu/qYEtIzWx76lJTQIRakC30I7jy08iRij/gU14wnjcVoHHQ00bGxOabjIjTODFr0Bm
 4NS/Kg7en3DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="409977906"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.7])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2021 18:03:53 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        mgorman@techsingularity.net, juri.lelli@redhat.com,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com
Cc:     tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: [PATCH v9 2/2] sched/fair: Remove SIS_PROP
Date:   Wed, 10 Mar 2021 10:12:22 +0800
Message-Id: <1615342342-50093-2-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615342342-50093-1-git-send-email-aubrey.li@intel.com>
References: <1615342342-50093-1-git-send-email-aubrey.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aubrey Li <aubrey.li@linux.intel.com>

Scanning idle cpu from the idle cpumask avoid superfluous scans
of the LLC domain, as the first bit in the idle cpumask is the
target. Considering the selected target could become busy, the
idle check is reserved, but SIS_PROP feature becomes meaningless,
so remove avg_scan_cost computation as well.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Jiang Biao <benbjiang@gmail.com>
Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 include/linux/sched/topology.h |  2 --
 kernel/sched/fair.c            | 33 ++-------------------------------
 kernel/sched/features.h        |  5 -----
 3 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 905e382..2a37596 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -113,8 +113,6 @@ struct sched_domain {
 	u64 max_newidle_lb_cost;
 	unsigned long next_decay_max_lb_cost;
 
-	u64 avg_scan_cost;		/* select_idle_sibling */
-
 #ifdef CONFIG_SCHEDSTATS
 	/* load_balance() stats */
 	unsigned int lb_count[CPU_MAX_IDLE_TYPES];
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 15d23d2..6236822 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6117,18 +6117,15 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 #endif /* CONFIG_SCHED_SMT */
 
 /*
- * Scan the LLC domain for idle CPUs; this is dynamically regulated by
- * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
- * average idle time for this rq (as found in rq->avg_idle).
+ * Scan idle cpumask in the LLC domain for idle CPUs
  */
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	int i, cpu, idle_cpu = -1;
 	bool smt = test_idle_cores(target, false);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
-	u64 time;
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
@@ -6141,25 +6138,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	 */
 	cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP) && !smt) {
-		u64 avg_cost, avg_idle, span_avg;
-
-		/*
-		 * Due to large variance we need a large fuzz factor;
-		 * hackbench in particularly is sensitive here.
-		 */
-		avg_idle = this_rq()->avg_idle / 512;
-		avg_cost = this_sd->avg_scan_cost + 1;
-
-		span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
-			nr = div_u64(span_avg, avg_cost);
-		else
-			nr = 4;
-
-		time = cpu_clock(this);
-	}
-
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (smt) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -6167,8 +6145,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 				return i;
 
 		} else {
-			if (!--nr)
-				return -1;
 			idle_cpu = __select_idle_cpu(cpu);
 			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
@@ -6178,11 +6154,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	if (smt)
 		set_idle_cores(this, false);
 
-	if (sched_feat(SIS_PROP) && !smt) {
-		time = cpu_clock(this) - time;
-		update_avg(&this_sd->avg_scan_cost, time);
-	}
-
 	return idle_cpu;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 1bc2b15..267aa774 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -53,11 +53,6 @@ SCHED_FEAT(NONTASK_CAPACITY, true)
 SCHED_FEAT(TTWU_QUEUE, true)
 
 /*
- * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
- */
-SCHED_FEAT(SIS_PROP, true)
-
-/*
  * Issue a WARN when we do multiple update_rq_clock() calls
  * in a single rq->lock section. Default disabled because the
  * annotations are not complete.
-- 
2.7.4

