Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666604450BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhKDJBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 05:01:30 -0400
Received: from foss.arm.com ([217.140.110.172]:45080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhKDJB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:01:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 912811063;
        Thu,  4 Nov 2021 01:58:51 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14DE33F719;
        Thu,  4 Nov 2021 01:58:49 -0700 (PDT)
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org>
 <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
 <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <78b3f72b-3fe7-f2e0-0e6b-32f28b8ce777@arm.com>
Date:   Thu, 4 Nov 2021 09:58:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2021 08:08, Zhaoyang Huang wrote:
> +Vincent Guittot
> 
> On Wed, Nov 3, 2021 at 3:07 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>>
>> On Wed, Nov 3, 2021 at 3:47 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>
>>> CC peterz as well for rt and timekeeping magic
>>>
>>> On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
>>>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>>
>>>> In an EAS enabled system, there are two scenarios discordant to current design,

I don't understand the EAS (probably asymmetric CPU capacity is meant
here) angle of the story. Pressure on CPU capacity which is usable for
CFS happens on SMP as well?

>>>>
>>>> 1. workload used to be heavy uneven among cores for sake of scheduler policy.
>>>> RT task usually preempts CFS task in little core.
>>>> 2. CFS task's memstall time is counted as simple as exit - entry so far, which
>>>> ignore the preempted time by RT, DL and Irqs.
>>>>
>>>> With these two constraints, the percpu nonidle time would be mainly consumed by
>>>> none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
>>>> via the proportion of cfs_rq's utilization on the whole rq.
>>>>
>>>> eg.
>>>> Here is the scenario which this commit want to fix, that is the rt and irq consume
>>>> some utilization of the whole rq. This scenario could be typical in a core
>>>> which is assigned to deal with all irqs. Furthermore, the rt task used to run on
>>>> little core under EAS.
>>>>
>>>> Binder:305_3-314    [002] d..1   257.880195: psi_memtime_fixup: original:30616,adjusted:25951,se:89,cfs:353,rt:139,dl:0,irq:18
>>>> droid.phone-1525    [001] d..1   265.145492: psi_memtime_fixup: original:61616,adjusted:53492,se:55,cfs:225,rt:121,dl:0,irq:15
>>>>
>>>> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>> ---
>>>>  kernel/sched/psi.c | 20 +++++++++++++++++++-
>>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>>> index cc25a3c..754a836 100644
>>>> --- a/kernel/sched/psi.c
>>>> +++ b/kernel/sched/psi.c
>>>> @@ -182,6 +182,8 @@ struct psi_group psi_system = {
>>>>
>>>>  static void psi_avgs_work(struct work_struct *work);
>>>>
>>>> +static unsigned long psi_memtime_fixup(u32 growth);
>>>> +
>>>>  static void group_init(struct psi_group *group)
>>>>  {
>>>>       int cpu;
>>>> @@ -492,6 +494,21 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
>>>>       return growth;
>>>>  }
>>>>
>>>> +static unsigned long psi_memtime_fixup(u32 growth)
>>>> +{
>>>> +     struct rq *rq = task_rq(current);
>>>> +     unsigned long growth_fixed = (unsigned long)growth;
>>>> +
>>>> +     if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
>>>> +             return growth_fixed;

This will let the idle task (swapper) pass. Is this indented? Or do you
want to only let CFS tasks (including SCHED_IDLE) pass?

if (current->sched_class != &fair_sched_class)
    return growth_fixed;

>>>> +
>>>> +     if (current->in_memstall)
>>>> +             growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
>>>> +                                     - rq->avg_irq.util_avg + 1) * growth, 1024);
>>>> +

We do this slightly different in scale_rt_capacity() [fair.c]:

max = arch_scale_cpu_capacity(cpu_of(rq) /* instead of 1024 to support
                                            asymmetric CPU capacity */

used = cpu_util_rt(rq);
used += cpu_util_dl(rq);
used += thermal_load_avg(rq);

free = max - used
irq = cpu_util_irq(rq)

used = scale_irq_capacity(free, irq, max);

scaling then with with: max - used / max

>>>> +     return growth_fixed;
>>>> +}
>>>> +
>>>>  static void init_triggers(struct psi_group *group, u64 now)
>>>>  {
>>>>       struct psi_trigger *t;
>>>> @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
>>>>       }
>>>>
>>>>       if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
>>>> +             delta = psi_memtime_fixup(delta);
>>>
>> add vincent for advise on cpu load mechanism
>>
>>> Ok, so we want to deduct IRQ and RT preemption time from the memstall
>>> period of an active reclaimer, since it's technically not stalled on
>>> memory during this time but on CPU.
>>>
>>> However, we do NOT want to deduct IRQ and RT time from memstalls that
>>> are sleeping on refaults swapins, since they are not affected by what
>>> is going on on the CPU.
>>>
>>> Does util_avg capture that difference? I'm not confident it does - but
>>> correct me if I'm wrong. We need length of time during which and IRQ
>>> or an RT task preempted the old rq->curr, not absolute irq/rt length.
>> As far as my understanding, core's capacity = IRQ + DEADLINE + RT +
>> CFS. For a certain time period, all cfs tasks preempt each other
>> inside CFS's utilization. So the sleeping on refaults is counted in.
>>>
>>> (Btw, such preemption periods, in addition to being deducted from
>>> memory stalls, should probably also be added to CPU contention stalls,
>>> to make CPU pressure reporting more accurate as well.)

