Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D7D33C6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 20:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhCOTST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 15:18:19 -0400
Received: from foss.arm.com ([217.140.110.172]:37152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233284AbhCOTSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 15:18:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63E451FB;
        Mon, 15 Mar 2021 12:18:12 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA8743F718;
        Mon, 15 Mar 2021 12:18:10 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH v3 6/7] sched/fair: Filter out locally-unsolvable misfit imbalances
In-Reply-To: <CAKfTPtAZmOp+c4LR0jKSP=cSUOnu0O_ubGUMnpEKh-cPc89qZw@mail.gmail.com>
References: <20210311120527.167870-1-valentin.schneider@arm.com> <20210311120527.167870-7-valentin.schneider@arm.com> <CAKfTPtAZmOp+c4LR0jKSP=cSUOnu0O_ubGUMnpEKh-cPc89qZw@mail.gmail.com>
Date:   Mon, 15 Mar 2021 19:18:04 +0000
Message-ID: <87v99srztf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/21 16:13, Vincent Guittot wrote:
> On Thu, 11 Mar 2021 at 13:05, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> Consider the following (hypothetical) asymmetric CPU capacity topology,
>> with some amount of capacity pressure (RT | DL | IRQ | thermal):
>>
>>   DIE [          ]
>>   MC  [    ][    ]
>>        0  1  2  3
>>
>>   | CPU | capacity_orig | capacity |
>>   |-----+---------------+----------|
>>   |   0 |           870 |      860 |
>>   |   1 |           870 |      600 |
>>   |   2 |          1024 |      850 |
>>   |   3 |          1024 |      860 |
>>
>> If CPU1 has a misfit task, then CPU0, CPU2 and CPU3 are valid candidates to
>> grant the task an uplift in CPU capacity. Consider CPU0 and CPU3 as
>> sufficiently busy, i.e. don't have enough spare capacity to accommodate
>> CPU1's misfit task. This would then fall on CPU2 to pull the task.
>>
>> This currently won't happen, because CPU2 will fail
>>
>>   capacity_greater(capacity_of(CPU2), sg->sgc->max_capacity)
>
> which has been introduced by the previous patch: patch5
>
>>
>> in update_sd_pick_busiest(), where 'sg' is the [0, 1] group at DIE
>> level. In this case, the max_capacity is that of CPU0's, which is at this
>> point in time greater than that of CPU2's. This comparison doesn't make
>> much sense, given that the only CPUs we should care about in this scenario
>> are CPU1 (the CPU with the misfit task) and CPU2 (the load-balance
>> destination CPU).
>>
>> Aggregate a misfit task's load into sgs->group_misfit_task_load only if
>> env->dst_cpu would grant it a capacity uplift. Separately track whether a
>> sched_group contains a misfit task to still classify it as
>> group_misfit_task and not pick it as busiest group when pulling from a
>
> Could you give more details about why we should keep tracking the
> group as misfit ? Do you have a UC in mind ?
>

As stated the current behaviour is to classify groups as group_misfit_task
regardless of the dst_cpu's capacity. When we see a group_misfit_task
candidate group misfit task with higher per-CPU capacity than the local
group, we don't pick it as busiest.

I initially thought not marking those as group_misfit_task was the right
thing to do, as they could then be classified as group_fully_busy or
group_has_spare. Consider:

  DIE [          ]
  MC  [    ][    ]
       0  1  2  3
       L  L  B  B

  arch_scale_capacity(L) < arch_scale_capacity(B)

  CPUs 0-1 are idle / lightly loaded
  CPU2 has a misfit task and a few very small tasks
  CPU3 has a few very small tasks

When CPU0 is running load_balance() at DIE level, right now we'll classify
the [2-3] group as group_misfit_task and not pick it as busiest because the
local group has a lower CPU capacity.

If we didn't do that, we could leave the misfit task alone and pull some
small task(s) from CPU2 or CPU3, which would be a good thing to
do. However, by allowing a group containing a misfit task to be picked as
the busiest group when a CPU of lower capacity is pulling, we run the risk
of the misfit task itself being downmigrated - e.g. if we repeatedly
increment the sd->nr_balance_failed counter and do an active balance (maybe
because the small tasks were unfortunately cache_hot()).

It's less than ideal, but I considered not downmigrating misfit tasks was
the thing to prioritize (and FWIW it also maintains current behaviour).


Another approach would be to add task utilization vs CPU capacity checks in
detach_tasks() and need_active_balance() to prevent downmigration when
env->imbalance_type < group_misfit_task. This may go against the busiest
group selection heuristics however (misfit tasks could be the main
contributors to the imbalance, but we end up not moving them).


>> lower-capacity CPU (which is the current behaviour and prevents
>> down-migration).
>>
>> Since find_busiest_queue() can now iterate over CPUs with a higher capacity
>> than the local CPU's, add a capacity check there.
>>
>> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

>> @@ -8447,10 +8454,21 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>                         continue;
>>
>>                 /* Check for a misfit task on the cpu */
>> -               if (sd_has_asym_cpucapacity(env->sd) &&
>> -                   sgs->group_misfit_task_load < rq->misfit_task_load) {
>> -                       sgs->group_misfit_task_load = rq->misfit_task_load;
>> -                       *sg_status |= SG_OVERLOAD;
>> +               if (!sd_has_asym_cpucapacity(env->sd) ||
>> +                   !rq->misfit_task_load)
>> +                       continue;
>> +
>> +               *sg_status |= SG_OVERLOAD;
>> +               sgs->group_has_misfit_task = true;
>> +
>> +               /*
>> +                * Don't attempt to maximize load for misfit tasks that can't be
>> +                * granted a CPU capacity uplift.
>> +                */
>> +               if (cpu_capacity_greater(env->dst_cpu, i)) {
>> +                       sgs->group_misfit_task_load = max(
>> +                               sgs->group_misfit_task_load,
>> +                               rq->misfit_task_load);
>
> Please encapsulate all this misfit specific code in a dedicated
> function which will be called from update_sg_lb_stats
>

Will do.
