Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5391C3F5A77
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhHXJJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbhHXJJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:09:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F66C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:08:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g13so43924828lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cu3fYL6GRf9ZgyzGKsInZk+M6avPIHONRiRsqdGhxF0=;
        b=rYDexSWCXEt7aPflbX9rdpXkYUxrPFFnWKHQwFiSHkTVwuiegE1uJJfGqdqvwUJBhD
         Lo4jEtFG83wGg5G7OdFAMzQAiwPeZCasYU+4zjkkaDShp7yCTP/7yV7aluWa7PR3LWsA
         1NcQ0qA/Jxg8aHupjILp6AQEXCOmc420/w10ckeibYLtxGNtBsDgyrmypX1W1ccmj4pZ
         A6qmuMH3eFsem9Ovs/n8C6IWtDyjMCz2d+XFsHO5m/uysduL26nY0RXxULC2Uuo3EKev
         vDSMQ8+WBv3PLHDOnrBFBPt+9Ak+IEAnU+ZHLAcd56Z8AmK5Zr9pEO6XnYknwi4H2Uxf
         G0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cu3fYL6GRf9ZgyzGKsInZk+M6avPIHONRiRsqdGhxF0=;
        b=T7q2gIcBAU1vb2qMJadX6xJ9Av48IJIW1Be/B/wBrug6Wf0Ztq6HmYd6/6oeeCzYgE
         YDGVyXxUN82nIHKE/TTtZ7mTsluaExv8GN2F0S+n0Rm2v0jhBstJOE14zFOqC4gjMraV
         WtymsGqi45U84Sy2NOsXr+/U71f4tLvSf8gy0Bk95FBlE4/TMkqeT5a/EYqAac09rAot
         fHuKhrrsPf5zcLTEt0bhXNJXEl2ndbhjWINDtT/qxnNFwIQXExSe6u/wIzQBIO3aA+eZ
         s4SPxgqysPrBsSV/f+4qcjZpC50S2mV9O0MwIKM2SCgIMcAORqpgNNjZ5hgGfOSPxIdt
         bSmA==
X-Gm-Message-State: AOAM5335f1wPMOFxHNG3dj6+T9bJW4ZGRzi9itKfCRE41d2CP5YYIRCj
        +w//eBtaRUdhoDuio6qfVnNKb+tJl67JwqSEbPFXZw==
X-Google-Smtp-Source: ABdhPJzN37Rfqq3lCbOt3X5C+wGz8sYgeKeyjh3UFhaEoOg/NHWluJMcgzF6CKdmx0Jyd/Jb2qUWT2khoWx+DlWLH6Q=
X-Received: by 2002:a05:6512:3385:: with SMTP id h5mr28855680lfg.154.1629796108840;
 Tue, 24 Aug 2021 02:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210823111700.2842997-1-valentin.schneider@arm.com> <20210823111700.2842997-2-valentin.schneider@arm.com>
In-Reply-To: <20210823111700.2842997-2-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 24 Aug 2021 11:08:17 +0200
Message-ID: <CAKfTPtC7GYKQcWjWcsrJtYPRLJXg5RB+7-J=TCvTiAANYtnLVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sched/fair: Add NOHZ balancer flag for
 nohz.next_balance updates
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 at 13:17, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> A following patch will trigger NOHZ idle balances as a means to update
> nohz.next_balance. Vincent noted that blocked load updates can have
> non-negligible overhead, which should be avoided if the intent is to only
> update nohz.next_balance.
>
> Add a new NOHZ balance kick flag, NOHZ_NEXT_KICK. Gate NOHZ blocked load
> update by the presence of NOHZ_STATS_KICK - currently all NOHZ balance
> kicks will have the NOHZ_STATS_KICK flag set, so no change in behaviour is
> expected.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c  | 24 ++++++++++++++----------
>  kernel/sched/sched.h |  8 +++++++-
>  2 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6cd05f1d77ef..4a91f3027c92 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10342,7 +10342,7 @@ static void nohz_balancer_kick(struct rq *rq)
>                 goto out;
>
>         if (rq->nr_running >= 2) {
> -               flags = NOHZ_KICK_MASK;
> +               flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
>                 goto out;
>         }
>
> @@ -10356,7 +10356,7 @@ static void nohz_balancer_kick(struct rq *rq)
>                  * on.
>                  */
>                 if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
> -                       flags = NOHZ_KICK_MASK;
> +                       flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
>                         goto unlock;
>                 }
>         }
> @@ -10370,7 +10370,7 @@ static void nohz_balancer_kick(struct rq *rq)
>                  */
>                 for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
>                         if (sched_asym_prefer(i, cpu)) {
> -                               flags = NOHZ_KICK_MASK;
> +                               flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
>                                 goto unlock;
>                         }
>                 }
> @@ -10383,7 +10383,7 @@ static void nohz_balancer_kick(struct rq *rq)
>                  * to run the misfit task on.
>                  */
>                 if (check_misfit_status(rq, sd)) {
> -                       flags = NOHZ_KICK_MASK;
> +                       flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
>                         goto unlock;
>                 }
>
> @@ -10410,7 +10410,7 @@ static void nohz_balancer_kick(struct rq *rq)
>                  */
>                 nr_busy = atomic_read(&sds->nr_busy_cpus);
>                 if (nr_busy > 1) {
> -                       flags = NOHZ_KICK_MASK;
> +                       flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
>                         goto unlock;
>                 }
>         }
> @@ -10572,7 +10572,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>          * setting the flag, we are sure to not clear the state and not
>          * check the load of an idle cpu.
>          */
> -       WRITE_ONCE(nohz.has_blocked, 0);
> +       if (flags & NOHZ_STATS_KICK)
> +               WRITE_ONCE(nohz.has_blocked, 0);
>
>         /*
>          * Ensures that if we miss the CPU, we must see the has_blocked
> @@ -10594,13 +10595,15 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>                  * balancing owner will pick it up.
>                  */
>                 if (need_resched()) {
> -                       has_blocked_load = true;
> +                       if (flags & NOHZ_STATS_KICK)
> +                               has_blocked_load = true;
>                         goto abort;
>                 }
>
>                 rq = cpu_rq(balance_cpu);
>
> -               has_blocked_load |= update_nohz_stats(rq);
> +               if (flags & NOHZ_STATS_KICK)
> +                       has_blocked_load |= update_nohz_stats(rq);
>
>                 /*
>                  * If time for next balance is due,
> @@ -10631,8 +10634,9 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>         if (likely(update_next_balance))
>                 nohz.next_balance = next_balance;
>
> -       WRITE_ONCE(nohz.next_blocked,
> -               now + msecs_to_jiffies(LOAD_AVG_PERIOD));
> +       if (flags & NOHZ_STATS_KICK)
> +               WRITE_ONCE(nohz.next_blocked,
> +                          now + msecs_to_jiffies(LOAD_AVG_PERIOD));
>
>  abort:
>         /* There is still blocked load, enable periodic update */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e7e2bba5b520..30b7bd2ef25d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2706,12 +2706,18 @@ extern void cfs_bandwidth_usage_dec(void);
>  #define NOHZ_BALANCE_KICK_BIT  0
>  #define NOHZ_STATS_KICK_BIT    1
>  #define NOHZ_NEWILB_KICK_BIT   2
> +#define NOHZ_NEXT_KICK_BIT     3
>
> +/* Run rebalance_domains() */
>  #define NOHZ_BALANCE_KICK      BIT(NOHZ_BALANCE_KICK_BIT)
> +/* Update blocked load */
>  #define NOHZ_STATS_KICK                BIT(NOHZ_STATS_KICK_BIT)
> +/* Update blocked load when entering idle */
>  #define NOHZ_NEWILB_KICK       BIT(NOHZ_NEWILB_KICK_BIT)
> +/* Update nohz.next_balance */
> +#define NOHZ_NEXT_KICK         BIT(NOHZ_NEXT_KICK_BIT)
>
> -#define NOHZ_KICK_MASK (NOHZ_BALANCE_KICK | NOHZ_STATS_KICK)
> +#define NOHZ_KICK_MASK (NOHZ_BALANCE_KICK | NOHZ_STATS_KICK | NOHZ_NEXT_KICK)
>
>  #define nohz_flags(cpu)        (&cpu_rq(cpu)->nohz_flags)
>
> --
> 2.25.1
>
