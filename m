Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FFA30DDED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhBCPRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:17:51 -0500
Received: from foss.arm.com ([217.140.110.172]:41880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234232AbhBCPQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:16:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 598CB143D;
        Wed,  3 Feb 2021 07:15:34 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09D7B3F73B;
        Wed,  3 Feb 2021 07:15:32 -0800 (PST)
Date:   Wed, 3 Feb 2021 15:15:30 +0000
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
Subject: Re: [PATCH 4/8] sched/fair: Use dst_cpu's capacity rather than group
 {min, max} capacity
Message-ID: <20210203151530.aptdehsruoj6flxf@e107158-lin>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-5-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128183141.28097-5-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/21 18:31, Valentin Schneider wrote:
> Comparing capacity extrema of local and source sched_group's doesn't make
> much sense when at the day of the day the imbalance will be pulled by a
> known env->dst_cpu, whose capacity can be anywhere within the local group's
> capacity extrema.
> 
> Replace group_smaller_{min, max}_cpu_capacity() with comparisons of the
> source group's min/max capacity and the destination CPU's capacity.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks

--
Qais Yousef

>  kernel/sched/fair.c | 31 +++----------------------------
>  1 file changed, 3 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 58ce0b22fcb0..0959a770ecc0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8352,26 +8352,6 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>  	return false;
>  }
>  
> -/*
> - * group_smaller_min_cpu_capacity: Returns true if sched_group sg has smaller
> - * per-CPU capacity than sched_group ref.
> - */
> -static inline bool
> -group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> -{
> -	return capacity_greater(ref->sgc->min_capacity, sg->sgc->min_capacity);
> -}
> -
> -/*
> - * group_smaller_max_cpu_capacity: Returns true if sched_group sg has smaller
> - * per-CPU capacity_orig than sched_group ref.
> - */
> -static inline bool
> -group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> -{
> -	return capacity_greater(ref->sgc->max_capacity, sg->sgc->max_capacity);
> -}
> -
>  static inline enum
>  group_type group_classify(unsigned int imbalance_pct,
>  			  struct sched_group *group,
> @@ -8523,15 +8503,10 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	if (!sgs->sum_h_nr_running)
>  		return false;
>  
> -	/*
> -	 * Don't try to pull misfit tasks we can't help.
> -	 * We can use max_capacity here as reduction in capacity on some
> -	 * CPUs in the group should either be possible to resolve
> -	 * internally or be covered by avg_load imbalance (eventually).
> -	 */
> +	/* Don't try to pull misfit tasks we can't help */
>  	if (static_branch_unlikely(&sched_asym_cpucapacity) &&
>  	    sgs->group_type == group_misfit_task &&
> -	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
> +	    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
>  	     sds->local_stat.group_type != group_has_spare))
>  		return false;
>  
> @@ -8615,7 +8590,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	 */
>  	if (sd_has_asym_cpucapacity(env->sd) &&
>  	    (sgs->group_type <= group_fully_busy) &&
> -	    (group_smaller_min_cpu_capacity(sds->local, sg)))
> +	    (capacity_greater(sg->sgc->min_capacity, capacity_of(env->dst_cpu))))
>  		return false;
>  
>  	return true;
> -- 
> 2.27.0
> 
