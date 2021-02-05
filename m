Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DD13116A3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhBEXJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhBEOfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:35:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0D3C061794
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:13:08 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id sa23so12831124ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ohOPEsSKEP0GCWWX7v/qRRrbSKEpWn4YzdHdUQhESQ=;
        b=TRjzKOJkIVdlSFdHXnpB07jVA3KURe4PKO3JmFvut7V2SzacsFLpOa4PEi9aHjHYUA
         35ty3thuwzyDfniBc9ws+voB0V8Y6Orj4pAlqsYgN6609M83LoeE94AcZ6Gsykc0XDc1
         Uqcb4TlbPWQ34ANiVrp2GPi3/taiEKzcvdzLbmqEJ8LhYaifNktBCEZgueJjgO8Eigp1
         OYLrThqikxRteYWe4y/Kla/LJ9+0IvamhwziKC1XXf0ruBRFnAoFuJOssL3Jzc8yZrvm
         btZrDCkDzIoeQL8tUNBY0EIcVY5hb+5Ybdmw0av3cq1P7RU0uYktpw/0FIuAynrMDiNA
         CQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ohOPEsSKEP0GCWWX7v/qRRrbSKEpWn4YzdHdUQhESQ=;
        b=V+DrPoGXlk8pB7rQNMf9oUHy0B+aK39zxhXYYDBPyHvuaYRF19eh9VkLIsbePzNGge
         9adoM9JdDoHrRBkbJZVheGT50KNQoEpuys6tkplEkCqWxwDOwaz6aGKkAfvobJdiKMCa
         7/EGEO7aCQRJrhZR5dTOW7WaqOnl8jhnkVWdsYdrrgiVAVj6XE8KmuVKzz6N9dRJBgvm
         9gCcbX2T08/YAkoQFIl4X6MTL3IENXqhNJ9gcy22vIxJw1qNeNTPYUoysy0d+lyseQJ7
         CFfeJPE5VDO8Ow1rpGF1rrB0pM1g3Gw8uYpUZEzOVq41ATfqDeLDzVhT6hRT4WTo07Fk
         BV9g==
X-Gm-Message-State: AOAM530yG+8gXb4UlvmHmfJeOEKPydUXXkn5gAjsXHjax+ZdN59up57O
        0sFEsARuILTDjD36pQvyl+tpAdpLuGHGja0S7hxkjwoOSVaMhw==
X-Google-Smtp-Source: ABdhPJyYMUaEIEFwJUr/vUsZHo2uOslmdlRzC2D90q+qYNhivg2Nd7usM3rpi/4Ckrcd/jnFf6ECc3gfqh0LL0IF054=
X-Received: by 2002:ac2:5232:: with SMTP id i18mr2727983lfl.277.1612535478969;
 Fri, 05 Feb 2021 06:31:18 -0800 (PST)
MIME-Version: 1.0
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-4-valentin.schneider@arm.com>
In-Reply-To: <20210128183141.28097-4-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 5 Feb 2021 15:31:07 +0100
Message-ID: <CAKfTPtADn0X8=ENfvG5dhzM1KbTD+JCCoOm-i8=bVkh0ZBM2Xg@mail.gmail.com>
Subject: Re: [PATCH 3/8] sched/fair: Tweak misfit-related capacity checks
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 at 19:32, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> During load-balance, groups classified as group_misfit_task are filtered
> out if they do not pass
>
>   group_smaller_max_cpu_capacity(<candidate group>, <local group>);

group_smaller_max_cpu_capacity and  group_smaller_max_cpu_capacity are
removed in the next patch. Merge this and the next and directly remove
them

>
> which itself employs fits_capacity() to compare the sgc->max_capacity of
> both groups.
>
> Due to the underlying margin, fits_capacity(X, 1024) will return false for
> any X > 819. Tough luck, the capacity_orig's on e.g. the Pixel 4 are
> {261, 871, 1024}. If a CPU-bound task ends up on one of those "medium"
> CPUs, misfit migration will never intentionally upmigrate it to a CPU of
> higher capacity due to the aforementioned margin.
>
> One may argue the 20% margin of fits_capacity() is excessive in the advent
> of counter-enhanced load tracking (APERF/MPERF, AMUs), but one point here
> is that fits_capacity() is meant to compare a utilization value to a
> capacity value, whereas here it is being used to compare two capacity
> values. As CPU capacity and task utilization have different dynamics, a
> sensible approach here would be to add a new helper dedicated to comparing
> CPU capacities.
>
> Introduce capacity_greater(), which uses a 5% margin. Use it to replace the
> existing capacity checks. Note that check_cpu_capacity() uses yet another
> margin (sd->imbalance_pct), and is left alone for now.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7d01fa0bfc7e..58ce0b22fcb0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -113,6 +113,13 @@ int __weak arch_asym_cpu_priority(int cpu)
>   */
>  #define fits_capacity(cap, max)        ((cap) * 1280 < (max) * 1024)
>
> +/*
> + * The margin used when comparing CPU capacities.
> + * is 'cap' noticeably greater than 'ref'
> + *
> + * (default: ~5%)
> + */
> +#define capacity_greater(cap, ref) ((ref) * 1078 < (cap) * 1024)
>  #endif
>
>  #ifdef CONFIG_CFS_BANDWIDTH
> @@ -8253,7 +8260,7 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
>  static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
>  {
>         return rq->misfit_task_load &&
> -               (rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
> +               (capacity_greater(rq->rd->max_cpu_capacity, rq->cpu_capacity_orig) ||

Why do you add a margin here whereas there was no margin before ?

>                  check_cpu_capacity(rq, sd));
>  }
>
> @@ -8352,7 +8359,7 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>  static inline bool
>  group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
>  {
> -       return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
> +       return capacity_greater(ref->sgc->min_capacity, sg->sgc->min_capacity);
>  }
>
>  /*
> @@ -8362,7 +8369,7 @@ group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
>  static inline bool
>  group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
>  {
> -       return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
> +       return capacity_greater(ref->sgc->max_capacity, sg->sgc->max_capacity);
>  }
>
>  static inline enum
> @@ -9421,7 +9428,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                  * average load.
>                  */
>                 if (sd_has_asym_cpucapacity(env->sd) &&
> -                   capacity_of(env->dst_cpu) < capacity &&
> +                   !capacity_greater(capacity_of(env->dst_cpu), capacity) &&

same here

>                     nr_running == 1)
>                         continue;
>
> --
> 2.27.0
>
