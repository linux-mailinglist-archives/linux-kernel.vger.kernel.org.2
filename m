Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DA130DDEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbhBCPSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:18:17 -0500
Received: from foss.arm.com ([217.140.110.172]:41860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234004AbhBCPQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:16:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 051E2143B;
        Wed,  3 Feb 2021 07:15:19 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A391E3F73B;
        Wed,  3 Feb 2021 07:15:17 -0800 (PST)
Date:   Wed, 3 Feb 2021 15:15:15 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 3/8] sched/fair: Tweak misfit-related capacity checks
Message-ID: <20210203151515.4uphnp2lbch57v6y@e107158-lin>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128183141.28097-4-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/21 18:31, Valentin Schneider wrote:
> During load-balance, groups classified as group_misfit_task are filtered
> out if they do not pass
> 
>   group_smaller_max_cpu_capacity(<candidate group>, <local group>);
> 
> which itself employs fits_capacity() to compare the sgc->max_capacity of
> both groups.
> 
> Due to the underlying margin, fits_capacity(X, 1024) will return false for
> any X > 819. Tough luck, the capacity_orig's on e.g. the Pixel 4 are
> {261, 871, 1024}. If a CPU-bound task ends up on one of those "medium"
> CPUs, misfit migration will never intentionally upmigrate it to a CPU of
> higher capacity due to the aforementioned margin.
> 
> One may argue the 20% margin of fits_capacity() is excessive in the advent
> of counter-enhanced load tracking (APERF/MPERF, AMUs), but one point here
> is that fits_capacity() is meant to compare a utilization value to a
> capacity value, whereas here it is being used to compare two capacity
> values. As CPU capacity and task utilization have different dynamics, a
> sensible approach here would be to add a new helper dedicated to comparing
> CPU capacities.
> 
> Introduce capacity_greater(), which uses a 5% margin. Use it to replace the
> existing capacity checks. Note that check_cpu_capacity() uses yet another
> margin (sd->imbalance_pct), and is left alone for now.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7d01fa0bfc7e..58ce0b22fcb0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -113,6 +113,13 @@ int __weak arch_asym_cpu_priority(int cpu)
>   */
>  #define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
>  
> +/*
> + * The margin used when comparing CPU capacities.
> + * is 'cap' noticeably greater than 'ref'
> + *
> + * (default: ~5%)
> + */
> +#define capacity_greater(cap, ref) ((ref) * 1078 < (cap) * 1024)

nit: can we use cap1 and cap2 and make the implementation use '>' instead of
'<'? ie:

	#define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)

this is more intuitive to read IMHO. Especially few lines below we have

	return capacity_greater(ref->sgc->max_capacity, sg->sgc->max_capacity);

which pass 'ref->...' as cap which can be confusing when looking at the
function signature @ref.

Either way, this LGTM

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks

--
Qais Yousef

>  #endif
>  
>  #ifdef CONFIG_CFS_BANDWIDTH
> @@ -8253,7 +8260,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
>  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
>  {
>  	return rq->misfit_task_load &&
> -		(rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
> +		(capacity_greater(rq->rd->max_cpu_capacity, rq->cpu_capacity_orig) ||
>  		 check_cpu_capacity(rq, sd));
>  }
>  
> @@ -8352,7 +8359,7 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>  static inline bool
>  group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
>  {
> -	return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
> +	return capacity_greater(ref->sgc->min_capacity, sg->sgc->min_capacity);
>  }
>  
>  /*
> @@ -8362,7 +8369,7 @@ group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
>  static inline bool
>  group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
>  {
> -	return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
> +	return capacity_greater(ref->sgc->max_capacity, sg->sgc->max_capacity);
>  }
>  
>  static inline enum
> @@ -9421,7 +9428,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  		 * average load.
>  		 */
>  		if (sd_has_asym_cpucapacity(env->sd) &&
> -		    capacity_of(env->dst_cpu) < capacity &&
> +		    !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
>  		    nr_running == 1)
>  			continue;
>  
> -- 
> 2.27.0
> 
