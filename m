Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563FC45E976
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359801AbhKZIhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353341AbhKZIfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:35:40 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0DBC061792
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 00:24:13 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id p8so3755662ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 00:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+3W8vdagLbTNRPFAylCMOvx5SBmZnQyRatYFnnBvgI=;
        b=PkAcmF1arCHVIb3ura2asB/DtB7F6PIY0/REH1dK7SNZ+dImaFIt2Itsy+oN4xMAQN
         Kufzzz6oxEoxNyWadXLkHEcyu4AJo6t3B8P8Tte/k1fuE84nA8o+lDv12YVLHhOGjWoS
         MIE6nbkG53/y8r3109Sagecr+VSqjx2FFRViH0TYhee9rCy3kVCXLm2e7fpoZVEyMjqG
         sTmm1hnJT5XnZG4MXXqJ8/LM2mIiqiYf2/dayXbu4dsDzWdn9Ur7Jn+cAHWk300BwdhA
         vHJLimhyIdekGA+QMxtiCnMiFPjP881/di88/AtGQ8jQ4HD0Ky99OVSZ07YCRxua8eNk
         2IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+3W8vdagLbTNRPFAylCMOvx5SBmZnQyRatYFnnBvgI=;
        b=k8+5bRkmscV1lpWd1u+bjU6FPdW9takAi3TexMd3QGmAuqbIUPPB2q1yESsr6BUFEG
         maH7qu9YXTo/I7lIU6BktJa9iNaQak1CyZt3Hc6b4nn2aNli4yN6ysP8zOwhwYqGp+ye
         9UgxEhA52EBdnFSBNIaC3uN94SexXxMay5wrHYrZoEhDkIVSQJ7Ofgz5kws/TGDPl/YE
         Utt3Vasd5kdZ9swk3Br0/oVhGbarAe3o55je2qHhijJbtNdKcSdej40l+Dr6Jl9rlKZE
         cyJhUBj+SUiyPpUPb87IZChALHWALHJwfDpdCnV0b2fEY30IiotAFBGBaAPzQRJ+iRs0
         7Z7A==
X-Gm-Message-State: AOAM531ko7rr9DWrRHJn6fRQ+jrKpDYubRGfQQfE/qPd4Pp4ursG39Mr
        98e1tC5l2Irs9rWm3DiRDRJz+3QM/8w0TJ84jO5GnQ==
X-Google-Smtp-Source: ABdhPJys9Onf/yd269QUTMsXZRfQTh8QnxOP2HY5QyZGAi+Ox24N9DcupY8WRb8SPA1kN5B2wszkR04d76i4AhCAIfA=
X-Received: by 2002:a2e:b88e:: with SMTP id r14mr29554658ljp.365.1637915051223;
 Fri, 26 Nov 2021 00:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20211124154239.3191366-1-vincent.donnefort@arm.com>
 <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com>
 <8735nkcwov.mognet@arm.com> <CAKfTPtDPskVdEd-KQ_cwe-R_zVFPQOgdbk9x+3eD12pKs8fGFw@mail.gmail.com>
 <87zgpsb6de.mognet@arm.com>
In-Reply-To: <87zgpsb6de.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 26 Nov 2021 09:23:59 +0100
Message-ID: <CAKfTPtCnusWJXJLDEudQ_q8MWaZYbPJK-QjAbBYWFW8Nw-J+Ww@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a task
To:     Valentin Schneider <Valentin.Schneider@arm.com>
Cc:     Vincent Donnefort <Vincent.Donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 at 16:30, Valentin Schneider
<Valentin.Schneider@arm.com> wrote:
>
> On 25/11/21 14:23, Vincent Guittot wrote:
> > On Thu, 25 Nov 2021 at 12:16, Valentin Schneider
> > <Valentin.Schneider@arm.com> wrote:
> >> I think you can still hit this on a symmetric system; let me try to
> >> reformulate my other email.
> >>
> >> If this (non-patched) condition evaluates to true, it means the previous
> >> condition
> >>
> >>   (available_idle_cpu(target) || sched_idle_cpu(target)) &&
> >>    asym_fits_capacity(task_util, target)
> >>
> >> evaluated to false, so for a symmetric system target sure isn't idle.
> >>
> >> prev == smp_processor_id() implies prev == target, IOW prev isn't
> >> idle. Now, consider:
> >>
> >>   p0.prev = CPU1
> >>   p1.prev = CPU1
> >>
> >>   CPU0                     CPU1
> >>   current = don't care     current = swapper/1
> >>
> >>   ttwu(p1)
> >>     ttwu_queue(p1, CPU1)
> >>     // or
> >>     ttwu_queue_wakelist(p1, CPU1)
> >>
> >>                           hrtimer_wakeup()
> >>                             wake_up_process()
> >>                               ttwu()
> >>                                 idle_cpu(CPU1)? no
> >>
> >>                                 is_per_cpu_kthread(current)? yes
> >>                                 prev == smp_processor_id()? yes
> >>                                 this_rq()->nr_running <= 1? yes
> >>                                 => self enqueue
> >>
> >>                           ...
> >>                           schedule_idle()
> >>
> >> This works if CPU0 does either a full enqueue (rq->nr_running == 1) or just
> >> a wakelist enqueue (rq->ttwu_pending > 0). If there was an idle CPU3
> >> around, we'd still be stacking p0 and p1 onto CPU1.
> >>
> >> IOW this opens a window between a remote ttwu() and the idle task invoking
> >> schedule_idle() where the idle task can stack more tasks onto its CPU.
> >
> > Your use case above is out of the scope of this patch and has always
> > been there, even for other per cpu kthreads. In such case, the wake up
> > is not triggered by current (idle or another per cpu kthread) but by
> > an interrupt (hrtimer in your case).
>
> Technically the idle task didn't pass is_per_cpu_kthread(p) when that
> condition was added, this is somewhat of a "new development" - but you're
> right on the hardirq side of things.
>
> > If we want to filter wakeup
> > generated by interrupt context while a per cpu kthread is running, it
> > would be better to fix all cases and test the running context like
> > this
> >
>
> I think that could make sense - though can the idle task issue wakeups in
> process context? If so that won't be sufficient. A quick audit tells me:
>
> o rcu_nocb_flush_deferred_wakeup() happens before calling into cpuidle
> o I didn't see any wakeup issued from the cpu_pm_notifier call chain
> o I'm not entirely sure about flush_smp_call_function_from_idle(). I found
>   this thing in RCU:
>
>   smp_call_function_single(cpu, rcu_exp_handler)
>
>     rcu_exp_handler()
>       rcu_report_exp_rdp()
>         rcu_report_exp_cpu_mult()
>           __rcu_report_exp_rnp()
>             swake_up_one()
>
> IIUC if set_nr_if_polling() then the smp_call won't send an IPI and should be
> handled in that flush_foo_from_idle() call.

Aren't all these planned to wakeup on local cpu  ? so i don't  see any
real problem there

>
> I'd be tempted to stick your VincentD's conditions together, just to be
> safe...

More than safe I would prefer that we fix the correct root cause
instead of hiding it

>
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6397,7 +6397,8 @@ static int select_idle_sibling(struct
> > task_struct *p, int prev, int target)
> >          * essentially a sync wakeup. An obvious example of this
> >          * pattern is IO completions.
> >          */
> > -       if (is_per_cpu_kthread(current) &&
> > +       if (!in_interrupt() &&
> > +           is_per_cpu_kthread(current) &&
> >             prev == smp_processor_id() &&
> >             this_rq()->nr_running <= 1) {
> >                 return prev;
> >
> >>
> >> >
> >> >> --
> >> >> 2.25.1
> >> >>
