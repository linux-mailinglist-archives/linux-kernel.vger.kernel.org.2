Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2918035C3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbhDLK1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:27:11 -0400
Received: from foss.arm.com ([217.140.110.172]:45682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237753AbhDLK1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:27:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A15B1FB;
        Mon, 12 Apr 2021 03:26:51 -0700 (PDT)
Received: from [10.57.59.170] (unknown [10.57.59.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 433C83F694;
        Mon, 12 Apr 2021 03:26:48 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH] sched/fair: use signed long when compute energy delta in
 eas
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ryan Y <xuewyan@foxmail.com>
References: <20210330052154.26861-1-xuewen.yan94@gmail.com>
 <YGLzQAvVqlrKb8AB@google.com> <34ce11ad-9c20-7ba7-90d8-4830725bf38a@arm.com>
 <CAB8ipk9JATYxJBnpVFfH_XHLqh=yHesbo73wx=Mm7t8mSqW_Gg@mail.gmail.com>
 <1ebddd33-4666-1e6e-7788-a3fe28c9e99c@arm.com>
 <CAB8ipk9+fdGMY6cYoHnicPUOdd+meJo+EaGaaVZTgoxQ84+Wiw@mail.gmail.com>
 <d85a1db9-4680-1d31-d3e7-6a081f652c5e@arm.com>
 <CAB8ipk_J-W35+iZqsmAm+VO2=OUXRR3EsW6BuhYmvmBiPcHxMA@mail.gmail.com>
Message-ID: <d80b7b3e-7eb3-4d0a-99fd-167e14ab86bc@arm.com>
Date:   Mon, 12 Apr 2021 11:26:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAB8ipk_J-W35+iZqsmAm+VO2=OUXRR3EsW6BuhYmvmBiPcHxMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> > > > Hi,
> > > > > I test the patch, but the overflow still exists.
> > > > > In the "sched/fair: Use pd_cache to speed up
> > > find_energy_efficient_cpu()"
> > > > > I wonder why recompute the cpu util when cpu==dst_cpu in
> > > compute_energy(),
> > > > > when the dst_cpu's util change, it also would cause the overflow.
> > > >
> > > > The patches aim to cache the energy values for the CPUs whose
> > > > utilization is not modified (so we don't have to compute it multiple
> > > > times). The values cached are the 'base values' of the CPUs, 
> i.e. when
> > > > the task is not placed on the CPU. When (cpu==dst_cpu) in
> > > > compute_energy(), it means the energy values need to be updated 
> instead
> > > > of using the cached ones.
> > > >
> > > well, is it better to use the task_util(p) + cache values ? but in
> > > this case, the cache
> > > values may need more parameters.
> >
> > This patch-set is not significantly improving the execution time of
> > feec(). The results we have so far are an improvement of 5-10% in
> > execution time, with feec() being executed in < 10us. So the gain is not
> > spectacular.
>
> well， I meaned to cache all util value and compute energy with caches, 
> when
> (cpu==dst_cpu), use caches instead of updating util, and do not get
> util with function:
>  "effective_cpu_util()", to compute util with cache.
> I add more parameters into pd_cache:
> struct pd_cache {
>         unsigned long util;
>         unsigned long util_est;
>         unsigned long util_cfs;
>         unsigned long util_irq;
>         unsigned long util_rt;
>         unsigned long util_dl;
>         unsigned long bw_dl;
>         unsigned long freq_util;
>         unsigned long nrg_util;
> };
> In this way, it can avoid util update while feec. I tested with it,
> and the negative delta disappeared.
> Maybe this is not a good method, but it does work.
If I understand correctly, you put all the fields used by 
core.c:effective_cpu_util() in the caches, allowing to have values not 
subject to updates.
core.c:effective_cpu_util() isn't only called from 
fair.c:compute_energy(). It is used in the cpufreq_schedutil.c and 
cpufreq_cooling.c (through core.c:sched_cpu_util()).
Did you have to duplicate core.c:effective_cpu_util() to have a second 
version using the caches ? If yes, I think the function was meant to be 
unique so that all the utilization estimations go through the same path.

If your concern is to avoid negative delta, I think just bailing out 
when this happens should be sufficient. As shown in the last message, 
having a wrong placement should not happen that often, plus the prev_cpu 
should be used which should be ok.
If you want to cache the values, I think a stronger justification will 
be asked: this seems to be a big modification compared to the initial 
issue, knowing that another simpler solution is available (i.e. bailing 
out). I was not able to prove there was a significant gain in the 
find_energy_efficient_cpu() execution time, but I would be happy if you 
can, or if you find other arguments.

> >
> > >
> > > > You are right, there is still a possibility to have a negative delta
> > > > with the patches at:
> > > >
> > > 
> https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integration-20210129 
> <https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integration-20210129>
> > > 
> <https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integration-20210129 
> <https://gitlab.arm.com/linux-arm/linux-power/-/commits/eas/next/integration-20210129>>
> > > > Adding a check before subtracting the values, and bailing out in 
> such
> > > > case would avoid this, such as at:
> > > > 
> https://gitlab.arm.com/linux-arm/linux-pg/-/commits/feec_bail_out/ 
> <https://gitlab.arm.com/linux-arm/linux-pg/-/commits/feec_bail_out/>
> > > 
> <https://gitlab.arm.com/linux-arm/linux-pg/-/commits/feec_bail_out/ 
> <https://gitlab.arm.com/linux-arm/linux-pg/-/commits/feec_bail_out/>>
> > > >
> > > In your patch, you bail out the case by "go to fail", that means you
> > > don't use eas in such
> > > case. However, in the actual scene, the case often occurr when select
> > > cpu for small task.
> > > As a result, the small task would not select cpu according to the eas,
> > > it may affect
> > > power consumption?
> > With this patch (bailing out), the percentage of feec() returning due to
> > a negative delta I get are:
> > on a Juno-r2, with 2 big CPUs and 4 CPUs (capacity of 383), with a
> > workload running during 5s with task having a period of 16 ms and:
> >   - 50 tasks at 1%:   0.14%
> >   - 30 tasks at 1%:   0.54%
> >   - 10 tasks at 1%: < 0.1%
> >   - 30 tasks at 5%: < 0.1%
> >   - 10 tasks at 5%: < 0.1%
> > It doesn't happen so often to me.If we bail out of feec(), the task will
> > still have another opportunity in the next call. However I agree this
> > can lead to a bad placement when this happens.
> > >
> > > > I think a similar modification should be done in your patch. 
> Even though
> > > > this is a good idea to group the calls to compute_energy() to 
> reduce the
> > > > chances of having updates of utilization values in between the
> > > > compute_energy() calls,
> > > > there is still a chance to have updates. I think it happened when I
> > > > applied your patch.
> > > >
> > > > About changing the delta(s) from 'unsigned long' to 'long', I am not
> > > > sure of the meaning of having a negative delta. I thing it would be
> > > > better to check and fail before it happens instead.
> > > >

Regards


