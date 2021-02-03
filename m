Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1354130E2B8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbhBCSoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:44:07 -0500
Received: from foss.arm.com ([217.140.110.172]:45052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233035AbhBCSnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:43:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 064811396;
        Wed,  3 Feb 2021 10:43:10 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A85613F719;
        Wed,  3 Feb 2021 10:43:08 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 6/8] sched/fair: Filter out locally-unsolvable misfit imbalances
In-Reply-To: <20210203151619.3sa42rqo7eihlfcz@e107158-lin>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-7-valentin.schneider@arm.com> <20210203151619.3sa42rqo7eihlfcz@e107158-lin>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 03 Feb 2021 18:43:06 +0000
Message-ID: <jhjlfc52ds5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/21 15:16, Qais Yousef wrote:
> On 01/28/21 18:31, Valentin Schneider wrote:
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
>
> I think this scenario would be hard in practice, but not impossible. Maybe
> gaming could push the system that hard.
>

Actually I wouldn't be surprised if a moderatly busy Android environment
could hit this - slight thermal pressure on the bigs, RT pressure because
we know folks love (ab)using RT, a pinch of IRQs in the mix...

>> @@ -8450,11 +8457,21 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>  			continue;
>>  
>>  		/* Check for a misfit task on the cpu */
>> -		if (sd_has_asym_cpucapacity(env->sd) &&
>> -		    sgs->group_misfit_task_load < rq->misfit_task_load) {
>> -			sgs->group_misfit_task_load = rq->misfit_task_load;
>> -			*sg_status |= SG_OVERLOAD;
>> -		}
>> +		if (!sd_has_asym_cpucapacity(env->sd) ||
>> +		    !rq->misfit_task_load)
>> +			continue;
>> +
>> +		*sg_status |= SG_OVERLOAD;
>> +		sgs->group_has_misfit_task = true;
>> +
>> +		/*
>> +		 * Don't attempt to maximize load for misfit tasks that can't be
>> +		 * granted a CPU capacity uplift.
>> +		 */
>> +		if (cpu_capacity_greater(env->dst_cpu, i))
>> +			sgs->group_misfit_task_load = max(
>> +				sgs->group_misfit_task_load,
>> +				rq->misfit_task_load);
>
> nit: missing curly braces around the if.
>

Ack.

>> @@ -8504,7 +8521,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>>  	/* Don't try to pull misfit tasks we can't help */
>>  	if (static_branch_unlikely(&sched_asym_cpucapacity) &&
>>  	    sgs->group_type == group_misfit_task &&
>> -	    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
>> +	    (!sgs->group_misfit_task_load ||
>>  	     sds->local_stat.group_type != group_has_spare))
>>  		return false;
>>  
>> @@ -9464,15 +9481,18 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>>  		case migrate_misfit:
>>  			/*
>>  			 * For ASYM_CPUCAPACITY domains with misfit tasks we
>> -			 * simply seek the "biggest" misfit task.
>> +			 * simply seek the "biggest" misfit task we can
>> +			 * accommodate.
>>  			 */
>> +			if (!cpu_capacity_greater(env->dst_cpu, i))
>> +				continue;
>
> Both this hunk and the one above mean we will end up searching harder to pull
> the task into the right cpu taking actual capacity into account. Which is
> a good improvement.
>

Note that those extra checks are to make sure we *don't* downmigrate tasks
(as stated somewhere above, this change lets find_busiest_queue() iterate
over CPUs bigger than the local CPU's, which wasn't the case before). A "big"
CPU will still get the chance to pull a "medium" task, even if a "medium"
CPU would have been a "better" choice.

