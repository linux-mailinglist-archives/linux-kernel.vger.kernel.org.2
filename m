Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6768A3D575B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhGZJmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:42:44 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:32929 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhGZJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:42:41 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id A4755BEC42
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:23:08 +0100 (IST)
Received: (qmail 21890 invoked from network); 26 Jul 2021 10:23:08 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 26 Jul 2021 10:23:08 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/9] sched/fair: Track efficiency of select_idle_sibling
Date:   Mon, 26 Jul 2021 11:22:39 +0100
Message-Id: <20210726102247.21437-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726102247.21437-1-mgorman@techsingularity.net>
References: <20210726102247.21437-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_sibling is an important path that finds a nearby idle CPU on
wakeup. As it is examining other CPUs state, it can be expensive in terms
of cache usage. This patch tracks the search efficiency if schedstats
are enabled. In general, this is only useful for kernel developers but
schedstats are typically disabled by default so it is convenient for
development and mostly free otherwise.

The series can be done without this patch but the stats were used to
generate a number of useful metrics in mmtest to analyse what was
going on.

SIS Search: Number of calls to select_idle_sibling

SIS Domain Search: Number of times the domain was searched because the
	fast path failed.

SIS Scanned: Generally the number of runqueues scanned but the fast
	path counts as 1 regardless of the values for target, prev
	and recent.

SIS Domain Scanned: Number of runqueues scanned during a search of the
	LLC domain.

SIS Failures: Number of SIS calls that failed to find an idle CPU

SIS Search Efficiency: A ratio expressed as a percentage of runqueues
	scanned versus idle CPUs found. A 100% efficiency indicates that
	the target, prev or recent CPU of a task was idle at wakeup. The
	lower the efficiency, the more runqueues were scanned before an
	idle CPU was found.

SIS Domain Search Efficiency: Similar, except only for the slower SIS
	patch.

SIS Fast Success Rate: Percentage of SIS that used target, prev or
	recent CPUs.

SIS Success rate: Percentage of scans that found an idle CPU.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/debug.c |  4 ++++
 kernel/sched/fair.c  | 14 ++++++++++++++
 kernel/sched/sched.h |  6 ++++++
 kernel/sched/stats.c |  8 +++++---
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0c5ec2776ddf..603d4bc71612 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -738,6 +738,10 @@ do {									\
 		P(sched_goidle);
 		P(ttwu_count);
 		P(ttwu_local);
+		P(sis_search);
+		P(sis_domain_search);
+		P(sis_scanned);
+		P(sis_failed);
 	}
 #undef P
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44c452072a1b..cc0b451d1794 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6064,6 +6064,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 
 static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 {
+	schedstat_inc(this_rq()->sis_scanned);
 	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
 	    sched_cpu_cookie_match(cpu_rq(cpu), p))
 		return cpu;
@@ -6138,6 +6139,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		return __select_idle_cpu(core, p);
 
 	for_each_cpu(cpu, cpu_smt_mask(core)) {
+		schedstat_inc(this_rq()->sis_scanned);
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
@@ -6168,6 +6170,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 	int cpu;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
+		schedstat_inc(this_rq()->sis_scanned);
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
 		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
@@ -6334,6 +6337,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	unsigned long task_util;
 	int i, recent_used_cpu;
 
+	schedstat_inc(this_rq()->sis_search);
+
+	/*
+	 * Checking if prev, target and recent is treated as one scan. A
+	 * perfect hit on one of those is considered 100% efficiency.
+	 * Further scanning impairs efficiency.
+	 */
+	schedstat_inc(this_rq()->sis_scanned);
+
 	/*
 	 * On asymmetric system, update task utilization because we will check
 	 * that the task fits with cpu's capacity.
@@ -6414,6 +6426,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
+	schedstat_inc(this_rq()->sis_domain_search);
 	if (sched_smt_active()) {
 		has_idle_core = test_idle_cores(target, false);
 
@@ -6428,6 +6441,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	schedstat_inc(this_rq()->sis_failed);
 	return target;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a243f7b..4cf307763fe9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1072,6 +1072,12 @@ struct rq {
 	/* try_to_wake_up() stats */
 	unsigned int		ttwu_count;
 	unsigned int		ttwu_local;
+
+	/* select_idle_sibling stats */
+	unsigned int		sis_search;
+	unsigned int		sis_domain_search;
+	unsigned int		sis_scanned;
+	unsigned int		sis_failed;
 #endif
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 3f93fc3b5648..7dd9b0dec437 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -10,7 +10,7 @@
  * Bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 15
+#define SCHEDSTAT_VERSION 16
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -30,12 +30,14 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
+		    rq->sis_search, rq->sis_domain_search,
+		    rq->sis_scanned, rq->sis_failed);
 
 		seq_printf(seq, "\n");
 
-- 
2.26.2

