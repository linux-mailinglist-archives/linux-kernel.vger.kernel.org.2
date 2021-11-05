Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A01445F90
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 06:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhKEGBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 02:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhKEGBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 02:01:39 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0204C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 22:58:59 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id bq14so7927894qkb.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bb9gceZLitaxHABPZh/aWsMloY6IdSQssq54VH/+oUY=;
        b=i561PFIQbwxoNJwatTVcH7CHntJCG58/E87eIAP87EwQhiS6YtMovntHe/cb5yozGs
         zbQ7BOwPQWcVoS09h6uUxuaeE5AA8WjCC6O/QXAKCiegIqzXuQP77QZwGLKgY5vf0Yh7
         4WWBuigojcGGOK8+L/3KtPJ9RBqPTw3QYp60t8pIMU2KbZFMDgm5TXg9sY33rBeHg3A6
         6ZY4hYxKG2Pbbj7094ghHMsmPELm0OjTn6X4AnEPDjJfwNC8zSKXbuTf91dGiWBoC4Ea
         KuvMC3xeD7Ym5qIQsnycytgyKQZEMzj890GoXlUJmIVaSJOeDjvY1BTb1hDwDgBlwLBo
         8T8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bb9gceZLitaxHABPZh/aWsMloY6IdSQssq54VH/+oUY=;
        b=p4abcUEF+YepQAGOXdOFLTsm4YUkDNAPnVthvuRl6bLLEGzDAoUXoIHjxb1MuNYig+
         j0XDAiLg0XCYL9hf9EPTJgSEfnPkBnvFXkAwHZOBODJi8qWn+FZWdiPGPx8du1XXXpYI
         4Iof/p/u8rTWdzbtjzo2QWmdAln7U6JUnoZ4jpmqE68oE8+VjTpd5xqBwiRhVa4tulBP
         2sBZqx9J2mwJekwi1Iv3ilrgy1Obf8lusc4Uu/JIjfAayBhCSjB98bqwOnbRsNtLOyQG
         6J63tE/TbY+vMU9JMMTlv2BPHmD8P9R9bDk/JkxxICRGlJDJZsxlrHMFJGfZM3JkPoAc
         jHJQ==
X-Gm-Message-State: AOAM530u6vyUu7NuPS7qjp/bxmURQoXQRDVx4GbBV3iOFpH06leW0hXj
        YtldiToKHHW2J2lfPdPrFQGApaUMd3wr8As7D7kox4iYeYc=
X-Google-Smtp-Source: ABdhPJzdC1Zq21yaHzyJ3Vy/8xgdQ7hSUN5ZUaA+3Z3rF8XdDSpFW5UZLWIA/z2OyZ0V/8CLml38X9FwVN7jCULGI9I=
X-Received: by 2002:a37:4041:: with SMTP id n62mr44191687qka.225.1636091938982;
 Thu, 04 Nov 2021 22:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org> <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
 <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com> <78b3f72b-3fe7-f2e0-0e6b-32f28b8ce777@arm.com>
In-Reply-To: <78b3f72b-3fe7-f2e0-0e6b-32f28b8ce777@arm.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 5 Nov 2021 13:58:37 +0800
Message-ID: <CAGWkznF_8iBp57BPoQKvG4VuNYep=g+ZxgO7D4e0wMDLipJ8uw@mail.gmail.com>
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xuewen.yan@unisoc.com, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 4:58 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 03/11/2021 08:08, Zhaoyang Huang wrote:
> > +Vincent Guittot
> >
> > On Wed, Nov 3, 2021 at 3:07 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >>
> >> On Wed, Nov 3, 2021 at 3:47 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >>>
> >>> CC peterz as well for rt and timekeeping magic
> >>>
> >>> On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
> >>>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>>>
> >>>> In an EAS enabled system, there are two scenarios discordant to current design,
>
> I don't understand the EAS (probably asymmetric CPU capacity is meant
> here) angle of the story. Pressure on CPU capacity which is usable for
> CFS happens on SMP as well?
 Mentioning EAS here mainly about RT tasks preempting small CFS tasks
(big CFS tasks could be scheduled to big core), which would introduce
more proportion of preempted time within PSI_MEM_STALL than SMP does.
>
> >>>>
> >>>> 1. workload used to be heavy uneven among cores for sake of scheduler policy.
> >>>> RT task usually preempts CFS task in little core.
> >>>> 2. CFS task's memstall time is counted as simple as exit - entry so far, which
> >>>> ignore the preempted time by RT, DL and Irqs.
> >>>>
> >>>> With these two constraints, the percpu nonidle time would be mainly consumed by
> >>>> none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
> >>>> via the proportion of cfs_rq's utilization on the whole rq.
> >>>>
> >>>> eg.
> >>>> Here is the scenario which this commit want to fix, that is the rt and irq consume
> >>>> some utilization of the whole rq. This scenario could be typical in a core
> >>>> which is assigned to deal with all irqs. Furthermore, the rt task used to run on
> >>>> little core under EAS.
> >>>>
> >>>> Binder:305_3-314    [002] d..1   257.880195: psi_memtime_fixup: original:30616,adjusted:25951,se:89,cfs:353,rt:139,dl:0,irq:18
> >>>> droid.phone-1525    [001] d..1   265.145492: psi_memtime_fixup: original:61616,adjusted:53492,se:55,cfs:225,rt:121,dl:0,irq:15
> >>>>
> >>>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>>> ---
> >>>>  kernel/sched/psi.c | 20 +++++++++++++++++++-
> >>>>  1 file changed, 19 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> >>>> index cc25a3c..754a836 100644
> >>>> --- a/kernel/sched/psi.c
> >>>> +++ b/kernel/sched/psi.c
> >>>> @@ -182,6 +182,8 @@ struct psi_group psi_system = {
> >>>>
> >>>>  static void psi_avgs_work(struct work_struct *work);
> >>>>
> >>>> +static unsigned long psi_memtime_fixup(u32 growth);
> >>>> +
> >>>>  static void group_init(struct psi_group *group)
> >>>>  {
> >>>>       int cpu;
> >>>> @@ -492,6 +494,21 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
> >>>>       return growth;
> >>>>  }
> >>>>
> >>>> +static unsigned long psi_memtime_fixup(u32 growth)
> >>>> +{
> >>>> +     struct rq *rq = task_rq(current);
> >>>> +     unsigned long growth_fixed = (unsigned long)growth;
> >>>> +
> >>>> +     if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> >>>> +             return growth_fixed;
>
> This will let the idle task (swapper) pass. Is this indented? Or do you
> want to only let CFS tasks (including SCHED_IDLE) pass?
idle tasks will NOT call psi_memstall_xxx. We just want CFS tasks to
scale the STALL time.
>
> if (current->sched_class != &fair_sched_class)
>     return growth_fixed;
>
> >>>> +
> >>>> +     if (current->in_memstall)
> >>>> +             growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> >>>> +                                     - rq->avg_irq.util_avg + 1) * growth, 1024);
> >>>> +
>
> We do this slightly different in scale_rt_capacity() [fair.c]:
>
> max = arch_scale_cpu_capacity(cpu_of(rq) /* instead of 1024 to support
>                                             asymmetric CPU capacity */
Is it possible that the SUM of rqs' util_avg large than
arch_scale_cpu_capacity because of task migration things?
>
> used = cpu_util_rt(rq);
> used += cpu_util_dl(rq);
> used += thermal_load_avg(rq);
>
> free = max - used
> irq = cpu_util_irq(rq)
>
> used = scale_irq_capacity(free, irq, max);
>
> scaling then with with: max - used / max
ok. so introduce thermal util.
>
> >>>> +     return growth_fixed;
> >>>> +}
> >>>> +
> >>>>  static void init_triggers(struct psi_group *group, u64 now)
> >>>>  {
> >>>>       struct psi_trigger *t;
> >>>> @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> >>>>       }
> >>>>
> >>>>       if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> >>>> +             delta = psi_memtime_fixup(delta);
> >>>
> >> add vincent for advise on cpu load mechanism
> >>
> >>> Ok, so we want to deduct IRQ and RT preemption time from the memstall
> >>> period of an active reclaimer, since it's technically not stalled on
> >>> memory during this time but on CPU.
> >>>
> >>> However, we do NOT want to deduct IRQ and RT time from memstalls that
> >>> are sleeping on refaults swapins, since they are not affected by what
> >>> is going on on the CPU.
> >>>
> >>> Does util_avg capture that difference? I'm not confident it does - but
> >>> correct me if I'm wrong. We need length of time during which and IRQ
> >>> or an RT task preempted the old rq->curr, not absolute irq/rt length.
> >> As far as my understanding, core's capacity = IRQ + DEADLINE + RT +
> >> CFS. For a certain time period, all cfs tasks preempt each other
> >> inside CFS's utilization. So the sleeping on refaults is counted in.
> >>>
> >>> (Btw, such preemption periods, in addition to being deducted from
> >>> memory stalls, should probably also be added to CPU contention stalls,
> >>> to make CPU pressure reporting more accurate as well.)
>
