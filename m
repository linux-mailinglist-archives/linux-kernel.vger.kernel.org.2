Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CAC3B9135
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbhGALfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:35:07 -0400
Received: from foss.arm.com ([217.140.110.172]:51996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236130AbhGALfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:35:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 289E66D;
        Thu,  1 Jul 2021 04:32:36 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E9EE3F718;
        Thu,  1 Jul 2021 04:32:34 -0700 (PDT)
Date:   Thu, 1 Jul 2021 12:32:32 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     valentin.schneider@arm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, qperret@google.com
Subject: Re: [PATCH v2] sched/uclamp: Avoid getting unreasonable ucalmp value
 when rq is idle
Message-ID: <20210701113232.quqmxjy22udr2hfb@e107158-lin.cambridge.arm.com>
References: <20210630141204.8197-1-xuewen.yan94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210630141204.8197-1-xuewen.yan94@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/21 22:12, Xuewen Yan wrote:
> From: Xuewen Yan <xuewen.yan@unisoc.com>
> 
> Now in uclamp_rq_util_with(), when the task != NULL, the uclamp_max as following:
> uc_rq_max = rq->uclamp[UCLAMP_MAX].value;
> uc_eff_max = uclamp_eff_value(p, UCLAMP_MAX);
> uclamp_max = max{uc_rq_max, uc_eff_max};
> 
> Consider the following scenario:
> (1)the rq is idle, the uc_rq_max is last runnable task's UCLAMP_MAX;
> (2)the p's uc_eff_max < uc_rq_max.
> 
> As a result, the uclamp_max = uc_rq_max instead of uc_eff_max, it is unreasonable.
> 
> The scenario often happens in find_energy_efficient_cpu(), when the task has smaller UCLAMP_MAX.
> 
> When rq has UCLAMP_FLAG_IDLE flag, enqueuing the task will lift UCLAMP_FLAG_IDLE
> and set the rq clamp as the task's via uclamp_idle_reset(). It doesn't need
> to read the rq clamp. And it can also avoid the problems described above.
> 
> Fixes: 9d20ad7dfc9a ("sched/uclamp: Add uclamp_util_with()")
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> 
> ---
> change v2:
> 	*add Fixes(Valentin Schneider);
> 	*ignore all rq clamp when idle (Valentin Schneider)
> ---
>  kernel/sched/sched.h | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index c80d42e9589b..14a41a243f7b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2818,20 +2818,27 @@ static __always_inline
>  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>  				  struct task_struct *p)
>  {
> -	unsigned long min_util;
> -	unsigned long max_util;
> +	unsigned long min_util = 0;
> +	unsigned long max_util = 0;
>  
>  	if (!static_branch_likely(&sched_uclamp_used))
>  		return util;
>  
> -	min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
> -	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
> -
>  	if (p) {
> -		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
> -		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
> +		min_util = uclamp_eff_value(p, UCLAMP_MIN);
> +		max_util = uclamp_eff_value(p, UCLAMP_MAX);
> +
> +		/*
> +		 * Ignore last runnable task's max clamp, as this task will
> +		 * reset it. Similarly, no need to read the rq's min clamp.
> +		 */
> +		if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> +			goto out;

We read rq->uclamp_flags without locks here. Me thinks this needs READ_ONCE().
But since we care only about a single bit, I can't see any risk for
inconsistency, so we're fine.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks!

--
Qais Yousef

>  	}
>  
> +	min_util = max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[UCLAMP_MIN].value));
> +	max_util = max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[UCLAMP_MAX].value));
> +out:
>  	/*
>  	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
>  	 * RUNNABLE tasks with _different_ clamps, we can end up with an
> -- 
> 2.25.1
> 
