Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE653343ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhCVLDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:03:34 -0400
Received: from outbound-smtp33.blacknight.com ([81.17.249.66]:58055 "EHLO
        outbound-smtp33.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230327AbhCVLDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:03:09 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp33.blacknight.com (Postfix) with ESMTPS id 06A8E16C06E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:03:08 +0000 (GMT)
Received: (qmail 24632 invoked from network); 22 Mar 2021 11:03:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Mar 2021 11:03:07 -0000
Date:   Mon, 22 Mar 2021 11:03:06 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v2] sched/fair: bring back select_idle_smt, but
 differently
Message-ID: <20210322110306.GE3697@techsingularity.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210321150358.71ef52b1@imladris.surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 03:03:58PM -0400, Rik van Riel wrote:
>     Mel Gorman did some nice work in 9fe1f127b913
>     ("sched/fair: Merge select_idle_core/cpu()"), resulting in the kernel
>     being more efficient at finding an idle CPU, and in tasks spending less
>     time waiting to be run, both according to the schedstats run_delay
>     numbers, and according to measured application latencies. Yay.
>     

Other than unusual indentation of the changelog, yey for part 1.

>     The flip side of this is that we see more task migrations (about
>     30% more), higher cache misses, higher memory bandwidth utilization,
>     and higher CPU use, for the same number of requests/second.
>     

I am having difficulty with this part and whether this patch affects task
migrations in particular.

>     This is most pronounced on a memcache type workload, which saw
>     a consistent 1-3% increase in total CPU use on the system, due
>     to those increased task migrations leading to higher L2 cache
>     miss numbers, and higher memory utilization. The exclusive L3
>     cache on Skylake does us no favors there.
>     

Out of curiousity, what is the load generator for memcache or is this
based on analysis of a production workload? I ask because mutilate
(https://github.com/leverich/mutilate) is allegedly a load generator
that can simulate FaceBook patterns but it is old. I would be interested
in hearing if mutilate is used and if so, what parameters the load
generator is given.

>     On our web serving workload, that effect is usually negligible,
>     but occasionally as large as a 9% regression in the number of
>     requests served, due to some interaction between scheduler latency
>     and the web load balancer.
>     
>     It appears that the increased number of CPU migrations is generally
>     a good thing, since it leads to lower cpu_delay numbers, reflecting
>     the fact that tasks get to run faster. However, the reduced locality
>     and the corresponding increase in L2 cache misses hurts a little.
>     

This is understandable because finding an idle CPU and incurring the
migration cost can be better than stacking a task on a busy CPU for
workloads that are sensitive to wakeup latency.

>     The patch below appears to fix the regression, while keeping the
>     benefit of the lower cpu_delay numbers, by reintroducing select_idle_smt
>     with a twist: when a socket has no idle cores, check to see if the
>     sibling of "prev" is idle, before searching all the other CPUs.
>     

But this is the part I'm having a problem with. If the sibling of prev is
idle then a task migration cost is still incurred. The main difference is
that it's more likely to share a L1 or L2 cache and with no idle cores,
some sharing of resources between HT siblings is inevitable.

Can you confirm that task migrations are still higher with this patch?

>     This fixes both the occasional 9% regression on the web serving
>     workload, and the continuous 2% CPU use regression on the memcache
>     type workload.
>     
>     With Mel's patches and this patch together, the p95 and p99 response
>     times for the memcache type application improve by about 20% over what
>     they were before Mel's patches got merged.
>     

Again, I would be very interested in hearing how this conclusion was
reached because I can update mmtests accordingly and wire it into the
"standard battery of scheduler workloads".

>     Signed-off-by: Rik van Riel <riel@surriel.com>
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..0c986972f4cd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6098,6 +6098,28 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>  	return -1;
>  }
>  
> +/*
> + * Scan the local SMT mask for idle CPUs.
> + */
> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int
> +target)
> +{
> +	int cpu;
> +
> +	if (!static_branch_likely(&sched_smt_present))
> +		return -1;
> +
> +	for_each_cpu(cpu, cpu_smt_mask(target)) {
> +		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> +		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> +			continue;
> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> +			return cpu;
> +	}
> +
> +	return -1;
> +}
> +
>  #else /* CONFIG_SCHED_SMT */
>  

Take a look at Barry's patch
"!static_branch_likely(&sched_smt_present)". If that is applied first then
you can remove the static_branch_likely check here as it'll be covered
by an earlier test_idle_cores() call.

As the ordering is not known, just note that it's a potential follow-up
if Barry's patch was merged after yours.

>  static inline void set_idle_cores(int cpu, int val)
> @@ -6114,6 +6136,11 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
>  	return __select_idle_cpu(core);
>  }
>  
> +static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +	return -1;
> +}
> +
>  #endif /* CONFIG_SCHED_SMT */
>  
>  /*
> @@ -6121,7 +6148,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>   * average idle time for this rq (as found in rq->avg_idle).
>   */
> -static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
> +static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int prev, int target)
>  {
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>  	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> @@ -6155,6 +6182,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  		time = cpu_clock(this);
>  	}
>  
> +	if (!smt && cpus_share_cache(prev, target)) {
> +		/* No idle core. Check if prev has an idle sibling. */
> +		i = select_idle_smt(p, sd, prev);
> +		if ((unsigned int)i < nr_cpumask_bits)
> +			return i;
> +	}
> +
>  	for_each_cpu_wrap(cpu, cpus, target) {
>  		if (smt) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);

Please consider moving this block within the SIS_PROP && !smt check
above. It could become something like

if (!smt) {
	/* No idle core. Check if prev has an idle sibling. */
	i = select_idle_smt(p, sd, prev);
	if ((unsigned int)i < nr_cpumask_bits)
		return i;

	if (sched_feat(SIS_PROP)) {
		SIS_PROP STUFF
	}
}

That way you avoid some calculations and a clock read if the HT sibling
is idle.

Second, select_idle_smt() does not use the cpus mask so consider moving
the cpus initialisation after select_idle_smt() has been called.
Specifically this initialisation

	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);

Alternatively, clear the bits in the SMT sibling scan to avoid checking
the siblings twice. It's a tradeoff because initialising and clearing
bits is not free and the cost is wasted if a sibling is free.

A third concern, although it is mild, is that the SMT scan ignores the
SIS_PROP limits on the depth search. This patch may increase the scan
depth as a result. It's only a mild concern as limiting the depth of a
search is a magic number anyway. 

Otherwise, the biggest difference from historical behaviour is that we are
explicitly favouring SMT siblings when !idle_cores and !idle_cores can
be inaccurate. That is going to be a "win some, lose some" scenario and
might show up in overloaded workloads that rapidly idle (e.g. hackbench).
I don't have a strong opinion on this one because *some* HT sibling
is going to be used and it's workload and hardware dependant what the
impact is.

I think I'll run this through a short run of some scheduler loads but
I'll wait to see if you decide to create another version based on this
review.

-- 
Mel Gorman
SUSE Labs
