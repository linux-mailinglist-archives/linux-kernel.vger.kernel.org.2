Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFCE3AA221
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFPRLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:11:41 -0400
Received: from foss.arm.com ([217.140.110.172]:42388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhFPRLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:11:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC7F91042;
        Wed, 16 Jun 2021 10:09:33 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161D53F70D;
        Wed, 16 Jun 2021 10:09:31 -0700 (PDT)
Subject: Re: [PATCH] sched/uclamp: Fix uclamp_tg_restrict()
To:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Wei Wang <wvw@google.com>, Yun Hsiang <hsiang023167@gmail.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20210611122246.3475897-1-qais.yousef@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <0b47fb7f-c96b-c2d6-e5e4-9a63683d6d56@arm.com>
Date:   Wed, 16 Jun 2021 19:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611122246.3475897-1-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2021 14:22, Qais Yousef wrote:
> Now cpu.uclamp.min acts as a protection, we need to make sure that the
> uclamp request of the task is within the allowed range of the cgroup,
> that is it is clamp()'ed correctly by tg->uclamp[UCLAMP_MIN] and
> tg->uclamp[UCLAMP_MAX].
> 
> As reported by Xuewen [1] we can have some corner cases where there's
> inverstion between uclamp requested by task (p) and the uclamp values of

s/inverstion/inversion

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9e9a5be35cde..0318b00baa97 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1403,38 +1403,28 @@ static void uclamp_sync_util_min_rt_default(void)
>  static inline struct uclamp_se
>  uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
>  {
> -	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
> +	/* Copy by value as we could modify it */
> +	struct uclamp_se uc_eff = p->uclamp_req[clamp_id];
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
> +	unsigned int tg_min, tg_max, value;
>  
>  	/*
>  	 * Tasks in autogroups or root task group will be
>  	 * restricted by system defaults.
>  	 */
>  	if (task_group_is_autogroup(task_group(p)))
> -		return uc_req;
> +		return uc_eff;
>  	if (task_group(p) == &root_task_group)
> -		return uc_req;
> +		return uc_eff;
>  
> -	switch (clamp_id) {
> -	case UCLAMP_MIN: {
> -		struct uclamp_se uc_min = task_group(p)->uclamp[clamp_id];
> -		if (uc_req.value < uc_min.value)
> -			return uc_min;
> -		break;
> -	}
> -	case UCLAMP_MAX: {
> -		struct uclamp_se uc_max = task_group(p)->uclamp[clamp_id];
> -		if (uc_req.value > uc_max.value)
> -			return uc_max;
> -		break;
> -	}
> -	default:
> -		WARN_ON_ONCE(1);
> -		break;
> -	}
> +	tg_min = task_group(p)->uclamp[UCLAMP_MIN].value;
> +	tg_max = task_group(p)->uclamp[UCLAMP_MAX].value;
> +	value = uc_eff.value;
> +	value = clamp(value, tg_min, tg_max);
> +	uclamp_se_set(&uc_eff, value, false);
>  #endif
>  
> -	return uc_req;
> +	return uc_eff;
>  }

I got confused by the renaming uc_req -> uc_eff.

We have:

uclamp_eff_value()                                     (1)

  uclamp_se  uc_eff = uclamp_eff_get(p, clamp_id);     (2)

    uclamp_se uc_req = uclamp_tg_restrict(p, clamp_id) (3)

      struct uclamp_se uc_eff = p->uclamp_req[clamp_id];
      ....

(3) is now calling it uc_eff where (2) still uses uc_req for the return
of (3). IMHO uc_*eff* was used after the system level (
uclamp_default) have been applied.

[...]

> @@ -1670,10 +1659,8 @@ uclamp_update_active_tasks(struct cgroup_subsys_state *css,
>  
>  	css_task_iter_start(css, 0, &it);
>  	while ((p = css_task_iter_next(&it))) {
> -		for_each_clamp_id(clamp_id) {
> -			if ((0x1 << clamp_id) & clamps)
> -				uclamp_update_active(p, clamp_id);
> -		}
> +		for_each_clamp_id(clamp_id)
> +			uclamp_update_active(p, clamp_id);
>  	}
>  	css_task_iter_end(&it);
>  }
> @@ -9626,7 +9613,7 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
>  		}
>  
>  		/* Immediately update descendants RUNNABLE tasks */
> -		uclamp_update_active_tasks(css, clamps);
> +		uclamp_update_active_tasks(css);

Since we now always have to update both clamp_id's, can you not update
both under the same task_rq_lock() (in uclamp_update_active())?
