Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63137447C3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbhKHIwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhKHIwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:52:37 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2336BC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 00:49:53 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o18so34382233lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 00:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NC6D/WS8Gp+h4dIR9Catgw+sLa+kzIQU0LzOCWmVhrM=;
        b=LujYT2JCFGjdzk+2fC32ggQUDjKXizNOHdnxDLypoRVtzT8GLM6W8KkS6bBtKiaJ3s
         CZ8D7mKp2MBmyNj4YkpNemsaT57xYF1ax7w/8RZ3y6NmY259gAE3PMY66Lmpu94VBpry
         m/pKTKHdZU/F9HF/1y8PFQzkNmrj2wIXSBqI3GmXgB7xhzSGeKw0PAGPeJUunedLQikp
         7rT4teXIU1RNvZ3jaEi1bH8c1sV0z5TJTlISfXNli/w+p+PQXhY4sare/g1TaS+B3C4j
         44Y6+koNk1hbKRG/tz3XkfcZTPuqeKHJx5eKC2rklzBZ2CjfsCUyhaGOvKf4VeAxy8/q
         Lxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NC6D/WS8Gp+h4dIR9Catgw+sLa+kzIQU0LzOCWmVhrM=;
        b=5xlAYZx7wNQ9drrXO2sqvd1b3V4K/iOmErLVOBOFl1VvA3edCnN6HkXiuNxOh8QuWu
         i95TpzNIiBB5uDu6YcufiMOmM+ZOdDpwBWgoYY/YD3LB5gJG/OSyu5hRUuuFm5TmBAaa
         AiRms2ZYAW957G+ZmWLNb3/YmlPLG1kLzaC/l1aenzZNdKhxRC6Wr3mtTPIMbgya9zly
         M2KCcnEBGdbwL4AzY+R/qUEflm8xHxFPo67K9gGQWE89odQ7QMrIBH686sUgl0B4zbu/
         jiDYw1huSHlrJROi0ose6eBCsXnfnE+XmVtQ2nUaDhfiWNO2U+hOTHLDmLXw8rnTYfpo
         Ya2A==
X-Gm-Message-State: AOAM530TMHi2zu6aip6US5u7BnKx7SbNrrLxwE/t9REm8UYRnmqWTG4Y
        zDaJtoMCx6nYXVnQfTKqPJ4sNlUP9m33DeAWam47wX1LrDM=
X-Google-Smtp-Source: ABdhPJwF3MCEgKFj4vvWPPbdNitPH62GPP/UPjjYD5+dZE6phEdbsCi7+BY69kIc8vwarxzNSoJq4rm3fdNHb27Kou8=
X-Received: by 2002:a05:6512:2346:: with SMTP id p6mr39368133lfu.503.1636361391539;
 Mon, 08 Nov 2021 00:49:51 -0800 (PST)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org> <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
 <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com>
 <78b3f72b-3fe7-f2e0-0e6b-32f28b8ce777@arm.com> <CAGWkznF_8iBp57BPoQKvG4VuNYep=g+ZxgO7D4e0wMDLipJ8uw@mail.gmail.com>
 <85c81ab7-49ed-aba5-6221-ea6a8f37f8ad@arm.com>
In-Reply-To: <85c81ab7-49ed-aba5-6221-ea6a8f37f8ad@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 8 Nov 2021 16:49:39 +0800
Message-ID: <CAB8ipk_0YxWnS-k+HLPnL7DRR1MM+WH-xQfna7jD_+TQ0vKi8Q@mail.gmail.com>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
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

Hi Dietmar

On Sat, Nov 6, 2021 at 1:20 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 05/11/2021 06:58, Zhaoyang Huang wrote:
> >> I don't understand the EAS (probably asymmetric CPU capacity is meant
> >> here) angle of the story. Pressure on CPU capacity which is usable for
> >> CFS happens on SMP as well?
> >  Mentioning EAS here mainly about RT tasks preempting small CFS tasks
> > (big CFS tasks could be scheduled to big core), which would introduce
> > more proportion of preempted time within PSI_MEM_STALL than SMP does.
>
> What's your CPU layout? Do you have the little before the big CPUs? Like
> Hikey 960?
>
> root@linaro-developer:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
> 462
> 462
> 462
> 462
> 1024
> 1024
> 1024
> 1024
>
> And I guess rt class prefers lower CPU numbers hence you see this?
>
our CPU layout is:
xuewen.yan:/ # cat /sys/devices/system/cpu/cpu*/cpu_capacity
544
544
544
544
544
544
1024
1024

And in our platform, we use the kernel in mobile phones with Android.
And we prefer power, so we prefer the RT class to run on little cores.


> >>
> >> This will let the idle task (swapper) pass. Is this indented? Or do you
> >> want to only let CFS tasks (including SCHED_IDLE) pass?
> > idle tasks will NOT call psi_memstall_xxx. We just want CFS tasks to
> > scale the STALL time.
>
> Not sure I  get this.
>
> __schedule() -> psi_sched_switch() -> psi_task_change() ->
> psi_group_change() -> record_times() -> psi_memtime_fixup()
>
> is something else than calling psi_memstall_enter() or _leave()?
>
> IMHO, at least record_times() can be called with current equal
> swapper/X. Or is it that PSI_MEM_SOME is never set for the idle task in
> this callstack? I don't know the PSI internals.
>
> >>
> >> if (current->sched_class != &fair_sched_class)
> >>     return growth_fixed;
> >>
> >>>>>> +
> >>>>>> +     if (current->in_memstall)
> >>>>>> +             growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> >>>>>> +                                     - rq->avg_irq.util_avg + 1) * growth, 1024);
> >>>>>> +
> >>
> >> We do this slightly different in scale_rt_capacity() [fair.c]:
> >>
> >> max = arch_scale_cpu_capacity(cpu_of(rq) /* instead of 1024 to support
> >>                                             asymmetric CPU capacity */
> > Is it possible that the SUM of rqs' util_avg large than
> > arch_scale_cpu_capacity because of task migration things?
>
> I assume you meant if the rq (cpu_rq(CPUx)) util_avg sum (CFS, RT, DL,
> IRQ and thermal part) can be larger than arch_scale_cpu_capacity(CPUx)?
>
> Yes it can.
>
> Have a lock at
>
> effective_cpu_util(..., max, ...) {
>
>   if (foo >= max)
>     return max;
>
> }
>
> Even the CFS part (cpu_rq(CPUx)->cfs.avg.util_avg) can be larger than
> the original cpu capacity (rq->cpu_capacity_orig).
>
> Have a look at cpu_util(). capacity_orig_of(CPUx) and
> arch_scale_cpu_capacity(CPUx) both returning rq->cpu_capacity_orig.
>

Well, your means is we should not use the 1024 and should use the
original cpu capacity?
And maybe use the "sched_cpu_util()" is a good choice just like this:

+       if (current->in_memstall)
+               growth_fixed = div64_ul(cpu_util_cfs(rq) * growth,
sched_cpu_util(rq->cpu, capacity_orig_of(rq->cpu)));

Thanks!

BR
xuewen
