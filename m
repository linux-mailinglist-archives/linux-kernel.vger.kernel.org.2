Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD830DDF9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhBCPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:20:47 -0500
Received: from foss.arm.com ([217.140.110.172]:41994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234283AbhBCPSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:18:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C399C12FC;
        Wed,  3 Feb 2021 07:17:22 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71E3F3F73B;
        Wed,  3 Feb 2021 07:17:21 -0800 (PST)
Date:   Wed, 3 Feb 2021 15:17:18 +0000
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
Subject: Re: [PATCH 8/8] sched/fair: Relax task_hot() for misfit tasks
Message-ID: <20210203151718.fg5idcfqbdqhkrah@e107158-lin>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
 <20210128183141.28097-9-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210128183141.28097-9-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/21 18:31, Valentin Schneider wrote:
> Misfit tasks can and will be preempted by the stopper to migrate them over
> to a higher-capacity CPU. However, when runnable but not current misfit
> tasks are scanned by the load balancer (i.e. detach_tasks()), the
> task_hot() ratelimiting logic may prevent us from enqueuing said task onto
> a higher-capacity CPU.
> 
> Align detach_tasks() with the active-balance logic and let it pick a
> cache-hot misfit task when the destination CPU can provide a capacity
> uplift.

Good catch.

> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cba9f97d9beb..c2351b87824f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7484,6 +7484,17 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>  	if (env->sd->flags & SD_SHARE_CPUCAPACITY)
>  		return 0;
>  
> +	/*
> +	 * On a (sane) asymmetric CPU capacity system, the increase in compute
> +	 * capacity should offset any potential performance hit caused by a
> +	 * migration.
> +	 */
> +	if (sd_has_asym_cpucapacity(env->sd) &&
> +	    env->idle != CPU_NOT_IDLE &&
> +	    !task_fits_capacity(p, capacity_of(env->src_cpu)) &&

Note for a very busy task that is running on the biggest cpu this will always
return true.

> +	    cpu_capacity_greater(env->dst_cpu, env->src_cpu))

But this will save us from triggering unnecessary migration.

We could swap them and optimize for this particular case, but tbh this is the
type of micro optimization that is hard to know whether it makes a real
difference or not..

Anyways, this looks good to me.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks

--
Qais Yousef

> +		return 0;
> +
>  	/*
>  	 * Buddy candidates are cache hot:
>  	 */
> -- 
> 2.27.0
> 
