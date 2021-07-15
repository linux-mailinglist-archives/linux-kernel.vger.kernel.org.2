Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFB3C99CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbhGOHpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhGOHpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:45:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D39C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:42:39 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b40so7372155ljf.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWDfac2kJgbnjU7/Ca+RQwYwqWngWC8KgGe46fQW+zg=;
        b=KdsI+JB5avJc+++JQZ4vaAU2HAP136dEYF0MPXd4ES+NfWppWEenqDDeV5Tkg9Mulb
         HwTRzWTHrEhKxf42WarN60r6hlQbUOErIysmyl8JyGS+lMTNUyFnBXgOTunxiFzugNxM
         iAc24a360WP9FxmopUXOj1PhkhLQaoWTuq5zApxwhImBRmH8mXt7ViSaqKN4PD2EF9nc
         4cb1Zxaik6O2gMLhNCY4P/6MEDCjbrlKQXTUqBbJvz4tA9pKZ2WZ2SRU5cSZYrDkP6zB
         UspVlktwBpAsMxNxD6mxkmjUibONEZSli8VcEdOFkMf8PU+UI5iV/mJYEam/ToAuQl2w
         C3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWDfac2kJgbnjU7/Ca+RQwYwqWngWC8KgGe46fQW+zg=;
        b=Zx0rkqVU5YXoHmApDXz24vB7SlWvndFww2Pue0msOkv1ghRuFT8DtlIz2zPHBUx1F6
         G28IYD64diqXgPTRonTahNaIyKTBfeDduTCQQcxLvdVd1ZM3VvNRhjf586k3lwoP6inK
         aekvAIT1a5YGuCFKwU2Zw2WxWPsax8x5pM9909G6rxmdND2wAflCJYdoTWlp32ub6DbY
         oDlgprYVRvSQ3tUv9p9MUD3OgVBbQRMPhOr1k3RygtCFdiV6o8JRDjTjdvwq+rwNoZwx
         CiJhf1RgmvOY9Tly3qOXWbJl0l/V+zSgpCFBUVy2GTVZp0a3Z/CqzcE+UKdSSI/G5gDy
         h3xg==
X-Gm-Message-State: AOAM531Bhqw5f0RIoBpy9rLVsIja6dVoND3M4wntkBAtYW4E+EeUTKkW
        KYSkOB3cGsyC6vzxIOVen4eBMvtdZog9jFjqkScF4w==
X-Google-Smtp-Source: ABdhPJyB9JN6djU6TCFrFxrsJ9eiLdgiY+8ijVmNToSvP1U8zc0AlYAJ1+Ct/wEjzyryZS9OPc06rUsnuFIU6CGXUwU=
X-Received: by 2002:a2e:a23b:: with SMTP id i27mr2645993ljm.176.1626334958145;
 Thu, 15 Jul 2021 00:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210714113928.2795632-1-valentin.schneider@arm.com>
In-Reply-To: <20210714113928.2795632-1-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 15 Jul 2021 09:42:26 +0200
Message-ID: <CAKfTPtCKJEgm=hXkKz0pHDE2d3Bz+6wp1kkNB+P+OpzWcR1+wg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Update nohz.next_balance for newly NOHZ-idle CPUs
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 at 13:39, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> Consider a system with some NOHZ-idle CPUs, such that
>
>   nohz.idle_cpus_mask = S
>   nohz.next_balance = T
>
> When a new CPU k goes NOHZ idle (nohz_balance_enter_idle()), we end up
> with:
>
>   nohz.idle_cpus_mask = S \U {k}
>   nohz.next_balance = T
>
> Note that the nohz.next_balance hasn't changed - it won't be updated until
> a NOHZ balance is triggered. This is problematic if the newly NOHZ idle CPU
> has an earlier rq.next_balance than the other NOHZ idle CPUs, IOW if:
>
>   cpu_rq(k).next_balance < nohz.next_balance
>
> In such scenarios, the existing nohz.next_balance will prevent any NOHZ
> balance from happening, which itself will prevent nohz.next_balance from
> being updated to this new cpu_rq(k).next_balance. Unnecessary load balance
> delays of over 12ms caused by this were observed on an arm64 RB5 board.

How many CPUs has the arm64 RB5 ?

>
> Track which CPUs are iterated over during a NOHZ idle balance with a new
> cpumask. When considering whether to kick a NOHZ idle balance, use this
> cpumask to determine if any CPU has entered NOHZ idle but hasn't had its
> rq.next_balance collated into nohz.next_balance yet, and kick a NOHZ_STATS
> balance if it is the case.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/core.c |  8 ++++++++
>  kernel/sched/fair.c | 19 +++++++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0c22cd026440..1bc4cbc1f85e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8893,6 +8893,10 @@ static struct kmem_cache *task_group_cache __read_mostly;
>  DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
>  DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
>
> +#ifdef CONFIG_NOHZ_COMMON
> +DECLARE_PER_CPU(cpumask_var_t, nohz_balance_mask);
> +#endif /* CONFIG_NOHZ_COMMON */
> +
>  void __init sched_init(void)
>  {
>         unsigned long ptr = 0;
> @@ -8942,6 +8946,10 @@ void __init sched_init(void)
>                         cpumask_size(), GFP_KERNEL, cpu_to_node(i));
>                 per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
>                         cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> +#ifdef CONFIG_NOHZ_COMMON
> +               per_cpu(nohz_balance_mask, i) = (cpumask_var_t)kzalloc_node(
> +                       cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> +#endif /* CONFIG_NOHZ_COMMON */
>         }
>  #endif /* CONFIG_CPUMASK_OFFSTACK */
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 11d22943753f..497208a1afb8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5694,8 +5694,11 @@ DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
>
>  #ifdef CONFIG_NO_HZ_COMMON
>
> +DEFINE_PER_CPU(cpumask_var_t, nohz_balance_mask);
> +
>  static struct {
> -       cpumask_var_t idle_cpus_mask;
> +       cpumask_var_t idle_cpus_mask;    /* CPUs in NOHZ idle */
> +       cpumask_var_t last_balance_mask; /* CPUs covered by last NOHZ balance */
>         atomic_t nr_cpus;
>         int has_blocked;                /* Idle CPUS has blocked load */
>         unsigned long next_balance;     /* in jiffy units */
> @@ -10351,6 +10354,13 @@ static void nohz_balancer_kick(struct rq *rq)
>  unlock:
>         rcu_read_unlock();
>  out:
> +       /*
> +        * Some CPUs have recently gone into NOHZ idle; kick a balance to
> +        * collate the proper next balance interval.
> +        */
> +       if (!cpumask_subset(nohz.idle_cpus_mask, nohz.last_balance_mask))

I don't really like having to manipulate a cpumask just to trigger an
ILB and force the update of nohz.next_balance. Could we use something
similar to nohz.has_blocked and introduce a nohz.force_update.
manipulating cpumask will even be more complex if we start to have a
per node idle_cpus_mask like proposed here:
https://lore.kernel.org/lkml/20210701055323.2199175-1-npiggin@gmail.com/

Also


Something like below is simpler

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44e44c235f1f..91c314f58982 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10657,6 +10657,9 @@ static void nohz_newidle_balance(struct rq *this_rq)
        if (this_rq->avg_idle < sysctl_sched_migration_cost)
                return;

+       if (time_before(this_rq->next_balance, READ_ONCE(nohz.next_balance))
+               WRITE_ONCE(nohz.need_update, 1);
+
        /* Don't need to update blocked load of idle CPUs*/
        if (!READ_ONCE(nohz.has_blocked) ||
            time_before(jiffies, READ_ONCE(nohz.next_blocked)))


Then we have to test nohz.need_update in nohz_balancer_kick()

> +               flags |= NOHZ_STATS_KICK;

people complain that an update of blocked load is time consuming so we
should not kick this update unnecessarily.
We should introduce a new bit like NOHZ_NEXT_KICK that will only go
through idle cpus and update nohz.next_balance

> +
>         if (flags)
>                 kick_ilb(flags);
>  }
> @@ -10487,6 +10497,7 @@ static bool update_nohz_stats(struct rq *rq)
>  static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>                                enum cpu_idle_type idle)
>  {
> +       struct cpumask *cpus = this_cpu_cpumask_var_ptr(nohz_balance_mask);
>         /* Earliest time when we have to do rebalance again */
>         unsigned long now = jiffies;
>         unsigned long next_balance = now + 60*HZ;
> @@ -10518,7 +10529,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>          * Start with the next CPU after this_cpu so we will end with this_cpu and let a
>          * chance for other idle cpu to pull load.
>          */
> -       for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
> +       cpumask_copy(cpus, nohz.idle_cpus_mask);

we are not sure to go through all idle cpus and ilb can abort

> +       for_each_cpu_wrap(balance_cpu, cpus, this_cpu+1) {
>                 if (!idle_cpu(balance_cpu))
>                         continue;
>
> @@ -10565,6 +10577,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>         if (likely(update_next_balance))
>                 nohz.next_balance = next_balance;
>
> +       cpumask_copy(nohz.last_balance_mask, cpus);
> +
>         WRITE_ONCE(nohz.next_blocked,
>                 now + msecs_to_jiffies(LOAD_AVG_PERIOD));
>
> @@ -11550,6 +11564,7 @@ __init void init_sched_fair_class(void)
>         nohz.next_balance = jiffies;
>         nohz.next_blocked = jiffies;
>         zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
> +       zalloc_cpumask_var(&nohz.last_balance_mask, GFP_NOWAIT);
>  #endif
>  #endif /* SMP */
>
> --
> 2.25.1
>
