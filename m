Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5F33BF88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhCOPN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbhCOPNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:13:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CB2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:13:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d3so57342035lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SX8/O9HkgZUh3ycU9Sl2AhNyXYcupu3NkmSOWldBEXQ=;
        b=mJbeER/eaVipYMCMADj6CN51JmPG2Snl3InYvsFFFfvoDxR6gkDoC8Dp9SpqGhbO4v
         6xReg28qJJgG3YTeI/+/EupXMOfx4WwBff31w7EBO09qyfSyFWnAFBFAO10gbKlX1rWS
         +qya4GIx41ahaVZRYCf7mEwa4QPu1Wj1HoTIdqf8PJ8wFeaAORreDNt+XLIt3cZKJP7Z
         1RpSfnZtfTqE6zeCoBSistfOGvCNrdSvTQ1stW0BEw3lSgsuWu6mp/GG5HzcgRB8hGCE
         20DGNXLHvSgYeFKvLPa+VwoVBH14WqkCudN1m5Sm8KIb4X0cuO5tIjcXX37UPBoIjRsm
         ORXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SX8/O9HkgZUh3ycU9Sl2AhNyXYcupu3NkmSOWldBEXQ=;
        b=XQJjICoPpfS6cPKAQBTz+Ub5ju/WJEJHfZIcGosw6/MoxS6OV5y4bIpzgX5C6eaA0M
         uMarEDVUTuE9nmjWfwp89hJ5MnAVJnIy3Vobci06NhWDbckYa/kk8LsclJ/PMOPrBaZX
         2Ufu7r4Pf+iTj/JTWp+SsaPBMg5132RZkxKollntEb5eOVhAhXM5tnoyjNkaBCBUOWLs
         ZcbI6DxKhRuIXl88xV/UApl3N9vITBAJW9kyzbCGWuAxoK2QP6IbJFni6MX/y0VIeBNs
         YbXJMreIfziZq+QOt3fMI7ZaktaFUX6FOt9cOMfatutx6ssiYSyyTVC0FBTYru7nvmkv
         u8YA==
X-Gm-Message-State: AOAM532OSFR5jmuBHoq+M9cs7TPwgQFUagn0yGuu5+jTBLVLx8fH0TfY
        ndetDnoRseWobduDoNImHKXFefDnzh8z26vprZjp3g==
X-Google-Smtp-Source: ABdhPJwA4G/eAvJrd9K5z/eHqZf4dwULlrXR95XAOkgWQ/Vl2qDkEqDXvfqVHxHW62cnbqrU3RvNXvvglbNqKgt5w+Q=
X-Received: by 2002:ac2:53a7:: with SMTP id j7mr8898591lfh.305.1615821216560;
 Mon, 15 Mar 2021 08:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210311120527.167870-1-valentin.schneider@arm.com> <20210311120527.167870-7-valentin.schneider@arm.com>
In-Reply-To: <20210311120527.167870-7-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 15 Mar 2021 16:13:24 +0100
Message-ID: <CAKfTPtAZmOp+c4LR0jKSP=cSUOnu0O_ubGUMnpEKh-cPc89qZw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] sched/fair: Filter out locally-unsolvable misfit imbalances
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 at 13:05, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Consider the following (hypothetical) asymmetric CPU capacity topology,
> with some amount of capacity pressure (RT | DL | IRQ | thermal):
>
>   DIE [          ]
>   MC  [    ][    ]
>        0  1  2  3
>
>   | CPU | capacity_orig | capacity |
>   |-----+---------------+----------|
>   |   0 |           870 |      860 |
>   |   1 |           870 |      600 |
>   |   2 |          1024 |      850 |
>   |   3 |          1024 |      860 |
>
> If CPU1 has a misfit task, then CPU0, CPU2 and CPU3 are valid candidates to
> grant the task an uplift in CPU capacity. Consider CPU0 and CPU3 as
> sufficiently busy, i.e. don't have enough spare capacity to accommodate
> CPU1's misfit task. This would then fall on CPU2 to pull the task.
>
> This currently won't happen, because CPU2 will fail
>
>   capacity_greater(capacity_of(CPU2), sg->sgc->max_capacity)

which has been introduced by the previous patch: patch5

>
> in update_sd_pick_busiest(), where 'sg' is the [0, 1] group at DIE
> level. In this case, the max_capacity is that of CPU0's, which is at this
> point in time greater than that of CPU2's. This comparison doesn't make
> much sense, given that the only CPUs we should care about in this scenario
> are CPU1 (the CPU with the misfit task) and CPU2 (the load-balance
> destination CPU).
>
> Aggregate a misfit task's load into sgs->group_misfit_task_load only if
> env->dst_cpu would grant it a capacity uplift. Separately track whether a
> sched_group contains a misfit task to still classify it as
> group_misfit_task and not pick it as busiest group when pulling from a

Could you give more details about why we should keep tracking the
group as misfit ? Do you have a UC in mind ?

> lower-capacity CPU (which is the current behaviour and prevents
> down-migration).
>
> Since find_busiest_queue() can now iterate over CPUs with a higher capacity
> than the local CPU's, add a capacity check there.
>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1e8a242cd1f7..41cdda7a8ea6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5759,6 +5759,12 @@ static unsigned long capacity_of(int cpu)
>         return cpu_rq(cpu)->cpu_capacity;
>  }
>
> +/* Is CPU a's capacity noticeably greater than CPU b's? */
> +static inline bool cpu_capacity_greater(int a, int b)
> +{
> +       return capacity_greater(capacity_of(a), capacity_of(b));
> +}
> +
>  static void record_wakee(struct task_struct *p)
>  {
>         /*
> @@ -8091,7 +8097,8 @@ struct sg_lb_stats {
>         unsigned int group_weight;
>         enum group_type group_type;
>         unsigned int group_asym_packing; /* Tasks should be moved to preferred CPU */
> -       unsigned long group_misfit_task_load; /* A CPU has a task too big for its capacity */
> +       unsigned long group_misfit_task_load; /* Task load that can be uplifted */
> +       int           group_has_misfit_task; /* A CPU has a task too big for its capacity */
>  #ifdef CONFIG_NUMA_BALANCING
>         unsigned int nr_numa_running;
>         unsigned int nr_preferred_running;
> @@ -8364,7 +8371,7 @@ group_type group_classify(unsigned int imbalance_pct,
>         if (sgs->group_asym_packing)
>                 return group_asym_packing;
>
> -       if (sgs->group_misfit_task_load)
> +       if (sgs->group_has_misfit_task)
>                 return group_misfit_task;
>
>         if (!group_has_capacity(imbalance_pct, sgs))
> @@ -8447,10 +8454,21 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                         continue;
>
>                 /* Check for a misfit task on the cpu */
> -               if (sd_has_asym_cpucapacity(env->sd) &&
> -                   sgs->group_misfit_task_load < rq->misfit_task_load) {
> -                       sgs->group_misfit_task_load = rq->misfit_task_load;
> -                       *sg_status |= SG_OVERLOAD;
> +               if (!sd_has_asym_cpucapacity(env->sd) ||
> +                   !rq->misfit_task_load)
> +                       continue;
> +
> +               *sg_status |= SG_OVERLOAD;
> +               sgs->group_has_misfit_task = true;
> +
> +               /*
> +                * Don't attempt to maximize load for misfit tasks that can't be
> +                * granted a CPU capacity uplift.
> +                */
> +               if (cpu_capacity_greater(env->dst_cpu, i)) {
> +                       sgs->group_misfit_task_load = max(
> +                               sgs->group_misfit_task_load,
> +                               rq->misfit_task_load);

Please encapsulate all this misfit specific code in a dedicated
function which will be called from update_sg_lb_stats

>                 }
>         }
>
> @@ -8501,7 +8519,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>         /* Don't try to pull misfit tasks we can't help */
>         if (static_branch_unlikely(&sched_asym_cpucapacity) &&
>             sgs->group_type == group_misfit_task &&
> -           (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
> +           (!sgs->group_misfit_task_load ||
>              sds->local_stat.group_type != group_has_spare))
>                 return false;
>
> @@ -9448,15 +9466,18 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                 case migrate_misfit:
>                         /*
>                          * For ASYM_CPUCAPACITY domains with misfit tasks we
> -                        * simply seek the "biggest" misfit task.
> +                        * simply seek the "biggest" misfit task we can
> +                        * accommodate.
>                          */
> +                       if (!cpu_capacity_greater(env->dst_cpu, i))
> +                               continue;
> +
>                         if (rq->misfit_task_load > busiest_load) {
>                                 busiest_load = rq->misfit_task_load;
>                                 busiest = rq;
>                         }
>
>                         break;
> -
>                 }
>         }
>
> --
> 2.25.1
>
