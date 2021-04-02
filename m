Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1993352AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhDBNEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhDBNEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:04:49 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD7BC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 06:04:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u9so5521124ljd.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 06:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIFPdn2HHsJa4KRcR9pDTGoB9KgM4sDHiRfQccA6W5U=;
        b=AsvJSEILIC/U78Qs6F3cN7SEwON/POywBtYUSwyo1xftp6jW00S0Y04HS+l6q+79s2
         xuO4vIQ9fuAG4TIdJFM7vVnwihw8V8hB+tw/aI7in8ARJwXwNt34tKZv1OgZECJk/m42
         gMdYKqyAAA6Ross+ozOU076p8oiAPtdQxe4odJ4hkchZAJ/lOPkktrcPExQ6fcvIq6QX
         K480/d2W1S8yx+uQmq0zEZ06W89lfySt75TZXOAq/w5B6dICOS56i0vTOllmWM3lbVW5
         KaX2nqolP/ukLgzYchmdQpzgL1o9VACEAMYcUjubfD4WbeGlOQHMa/C8rngdEQPyAk/j
         FOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIFPdn2HHsJa4KRcR9pDTGoB9KgM4sDHiRfQccA6W5U=;
        b=sOyXUXkfH7KXvF4BO+FZOf1ZXFlX8cwChIIqbnnnFlbo2O3ohZRqLN9mlg2twoSHxi
         ko0mODKaLHZPA2DqJ4fY3aAJZv9M0sV89X7sqhX2OKz+vat+fksQ0CMY1EV/3MNYxNaZ
         Y5tZVsm3yy6n095pEgmVbea07NBv4sUFuuU+d2n/C4lC4lgnRV6Idz6djly1s4Qn8g00
         sWplVA/8VlYIfq82Su8gjScCd/VDqunzfqQoO+NSrRRxlJWw+POICwNNyvexg0706T9n
         TP2zGytQcBuVtfap42yDQCNyg4WN7RrGttrTnXVpTSArunwnk1VhsHHrNNRDYOQs+MYf
         +qFg==
X-Gm-Message-State: AOAM532NsGtcutSvg138nVKh+CyGLOFE7sm4uvkCnYUeFEXigliJS20H
        Nd1HeWm7bCx33BliEQ91zf98bdRa9qk2NEFqRV3VtMfdWZAxag==
X-Google-Smtp-Source: ABdhPJxHCa4PCEFHZt0fRpsYAQJwJjxmWIAEgjMWDJNUvxQdy88JPvzFb8PNk6kNLHULx7jwwZm8LFSOlyq06gbhS8A=
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr8003028ljo.176.1617368685440;
 Fri, 02 Apr 2021 06:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210401193006.3392788-1-valentin.schneider@arm.com> <20210401193006.3392788-4-valentin.schneider@arm.com>
In-Reply-To: <20210401193006.3392788-4-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 2 Apr 2021 15:04:34 +0200
Message-ID: <CAKfTPtD1iN5HdrZsO_HuVTn6MwCFea9X+80LcGWxOSgkA0aU+g@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] sched/fair: Introduce a CPU capacity comparison helper
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 at 21:30, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> During load-balance, groups classified as group_misfit_task are filtered
> out if they do not pass
>
>   group_smaller_max_cpu_capacity(<candidate group>, <local group>);
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
> While at it, replace group_smaller_{min, max}_cpu_capacity() with
> comparisons of the source group's min/max capacity and the destination
> CPU's capacity.
>
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>
> Tested-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d8077f82a380..c9c5c2697998 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -113,6 +113,13 @@ int __weak arch_asym_cpu_priority(int cpu)
>   */
>  #define fits_capacity(cap, max)        ((cap) * 1280 < (max) * 1024)
>
> +/*
> + * The margin used when comparing CPU capacities.
> + * is 'cap1' noticeably greater than 'cap2'
> + *
> + * (default: ~5%)
> + */
> +#define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
>  #endif
>
>  #ifdef CONFIG_CFS_BANDWIDTH
> @@ -8364,26 +8371,6 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>         return false;
>  }
>
> -/*
> - * group_smaller_min_cpu_capacity: Returns true if sched_group sg has smaller
> - * per-CPU capacity than sched_group ref.
> - */
> -static inline bool
> -group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> -{
> -       return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
> -}
> -
> -/*
> - * group_smaller_max_cpu_capacity: Returns true if sched_group sg has smaller
> - * per-CPU capacity_orig than sched_group ref.
> - */
> -static inline bool
> -group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
> -{
> -       return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
> -}
> -
>  static inline enum
>  group_type group_classify(unsigned int imbalance_pct,
>                           struct sched_group *group,
> @@ -8539,7 +8526,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>          * internally or be covered by avg_load imbalance (eventually).
>          */
>         if (sgs->group_type == group_misfit_task &&
> -           (!group_smaller_max_cpu_capacity(sg, sds->local) ||
> +           (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
>              sds->local_stat.group_type != group_has_spare))
>                 return false;
>
> @@ -8623,7 +8610,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>          */
>         if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
>             (sgs->group_type <= group_fully_busy) &&
> -           (group_smaller_min_cpu_capacity(sds->local, sg)))
> +           (capacity_greater(sg->sgc->min_capacity, capacity_of(env->dst_cpu))))
>                 return false;
>
>         return true;
> @@ -9423,7 +9410,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>                  * average load.
>                  */
>                 if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> -                   capacity_of(env->dst_cpu) < capacity &&
> +                   !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
>                     nr_running == 1)
>                         continue;
>
> --
> 2.25.1
>
