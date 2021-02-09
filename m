Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED472315327
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 16:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhBIPtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 10:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhBIPtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 10:49:06 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3354DC061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 07:48:25 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id h8so8117197qkk.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 07:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v44wljKK9LleEe24eIdSYGfbeID6JGw9AQcEXahJDho=;
        b=cFjibUh8PzXqHUMu1ZogaUUS++qXMayAcUM7RxLQfstE9/UAJySaGtT/j4u02MmS3X
         e5i/omUfik2fgs1DaDDoL60Di5QFM2Gl1XXfhbvHHMyb5evWuyr7LVJ+XKk+iDPaUvsq
         ft3HI4YZD++qRZE31ybobG4r2EcRb2RkowzRu0tdZ6k8I5us45HpmQWA85enI6aBg0Ja
         HVGxiqAQ2qZMS8iAqF9cxsamBtfngEm+I34ncWJ3k+dJ6Xy9wPEPheCeHsK/7AndEwpX
         KMQYZtjEyd6aNetA95Cmtj70OPMguxXtTQSLiy2Rw1X1RG+Hk9b1r05vBx7rvbgXxuZS
         65XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v44wljKK9LleEe24eIdSYGfbeID6JGw9AQcEXahJDho=;
        b=K++REDrcoGu0uhQcz55VexKP84NIMvfR6nBXy0fQy5m2zIKnTIVSBfQQtPukC5pgrG
         svnqsieNYxFyCY0ujZK/jSqguiBiomxAIfVG1p2WTUG/oxF2R0wiCBS78lSNsEbtInjA
         E366xKd3ihqXLYuf+VJzU0ddtmNxjcoHgjuRMht05wG908X8IzOvNUftZ0Lw10r4+aH4
         RSj2lvS3E5Jy0V9HdXUMMskhiVmP/PgDU/txNdglU2RGKSl2S2vjLoTJ27U9H9/7ZcpE
         4jKV+djcJKEH36lPewHZ3UYcCQb8uhSB6BENw/8YUZH7GZmIg5387Nx6R2QKcHntcuiC
         46Mw==
X-Gm-Message-State: AOAM532JK3WyOK8/Azjh4GC8oclyhptTg2gDt6V1kpRVVN48M4TURJbS
        iwUvs1A9Rh0Gto2CAxrfn8rM6w==
X-Google-Smtp-Source: ABdhPJzGbaWigN1rY+mOyiAFrwOSI+OqzDFWL40/A7S2+HuximvapCByJXSGEObox22CxWz+xKgrdw==
X-Received: by 2002:a05:620a:410f:: with SMTP id j15mr22773462qko.424.1612885704439;
        Tue, 09 Feb 2021 07:48:24 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id v30sm1259811qte.26.2021.02.09.07.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 07:48:23 -0800 (PST)
Date:   Tue, 9 Feb 2021 10:48:22 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v2] psi: Remove the redundant psi_task_tick
Message-ID: <YCKuxoPnm/RFI18O@cmpxchg.org>
References: <20210209071033.16989-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209071033.16989-1-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chengming,

On Tue, Feb 09, 2021 at 03:10:33PM +0800, Chengming Zhou wrote:
> When the current task in a cgroup is in_memstall, the corresponding groupc
> on that cpu is in PSI_MEM_FULL state, so we can exploit that to remove the
> redundant psi_task_tick from scheduler_tick to save this periodic cost.

Can you please update the patch name and the changelog to the new
version of the patch? It's not removing the redundant tick, it's
moving the reclaim detection from the timer tick to the task state
tracking machinery using the recently added ONCPU state.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  include/linux/psi.h  |  1 -
>  kernel/sched/core.c  |  1 -
>  kernel/sched/psi.c   | 49 ++++++++++++++-----------------------------------
>  kernel/sched/stats.h |  9 ---------
>  4 files changed, 14 insertions(+), 46 deletions(-)
> 
> diff --git a/include/linux/psi.h b/include/linux/psi.h
> index 7361023f3fdd..65eb1476ac70 100644
> --- a/include/linux/psi.h
> +++ b/include/linux/psi.h
> @@ -20,7 +20,6 @@ void psi_task_change(struct task_struct *task, int clear, int set);
>  void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		     bool sleep);
>  
> -void psi_memstall_tick(struct task_struct *task, int cpu);
>  void psi_memstall_enter(unsigned long *flags);
>  void psi_memstall_leave(unsigned long *flags);
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 15d2562118d1..31788a9b335b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4533,7 +4533,6 @@ void scheduler_tick(void)
>  	update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure);
>  	curr->sched_class->task_tick(rq, curr, 0);
>  	calc_global_load_tick(rq);
> -	psi_task_tick(rq);
>  
>  	rq_unlock(rq, &rf);
>  
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 2293c45d289d..6e46d9eb279b 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -644,8 +644,7 @@ static void poll_timer_fn(struct timer_list *t)
>  	wake_up_interruptible(&group->poll_wait);
>  }
>  
> -static void record_times(struct psi_group_cpu *groupc, int cpu,
> -			 bool memstall_tick)
> +static void record_times(struct psi_group_cpu *groupc, int cpu)
>  {
>  	u32 delta;
>  	u64 now;
> @@ -664,23 +663,6 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
>  		groupc->times[PSI_MEM_SOME] += delta;
>  		if (groupc->state_mask & (1 << PSI_MEM_FULL))
>  			groupc->times[PSI_MEM_FULL] += delta;
> -		else if (memstall_tick) {
> -			u32 sample;
> -			/*
> -			 * Since we care about lost potential, a
> -			 * memstall is FULL when there are no other
> -			 * working tasks, but also when the CPU is
> -			 * actively reclaiming and nothing productive
> -			 * could run even if it were runnable.
> -			 *
> -			 * When the timer tick sees a reclaiming CPU,
> -			 * regardless of runnable tasks, sample a FULL
> -			 * tick (or less if it hasn't been a full tick
> -			 * since the last state change).
> -			 */
> -			sample = min(delta, (u32)jiffies_to_nsecs(1));
> -			groupc->times[PSI_MEM_FULL] += sample;
> -		}
>  	}
>  
>  	if (groupc->state_mask & (1 << PSI_CPU_SOME)) {
> @@ -714,7 +696,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  	 */
>  	write_seqcount_begin(&groupc->seq);
>  
> -	record_times(groupc, cpu, false);
> +	record_times(groupc, cpu);
>  
>  	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
>  		if (!(m & (1 << t)))
> @@ -738,6 +720,18 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  		if (test_state(groupc->tasks, s))
>  			state_mask |= (1 << s);
>  	}
> +
> +	/*
> +	 * Since we care about lost potential, a memstall is FULL
> +	 * when there are no other working tasks, but also when
> +	 * the CPU is actively reclaiming and nothing productive
> +	 * could run even if it were runnable. So when the current
> +	 * task in a cgroup is in_memstall, the corresponding groupc
> +	 * on that cpu is in PSI_MEM_FULL state.
> +	 */
> +	if (groupc->tasks[NR_ONCPU] && cpu_curr(cpu)->in_memstall)
> +		state_mask |= (1 << PSI_MEM_FULL);

This doesn't really work with the psi_task_switch() optimization. If
we switch between two tasks inside a leaf group, where one is memstall
and the other is not, we don't update the parents properly. So you
need another branch in there as well for checking memstall. At which
point the timer tick implementation is likely cheaper and simpler...

> @@ -144,14 +144,6 @@ static inline void psi_sched_switch(struct task_struct *prev,
>  	psi_task_switch(prev, next, sleep);
>  }
>  
> -static inline void psi_task_tick(struct rq *rq)
> -{
> -	if (static_branch_likely(&psi_disabled))
> -		return;
> -
> -	if (unlikely(rq->curr->in_memstall))
> -		psi_memstall_tick(rq->curr, cpu_of(rq));
> -}
>  #else /* CONFIG_PSI */
>  static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}
>  static inline void psi_dequeue(struct task_struct *p, bool sleep) {}
