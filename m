Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C866414CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbhIVPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:06:31 -0400
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:35663 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236304AbhIVPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:06:30 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id 2B878FAC22
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:04:59 +0100 (IST)
Received: (qmail 8728 invoked from network); 22 Sep 2021 15:04:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Sep 2021 15:04:59 -0000
Date:   Wed, 22 Sep 2021 16:04:57 +0100
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
Message-ID: <20210922150457.GA3959@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net>
 <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net>
 <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 04:15:27PM +0200, Vincent Guittot wrote:
> > ---8<---
> > sched/fair: Scale wakeup granularity relative to nr_running
> >
> > Commit 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs") moved
> > the kernel.sched_wakeup_granularity_ns sysctl under debugfs.  One of the
> > reasons why this sysctl may be used may be for "optimising for throughput",
> > particularly when overloaded. The tool TuneD sometimes alters this for two
> > profiles e.g. "mssql" and "throughput-performance". At least version 2.9
> > does but it changed in master where it also will poke at debugfs instead.
> >
> > Internal parameters like sysctl_sched_wakeup_granularity are scaled
> > based on the number of CPUs due to sysctl_sched_tunable_scaling. For
> > simplicity, the timing figures in this changelog are based on
> > SCHED_TUNABLESCALING_NONE.
> 
> This is a bit misleading because the platform that you used to
> highlight the problem has a 7ms sysctl_sched_wakeup_granularity. which
> is far more than your tick which should be 1ms
> 

Tick on the test machines is 4ms (HZ=250).

The reason I used SCHED_TUNABLESCALING_NONE for the changelog is that
the exact values depend on the number of CPUs so values are not even
the same across the range of machines I'm using. sysctl_sched_latency,
sysctl_sched_min_granularity sysctl_sched_wakeup_granularity are all
scaled but the ratios remain constant.

> > <SNIP>
> >  static int
> > -wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
> > +wakeup_preempt_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr,
> > +                                               struct sched_entity *se);
> >
> >  /*
> >   * Pick the next process, keeping these things in mind, in this order:
> > @@ -4550,16 +4562,16 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >                                 second = curr;
> >                 }
> >
> > -               if (second && wakeup_preempt_entity(second, left) < 1)
> > +               if (second && wakeup_preempt_entity(NULL, second, left) < 1)
> 
> Why not applying the same policy here ? the tick can also prevent
> current task to move forward
> 

Because it was less clear if it was necessary and what the consequences
would be if the skip buddy ran or the next buddy failed to run because
preempt failed, how does it interact with yield_to etc.

I ended up concluding that they should be separate patches and keep this
patch to one topic.


> >                         se = second;
> >         }
> >
> > -       if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
> > +       if (cfs_rq->next && wakeup_preempt_entity(NULL, cfs_rq->next, left) < 1) {
> >                 /*
> >                  * Someone really wants this to run. If it's not unfair, run it.
> >                  */
> >                 se = cfs_rq->next;
> > -       } else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
> > +       } else if (cfs_rq->last && wakeup_preempt_entity(NULL, cfs_rq->last, left) < 1) {
> >                 /*
> >                  * Prefer last buddy, try to return the CPU to a preempted task.
> >                  */
> > @@ -7044,9 +7056,42 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  }
> >  #endif /* CONFIG_SMP */
> >
> > -static unsigned long wakeup_gran(struct sched_entity *se)
> > +static unsigned long
> > +select_wakeup_gran(struct cfs_rq *cfs_rq)
> > +{
> > +       unsigned int nr_running, threshold;
> > +
> > +       if (!cfs_rq || !sched_feat(SCALE_WAKEUP_GRAN))
> > +               return sysctl_sched_wakeup_granularity;
> > +
> > +       /* !GENTLE_FAIR_SLEEPERS has one overload threshold. */
> > +       if (!sched_feat(GENTLE_FAIR_SLEEPERS)) {
> > +               if (cfs_rq->nr_running <= sched_nr_disable_gran)
> 
> cfs_rq->nr_running reflects the number of sched entities in the cfs
> but not the number of running tasks which reflected in h_nr_running
> 

Then check_preempt_wakeup may also have the same problem as it uses
nr_running.

> Also do you want to take into account only tasks in this cfs and its
> children or on all cfs on this rq ?
> 

Only this cfq I think to limit overhead.

> > +                       return sysctl_sched_wakeup_granularity;
> > +
> > +               return sysctl_sched_latency;
> > +       }
> > +
> > +       /* GENTLE_FAIR_SLEEPER has two overloaded thresholds. */
> > +       nr_running = cfs_rq->nr_running;
> > +       threshold = sched_nr_disable_gran >> 1;
> > +
> > +       /* No overload. */
> > +       if (nr_running <= threshold)
> > +               return sysctl_sched_wakeup_granularity;
> 
> TBH I don't like these "no overload", "light overload" ...  They don't
> have any real meaning apart from that it might work for your platform
> and your hackbench test.

They are, at best, a proxy measure for overload but the alternative is
scanning a bunch of runqueues similar to what is required when detecting
if a domain is fully busy or overloaded.

> We already had have people complaining that small cfs task does not
> preempt fast enough curr task as an example
> 

Is there a specific test case that demonstrates this?

> There is no explanation why these values are the correct ones and not
> but are just some random heuristic results and we are trying to remove
> platform heuristic and to not add new
> 

They are a heuristic yes, but I'm trying to remove the motivation for
users trying to tune sysctl_sched_wakeup_granularity to stupid values
because as it stands, tuned will happily poke into debugfs despite the
fact they are meant for debugging only and the values are of dubious merit.

> > +
> > +       /* Light overload. */
> > +       if (nr_running <= sched_nr_disable_gran)
> > +               return sysctl_sched_latency >> 1;
> > +
> > +       /* Heavy overload. */
> > +       return sysctl_sched_latency;
> 
> Why should a thread without any relationship with the curr,  not
> preempt it because there are already a lot of running threads?

Preemption is not free, without any knowledge of what the thread is
doing, we cannot determine if an inappropriate amount of CPU time is
being spent dequeueing/enqueuing tasks.

> In
> your case, you want hackbench threads to not preempt each others
> because they tries to use same resources so it's probably better to
> let the current one to move forward but that's not a universal policy.
> 

No, but have you a better suggestion? hackbench might be stupid but it's
an example of where a workload can excessively preempt itself. While
overloading an entire machine is stupid, it could also potentially occurs
for applications running within a constrained cpumask.

> side question: Have you try to change the nice priority which also
> impact whether a thread can preempt curr ?
> 

No, I have not tried. I guess one would be constructed with cyclictest
-S running hackbench in the background and measuring if it makes a
difference to the amount of jitter cyclictest experiences but I'm not
sure if that would cover the case you are concerned with.

> > +}
> > +
> > +static unsigned long
> > +wakeup_gran(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >  {
> > -       unsigned long gran = sysctl_sched_wakeup_granularity;
> > +       unsigned long gran = select_wakeup_gran(cfs_rq);
> >
> >         /*
> >          * Since its curr running now, convert the gran from real-time
> > @@ -7079,14 +7124,15 @@ static unsigned long wakeup_gran(struct sched_entity *se)
> >   *
> >   */
> >  static int
> > -wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
> > +wakeup_preempt_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr,
> > +                                               struct sched_entity *se)
> >  {
> >         s64 gran, vdiff = curr->vruntime - se->vruntime;
> >
> >         if (vdiff <= 0)
> >                 return -1;
> >
> > -       gran = wakeup_gran(se);
> > +       gran = wakeup_gran(cfs_rq, se);
> >         if (vdiff > gran)
> >                 return 1;
> >
> > @@ -7191,7 +7237,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> >                 return;
> >
> >         update_curr(cfs_rq_of(se));
> > -       if (wakeup_preempt_entity(se, pse) == 1) {
> > +       if (wakeup_preempt_entity(cfs_rq, se, pse) == 1) {
> 
> like for update_curr above, cfs_rq can be wrong because se could have changed
> 

Crap, that was a stupid mistake based on earlier review. I'll fix it.

-- 
Mel Gorman
SUSE Labs
