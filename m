Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222E8352AE0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 14:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhDBM5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 08:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBM5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 08:57:34 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E573EC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 05:57:32 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s17so5535219ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HjrY0aJR0Fk41qu9ljvJEhs7O1yb0hpFQCNbKqdmsw=;
        b=R+oY8zYCkGvTJ+TD5uvLJKD4LFhDhyo2hR7g2b4oLCWlBoKX0iZrw2oWktDrf6vsGY
         weRcSxXktI+qrwzUw/JYpLBL7o/2NEI5DF79qKKZ26EPOqDldqW0e70OV36BxAhu5WcU
         Ky4irdJk/zY11MMsTQAP0cAPu0slvTlF0Fvv/G00QBwHJoChmTPCTEiTFZFk6uGt0yHL
         s+34VsgiAAaHGy+rd+tdbvOt7qDXX4IpVWmZg6K5xVDEC1RpGXnd50L5HHnSRhyDcAB6
         MC1KNco97gWWoJoArXvKQLJeBbRRuUEYTf9vStmgmr2+8qrf6ZvVZtq+pzkP8z1uLJuX
         4tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HjrY0aJR0Fk41qu9ljvJEhs7O1yb0hpFQCNbKqdmsw=;
        b=WaI0Yh+RcJpKSZQIz1iim1ORUcLftq2xzIFWR3assKI8cyk+geTc1Cy9E7SbtS05w2
         F9h2zBn2VMgouTXtSGCborin0cHAR8mRIapa0ULcttWsCteGtde5ble685j99nOMw7BS
         rNnujWh4fsasbsd6m094vDYN2A+AzQRMJP34a0Lbwy2I/qyWNKLXzgiXkaNvr/zTxEAK
         oXEq9CU1RRiAy5JpPFQszX6/3hBraYvEMNF/YgTPx3Vt9eRn9u8UsbYzFpEGzf/FIUKo
         OU2lQpcx+Udpxg2xr3+uOpugBQv4CXWu3P3Fv7xVnQZxQMAq+xmt6KYoAbeoTSZapKs4
         8dbQ==
X-Gm-Message-State: AOAM531jhjjw4GVlzvPqFUbAzq/cBVLbjEOoD8QGWdfedSEHRrhODIQg
        Hyf6UJIKz1qTET3jOp7mRPVtZkZTFm2TlyyDA9x8vA==
X-Google-Smtp-Source: ABdhPJximMj5iYgtlRU9bPwJL1zy7wm+wzhYLHsQkcRR4MrZw18mj3wZlavleZMyjP4dH/FamTHDxpaa6ZhU+m7vP70=
X-Received: by 2002:a05:651c:124b:: with SMTP id h11mr8248282ljh.401.1617368251361;
 Fri, 02 Apr 2021 05:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210401193006.3392788-1-valentin.schneider@arm.com> <20210401193006.3392788-3-valentin.schneider@arm.com>
In-Reply-To: <20210401193006.3392788-3-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 2 Apr 2021 14:57:20 +0200
Message-ID: <CAKfTPtD-8B0w1VQd5AST8KT86=dArQ1EuNP5uQXVw1mBy3LRsw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] sched/fair: Clean up active balance
 nr_balance_failed trickery
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 at 21:30, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> When triggering an active load balance, sd->nr_balance_failed is set to
> such a value that any further can_migrate_task() using said sd will ignore
> the output of task_hot().
>
> This behaviour makes sense, as active load balance intentionally preempts a
> rq's running task to migrate it right away, but this asynchronous write is
> a bit shoddy, as the stopper thread might run active_load_balance_cpu_stop
> before the sd->nr_balance_failed write either becomes visible to the
> stopper's CPU or even happens on the CPU that appended the stopper work.
>
> Add a struct lb_env flag to denote active balancing, and use it in
> can_migrate_task(). Remove the sd->nr_balance_failed write that served the
> same purpose. Cleanup the LBF_DST_PINNED active balance special case.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04d5e14fa261..d8077f82a380 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7422,6 +7422,7 @@ enum migration_type {
>  #define LBF_NEED_BREAK 0x02
>  #define LBF_DST_PINNED  0x04
>  #define LBF_SOME_PINNED        0x08
> +#define LBF_ACTIVE_LB  0x10
>
>  struct lb_env {
>         struct sched_domain     *sd;
> @@ -7583,10 +7584,13 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>                  * our sched_group. We may want to revisit it if we couldn't
>                  * meet load balance goals by pulling other tasks on src_cpu.
>                  *
> -                * Avoid computing new_dst_cpu for NEWLY_IDLE or if we have
> -                * already computed one in current iteration.
> +                * Avoid computing new_dst_cpu
> +                * - for NEWLY_IDLE
> +                * - if we have already computed one in current iteration
> +                * - if it's an active balance
>                  */
> -               if (env->idle == CPU_NEWLY_IDLE || (env->flags & LBF_DST_PINNED))
> +               if (env->idle == CPU_NEWLY_IDLE ||
> +                   env->flags & (LBF_DST_PINNED | LBF_ACTIVE_LB))
>                         return 0;
>
>                 /* Prevent to re-select dst_cpu via env's CPUs: */
> @@ -7611,10 +7615,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>
>         /*
>          * Aggressive migration if:
> -        * 1) destination numa is preferred
> -        * 2) task is cache cold, or
> -        * 3) too many balance attempts have failed.
> +        * 1) active balance
> +        * 2) destination numa is preferred
> +        * 3) task is cache cold, or
> +        * 4) too many balance attempts have failed.
>          */
> +       if (env->flags & LBF_ACTIVE_LB)
> +               return 1;
> +
>         tsk_cache_hot = migrate_degrades_locality(p, env);
>         if (tsk_cache_hot == -1)
>                 tsk_cache_hot = task_hot(p, env);
> @@ -9805,9 +9813,6 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>                                         active_load_balance_cpu_stop, busiest,
>                                         &busiest->active_balance_work);
>                         }
> -
> -                       /* We've kicked active balancing, force task migration. */
> -                       sd->nr_balance_failed = sd->cache_nice_tries+1;
>                 }
>         } else {
>                 sd->nr_balance_failed = 0;
> @@ -9957,13 +9962,7 @@ static int active_load_balance_cpu_stop(void *data)
>                         .src_cpu        = busiest_rq->cpu,
>                         .src_rq         = busiest_rq,
>                         .idle           = CPU_IDLE,
> -                       /*
> -                        * can_migrate_task() doesn't need to compute new_dst_cpu
> -                        * for active balancing. Since we have CPU_IDLE, but no
> -                        * @dst_grpmask we need to make that test go away with lying
> -                        * about DST_PINNED.
> -                        */
> -                       .flags          = LBF_DST_PINNED,
> +                       .flags          = LBF_ACTIVE_LB,
>                 };
>
>                 schedstat_inc(sd->alb_count);
> --
> 2.25.1
>
