Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D9B3D2027
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhGVIHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:07:02 -0400
Received: from foss.arm.com ([217.140.110.172]:47724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhGVIHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:07:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91983113E;
        Thu, 22 Jul 2021 01:47:36 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9B3D3F73D;
        Thu, 22 Jul 2021 01:47:34 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] sched: Skip priority checks with
 SCHED_FLAG_KEEP_PARAMS
To:     Quentin Perret <qperret@google.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        qais.yousef@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20210719161656.3833943-1-qperret@google.com>
 <20210719161656.3833943-3-qperret@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ad30be79-8fb2-023d-9936-01f7173164e4@arm.com>
Date:   Thu, 22 Jul 2021 10:47:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719161656.3833943-3-qperret@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2021 18:16, Quentin Perret wrote:
> SCHED_FLAG_KEEP_PARAMS can be passed to sched_setattr to specify that
> the call must not touch scheduling parameters (nice or priority). This

What about DL params (runtime, deadline, period)?

Uclamp is not for DL but we could (*) still set uclamp values on a DL
task. Obviously they would only be used when the task switches policy.

On tip/sched/core:

root@juno:~# chrt -d -P 1000000000 -T 100000000 -p 0 1671

root@juno:~# uclampset -m200 -M400 -p 1671

root@juno:~# cat /proc/1671/sched | grep uclamp
uclamp.min                                   :                  200
uclamp.max                                   :                  400
effective uclamp.min                         :                  200
effective uclamp.max                         :                  400

root@juno:~# chrt -o -p 0
pid 1702's current scheduling policy: SCHED_OTHER
pid 1702's current scheduling priority: 0

root@juno:~# cat /proc/1671/sched | grep uclamp
uclamp.min                                   :                  200
uclamp.max                                   :                  400
effective uclamp.min                         :                  200
effective uclamp.max                         :                  400


> is particularly handy for uclamp when used in conjunction with
> SCHED_FLAG_KEEP_POLICY as that allows to issue a syscall that only
> impacts uclamp values.
> 
> However, sched_setattr always checks whether the priorities and nice
> values passed in sched_attr are valid first, even if those never get

+ DL params (__checkparam_dl())

> used down the line. This is useless at best since userspace can
> trivially bypass this check to set the uclamp values by specifying low
> priorities. However, it is cumbersome to do so as there is no single
> expression of this that skips both RT and CFS checks at once. As such,
> userspace needs to query the task policy first with e.g. sched_getattr
> and then set sched_attr.sched_priority accordingly. This is racy and
> slower than a single call.
> 
> As the priority and nice checks are useless when SCHED_FLAG_KEEP_PARAMS
> is specified, simply inherit them in this case to match the policy
> inheritance of SCHED_FLAG_KEEP_POLICY.
> 
> Reported-by: Wei Wang <wvw@google.com>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  kernel/sched/core.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e801d2c3077b..914076eab242 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7332,6 +7332,16 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
>  	return -E2BIG;
>  }
>  
> +static void get_params(struct task_struct *p, struct sched_attr *attr)
> +{
> +	if (task_has_dl_policy(p))
> +		__getparam_dl(p, attr);

(*) This changes the behaviour when setting uclamp values on a DL task.

Before uclamp values could be set but now, because of

  void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
    ..
    attr->sched_flags = dl_se->flags

SCHED_FLAG_UTIL_CLAMP gets overwritten and  __sched_setscheduler() bails in:

    if (unlikely(policy == p->policy)) {
      ...
      retval = 0;
      goto unlock;
    }
  change:

I.e. the:

      if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
        goto change;

can't trigger anymore.


> +	else if (task_has_rt_policy(p))
> +		attr->sched_priority = p->rt_priority;
> +	else
> +		attr->sched_nice = task_nice(p);
> +}
> +
>  /**
>   * sys_sched_setscheduler - set/change the scheduler policy and RT priority
>   * @pid: the pid in question.
> @@ -7393,6 +7403,8 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	rcu_read_unlock();
>  
>  	if (likely(p)) {
> +		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
> +			get_params(p, &attr);

SCHED_FLAG_KEEP_PARAMS is handled here but SCHED_FLAG_KEEP_POLICY
outside (before) the `if (likely(p))`?

>  		retval = sched_setattr(p, &attr);
>  		put_task_struct(p);
>  	}

[...]
