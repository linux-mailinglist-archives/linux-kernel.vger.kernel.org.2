Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931A530DE01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbhBCPW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:22:56 -0500
Received: from foss.arm.com ([217.140.110.172]:41838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233976AbhBCPPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:15:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EC821396;
        Wed,  3 Feb 2021 07:14:50 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F2403F73B;
        Wed,  3 Feb 2021 07:14:49 -0800 (PST)
Date:   Wed, 3 Feb 2021 15:14:46 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [PATCH 2/8] sched/fair: Add more sched_asym_cpucapacity static
 branch checks
Message-ID: <20210203151446.ohqefxok6piz3kun@e107158-lin>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128183141.28097-3-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/21 18:31, Valentin Schneider wrote:
> Rik noted a while back that a handful of
> 
>   sd->flags & SD_ASYM_CPUCAPACITY
> 
> & family in the CFS load-balancer code aren't guarded by the
> sched_asym_cpucapacity static branch.
> 
> The load-balancer is already doing a humongous amount of work, but turning
> those checks into NOPs for those who don't need it is fairly
> straightforward, so do that.
> 
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks

--
Qais Yousef

>  kernel/sched/fair.c  | 11 ++++++-----
>  kernel/sched/sched.h |  6 ++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0f6a4e58ce3c..7d01fa0bfc7e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8465,7 +8465,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  			continue;
>  
>  		/* Check for a misfit task on the cpu */
> -		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> +		if (sd_has_asym_cpucapacity(env->sd) &&
>  		    sgs->group_misfit_task_load < rq->misfit_task_load) {
>  			sgs->group_misfit_task_load = rq->misfit_task_load;
>  			*sg_status |= SG_OVERLOAD;
> @@ -8522,7 +8522,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	 * CPUs in the group should either be possible to resolve
>  	 * internally or be covered by avg_load imbalance (eventually).
>  	 */
> -	if (sgs->group_type == group_misfit_task &&
> +	if (static_branch_unlikely(&sched_asym_cpucapacity) &&
> +	    sgs->group_type == group_misfit_task &&
>  	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
>  	     sds->local_stat.group_type != group_has_spare))
>  		return false;
> @@ -8605,7 +8606,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	 * throughput. Maximize throughput, power/energy consequences are not
>  	 * considered.
>  	 */
> -	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
> +	if (sd_has_asym_cpucapacity(env->sd) &&
>  	    (sgs->group_type <= group_fully_busy) &&
>  	    (group_smaller_min_cpu_capacity(sds->local, sg)))
>  		return false;
> @@ -8728,7 +8729,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>  	}
>  
>  	/* Check if task fits in the group */
> -	if (sd->flags & SD_ASYM_CPUCAPACITY &&
> +	if (sd_has_asym_cpucapacity(sd) &&
>  	    !task_fits_capacity(p, group->sgc->max_capacity)) {
>  		sgs->group_misfit_task_load = 1;
>  	}
> @@ -9419,7 +9420,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>  		 * Higher per-CPU capacity is considered better than balancing
>  		 * average load.
>  		 */
> -		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> +		if (sd_has_asym_cpucapacity(env->sd) &&
>  		    capacity_of(env->dst_cpu) < capacity &&
>  		    nr_running == 1)
>  			continue;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 045b01064c1e..21bd71f58c06 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1482,6 +1482,12 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  extern struct static_key_false sched_asym_cpucapacity;
>  
> +static inline bool sd_has_asym_cpucapacity(struct sched_domain *sd)
> +{
> +	return static_branch_unlikely(&sched_asym_cpucapacity) &&
> +		sd->flags & SD_ASYM_CPUCAPACITY;
> +}
> +
>  struct sched_group_capacity {
>  	atomic_t		ref;
>  	/*
> -- 
> 2.27.0
> 
