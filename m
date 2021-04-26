Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9003C36B26F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhDZLl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:41:59 -0400
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:42233 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231550AbhDZLl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:41:56 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id CE87BFB213
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:41:13 +0100 (IST)
Received: (qmail 26320 invoked from network); 26 Apr 2021 11:41:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.248])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Apr 2021 11:41:13 -0000
Date:   Mon, 26 Apr 2021 12:41:12 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH 00/10] sched/fair: wake_affine improvements
Message-ID: <20210426114112.GE4239@techsingularity.net>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
 <20210423082532.GA4239@techsingularity.net>
 <20210426103940.GJ2633526@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210426103940.GJ2633526@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 04:09:40PM +0530, Srikar Dronamraju wrote:
> * Mel Gorman <mgorman@techsingularity.net> [2021-04-23 09:25:32]:
> 
> > On Thu, Apr 22, 2021 at 03:53:16PM +0530, Srikar Dronamraju wrote:
> > > Recently we found that some of the benchmark numbers on Power10 were lesser
> > > than expected. Some analysis showed that the problem lies in the fact that
> > > L2-Cache on Power10 is at core level i.e only 4 threads share the L2-cache.
> > > 
> > 
> > I didn't get the chance to review this properly although I am suspicious
> > of tracking idle_core and updating that more frequently. It becomes a very
> > hot cache line that bounces. I did experiement with tracking an idle core
> > but the data either went stale too quickly or the updates incurred more
> > overhead than a reduced search saved.
> > 
> 
> This change does increase the number of times we read the idle-core.  There
> are also more places where we try to update the idle-core. However I feel
> the number of times, we actually update the idle-core now will be much
> lesser than previous, because we are mostly doing a conditional update. i.e
> we are updating the idle-core only if the waking up CPU happens to be part
> of our core.
> 

Increased cache misses may be detectable from perf.

> Also if the system is mostly lightly loaded, we check for
> available_idle_cpu, so we may not look for an idle-core. If the system is
> running a CPU intensive task, then the idle-core will most likely to be -1.
> Its only the cases where the system utilization keeps swinging between
> lightly loaded to heavy load, that we would end up checking and setting
> idle-core.
> 

But this is a "how long is a piece of string" question because the benefit
of tracking an idle core depends on both the interarrival time of wakeups,
the domain utilisation and the length of time tasks are running. When
I was looking at the area, I tracked the SIS efficiency to see how much
each change was helping. The patch no longer applies but the stats are
understood by mmtests if you wanted to forward port it.  It's possible
you would do something similar but specific to idle_core -- e.g. track
how often it's updated, how often it's read, how often a CPU is returned
and how often it's still an idle core and use those stats to calculate
hit/miss ratios.

However, I would caution against conflating the "fallback search domain"
with the patches tracking idle core because they should be independent
of each other.

Old patch that no longer applies that was the basis for some SIS work
over a year ago is below

---8<---
From c791354b92a5723b0da14d050f942f61f0c12857 Mon Sep 17 00:00:00 2001
From: Mel Gorman <mgorman@techsingularity.net>
Date: Fri, 14 Feb 2020 19:11:16 +0000
Subject: [PATCH] sched/fair: Track efficiency of select_idle_sibling

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
index 8331bc04aea2..7af6e8a12f40 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -661,6 +661,10 @@ do {									\
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
index 23a6fe298720..10cdd28e910e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5975,6 +5975,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		bool idle = true;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
+			schedstat_inc(this_rq()->sis_scanned);
 			if (!available_idle_cpu(cpu)) {
 				idle = false;
 				break;
@@ -6005,6 +6006,7 @@ static int select_idle_smt(struct task_struct *p, int target)
 		return -1;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
+		schedstat_inc(this_rq()->sis_scanned);
 		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
@@ -6070,6 +6072,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
 	for_each_cpu_wrap(cpu, cpus, target) {
+		schedstat_inc(this_rq()->sis_scanned);
 		if (!--nr)
 			return -1;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
@@ -6126,6 +6129,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
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
 	 * For asymmetric CPU capacity systems, our domain of interest is
 	 * sd_asym_cpucapacity rather than sd_llc.
@@ -6191,6 +6203,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
+	schedstat_inc(this_rq()->sis_domain_search);
 	i = select_idle_core(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
@@ -6203,6 +6216,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
+	schedstat_inc(this_rq()->sis_failed);
 	return target;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2a0caf394dd4..c1a5c27cfd72 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1006,6 +1006,12 @@ struct rq {
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
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 750fb3c67eed..390bfcc3842c 100644
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
Mel Gorman
SUSE Labs
