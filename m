Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E50D4134F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhIUOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 10:05:02 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:54733 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233406AbhIUOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:05:01 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 104C1CB4A0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 15:03:32 +0100 (IST)
Received: (qmail 11935 invoked from network); 21 Sep 2021 14:03:31 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2021 14:03:31 -0000
Date:   Tue, 21 Sep 2021 15:03:30 +0100
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
Message-ID: <20210921140330.GT3959@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net>
 <0cf76bb7701d4a37367773881c7d7c7bfceb455e.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cf76bb7701d4a37367773881c7d7c7bfceb455e.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:32:54PM +0200, Mike Galbraith wrote:
> On Tue, 2021-09-21 at 11:36 +0100, Mel Gorman wrote:
> > On Tue, Sep 21, 2021 at 05:52:32AM +0200, Mike Galbraith wrote:
> > >
> >
> > > Preemption does rapidly run into diminishing return as load climbs for
> > > a lot of loads, but as you know, it's a rather sticky wicket because
> > > even when over-committed, preventing light control threads from slicing
> > > through (what can be a load's own work crew of) hogs can seriously
> > > injure performance.
> > >
> >
> > Turning this into a classic Rob Peter To Pay Paul problem.
> 
> Damn near everything you do in sched-land is rob Peter to pay Paul.
> 

True.

> >  We don't know
> > if there is a light control thread that needs to run or not that affects
> > overall performance. It all depends on whether that control thread needs
> > to make progress for the overall workload or whether there are a mix of
> > workloads resulting in overloading.
> 
> Sure.. and operative words "we don't know" cuts both ways.
> 

Yes and I don't believe we know how often a latency critical thread is
running in a heavily overloaded domain (I hope not very often).

> CFS came about because the O1 scheduler was unfair to the point it had
> starvation problems. People pretty much across the board agreed that a
> fair scheduler was a much way better way to go, and CFS was born.  It
> didn't originally have the sleep credit business, but had to grow it to
> become _short term_ fair.  Ingo cut the sleep credit in half because of
> overscheduling, and that has worked out pretty well all told.. but now
> you're pushing it more in the unfair direction, all the way to
> extremely unfair for anything and everything very light.
> 

With the slight caveat that it's pushed in the other direction at the
point where the domain is becoming overloaded. While fairness is still
important, tasks are being starved to some extent.

> Fairness isn't the holy grail mind you, and at some point, giving up on
> short term fairness certainly isn't crazy, as proven by your hackbench
> numbers and other numbers we've seen over the years, but taking bites
> out of the 'CF' in the CFS that was born to be a corner-case killer
> is.. worrisome.  The other shoe will drop.. it always does :)
> 

Lovely. I don't suppose you know where that shoe is?

> > > <snip>
> > >
> > > > @@ -7044,10 +7045,22 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > > >  }
> > > >  #endif /* CONFIG_SMP */
> > > >  
> > > > -static unsigned long wakeup_gran(struct sched_entity *se)
> > > > +static unsigned long
> > > > +wakeup_gran(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > >  {
> > > >         unsigned long gran = sysctl_sched_wakeup_granularity;
> > > >  
> > > > +       /*
> > > > +        * If rq is specified, scale the granularity relative to the number
> > > > +        * of running tasks but no more than 8ms with default
> > > > +        * sysctl_sched_wakeup_granularity settings. The wakeup gran
> > > > +        * reduces over-scheduling but if tasks are stacked then the
> > > > +        * domain is likely overloaded and over-scheduling may
> > > > +        * prolong the overloaded state.
> > > > +        */
> > > > +       if (cfs_rq && cfs_rq->nr_running > 1)
> > > > +               gran *= min(cfs_rq->nr_running >> 1, sched_nr_latency);
> > > > +
> > >
> > > Maybe things have changed while I wasn't watching closely, but...
> > >
> >
> > Yeah, a lot has changed and unfortunately, I still lack a lot of
> > historical context on why things are the way they are.
> >
> > > The scaled up tweakables on my little quad desktop box:
> > > sched_nr_latency = 8
> > > sched_wakeup_granularity = 4ms
> > > sched_latency = 24ms
> > >
> > > Due to the FAIR_SLEEPERS feature, a task can only receive a max of
> > > sched_latency/2 sleep credit,
> >
> > A task that just became runnable rather than all tasks, right?
> 
> I'm talking about tasks being enqueued during wakeup.
> 

Understood.

> > > ie the delta between waking sleeper and
> > > current is clipped to a max of 12 virtual ms, so the instant our
> > > preempt threshold reaches 12.000ms, by human booboo or now 3 runnable
> > > tasks with this change, wakeup preemption is completely disabled, or?
> > >
> >
> > I'm having trouble reconciling this in some sensible fashion.
> > sched_nr_latency is the threshold where the sched period might be stretched
> > (sysctl_sched_latency/sysctl_sched_min_granularity) which is why I picked
> > it - (nr_running > sched_nr_latency) is a tipping point where the
> > scheduler changes behaviour.
> 
> Yeah, an existing branch is as good a place as any.
> 

Although possibly overkill. Even if the new patch does not help
hackbench to the same extent, it may still be a better tradeoff for
workloads that have critical threads running in an overloaded domain.

> > FAIR_SLEEPERS primarily affects tasks that just became runnable and the
> > new task is trying to fit in without causing too much disruption based
> > on sysctl_sched_latency.
> 
> No, fair sleepers is all about sleeper wakeup preemption, I think
> you're thinking of fork initial placement.
> 

Understood.

> > As sysctl_sched_wakeup_granularity is now debugfs and should not be
> > tuned, we want to avoid that. On the other hand, we also know from the
> > results that overloaded tasks may fail to make sufficient progress so,
> > do we either try to dynamically adjust or do we just ignore the problem?
> 
> Good question.  Anything you do is guaranteed to be wrong for
> something, which is why CFS was born.. fair doesn't have corner cases.
> 

And indeed, this is basically trading some fairness to allow some tasks to
complete faster so that load goes down. It's similar to the race-to-idle
problem in frequency management where it asked "Is it better to use more
power to finish quickly or converve power and take longer?". This patch
is asking the question "When overloaded, is it better to let a task run
longer so it finishes quicker or pay the cost of context switching?"

> > If we are to dynamically adjust then what should it be? One alternative
> > could be to base the tipping point on the ratio of sysctl_sched_latency to
> > gran, take FAIR_SLEEPERS into account, sanity check the result and stick it
> > behind a feature flag in case it needs to be disabled to debug a preempt
> > starvation problem.
> >
> > This on top?
> 
> Dunno.  Seeing as how it wasn't as aggressive as I thought at first
> glance, maybe that original rolldown will be more or less fine.  I
> don't like it much, but numbers talk, BS walks.  I trust boxen on such
> matters way more than any human, myself included ;-)
> 

I've queued v2 on the test grid, lets see what falls out.

Thanks Mike for the review and the historical context.

-- 
Mel Gorman
SUSE Labs
