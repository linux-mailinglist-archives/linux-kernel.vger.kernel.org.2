Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577CA365E74
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbhDTRZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:25:54 -0400
Received: from foss.arm.com ([217.140.110.172]:39428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233281AbhDTRZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:25:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9262911D4;
        Tue, 20 Apr 2021 10:25:21 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01BE43F73B;
        Tue, 20 Apr 2021 10:25:18 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Fix negative energy delta in
 find_energy_efficient_cpu()
To:     Pierre.Gondois@arm.com, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com
Cc:     Lukasz.Luba@arm.com, Vincent.Donnefort@arm.com,
        qais.yousef@arm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qperret@qperret.net
References: <20210420125604.15796-1-Pierre.Gondois@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <cef37a82-75a8-f51e-522f-57f9a0d1750d@arm.com>
Date:   Tue, 20 Apr 2021 19:25:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420125604.15796-1-Pierre.Gondois@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2021 14:56, Pierre.Gondois@arm.com wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> find_energy_efficient_cpu() (feec()) searches the best energy CPU
> to place a task on. To do so, compute_energy() estimates the energy
> impact of placing the task on a CPU, based on CPU and task utilization
> signals.
> 
> Utilization signals can be concurrently updated while evaluating a
> perf_domain. In some cases, this leads to having a 'negative delta',
> i.e. placing the task in the perf_domain is seen as an energy gain.
> Thus, any further energy comparison is biased.
> 
> In case of a 'negative delta', return prev_cpu since:
> 1. a 'negative delta' happens in less than 0.5% of feec() calls,
>    on a Juno with 6 CPUs (4 little, 2 big)
> 2. it is unlikely to have two consecutive 'negative delta' for
>    a task, so if the first call fails, feec() will correctly
>    place the task in the next feec() call
> 3. EAS current behavior tends to select prev_cpu if the task
>    doesn't raise the OPP of its current perf_domain. prev_cpu
>    is EAS's generic decision
> 4. prev_cpu should be preferred to returning an error code.
>    In the latter case, select_idle_sibling() would do the placement,
>    selecting a big (and not energy efficient) CPU. As 3., the task
>    would potentially reside on the big CPU for a long time
> 
> The patch also:
> a. groups the compute_energy() calls to lower the chances of having
>    concurrent updates in between the calls
> b. skips the base_energy_pd computation if no CPU is available in a
>    perf_domain

Did you run some tests to make sure you didn't regress on energy
consumption? You could run EAS' Energy tests w/ and w/o the patch
depicted in:

https://lkml.kernel.org/r/20181203095628.11858-1-quentin.perret@arm.com

> Fixes: eb92692b2544d sched/fair: Speed-up energy-aware wake-up
> Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Suggested-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>  kernel/sched/fair.c | 69 +++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0dba0ebc3657..577482aa8919 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6594,8 +6594,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  {
>  	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
>  	struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
> +	int cpu, best_energy_cpu = prev_cpu, target = -1;
>  	unsigned long cpu_cap, util, base_energy = 0;
> -	int cpu, best_energy_cpu = prev_cpu;
>  	struct sched_domain *sd;
>  	struct perf_domain *pd;
>  
> @@ -6614,19 +6614,18 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  	if (!sd)
>  		goto fail;
>  
> +	target = prev_cpu;
> +
>  	sync_entity_load_avg(&p->se);
>  	if (!task_util_est(p))
> -		goto unlock;
> +		goto fail;
>  
>  	for (; pd; pd = pd->next) {
>  		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
> +		bool compute_prev_delta = false;
>  		unsigned long base_energy_pd;
>  		int max_spare_cap_cpu = -1;
>  
> -		/* Compute the 'base' energy of the pd, without @p */
> -		base_energy_pd = compute_energy(p, -1, pd);
> -		base_energy += base_energy_pd;
> -
>  		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
>  			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>  				continue;
> @@ -6647,26 +6646,41 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			if (!fits_capacity(util, cpu_cap))
>  				continue;
>  
> -			/* Always use prev_cpu as a candidate. */
>  			if (cpu == prev_cpu) {
> -				prev_delta = compute_energy(p, prev_cpu, pd);
> -				prev_delta -= base_energy_pd;
> -				best_delta = min(best_delta, prev_delta);
> -			}
> -
> -			/*
> -			 * Find the CPU with the maximum spare capacity in
> -			 * the performance domain
> -			 */
> -			if (spare_cap > max_spare_cap) {
> +				/* Always use prev_cpu as a candidate. */
> +				compute_prev_delta = true;
> +			} else if (spare_cap > max_spare_cap) {
> +				/*
> +				 * Find the CPU with the maximum spare capacity
> +				 * in the performance domain.
> +				 */
>  				max_spare_cap = spare_cap;
>  				max_spare_cap_cpu = cpu;
>  			}
>  		}
>  
> +		if (max_spare_cap_cpu < 0 && !compute_prev_delta)
> +			continue;
> +
> +		/* Compute the 'base' energy of the pd, without @p */
> +		base_energy_pd = compute_energy(p, -1, pd);
> +		base_energy += base_energy_pd;


Maybe add a comment

                /* Evaluate the energy impact of using prev_cpu. */

To be in sync with the if condition further below.

> +		if (compute_prev_delta) {
> +			prev_delta = compute_energy(p, prev_cpu, pd);
> +			/* Prevent negative deltas and select prev_cpu */

Not sure if this comment helps in understanding the code. We don't
comment that we return prev_cpu if !task_util_est(p) or we're not
entering the `Pick the best CPU ...` condition.

> +			if (prev_delta < base_energy_pd)
> +				goto fail;
> +			prev_delta -= base_energy_pd;
> +			best_delta = min(best_delta, prev_delta);
> +		}
> +
>  		/* Evaluate the energy impact of using this CPU. */

better

   	    /* Evaluate the energy impact of using max_spare_cap_cpu. */

since `this` has lost its context.

> -		if (max_spare_cap_cpu >= 0 && max_spare_cap_cpu != prev_cpu) {
> +		if (max_spare_cap_cpu >= 0) {
>  			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
> +			/* Prevent negative deltas and select prev_cpu */

Not sure if this comment helps in understanding the code.

> +			if (cur_delta < base_energy_pd)
> +				goto fail;
>  			cur_delta -= base_energy_pd;
>  			if (cur_delta < best_delta) {
>  				best_delta = cur_delta;
> @@ -6674,25 +6688,20 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  			}
>  		}
>  	}
> -unlock:
> -	rcu_read_unlock();

You don't close the RCU read-side critical section here anymore but
include the following if condition as well. Don't we always want to
close them as quick as possible? We could still return target (prev_cpu)
after the if condition below ...

>  
>  	/*
> -	 * Pick the best CPU if prev_cpu cannot be used, or if it saves at
> -	 * least 6% of the energy used by prev_cpu.
> +	 * Pick the best CPU if:
> +	 *  - prev_cpu cannot be used, or
> +	 *  - it saves at least 6% of the energy used by prev_cpu
>  	 */

Why changing the layout of this comment?

> -	if (prev_delta == ULONG_MAX)
> -		return best_energy_cpu;
> -
> -	if ((prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
> -		return best_energy_cpu;
> -
> -	return prev_cpu;
> +	if ((prev_delta == ULONG_MAX) ||
> +		(prev_delta - best_delta) > ((prev_delta + base_energy) >> 4))
> +		target = best_energy_cpu;
>  
>  fail:
>  	rcu_read_unlock();
>  
> -	return -1;
> +	return target;
>  }
>  
>  /*
> 

