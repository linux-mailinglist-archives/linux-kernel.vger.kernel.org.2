Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D404340FC3E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbhIQP2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbhIQP2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:28:49 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E80C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:27:27 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a10so18549465qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+tQ/PU9p2iYa5juxC+5TIx7gu+WxD4o31x+e5MbNAc=;
        b=wZvzXvDFoJxniSSZ1sP1OHE+iQIl14sDSSGD9RuI3YPPIvxu68inmiOiFQy/hbH2rc
         ByJxsWbm0dS5/qUBy5yvIn4xCBq7APq+I69B12S+nG+ozBstaNrLdlWhcYS485dyQRXH
         XD2oO0iNEWppR796Rx3BSQyHK3s/tC7qXkNy80RPUptucgzHKOLQsplduEITsgfxGpY5
         A1TgLXvcwwteseOe6s8PgD2KDm3er4KluD0U4NDIVhwu4C4gY8b2v8bUbO2p8ZYJZwEz
         VQwHBTBmPiYebOPnGdT7dVN55Pl7fkz/RW/xHL9Mhp8Iblg1F+pjIH8BSaDFt7AQeqAN
         +VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+tQ/PU9p2iYa5juxC+5TIx7gu+WxD4o31x+e5MbNAc=;
        b=SSpx2K70Ytn3GvFYslpVgNlITOORHbr5I3sY8iRlnG1xgeFZUeNWnRd9s9ch8+OlbE
         CYOF5308Nzklg4CyEGEE+Gn2F2OHEfKkXdzHquv6Jx5HAgCTvnPXGN3FufFwye/A1alO
         vP+0OBaXHkkGl2U7vXOc59dMSisykajczvdB2UFIrvTi1d+vokvYn3YOx6DU0fcUdwtJ
         2RFKjXZJQ/nPhTTn3HaFpmR82+QrcC0imrsFANsrHcuTKe4VFvIHNzWSrYHB7Q3zZA6Z
         lk+CzPuH+zOvFdtZjkpElcQJGRJgnDoqFOPyhRbRF36IP9CIomB8l6aZHqSPeLAP/lT7
         ec6Q==
X-Gm-Message-State: AOAM531kM9bt3w++UYzUQv8unp+cjcaAAQhdq9QJE2oXvQ1TTQ8A/BZZ
        RPXB8fyb9auJmZorqu5q+xJAQ5gemtSEfkIvfRFzbA==
X-Google-Smtp-Source: ABdhPJy5SUJ2zmS5uUPpvJeW3954agmyO5nBK74RNUzXvygOt2JqjOZVpqg5FpwmPJeTHdeAv+FMZUt5XVZrnFOxp30=
X-Received: by 2002:a25:ac13:: with SMTP id w19mr13980398ybi.402.1631892446211;
 Fri, 17 Sep 2021 08:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com> <20210911011819.12184-6-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20210911011819.12184-6-ricardo.neri-calderon@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Sep 2021 17:27:15 +0200
Message-ID: <CAKfTPtC6Yg2gPHETZ2qUgFJvyrdiNCx2sFBYAtidX0za4tnpQw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] sched/fair: Carve out logic to mark a group for
 asymmetric packing
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sept 2021 at 03:19, Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Create a separate function, sched_asym(). A subsequent changeset will
> introduce logic to deal with SMT in conjunction with asmymmetric
> packing. Such logic will need the statistics of the scheduling
> group provided as argument. Update them before calling sched_asym().
>
> Cc: Aubrey Li <aubrey.li@intel.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Quentin Perret <qperret@google.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> Changes since v4:
>   * None
>
> Changes since v3:
>   * Remove a redundant check for the local group in sched_asym().
>     (Dietmar)
>   * Reworded commit message for clarity. (Len)
>
> Changes since v2:
>   * Introduced this patch.
>
> Changes since v1:
>   * N/A
> ---
>  kernel/sched/fair.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c5851260b4d8..26db017c14a3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8597,6 +8597,13 @@ group_type group_classify(unsigned int imbalance_pct,
>         return group_has_spare;
>  }
>
> +static inline bool
> +sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
> +          struct sched_group *group)
> +{
> +       return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
> +}
> +
>  /**
>   * update_sg_lb_stats - Update sched_group's statistics for load balancing.
>   * @env: The load balancing environment.
> @@ -8657,18 +8664,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 }
>         }
>
> +       sgs->group_capacity = group->sgc->capacity;
> +
> +       sgs->group_weight = group->group_weight;
> +
>         /* Check if dst CPU is idle and preferred to this group */
>         if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
> -           env->idle != CPU_NOT_IDLE &&
> -           sgs->sum_h_nr_running &&
> -           sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> +           env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
> +           sched_asym(env, sds, sgs, group)) {
>                 sgs->group_asym_packing = 1;
>         }
>
> -       sgs->group_capacity = group->sgc->capacity;
> -
> -       sgs->group_weight = group->group_weight;
> -
>         sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
>
>         /* Computing avg_load makes sense only when group is overloaded */
> --
> 2.17.1
>
