Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C86447CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbhKHJYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbhKHJYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:24:02 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A36C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 01:21:18 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id gh1so11475909qvb.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 01:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44pYJW76BNvqnwNFsAADAvCHu/ye4pCtZSvD5oLz7Vo=;
        b=man9nIqCDwUVnQNAWgFdoB2KVK30SLTwTXmMoapBLTbDq7xcZqKx6iuNWv0W+05VyH
         awidQxm+pD/aU3/NxEJLPifZURF93KlhwJyoHd07aT8amXcsz+SgEf4ZvoeJgHhp3bB5
         jfmyqjtalwH/1IngvKdVR5VGSnEzU9aESvbJLoEJE7+GiKiyzOtzwi0i0EkJGlgar6ik
         h/CM27NsL+AwRGpJEXUUFBn8qJJt7D0HiN0GpTE4nOmiPARCD8ipDO5skB6QJ0Fm0MgA
         UsJhTs1bU2/5FPyn/T3qhHe2r4IHbiwQAL4cgjBLrVSZg3VysUsT9/OhlpmTi1uWu2FV
         GRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44pYJW76BNvqnwNFsAADAvCHu/ye4pCtZSvD5oLz7Vo=;
        b=cCcIR4GVuqzerG90h9AhHtC8r8K2Gne7vDWr+eikcuE4AHFMFc5wMbqr32ye9OlTGr
         4XOzY5MFik19ujNdqGnfpFLMPS8yf4rVevCF5Y0A4UxiQ56q4nqC6seGXzPu0VUnHvPF
         Dhn/WbS2FpkiZ775sHFG68o3MCenmPAKY2E13OuD0NrfgC8l8t3HGXuys5WmMDsw5KYg
         vXQMnlKBjSaK1EYkXENKIVG9TecEJ7NwUvQm4/YYuT6v/mCN/28c9ABS5O2gFHKfDwlh
         RbBYEBmLpyNikCVaXdo5DRydzdOlm1Li53jP9H8OV6JXOw03QoFfjYVHBFYkDFDdTsFw
         6cmw==
X-Gm-Message-State: AOAM530dd1TFapBGaq8c18fRrqOV/LpNGANAUzlNfbWPZarLCuEHmioH
        XA19Ws1VCYM4Z8oi5oSmuZFVS8u+CVQACSzG7wg=
X-Google-Smtp-Source: ABdhPJz03DiS70ytD4xBMmawGUMpmbGTktECHfQ7kfsODxQJO4onqlNyaKjiORHRtVwTOUSd5u1CvlhbZZD5dwMEx0w=
X-Received: by 2002:a05:6214:d8e:: with SMTP id e14mr17462332qve.37.1636363277093;
 Mon, 08 Nov 2021 01:21:17 -0800 (PST)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org> <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
 <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com>
 <78b3f72b-3fe7-f2e0-0e6b-32f28b8ce777@arm.com> <CAGWkznF_8iBp57BPoQKvG4VuNYep=g+ZxgO7D4e0wMDLipJ8uw@mail.gmail.com>
 <85c81ab7-49ed-aba5-6221-ea6a8f37f8ad@arm.com> <CAB8ipk_0YxWnS-k+HLPnL7DRR1MM+WH-xQfna7jD_+TQ0vKi8Q@mail.gmail.com>
In-Reply-To: <CAB8ipk_0YxWnS-k+HLPnL7DRR1MM+WH-xQfna7jD_+TQ0vKi8Q@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 8 Nov 2021 17:20:56 +0800
Message-ID: <CAGWkznGNb2X_V1ppD2AjBxaKrey_A7U==XO_bnXoNAh2emLs8A@mail.gmail.com>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xuewen.yan@unisoc.com, Ke Wang <Ke.Wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 4:49 PM Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>
> Hi Dietmar
>
> On Sat, Nov 6, 2021 at 1:20 AM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
> >
> > On 05/11/2021 06:58, Zhaoyang Huang wrote:
> > >> I don't understand the EAS (probably asymmetric CPU capacity is meant
> > >> here) angle of the story. Pressure on CPU capacity which is usable for
> > >> CFS happens on SMP as well?
> > >  Mentioning EAS here mainly about RT tasks preempting small CFS tasks
> > > (big CFS tasks could be scheduled to big core), which would introduce
> > > more proportion of preempted time within PSI_MEM_STALL than SMP does.
> >
> > What's your CPU layout? Do you have the little before the big CPUs? Like
> > Hikey 960?
> >
> > root@linaro-developer:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
> > 462
> > 462
> > 462
> > 462
> > 1024
> > 1024
> > 1024
> > 1024
> >
> > And I guess rt class prefers lower CPU numbers hence you see this?
> >
> our CPU layout is:
> xuewen.yan:/ # cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 544
> 544
> 544
> 544
> 544
> 544
> 1024
> 1024
>
> And in our platform, we use the kernel in mobile phones with Android.
> And we prefer power, so we prefer the RT class to run on little cores.
>
>
> > >>
> > >> This will let the idle task (swapper) pass. Is this indented? Or do you
> > >> want to only let CFS tasks (including SCHED_IDLE) pass?
> > > idle tasks will NOT call psi_memstall_xxx. We just want CFS tasks to
> > > scale the STALL time.
> >
> > Not sure I  get this.
> >
> > __schedule() -> psi_sched_switch() -> psi_task_change() ->
> > psi_group_change() -> record_times() -> psi_memtime_fixup()
> >
> > is something else than calling psi_memstall_enter() or _leave()?
> >
> > IMHO, at least record_times() can be called with current equal
> > swapper/X. Or is it that PSI_MEM_SOME is never set for the idle task in
> > this callstack? I don't know the PSI internals.
According to my understanding, PSI_MEM_SOME represents the CORE's
state within which there is at least one task trapped in memstall
path(only counted in by calling PSI_MEMSTALL_ENTER). record_times is
responsible for collecting the delta time of the CORE since it start.
What we are doing is to make the delta time more precise. So idle task
is irrelevant for these.

> >
> > >>
> > >> if (current->sched_class != &fair_sched_class)
> > >>     return growth_fixed;
> > >>
> > >>>>>> +
> > >>>>>> +     if (current->in_memstall)
> > >>>>>> +             growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> > >>>>>> +                                     - rq->avg_irq.util_avg + 1) * growth, 1024);
> > >>>>>> +
> > >>
> > >> We do this slightly different in scale_rt_capacity() [fair.c]:
> > >>
> > >> max = arch_scale_cpu_capacity(cpu_of(rq) /* instead of 1024 to support
> > >>                                             asymmetric CPU capacity */
> > > Is it possible that the SUM of rqs' util_avg large than
> > > arch_scale_cpu_capacity because of task migration things?
> >
> > I assume you meant if the rq (cpu_rq(CPUx)) util_avg sum (CFS, RT, DL,
> > IRQ and thermal part) can be larger than arch_scale_cpu_capacity(CPUx)?
> >
> > Yes it can.
> >
> > Have a lock at
> >
> > effective_cpu_util(..., max, ...) {
> >
> >   if (foo >= max)
> >     return max;
> >
> > }
> >
> > Even the CFS part (cpu_rq(CPUx)->cfs.avg.util_avg) can be larger than
> > the original cpu capacity (rq->cpu_capacity_orig).
> >
> > Have a look at cpu_util(). capacity_orig_of(CPUx) and
> > arch_scale_cpu_capacity(CPUx) both returning rq->cpu_capacity_orig.
> >
>
> Well, your means is we should not use the 1024 and should use the
> original cpu capacity?
> And maybe use the "sched_cpu_util()" is a good choice just like this:
>
> +       if (current->in_memstall)
> +               growth_fixed = div64_ul(cpu_util_cfs(rq) * growth,
> sched_cpu_util(rq->cpu, capacity_orig_of(rq->cpu)));
>
> Thanks!
>
> BR
> xuewen
