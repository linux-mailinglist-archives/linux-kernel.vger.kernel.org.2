Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0857A4351F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 19:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJTRvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 13:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230340AbhJTRvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 13:51:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46D436128B;
        Wed, 20 Oct 2021 17:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634752173;
        bh=dWryytcKcquSUHoso2WGDQASvn9GulP3BjDgcWZrpso=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HGzGx/NixfOt14iGdmf9D/TVv5VWgCyLTSJpDJa0X7M8SXHAprDOvVeUlAVmsc7DB
         Qkmm+O8DJEiUoSx5hz7mEtXVKzHedjFumuJPB0K/qVuPeKSOeHVFTYUYgaeh/trbSl
         ERjHe3F6+PL5EgaeWEAyutMLjX6ClFTRMhwiuDox1lzQ7ojHoPZkOgeODuA2sLCmQQ
         7LGNbMD8EpUrIW0FYtx61SY60aEG/Wm+pfM2C7VJoYsLHYfO33Hc8WEp1WpRmUpeGc
         MSAiwgcJotRX3qT4olCrlZCzt3NTVjbmnfERNz6cOi9axtDWNzufN1bMBEr09dUg5l
         h30UOkg6LJS7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 131FE5C094B; Wed, 20 Oct 2021 10:49:33 -0700 (PDT)
Date:   Wed, 20 Oct 2021 10:49:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Luming Yu <luming.yu@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        yanghui <yanghui.def@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
Message-ID: <20211020174933.GJ880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com>
 <CALAqxLVgQ6QEThWaN65nOW9F_XCh7885n9RigAQDU+OgDntS5g@mail.gmail.com>
 <6b715fb7-9850-04f3-4ab8-1a2a8a2cdfbf@gmail.com>
 <CALAqxLWgw8tA1Lrg27JUUFrGWCQqPQXmhjHyjsTRA5a4qingkg@mail.gmail.com>
 <95c1a031-6751-f90f-d003-b74fbec0e9d8@gmail.com>
 <CALAqxLVcc9nscuWT-qFH=JbatVL0c5AxH5B9y3qE1ekG=BZ0aA@mail.gmail.com>
 <61381153-634e-489b-848f-7077ce46049a@bytedance.com>
 <CALAqxLUJeF1NFAzvp2ubRizbJV-ws09P6x=5nzSz7_VmMAQLNA@mail.gmail.com>
 <CAJRGBZz6dF=AADKMFwUodm2WeDyTvBw0XxnQdeJwPLs2=sLLEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJRGBZz6dF=AADKMFwUodm2WeDyTvBw0XxnQdeJwPLs2=sLLEw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 06:09:58AM -0400, Luming Yu wrote:
> On Tue, Oct 19, 2021 at 1:04 AM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Mon, Oct 18, 2021 at 9:14 PM yanghui <yanghui.def@bytedance.com> wrote:
> > > 在 2021/10/19 上午12:14, John Stultz 写道:
> > > > On Tue, Oct 12, 2021 at 1:06 AM brookxu <brookxu.cn@gmail.com> wrote:
> > > >> John Stultz wrote on 2021/10/12 13:29:
> > > >>> On Mon, Oct 11, 2021 at 10:23 PM brookxu <brookxu.cn@gmail.com> wrote:
> > > >>>> John Stultz wrote on 2021/10/12 12:52 下午:
> > > >>>>> On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gmail.com> wrote:
> > > >>>> If we record the watchdog's start_time in clocksource_start_watchdog(), and then
> > > >>>> when we verify cycles in clocksource_watchdog(), check whether the clocksource
> > > >>>> watchdog is blocked. Due to MSB verification, if the blocked time is greater than
> > > >>>> half of the watchdog timer max_cycles, then we can safely ignore the current
> > > >>>> verification? Do you think this idea is okay?
> > > >>>
> > > >>> I can't say I totally understand the idea. Maybe could you clarify with a patch?
> > > >>>
> > > >>
> > > >> Sorry, it looks almost as follows:
> > > >>
> > > >> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > > >> index b8a14d2..87f3b67 100644
> > > >> --- a/kernel/time/clocksource.c
> > > >> +++ b/kernel/time/clocksource.c
> > > >> @@ -119,6 +119,7 @@
> > > >>   static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
> > > >>   static DEFINE_SPINLOCK(watchdog_lock);
> > > >>   static int watchdog_running;
> > > >> +static unsigned long watchdog_start_time;
> > > >>   static atomic_t watchdog_reset_pending;
> > > >>
> > > >>   static inline void clocksource_watchdog_lock(unsigned long *flags)
> > > >> @@ -356,6 +357,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > >>          int next_cpu, reset_pending;
> > > >>          int64_t wd_nsec, cs_nsec;
> > > >>          struct clocksource *cs;
> > > >> +       unsigned long max_jiffies;
> > > >>          u32 md;
> > > >>
> > > >>          spin_lock(&watchdog_lock);
> > > >> @@ -402,6 +404,10 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > >>                  if (atomic_read(&watchdog_reset_pending))
> > > >>                          continue;
> > > >>
> > > >> +               max_jiffies = nsecs_to_jiffies(cs->max_idle_ns);
> > > >> +               if (time_is_before_jiffies(watchdog_start_time + max_jiffies))
> > > >> +                       continue;
> > > >> +
> > > >
> > > > Sorry, what is the benefit of using jiffies here?   Jiffies are
> > > > updated by counting the number of tick intervals on the current
> > > > clocksource.
> > > >
> > > > This seems like circular logic, where we're trying to judge the
> > > > current clocksource by using something we derived from the current
> > > > clocksource.
> > > > That's why the watchdog clocksource is important, as it's supposed to
> > > > be a separate counter that is more reliable (but likely slower) then
> > > > the preferred clocksource.
> > > >
> > > > So I'm not really sure how this helps.
> > > >
> > > > The earlier patch by yanghui at least used the watchdog interval to
> > > > decide if the watchdog timer had expired late. Which seemed
> > > > reasonable, but I thought it might be helpful to add some sort of a
> > > > counter so if the case is happening repeatedly (timers constantly
> > > > being delayed) we have a better signal that the watchdog and current
> > > > clocksource are out of sync.  Because again, timers are fired based on
> > >
> > > I think only have a signal ls not enough. we need to prevent
> > > clocksource from being incorrectly switched.
> >
> > Right, but we also have to ensure that we also properly disqualify
> > clocksources that are misbehaving.
> >
> > In the case that the current clocksource is running very slow (imagine
> > old TSCs that lowered freq with cpufreq), then system time slows down,
> > so timers fire late.
> > So it would constantly seem like the irqs are being delayed, so with
> > your logic we would not disqualify a clearly malfunctioning
> > clocksource..
> >
> > > The Timer callback function clocksource_watchdog() is executed in the
> > > context of softirq(run_timer_softirq()). So if softirq is disabled for
> > > long time(One situation is long time softlockup), clocksource_watchdog()
> > > will be delay executed.
> >
> > Yes. The reality is that timers are often spuriously delayed. We don't
> > want a short burst of timer misbehavior to disqualify a good
> > clocksource.
> >
> > But the problem is that this situation and the one above (with the
> > freq changing TSC), will look exactly the same.
> >
> > So having a situation where if the watchdog clocksource thinks too
> > much time has passed between watchdog timers, we can skip judgement,
> > assuming its a spurious delay. But I think we need to keep a counter
> > so that if this happens 3-5 times in a row, we stop ignoring the
> > misbehavior and judge the current clocksource, as it may be running
> > slowly.
> >
> > > >
> > > I think it will be better to add this to my patch:
> > >   /*
> > >    * Interval: 0.5sec.
> > > - * MaxInterval: 1s.
> > > + * MaxInterval: 20s.
> > >    */
> > >   #define WATCHDOG_INTERVAL (HZ >> 1)
> > > -#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
> > > +#define WATCHDOG_MAX_INTERVAL_NS (20 * NSEC_PER_SEC)
> > >
> >
> > Some watchdog counters wrap within 20 seconds, so I don't think this
> > is a good idea.
> >
> > The other proposal to calculate the error rate, rather than a fixed
> > error boundary might be useful too, as if the current clocksource and
> > watchdog are close, a long timer delay won't disqualify them if we
> > scale the error bounds to be within an given error rate.
> 
> In most of tsc unstable trouble shooting on modern servers we experienced,
> it usually ends up in a false alarm triggered by the  clock source
> watchdog for tsc.
> 
> I think Paul has a proposal to make a clock source watchdog to be more
> intelligent.
> Its job is to find a real problem instead of causing a problem.

And that proposal is now in mainline:

22a223833716 clocksource: Print deviation in nanoseconds when a clocksource becomes unstable
1253b9b87e42 clocksource: Provide kernel module to test clocksource watchdog
2e27e793e280 clocksource: Reduce clocksource-skew threshold
fa218f1cce6b clocksource: Limit number of CPUs checked for clock synchronization
7560c02bdffb clocksource: Check per-CPU clock synchronization when marked unstable
db3a34e17433 clocksource: Retry clock read if long delays detected

The strategy is to disqualify a clock comparison if the reads took too
long, and to retry the comparison.  If four consecutive comparison take
too long, clock skew is reported.  The number of consecutive comparisons
may be adjusted by the usual kernel boot parameter.

> so disabling it for known good-tsc might be a reasonable good idea
> that can save manpower for other
> more valuable problems to solve, or at least make it statistically a
> problem less chance to happen.

One additional piece that is still in prototype state in -rcu is to give
clocksources some opportunity to resynchronize if there are too many
slow comparisons.  This is intended to handle cases where clocks often
take hundreds of microseconds to read out due to cache-buster workloads
interfering with all and sundry.  Testing indicates that even in the
midst of such cache-busting, there will almost certainly be at least one
fast comparison within a five-second period.  So the current thought is
to give a clocksource 100 seconds in which to get a fast comparison.

Those who have only one clock always know what time it is.  Those with
more than one can never be certain.  Except that the universe is
well-supplied with a great many clocks outside of the computer system
in question.  ;-)

							Thanx, Paul
