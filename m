Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB7E45D909
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbhKYLUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:20:52 -0500
Received: from foss.arm.com ([217.140.110.172]:49694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234205AbhKYLTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:19:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 291831042;
        Thu, 25 Nov 2021 03:16:23 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2626D3F66F;
        Thu, 25 Nov 2021 03:16:22 -0800 (PST)
From:   Valentin Schneider <Valentin.Schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        dietmar.eggemann@arm.com
Subject: Re: [PATCH] sched/fair: Fix detection of per-CPU kthreads waking a task
In-Reply-To: <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com>
References: <20211124154239.3191366-1-vincent.donnefort@arm.com> <CAKfTPtDX8sOfguZhJt5QV3j5D_JetcgncuF2w+uLa0XDk7UXkw@mail.gmail.com>
Date:   Thu, 25 Nov 2021 11:16:16 +0000
Message-ID: <8735nkcwov.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/21 10:05, Vincent Guittot wrote:
> On Wed, 24 Nov 2021 at 16:42, Vincent Donnefort
> <vincent.donnefort@arm.com> wrote:
>>
>> select_idle_sibling() will return prev_cpu for the case where the task is
>> woken up by a per-CPU kthread. However, the idle task has been recently
>> modified and is now identified by is_per_cpu_kthread(), breaking the
>> behaviour described above. Using !is_idle_task() ensures we do not
>> spuriously trigger that select_idle_sibling() exit path.
>>
>> Fixes: 00b89fe0197f ("sched: Make the idle task quack like a per-CPU kthread")
>> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 945d987246c5..8bf95b0e368d 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6399,6 +6399,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>          * pattern is IO completions.
>>          */
>>         if (is_per_cpu_kthread(current) &&
>> +           !is_idle_task(current) &&
>>             prev == smp_processor_id() &&
>>             this_rq()->nr_running <= 1) {
>>                 return prev;
>
> AFAICT, this can't be possible for a symmetric system because it would
> have been already returned by other conditions.
> Only an asymmetric system can face such a situation if the task
> doesn't fit which is the subject of your other patch.
> so this patch seems irrelevant outside the other one
>

I think you can still hit this on a symmetric system; let me try to
reformulate my other email.

If this (non-patched) condition evaluates to true, it means the previous
condition

  (available_idle_cpu(target) || sched_idle_cpu(target)) &&
   asym_fits_capacity(task_util, target)

evaluated to false, so for a symmetric system target sure isn't idle.

prev == smp_processor_id() implies prev == target, IOW prev isn't
idle. Now, consider:

  p0.prev = CPU1
  p1.prev = CPU1

  CPU0                     CPU1
  current = don't care     current = swapper/1

  ttwu(p1)
    ttwu_queue(p1, CPU1)
    // or
    ttwu_queue_wakelist(p1, CPU1)

                          hrtimer_wakeup()
                            wake_up_process()
                              ttwu()
                                idle_cpu(CPU1)? no

                                is_per_cpu_kthread(current)? yes
                                prev == smp_processor_id()? yes
                                this_rq()->nr_running <= 1? yes
                                => self enqueue

                          ...
                          schedule_idle()

This works if CPU0 does either a full enqueue (rq->nr_running == 1) or just
a wakelist enqueue (rq->ttwu_pending > 0). If there was an idle CPU3
around, we'd still be stacking p0 and p1 onto CPU1.

IOW this opens a window between a remote ttwu() and the idle task invoking
schedule_idle() where the idle task can stack more tasks onto its CPU.

>
>> --
>> 2.25.1
>>
