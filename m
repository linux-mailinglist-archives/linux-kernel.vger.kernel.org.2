Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46944AABD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 10:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244955AbhKIJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 04:46:28 -0500
Received: from foss.arm.com ([217.140.110.172]:59088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237441AbhKIJq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 04:46:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55A012B;
        Tue,  9 Nov 2021 01:43:41 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98CA03F7F5;
        Tue,  9 Nov 2021 01:43:38 -0800 (PST)
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
To:     Xuewen Yan <xuewen.yan94@gmail.com>
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
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org>
 <CAGWkznEaEEz=m5UmPXRECiizwht7+8Zw_xH9V7Wwyd__10eJDA@mail.gmail.com>
 <CAGWkznFuX=6mSnj7J7=t7et5QO-GB2BKCMRiHoU37jcH9dPhLA@mail.gmail.com>
 <78b3f72b-3fe7-f2e0-0e6b-32f28b8ce777@arm.com>
 <CAGWkznF_8iBp57BPoQKvG4VuNYep=g+ZxgO7D4e0wMDLipJ8uw@mail.gmail.com>
 <85c81ab7-49ed-aba5-6221-ea6a8f37f8ad@arm.com>
 <CAB8ipk_0YxWnS-k+HLPnL7DRR1MM+WH-xQfna7jD_+TQ0vKi8Q@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <05a2e61e-9c55-8f8d-5e72-9854613e53c9@arm.com>
Date:   Tue, 9 Nov 2021 10:43:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAB8ipk_0YxWnS-k+HLPnL7DRR1MM+WH-xQfna7jD_+TQ0vKi8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2021 09:49, Xuewen Yan wrote:
> Hi Dietmar
> 
> On Sat, Nov 6, 2021 at 1:20 AM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 05/11/2021 06:58, Zhaoyang Huang wrote:
>>>> I don't understand the EAS (probably asymmetric CPU capacity is meant
>>>> here) angle of the story. Pressure on CPU capacity which is usable for
>>>> CFS happens on SMP as well?
>>>  Mentioning EAS here mainly about RT tasks preempting small CFS tasks
>>> (big CFS tasks could be scheduled to big core), which would introduce
>>> more proportion of preempted time within PSI_MEM_STALL than SMP does.
>>
>> What's your CPU layout? Do you have the little before the big CPUs? Like
>> Hikey 960?

[...]

>> And I guess rt class prefers lower CPU numbers hence you see this?
>>
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

Ah, OK, out-of-tree extensions.

[...]

>>>>>>>> +     if (current->in_memstall)
>>>>>>>> +             growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
>>>>>>>> +                                     - rq->avg_irq.util_avg + 1) * growth, 1024);
>>>>>>>> +
>>>>
>>>> We do this slightly different in scale_rt_capacity() [fair.c]:
>>>>
>>>> max = arch_scale_cpu_capacity(cpu_of(rq) /* instead of 1024 to support
>>>>                                             asymmetric CPU capacity */
>>> Is it possible that the SUM of rqs' util_avg large than
>>> arch_scale_cpu_capacity because of task migration things?
>>
>> I assume you meant if the rq (cpu_rq(CPUx)) util_avg sum (CFS, RT, DL,
>> IRQ and thermal part) can be larger than arch_scale_cpu_capacity(CPUx)?
>>
>> Yes it can.
>>
>> Have a lock at
>>
>> effective_cpu_util(..., max, ...) {
>>
>>   if (foo >= max)
>>     return max;
>>
>> }
>>
>> Even the CFS part (cpu_rq(CPUx)->cfs.avg.util_avg) can be larger than
>> the original cpu capacity (rq->cpu_capacity_orig).
>>
>> Have a look at cpu_util(). capacity_orig_of(CPUx) and
>> arch_scale_cpu_capacity(CPUx) both returning rq->cpu_capacity_orig.
>>
> 
> Well, your means is we should not use the 1024 and should use the
> original cpu capacity?
> And maybe use the "sched_cpu_util()" is a good choice just like this:
> 
> +       if (current->in_memstall)
> +               growth_fixed = div64_ul(cpu_util_cfs(rq) * growth,
> sched_cpu_util(rq->cpu, capacity_orig_of(rq->cpu)));

Not sure about this. In case util_cfs=0 you would get scale=0.

IMHO, you need

cap      = rq->cpu_capacity
cap_orig = rq->cpu_capacity_orig

scale = (cap * X) / cap_orig

or if the update of these rq values happens to infrequently for you then
you have to calc the pressure evey time. Something like:

pressure = cpu_util_rt(rq) + cpu_util_dl(rq)

irq = cpu_util_irq(rq)

if (irq >= cap_orig)
    pressure = cap_orig
else
    pressure = scale_irq_capacity(pressure, irq, cap_orig)
    pressure += irq

scale = ((cap_orig - pressure) * X) / cap_orig
