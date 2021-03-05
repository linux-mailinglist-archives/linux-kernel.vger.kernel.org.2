Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB25F32ECA4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 14:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhCEN42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 08:56:28 -0500
Received: from foss.arm.com ([217.140.110.172]:54574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhCEN4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 08:56:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C89D3101E;
        Fri,  5 Mar 2021 05:56:02 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0805A3F73B;
        Fri,  5 Mar 2021 05:56:00 -0800 (PST)
Date:   Fri, 5 Mar 2021 13:55:58 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com,
        fweisbec@gmail.com, tglx@linutronix.de
Subject: Re: [PATCH 3/7 v4] sched/fair: remove unused parameter of
 update_nohz_stats
Message-ID: <20210305135558.rorthawxu26q4o5y@e107158-lin.cambridge.arm.com>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
 <20210224133007.28644-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210224133007.28644-4-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/21 14:30, Vincent Guittot wrote:
> idle load balance is the only user of update_nohz_stats and doesn't use
> force parameter. Remove it
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e23709f6854b..f52f4dd3fb9e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8352,7 +8352,7 @@ group_type group_classify(unsigned int imbalance_pct,
>  	return group_has_spare;
>  }
>  
> -static bool update_nohz_stats(struct rq *rq, bool force)
> +static bool update_nohz_stats(struct rq *rq)
>  {
>  #ifdef CONFIG_NO_HZ_COMMON
>  	unsigned int cpu = rq->cpu;
> @@ -8363,7 +8363,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
>  	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
>  		return false;
>  
> -	if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
> +	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
>  		return true;
>  
>  	update_blocked_averages(cpu);
> @@ -10401,7 +10401,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>  
>  		rq = cpu_rq(balance_cpu);
>  
> -		has_blocked_load |= update_nohz_stats(rq, true);
> +		has_blocked_load |= update_nohz_stats(rq);

I think Dietmar commented on this on v1. There's a change in behavior here
AFAICT. Worth expanding the changelog to explain that this will be rate limited
and why it's okay? It'll help a lost soul like me who doesn't have the ins and
outs of this code carved in their head :-)

Thanks

--
Qais Yousef


>  
>  		/*
>  		 * If time for next balance is due,
> -- 
> 2.17.1
> 
