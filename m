Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E5744BB51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 06:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhKJFju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 00:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKJFjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 00:39:46 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88195C061767
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 21:36:59 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id y26so3117008lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 21:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zcX1ef8v4+GqxdMyQ+IPlbHORR9ZeSP0Dh2u9Ax2y8=;
        b=FgO26LrTjzGM5BvVPfuHRSTAi5yDrSozFO4pxxHUmJ53mVGntZazCHpRVD+HkonMEj
         vBY9OU5mdGmEEksVtedcUpkHlrNgOSHnfy4K81OvC+WW5VS6F9xtKWVeL6737N+NpvXu
         yTmkVVPWCVsp200M4jwHQp9ooWSth1ncqFJu5HQeraGAiF0Hv8Ps9mTJGwRvGjf2IAOi
         1F8sULnwbrCQapwRX/ne0E290otcQ/8z7zVxc14zUAr6rqp223fvnYaeuM3pWUlKN+Qz
         WNi9PFoI5Y9p3713rca3r0G0R498DsH/pprwYBpB35DRHJD6L71D2p6FSqwU8FJoGb/C
         zFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zcX1ef8v4+GqxdMyQ+IPlbHORR9ZeSP0Dh2u9Ax2y8=;
        b=Kk0AbK5kSfgDwhUTC56xPnYdQ1kJ7etj3PqxIUB9ubAeVj3kR7Qli/6DSIT/xSioXY
         rgDoTqbPVmf1MF0+bVGcFBKtiPJm3j9AJSQBxKFeY7PrsGVAAd2rnSBDZ08nY5Wqc6lm
         S+3ZE/Gc8ozF/LXKn/UwOhhliU5h2TlFOuZjn5UaTze8x9CvDkyPBrB0042Vs5X0qWzi
         C3IbuTghUV5/IwMhLgr49qNoJ3OPsryk3Zq2qSLJUuqe81G/qYxuzUOxmX4cLbYUVWvD
         Dp+hvDRINkkfv8jxKeWrBov+rLQwRz4DiQQB9vl2+eCFN/0lgNsE9vK/J0h+EsAL6vT+
         rlWQ==
X-Gm-Message-State: AOAM531vIVdttjxOlM4RaLOHEiDrjsjbUt2IYKeIpjHGELA20Py58oAo
        zYXU15gD55AI3EskkWe+jIdEAlGlaYUM5S4wvUejz83evnw=
X-Google-Smtp-Source: ABdhPJxk7jccrFAvVJAGbUivIgZMky6GwtU2K1Zkgx97uTwpjslqEvS5rkPvkIren9bVkTECQmJepn+zXnO53tcW59g=
X-Received: by 2002:ac2:442e:: with SMTP id w14mr12548128lfl.577.1636522617826;
 Tue, 09 Nov 2021 21:36:57 -0800 (PST)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org> <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
 <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com>
 <78b3f72b-3fe7-f2e0-0e6b-32f28b8ce777@arm.com> <CAGWkznF_8iBp57BPoQKvG4VuNYep=g+ZxgO7D4e0wMDLipJ8uw@mail.gmail.com>
 <85c81ab7-49ed-aba5-6221-ea6a8f37f8ad@arm.com> <CAB8ipk_0YxWnS-k+HLPnL7DRR1MM+WH-xQfna7jD_+TQ0vKi8Q@mail.gmail.com>
 <05a2e61e-9c55-8f8d-5e72-9854613e53c9@arm.com>
In-Reply-To: <05a2e61e-9c55-8f8d-5e72-9854613e53c9@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 10 Nov 2021 13:36:45 +0800
Message-ID: <CAB8ipk-r0LOudU7+ijVGS5mu2stKY8DBZ3BhKfbFcOgZj2VaQA@mail.gmail.com>
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
On Tue, Nov 9, 2021 at 5:43 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 08/11/2021 09:49, Xuewen Yan wrote:
> > Hi Dietmar
> >
> > On Sat, Nov 6, 2021 at 1:20 AM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 05/11/2021 06:58, Zhaoyang Huang wrote:
> >>>> I don't understand the EAS (probably asymmetric CPU capacity is meant
> >>>> here) angle of the story. Pressure on CPU capacity which is usable for
> >>>> CFS happens on SMP as well?
> >>>  Mentioning EAS here mainly about RT tasks preempting small CFS tasks
> >>> (big CFS tasks could be scheduled to big core), which would introduce
> >>> more proportion of preempted time within PSI_MEM_STALL than SMP does.
> >>
> >> What's your CPU layout? Do you have the little before the big CPUs? Like
> >> Hikey 960?
>
> [...]
>
> >> And I guess rt class prefers lower CPU numbers hence you see this?
> >>
> > our CPU layout is:
> > xuewen.yan:/ # cat /sys/devices/system/cpu/cpu*/cpu_capacity
> > 544
> > 544
> > 544
> > 544
> > 544
> > 544
> > 1024
> > 1024
> >
> > And in our platform, we use the kernel in mobile phones with Android.
> > And we prefer power, so we prefer the RT class to run on little cores.
>
> Ah, OK, out-of-tree extensions.
>
> [...]
>
> >>>>>>>> +     if (current->in_memstall)
> >>>>>>>> +             growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> >>>>>>>> +                                     - rq->avg_irq.util_avg + 1) * growth, 1024);
> >>>>>>>> +
> >>>>
> >>>> We do this slightly different in scale_rt_capacity() [fair.c]:
> >>>>
> >>>> max = arch_scale_cpu_capacity(cpu_of(rq) /* instead of 1024 to support
> >>>>                                             asymmetric CPU capacity */
> >>> Is it possible that the SUM of rqs' util_avg large than
> >>> arch_scale_cpu_capacity because of task migration things?
> >>
> >> I assume you meant if the rq (cpu_rq(CPUx)) util_avg sum (CFS, RT, DL,
> >> IRQ and thermal part) can be larger than arch_scale_cpu_capacity(CPUx)?
> >>
> >> Yes it can.
> >>
> >> Have a lock at
> >>
> >> effective_cpu_util(..., max, ...) {
> >>
> >>   if (foo >= max)
> >>     return max;
> >>
> >> }
> >>
> >> Even the CFS part (cpu_rq(CPUx)->cfs.avg.util_avg) can be larger than
> >> the original cpu capacity (rq->cpu_capacity_orig).
> >>
> >> Have a look at cpu_util(). capacity_orig_of(CPUx) and
> >> arch_scale_cpu_capacity(CPUx) both returning rq->cpu_capacity_orig.
> >>
> >
> > Well, your means is we should not use the 1024 and should use the
> > original cpu capacity?
> > And maybe use the "sched_cpu_util()" is a good choice just like this:
> >
> > +       if (current->in_memstall)
> > +               growth_fixed = div64_ul(cpu_util_cfs(rq) * growth,
> > sched_cpu_util(rq->cpu, capacity_orig_of(rq->cpu)));
>
> Not sure about this. In case util_cfs=0 you would get scale=0.

Yes , we should consider it. In addition, it also should be considered
when util_cfs > capacity_orig because of the UTIL_EST......

>
> IMHO, you need
>
> cap      = rq->cpu_capacity
> cap_orig = rq->cpu_capacity_orig
>
> scale = (cap * X) / cap_orig
>
> or if the update of these rq values happens to infrequently for you then
> you have to calc the pressure evey time. Something like:
>
> pressure = cpu_util_rt(rq) + cpu_util_dl(rq)
>
> irq = cpu_util_irq(rq)
>
> if (irq >= cap_orig)
>     pressure = cap_orig
> else
>     pressure = scale_irq_capacity(pressure, irq, cap_orig)
>     pressure += irq
>
> scale = ((cap_orig - pressure) * X) / cap_orig

Why rescale the util there, the sched_cpu_util() would invoke the
effective_cpu_util(), and I don't think it's necessary to rescale it.

Thanks!
