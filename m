Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E0E313FEC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhBHUHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:07:20 -0500
Received: from foss.arm.com ([217.140.110.172]:39918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235475AbhBHSZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:25:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08BE01042;
        Mon,  8 Feb 2021 10:24:55 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB3C33F73D;
        Mon,  8 Feb 2021 10:24:53 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 8/8] sched/fair: Relax task_hot() for misfit tasks
In-Reply-To: <CAKfTPtDBPREA2oBXZ0=-396Dxh5WMYgNTF+=6d_+K-WVjq3Sag@mail.gmail.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-9-valentin.schneider@arm.com> <CAKfTPtDBPREA2oBXZ0=-396Dxh5WMYgNTF+=6d_+K-WVjq3Sag@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Mon, 08 Feb 2021 18:24:47 +0000
Message-ID: <jhjblcuv2mo.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/21 17:21, Vincent Guittot wrote:
> On Thu, 28 Jan 2021 at 19:32, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> Misfit tasks can and will be preempted by the stopper to migrate them over
>> to a higher-capacity CPU. However, when runnable but not current misfit
>> tasks are scanned by the load balancer (i.e. detach_tasks()), the
>> task_hot() ratelimiting logic may prevent us from enqueuing said task onto
>> a higher-capacity CPU.
>>
>> Align detach_tasks() with the active-balance logic and let it pick a
>> cache-hot misfit task when the destination CPU can provide a capacity
>> uplift.
>>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  kernel/sched/fair.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index cba9f97d9beb..c2351b87824f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7484,6 +7484,17 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>>         if (env->sd->flags & SD_SHARE_CPUCAPACITY)
>>                 return 0;
>>
>> +       /*
>> +        * On a (sane) asymmetric CPU capacity system, the increase in compute
>> +        * capacity should offset any potential performance hit caused by a
>> +        * migration.
>> +        */
>> +       if (sd_has_asym_cpucapacity(env->sd) &&
>> +           env->idle != CPU_NOT_IDLE &&
>> +           !task_fits_capacity(p, capacity_of(env->src_cpu)) &&
>> +           cpu_capacity_greater(env->dst_cpu, env->src_cpu))
>
> Why not using env->migration_type to directly detect that it's a
> misfit task active migration ?
>

This is admittedly a kludge. Consider the scenario described in patch 7/8,
i.e.:
- there's a misfit task running on a LITTLE CPU
- a big CPU completes its work and is about to go through newidle_balance()

Now, consider by the time that big CPU gets into load_balance(), the misfit
task on the LITTLE CPU got preempted by a percpu kworker. As of right now,
it's quite likely the imbalance won't be classified as group_misfit_task,
but as group_overloaded (depends on the topology / workload, but that's a
symptom I've been seeing).

Unfortunately, even if we e.g. change the misfit load-balance logic to also
track preempted misfit tasks (rather than just the rq's current), this
could still happen AFAICT.

Long story short, we already trigger an active-balance to upmigrate running
misfit tasks, this changes task_hot() to allow any preempted task that
doesn't fit on its CPU to be upmigrated (regardless of the imbalance
classification).

>> +               return 0;
>> +
>>         /*
>>          * Buddy candidates are cache hot:
>>          */
>> --
>> 2.27.0
>>
