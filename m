Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB2E43489B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 12:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhJTKLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 06:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJTKLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 06:11:14 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92B4C061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 03:09:00 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id z15so1735630qvj.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7zPb9FQ20/SoAUVK7Nq9S40W9S5lPi5XKxOe4b1japQ=;
        b=BIhJQu4IfQHH3q2ARLadVGMsQpFmI8VifnbOEe1Fmc/AB2QJC9AZnDTkz02Quvc0c9
         unB9dZ+SHOHt2z7OfnRPSoU/EYNTjV8ywHJdabQlwAz/SC19QPoA4FQwMKA4LQK+LXj5
         OIfP6U/vawOHxt5PQWHHXXa2Bu7qZ9YeTb7tL1rqRAoGOnzM/CYVMbZxIxO+9v/aWJ6i
         ekuSF5b5q3eSbzya25tsWk+YGjKY6YTU5Q7tXquyhArzHHMO5D71/ygDfxdWAQwLFXXX
         c6q9ICrMwJtK2sntuWQly3NWEIFELdB9aTQ+FKhhz+G9Ga/V/XANTz+rcUfP5fXIe4dt
         jDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7zPb9FQ20/SoAUVK7Nq9S40W9S5lPi5XKxOe4b1japQ=;
        b=kcl+4t8GSbPbFRrMnG/atzppZ3vic2qPMFD2Yl2JAW/1z8pFe+tb0zt7cF30g0FyfU
         dXdsllYySBhWw4lCCRPMLIoTwuq2/oozmzZdbXLP2GSpYrYkTISsdgh5q1Eiq/kevRq/
         j/tscKnacEy+F4asFblOLCNWwyMM3YMoX7YSov113/szyLYZ34IZ4P2r/JXBHDxY+mvk
         5cuLd+b/X44WJm05d7NHUbBqJ01nXtUUDvy+fmmymhOpxa0pLA+CpLO7fwv3Bu/+ugqP
         ZfgZzXsjX97CakRmauUX7yvdikNCtVXrJt/Ak83gSHNSk84M2SyjxxsLfofXjYgfskzH
         0maQ==
X-Gm-Message-State: AOAM532nXOCqO29PXZJV2p34x77by8k/SS99SNWGPbHIZ2CG/ANDJh64
        +HQ203wlZr3utZr5SL0j1ylmjS4xXUij+cNgMSM=
X-Google-Smtp-Source: ABdhPJzv5pre9Riyw/rHYcUd1TRndQiRZbCRgYh+W/FEk9/YCIJ97l1lQWi4Jpi85smLHLmL8BSo5tpXPn4YDguuVH4=
X-Received: by 2002:a05:6214:224d:: with SMTP id c13mr5201789qvc.37.1634724540084;
 Wed, 20 Oct 2021 03:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com> <CALAqxLVgQ6QEThWaN65nOW9F_XCh7885n9RigAQDU+OgDntS5g@mail.gmail.com>
 <6b715fb7-9850-04f3-4ab8-1a2a8a2cdfbf@gmail.com> <CALAqxLWgw8tA1Lrg27JUUFrGWCQqPQXmhjHyjsTRA5a4qingkg@mail.gmail.com>
 <95c1a031-6751-f90f-d003-b74fbec0e9d8@gmail.com> <CALAqxLVcc9nscuWT-qFH=JbatVL0c5AxH5B9y3qE1ekG=BZ0aA@mail.gmail.com>
 <61381153-634e-489b-848f-7077ce46049a@bytedance.com> <CALAqxLUJeF1NFAzvp2ubRizbJV-ws09P6x=5nzSz7_VmMAQLNA@mail.gmail.com>
In-Reply-To: <CALAqxLUJeF1NFAzvp2ubRizbJV-ws09P6x=5nzSz7_VmMAQLNA@mail.gmail.com>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Wed, 20 Oct 2021 06:09:58 -0400
Message-ID: <CAJRGBZz6dF=AADKMFwUodm2WeDyTvBw0XxnQdeJwPLs2=sLLEw@mail.gmail.com>
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     John Stultz <john.stultz@linaro.org>
Cc:     yanghui <yanghui.def@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 1:04 AM John Stultz <john.stultz@linaro.org> wrote:
>
> On Mon, Oct 18, 2021 at 9:14 PM yanghui <yanghui.def@bytedance.com> wrote=
:
> > =E5=9C=A8 2021/10/19 =E4=B8=8A=E5=8D=8812:14, John Stultz =E5=86=99=E9=
=81=93:
> > > On Tue, Oct 12, 2021 at 1:06 AM brookxu <brookxu.cn@gmail.com> wrote:
> > >> John Stultz wrote on 2021/10/12 13:29:
> > >>> On Mon, Oct 11, 2021 at 10:23 PM brookxu <brookxu.cn@gmail.com> wro=
te:
> > >>>> John Stultz wrote on 2021/10/12 12:52 =E4=B8=8B=E5=8D=88:
> > >>>>> On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gmail.com> wro=
te:
> > >>>> If we record the watchdog's start_time in clocksource_start_watchd=
og(), and then
> > >>>> when we verify cycles in clocksource_watchdog(), check whether the=
 clocksource
> > >>>> watchdog is blocked. Due to MSB verification, if the blocked time =
is greater than
> > >>>> half of the watchdog timer max_cycles, then we can safely ignore t=
he current
> > >>>> verification? Do you think this idea is okay?
> > >>>
> > >>> I can't say I totally understand the idea. Maybe could you clarify =
with a patch?
> > >>>
> > >>
> > >> Sorry, it looks almost as follows:
> > >>
> > >> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> > >> index b8a14d2..87f3b67 100644
> > >> --- a/kernel/time/clocksource.c
> > >> +++ b/kernel/time/clocksource.c
> > >> @@ -119,6 +119,7 @@
> > >>   static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
> > >>   static DEFINE_SPINLOCK(watchdog_lock);
> > >>   static int watchdog_running;
> > >> +static unsigned long watchdog_start_time;
> > >>   static atomic_t watchdog_reset_pending;
> > >>
> > >>   static inline void clocksource_watchdog_lock(unsigned long *flags)
> > >> @@ -356,6 +357,7 @@ static void clocksource_watchdog(struct timer_li=
st *unused)
> > >>          int next_cpu, reset_pending;
> > >>          int64_t wd_nsec, cs_nsec;
> > >>          struct clocksource *cs;
> > >> +       unsigned long max_jiffies;
> > >>          u32 md;
> > >>
> > >>          spin_lock(&watchdog_lock);
> > >> @@ -402,6 +404,10 @@ static void clocksource_watchdog(struct timer_l=
ist *unused)
> > >>                  if (atomic_read(&watchdog_reset_pending))
> > >>                          continue;
> > >>
> > >> +               max_jiffies =3D nsecs_to_jiffies(cs->max_idle_ns);
> > >> +               if (time_is_before_jiffies(watchdog_start_time + max=
_jiffies))
> > >> +                       continue;
> > >> +
> > >
> > > Sorry, what is the benefit of using jiffies here?   Jiffies are
> > > updated by counting the number of tick intervals on the current
> > > clocksource.
> > >
> > > This seems like circular logic, where we're trying to judge the
> > > current clocksource by using something we derived from the current
> > > clocksource.
> > > That's why the watchdog clocksource is important, as it's supposed to
> > > be a separate counter that is more reliable (but likely slower) then
> > > the preferred clocksource.
> > >
> > > So I'm not really sure how this helps.
> > >
> > > The earlier patch by yanghui at least used the watchdog interval to
> > > decide if the watchdog timer had expired late. Which seemed
> > > reasonable, but I thought it might be helpful to add some sort of a
> > > counter so if the case is happening repeatedly (timers constantly
> > > being delayed) we have a better signal that the watchdog and current
> > > clocksource are out of sync.  Because again, timers are fired based o=
n
> >
> > I think only have a signal ls not enough. we need to prevent
> > clocksource from being incorrectly switched.
>
> Right, but we also have to ensure that we also properly disqualify
> clocksources that are misbehaving.
>
> In the case that the current clocksource is running very slow (imagine
> old TSCs that lowered freq with cpufreq), then system time slows down,
> so timers fire late.
> So it would constantly seem like the irqs are being delayed, so with
> your logic we would not disqualify a clearly malfunctioning
> clocksource..
>
> > The Timer callback function clocksource_watchdog() is executed in the
> > context of softirq(run_timer_softirq()). So if softirq is disabled for
> > long time(One situation is long time softlockup), clocksource_watchdog(=
)
> > will be delay executed.
>
> Yes. The reality is that timers are often spuriously delayed. We don't
> want a short burst of timer misbehavior to disqualify a good
> clocksource.
>
> But the problem is that this situation and the one above (with the
> freq changing TSC), will look exactly the same.
>
> So having a situation where if the watchdog clocksource thinks too
> much time has passed between watchdog timers, we can skip judgement,
> assuming its a spurious delay. But I think we need to keep a counter
> so that if this happens 3-5 times in a row, we stop ignoring the
> misbehavior and judge the current clocksource, as it may be running
> slowly.
>
> > >
> > I think it will be better to add this to my patch:
> >   /*
> >    * Interval: 0.5sec.
> > - * MaxInterval: 1s.
> > + * MaxInterval: 20s.
> >    */
> >   #define WATCHDOG_INTERVAL (HZ >> 1)
> > -#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
> > +#define WATCHDOG_MAX_INTERVAL_NS (20 * NSEC_PER_SEC)
> >
>
> Some watchdog counters wrap within 20 seconds, so I don't think this
> is a good idea.
>
> The other proposal to calculate the error rate, rather than a fixed
> error boundary might be useful too, as if the current clocksource and
> watchdog are close, a long timer delay won't disqualify them if we
> scale the error bounds to be within an given error rate.

In most of tsc unstable trouble shooting on modern servers we experienced,
it usually ends up in a false alarm triggered by the  clock source
watchdog for tsc.

I think Paul has a proposal to make a clock source watchdog to be more
intelligent.
Its job is to find a real problem instead of causing a problem.

so disabling it for known good-tsc might be a reasonable good idea
that can save manpower for other
more valuable problems to solve, or at least make it statistically a
problem less chance to happen.
>
> thanks
> -john
