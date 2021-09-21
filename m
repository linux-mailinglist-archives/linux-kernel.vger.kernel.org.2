Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFF24131BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhIUKhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:37:53 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:44161 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231189AbhIUKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:37:52 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 239FD1C5F84
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:36:23 +0100 (IST)
Received: (qmail 21369 invoked from network); 21 Sep 2021 10:36:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2021 10:36:22 -0000
Date:   Tue, 21 Sep 2021 11:36:21 +0100
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
Message-ID: <20210921103621.GM3959@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:52:32AM +0200, Mike Galbraith wrote:
> On Mon, 2021-09-20 at 15:26 +0100, Mel Gorman wrote:
> >
> > This patch scales the wakeup granularity based on the number of running
> > tasks on the CPU up to a max of 8ms by default.  The intent is to
> > allow tasks to run for longer while overloaded so that some tasks may
> > complete faster and reduce the degree a domain is overloaded. Note that
> > the TuneD throughput-performance profile allows up to 15ms but there
> > is no explanation why such a long period was necessary so this patch is
> > conservative and uses the value that check_preempt_wakeup() also takes
> > into account.  An internet search for instances where this parameter are
> > tuned to high values offer either no explanation or a broken one.
> >
> > This improved hackbench on a range of machines when communicating via
> > pipes (sockets show little to no difference). For a 2-socket CascadeLake
> > machine, the results were
> 
> Twiddling wakeup preemption based upon the performance of a fugly fork
> bomb seems like a pretty bad idea to me.
> 

I'm no fan of hackbench but unfortunately it's heavily used for
evaluating scheduler changes at least and the notion that
over-scheduling can reduce throughput of communicating tasks in the
overloaded case is still problematic.

> Preemption does rapidly run into diminishing return as load climbs for
> a lot of loads, but as you know, it's a rather sticky wicket because
> even when over-committed, preventing light control threads from slicing
> through (what can be a load's own work crew of) hogs can seriously
> injure performance.
> 

Turning this into a classic Rob Peter To Pay Paul problem. We don't know
if there is a light control thread that needs to run or not that affects
overall performance. It all depends on whether that control thread needs
to make progress for the overall workload or whether there are a mix of
workloads resulting in overloading.

> <snip>
> 
> > @@ -7044,10 +7045,22 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  }
> >  #endif /* CONFIG_SMP */
> >  
> > -static unsigned long wakeup_gran(struct sched_entity *se)
> > +static unsigned long
> > +wakeup_gran(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >  {
> >         unsigned long gran = sysctl_sched_wakeup_granularity;
> >  
> > +       /*
> > +        * If rq is specified, scale the granularity relative to the number
> > +        * of running tasks but no more than 8ms with default
> > +        * sysctl_sched_wakeup_granularity settings. The wakeup gran
> > +        * reduces over-scheduling but if tasks are stacked then the
> > +        * domain is likely overloaded and over-scheduling may
> > +        * prolong the overloaded state.
> > +        */
> > +       if (cfs_rq && cfs_rq->nr_running > 1)
> > +               gran *= min(cfs_rq->nr_running >> 1, sched_nr_latency);
> > +
> 
> Maybe things have changed while I wasn't watching closely, but...
> 

Yeah, a lot has changed and unfortunately, I still lack a lot of
historical context on why things are the way they are. 

> The scaled up tweakables on my little quad desktop box:
> sched_nr_latency = 8
> sched_wakeup_granularity = 4ms
> sched_latency = 24ms
> 
> Due to the FAIR_SLEEPERS feature, a task can only receive a max of
> sched_latency/2 sleep credit,

A task that just became runnable rather than all tasks, right?

> ie the delta between waking sleeper and
> current is clipped to a max of 12 virtual ms, so the instant our
> preempt threshold reaches 12.000ms, by human booboo or now 3 runnable
> tasks with this change, wakeup preemption is completely disabled, or?
> 

I'm having trouble reconciling this in some sensible fashion.
sched_nr_latency is the threshold where the sched period might be stretched
(sysctl_sched_latency/sysctl_sched_min_granularity) which is why I picked
it - (nr_running > sched_nr_latency) is a tipping point where the
scheduler changes behaviour.

FAIR_SLEEPERS primarily affects tasks that just became runnable and the
new task is trying to fit in without causing too much disruption based
on sysctl_sched_latency.

As sysctl_sched_wakeup_granularity is now debugfs and should not be
tuned, we want to avoid that. On the other hand, we also know from the
results that overloaded tasks may fail to make sufficient progress so,
do we either try to dynamically adjust or do we just ignore the problem?

If we are to dynamically adjust then what should it be? One alternative
could be to base the tipping point on the ratio of sysctl_sched_latency to
gran, take FAIR_SLEEPERS into account, sanity check the result and stick it
behind a feature flag in case it needs to be disabled to debug a preempt
starvation problem.

This on top?

---8<---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8e12aeebf4ce..4c94af6ecb1d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7052,14 +7052,21 @@ wakeup_gran(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 	/*
 	 * If rq is specified, scale the granularity relative to the number
-	 * of running tasks but no more than 8ms with default
-	 * sysctl_sched_wakeup_granularity settings. The wakeup gran
-	 * reduces over-scheduling but if tasks are stacked then the
-	 * domain is likely overloaded and over-scheduling may
-	 * prolong the overloaded state.
-	 */
-	if (cfs_rq && cfs_rq->nr_running > 1)
-		gran *= min(cfs_rq->nr_running >> 1, sched_nr_latency);
+	 * of running tasks but no more than sysctl_sched_latency.
+	 * The wakeup gran reduces over-scheduling but if tasks are
+	 * stacked then the domain is likely overloaded and over-scheduling
+	 * may prolong the overloaded state.
+	 */
+	if (sched_feat(SCALE_WAKEUP_GRAN) &&
+	    cfs_rq && cfs_rq->nr_running > 1) {
+		int max_scale = sysctl_sched_latency / gran;
+
+		if (sched_feat(GENTLE_FAIR_SLEEPERS))
+			max_scale >>= 1;
+
+		if (max_scale)
+			gran *= min(cfs_rq->nr_running >> 1, max_scale);
+	}
 
 	/*
 	 * Since its curr running now, convert the gran from real-time
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
