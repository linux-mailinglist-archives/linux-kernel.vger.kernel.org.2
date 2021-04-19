Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2901A3648DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 19:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbhDSROC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Apr 2021 13:14:02 -0400
Received: from foss.arm.com ([217.140.110.172]:46950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239824AbhDSRNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8349014BF;
        Mon, 19 Apr 2021 10:13:25 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 155833F7D7;
        Mon, 19 Apr 2021 10:13:23 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
In-Reply-To: <20210416135113.GA16445@vingu-book>
References: <20210415175846.494385-1-valentin.schneider@arm.com> <20210415175846.494385-3-valentin.schneider@arm.com> <20210416135113.GA16445@vingu-book>
Date:   Mon, 19 Apr 2021 18:13:21 +0100
Message-ID: <87blaakxji.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/21 15:51, Vincent Guittot wrote:
> Le jeudi 15 avril 2021 ï¿½ 18:58:46 (+0100), Valentin Schneider a ï¿½crit :
>> +
>> +/*
>> + * What does migrating this task do to our capacity-aware scheduling criterion?
>> + *
>> + * Returns 1, if the task needs more capacity than the dst CPU can provide.
>> + * Returns 0, if the task needs the extra capacity provided by the dst CPU
>> + * Returns -1, if the task isn't impacted by the migration wrt capacity.
>> + */
>> +static int migrate_degrades_capacity(struct task_struct *p, struct lb_env *env)
>> +{
>> +	if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
>> +		return -1;
>> +
>> +	if (!task_fits_capacity(p, capacity_of(env->src_cpu))) {
>> +		if (cpu_capacity_greater(env->dst_cpu, env->src_cpu))
>> +			return 0;
>> +		else if (cpu_capacity_greater(env->src_cpu, env->dst_cpu))
>> +			return 1;
>> +		else
>> +			return -1;
>> +	}
>
> Being there means that task fits src_cpu capacity so why testing p against dst_cpu ?
>

Because if p fits on src_cpu, we don't want to move it to a dst_cpu on
which it *doesn't* fit.

>> +
>> +	return task_fits_capacity(p, capacity_of(env->dst_cpu)) ? -1 : 1;
>> +}
>
> I prefer the below which easier to read because the same var is use everywhere and you can remove cpu_capacity_greater.
>
> static int migrate_degrades_capacity(struct task_struct *p, struct lb_env *env)
> {
>     unsigned long src_capacity, dst_capacity;
>
>     if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
>         return -1;
>
>     src_capacity = capacity_of(env->src_cpu);
>     dst_capacity = capacity_of(env->dst_cpu);
>
>     if (!task_fits_capacity(p, src_capacity)) {
>         if (capacity_greater(dst_capacity, src_capacity))
>             return 0;
>         else if (capacity_greater(src_capacity, dst_capacity))
>             return 1;
>         else
>             return -1;
>     }
>
>     return task_fits_capacity(p, dst_capacity) ? -1 : 1;
> }
>

I'll take it, thanks!

>
>> +
>>  #ifdef CONFIG_NUMA_BALANCING
>>  /*
>>   * Returns 1, if task migration degrades locality
>> @@ -7672,6 +7698,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>      if (tsk_cache_hot == -1)
>>              tsk_cache_hot = task_hot(p, env);
>>
>> +	/*
>> +	 * On a (sane) asymmetric CPU capacity system, the increase in compute
>> +	 * capacity should offset any potential performance hit caused by a
>> +	 * migration.
>> +	 */
>> +	if ((env->dst_grp_type == group_has_spare) &&
>
> Shouldn't it be env->src_grp_type == group_misfit_task to only care of misfit task case as
> stated in $subject
>

Previously this was env->idle != CPU_NOT_IDLE, but I figured dst_grp_type
could give us a better picture. Staring at this some more, this isn't so
true when the group size goes up - there's no guarantees the dst_cpu is the
one that has spare cycles, and the other CPUs might not be able to grant
the capacity uplift dst_cpu can.

As for not using src_grp_type == group_misfit_task, this is pretty much the
same as [1]. CPU-bound (misfit) task + some other task on the same rq
implies group_overloaded classification when balancing at MC level (no SMT,
so one group per CPU).

[1]: http://lore.kernel.org/r/jhjblcuv2mo.mognet@arm.com
