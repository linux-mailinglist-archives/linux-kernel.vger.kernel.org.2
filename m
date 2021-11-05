Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A672C446732
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhKEQpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:45:10 -0400
Received: from foss.arm.com ([217.140.110.172]:33458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233849AbhKEQpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:45:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BF8E2F;
        Fri,  5 Nov 2021 09:42:29 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91BA93F7F5;
        Fri,  5 Nov 2021 09:42:27 -0700 (PDT)
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
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
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org>
 <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
 <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com>
 <78b3f72b-3fe7-f2e0-0e6b-32f28b8ce777@arm.com>
 <CAGWkznF_8iBp57BPoQKvG4VuNYep=g+ZxgO7D4e0wMDLipJ8uw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <85c81ab7-49ed-aba5-6221-ea6a8f37f8ad@arm.com>
Date:   Fri, 5 Nov 2021 17:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAGWkznF_8iBp57BPoQKvG4VuNYep=g+ZxgO7D4e0wMDLipJ8uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2021 06:58, Zhaoyang Huang wrote:
> On Thu, Nov 4, 2021 at 4:58 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 03/11/2021 08:08, Zhaoyang Huang wrote:
>>> +Vincent Guittot
>>>
>>> On Wed, Nov 3, 2021 at 3:07 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>>>>
>>>> On Wed, Nov 3, 2021 at 3:47 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>>>
>>>>> CC peterz as well for rt and timekeeping magic
>>>>>
>>>>> On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
>>>>>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>>>>
>>>>>> In an EAS enabled system, there are two scenarios discordant to current design,
>>
>> I don't understand the EAS (probably asymmetric CPU capacity is meant
>> here) angle of the story. Pressure on CPU capacity which is usable for
>> CFS happens on SMP as well?
>  Mentioning EAS here mainly about RT tasks preempting small CFS tasks
> (big CFS tasks could be scheduled to big core), which would introduce
> more proportion of preempted time within PSI_MEM_STALL than SMP does.

What's your CPU layout? Do you have the little before the big CPUs? Like
Hikey 960?

root@linaro-developer:~# cat /sys/devices/system/cpu/cpu*/cpu_capacity
462
462
462
462
1024
1024
1024
1024

And I guess rt class prefers lower CPU numbers hence you see this?

>>>>>> 1. workload used to be heavy uneven among cores for sake of scheduler policy.
>>>>>> RT task usually preempts CFS task in little core.
>>>>>> 2. CFS task's memstall time is counted as simple as exit - entry so far, which
>>>>>> ignore the preempted time by RT, DL and Irqs.
>>>>>>
>>>>>> With these two constraints, the percpu nonidle time would be mainly consumed by
>>>>>> none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
>>>>>> via the proportion of cfs_rq's utilization on the whole rq.
>>>>>>
>>>>>> eg.
>>>>>> Here is the scenario which this commit want to fix, that is the rt and irq consume
>>>>>> some utilization of the whole rq. This scenario could be typical in a core
>>>>>> which is assigned to deal with all irqs. Furthermore, the rt task used to run on
>>>>>> little core under EAS.
>>>>>>
>>>>>> Binder:305_3-314    [002] d..1   257.880195: psi_memtime_fixup: original:30616,adjusted:25951,se:89,cfs:353,rt:139,dl:0,irq:18
>>>>>> droid.phone-1525    [001] d..1   265.145492: psi_memtime_fixup: original:61616,adjusted:53492,se:55,cfs:225,rt:121,dl:0,irq:15

[...]

>>>>>> @@ -492,6 +494,21 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
>>>>>>       return growth;
>>>>>>  }
>>>>>>
>>>>>> +static unsigned long psi_memtime_fixup(u32 growth)
>>>>>> +{
>>>>>> +     struct rq *rq = task_rq(current);
>>>>>> +     unsigned long growth_fixed = (unsigned long)growth;
>>>>>> +
>>>>>> +     if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
>>>>>> +             return growth_fixed;
>>
>> This will let the idle task (swapper) pass. Is this indented? Or do you
>> want to only let CFS tasks (including SCHED_IDLE) pass?
> idle tasks will NOT call psi_memstall_xxx. We just want CFS tasks to
> scale the STALL time.

Not sure I  get this.

__schedule() -> psi_sched_switch() -> psi_task_change() ->
psi_group_change() -> record_times() -> psi_memtime_fixup()

is something else than calling psi_memstall_enter() or _leave()?

IMHO, at least record_times() can be called with current equal
swapper/X. Or is it that PSI_MEM_SOME is never set for the idle task in
this callstack? I don't know the PSI internals.

>>
>> if (current->sched_class != &fair_sched_class)
>>     return growth_fixed;
>>
>>>>>> +
>>>>>> +     if (current->in_memstall)
>>>>>> +             growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
>>>>>> +                                     - rq->avg_irq.util_avg + 1) * growth, 1024);
>>>>>> +
>>
>> We do this slightly different in scale_rt_capacity() [fair.c]:
>>
>> max = arch_scale_cpu_capacity(cpu_of(rq) /* instead of 1024 to support
>>                                             asymmetric CPU capacity */
> Is it possible that the SUM of rqs' util_avg large than
> arch_scale_cpu_capacity because of task migration things?

I assume you meant if the rq (cpu_rq(CPUx)) util_avg sum (CFS, RT, DL,
IRQ and thermal part) can be larger than arch_scale_cpu_capacity(CPUx)?

Yes it can.

Have a lock at

effective_cpu_util(..., max, ...) {

  if (foo >= max)
    return max;

}

Even the CFS part (cpu_rq(CPUx)->cfs.avg.util_avg) can be larger than
the original cpu capacity (rq->cpu_capacity_orig).

Have a look at cpu_util(). capacity_orig_of(CPUx) and
arch_scale_cpu_capacity(CPUx) both returning rq->cpu_capacity_orig.

[...]
