Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AB930DE05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhBCPXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:23:10 -0500
Received: from foss.arm.com ([217.140.110.172]:41820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233322AbhBCPPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:15:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41DCD12FC;
        Wed,  3 Feb 2021 07:14:33 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E54373F73B;
        Wed,  3 Feb 2021 07:14:31 -0800 (PST)
Date:   Wed, 3 Feb 2021 15:14:29 +0000
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
Subject: Re: [PATCH 1/8] sched/fair: Clean up active balance
 nr_balance_failed trickery
Message-ID: <20210203151429.rnbdgt7wyoaz2vui@e107158-lin>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128183141.28097-2-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin

On 01/28/21 18:31, Valentin Schneider wrote:
> When triggering an active load balance, sd->nr_balance_failed is set to
> such a value that any further can_migrate_task() using said sd will ignore
> the output of task_hot().
> 
> This behaviour makes sense, as active load balance intentionally preempts a
> rq's running task to migrate it right away, but this asynchronous write is
> a bit shoddy, as the stopper thread might run active_load_balance_cpu_stop
> before the sd->nr_balance_failed write either becomes visible to the
> stopper's CPU or even happens on the CPU that appended the stopper work.
> 
> Add a struct lb_env flag to denote active balancing, and use it in
> can_migrate_task(). Remove the sd->nr_balance_failed write that served the
> same purpose.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 197a51473e0c..0f6a4e58ce3c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7423,6 +7423,7 @@ enum migration_type {
>  #define LBF_SOME_PINNED	0x08
>  #define LBF_NOHZ_STATS	0x10
>  #define LBF_NOHZ_AGAIN	0x20
> +#define LBF_ACTIVE_LB	0x40
>  
>  struct lb_env {
>  	struct sched_domain	*sd;
> @@ -7608,10 +7609,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  
>  	/*
>  	 * Aggressive migration if:
> -	 * 1) destination numa is preferred
> -	 * 2) task is cache cold, or
> -	 * 3) too many balance attempts have failed.
> +	 * 1) active balance
> +	 * 2) destination numa is preferred
> +	 * 3) task is cache cold, or
> +	 * 4) too many balance attempts have failed.
>  	 */
> +	if (env->flags & LBF_ACTIVE_LB)
> +		return 1;
> +
>  	tsk_cache_hot = migrate_degrades_locality(p, env);
>  	if (tsk_cache_hot == -1)
>  		tsk_cache_hot = task_hot(p, env);
> @@ -9805,9 +9810,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  					active_load_balance_cpu_stop, busiest,
>  					&busiest->active_balance_work);
>  			}
> -
> -			/* We've kicked active balancing, force task migration. */
> -			sd->nr_balance_failed = sd->cache_nice_tries+1;

This has an impact on future calls to need_active_balance() too, no? We enter
this path because need_active_balance() returned true; one of the conditions it
checks for is

	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);

So since we used to reset nr_balanced_failed to cache_nice_tries+1, the above
condition would be false in the next call or two IIUC. But since we remove
that, we could end up here again soon.

Was this intentional?

Thanks

--
Qais Yousef

>  		}
>  	} else {
>  		sd->nr_balance_failed = 0;
> @@ -9963,7 +9965,8 @@ static int active_load_balance_cpu_stop(void *data)
>  			 * @dst_grpmask we need to make that test go away with lying
>  			 * about DST_PINNED.
>  			 */
> -			.flags		= LBF_DST_PINNED,
> +			.flags		= LBF_DST_PINNED |
> +					  LBF_ACTIVE_LB,
>  		};
>  
>  		schedstat_inc(sd->alb_count);
> -- 
> 2.27.0
> 
