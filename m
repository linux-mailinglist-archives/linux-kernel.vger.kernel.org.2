Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0A414A63
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhIVNVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:21:36 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:44413 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbhIVNVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:21:35 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 6F14C1C48E6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:20:04 +0100 (IST)
Received: (qmail 11602 invoked from network); 22 Sep 2021 13:20:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Sep 2021 13:20:04 -0000
Date:   Wed, 22 Sep 2021 14:20:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <20210922132002.GX3959@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net>
 <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 07:22:20AM +0200, Mike Galbraith wrote:
> On Tue, 2021-09-21 at 11:36 +0100, Mel Gorman wrote:
> > On Tue, Sep 21, 2021 at 05:52:32AM +0200, Mike Galbraith wrote:
> >
> >
> > > Preemption does rapidly run into diminishing return as load climbs for
> > > a lot of loads, but as you know, it's a rather sticky wicket because
> > > even when over-committed, preventing light control threads from slicing
> > > through (what can be a load's own work crew of) hogs can seriously
> > > injure performance.
> > >
> >
> > Turning this into a classic Rob Peter To Pay Paul problem. We don't know
> > if there is a light control thread that needs to run or not that affects
> > overall performance. It all depends on whether that control thread needs
> > to make progress for the overall workload or whether there are a mix of
> > workloads resulting in overloading.
> 
> WRT overload, and our good buddies Peter and Paul :) I added...
> 	if (gran >= sysctl_sched_latency >> 1)
> 		trace_printk("runnable:%d preempt disabled\n",cfs_rq->nr_running);
> ...to watch, and met the below when I.. logged in.
> 
> homer:..debug/tracing # tail -20 trace
>                X-2229    [002] d..5.    60.690322: wakeup_gran: runnable:9 preempt disabled
>                X-2229    [002] d..5.    60.690325: wakeup_gran: runnable:10 preempt disabled
>                X-2229    [002] d..5.    60.690330: wakeup_gran: runnable:11 preempt disabled
>                X-2229    [002] d..5.    60.690363: wakeup_gran: runnable:13 preempt disabled
>                X-2229    [002] d..5.    60.690377: wakeup_gran: runnable:14 preempt disabled
>                X-2229    [002] d..5.    60.690390: wakeup_gran: runnable:15 preempt disabled
>                X-2229    [002] d..5.    60.690404: wakeup_gran: runnable:16 preempt disabled
>                X-2229    [002] d..5.    60.690425: wakeup_gran: runnable:9 preempt disabled
>        ksmserver-2694    [003] d..3.    60.690432: wakeup_gran: runnable:6 preempt disabled
>        ksmserver-2694    [003] d..3.    60.690436: wakeup_gran: runnable:7 preempt disabled
>                X-2229    [002] d..5.    60.690451: wakeup_gran: runnable:6 preempt disabled
>                X-2229    [002] d..5.    60.690465: wakeup_gran: runnable:7 preempt disabled
>             kmix-2736    [000] d..3.    60.690491: wakeup_gran: runnable:6 preempt disabled
>                X-2229    [004] d..5.    92.889635: wakeup_gran: runnable:6 preempt disabled
>                X-2229    [004] d..5.    92.889675: wakeup_gran: runnable:6 preempt disabled
>                X-2229    [004] d..5.    92.889863: wakeup_gran: runnable:6 preempt disabled
>                X-2229    [004] d..5.    92.889944: wakeup_gran: runnable:6 preempt disabled
>                X-2229    [004] d..5.    92.889957: wakeup_gran: runnable:7 preempt disabled
>                X-2229    [004] d..5.    92.889968: wakeup_gran: runnable:8 preempt disabled
>   QXcbEventQueue-2740    [000] d..4.    92.890025: wakeup_gran: runnable:6 preempt disabled
> homer:..debug/tracing
> 
> Watching 'while sleep 1; do clear;tail trace; done' with nothing but a
> kbuild running is like watching top.  There's enough stacking during
> routine use of my desktop box that it runs into the tick granularity
> wall pretty much continuously, so 'overload' may want redefining.
> 

Ok, that's pretty convincing. You didn't mention if there were
interactivity glitches but it's possible. This is what I'm currently
testing but have no results for yet. It caps wakeup_gran at
sysctl_sched_latency.

---8<---
sched/fair: Scale wakeup granularity relative to nr_running

Commit 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs") moved
the kernel.sched_wakeup_granularity_ns sysctl under debugfs.  One of the
reasons why this sysctl may be used may be for "optimising for throughput",
particularly when overloaded. The tool TuneD sometimes alters this for two
profiles e.g. "mssql" and "throughput-performance". At least version 2.9
does but it changed in master where it also will poke at debugfs instead.

Internal parameters like sysctl_sched_wakeup_granularity are scaled
based on the number of CPUs due to sysctl_sched_tunable_scaling. For
simplicity, the timing figures in this changelog are based on
SCHED_TUNABLESCALING_NONE.

During task migration or wakeup, a decision is made on whether
to preempt the current task or not. To limit over-scheduled,
sysctl_sched_wakeup_granularity delays the preemption to allow at least 1ms
of runtime before preempting. However, when a domain is heavily overloaded
(e.g. hackbench), the degree of over-scheduling is still severe. This is
problematic as time is wasted rescheduling tasks that could instead be
used by userspace tasks.

However, care must be taken. Even if a system is overloaded, there may
be high priority threads that must still be able to run. Mike Galbraith
explained the contraints as follows;

	CFS came about because the O1 scheduler was unfair to the
	point it had starvation problems. People pretty much across the
	board agreed that a fair scheduler was a much way better way
	to go, and CFS was born.  It didn't originally have the sleep
	credit business, but had to grow it to become _short term_ fair.
	Ingo cut the sleep credit in half because of overscheduling, and
	that has worked out pretty well all told.. but now you're pushing
	it more in the unfair direction, all the way to extremely unfair
	for anything and everything very light.

	Fairness isn't the holy grail mind you, and at some point, giving
	up on short term fairness certainly isn't crazy, as proven by your
	hackbench numbers and other numbers we've seen over the years,
	but taking bites out of the 'CF' in the CFS that was born to be a
	corner-case killer is.. worrisome.  The other shoe will drop.. it
	always does :)

This patch scales the wakeup granularity based on the number of running
tasks on the CPU relative to

	sched_nr_disable_gran = sysctl_sched_latency / sysctl_sched_wakeup_granularity

By default, this will allow the wakeup_gran to scale from
sysctl_sched_wakeup_granularity up to sysctl_sched_wakeup_granularity up to
sysctl_sched_latency depending on the number of running tasks on a cfs_rq.
By default, the limit is 6ms.

Note that the TuneD throughput-performance profile allows up to 15ms
for sysctl_sched_latency (ignoring scaling) but there is no explanation
why such a long period was necessary or why sched_latency_ns is also
not adjusted. The intent may have been to disable wakeup preemption
or it might be an oversight.  An internet search for instances where
sysctl_sched_wakeup_granularity parameter are tuned to high values offer
either no explanation or a broken one.

TODO: Results positive or negative

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c     | 64 ++++++++++++++++++++++++++++++++++++++++++-------
 kernel/sched/features.h |  6 +++++
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f245b939..5ec3b12039d6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -84,6 +84,14 @@ static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
+/*
+ * This value is kept at sysctl_sched_latency / sysctl_sched_wakeup_granularity
+ *
+ * This influences the decision on whether a waking task can preempt a running
+ * task.
+ */
+static unsigned int sched_nr_disable_gran = 6;
+
 int sched_thermal_decay_shift;
 static int __init setup_sched_thermal_decay_shift(char *str)
 {
@@ -627,6 +635,9 @@ int sched_update_scaling(void)
 	sched_nr_latency = DIV_ROUND_UP(sysctl_sched_latency,
 					sysctl_sched_min_granularity);
 
+	sched_nr_disable_gran = DIV_ROUND_UP(sysctl_sched_latency,
+					sysctl_sched_wakeup_granularity);
+
 #define WRT_SYSCTL(name) \
 	(normalized_sysctl_##name = sysctl_##name / (factor))
 	WRT_SYSCTL(sched_min_granularity);
@@ -4511,7 +4522,8 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 }
 
 static int
-wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
+wakeup_preempt_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr,
+						struct sched_entity *se);
 
 /*
  * Pick the next process, keeping these things in mind, in this order:
@@ -4550,16 +4562,16 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 				second = curr;
 		}
 
-		if (second && wakeup_preempt_entity(second, left) < 1)
+		if (second && wakeup_preempt_entity(NULL, second, left) < 1)
 			se = second;
 	}
 
-	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
+	if (cfs_rq->next && wakeup_preempt_entity(NULL, cfs_rq->next, left) < 1) {
 		/*
 		 * Someone really wants this to run. If it's not unfair, run it.
 		 */
 		se = cfs_rq->next;
-	} else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
+	} else if (cfs_rq->last && wakeup_preempt_entity(NULL, cfs_rq->last, left) < 1) {
 		/*
 		 * Prefer last buddy, try to return the CPU to a preempted task.
 		 */
@@ -7044,9 +7056,42 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 }
 #endif /* CONFIG_SMP */
 
-static unsigned long wakeup_gran(struct sched_entity *se)
+static unsigned long
+select_wakeup_gran(struct cfs_rq *cfs_rq)
+{
+	unsigned int nr_running, threshold;
+
+	if (!cfs_rq || !sched_feat(SCALE_WAKEUP_GRAN))
+		return sysctl_sched_wakeup_granularity;
+
+	/* !GENTLE_FAIR_SLEEPERS has one overload threshold. */
+	if (!sched_feat(GENTLE_FAIR_SLEEPERS)) {
+		if (cfs_rq->nr_running <= sched_nr_disable_gran)
+			return sysctl_sched_wakeup_granularity;
+
+		return sysctl_sched_latency;
+	}
+
+	/* GENTLE_FAIR_SLEEPER has two overloaded thresholds. */
+	nr_running = cfs_rq->nr_running;
+	threshold = sched_nr_disable_gran >> 1;
+
+	/* No overload. */
+	if (nr_running <= threshold)
+		return sysctl_sched_wakeup_granularity;
+
+	/* Light overload. */
+	if (nr_running <= sched_nr_disable_gran)
+		return sysctl_sched_latency >> 1;
+
+	/* Heavy overload. */
+	return sysctl_sched_latency;
+}
+
+static unsigned long
+wakeup_gran(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	unsigned long gran = sysctl_sched_wakeup_granularity;
+	unsigned long gran = select_wakeup_gran(cfs_rq);
 
 	/*
 	 * Since its curr running now, convert the gran from real-time
@@ -7079,14 +7124,15 @@ static unsigned long wakeup_gran(struct sched_entity *se)
  *
  */
 static int
-wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
+wakeup_preempt_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr,
+						struct sched_entity *se)
 {
 	s64 gran, vdiff = curr->vruntime - se->vruntime;
 
 	if (vdiff <= 0)
 		return -1;
 
-	gran = wakeup_gran(se);
+	gran = wakeup_gran(cfs_rq, se);
 	if (vdiff > gran)
 		return 1;
 
@@ -7191,7 +7237,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		return;
 
 	update_curr(cfs_rq_of(se));
-	if (wakeup_preempt_entity(se, pse) == 1) {
+	if (wakeup_preempt_entity(cfs_rq, se, pse) == 1) {
 		/*
 		 * Bias pick_next to pick the sched entity that is
 		 * triggering this preemption.
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7f8dace0964c..d041d7023029 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -95,3 +95,9 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+
+/*
+ * Scale sched_wakeup_granularity dynamically based on the number of running
+ * tasks up to a cap of sysctl_sched_latency.
+ */
+SCHED_FEAT(SCALE_WAKEUP_GRAN, true)
