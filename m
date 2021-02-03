Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590AD30DDF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhBCPTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:19:06 -0500
Received: from foss.arm.com ([217.140.110.172]:41922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234397AbhBCPRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:17:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 983081474;
        Wed,  3 Feb 2021 07:15:50 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 462703F73B;
        Wed,  3 Feb 2021 07:15:49 -0800 (PST)
Date:   Wed, 3 Feb 2021 15:15:46 +0000
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
Subject: Re: [PATCH 5/8] sched/fair: Make check_misfit_status() only compare
 dynamic capacities
Message-ID: <20210203151546.rwkbdjxc2vgiodvx@e107158-lin>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-6-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128183141.28097-6-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/21 18:31, Valentin Schneider wrote:
> check_misfit_status() checks for both capacity pressure & available CPUs
> with higher capacity. Now that we have a sane(ish) capacity comparison
> margin which is used throughout load-balance, this can be condensed into a
> single check:
> 
>   capacity_greater(<root_domain max capacity>, <misfit task CPU's capacity>);
> 
> This has the added benefit of returning false if the misfit task CPU's is
> heavily pressured, but there are no better candidates for migration.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---

check_cpu_capacity() call looks redundant now, yes.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks

--
Qais Yousef

>  kernel/sched/fair.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0959a770ecc0..ef44474b8fbf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8254,14 +8254,12 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
>  
>  /*
>   * Check whether a rq has a misfit task and if it looks like we can actually
> - * help that task: we can migrate the task to a CPU of higher capacity, or
> - * the task's current CPU is heavily pressured.
> + * help that task: we can migrate the task to a CPU of higher capacity.
>   */
> -static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> +static inline int check_misfit_status(struct rq *rq)
>  {
>  	return rq->misfit_task_load &&
> -		(capacity_greater(rq->rd->max_cpu_capacity, rq->cpu_capacity_orig) ||
> -		 check_cpu_capacity(rq, sd));
> +		capacity_greater(rq->rd->max_cpu_capacity, rq->cpu_capacity);
>  }
>  
>  /*
> @@ -10238,7 +10236,7 @@ static void nohz_balancer_kick(struct rq *rq)
>  		 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
>  		 * to run the misfit task on.
>  		 */
> -		if (check_misfit_status(rq, sd)) {
> +		if (check_misfit_status(rq)) {
>  			flags = NOHZ_KICK_MASK;
>  			goto unlock;
>  		}
> -- 
> 2.27.0
> 
