Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7E84444FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhKCP4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:56:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhKCP4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:56:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DC5A60E98;
        Wed,  3 Nov 2021 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635954848;
        bh=PKeNPWp1sj3+Vb3lAULD3hB9QWmiaJO9RaNXZ+LYQcI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CYTkTHLk590IP5p85oMyF3icTt21kQi+rC3gtWVF40/DNcjZOJMqmR6uadgZpDdVx
         icMvHHW85KDzkj1eQtVjOrm6cH/tLhc1KXPU5lxYPFJIL1Lb807BLwsYZQR0Pl7550
         FLmVciZah1GSUquWBniOthnw0q4lpJaORSq3kV+ATH3mSkG1qxpAadE5VNHeeNYsuU
         RE1X/k1cUXs1+NZKxtbCKM+DsXTfp+0M/pB9hruRmPZiU4XqqpKev8Nzd1W05imdli
         cxQ7zbkFIXi9UqiNwp0TnVQIiI2mHQ/b4dMeAri3oa6TgEpcKuH7P8jy3DRRn35AWX
         8o0Ko8x+GwMIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3012D5C0848; Wed,  3 Nov 2021 08:54:08 -0700 (PDT)
Date:   Wed, 3 Nov 2021 08:54:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Luming Yu <luming.yu@gmail.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        yanghui <yanghui.def@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
Message-ID: <20211103155408.GA608663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CALAqxLVcc9nscuWT-qFH=JbatVL0c5AxH5B9y3qE1ekG=BZ0aA@mail.gmail.com>
 <61381153-634e-489b-848f-7077ce46049a@bytedance.com>
 <CALAqxLUJeF1NFAzvp2ubRizbJV-ws09P6x=5nzSz7_VmMAQLNA@mail.gmail.com>
 <CAJRGBZz6dF=AADKMFwUodm2WeDyTvBw0XxnQdeJwPLs2=sLLEw@mail.gmail.com>
 <20211020174933.GJ880162@paulmck-ThinkPad-P17-Gen-1>
 <CAJRGBZxQdFsXZtHwiqT4YrjUnN4P3xK_vy_uuso2WErqtHRX7w@mail.gmail.com>
 <20211022233655.GH880162@paulmck-ThinkPad-P17-Gen-1>
 <CAJRGBZxL4ofhdhMTAaravWyCLsg8Pghtd+J9LGwBwzF2f6MKng@mail.gmail.com>
 <20211101165702.GD880162@paulmck-ThinkPad-P17-Gen-1>
 <CAJRGBZzC2+rnPFVN-9rRB2hL2NFN27eknquKwjnbTS3b0DLWsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJRGBZzC2+rnPFVN-9rRB2hL2NFN27eknquKwjnbTS3b0DLWsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 04:27:42AM -0400, Luming Yu wrote:
> On Mon, Nov 1, 2021 at 12:57 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Nov 01, 2021 at 05:59:52AM -0400, Luming Yu wrote:
> > > On Fri, Oct 22, 2021 at 7:36 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 21, 2021 at 05:37:24AM -0400, Luming Yu wrote:
> > > > > On Wed, Oct 20, 2021 at 1:49 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Oct 20, 2021 at 06:09:58AM -0400, Luming Yu wrote:
> > > > > > > On Tue, Oct 19, 2021 at 1:04 AM John Stultz <john.stultz@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Oct 18, 2021 at 9:14 PM yanghui <yanghui.def@bytedance.com> wrote:
> > > > > > > > > 在 2021/10/19 上午12:14, John Stultz 写道:
> > > > > > > > > > On Tue, Oct 12, 2021 at 1:06 AM brookxu <brookxu.cn@gmail.com> wrote:
> > > > > > > > > >> John Stultz wrote on 2021/10/12 13:29:
> > > > > > > > > >>> On Mon, Oct 11, 2021 at 10:23 PM brookxu <brookxu.cn@gmail.com> wrote:
> > > > > > > > > >>>> John Stultz wrote on 2021/10/12 12:52 下午:
> > > > > > > > > >>>>> On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gmail.com> wrote:
> > > > > > > > > >>>> If we record the watchdog's start_time in clocksource_start_watchdog(), and then
> > > > > > > > > >>>> when we verify cycles in clocksource_watchdog(), check whether the clocksource
> > > > > > > > > >>>> watchdog is blocked. Due to MSB verification, if the blocked time is greater than
> > > > > > > > > >>>> half of the watchdog timer max_cycles, then we can safely ignore the current
> > > > > > > > > >>>> verification? Do you think this idea is okay?
> > > > > > > > > >>>
> > > > > > > > > >>> I can't say I totally understand the idea. Maybe could you clarify with a patch?
> > > > > > > > > >>>
> > > > > > > > > >>
> > > > > > > > > >> Sorry, it looks almost as follows:
> > > > > > > > > >>
> > > > > > > > > >> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > > > > > > > > >> index b8a14d2..87f3b67 100644
> > > > > > > > > >> --- a/kernel/time/clocksource.c
> > > > > > > > > >> +++ b/kernel/time/clocksource.c
> > > > > > > > > >> @@ -119,6 +119,7 @@
> > > > > > > > > >>   static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
> > > > > > > > > >>   static DEFINE_SPINLOCK(watchdog_lock);
> > > > > > > > > >>   static int watchdog_running;
> > > > > > > > > >> +static unsigned long watchdog_start_time;
> > > > > > > > > >>   static atomic_t watchdog_reset_pending;
> > > > > > > > > >>
> > > > > > > > > >>   static inline void clocksource_watchdog_lock(unsigned long *flags)
> > > > > > > > > >> @@ -356,6 +357,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > > > > > > > >>          int next_cpu, reset_pending;
> > > > > > > > > >>          int64_t wd_nsec, cs_nsec;
> > > > > > > > > >>          struct clocksource *cs;
> > > > > > > > > >> +       unsigned long max_jiffies;
> > > > > > > > > >>          u32 md;
> > > > > > > > > >>
> > > > > > > > > >>          spin_lock(&watchdog_lock);
> > > > > > > > > >> @@ -402,6 +404,10 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > > > > > > > >>                  if (atomic_read(&watchdog_reset_pending))
> > > > > > > > > >>                          continue;
> > > > > > > > > >>
> > > > > > > > > >> +               max_jiffies = nsecs_to_jiffies(cs->max_idle_ns);
> > > > > > > > > >> +               if (time_is_before_jiffies(watchdog_start_time + max_jiffies))
> > > > > > > > > >> +                       continue;
> > > > > > > > > >> +
> > > > > > > > > >
> > > > > > > > > > Sorry, what is the benefit of using jiffies here?   Jiffies are
> > > > > > > > > > updated by counting the number of tick intervals on the current
> > > > > > > > > > clocksource.
> > > > > > > > > >
> > > > > > > > > > This seems like circular logic, where we're trying to judge the
> > > > > > > > > > current clocksource by using something we derived from the current
> > > > > > > > > > clocksource.
> > > > > > > > > > That's why the watchdog clocksource is important, as it's supposed to
> > > > > > > > > > be a separate counter that is more reliable (but likely slower) then
> > > > > > > > > > the preferred clocksource.
> > > > > > > > > >
> > > > > > > > > > So I'm not really sure how this helps.
> > > > > > > > > >
> > > > > > > > > > The earlier patch by yanghui at least used the watchdog interval to
> > > > > > > > > > decide if the watchdog timer had expired late. Which seemed
> > > > > > > > > > reasonable, but I thought it might be helpful to add some sort of a
> > > > > > > > > > counter so if the case is happening repeatedly (timers constantly
> > > > > > > > > > being delayed) we have a better signal that the watchdog and current
> > > > > > > > > > clocksource are out of sync.  Because again, timers are fired based on
> > > > > > > > >
> > > > > > > > > I think only have a signal ls not enough. we need to prevent
> > > > > > > > > clocksource from being incorrectly switched.
> > > > > > > >
> > > > > > > > Right, but we also have to ensure that we also properly disqualify
> > > > > > > > clocksources that are misbehaving.
> > > > > > > >
> > > > > > > > In the case that the current clocksource is running very slow (imagine
> > > > > > > > old TSCs that lowered freq with cpufreq), then system time slows down,
> > > > > > > > so timers fire late.
> > > > > > > > So it would constantly seem like the irqs are being delayed, so with
> > > > > > > > your logic we would not disqualify a clearly malfunctioning
> > > > > > > > clocksource..
> > > > > > > >
> > > > > > > > > The Timer callback function clocksource_watchdog() is executed in the
> > > > > > > > > context of softirq(run_timer_softirq()). So if softirq is disabled for
> > > > > > > > > long time(One situation is long time softlockup), clocksource_watchdog()
> > > > > > > > > will be delay executed.
> > > > > > > >
> > > > > > > > Yes. The reality is that timers are often spuriously delayed. We don't
> > > > > > > > want a short burst of timer misbehavior to disqualify a good
> > > > > > > > clocksource.
> > > > > > > >
> > > > > > > > But the problem is that this situation and the one above (with the
> > > > > > > > freq changing TSC), will look exactly the same.
> > > > > > > >
> > > > > > > > So having a situation where if the watchdog clocksource thinks too
> > > > > > > > much time has passed between watchdog timers, we can skip judgement,
> > > > > > > > assuming its a spurious delay. But I think we need to keep a counter
> > > > > > > > so that if this happens 3-5 times in a row, we stop ignoring the
> > > > > > > > misbehavior and judge the current clocksource, as it may be running
> > > > > > > > slowly.
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > I think it will be better to add this to my patch:
> > > > > > > > >   /*
> > > > > > > > >    * Interval: 0.5sec.
> > > > > > > > > - * MaxInterval: 1s.
> > > > > > > > > + * MaxInterval: 20s.
> > > > > > > > >    */
> > > > > > > > >   #define WATCHDOG_INTERVAL (HZ >> 1)
> > > > > > > > > -#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
> > > > > > > > > +#define WATCHDOG_MAX_INTERVAL_NS (20 * NSEC_PER_SEC)
> > > > > > > > >
> > > > > > > >
> > > > > > > > Some watchdog counters wrap within 20 seconds, so I don't think this
> > > > > > > > is a good idea.
> > > > > > > >
> > > > > > > > The other proposal to calculate the error rate, rather than a fixed
> > > > > > > > error boundary might be useful too, as if the current clocksource and
> > > > > > > > watchdog are close, a long timer delay won't disqualify them if we
> > > > > > > > scale the error bounds to be within an given error rate.
> > > > > > >
> > > > > > > In most of tsc unstable trouble shooting on modern servers we experienced,
> > > > > > > it usually ends up in a false alarm triggered by the  clock source
> > > > > > > watchdog for tsc.
> > > > > > >
> > > > > > > I think Paul has a proposal to make a clock source watchdog to be more
> > > > > > > intelligent.
> > > > > > > Its job is to find a real problem instead of causing a problem.
> > > > > >
> > > > > > And that proposal is now in mainline:
> > > > >
> > > > > Great! : -)
> > > > > >
> > > > > > 22a223833716 clocksource: Print deviation in nanoseconds when a clocksource becomes unstable
> > > > > > 1253b9b87e42 clocksource: Provide kernel module to test clocksource watchdog
> > > > > > 2e27e793e280 clocksource: Reduce clocksource-skew threshold
> > > > > > fa218f1cce6b clocksource: Limit number of CPUs checked for clock synchronization
> > > > > > 7560c02bdffb clocksource: Check per-CPU clock synchronization when marked unstable
> > > > > > db3a34e17433 clocksource: Retry clock read if long delays detected
> > > > > >
> > > > > > The strategy is to disqualify a clock comparison if the reads took too
> > > > > > long, and to retry the comparison.  If four consecutive comparison take
> > > > > > too long, clock skew is reported.  The number of consecutive comparisons
> > > > > > may be adjusted by the usual kernel boot parameter.
> > > > > >
> > > > > > > so disabling it for known good-tsc might be a reasonable good idea
> > > > > > > that can save manpower for other
> > > > > > > more valuable problems to solve, or at least make it statistically a
> > > > > > > problem less chance to happen.
> > > > > >
> > > > > > One additional piece that is still in prototype state in -rcu is to give
> > > > > > clocksources some opportunity to resynchronize if there are too many
> > > > > > slow comparisons.  This is intended to handle cases where clocks often
> > > > >
> > > > > if there is such tsc-sync algorithm existing in software, it really
> > > > > can help system software engineers
> > > > > to solve some rare power good signals synchronization problem caused
> > > > > by bios that caused
> > > > > boot time tsc sync check failure that usually would consume huge
> > > > > debugging engine for bringing up qualified linux system.
> > > > >
> > > > > Less depending on platform quirks should be good thing to linux for
> > > > > tsc && rcu support.
> > > >
> > > > Good point, I have procrastinated long enough.
> > > >
> > > > How about like this?
> > >
> > > sorry, I meant a better algorithm to use tsc adjust register
> > > like the tried one in  arch/x86/kernel/tsc_sync.c
> >
> > Ah, at this time I must leave that sort of task to others.
> 
> sure.
> if anyone is still debugging clock-source watchdog issue, It is
> highly appreciated and would be more helpful to others
> that we truly need  to decouple TSC with slow clock source.
> we need to be aware of that when looking into clock source watchdog issues.

There is a old saying that those with only one clock always know what
time it is, but those with more than one clock never can be sure.  ;-)

In the testing and validation phases, one should supply a known good
external clock against which to check everything.  I could imagine doing
something similar in production using any of a number of Internet time
services, but that project is beyond what I can commit to any time soon.
Note that it is not so simple because it must deal with arbitrary delays
across the Internet, the possibility of broken Internet time services,
and so on.

But in the common case, I bet it would greatly simplify your debugging
efforts!

> And many thanks to the value of your patch, I 'm seeing another report
> that obviously has carried  "attempt 4, marking unstable"
> one or two times at the beginning followed  less occurrence after
> hundreds of boot..
> ： high priority --> medium

I am glad that it helped!

                                                        Thanx, Paul

> > > > ------------------------------------------------------------------------
> > > >
> > > > commit 9ec2a03bbf4bee3d9fbc02a402dee36efafc5a2d
> > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Thu May 27 11:03:28 2021 -0700
> > > >
> > > >     clocksource: Forgive repeated long-latency watchdog clocksource reads
> > > >
> > > >     Currently, the clocksource watchdog reacts to repeated long-latency
> > > >     clocksource reads by marking that clocksource unstable on the theory that
> > > >     these long-latency reads are a sign of a serious problem.  And this theory
> > >
> > > Maybe we need to use other core's tsc as a reference clock instead of
> > > using HPET, which , to my knowledge ,  is the place where the problem happens.
> > >
> > > Ruling out HPET and other slow clock devices as the obvious wrong choice
> > > of a reference clock for  tsc,  I guess there will be less chance we
> > > (in kernel code)
> > > will get bothered by other latency problems perceived in the clock
> > > source watchdog.
> >
> > There have been a number of patches that identify systems that tend to
> > have unreliable HPET implementations.  Perhaps more systems are needed
> > there, or maybe some of those patches need to be backported to the
> > version of Linux that you are using.
> >
> > There was also a patch that identified systems that are expected to have
> > reliable TSCs, and that de-emphasized HPET on such systems.
> >
> >                                                         Thanx, Paul
> >
> > > >     does in fact have real-world support in the form of firmware issues [1].
> > > >
> > > >     However, it is also possible to trigger this using stress-ng on what
> > > >     the stress-ng man page terms "poorly designed hardware" [2].  And it
> > > >     is not necessarily a bad thing for the kernel to diagnose cases where
> > > >     heavy memory-contention workloads are being run on hardware that is not
> > > >     designed for this sort of use.
> > > >
> > > >     Nevertheless, it is quite possible that real-world use will result in
> > > >     some situation requiring that high-stress workloads run on hardware
> > > >     not designed to accommodate them, and also requiring that the kernel
> > > >     refrain from marking clocksources unstable.
> > > >
> > > >     Therefore, react to persistent long-latency reads by leaving the
> > > >     clocksource alone, but using the old 62.5-millisecond skew-detection
> > > >     threshold.  In addition, the offending clocksource is marked for
> > > >     re-initialization, which both restarts that clocksource with a clean bill
> > > >     of health and avoids false-positive skew reports on later watchdog checks.
> > > >     Once marked for re-initialization, the clocksource is not subjected to
> > > >     further watchdog checking until a subsequent successful read from that
> > > >     clocksource that is free of excessive delays.
> > > >
> > > >     However, if clocksource.max_cswd_coarse_reads consecutive clocksource read
> > > >     attempts result in long latencies, a warning (splat) will be emitted.
> > > >     This kernel boot parameter defaults to 100, and this warning can be
> > > >     disabled by setting it to zero or to a negative value.
> > > >
> > > >     [ paulmck: Apply feedback from Chao Gao ]
> > > >
> > > >     Link: https://lore.kernel.org/lkml/20210513155515.GB23902@xsang-OptiPlex-9020/ # [1]
> > > >     Link: https://lore.kernel.org/lkml/20210521083322.GG25531@xsang-OptiPlex-9020/ # [2]
> > > >     Link: https://lore.kernel.org/lkml/20210521084405.GH25531@xsang-OptiPlex-9020/
> > > >     Link: https://lore.kernel.org/lkml/20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1/
> > > >     Tested-by: Chao Gao <chao.gao@intel.com>
> > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > > index 316027c3aadc..61d2436ae9df 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -600,6 +600,14 @@
> > > >                         loops can be debugged more effectively on production
> > > >                         systems.
> > > >
> > > > +       clocksource.max_cswd_coarse_reads= [KNL]
> > > > +                       Number of consecutive clocksource_watchdog()
> > > > +                       coarse reads (that is, clocksource reads that
> > > > +                       were unduly delayed) that are permitted before
> > > > +                       the kernel complains (gently).  Set to a value
> > > > +                       less than or equal to zero to suppress these
> > > > +                       complaints.
> > > > +
> > > >         clocksource.max_cswd_read_retries= [KNL]
> > > >                         Number of clocksource_watchdog() retries due to
> > > >                         external delays before the clock will be marked
> > > > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> > > > index 1d42d4b17327..3e925d9ffc31 100644
> > > > --- a/include/linux/clocksource.h
> > > > +++ b/include/linux/clocksource.h
> > > > @@ -110,6 +110,7 @@ struct clocksource {
> > > >         int                     rating;
> > > >         enum clocksource_ids    id;
> > > >         enum vdso_clock_mode    vdso_clock_mode;
> > > > +       unsigned int            n_coarse_reads;
> > > >         unsigned long           flags;
> > > >
> > > >         int                     (*enable)(struct clocksource *cs);
> > > > @@ -291,6 +292,7 @@ static inline void timer_probe(void) {}
> > > >  #define TIMER_ACPI_DECLARE(name, table_id, fn)         \
> > > >         ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
> > > >
> > > > +extern int max_cswd_coarse_reads;
> > > >  extern ulong max_cswd_read_retries;
> > > >  void clocksource_verify_percpu(struct clocksource *cs);
> > > >
> > > > diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
> > > > index df922f49d171..7e82500c400b 100644
> > > > --- a/kernel/time/clocksource-wdtest.c
> > > > +++ b/kernel/time/clocksource-wdtest.c
> > > > @@ -145,13 +145,12 @@ static int wdtest_func(void *arg)
> > > >                 else if (i <= max_cswd_read_retries)
> > > >                         s = ", expect message";
> > > >                 else
> > > > -                       s = ", expect clock skew";
> > > > +                       s = ", expect coarse-grained clock skew check and re-initialization";
> > > >                 pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
> > > >                 WRITE_ONCE(wdtest_ktime_read_ndelays, i);
> > > >                 schedule_timeout_uninterruptible(2 * HZ);
> > > >                 WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
> > > > -               WARN_ON_ONCE((i <= max_cswd_read_retries) !=
> > > > -                            !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
> > > > +               WARN_ON_ONCE(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE);
> > > >                 wdtest_ktime_clocksource_reset();
> > > >         }
> > > >
> > > > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > > > index b8a14d2fb5ba..796a127aabb9 100644
> > > > --- a/kernel/time/clocksource.c
> > > > +++ b/kernel/time/clocksource.c
> > > > @@ -199,6 +199,9 @@ void clocksource_mark_unstable(struct clocksource *cs)
> > > >         spin_unlock_irqrestore(&watchdog_lock, flags);
> > > >  }
> > > >
> > > > +int max_cswd_coarse_reads = 100;
> > > > +module_param(max_cswd_coarse_reads, int, 0644);
> > > > +EXPORT_SYMBOL_GPL(max_cswd_coarse_reads);
> > > >  ulong max_cswd_read_retries = 3;
> > > >  module_param(max_cswd_read_retries, ulong, 0644);
> > > >  EXPORT_SYMBOL_GPL(max_cswd_read_retries);
> > > > @@ -226,13 +229,22 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> > > >                                 pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
> > > >                                         smp_processor_id(), watchdog->name, nretries);
> > > >                         }
> > > > -                       return true;
> > > > +                       cs->n_coarse_reads = 0;
> > > > +                       return false;
> > > >                 }
> > > > +               WARN_ONCE(max_cswd_coarse_reads > 0 &&
> > > > +                         !(++cs->n_coarse_reads % max_cswd_coarse_reads),
> > > > +                         "timekeeping watchdog on CPU%d: %s %u consecutive coarse-grained reads\n", smp_processor_id(), watchdog->name, cs->n_coarse_reads);
> > > >         }
> > > >
> > > > -       pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
> > > > -               smp_processor_id(), watchdog->name, wd_delay, nretries);
> > > > -       return false;
> > > > +       if ((cs->flags & CLOCK_SOURCE_WATCHDOG) && !atomic_read(&watchdog_reset_pending)) {
> > > > +               pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, coarse-grained skew check followed by re-initialization\n",
> > > > +                       smp_processor_id(), watchdog->name, wd_delay, nretries);
> > > > +       } else {
> > > > +               pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, awaiting re-initialization\n",
> > > > +                       smp_processor_id(), watchdog->name, wd_delay, nretries);
> > > > +       }
> > > > +       return true;
> > > >  }
> > > >
> > > >  static u64 csnow_mid;
> > > > @@ -356,6 +368,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > >         int next_cpu, reset_pending;
> > > >         int64_t wd_nsec, cs_nsec;
> > > >         struct clocksource *cs;
> > > > +       bool coarse;
> > > >         u32 md;
> > > >
> > > >         spin_lock(&watchdog_lock);
> > > > @@ -373,16 +386,13 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > >                         continue;
> > > >                 }
> > > >
> > > > -               if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
> > > > -                       /* Clock readout unreliable, so give it up. */
> > > > -                       __clocksource_unstable(cs);
> > > > -                       continue;
> > > > -               }
> > > > +               coarse = cs_watchdog_read(cs, &csnow, &wdnow);
> > > >
> > > >                 /* Clocksource initialized ? */
> > > >                 if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
> > > >                     atomic_read(&watchdog_reset_pending)) {
> > > > -                       cs->flags |= CLOCK_SOURCE_WATCHDOG;
> > > > +                       if (!coarse)
> > > > +                               cs->flags |= CLOCK_SOURCE_WATCHDOG;
> > > >                         cs->wd_last = wdnow;
> > > >                         cs->cs_last = csnow;
> > > >                         continue;
> > > > @@ -403,7 +413,13 @@ static void clocksource_watchdog(struct timer_list *unused)
> > > >                         continue;
> > > >
> > > >                 /* Check the deviation from the watchdog clocksource. */
> > > > -               md = cs->uncertainty_margin + watchdog->uncertainty_margin;
> > > > +               if (coarse) {
> > > > +                       md = 62500 * NSEC_PER_USEC;
> > > > +                       cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
> > > > +                       pr_warn("timekeeping watchdog on CPU%d: %s coarse-grained %lu.%03lu ms clock-skew check followed by re-initialization\n", smp_processor_id(), watchdog->name, md / NSEC_PER_MSEC, md % NSEC_PER_MSEC / NSEC_PER_USEC);
> > > > +               } else {
> > > > +                       md = cs->uncertainty_margin + watchdog->uncertainty_margin;
> > > > +               }
> > > >                 if (abs(cs_nsec - wd_nsec) > md) {
> > > >                         pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
> > > >                                 smp_processor_id(), cs->name);
