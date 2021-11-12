Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FB944EB44
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhKLQXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhKLQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:23:04 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1DCC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:20:13 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v64so25030151ybi.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSyi1t+zt7tAuow8W+db8Y7S8jqQDHW6kMj3Q06p+Fc=;
        b=Y/ck4UPeh/tDdtb/TfLTArPFbN8OSGZKbqnyMx0nYs1D/pYNmnE3Mo99bEcSq5Lh3X
         uOcFx8HL1JYU8IPxkNa9kTzxQCOF14vALCvBryM0tkzYcDvOhApt2kM59wVyc8JUyQMR
         Z2mlDTMUqS5grpf3xPifrXyauieSVOhXxyusOYS8o/XX6YQR6pUBto8n+j1C7yY+Rd+S
         4prIuBlnizjHIda1ZIlOgHQ0DvJvQ5zdYjmP2jiQRrmb5IA7+Tsc8HZ9YSqJiYiPfiuO
         ycFLhg02Idzbqr7dV9YsdhtO9Hru/lIxDp6DsaG7RJbIhXwhdtn6C2kXCyrjyZc964iM
         oK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSyi1t+zt7tAuow8W+db8Y7S8jqQDHW6kMj3Q06p+Fc=;
        b=d1PHnKzJFc0VS/MDITN/2gx7gUVj86vFEzRf18yfLqteM8t60g5EcctDZZIADqeELY
         7LDXfTPpA8Gvkj6vAZYRIcxwCFqK+1rByK/4DEwUtN614puGKUleyLQqdAEDfhd9r+lh
         IdbnE9r4L8jyyD04wUP8caVOmOwpLVTyP81Ld4LVLuj0TAlptX8DH4HKDHdw3RJv2qms
         pSiDVZto5jz2oKl/ql4EBGBR43nJyKjMRfV12GHy64DsMdZObtdJl4rqzxysQ1wwnHk6
         dkgU/dhwVbpniU4Iyg3pD5YUoWSpg1LH5dSYXzuRsVFMNwRg8xsqbMLnEBQM370BNDVK
         2z6w==
X-Gm-Message-State: AOAM531kB2K1G+JKq86ocjavfySFFFALR5MPRIhACmqn1QvoYaVFCuuG
        /LbbexAe9qH/vh+j8rjxnvm0Ci0F+YTWsZhHW4822A==
X-Google-Smtp-Source: ABdhPJwJxtIwdQ/xSKQABzzt8kLR95aNau3y+yUXGVRt1mVVdmtJKv4q2X+T5mddzB7ECDN2NEMJvYldPNPIKI92LSw=
X-Received: by 2002:a25:f205:: with SMTP id i5mr18301171ybe.61.1636734012862;
 Fri, 12 Nov 2021 08:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20211112141349.155713-1-dietmar.eggemann@arm.com>
In-Reply-To: <20211112141349.155713-1-dietmar.eggemann@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 12 Nov 2021 17:20:01 +0100
Message-ID: <CAKfTPtCzP_Xgos-yAiUxnKw_BvP22P5CH3xJjLiUQLeg0a-AxQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Replace CFS internal cpu_util() with cpu_util_cfs()
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021 at 15:14, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> cpu_util_cfs() was created by commit d4edd662ac16 ("sched/cpufreq: Use
> the DEADLINE utilization signal") to enable the access to CPU
> utilization from the Schedutil CPUfreq governor.
>
> Commit a07630b8b2c1 ("sched/cpufreq/schedutil: Use util_est for OPP
> selection") added util_est support later.
>
> The only thing cpu_util() is doing on top of what cpu_util_cfs() already
> does is to clamp the return value to the [0..capacity_orig] capacity
> range of the CPU. Integrating this into cpu_util_cfs() is not harming
> the existing users (Schedutil and CPUfreq cooling (latter via
> sched_cpu_util() wrapper)).

Could you to update cpu_util_cfs() to use cpu as a parameter instead of rq ?

>
> Remove cpu_util().
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>
> I deliberately got rid of the comment on top of cpu_util(). It's from
> the early days of using PELT utilization, it describes CPU utilization
> behaviour before PELT time-scaling and talks about current capacity
> which we don't maintain.

would be good to keep an updated version in this case. There are lot
of interesting informations in the comment

>
>  kernel/sched/fair.c  | 65 ++++----------------------------------------
>  kernel/sched/sched.h |  2 +-
>  2 files changed, 6 insertions(+), 61 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 13950beb01a2..7a815b10c0c3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1502,7 +1502,6 @@ struct task_numa_env {
>
>  static unsigned long cpu_load(struct rq *rq);
>  static unsigned long cpu_runnable(struct rq *rq);
> -static unsigned long cpu_util(int cpu);
>  static inline long adjust_numa_imbalance(int imbalance,
>                                         int dst_running, int dst_weight);
>
> @@ -1569,7 +1568,7 @@ static void update_numa_stats(struct task_numa_env *env,
>
>                 ns->load += cpu_load(rq);
>                 ns->runnable += cpu_runnable(rq);
> -               ns->util += cpu_util(cpu);
> +               ns->util += cpu_util_cfs(rq);
>                 ns->nr_running += rq->cfs.h_nr_running;
>                 ns->compute_capacity += capacity_of(cpu);
>
> @@ -5509,11 +5508,9 @@ static inline void hrtick_update(struct rq *rq)
>  #endif
>
>  #ifdef CONFIG_SMP
> -static inline unsigned long cpu_util(int cpu);
> -
>  static inline bool cpu_overutilized(int cpu)
>  {
> -       return !fits_capacity(cpu_util(cpu), capacity_of(cpu));
> +       return !fits_capacity(cpu_util_cfs(cpu_rq(cpu)), capacity_of(cpu));
>  }
>
>  static inline void update_overutilized_status(struct rq *rq)
> @@ -6456,58 +6453,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         return target;
>  }
>
> -/**
> - * cpu_util - Estimates the amount of capacity of a CPU used by CFS tasks.
> - * @cpu: the CPU to get the utilization of
> - *
> - * The unit of the return value must be the one of capacity so we can compare
> - * the utilization with the capacity of the CPU that is available for CFS task
> - * (ie cpu_capacity).
> - *
> - * cfs_rq.avg.util_avg is the sum of running time of runnable tasks plus the
> - * recent utilization of currently non-runnable tasks on a CPU. It represents
> - * the amount of utilization of a CPU in the range [0..capacity_orig] where
> - * capacity_orig is the cpu_capacity available at the highest frequency
> - * (arch_scale_freq_capacity()).
> - * The utilization of a CPU converges towards a sum equal to or less than the
> - * current capacity (capacity_curr <= capacity_orig) of the CPU because it is
> - * the running time on this CPU scaled by capacity_curr.
> - *
> - * The estimated utilization of a CPU is defined to be the maximum between its
> - * cfs_rq.avg.util_avg and the sum of the estimated utilization of the tasks
> - * currently RUNNABLE on that CPU.
> - * This allows to properly represent the expected utilization of a CPU which
> - * has just got a big task running since a long sleep period. At the same time
> - * however it preserves the benefits of the "blocked utilization" in
> - * describing the potential for other tasks waking up on the same CPU.
> - *
> - * Nevertheless, cfs_rq.avg.util_avg can be higher than capacity_curr or even
> - * higher than capacity_orig because of unfortunate rounding in
> - * cfs.avg.util_avg or just after migrating tasks and new task wakeups until
> - * the average stabilizes with the new running time. We need to check that the
> - * utilization stays within the range of [0..capacity_orig] and cap it if
> - * necessary. Without utilization capping, a group could be seen as overloaded
> - * (CPU0 utilization at 121% + CPU1 utilization at 80%) whereas CPU1 has 20% of
> - * available capacity. We allow utilization to overshoot capacity_curr (but not
> - * capacity_orig) as it useful for predicting the capacity required after task
> - * migrations (scheduler-driven DVFS).
> - *
> - * Return: the (estimated) utilization for the specified CPU
> - */
> -static inline unsigned long cpu_util(int cpu)
> -{
> -       struct cfs_rq *cfs_rq;
> -       unsigned int util;
> -
> -       cfs_rq = &cpu_rq(cpu)->cfs;
> -       util = READ_ONCE(cfs_rq->avg.util_avg);
> -
> -       if (sched_feat(UTIL_EST))
> -               util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));
> -
> -       return min_t(unsigned long, util, capacity_orig_of(cpu));
> -}
> -
>  /*
>   * cpu_util_without: compute cpu utilization without any contributions from *p
>   * @cpu: the CPU which utilization is requested
> @@ -6528,7 +6473,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
>
>         /* Task has no contribution or is new */
>         if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
> -               return cpu_util(cpu);
> +               return cpu_util_cfs(cpu_rq(cpu));
>
>         cfs_rq = &cpu_rq(cpu)->cfs;
>         util = READ_ONCE(cfs_rq->avg.util_avg);
> @@ -8681,7 +8626,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 struct rq *rq = cpu_rq(i);
>
>                 sgs->group_load += cpu_load(rq);
> -               sgs->group_util += cpu_util(i);
> +               sgs->group_util += cpu_util_cfs(rq);
>                 sgs->group_runnable += cpu_runnable(rq);
>                 sgs->sum_h_nr_running += rq->cfs.h_nr_running;
>
> @@ -9699,7 +9644,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                         break;
>
>                 case migrate_util:
> -                       util = cpu_util(cpu_of(rq));
> +                       util = cpu_util_cfs(rq);
>
>                         /*
>                          * Don't try to pull utilization from a CPU with one
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index f0b249ec581d..d49eda251049 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2951,7 +2951,7 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
>                              READ_ONCE(rq->cfs.avg.util_est.enqueued));
>         }
>
> -       return util;
> +       return min(util, capacity_orig_of(cpu_of(rq)));
>  }
>
>  static inline unsigned long cpu_util_rt(struct rq *rq)
> --
> 2.25.1
>
