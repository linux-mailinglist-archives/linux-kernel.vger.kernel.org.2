Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1F0443E5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhKCI20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhKCI2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:28:25 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB89C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 01:25:49 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id i13so2177902qvm.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 01:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GVwGz5dzmYwTO2O5Yz6a0bSCSbR67v16nAcXtU/d9Mk=;
        b=nasj9kV8HKWfvJWQlXX5o/VZkHBrG0i2JeyjXDsZLOeyczzz9CfMa7eaRq/hLzHcQJ
         vfmGAxd72S8W1S/pgiCYUQtuu/33ViFqjDjDIz6zRakYmaIsJp/12BdsDqLa4PhF6vhO
         Fyaa4l3nvwJGaSnFuTNzyTknCQecjE7lrLxq6AQxH1x2L+AmKzUufQF+iXuZIVnceGkG
         spLCRLSxDgh/EiFHPKRYwktfxnnYzcxxF+/PZW3u6mFM6GLFR5wff2Jd7Y9G46wS6/On
         ZY6odmxAOLuZfKw2B9911gCF+aUtLoIaO1msP4iP1SskkpuW9OJQXzzZAXwAj6VgBTl9
         3ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GVwGz5dzmYwTO2O5Yz6a0bSCSbR67v16nAcXtU/d9Mk=;
        b=bz93NKfoqjt6Qy/ekA3deGu+cNLCQ7I5XD2NbYbvxKtwFLwtSLIk4Zdj10t25ZCk1i
         3thQU5AovuyKWD+AXySGauOKVhcAoOgZX/EihI0/8wMwKW4s+hu4qIDYJL0okvhxmVnU
         Ok0cjW1XijlM1F2N4s/JtbVDjJiYyxZWetNsNoJLEY32GV7oXtNxtunOsY9Jeqt0c+bX
         RrUIbqbJmsEa/VYOCNVllB8XrdbSRk+OPGY/WeMbNxqT88cq8DVizT25KpjlhmznNyHc
         h09jEv861Rtl3dcVa1O6yDKb6syUrnSjKkP26gh2Eedx7TN4tjfQD89zoCwPfa/o4fs5
         m3yw==
X-Gm-Message-State: AOAM531h7DWkH4wz8Qp4rIe174Dnmj5JC6sf4e/aE1LONOxYtm3Jw2w0
        q4D1pB8S6EXG2w7uTZfZnOlG2FsoCe4dIQDIpp0=
X-Google-Smtp-Source: ABdhPJxTL9l3/NzQspdScRhFEhEneL5vcL/aZXCbPOxyabcXpCGYw99L/PPmcSaQtLU5qTsIVHNeWGm/Yr9bAim0k+Q=
X-Received: by 2002:a05:622a:13cc:: with SMTP id p12mr45147822qtk.227.1635927948351;
 Wed, 03 Nov 2021 01:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLWgw8tA1Lrg27JUUFrGWCQqPQXmhjHyjsTRA5a4qingkg@mail.gmail.com>
 <95c1a031-6751-f90f-d003-b74fbec0e9d8@gmail.com> <CALAqxLVcc9nscuWT-qFH=JbatVL0c5AxH5B9y3qE1ekG=BZ0aA@mail.gmail.com>
 <61381153-634e-489b-848f-7077ce46049a@bytedance.com> <CALAqxLUJeF1NFAzvp2ubRizbJV-ws09P6x=5nzSz7_VmMAQLNA@mail.gmail.com>
 <CAJRGBZz6dF=AADKMFwUodm2WeDyTvBw0XxnQdeJwPLs2=sLLEw@mail.gmail.com>
 <20211020174933.GJ880162@paulmck-ThinkPad-P17-Gen-1> <CAJRGBZxQdFsXZtHwiqT4YrjUnN4P3xK_vy_uuso2WErqtHRX7w@mail.gmail.com>
 <20211022233655.GH880162@paulmck-ThinkPad-P17-Gen-1> <CAJRGBZxL4ofhdhMTAaravWyCLsg8Pghtd+J9LGwBwzF2f6MKng@mail.gmail.com>
 <20211101165702.GD880162@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20211101165702.GD880162@paulmck-ThinkPad-P17-Gen-1>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Wed, 3 Nov 2021 04:27:42 -0400
Message-ID: <CAJRGBZzC2+rnPFVN-9rRB2hL2NFN27eknquKwjnbTS3b0DLWsA@mail.gmail.com>
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

On Mon, Nov 1, 2021 at 12:57 PM Paul E. McKenney <paulmck@kernel.org> wrote=
:
>
> On Mon, Nov 01, 2021 at 05:59:52AM -0400, Luming Yu wrote:
> > On Fri, Oct 22, 2021 at 7:36 PM Paul E. McKenney <paulmck@kernel.org> w=
rote:
> > >
> > > On Thu, Oct 21, 2021 at 05:37:24AM -0400, Luming Yu wrote:
> > > > On Wed, Oct 20, 2021 at 1:49 PM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
> > > > >
> > > > > On Wed, Oct 20, 2021 at 06:09:58AM -0400, Luming Yu wrote:
> > > > > > On Tue, Oct 19, 2021 at 1:04 AM John Stultz <john.stultz@linaro=
.org> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 18, 2021 at 9:14 PM yanghui <yanghui.def@bytedanc=
e.com> wrote:
> > > > > > > > =E5=9C=A8 2021/10/19 =E4=B8=8A=E5=8D=8812:14, John Stultz =
=E5=86=99=E9=81=93:
> > > > > > > > > On Tue, Oct 12, 2021 at 1:06 AM brookxu <brookxu.cn@gmail=
.com> wrote:
> > > > > > > > >> John Stultz wrote on 2021/10/12 13:29:
> > > > > > > > >>> On Mon, Oct 11, 2021 at 10:23 PM brookxu <brookxu.cn@gm=
ail.com> wrote:
> > > > > > > > >>>> John Stultz wrote on 2021/10/12 12:52 =E4=B8=8B=E5=8D=
=88:
> > > > > > > > >>>>> On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gm=
ail.com> wrote:
> > > > > > > > >>>> If we record the watchdog's start_time in clocksource_=
start_watchdog(), and then
> > > > > > > > >>>> when we verify cycles in clocksource_watchdog(), check=
 whether the clocksource
> > > > > > > > >>>> watchdog is blocked. Due to MSB verification, if the b=
locked time is greater than
> > > > > > > > >>>> half of the watchdog timer max_cycles, then we can saf=
ely ignore the current
> > > > > > > > >>>> verification? Do you think this idea is okay?
> > > > > > > > >>>
> > > > > > > > >>> I can't say I totally understand the idea. Maybe could =
you clarify with a patch?
> > > > > > > > >>>
> > > > > > > > >>
> > > > > > > > >> Sorry, it looks almost as follows:
> > > > > > > > >>
> > > > > > > > >> diff --git a/kernel/time/clocksource.c b/kernel/time/clo=
cksource.c
> > > > > > > > >> index b8a14d2..87f3b67 100644
> > > > > > > > >> --- a/kernel/time/clocksource.c
> > > > > > > > >> +++ b/kernel/time/clocksource.c
> > > > > > > > >> @@ -119,6 +119,7 @@
> > > > > > > > >>   static DECLARE_WORK(watchdog_work, clocksource_watchdo=
g_work);
> > > > > > > > >>   static DEFINE_SPINLOCK(watchdog_lock);
> > > > > > > > >>   static int watchdog_running;
> > > > > > > > >> +static unsigned long watchdog_start_time;
> > > > > > > > >>   static atomic_t watchdog_reset_pending;
> > > > > > > > >>
> > > > > > > > >>   static inline void clocksource_watchdog_lock(unsigned =
long *flags)
> > > > > > > > >> @@ -356,6 +357,7 @@ static void clocksource_watchdog(str=
uct timer_list *unused)
> > > > > > > > >>          int next_cpu, reset_pending;
> > > > > > > > >>          int64_t wd_nsec, cs_nsec;
> > > > > > > > >>          struct clocksource *cs;
> > > > > > > > >> +       unsigned long max_jiffies;
> > > > > > > > >>          u32 md;
> > > > > > > > >>
> > > > > > > > >>          spin_lock(&watchdog_lock);
> > > > > > > > >> @@ -402,6 +404,10 @@ static void clocksource_watchdog(st=
ruct timer_list *unused)
> > > > > > > > >>                  if (atomic_read(&watchdog_reset_pending=
))
> > > > > > > > >>                          continue;
> > > > > > > > >>
> > > > > > > > >> +               max_jiffies =3D nsecs_to_jiffies(cs->max=
_idle_ns);
> > > > > > > > >> +               if (time_is_before_jiffies(watchdog_star=
t_time + max_jiffies))
> > > > > > > > >> +                       continue;
> > > > > > > > >> +
> > > > > > > > >
> > > > > > > > > Sorry, what is the benefit of using jiffies here?   Jiffi=
es are
> > > > > > > > > updated by counting the number of tick intervals on the c=
urrent
> > > > > > > > > clocksource.
> > > > > > > > >
> > > > > > > > > This seems like circular logic, where we're trying to jud=
ge the
> > > > > > > > > current clocksource by using something we derived from th=
e current
> > > > > > > > > clocksource.
> > > > > > > > > That's why the watchdog clocksource is important, as it's=
 supposed to
> > > > > > > > > be a separate counter that is more reliable (but likely s=
lower) then
> > > > > > > > > the preferred clocksource.
> > > > > > > > >
> > > > > > > > > So I'm not really sure how this helps.
> > > > > > > > >
> > > > > > > > > The earlier patch by yanghui at least used the watchdog i=
nterval to
> > > > > > > > > decide if the watchdog timer had expired late. Which seem=
ed
> > > > > > > > > reasonable, but I thought it might be helpful to add some=
 sort of a
> > > > > > > > > counter so if the case is happening repeatedly (timers co=
nstantly
> > > > > > > > > being delayed) we have a better signal that the watchdog =
and current
> > > > > > > > > clocksource are out of sync.  Because again, timers are f=
ired based on
> > > > > > > >
> > > > > > > > I think only have a signal ls not enough. we need to preven=
t
> > > > > > > > clocksource from being incorrectly switched.
> > > > > > >
> > > > > > > Right, but we also have to ensure that we also properly disqu=
alify
> > > > > > > clocksources that are misbehaving.
> > > > > > >
> > > > > > > In the case that the current clocksource is running very slow=
 (imagine
> > > > > > > old TSCs that lowered freq with cpufreq), then system time sl=
ows down,
> > > > > > > so timers fire late.
> > > > > > > So it would constantly seem like the irqs are being delayed, =
so with
> > > > > > > your logic we would not disqualify a clearly malfunctioning
> > > > > > > clocksource..
> > > > > > >
> > > > > > > > The Timer callback function clocksource_watchdog() is execu=
ted in the
> > > > > > > > context of softirq(run_timer_softirq()). So if softirq is d=
isabled for
> > > > > > > > long time(One situation is long time softlockup), clocksour=
ce_watchdog()
> > > > > > > > will be delay executed.
> > > > > > >
> > > > > > > Yes. The reality is that timers are often spuriously delayed.=
 We don't
> > > > > > > want a short burst of timer misbehavior to disqualify a good
> > > > > > > clocksource.
> > > > > > >
> > > > > > > But the problem is that this situation and the one above (wit=
h the
> > > > > > > freq changing TSC), will look exactly the same.
> > > > > > >
> > > > > > > So having a situation where if the watchdog clocksource think=
s too
> > > > > > > much time has passed between watchdog timers, we can skip jud=
gement,
> > > > > > > assuming its a spurious delay. But I think we need to keep a =
counter
> > > > > > > so that if this happens 3-5 times in a row, we stop ignoring =
the
> > > > > > > misbehavior and judge the current clocksource, as it may be r=
unning
> > > > > > > slowly.
> > > > > > >
> > > > > > > > >
> > > > > > > > I think it will be better to add this to my patch:
> > > > > > > >   /*
> > > > > > > >    * Interval: 0.5sec.
> > > > > > > > - * MaxInterval: 1s.
> > > > > > > > + * MaxInterval: 20s.
> > > > > > > >    */
> > > > > > > >   #define WATCHDOG_INTERVAL (HZ >> 1)
> > > > > > > > -#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
> > > > > > > > +#define WATCHDOG_MAX_INTERVAL_NS (20 * NSEC_PER_SEC)
> > > > > > > >
> > > > > > >
> > > > > > > Some watchdog counters wrap within 20 seconds, so I don't thi=
nk this
> > > > > > > is a good idea.
> > > > > > >
> > > > > > > The other proposal to calculate the error rate, rather than a=
 fixed
> > > > > > > error boundary might be useful too, as if the current clockso=
urce and
> > > > > > > watchdog are close, a long timer delay won't disqualify them =
if we
> > > > > > > scale the error bounds to be within an given error rate.
> > > > > >
> > > > > > In most of tsc unstable trouble shooting on modern servers we e=
xperienced,
> > > > > > it usually ends up in a false alarm triggered by the  clock sou=
rce
> > > > > > watchdog for tsc.
> > > > > >
> > > > > > I think Paul has a proposal to make a clock source watchdog to =
be more
> > > > > > intelligent.
> > > > > > Its job is to find a real problem instead of causing a problem.
> > > > >
> > > > > And that proposal is now in mainline:
> > > >
> > > > Great! : -)
> > > > >
> > > > > 22a223833716 clocksource: Print deviation in nanoseconds when a c=
locksource becomes unstable
> > > > > 1253b9b87e42 clocksource: Provide kernel module to test clocksour=
ce watchdog
> > > > > 2e27e793e280 clocksource: Reduce clocksource-skew threshold
> > > > > fa218f1cce6b clocksource: Limit number of CPUs checked for clock =
synchronization
> > > > > 7560c02bdffb clocksource: Check per-CPU clock synchronization whe=
n marked unstable
> > > > > db3a34e17433 clocksource: Retry clock read if long delays detecte=
d
> > > > >
> > > > > The strategy is to disqualify a clock comparison if the reads too=
k too
> > > > > long, and to retry the comparison.  If four consecutive compariso=
n take
> > > > > too long, clock skew is reported.  The number of consecutive comp=
arisons
> > > > > may be adjusted by the usual kernel boot parameter.
> > > > >
> > > > > > so disabling it for known good-tsc might be a reasonable good i=
dea
> > > > > > that can save manpower for other
> > > > > > more valuable problems to solve, or at least make it statistica=
lly a
> > > > > > problem less chance to happen.
> > > > >
> > > > > One additional piece that is still in prototype state in -rcu is =
to give
> > > > > clocksources some opportunity to resynchronize if there are too m=
any
> > > > > slow comparisons.  This is intended to handle cases where clocks =
often
> > > >
> > > > if there is such tsc-sync algorithm existing in software, it really
> > > > can help system software engineers
> > > > to solve some rare power good signals synchronization problem cause=
d
> > > > by bios that caused
> > > > boot time tsc sync check failure that usually would consume huge
> > > > debugging engine for bringing up qualified linux system.
> > > >
> > > > Less depending on platform quirks should be good thing to linux for
> > > > tsc && rcu support.
> > >
> > > Good point, I have procrastinated long enough.
> > >
> > > How about like this?
> >
> > sorry, I meant a better algorithm to use tsc adjust register
> > like the tried one in  arch/x86/kernel/tsc_sync.c
>
> Ah, at this time I must leave that sort of task to others.

sure.
if anyone is still debugging clock-source watchdog issue, It is
highly appreciated and would be more helpful to others
that we truly need  to decouple TSC with slow clock source.
we need to be aware of that when looking into clock source watchdog issues.

And many thanks to the value of your patch, I 'm seeing another report
that obviously has carried  "attempt 4, marking unstable"
one or two times at the beginning followed  less occurrence after
hundreds of boot..
=EF=BC=9A high priority --> medium

>
>                                                         Thanx, Paul
>
> > > ---------------------------------------------------------------------=
---
> > >
> > > commit 9ec2a03bbf4bee3d9fbc02a402dee36efafc5a2d
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Thu May 27 11:03:28 2021 -0700
> > >
> > >     clocksource: Forgive repeated long-latency watchdog clocksource r=
eads
> > >
> > >     Currently, the clocksource watchdog reacts to repeated long-laten=
cy
> > >     clocksource reads by marking that clocksource unstable on the the=
ory that
> > >     these long-latency reads are a sign of a serious problem.  And th=
is theory
> >
> > Maybe we need to use other core's tsc as a reference clock instead of
> > using HPET, which , to my knowledge ,  is the place where the problem h=
appens.
> >
> > Ruling out HPET and other slow clock devices as the obvious wrong choic=
e
> > of a reference clock for  tsc,  I guess there will be less chance we
> > (in kernel code)
> > will get bothered by other latency problems perceived in the clock
> > source watchdog.
>
> There have been a number of patches that identify systems that tend to
> have unreliable HPET implementations.  Perhaps more systems are needed
> there, or maybe some of those patches need to be backported to the
> version of Linux that you are using.
>
> There was also a patch that identified systems that are expected to have
> reliable TSCs, and that de-emphasized HPET on such systems.
>
>                                                         Thanx, Paul
>
> > >     does in fact have real-world support in the form of firmware issu=
es [1].
> > >
> > >     However, it is also possible to trigger this using stress-ng on w=
hat
> > >     the stress-ng man page terms "poorly designed hardware" [2].  And=
 it
> > >     is not necessarily a bad thing for the kernel to diagnose cases w=
here
> > >     heavy memory-contention workloads are being run on hardware that =
is not
> > >     designed for this sort of use.
> > >
> > >     Nevertheless, it is quite possible that real-world use will resul=
t in
> > >     some situation requiring that high-stress workloads run on hardwa=
re
> > >     not designed to accommodate them, and also requiring that the ker=
nel
> > >     refrain from marking clocksources unstable.
> > >
> > >     Therefore, react to persistent long-latency reads by leaving the
> > >     clocksource alone, but using the old 62.5-millisecond skew-detect=
ion
> > >     threshold.  In addition, the offending clocksource is marked for
> > >     re-initialization, which both restarts that clocksource with a cl=
ean bill
> > >     of health and avoids false-positive skew reports on later watchdo=
g checks.
> > >     Once marked for re-initialization, the clocksource is not subject=
ed to
> > >     further watchdog checking until a subsequent successful read from=
 that
> > >     clocksource that is free of excessive delays.
> > >
> > >     However, if clocksource.max_cswd_coarse_reads consecutive clockso=
urce read
> > >     attempts result in long latencies, a warning (splat) will be emit=
ted.
> > >     This kernel boot parameter defaults to 100, and this warning can =
be
> > >     disabled by setting it to zero or to a negative value.
> > >
> > >     [ paulmck: Apply feedback from Chao Gao ]
> > >
> > >     Link: https://lore.kernel.org/lkml/20210513155515.GB23902@xsang-O=
ptiPlex-9020/ # [1]
> > >     Link: https://lore.kernel.org/lkml/20210521083322.GG25531@xsang-O=
ptiPlex-9020/ # [2]
> > >     Link: https://lore.kernel.org/lkml/20210521084405.GH25531@xsang-O=
ptiPlex-9020/
> > >     Link: https://lore.kernel.org/lkml/20210511233403.GA2896757@paulm=
ck-ThinkPad-P17-Gen-1/
> > >     Tested-by: Chao Gao <chao.gao@intel.com>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docume=
ntation/admin-guide/kernel-parameters.txt
> > > index 316027c3aadc..61d2436ae9df 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -600,6 +600,14 @@
> > >                         loops can be debugged more effectively on pro=
duction
> > >                         systems.
> > >
> > > +       clocksource.max_cswd_coarse_reads=3D [KNL]
> > > +                       Number of consecutive clocksource_watchdog()
> > > +                       coarse reads (that is, clocksource reads that
> > > +                       were unduly delayed) that are permitted befor=
e
> > > +                       the kernel complains (gently).  Set to a valu=
e
> > > +                       less than or equal to zero to suppress these
> > > +                       complaints.
> > > +
> > >         clocksource.max_cswd_read_retries=3D [KNL]
> > >                         Number of clocksource_watchdog() retries due =
to
> > >                         external delays before the clock will be mark=
ed
> > > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.=
h
> > > index 1d42d4b17327..3e925d9ffc31 100644
> > > --- a/include/linux/clocksource.h
> > > +++ b/include/linux/clocksource.h
> > > @@ -110,6 +110,7 @@ struct clocksource {
> > >         int                     rating;
> > >         enum clocksource_ids    id;
> > >         enum vdso_clock_mode    vdso_clock_mode;
> > > +       unsigned int            n_coarse_reads;
> > >         unsigned long           flags;
> > >
> > >         int                     (*enable)(struct clocksource *cs);
> > > @@ -291,6 +292,7 @@ static inline void timer_probe(void) {}
> > >  #define TIMER_ACPI_DECLARE(name, table_id, fn)         \
> > >         ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, f=
n)
> > >
> > > +extern int max_cswd_coarse_reads;
> > >  extern ulong max_cswd_read_retries;
> > >  void clocksource_verify_percpu(struct clocksource *cs);
> > >
> > > diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksour=
ce-wdtest.c
> > > index df922f49d171..7e82500c400b 100644
> > > --- a/kernel/time/clocksource-wdtest.c
> > > +++ b/kernel/time/clocksource-wdtest.c
> > > @@ -145,13 +145,12 @@ static int wdtest_func(void *arg)
> > >                 else if (i <=3D max_cswd_read_retries)
> > >                         s =3D ", expect message";
> > >                 else
> > > -                       s =3D ", expect clock skew";
> > > +                       s =3D ", expect coarse-grained clock skew che=
ck and re-initialization";
> > >                 pr_info("--- Watchdog with %dx error injection, %lu r=
etries%s.\n", i, max_cswd_read_retries, s);
> > >                 WRITE_ONCE(wdtest_ktime_read_ndelays, i);
> > >                 schedule_timeout_uninterruptible(2 * HZ);
> > >                 WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
> > > -               WARN_ON_ONCE((i <=3D max_cswd_read_retries) !=3D
> > > -                            !(clocksource_wdtest_ktime.flags & CLOCK=
_SOURCE_UNSTABLE));
> > > +               WARN_ON_ONCE(clocksource_wdtest_ktime.flags & CLOCK_S=
OURCE_UNSTABLE);
> > >                 wdtest_ktime_clocksource_reset();
> > >         }
> > >
> > > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > > index b8a14d2fb5ba..796a127aabb9 100644
> > > --- a/kernel/time/clocksource.c
> > > +++ b/kernel/time/clocksource.c
> > > @@ -199,6 +199,9 @@ void clocksource_mark_unstable(struct clocksource=
 *cs)
> > >         spin_unlock_irqrestore(&watchdog_lock, flags);
> > >  }
> > >
> > > +int max_cswd_coarse_reads =3D 100;
> > > +module_param(max_cswd_coarse_reads, int, 0644);
> > > +EXPORT_SYMBOL_GPL(max_cswd_coarse_reads);
> > >  ulong max_cswd_read_retries =3D 3;
> > >  module_param(max_cswd_read_retries, ulong, 0644);
> > >  EXPORT_SYMBOL_GPL(max_cswd_read_retries);
> > > @@ -226,13 +229,22 @@ static bool cs_watchdog_read(struct clocksource=
 *cs, u64 *csnow, u64 *wdnow)
> > >                                 pr_warn("timekeeping watchdog on CPU%=
d: %s retried %d times before success\n",
> > >                                         smp_processor_id(), watchdog-=
>name, nretries);
> > >                         }
> > > -                       return true;
> > > +                       cs->n_coarse_reads =3D 0;
> > > +                       return false;
> > >                 }
> > > +               WARN_ONCE(max_cswd_coarse_reads > 0 &&
> > > +                         !(++cs->n_coarse_reads % max_cswd_coarse_re=
ads),
> > > +                         "timekeeping watchdog on CPU%d: %s %u conse=
cutive coarse-grained reads\n", smp_processor_id(), watchdog->name, cs->n_c=
oarse_reads);
> > >         }
> > >
> > > -       pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of=
 %lldns, attempt %d, marking unstable\n",
> > > -               smp_processor_id(), watchdog->name, wd_delay, nretrie=
s);
> > > -       return false;
> > > +       if ((cs->flags & CLOCK_SOURCE_WATCHDOG) && !atomic_read(&watc=
hdog_reset_pending)) {
> > > +               pr_warn("timekeeping watchdog on CPU%d: %s read-back =
delay of %lldns, attempt %d, coarse-grained skew check followed by re-initi=
alization\n",
> > > +                       smp_processor_id(), watchdog->name, wd_delay,=
 nretries);
> > > +       } else {
> > > +               pr_warn("timekeeping watchdog on CPU%d: %s read-back =
delay of %lldns, attempt %d, awaiting re-initialization\n",
> > > +                       smp_processor_id(), watchdog->name, wd_delay,=
 nretries);
> > > +       }
> > > +       return true;
> > >  }
> > >
> > >  static u64 csnow_mid;
> > > @@ -356,6 +368,7 @@ static void clocksource_watchdog(struct timer_lis=
t *unused)
> > >         int next_cpu, reset_pending;
> > >         int64_t wd_nsec, cs_nsec;
> > >         struct clocksource *cs;
> > > +       bool coarse;
> > >         u32 md;
> > >
> > >         spin_lock(&watchdog_lock);
> > > @@ -373,16 +386,13 @@ static void clocksource_watchdog(struct timer_l=
ist *unused)
> > >                         continue;
> > >                 }
> > >
> > > -               if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
> > > -                       /* Clock readout unreliable, so give it up. *=
/
> > > -                       __clocksource_unstable(cs);
> > > -                       continue;
> > > -               }
> > > +               coarse =3D cs_watchdog_read(cs, &csnow, &wdnow);
> > >
> > >                 /* Clocksource initialized ? */
> > >                 if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
> > >                     atomic_read(&watchdog_reset_pending)) {
> > > -                       cs->flags |=3D CLOCK_SOURCE_WATCHDOG;
> > > +                       if (!coarse)
> > > +                               cs->flags |=3D CLOCK_SOURCE_WATCHDOG;
> > >                         cs->wd_last =3D wdnow;
> > >                         cs->cs_last =3D csnow;
> > >                         continue;
> > > @@ -403,7 +413,13 @@ static void clocksource_watchdog(struct timer_li=
st *unused)
> > >                         continue;
> > >
> > >                 /* Check the deviation from the watchdog clocksource.=
 */
> > > -               md =3D cs->uncertainty_margin + watchdog->uncertainty=
_margin;
> > > +               if (coarse) {
> > > +                       md =3D 62500 * NSEC_PER_USEC;
> > > +                       cs->flags &=3D ~CLOCK_SOURCE_WATCHDOG;
> > > +                       pr_warn("timekeeping watchdog on CPU%d: %s co=
arse-grained %lu.%03lu ms clock-skew check followed by re-initialization\n"=
, smp_processor_id(), watchdog->name, md / NSEC_PER_MSEC, md % NSEC_PER_MSE=
C / NSEC_PER_USEC);
> > > +               } else {
> > > +                       md =3D cs->uncertainty_margin + watchdog->unc=
ertainty_margin;
> > > +               }
> > >                 if (abs(cs_nsec - wd_nsec) > md) {
> > >                         pr_warn("timekeeping watchdog on CPU%d: Marki=
ng clocksource '%s' as unstable because the skew is too large:\n",
> > >                                 smp_processor_id(), cs->name);
