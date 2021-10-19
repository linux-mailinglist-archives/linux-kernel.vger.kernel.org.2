Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2F432D01
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhJSFDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhJSFDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:03:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE7AC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:00:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x192so4589011lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ald5aOE/eLEOjW+mB09MNBV06JQd0hyxn3aC+k1ZC20=;
        b=mS/r+syvgtfoHnxmXjTch5p1F5iqX+cuj6weUMIN3K1G1EQx68mo5AipqYtynNGdjw
         n5Raol9Fz48xdhI1JHQYISQ5CzW/Pg66UGQ7D7kGRgmw1iMslRZ1k8/Fh4wLRKpKlBnf
         aoTuKeAL6U8lx5LSKCnpihT9R+M8uW4OcfVYv/HTxhngDq+HZjIamULMvwXtuVlmKros
         zVraIqGY8U2/CZn3wzOxnQBRvHbJTjeiD1GLCwac+hrS8xgUjp37/6aDgH8BgAylVteZ
         XW5ACpupK/lcPvHaZ0otEAlKsjGB7zvQLtZ+4k5MgbSQPEOztlIYtRQnTRMbvvG9ciOR
         +k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ald5aOE/eLEOjW+mB09MNBV06JQd0hyxn3aC+k1ZC20=;
        b=t5rn/rV/qjfsvj+Jq2NeVXz+BTBLgKQHPOwTBLLdv2BZxbg6l7Yja21gh2yGIzBbbR
         40CT+7HO0DlFf/tapCm9+9NAy/MZTDzhliJqKbEb4ExwuGPde1bWbL6+lNrKONmtVoMH
         a6xVbUcgS9rQKpZNWQ1sRphG3mWoIZsTgm3bZqPdwjm8hLUYbC2JAEJTASTJkjqSCTxP
         +Cz0u+txewk05355hS400aFPCeGNR3Qz3UVEIMJGUgLlDEHlC74PKyyTIisJ85leqk8H
         /+0WW2CAP52XatdL4LuVgJqb4s1jGUtBMqT7D/jzbMjTt9EiZ+s1+Df+HpbWsc3fY7x0
         1q4w==
X-Gm-Message-State: AOAM531zyMIPClGIkn+uFDDWEJVduaiozxLSOSiKhZpzfN9mF7wZzztC
        Du8FW6UMeEvNzzWlqEnSHyUHPCAWQSx5a9QhwaCT0w==
X-Google-Smtp-Source: ABdhPJyMw/0iRcu6ejI52FI7thrq/5UbCDbiG1ZwDkM9N/r7EvAT9PRQist0i1Ud/k0cW7w2FZrhM3ZQ+g+aRnntd+A=
X-Received: by 2002:a05:6512:3191:: with SMTP id i17mr3916420lfe.485.1634619648050;
 Mon, 18 Oct 2021 22:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211008080305.13401-1-yanghui.def@bytedance.com>
 <CALAqxLWUNFozhfhuVFAPo9xGgO+xsXPQ=i5w1Y0E9-w-PdHXgw@mail.gmail.com>
 <c70a418d-4748-6876-ac8a-c9d1b7e94e78@gmail.com> <CALAqxLVgQ6QEThWaN65nOW9F_XCh7885n9RigAQDU+OgDntS5g@mail.gmail.com>
 <6b715fb7-9850-04f3-4ab8-1a2a8a2cdfbf@gmail.com> <CALAqxLWgw8tA1Lrg27JUUFrGWCQqPQXmhjHyjsTRA5a4qingkg@mail.gmail.com>
 <95c1a031-6751-f90f-d003-b74fbec0e9d8@gmail.com> <CALAqxLVcc9nscuWT-qFH=JbatVL0c5AxH5B9y3qE1ekG=BZ0aA@mail.gmail.com>
 <61381153-634e-489b-848f-7077ce46049a@bytedance.com>
In-Reply-To: <61381153-634e-489b-848f-7077ce46049a@bytedance.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 18 Oct 2021 22:00:36 -0700
Message-ID: <CALAqxLUJeF1NFAzvp2ubRizbJV-ws09P6x=5nzSz7_VmMAQLNA@mail.gmail.com>
Subject: Re: [PATCH] Clocksource: Avoid misjudgment of clocksource
To:     yanghui <yanghui.def@bytedance.com>
Cc:     brookxu <brookxu.cn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 9:14 PM yanghui <yanghui.def@bytedance.com> wrote:
> =E5=9C=A8 2021/10/19 =E4=B8=8A=E5=8D=8812:14, John Stultz =E5=86=99=E9=81=
=93:
> > On Tue, Oct 12, 2021 at 1:06 AM brookxu <brookxu.cn@gmail.com> wrote:
> >> John Stultz wrote on 2021/10/12 13:29:
> >>> On Mon, Oct 11, 2021 at 10:23 PM brookxu <brookxu.cn@gmail.com> wrote=
:
> >>>> John Stultz wrote on 2021/10/12 12:52 =E4=B8=8B=E5=8D=88:
> >>>>> On Sat, Oct 9, 2021 at 7:04 AM brookxu <brookxu.cn@gmail.com> wrote=
:
> >>>> If we record the watchdog's start_time in clocksource_start_watchdog=
(), and then
> >>>> when we verify cycles in clocksource_watchdog(), check whether the c=
locksource
> >>>> watchdog is blocked. Due to MSB verification, if the blocked time is=
 greater than
> >>>> half of the watchdog timer max_cycles, then we can safely ignore the=
 current
> >>>> verification? Do you think this idea is okay?
> >>>
> >>> I can't say I totally understand the idea. Maybe could you clarify wi=
th a patch?
> >>>
> >>
> >> Sorry, it looks almost as follows:
> >>
> >> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> >> index b8a14d2..87f3b67 100644
> >> --- a/kernel/time/clocksource.c
> >> +++ b/kernel/time/clocksource.c
> >> @@ -119,6 +119,7 @@
> >>   static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
> >>   static DEFINE_SPINLOCK(watchdog_lock);
> >>   static int watchdog_running;
> >> +static unsigned long watchdog_start_time;
> >>   static atomic_t watchdog_reset_pending;
> >>
> >>   static inline void clocksource_watchdog_lock(unsigned long *flags)
> >> @@ -356,6 +357,7 @@ static void clocksource_watchdog(struct timer_list=
 *unused)
> >>          int next_cpu, reset_pending;
> >>          int64_t wd_nsec, cs_nsec;
> >>          struct clocksource *cs;
> >> +       unsigned long max_jiffies;
> >>          u32 md;
> >>
> >>          spin_lock(&watchdog_lock);
> >> @@ -402,6 +404,10 @@ static void clocksource_watchdog(struct timer_lis=
t *unused)
> >>                  if (atomic_read(&watchdog_reset_pending))
> >>                          continue;
> >>
> >> +               max_jiffies =3D nsecs_to_jiffies(cs->max_idle_ns);
> >> +               if (time_is_before_jiffies(watchdog_start_time + max_j=
iffies))
> >> +                       continue;
> >> +
> >
> > Sorry, what is the benefit of using jiffies here?   Jiffies are
> > updated by counting the number of tick intervals on the current
> > clocksource.
> >
> > This seems like circular logic, where we're trying to judge the
> > current clocksource by using something we derived from the current
> > clocksource.
> > That's why the watchdog clocksource is important, as it's supposed to
> > be a separate counter that is more reliable (but likely slower) then
> > the preferred clocksource.
> >
> > So I'm not really sure how this helps.
> >
> > The earlier patch by yanghui at least used the watchdog interval to
> > decide if the watchdog timer had expired late. Which seemed
> > reasonable, but I thought it might be helpful to add some sort of a
> > counter so if the case is happening repeatedly (timers constantly
> > being delayed) we have a better signal that the watchdog and current
> > clocksource are out of sync.  Because again, timers are fired based on
>
> I think only have a signal ls not enough. we need to prevent
> clocksource from being incorrectly switched.

Right, but we also have to ensure that we also properly disqualify
clocksources that are misbehaving.

In the case that the current clocksource is running very slow (imagine
old TSCs that lowered freq with cpufreq), then system time slows down,
so timers fire late.
So it would constantly seem like the irqs are being delayed, so with
your logic we would not disqualify a clearly malfunctioning
clocksource..

> The Timer callback function clocksource_watchdog() is executed in the
> context of softirq(run_timer_softirq()). So if softirq is disabled for
> long time(One situation is long time softlockup), clocksource_watchdog()
> will be delay executed.

Yes. The reality is that timers are often spuriously delayed. We don't
want a short burst of timer misbehavior to disqualify a good
clocksource.

But the problem is that this situation and the one above (with the
freq changing TSC), will look exactly the same.

So having a situation where if the watchdog clocksource thinks too
much time has passed between watchdog timers, we can skip judgement,
assuming its a spurious delay. But I think we need to keep a counter
so that if this happens 3-5 times in a row, we stop ignoring the
misbehavior and judge the current clocksource, as it may be running
slowly.

> >
> I think it will be better to add this to my patch:
>   /*
>    * Interval: 0.5sec.
> - * MaxInterval: 1s.
> + * MaxInterval: 20s.
>    */
>   #define WATCHDOG_INTERVAL (HZ >> 1)
> -#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
> +#define WATCHDOG_MAX_INTERVAL_NS (20 * NSEC_PER_SEC)
>

Some watchdog counters wrap within 20 seconds, so I don't think this
is a good idea.

The other proposal to calculate the error rate, rather than a fixed
error boundary might be useful too, as if the current clocksource and
watchdog are close, a long timer delay won't disqualify them if we
scale the error bounds to be within an given error rate.

thanks
-john
