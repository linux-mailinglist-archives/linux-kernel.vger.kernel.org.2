Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7FA435E0E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhJUJij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhJUJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:38:38 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E50C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:36:22 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id y10so7124922qkp.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IlSZhCf+Gf0kDyeO61N+I5aGuRl8CEyqdDa1WOKBPC0=;
        b=SU1MWMNmG++jW9M2JCi/fd2/vdDoAst3bZcC/2D70paaHOn7O0PLIRDZV7NccuLyYI
         edNpp3UrdyK+3UUNFWyTH117l8kCaw/4gAGrYnm7wiI44+62Eh32bLQFAC7ZwWYGMjI0
         FRXzLXbpKQyXQyI8Fx0T4NcawBjD03yYZ2sa6GI6e+CRYrX3HjzxyrpQOZVCK0Ib71JY
         oaXoFLFfCGoKFokqXRUFgRK9wh1oYu178NYNce9KgVOnTiq0pUl2bqBG3+2t6Nbms4oQ
         4PM1IVdrEkhUpm5hytIVVJxfEQFOQ2Gu1oWnoY50YQ6kiXvpl5wwAPwMuaSZiR416FSU
         kBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IlSZhCf+Gf0kDyeO61N+I5aGuRl8CEyqdDa1WOKBPC0=;
        b=uNgyMTHUaxeyVbYmAfF2wyHRUkRN6jyLUuoPqZ1/2J4T3LtBt6F66184l9PVGSBZKu
         rjtSbvMkICJ0DmBVSNduvXNIFPPSGr7qECdnrrjYrtQ7bbioG4nAJ2lR7+aeOx4GBsuZ
         quPMV47wHdomZdGw967jhq24gdPgkKVUkg8zS6jt/EUHwHPjwiWaZ3tqfdjd+T9+0g8t
         EQ6t4LZyOJ8wTWgWvMcYfwfxtNwtPnhtcuMEVOCHWbfAYF0uP1PdPKhXRQn9Jy5pLIDk
         YjrkLjSprxQKtucweWg+nLKNJ+X7vyITm2IXqKndFcQQIjrNZAJKIM7Vym/m7IKJ0/Mr
         fGrw==
X-Gm-Message-State: AOAM532acNjHn2UFYcR5TDX3fLA1x8O791J7kwLm+0oAovGzl0FaFkGb
        lx6JoLlj2LBTLaO15Y+f6vGiI17N6WOWauCO26I=
X-Google-Smtp-Source: ABdhPJzaEHEDKwlJtkdjYL9rApKRSmpvnUIlo3akNglAjgRuAtIDp4CDvA6Pdnc5EV3WMN8awxLlKzR4TdWZ25lLRS0=
X-Received: by 2002:a37:9c57:: with SMTP id f84mr3525419qke.16.1634808982027;
 Thu, 21 Oct 2021 02:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com> <CALAqxLVgQ6QEThWaN65nOW9F_XCh7885n9RigAQDU+OgDntS5g@mail.gmail.com>
 <6b715fb7-9850-04f3-4ab8-1a2a8a2cdfbf@gmail.com> <CALAqxLWgw8tA1Lrg27JUUFrGWCQqPQXmhjHyjsTRA5a4qingkg@mail.gmail.com>
 <95c1a031-6751-f90f-d003-b74fbec0e9d8@gmail.com> <CALAqxLVcc9nscuWT-qFH=JbatVL0c5AxH5B9y3qE1ekG=BZ0aA@mail.gmail.com>
 <61381153-634e-489b-848f-7077ce46049a@bytedance.com> <CALAqxLUJeF1NFAzvp2ubRizbJV-ws09P6x=5nzSz7_VmMAQLNA@mail.gmail.com>
 <CAJRGBZz6dF=AADKMFwUodm2WeDyTvBw0XxnQdeJwPLs2=sLLEw@mail.gmail.com> <20211020174933.GJ880162@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20211020174933.GJ880162@paulmck-ThinkPad-P17-Gen-1>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Thu, 21 Oct 2021 05:37:24 -0400
Message-ID: <CAJRGBZxQdFsXZtHwiqT4YrjUnN4P3xK_vy_uuso2WErqtHRX7w@mail.gmail.com>
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     paulmck@kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        yanghui <yanghui.def@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 1:49 PM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Wed, Oct 20, 2021 at 06:09:58AM -0400, Luming Yu wrote:
> > On Tue, Oct 19, 2021 at 1:04 AM John Stultz <john.stultz@linaro.org> wr=
ote:
> > >
> > > On Mon, Oct 18, 2021 at 9:14 PM yanghui <yanghui.def@bytedance.com> w=
rote:
> > > > =E5=9C=A8 2021/10/19 =E4=B8=8A=E5=8D=8812:14, John Stultz =E5=86=99=
=E9=81=93:
> > > > > On Tue, Oct 12, 2021 at 1:06 AM brookxu <brookxu.cn@gmail.com> wr=
ote:
> > > > >> John Stultz wrote on 2021/10/12 13:29:
> > > > >>> On Mon, Oct 11, 2021 at 10:23 PM brookxu <brookxu.cn@gmail.com>=
 wrote:
> > > > >>>> John Stultz wrote on 2021/10/12 12:52 =E4=B8=8B=E5=8D=88:
> > > > >>>>> On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gmail.com>=
 wrote:
> > > > >>>> If we record the watchdog's start_time in clocksource_start_wa=
tchdog(), and then
> > > > >>>> when we verify cycles in clocksource_watchdog(), check whether=
 the clocksource
> > > > >>>> watchdog is blocked. Due to MSB verification, if the blocked t=
ime is greater than
> > > > >>>> half of the watchdog timer max_cycles, then we can safely igno=
re the current
> > > > >>>> verification? Do you think this idea is okay?
> > > > >>>
> > > > >>> I can't say I totally understand the idea. Maybe could you clar=
ify with a patch?
> > > > >>>
> > > > >>
> > > > >> Sorry, it looks almost as follows:
> > > > >>
> > > > >> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource=
.c
> > > > >> index b8a14d2..87f3b67 100644
> > > > >> --- a/kernel/time/clocksource.c
> > > > >> +++ b/kernel/time/clocksource.c
> > > > >> @@ -119,6 +119,7 @@
> > > > >>   static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
> > > > >>   static DEFINE_SPINLOCK(watchdog_lock);
> > > > >>   static int watchdog_running;
> > > > >> +static unsigned long watchdog_start_time;
> > > > >>   static atomic_t watchdog_reset_pending;
> > > > >>
> > > > >>   static inline void clocksource_watchdog_lock(unsigned long *fl=
ags)
> > > > >> @@ -356,6 +357,7 @@ static void clocksource_watchdog(struct time=
r_list *unused)
> > > > >>          int next_cpu, reset_pending;
> > > > >>          int64_t wd_nsec, cs_nsec;
> > > > >>          struct clocksource *cs;
> > > > >> +       unsigned long max_jiffies;
> > > > >>          u32 md;
> > > > >>
> > > > >>          spin_lock(&watchdog_lock);
> > > > >> @@ -402,6 +404,10 @@ static void clocksource_watchdog(struct tim=
er_list *unused)
> > > > >>                  if (atomic_read(&watchdog_reset_pending))
> > > > >>                          continue;
> > > > >>
> > > > >> +               max_jiffies =3D nsecs_to_jiffies(cs->max_idle_ns=
);
> > > > >> +               if (time_is_before_jiffies(watchdog_start_time +=
 max_jiffies))
> > > > >> +                       continue;
> > > > >> +
> > > > >
> > > > > Sorry, what is the benefit of using jiffies here?   Jiffies are
> > > > > updated by counting the number of tick intervals on the current
> > > > > clocksource.
> > > > >
> > > > > This seems like circular logic, where we're trying to judge the
> > > > > current clocksource by using something we derived from the curren=
t
> > > > > clocksource.
> > > > > That's why the watchdog clocksource is important, as it's suppose=
d to
> > > > > be a separate counter that is more reliable (but likely slower) t=
hen
> > > > > the preferred clocksource.
> > > > >
> > > > > So I'm not really sure how this helps.
> > > > >
> > > > > The earlier patch by yanghui at least used the watchdog interval =
to
> > > > > decide if the watchdog timer had expired late. Which seemed
> > > > > reasonable, but I thought it might be helpful to add some sort of=
 a
> > > > > counter so if the case is happening repeatedly (timers constantly
> > > > > being delayed) we have a better signal that the watchdog and curr=
ent
> > > > > clocksource are out of sync.  Because again, timers are fired bas=
ed on
> > > >
> > > > I think only have a signal ls not enough. we need to prevent
> > > > clocksource from being incorrectly switched.
> > >
> > > Right, but we also have to ensure that we also properly disqualify
> > > clocksources that are misbehaving.
> > >
> > > In the case that the current clocksource is running very slow (imagin=
e
> > > old TSCs that lowered freq with cpufreq), then system time slows down=
,
> > > so timers fire late.
> > > So it would constantly seem like the irqs are being delayed, so with
> > > your logic we would not disqualify a clearly malfunctioning
> > > clocksource..
> > >
> > > > The Timer callback function clocksource_watchdog() is executed in t=
he
> > > > context of softirq(run_timer_softirq()). So if softirq is disabled =
for
> > > > long time(One situation is long time softlockup), clocksource_watch=
dog()
> > > > will be delay executed.
> > >
> > > Yes. The reality is that timers are often spuriously delayed. We don'=
t
> > > want a short burst of timer misbehavior to disqualify a good
> > > clocksource.
> > >
> > > But the problem is that this situation and the one above (with the
> > > freq changing TSC), will look exactly the same.
> > >
> > > So having a situation where if the watchdog clocksource thinks too
> > > much time has passed between watchdog timers, we can skip judgement,
> > > assuming its a spurious delay. But I think we need to keep a counter
> > > so that if this happens 3-5 times in a row, we stop ignoring the
> > > misbehavior and judge the current clocksource, as it may be running
> > > slowly.
> > >
> > > > >
> > > > I think it will be better to add this to my patch:
> > > >   /*
> > > >    * Interval: 0.5sec.
> > > > - * MaxInterval: 1s.
> > > > + * MaxInterval: 20s.
> > > >    */
> > > >   #define WATCHDOG_INTERVAL (HZ >> 1)
> > > > -#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
> > > > +#define WATCHDOG_MAX_INTERVAL_NS (20 * NSEC_PER_SEC)
> > > >
> > >
> > > Some watchdog counters wrap within 20 seconds, so I don't think this
> > > is a good idea.
> > >
> > > The other proposal to calculate the error rate, rather than a fixed
> > > error boundary might be useful too, as if the current clocksource and
> > > watchdog are close, a long timer delay won't disqualify them if we
> > > scale the error bounds to be within an given error rate.
> >
> > In most of tsc unstable trouble shooting on modern servers we experienc=
ed,
> > it usually ends up in a false alarm triggered by the  clock source
> > watchdog for tsc.
> >
> > I think Paul has a proposal to make a clock source watchdog to be more
> > intelligent.
> > Its job is to find a real problem instead of causing a problem.
>
> And that proposal is now in mainline:

Great! : -)
>
> 22a223833716 clocksource: Print deviation in nanoseconds when a clocksour=
ce becomes unstable
> 1253b9b87e42 clocksource: Provide kernel module to test clocksource watch=
dog
> 2e27e793e280 clocksource: Reduce clocksource-skew threshold
> fa218f1cce6b clocksource: Limit number of CPUs checked for clock synchron=
ization
> 7560c02bdffb clocksource: Check per-CPU clock synchronization when marked=
 unstable
> db3a34e17433 clocksource: Retry clock read if long delays detected
>
> The strategy is to disqualify a clock comparison if the reads took too
> long, and to retry the comparison.  If four consecutive comparison take
> too long, clock skew is reported.  The number of consecutive comparisons
> may be adjusted by the usual kernel boot parameter.
>
> > so disabling it for known good-tsc might be a reasonable good idea
> > that can save manpower for other
> > more valuable problems to solve, or at least make it statistically a
> > problem less chance to happen.
>
> One additional piece that is still in prototype state in -rcu is to give
> clocksources some opportunity to resynchronize if there are too many
> slow comparisons.  This is intended to handle cases where clocks often

if there is such tsc-sync algorithm existing in software, it really
can help system software engineers
to solve some rare power good signals synchronization problem caused
by bios that caused
boot time tsc sync check failure that usually would consume huge
debugging engine for bringing up qualified linux system.

Less depending on platform quirks should be good thing to linux for
tsc && rcu support.

> take hundreds of microseconds to read out due to cache-buster workloads
> interfering with all and sundry.  Testing indicates that even in the
> midst of such cache-busting, there will almost certainly be at least one
> fast comparison within a five-second period.  So the current thought is
> to give a clocksource 100 seconds in which to get a fast comparison.
>
> Those who have only one clock always know what time it is.  Those with
> more than one can never be certain.  Except that the universe is
> well-supplied with a great many clocks outside of the computer system
> in question.  ;-)
>
>                                                         Thanx, Paul
