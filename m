Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282C6367E10
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhDVJp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:45:26 -0400
Received: from foss.arm.com ([217.140.110.172]:49104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235767AbhDVJpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:45:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43C3911D4;
        Thu, 22 Apr 2021 02:44:51 -0700 (PDT)
Received: from [10.57.0.105] (unknown [10.57.0.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DDF5A3F774;
        Thu, 22 Apr 2021 02:44:47 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Fix negative energy delta in
 find_energy_efficient_cpu()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com
Cc:     Lukasz.Luba@arm.com, Vincent.Donnefort@arm.com,
        qais.yousef@arm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qperret@qperret.net
References: <20210420125604.15796-1-Pierre.Gondois@arm.com>
 <cef37a82-75a8-f51e-522f-57f9a0d1750d@arm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
Message-ID: <9c27a3aa-091d-59fc-1f47-97807954434f@arm.com>
Date:   Thu, 22 Apr 2021 10:44:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <cef37a82-75a8-f51e-522f-57f9a0d1750d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,
Thanks for the review,

On 4/20/21 6:25 PM, Dietmar Eggemann wrote:

> On 20/04/2021 14:56, Pierre.Gondois@arm.com wrote:
>> From: Pierre Gondois <Pierre.Gondois@arm.com>
>>
>> find_energy_efficient_cpu() (feec()) searches the best energy CPU
>> to place a task on. To do so, compute_energy() estimates the energy
>> impact of placing the task on a CPU, based on CPU and task utilization
>> signals.
>>
>> Utilization signals can be concurrently updated while evaluating a
>> perf_domain. In some cases, this leads to having a 'negative delta',
>> i.e. placing the task in the perf_domain is seen as an energy gain.
>> Thus, any further energy comparison is biased.
>>
>> In case of a 'negative delta', return prev_cpu since:
>> 1. a 'negative delta' happens in less than 0.5% of feec() calls,
>>     on a Juno with 6 CPUs (4 little, 2 big)
>> 2. it is unlikely to have two consecutive 'negative delta' for
>>     a task, so if the first call fails, feec() will correctly
>>     place the task in the next feec() call
>> 3. EAS current behavior tends to select prev_cpu if the task
>>     doesn't raise the OPP of its current perf_domain. prev_cpu
>>     is EAS's generic decision
>> 4. prev_cpu should be preferred to returning an error code.
>>     In the latter case, select_idle_sibling() would do the placement,
>>     selecting a big (and not energy efficient) CPU. As 3., the task
>>     would potentially reside on the big CPU for a long time
>>
>> The patch also:
>> a. groups the compute_energy() calls to lower the chances of having
>>     concurrent updates in between the calls
>> b. skips the base_energy_pd computation if no CPU is available in a
>>     perf_domain
> Did you run some tests to make sure you didn't regress on energy
> consumption? You could run EAS' Energy tests w/ and w/o the patch
> depicted in:
>
> https://lkml.kernel.org/r/20181203095628.11858-1-quentin.perret@arm.com


I executed the energy test you pointed at using LISA on a Juno-r2 (2xA57 
+ 4xA53). The initial tests made by Quentin was on a Juno-r0 and a Hikey960.

To recall the test:
"10 iterations of between 10 and 50 periodic rt-app tasks (16ms period, 
5% duty-cycle) for 30 seconds with energy measurement. Unit is Joules. 
The goal is to save energy, so lower is better."
"Energy is measured with the onboard energy meter. Numbers include 
consumption of big and little CPUs."

+----------+-----------------+-------------------------+
|          | Without patches | With patches            |
+----------+--------+--------+------------------+------+
| Tasks nb |  Mean  |    CI* | Mean             |  CI* |
+----------+--------+--------+------------------+------+
|       10 |   6.57 |   0.24 |   6.46 (-1.69%)  | 0.16 |
|       20 |  12.44 |   0.21 |  12.40 (-0.33%)  | 0.11 |
|       30 |  19.10 |   0.78 |  18.93 (-0.89%)  | 0.46 |
|       40 |  27.27 |   0.53 |  27.49 (+0.81%   | 0.17 |
|       50 |  36.55 |   0.42 |  37.21 (+1.80%)  | 0.81 |
+----------+-----------------+-------------------------+
CI: confidence interval

For each line, the intervals of values w/ wo/ the patches are 
overlapping (consider Mean +/- CI). Thus, the energy results shouldn't 
have been impacted.

>> Fixes: eb92692b2544d sched/fair: Speed-up energy-aware wake-up
>> Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
>> Suggested-by: Xuewen Yan <xuewen.yan@unisoc.com>
>> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
>> ---
>>   kernel/sched/fair.c | 69 +++++++++++++++++++++++++--------------------
>>   1 file changed, 39 insertions(+), 30 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 0dba0ebc3657..577482aa8919 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6594,8 +6594,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>   {
>>   	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
>>   	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
>> +	int cpu, best_energy_cpu = prev_cpu, target = -1;
>>   	unsigned long cpu_cap, util, base_energy = 0;
>> -	int cpu, best_energy_cpu = prev_cpu;
>>   	struct sched_domain *sd;
>>   	struct perf_domain *pd;
>>   
>> @@ -6614,19 +6614,18 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>   	if (!sd)
>>   		goto fail;
>>   
>> +	target = prev_cpu;
>> +
>>   	sync_entity_load_avg(&p->se);
>>   	if (!task_util_est(p))
>> -		goto unlock;
>> +		goto fail;
>>   
>>   	for (; pd; pd = pd->next) {
>>   		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
>> +		bool compute_prev_delta = false;
>>   		unsigned long base_energy_pd;
>>   		int max_spare_cap_cpu = -1;
>>   
>> -		/* Compute the 'base' energy of the pd, without @p */
>> -		base_energy_pd = compute_energy(p, -1, pd);
>> -		base_energy += base_energy_pd;
>> -
>>   		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
>>   			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>>   				continue;
>> @@ -6647,26 +6646,41 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>   			if (!fits_capacity(util, cpu_cap))
>>   				continue;
>>   
>> -			/* Always use prev_cpu as a candidate. */
>>   			if (cpu == prev_cpu) {
>> -				prev_delta = compute_energy(p, prev_cpu, pd);
>> -				prev_delta -= base_energy_pd;
>> -				best_delta = min(best_delta, prev_delta);
>> -			}
>> -
>> -			/*
>> -			 * Find the CPU with the maximum spare capacity in
>> -			 * the performance domain
>> -			 */
>> -			if (spare_cap > max_spare_cap) {
>> +				/* Always use prev_cpu as a candidate. */
>> +				compute_prev_delta = true;
>> +			} else if (spare_cap > max_spare_cap) {
>> +				/*
>> +				 * Find the CPU with the maximum spare capacity
>> +				 * in the performance domain.
>> +				 */
>>   				max_spare_cap = spare_cap;
>>   				max_spare_cap_cpu = cpu;
>>   			}
>>   		}
>>   
>> +		if (max_spare_cap_cpu < 0 && !compute_prev_delta)
>> +			continue;
>> +
>> +		/* Compute the 'base' energy of the pd, without @p */
>> +		base_energy_pd = compute_energy(p, -1, pd);
>> +		base_energy += base_energy_pd;
>
> Maybe add a comment
>
>                  /* Evaluate the energy impact of using prev_cpu. */
>
> To be in sync with the if condition further below.
Ok
>
>> +		if (compute_prev_delta) {
>> +			prev_delta = compute_energy(p, prev_cpu, pd);
>> +			/* Prevent negative deltas and select prev_cpu */
> Not sure if this comment helps in understanding the code. We don't
> comment that we return prev_cpu if !task_util_est(p) or we're not
> entering the `Pick the best CPU ...` condition.
I thought it was not obvious how (prev_delta < base_energy_pd) could 
happen. I'm ok to remove the comment, but maybe a sentence should be 
added in the function header or somewhere else.
>
>> +			if (prev_delta < base_energy_pd)
>> +				goto fail;
>> +			prev_delta -= base_energy_pd;
>> +			best_delta = min(best_delta, prev_delta);
>> +		}
>> +
>>   		/* Evaluate the energy impact of using this CPU. */
> better
>
>     	    /* Evaluate the energy impact of using max_spare_cap_cpu. */
>
> since `this` has lost its context.
Ok
>
>> -		if (max_spare_cap_cpu >= 0 && max_spare_cap_cpu != prev_cpu) {
>> +		if (max_spare_cap_cpu >= 0) {
>>   			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
>> +			/* Prevent negative deltas and select prev_cpu */
> Not sure if this comment helps in understanding the code.

Same comment: I'm ok to remove it, but we should explain what happens 
somewhere, maybe in the function header.

>
>> +			if (cur_delta < base_energy_pd)
>> +				goto fail;
>>   			cur_delta -= base_energy_pd;
>>   			if (cur_delta < best_delta) {
>>   				best_delta = cur_delta;
>> @@ -6674,25 +6688,20 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>   			}
>>   		}
>>   	}
>> -unlock:
>> -	rcu_read_unlock();
> You don't close the RCU read-side critical section here anymore but
> include the following if condition as well. Don't we always want to
> close them as quick as possible? We could still return target (prev_cpu)
> after the if condition below ...
The computation should not take that long and this would make less code.
Putting back the rcu_read_unlock() and returning faster instead of 
having a fall-through would also work for me.

>>   
>>   	/*
>> -	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
>> -	 * least 6% of the energy used by prev_cpu.
>> +	 * Pick the best CPU if:
>> +	 *  - prev_cpu cannot be used, or
>> +	 *  - it saves at least 6% of the energy used by prev_cpu
>>   	 */
> Why changing the layout of this comment?

I thought it was clearer to have bullet points. It can be reverted.


>> -	if (prev_delta == ULONG_MAX)
>> -		return best_energy_cpu;
>> -
>> -	if ((prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
>> -		return best_energy_cpu;
>> -
>> -	return prev_cpu;
>> +	if ((prev_delta == ULONG_MAX) ||
>> +		(prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
>> +		target = best_energy_cpu;
>>   
>>   fail:
>>   	rcu_read_unlock();
>>   
>> -	return -1;
>> +	return target;
>>   }
>>   
>>   /*
>>


