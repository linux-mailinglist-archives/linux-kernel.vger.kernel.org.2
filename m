Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3233BEA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbhCOOsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhCOOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:18:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C80C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:18:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id v2so44066143lft.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5jxmvwUyLuLPl9m+coT5OZbfzx5dsredAEHkRzWHHk=;
        b=lHz70nRMVEwDFA3um9sVxNlj7SPzo6aORS1sC2V4EEY8YPwzC0UxqJ1D5oAU4B4g1e
         y4PVxAgNdpcb8BxblcsQxBMNiG5U6gIY2yq4qBKmHqjQ9f1C4wokw/cNT6Gb1A5X68ev
         dUiP2c02pNIs4j8y8OOpfN58DoXZeBJJvhLfU4UMiXFmzMATch6YyBy2q2jJQsmFznC5
         NNSscZg/FOBEOiEUfdzzHjFGMTemc8lZqgv5I+6kHAbmUuZv7y8IR6MGvLlQqKTSO5eP
         SFspWV+bDDZKFWZPavuanjNyJhK8sQw0QtzftT/oUBdAh23ZukFeSRMEsSUYTvctLpuq
         OmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5jxmvwUyLuLPl9m+coT5OZbfzx5dsredAEHkRzWHHk=;
        b=YUN6/yQoWVpIZzZ2xgNVVj3wf5CHeud2v2+Zj73Q5dcJk/a0m9+Kc8f92Xml7t+qh0
         MW3tHxc443P+CGNq8cpKviZ5YXtWq8QPDMeOUWAgHk8Gjdblwr37N2LMaGjZLvSYyxJQ
         43WxL21fSsNNewEnJMWsXu4tb7xYhRxG8wlOoprzbFulDnfv05J5WXUD4Co5GiCVJ/Kc
         1ekZzizh5j5ib2pGOEwmuouhN3khwkWRUSXqflxlzP25C7A2PZ+ic2t7okV7w73so3h0
         zfYusPNQxw7W6PMMHu4n0ovmILJGJxWG8eWHzdiVZSSdJvTcNlTfWaOekUAyR9ZFT3Y2
         CW3w==
X-Gm-Message-State: AOAM530axw37YIJvNVoZVuorzw9hNWNgwIVjRzQGDEnc8QGhhx3vSg/f
        EFUlo1A3qvVeapvkcv6gILC9+4DckxtzIJs3twEgRQ==
X-Google-Smtp-Source: ABdhPJxESMqBblGRzChmljNvysikD+3G96CUvDvs4y68vjAQwwWqBlsbErB3BIV7L0y+tkl+VGbd8tYtkMDYCpX7T5Y=
X-Received: by 2002:ac2:53a7:: with SMTP id j7mr8746698lfh.305.1615817911709;
 Mon, 15 Mar 2021 07:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210311120527.167870-1-valentin.schneider@arm.com> <20210311120527.167870-4-valentin.schneider@arm.com>
In-Reply-To: <20210311120527.167870-4-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 15 Mar 2021 15:18:19 +0100
Message-ID: <CAKfTPtC-=PYTy5c6iOEwU=53S+gAYVzc6=GMTyEzjQWuyk7_uQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] sched/fair: Add more sched_asym_cpucapacity static
 branch checks
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 at 13:05, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Rik noted a while back that a handful of
>
>   sd->flags & SD_ASYM_CPUCAPACITY
>
> & family in the CFS load-balancer code aren't guarded by the
> sched_asym_cpucapacity static branch.

guarding asym capacity with static branch in fast path makes sense but
I see no benefit in this slow path but hiding and complexifying the
code. Also if you start with this way then you have to add a nop in
all other places where flag or a group_type might be unused.

>
> Turning those checks into NOPs for those who don't need it is fairly
> straightforward, and hiding it in a helper doesn't change code size in all
> but one spot. It also gives us a place to document the differences between
> checking the static key and checking the SD flag.
>
> Suggested-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c  | 21 ++++++++-------------
>  kernel/sched/sched.h | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f50a902bdf24..db892f6e222f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6300,15 +6300,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>          * sd_asym_cpucapacity rather than sd_llc.
>          */
>         if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> +               /* See sd_has_asym_cpucapacity() */
>                 sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
> -               /*
> -                * On an asymmetric CPU capacity system where an exclusive
> -                * cpuset defines a symmetric island (i.e. one unique
> -                * capacity_orig value through the cpuset), the key will be set
> -                * but the CPUs within that cpuset will not have a domain with
> -                * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
> -                * capacity path.
> -                */
>                 if (sd) {
>                         i = select_idle_capacity(p, sd, target);
>                         return ((unsigned)i < nr_cpumask_bits) ? i : target;
> @@ -8467,7 +8460,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                         continue;
>
>                 /* Check for a misfit task on the cpu */
> -               if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> +               if (sd_has_asym_cpucapacity(env->sd) &&
>                     sgs->group_misfit_task_load < rq->misfit_task_load) {
>                         sgs->group_misfit_task_load = rq->misfit_task_load;
>                         *sg_status |= SG_OVERLOAD;
> @@ -8524,7 +8517,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>          * CPUs in the group should either be possible to resolve
>          * internally or be covered by avg_load imbalance (eventually).
>          */
> -       if (sgs->group_type == group_misfit_task &&
> +       if (static_branch_unlikely(&sched_asym_cpucapacity) &&
> +           sgs->group_type == group_misfit_task &&
>             (!group_smaller_max_cpu_capacity(sg, sds->local) ||
>              sds->local_stat.group_type != group_has_spare))
>                 return false;
> @@ -8607,7 +8601,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>          * throughput. Maximize throughput, power/energy consequences are not
>          * considered.
>          */
> -       if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
> +       if (sd_has_asym_cpucapacity(env->sd) &&
>             (sgs->group_type <= group_fully_busy) &&
>             (group_smaller_min_cpu_capacity(sds->local, sg)))
>                 return false;
> @@ -8730,7 +8724,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>         }
>
>         /* Check if task fits in the group */
> -       if (sd->flags & SD_ASYM_CPUCAPACITY &&
> +       if (sd_has_asym_cpucapacity(sd) &&
>             !task_fits_capacity(p, group->sgc->max_capacity)) {
>                 sgs->group_misfit_task_load = 1;
>         }
> @@ -9408,7 +9402,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                  * Higher per-CPU capacity is considered better than balancing
>                  * average load.
>                  */
> -               if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> +               if (sd_has_asym_cpucapacity(env->sd) &&
>                     capacity_of(env->dst_cpu) < capacity &&
>                     nr_running == 1)
>                         continue;
> @@ -10225,6 +10219,7 @@ static void nohz_balancer_kick(struct rq *rq)
>                 }
>         }
>
> +        /* See sd_has_asym_cpucapacity(). */
>         sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
>         if (sd) {
>                 /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d2e09a647c4f..27bf70bc86c7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1492,6 +1492,39 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  extern struct static_key_false sched_asym_cpucapacity;
>
> +/*
> + * Note that the static key is system-wide, but the visibility of
> + * SD_ASYM_CPUCAPACITY isn't. Thus the static key being enabled does not
> + * imply all CPUs can see asymmetry.
> + *
> + * Consider an asymmetric CPU capacity system such as:
> + *
> + * MC [           ]
> + *     0 1 2 3 4 5
> + *     L L L L B B
> + *
> + * w/ arch_scale_cpu_capacity(L) < arch_scale_cpu_capacity(B)
> + *
> + * By default, booting this system will enable the sched_asym_cpucapacity
> + * static key, and all CPUs will see SD_ASYM_CPUCAPACITY set at their MC
> + * sched_domain.
> + *
> + * Further consider exclusive cpusets creating a "symmetric island":
> + *
> + * MC [   ][      ]
> + *     0 1  2 3 4 5
> + *     L L  L L B B
> + *
> + * Again, booting this will enable the static key, but CPUs 0-1 will *not* have
> + * SD_ASYM_CPUCAPACITY set in any of their sched_domain. This is the intended
> + * behaviour, as CPUs 0-1 should be treated as a regular, isolated SMP system.
> + */
> +static inline bool sd_has_asym_cpucapacity(struct sched_domain *sd)
> +{
> +       return static_branch_unlikely(&sched_asym_cpucapacity) &&
> +               sd->flags & SD_ASYM_CPUCAPACITY;
> +}
> +
>  struct sched_group_capacity {
>         atomic_t                ref;
>         /*
> --
> 2.25.1
>
