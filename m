Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A7740FC3B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhIQP2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbhIQP2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:28:00 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF28C061764
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:26:38 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a10so18540935qka.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OkLjxJhItoHaIYoOhvnxYFt8zLgNaAeBdV6KcTjLYo4=;
        b=AwWr8OFEIKyWg7y6uBsmAyUxp9xN+wU3egAnMtw5fIkFwTnqoZwnFz+PcctOq9PwMh
         ObXr2b9H8tEqYYj/AABbV4Lk8Ihg05gZRc3VeqFAUSXOGJcy+2ioi//icUkZovHc4QLM
         OfIso7ExhrDKTdW9+ekt67y734hHN5qNeE0gcOaomu1+UKVahkpswWD+6ZoXjTZV6p99
         PMQs9cIUCpAgJSveenfvQhSEj8RYAO9AX7jC6tJ0t2KtD7kQnfrnma0W7wskP07POu2w
         tJA9uKkj1OpPnWJ9QzwLXHUZq9dE2wYL1FgsF7WppSDariEtHI3f+qUde6jNmiFbnzDJ
         hduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkLjxJhItoHaIYoOhvnxYFt8zLgNaAeBdV6KcTjLYo4=;
        b=6V5qRtpylD00km9yqcKGrSoD7BdwedTgCs5OQZDyA5KriB1iG1oXxbZAmzKJ+F4oEI
         qVsq1iNYFGR6ORwogr4Jqv6cHWRyKNu42JMYeTnIVfYDCi9J3xwr3BcvAuGaRei7w7vi
         QjULxnDy1SENwY5jRhUcx83PE0ZN4kvzOmY36oEVOseh/jYqTb3AtPUbLxNhUW+i2p/B
         2FnhX3yfUDWWoznL2JA5DImGMS7Ar7WrpMUWPb6+0KP4S8vYW/xARfxQaTGEfzi73R90
         bj+Egmull5nnptzI9F5U7ym1qpSNa/FTwd2yy7m4qAsIiRBK4yDncTr4n8KSAo+Be+aQ
         breQ==
X-Gm-Message-State: AOAM533H05LJ1KLDKBjRTeaBgAdUdworIFk4TrnnEWvs2EhVFNBag5O/
        HJ0NvlAfJrsX5p7uVBfY4bIBDb2REBt/eEVtEgUrpg==
X-Google-Smtp-Source: ABdhPJySCDrecUuxQqs+LaFuiOoTAxgl0MMZVhJ9pHxOJEU/z8m6WJf075iL3pZcPj3q785nIddKc6ubc/8WROvPGI0=
X-Received: by 2002:a25:9001:: with SMTP id s1mr13892523ybl.191.1631892397154;
 Fri, 17 Sep 2021 08:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com> <20210911011819.12184-4-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20210911011819.12184-4-ricardo.neri-calderon@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Sep 2021 17:26:26 +0200
Message-ID: <CAKfTPtCHFgaWWdxSuRKPrp4cSLA+pTzXAmsGn9N3LrFn0x4B1w@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] sched/fair: Optimize checking for group_asym_packing
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
> sched_asmy_prefer() always returns false when called on the local group. By
> checking local_group, we can avoid additional checks and invoking
> sched_asmy_prefer() when it is not needed. No functional changes are
> introduced.
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
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> Changes since v4:
>   * None
>
> Changes since v3:
>   * Further rewording of the commit message. (Len)
>
> Changes since v2:
>   * Reworded the commit message for clarity. (Peter Z)
>
> Changes since v1:
>   * None
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff69f245b939..7a054f528bcc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8657,7 +8657,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>         }
>
>         /* Check if dst CPU is idle and preferred to this group */
> -       if (env->sd->flags & SD_ASYM_PACKING &&
> +       if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
>             env->idle != CPU_NOT_IDLE &&
>             sgs->sum_h_nr_running &&
>             sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> --
> 2.17.1
>
