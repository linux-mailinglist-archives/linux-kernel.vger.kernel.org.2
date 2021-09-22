Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51636414F4A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhIVRk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:40:28 -0400
Received: from outbound-smtp32.blacknight.com ([81.17.249.64]:46900 "EHLO
        outbound-smtp32.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236886AbhIVRk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:40:26 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp32.blacknight.com (Postfix) with ESMTPS id 001EDBEDAA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 18:38:54 +0100 (IST)
Received: (qmail 21999 invoked from network); 22 Sep 2021 17:38:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Sep 2021 17:38:54 -0000
Date:   Wed, 22 Sep 2021 18:38:53 +0100
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
Message-ID: <20210922173853.GB3959@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net>
 <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net>
 <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net>
 <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 06:00:56PM +0200, Vincent Guittot wrote:
> On Wed, 22 Sept 2021 at 17:04, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Wed, Sep 22, 2021 at 04:15:27PM +0200, Vincent Guittot wrote:
> > > > ---8<---
> > > > sched/fair: Scale wakeup granularity relative to nr_running
> > > >
> > > > Commit 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs") moved
> > > > the kernel.sched_wakeup_granularity_ns sysctl under debugfs.  One of the
> > > > reasons why this sysctl may be used may be for "optimising for throughput",
> > > > particularly when overloaded. The tool TuneD sometimes alters this for two
> > > > profiles e.g. "mssql" and "throughput-performance". At least version 2.9
> > > > does but it changed in master where it also will poke at debugfs instead.
> > > >
> > > > Internal parameters like sysctl_sched_wakeup_granularity are scaled
> > > > based on the number of CPUs due to sysctl_sched_tunable_scaling. For
> > > > simplicity, the timing figures in this changelog are based on
> > > > SCHED_TUNABLESCALING_NONE.
> > >
> > > This is a bit misleading because the platform that you used to
> > > highlight the problem has a 7ms sysctl_sched_wakeup_granularity. which
> > > is far more than your tick which should be 1ms
> > >
> >
> > Tick on the test machines is 4ms (HZ=250).
> >
> > The reason I used SCHED_TUNABLESCALING_NONE for the changelog is that
> > the exact values depend on the number of CPUs so values are not even
> > the same across the range of machines I'm using. sysctl_sched_latency,
> > sysctl_sched_min_granularity sysctl_sched_wakeup_granularity are all
> > scaled but the ratios remain constant.
> 
> My point was mainly that sysctl_sched_wakeup_granularity is above the
> tick period
> 

Ok. sysctl_sched_wakeup_granularity is not related to the tick but I'm
probably missing something else.

> > > Also do you want to take into account only tasks in this cfs and its
> > > children or on all cfs on this rq ?
> > >
> >
> > Only this cfq I think to limit overhead.
> >
> > > > +                       return sysctl_sched_wakeup_granularity;
> > > > +
> > > > +               return sysctl_sched_latency;
> > > > +       }
> > > > +
> > > > +       /* GENTLE_FAIR_SLEEPER has two overloaded thresholds. */
> > > > +       nr_running = cfs_rq->nr_running;
> > > > +       threshold = sched_nr_disable_gran >> 1;
> > > > +
> > > > +       /* No overload. */
> > > > +       if (nr_running <= threshold)
> 
> The comment was originally for this
> nr_running does not reflect the number of task running on the cpu and
> the associated overload state
> 
> If you put 2 hackbench in their own cgroup, nr_running will be 2 but
> you will have twice more runnable threads
> 

Ok, that's understood. FWIW, I had switched to h_nr_running already.

> > > > +
> > > > +       /* Light overload. */
> > > > +       if (nr_running <= sched_nr_disable_gran)
> > > > +               return sysctl_sched_latency >> 1;
> > > > +
> > > > +       /* Heavy overload. */
> > > > +       return sysctl_sched_latency;
> > >
> > > Why should a thread without any relationship with the curr,  not
> > > preempt it because there are already a lot of running threads?
> >
> > Preemption is not free, without any knowledge of what the thread is
> > doing, we cannot determine if an inappropriate amount of CPU time is
> > being spent dequeueing/enqueuing tasks.
> 
> That's exactly my point. The heuristic above doesn't give any clue if
> the thread should or not preempt the current one. Most of the time
> there is no relation with the number of the running threads but it is
> define by the workload itself and its level of interactivity
> 

Right albeit it ignores the possibility that there are multiple workloads
overloading the machine wasting even more time preempting.  Whether that
is due to a bad application, a bad configuration or a bad actor is anyones
guess. I've seen applications with multiple worker threads which generally
behaved ok, except when they didn't and too many worker threads were
spawned due to a spike in server load. I'm not 

> >
> > > In
> > > your case, you want hackbench threads to not preempt each others
> > > because they tries to use same resources so it's probably better to
> > > let the current one to move forward but that's not a universal policy.
> > >
> >
> > No, but have you a better suggestion? hackbench might be stupid but it's
> > an example of where a workload can excessively preempt itself. While
> > overloading an entire machine is stupid, it could also potentially occurs
> > for applications running within a constrained cpumask.
> 
> But this is property that is specific to each application. Some can
> have a lot of running threads but few wakes up which have to preempt
> current threads quickly but others just want the opposite
> So because it is a application specific property we should define it
> this way instead of trying to guess

I'm not seeing an alternative suggestion that could be turned into
an implementation. The current value for sched_wakeup_granularity
was set 12 years ago was exposed for tuning which is no longer
the case. The intent was to allow some dynamic adjustment between
sysctl_sched_wakeup_granularity and sysctl_sched_latency to reduce
over-scheduling in the worst case without disabling preemption entirely
(which the first version did).

Should we just ignore this problem and hope it goes away or just let
people keep poking silly values into debugfs via tuned?

-- 
Mel Gorman
SUSE Labs
