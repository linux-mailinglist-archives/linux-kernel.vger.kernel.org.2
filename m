Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D8314A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhBIIm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhBIImf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:42:35 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8674C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 00:42:12 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id r65so3624796lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 00:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ChzYY0c5Iz/EDroW9Gp2d3Y4yrxj6R1o6bawn1H2xic=;
        b=I5HLu1M62gaa5nODf3Wucx2CEMEQxfJkJgo74kx3OIL0kyZRtKHr9AK2hK36oLoFVy
         d+444QrBQry1Z8njdHiOLYWIehYwwagVw34aY/Mft1QAmy3l0SYp717P4MxW4od7XWvX
         pbHcYMp7eIDgZICrV9a1Jy1zNDmBDiWusMQv/2mxHjv2D2fyTKhfCsUQ1OAg3HxQu9KC
         YkSq6X0+mazQ7iutE0+s+LuI2e44vABZSm3O7qTedU5ISeMndtv0HgqnudcYNtNtDgHL
         QVGpu3QQz2lCXbCxtFvcxI0NkqXjLOQpCqDrpWjFF6rfTiiQBCmKNG5/QlOFjznn9INh
         ed5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChzYY0c5Iz/EDroW9Gp2d3Y4yrxj6R1o6bawn1H2xic=;
        b=QKBHnhg3weKAEYyFVw5qT5niHWHF7yTX0iSO0d+d2IqQjLMaDSHz8Hpp7uwZ+pMHZC
         D0pAbPcxUBhm0hTSV00ofUneSCvWdEE2mPXc2P607drWgGuFWrNfBa0YJiPI5aJQMntg
         Q7CY8NvEswlsbK3V6XXxxm0yRlUEDwnFJ7+Yn8t8XSXdoD/8N0bULVuWoz0O1HzjTlJe
         40j7xgt7kA6cUFczYPpIqSlNbi+i3+T1i3s3tAXNILdb/9FlnO3dT2FqVt41rIIrk+dz
         w9aOFABqhndphr6EpcZPZY+XEO7bvoRtk5pXfVrgDBf8IzLFSX63j1542VdhX0ym70gb
         04sA==
X-Gm-Message-State: AOAM532kC13Ura7nL1Ikx4PQtQMjQxNTWg1CCiYbaJMnX/mVCHYt7zwN
        JEGE7aOil+70fOCu9i2MpXXQTQ/D3Pn0u4HwQ2WJgQ==
X-Google-Smtp-Source: ABdhPJyQW9NK8gPSZAT5oQKQ3PMm7Xo0rkRgQDJfPGYSQsIWKaW33NHUurl8aKOgcevOHL8G+8JQ9SMCZVE3lXmvkjk=
X-Received: by 2002:a19:e219:: with SMTP id z25mr6148194lfg.254.1612860131181;
 Tue, 09 Feb 2021 00:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-3-valentin.schneider@arm.com>
In-Reply-To: <20210128183141.28097-3-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Feb 2021 09:42:00 +0100
Message-ID: <CAKfTPtD=QmCnTVdPiAv8v4X3wnwSm3_YiGd+vtHx2kw+DLYfPw@mail.gmail.com>
Subject: Re: [PATCH 2/8] sched/fair: Add more sched_asym_cpucapacity static
 branch checks
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 at 19:32, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Rik noted a while back that a handful of
>
>   sd->flags & SD_ASYM_CPUCAPACITY
>
> & family in the CFS load-balancer code aren't guarded by the
> sched_asym_cpucapacity static branch.
>
> The load-balancer is already doing a humongous amount of work, but turning
> those checks into NOPs for those who don't need it is fairly
> straightforward, so do that.

It would be good to get figures showing an improvement. We are there
in the LB which is a slow path. Whereas using the static branch in
fast path makes sense, I don't see the benefit there. Also why not
doing the same for others like SD_ASYM_PACKING.
I'm not convinced by this change which IMO doesn't provide any benefit
but adds complexity.

>
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c  | 11 ++++++-----
>  kernel/sched/sched.h |  6 ++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0f6a4e58ce3c..7d01fa0bfc7e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8465,7 +8465,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                         continue;
>
>                 /* Check for a misfit task on the cpu */
> -               if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> +               if (sd_has_asym_cpucapacity(env->sd) &&
>                     sgs->group_misfit_task_load < rq->misfit_task_load) {
>                         sgs->group_misfit_task_load = rq->misfit_task_load;
>                         *sg_status |= SG_OVERLOAD;
> @@ -8522,7 +8522,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>          * CPUs in the group should either be possible to resolve
>          * internally or be covered by avg_load imbalance (eventually).
>          */
> -       if (sgs->group_type == group_misfit_task &&
> +       if (static_branch_unlikely(&sched_asym_cpucapacity) &&
> +           sgs->group_type == group_misfit_task &&
>             (!group_smaller_max_cpu_capacity(sg, sds->local) ||
>              sds->local_stat.group_type != group_has_spare))
>                 return false;
> @@ -8605,7 +8606,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>          * throughput. Maximize throughput, power/energy consequences are not
>          * considered.
>          */
> -       if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
> +       if (sd_has_asym_cpucapacity(env->sd) &&
>             (sgs->group_type <= group_fully_busy) &&
>             (group_smaller_min_cpu_capacity(sds->local, sg)))
>                 return false;
> @@ -8728,7 +8729,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>         }
>
>         /* Check if task fits in the group */
> -       if (sd->flags & SD_ASYM_CPUCAPACITY &&
> +       if (sd_has_asym_cpucapacity(sd) &&
>             !task_fits_capacity(p, group->sgc->max_capacity)) {
>                 sgs->group_misfit_task_load = 1;
>         }
> @@ -9419,7 +9420,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                  * Higher per-CPU capacity is considered better than balancing
>                  * average load.
>                  */
> -               if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> +               if (sd_has_asym_cpucapacity(env->sd) &&
>                     capacity_of(env->dst_cpu) < capacity &&
>                     nr_running == 1)
>                         continue;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 045b01064c1e..21bd71f58c06 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1482,6 +1482,12 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>  extern struct static_key_false sched_asym_cpucapacity;
>
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
> 2.27.0
>
