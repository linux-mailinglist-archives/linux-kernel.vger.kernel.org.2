Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D43421F8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 09:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhJEHnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 03:43:14 -0400
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:52362 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232108AbhJEHnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 03:43:12 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id D197DBA9D9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 08:41:21 +0100 (IST)
Received: (qmail 6350 invoked from network); 5 Oct 2021 07:41:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Oct 2021 07:41:21 -0000
Date:   Tue, 5 Oct 2021 08:41:20 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <20211005074120.GO3959@techsingularity.net>
References: <20210922173853.GB3959@techsingularity.net>
 <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
 <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
 <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
 <50400427070018eff83b0782d2e26c0cc9ff4521.camel@gmx.de>
 <CAKfTPtDHYtskM7wR0w=fDry+6JJae2_q8Lw7ETcW_gBJ+n4NBA@mail.gmail.com>
 <20210927111730.GG3959@techsingularity.net>
 <ae821481769c4cd82a1672f0aac427c52e0a1647.camel@gmx.de>
 <20211004080547.GK3959@techsingularity.net>
 <CAKfTPtD5=VQfSdL6YqdET99XFbPxT359oH0UZ78O=wWn6G8mAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtD5=VQfSdL6YqdET99XFbPxT359oH0UZ78O=wWn6G8mAg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 06:37:02PM +0200, Vincent Guittot wrote:
> On Mon, 4 Oct 2021 at 10:05, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Mon, Sep 27, 2021 at 04:17:25PM +0200, Mike Galbraith wrote:
> > > On Mon, 2021-09-27 at 12:17 +0100, Mel Gorman wrote:
> > > > On Thu, Sep 23, 2021 at 02:41:06PM +0200, Vincent Guittot wrote:
> > > > > On Thu, 23 Sept 2021 at 11:22, Mike Galbraith <efault@gmx.de> wrote:
> > > > > >
> > > > > > On Thu, 2021-09-23 at 10:40 +0200, Vincent Guittot wrote:
> > > > > > >
> > > > > > > a 100us value should even be enough to fix Mel's problem without
> > > > > > > impacting common wakeup preemption cases.
> > > > > >
> > > > > > It'd be nice if it turn out to be something that simple, but color me
> > > > > > skeptical.  I've tried various preemption throttling schemes, and while
> > > > >
> > > > > Let's see what the results will show. I tend to agree that this will
> > > > > not be enough to cover all use cases and I don't see any other way to
> > > > > cover all cases than getting some inputs from the threads about their
> > > > > latency fairness which bring us back to some kind of latency niceness
> > > > > value
> > > > >
> > > >
> > > > Unfortunately, I didn't get a complete set of results but enough to work
> > > > with. The missing tests have been requeued. The figures below are based
> > > > on a single-socket Skylake machine with 8 CPUs as it had the most set of
> > > > results and is the basic case.
> > >
> > > There's something missing, namely how does whatever load you measure
> > > perform when facing dissimilar competition. Instead of only scaling
> > > loads running solo from underutilized to heavily over-committed, give
> > > them competition. eg something switch heavy, say tbench, TCP_RR et al
> > > (latency bound load) pairs=CPUS vs something hefty like make -j CPUS or
> > > such.
> > >
> >
> > Ok, that's an interesting test. I've been out intermittently and will be
> > for the next few weeks but I managed to automate something that can test
> > this. The test runs a kernel compile with -jNR_CPUS and TCP_RR running
> > NR_CPUS pairs of clients/servers in the background with the default
> > openSUSE Leap kernel config (CONFIG_PREEMPT_NONE) with the two patches
> > and no tricks done with task priorities.  5 kernel compilations are run
> > and TCP_RR is shutdown when the compilation finishes.
> >
> > This can be reproduced with the mmtests config
> > config-multi-kernbench__netperf-tcp-rr-multipair using xfs as the
> > filesystem for the kernel compilation.
> >
> > sched-scalewakegran-v2r5: my patch
> > sched-moveforward-v1r1: Vincent's patch
> 
> If I'm not wrong, you refer to the 1st version which scales with the
> number of cpu by sched-moveforward-v1r1. We don't want to scale with
> the number of cpu because this can create some quite large non
> preemptable duration. We want to ensure a fix small runtime like the
> last version with 100us
> 

It was a modified version based on feedback that limited the scale that
preemption would be disabled. It was still based on h_nr_running as a
basis for comparison

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f245b939..964f76a95c04 100644
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
+		if (cfs_rq->h_nr_running <= sched_nr_disable_gran)
+			return sysctl_sched_wakeup_granularity;
+
+		return sysctl_sched_latency;
+	}
+
+	/* GENTLE_FAIR_SLEEPER has two overloaded thresholds. */
+	nr_running = cfs_rq->h_nr_running;
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
 
@@ -7190,8 +7236,9 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 	if (cse_is_idle != pse_is_idle)
 		return;
 
-	update_curr(cfs_rq_of(se));
-	if (wakeup_preempt_entity(se, pse) == 1) {
+	cfs_rq = cfs_rq_of(se);
+	update_curr(cfs_rq);
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
