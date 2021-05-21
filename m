Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD3C38C6A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhEUMjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhEUMj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:39:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23827C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:38:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id m11so29484794lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZXva6/Yqd6IA9/jgqhzQ7W+jI1PpNOShUWjkaZh4eNg=;
        b=UO7OnFKW+cPB2rAq5pwSBGynYvW9d+KTX4VcKj+eDu4Ewh8UKm6/64i3qCm28ZzArB
         lG7M1a2COavXBwDHvV2rJmXzg2os/APTEPYFB2bzNvUHwdgz5nepaLqGQIq6VLbEa5gZ
         c1FQQHh6DFIbPbAwqA6UFiLvh0ty4mq4UT8lCMSp1n6il/CPP9vQQHphhDC70O6KTu/f
         j+3nx0Hfw+kgYFppUvHbmWFhNgwwgYKAjTO87HbW7gkcb6PqCWaqtpAZ89FK+HmGr4w5
         8lZvS6Wg45qQgoxhV4lfTXYDhnCYyuAG4Fc3dLH9t4r5bESskiMYt/BQ6C3+h1MITP7M
         WirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXva6/Yqd6IA9/jgqhzQ7W+jI1PpNOShUWjkaZh4eNg=;
        b=Ri9b7jqHpO00TKAR3SS1SfC2DJI2xZJwjFrEHkvTn0ftk8f1dIsZIQ7CsoiLMAmoJE
         EGpwLtluYwUMWVGM0YQOIPB3wKlM8Yo8ErMK+cISgHn8b4luhYQmjSPmEn/hJx2JatiQ
         dnJZtvBa482p5GX0wZRdAZvbubuZjMwIN05W4IoN6hUWrZdvR9X/ykPui2dxDpIwQHFX
         mMtvYQx6JxXlTxQbrjTYO/FnO3rAAxwxxvER/Kae85xY3mruiC1ZrWJplvNu3XYqVlDv
         VItJ4QA/ErUWbKYDp4Ql03QjbkHjE72QNVibxKOXhbX5+KlKLqvWiFJBC/LZvC3mTo1t
         2MCw==
X-Gm-Message-State: AOAM531cQlyjyP+anYsm32d1xmNFLQ8Q4NyPE/r9PFHB9Q4VPCfMjsQc
        OUNdNgJLAYNJswN/9+eQrTIFvossuxK9EkcyEe+MCQ==
X-Google-Smtp-Source: ABdhPJxgGC1b8+jhKTozMjwnLX1ipgmvs6YDDUByMXhF8iJxQvNESI0oivilElV9+bRWCZC+i32bfb3EgGLZajom8Jg=
X-Received: by 2002:a19:e017:: with SMTP id x23mr2067772lfg.254.1621600682459;
 Fri, 21 May 2021 05:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com> <20210513074027.543926-7-srikar@linux.vnet.ibm.com>
In-Reply-To: <20210513074027.543926-7-srikar@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 May 2021 14:37:51 +0200
Message-ID: <CAKfTPtB05dxcXPX_hZOFXHYaW98sdcykxVYnWdNdMOBHqLMBow@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] sched/idle: Move busy_cpu accounting to idle callback
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 at 09:41, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> Currently we account nr_busy_cpus in no_hz idle functions.
> There is no reason why nr_busy_cpus should updated be in NO_HZ_COMMON
> configs only. Also scheduler can mark a CPU as non-busy as soon as an
> idle class task starts to run. Scheduler can then mark a CPU as busy
> as soon as its woken up from idle or a new task is placed on it's
> runqueue.
>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Cc: Parth Shah <parth@linux.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c     |  6 ++++--
>  kernel/sched/idle.c     | 29 +++++++++++++++++++++++++++--
>  kernel/sched/sched.h    |  1 +
>  kernel/sched/topology.c |  2 ++
>  4 files changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0dfe01de22d6..8f86359efdbd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10410,7 +10410,10 @@ static void set_cpu_sd_state_busy(int cpu)
>                 goto unlock;
>         sd->nohz_idle = 0;
>
> -       atomic_inc(&sd->shared->nr_busy_cpus);
> +       if (sd && per_cpu(is_idle, cpu)) {
> +               atomic_add_unless(&sd->shared->nr_busy_cpus, 1, per_cpu(sd_llc_size, cpu));
> +               per_cpu(is_idle, cpu) = 0;
> +       }
>  unlock:
>         rcu_read_unlock();
>  }
> @@ -10440,7 +10443,6 @@ static void set_cpu_sd_state_idle(int cpu)
>                 goto unlock;
>         sd->nohz_idle = 1;
>
> -       atomic_dec(&sd->shared->nr_busy_cpus);
>  unlock:
>         rcu_read_unlock();
>  }
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index a9f5a8ace59e..c13105fe06b3 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -431,12 +431,25 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
>
>  static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
>  {
> -#ifdef CONFIG_SCHED_SMT
> +#ifdef CONFIG_SMP
> +       struct sched_domain_shared *sds;
>         int cpu = rq->cpu;
>
> +#ifdef CONFIG_SCHED_SMT
>         if (static_branch_likely(&sched_smt_present))
>                 set_core_busy(cpu);
>  #endif
> +
> +       rcu_read_lock();
> +       sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +       if (sds) {
> +               if (per_cpu(is_idle, cpu)) {
> +                       atomic_inc(&sds->nr_busy_cpus);
> +                       per_cpu(is_idle, cpu) = 0;
> +               }
> +       }
> +       rcu_read_unlock();
> +#endif
>  }
>
>  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
> @@ -448,9 +461,21 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
>  struct task_struct *pick_next_task_idle(struct rq *rq)
>  {
>         struct task_struct *next = rq->idle;
> +#ifdef CONFIG_SMP
> +       struct sched_domain_shared *sds;
> +       int cpu = rq->cpu;
>
> -       set_next_task_idle(rq, next, true);
> +       rcu_read_lock();
> +       sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +       if (sds) {
> +               atomic_add_unless(&sds->nr_busy_cpus, -1, 0);
> +               per_cpu(is_idle, cpu) = 1;
> +       }

One reason to update nr_busy_cpus only during tick is and not at each
and every single sleep/wakeup to limit the number of atomic_inc/dec in
case of storm of short running tasks. Because at the end , you waste
more time trying to accurately follow the current state of the CPU
than doing work

>
> +       rcu_read_unlock();
> +#endif
> +
> +       set_next_task_idle(rq, next, true);
>         return next;
>  }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 98c3cfbc5d26..b66c4dad5fd2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1496,6 +1496,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
>  #ifdef CONFIG_SCHED_SMT
>  DECLARE_PER_CPU(int, smt_id);
>  #endif
> +DECLARE_PER_CPU(int, is_idle);
>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 232fb261dfc2..730252937712 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -647,6 +647,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
>  #ifdef CONFIG_SCHED_SMT
>  DEFINE_PER_CPU(int, smt_id);
>  #endif
> +DEFINE_PER_CPU(int, is_idle);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> @@ -673,6 +674,7 @@ static void update_top_cache_domain(int cpu)
>  #ifdef CONFIG_SCHED_SMT
>         per_cpu(smt_id, cpu) = cpumask_first(cpu_smt_mask(cpu));
>  #endif
> +       per_cpu(is_idle, cpu) = 1;
>         rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
>
>         sd = lowest_flag_domain(cpu, SD_NUMA);
> --
> 2.18.2
>
