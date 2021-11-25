Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8FA45DADF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355281AbhKYNXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:23:17 -0500
Received: from foss.arm.com ([217.140.110.172]:50890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347729AbhKYNVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:21:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97CD21FB;
        Thu, 25 Nov 2021 05:18:04 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 717AB3F66F;
        Thu, 25 Nov 2021 05:18:03 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a
 task
To:     Valentin Schneider <Valentin.Schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net
References: <20211124154239.3191366-1-vincent.donnefort@arm.com>
 <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com>
 <8735nkcwov.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e1a1af29-af98-30e0-9aed-73f9201e27d8@arm.com>
Date:   Thu, 25 Nov 2021 14:17:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8735nkcwov.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.21 12:16, Valentin Schneider wrote:
> On 25/11/21 10:05, Vincent Guittot wrote:
>> On Wed, 24 Nov 2021 at 16:42, Vincent Donnefort
>> <vincent.donnefort@arm.com> wrote:
>>>
>>> select_idle_sibling() will return prev_cpu for the case where the task is
>>> woken up by a per-CPU kthread. However, the idle task has been recently
>>> modified and is now identified by is_per_cpu_kthread(), breaking the
>>> behaviour described above. Using !is_idle_task() ensures we do not
>>> spuriously trigger that select_idle_sibling() exit path.
>>>
>>> Fixes: 00b89fe0197f ("sched: Make the idle task quack like a per-CPU kthread")
>>> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 945d987246c5..8bf95b0e368d 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6399,6 +6399,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>          * pattern is IO completions.
>>>          */
>>>         if (is_per_cpu_kthread(current) &&
>>> +           !is_idle_task(current) &&
>>>             prev == smp_processor_id() &&
>>>             this_rq()->nr_running <= 1) {
>>>                 return prev;
>>
>> AFAICT, this can't be possible for a symmetric system because it would
>> have been already returned by other conditions.
>> Only an asymmetric system can face such a situation if the task
>> doesn't fit which is the subject of your other patch.
>> so this patch seems irrelevant outside the other one
>>
> 
> I think you can still hit this on a symmetric system; let me try to
> reformulate my other email.
> 
> If this (non-patched) condition evaluates to true, it means the previous
> condition
> 
>   (available_idle_cpu(target) || sched_idle_cpu(target)) &&
>    asym_fits_capacity(task_util, target)
> 
> evaluated to false, so for a symmetric system target sure isn't idle.
> 
> prev == smp_processor_id() implies prev == target, IOW prev isn't
> idle. Now, consider:
> 
>   p0.prev = CPU1
>   p1.prev = CPU1
> 
>   CPU0                     CPU1
>   current = don't care     current = swapper/1
> 
>   ttwu(p1)
>     ttwu_queue(p1, CPU1)
>     // or
>     ttwu_queue_wakelist(p1, CPU1)
> 
>                           hrtimer_wakeup()
>                             wake_up_process()
>                               ttwu()
>                                 idle_cpu(CPU1)? no
> 
>                                 is_per_cpu_kthread(current)? yes
>                                 prev == smp_processor_id()? yes
>                                 this_rq()->nr_running <= 1? yes
>                                 => self enqueue
> 
>                           ...
>                           schedule_idle()
> 
> This works if CPU0 does either a full enqueue (rq->nr_running == 1) or just
> a wakelist enqueue (rq->ttwu_pending > 0). If there was an idle CPU3
> around, we'd still be stacking p0 and p1 onto CPU1.
> 
> IOW this opens a window between a remote ttwu() and the idle task invoking
> schedule_idle() where the idle task can stack more tasks onto its CPU.

I can see this happening on my Hikey620 (symmetric) when `this = prev =
target`. 

available_idle_cpu(target) returns 0. rq->curr is rq->idle but
rq->nr_running is 1.

trace_printk() in sis()' `if (is_per_cpu_kthread(current) &&`
condition.

<idle>-0 [005] this=5 prev=5 target=5 rq->curr=[swapper/5 0] rq->nr_running=1 p=[kworker/u16:3 89] current=[swapper/5 0]
<idle>-0 [007] this=7 prev=7 target=7 rq->curr=[swapper/7 0] rq->nr_running=1 p=[rcu_preempt 11] current=[swapper/7 0]
<idle>-0 [005] this=5 prev=5 target=5 rq->curr=[swapper/5 0] rq->nr_running=1 p=[kworker/u16:1 74] current=[swapper/5 0]
                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                      available_idle_cpu(target)->idle_cpu(target)

