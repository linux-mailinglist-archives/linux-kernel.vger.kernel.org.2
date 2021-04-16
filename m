Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38511362178
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbhDPNvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbhDPNvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 09:51:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AADC061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:51:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s7so26677795wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xRM3MnZum00TjXyXV395BHIoejSmJkmsUoaS2chuhuQ=;
        b=CaNBeNgCW6UgczdXmgMA1lJ/t0J0+HsLZ2PA0dN6277iAR8q1wFCSHk6BiONc5AC0D
         ZHVUohYzvswqhtu4n4XSfnETFPlFiKTINknsTDo4LyGPn/xShws9LdS5URWj3MqyAPDH
         66TpuCOePPPZ9Em70+jzKHEEJWLfE9J6b0gSZQLYZ2cK2aQh3tz0GDGwWCH9BYFC9lI2
         S4Uh+J6mDSWhwG9RKFlCA/8INQlCwjh7+XaujIMvnN5d5J82ZN2O79rCDCzHT6+RSe4v
         NZoYGa26kwvLJQCh6N/f1FjfHzTnloi1eSs+nrkZbcWf3NI8pH73s6iUP/WAeEOeK391
         +Opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xRM3MnZum00TjXyXV395BHIoejSmJkmsUoaS2chuhuQ=;
        b=Jd7+0enMEFgr3Mc0/8Zd0w4vqIFUKnQOqSNB/WN7pKn1fwWuy5oHt8zwxl1evoal/9
         1XHTjPfAqW5q0STRobafiAdWm+3EnNcKfs24Zc/K9B7sj1I59TiJtPTdG8t3H23LQh4k
         Nblht6j4YdB22Tw5ckoU+oePrPd1amDq33hWc0iNsUshPi7ZU8pgTadKtlfsDRCFRR1N
         kZITdNEalJPuO9oEY9gvXXhL+X2UU+SmZXGp21veBXRH/AAuiELgDSzsJfIhtY/5EhHq
         oHCiJUbcY8gtHuKqOraBk88k9LrbG6Avbn4coc2ZPHYglDkQivUhRHVgEr0oeYRxVS9P
         lIog==
X-Gm-Message-State: AOAM530jrogwcApV/AiI5glvzLhd7/jPYJX4vowplLFMgKmj0b3edXLQ
        v+wzi3erJDqAxy61NjHQD6Xe9jMFAVZuDQ==
X-Google-Smtp-Source: ABdhPJygJ+/KhuGuCr2HXJEzE1TV1CQZFbUOR9oif4KtUZXL7r0sVkEWg/a397ZUbg/wzpl7pI9yvw==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr8944409wrw.289.1618581075991;
        Fri, 16 Apr 2021 06:51:15 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:2c7d:7c51:7cb2:ccb2])
        by smtp.gmail.com with ESMTPSA id o18sm8811960wmp.26.2021.04.16.06.51.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Apr 2021 06:51:15 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:51:13 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH 2/2] sched/fair: Relax task_hot() for misfit tasks
Message-ID: <20210416135113.GA16445@vingu-book>
References: <20210415175846.494385-1-valentin.schneider@arm.com>
 <20210415175846.494385-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210415175846.494385-3-valentin.schneider@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 15 avril 2021 à 18:58:46 (+0100), Valentin Schneider a écrit :
> Consider the following topology:
> 
>   DIE [          ]
>   MC  [    ][    ]
>        0  1  2  3
> 
>   capacity_orig_of(x \in {0-1}) < capacity_orig_of(x \in {2-3})
> 
> w/ CPUs 2-3 idle and CPUs 0-1 running CPU hogs (util_avg=1024).
> 
> When CPU2 goes through load_balance() (via periodic / NOHZ balance), it
> should pull one CPU hog from either CPU0 or CPU1 (this is misfit task
> upmigration). However, should a e.g. pcpu kworker awake on CPU0 just before
> this load_balance() happens and preempt the CPU hog running there, we would
> have, for the [0-1] group at CPU2's DIE level:
> 
> o sgs->sum_nr_running > sgs->group_weight
> o sgs->group_capacity * 100 < sgs->group_util * imbalance_pct
> 
> IOW, this group is group_overloaded.
> 
> Considering CPU0 is picked by find_busiest_queue(), we would then visit the
> preempted CPU hog in detach_tasks(). However, given it has just been
> preempted by this pcpu kworker, task_hot() will prevent it from being
> detached. We then leave load_balance() without having done anything.
> 
> Long story short, preempted misfit tasks are affected by task_hot(), while
> currently running misfit tasks are intentionally preempted by the stopper
> task to migrate them over to a higher-capacity CPU.
> 
> Align detach_tasks() with the active-balance logic and let it pick a
> cache-hot misfit task when the destination CPU can provide a capacity
> uplift.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d2d1a69d7aa7..43fc98d34276 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7493,6 +7493,7 @@ struct lb_env {
>  	enum fbq_type		fbq_type;
>  	enum migration_type	migration_type;
>  	enum group_type         src_grp_type;
> +	enum group_type         dst_grp_type;
>  	struct list_head	tasks;
>  };
>  
> @@ -7533,6 +7534,31 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>  	return delta < (s64)sysctl_sched_migration_cost;
>  }
>  
> +
> +/*
> + * What does migrating this task do to our capacity-aware scheduling criterion?
> + *
> + * Returns 1, if the task needs more capacity than the dst CPU can provide.
> + * Returns 0, if the task needs the extra capacity provided by the dst CPU
> + * Returns -1, if the task isn't impacted by the migration wrt capacity.
> + */
> +static int migrate_degrades_capacity(struct task_struct *p, struct lb_env *env)
> +{
> +	if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
> +		return -1;
> +
> +	if (!task_fits_capacity(p, capacity_of(env->src_cpu))) {
> +		if (cpu_capacity_greater(env->dst_cpu, env->src_cpu))
> +			return 0;
> +		else if (cpu_capacity_greater(env->src_cpu, env->dst_cpu))
> +			return 1;
> +		else
> +			return -1;
> +	}

Being there means that task fits src_cpu capacity so why testing p against dst_cpu ?

> +
> +	return task_fits_capacity(p, capacity_of(env->dst_cpu)) ? -1 : 1;
> +}

I prefer the below which easier to read because the same var is use everywhere and you can remove cpu_capacity_greater.

static int migrate_degrades_capacity(struct task_struct *p, struct lb_env *env)
{
    unsigned long src_capacity, dst_capacity;

    if (!(env->sd->flags & SD_ASYM_CPUCAPACITY))
        return -1;

    src_capacity = capacity_of(env->src_cpu);
    dst_capacity = capacity_of(env->dst_cpu);

    if (!task_fits_capacity(p, src_capacity)) {
        if (capacity_greater(dst_capacity, src_capacity))
            return 0;
        else if (capacity_greater(src_capacity, dst_capacity))
            return 1;
        else
            return -1;
    }

    return task_fits_capacity(p, dst_capacity) ? -1 : 1;
}


> +
>  #ifdef CONFIG_NUMA_BALANCING
>  /*
>   * Returns 1, if task migration degrades locality
> @@ -7672,6 +7698,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	if (tsk_cache_hot == -1)
>  		tsk_cache_hot = task_hot(p, env);
>  
> +	/*
> +	 * On a (sane) asymmetric CPU capacity system, the increase in compute
> +	 * capacity should offset any potential performance hit caused by a
> +	 * migration.
> +	 */
> +	if ((env->dst_grp_type == group_has_spare) &&

Shouldn't it be env->src_grp_type == group_misfit_task to only care of misfit task case as
stated in $subject


> +	    !migrate_degrades_capacity(p, env))
> +		tsk_cache_hot = 0;
> +
>  	if (tsk_cache_hot <= 0 ||
>  	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
>  		if (tsk_cache_hot == 1) {
> @@ -9310,6 +9345,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	if (!sds.busiest)
>  		goto out_balanced;
>  
> +	env->dst_grp_type = local->group_type;
>  	env->src_grp_type = busiest->group_type;
>  
>  	/* Misfit tasks should be dealt with regardless of the avg load */
> -- 
> 2.25.1
> 
