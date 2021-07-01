Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3E23B90A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhGAKwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:52:51 -0400
Received: from foss.arm.com ([217.140.110.172]:51238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhGAKwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:52:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB3F61063;
        Thu,  1 Jul 2021 03:50:18 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2403E3F718;
        Thu,  1 Jul 2021 03:50:17 -0700 (PDT)
Date:   Thu, 1 Jul 2021 11:50:14 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH v3 3/3] sched: Introduce RLIMIT_UCLAMP
Message-ID: <20210701105014.ewrg4nt5sn3eg57o@e107158-lin.cambridge.arm.com>
References: <20210623123441.592348-1-qperret@google.com>
 <20210623123441.592348-4-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210623123441.592348-4-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin

Thanks for the patch!

+CC Morten

On 06/23/21 12:34, Quentin Perret wrote:
> There is currently nothing preventing tasks from changing their per-task
> clamp values in anyway that they like. The rationale is probably that
> system administrators are still able to limit those clamps thanks to the
> cgroup interface. While this is probably fine in many systems where
> userspace apps are expected to drive their own power-performance, this
> causes pain in a system where both per-task and per-cgroup clamp values
> are expected to be under the control of core system components (as is
> the case for Android).

Yeah when there's a framework that wants full control of how uclamp is set for
each task/app, a mechanism to allow that is necessary.

> To fix this, let's introduce a new rlimit to control the uclamp
> behaviour. This allows unprivileged tasks to lower their uclamp
> requests, but not increase them unless they have been allowed to do so
> via rlimit. This is consistent with the existing behaviour for nice
> values or RT priorities.

I'm still trying to digest the full implications of this new API to be honest.
So take my comments with a pinch of salt from someone who's trying to build
a full mental picture of how all of this should really work :-)

At the moment we have: system wide sysctl trumps cgroup which in turn trumps
per-task requests.

The new RLIMIT_UCLAMP will be a layer below cgroup but above per-task, right?

And IIUC, you just want it to limit the per-task requests, it doesn't change
the currently set values. I think this is a crucial decision of this mechanism.

Is this usage of RLIMIT to constraints request without impacting the currently
set value accepted? It's not really limiting resources and it is acting as
a permission control since it doesn't impact the currently set value.

> 
> The default RLIMIT_UCLAMP is set to RLIMIT_INFINITY to keep the existing
> behaviour.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  fs/proc/base.c                      |  1 +
>  include/asm-generic/resource.h      |  1 +
>  include/uapi/asm-generic/resource.h |  3 +-
>  kernel/sched/core.c                 | 48 ++++++++++++++++++++++++-----
>  4 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9cbd915025ad..91a78cf1fe79 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -586,6 +586,7 @@ static const struct limit_names lnames[RLIM_NLIMITS] = {
>  	[RLIMIT_NICE] = {"Max nice priority", NULL},
>  	[RLIMIT_RTPRIO] = {"Max realtime priority", NULL},
>  	[RLIMIT_RTTIME] = {"Max realtime timeout", "us"},
> +	[RLIMIT_UCLAMP] = {"Max utilization clamp", NULL},

I think a single RLIMIT_UCLAMP is fine for pure permission control. But if we
have to do something with the currently requested values we'd need to split it
IMO.

>  };
>  
>  /* Display limits for a process */
> diff --git a/include/asm-generic/resource.h b/include/asm-generic/resource.h
> index 8874f681b056..53483b7cd4d7 100644
> --- a/include/asm-generic/resource.h
> +++ b/include/asm-generic/resource.h
> @@ -26,6 +26,7 @@
>  	[RLIMIT_NICE]		= { 0, 0 },				\
>  	[RLIMIT_RTPRIO]		= { 0, 0 },				\
>  	[RLIMIT_RTTIME]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
> +	[RLIMIT_UCLAMP]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
>  }
>  
>  #endif
> diff --git a/include/uapi/asm-generic/resource.h b/include/uapi/asm-generic/resource.h
> index f12db7a0da64..4d0fe4d564bf 100644
> --- a/include/uapi/asm-generic/resource.h
> +++ b/include/uapi/asm-generic/resource.h
> @@ -46,7 +46,8 @@
>  					   0-39 for nice level 19 .. -20 */
>  #define RLIMIT_RTPRIO		14	/* maximum realtime priority */
>  #define RLIMIT_RTTIME		15	/* timeout for RT tasks in us */
> -#define RLIM_NLIMITS		16
> +#define RLIMIT_UCLAMP		16	/* maximum utilization clamp */
> +#define RLIM_NLIMITS		17
>  
>  /*
>   * SuS says limits have to be unsigned.
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ad055fb9ed2d..b094da4c5fea 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1430,6 +1430,11 @@ static int uclamp_validate(struct task_struct *p,
>  	if (util_min != -1 && util_max != -1 && util_min > util_max)
>  		return -EINVAL;
>  
> +	return 0;
> +}
> +
> +static void uclamp_enable(void)
> +{
>  	/*
>  	 * We have valid uclamp attributes; make sure uclamp is enabled.
>  	 *
> @@ -1438,8 +1443,20 @@ static int uclamp_validate(struct task_struct *p,
>  	 * scheduler locks.
>  	 */
>  	static_branch_enable(&sched_uclamp_used);
> +}
>  
> -	return 0;
> +static bool can_uclamp(struct task_struct *p, int value, enum uclamp_id clamp_id)
> +{
> +	unsigned long uc_rlimit = task_rlimit(p, RLIMIT_UCLAMP);
> +
> +	if (value == -1) {
> +		if (rt_task(p) && clamp_id == UCLAMP_MIN)
> +			value = sysctl_sched_uclamp_util_min_rt_default;
> +		else
> +			value = uclamp_none(clamp_id);
> +	}
> +
> +	return value <= p->uclamp_req[clamp_id].value || value <= uc_rlimit;

Hmm why do we still need to prevent the task from changing the uclamp value
upward? It just shouldn't be outside the specified limit, no?

And I think there's a bug in this logic. If UCLAMP_MIN was 1024 then the
RLIMIT_UCLAMP was lowered to 512, the user will be able to change UCLAMP_MIN to
700 for example because of the

	return value <= p->uclamp_req[clamp_id].value || ...

I think we should just prevent the requested value to be above the limit. But
the user can lower and increase it within that range. ie: for RLIMIT_UCLAMP
= 512, any request in the [0:512] range is fine.

Also if we set RLIMIT_UCLAMP = 0, then the user will still be able to change
the uclamp value to 0, which is not what we want. We need a special value for
*all requests are invalid*.

I'm not against this, but my instinct tells me that the simple sysctl knob to
define the paranoia/priviliged level for uclamp is a lot simpler and more
straightforward control. I still can't get my head around the full implications
of the RLIMIT and what they should really deliver. It being a pure permission
control mechanism feels off to me and misusing its purpose.

Thanks

--
Qais Yousef

>  }
>  
>  static bool uclamp_reset(const struct sched_attr *attr,
> @@ -1580,6 +1597,11 @@ static inline int uclamp_validate(struct task_struct *p,
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline void uclamp_enable(void) { }
> +static bool can_uclamp(struct task_struct *p, int value, enum uclamp_id clamp_id)
> +{
> +	return true;
> +}
>  static void __setscheduler_uclamp(struct task_struct *p,
>  				  const struct sched_attr *attr) { }
>  static inline void uclamp_fork(struct task_struct *p) { }
> @@ -6116,6 +6138,13 @@ static int __sched_setscheduler(struct task_struct *p,
>  	    (rt_policy(policy) != (attr->sched_priority != 0)))
>  		return -EINVAL;
>  
> +	/* Update task specific "requested" clamps */
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
> +		retval = uclamp_validate(p, attr);
> +		if (retval)
> +			return retval;
> +	}
> +
>  	/*
>  	 * Allow unprivileged RT tasks to decrease priority:
>  	 */
> @@ -6165,6 +6194,15 @@ static int __sched_setscheduler(struct task_struct *p,
>  		/* Normal users shall not reset the sched_reset_on_fork flag: */
>  		if (p->sched_reset_on_fork && !reset_on_fork)
>  			return -EPERM;
> +
> +		/* Can't increase util-clamps */
> +		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN &&
> +		    !can_uclamp(p, attr->sched_util_min, UCLAMP_MIN))
> +			return -EPERM;
> +
> +		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
> +		    !can_uclamp(p, attr->sched_util_max, UCLAMP_MAX))
> +			return -EPERM;
>  	}
>  
>  	if (user) {
> @@ -6176,12 +6214,8 @@ static int __sched_setscheduler(struct task_struct *p,
>  			return retval;
>  	}
>  
> -	/* Update task specific "requested" clamps */
> -	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
> -		retval = uclamp_validate(p, attr);
> -		if (retval)
> -			return retval;
> -	}
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> +		uclamp_enable();
>  
>  	if (pi)
>  		cpuset_read_lock();
> -- 
> 2.32.0.288.g62a8d224e6-goog
> 
