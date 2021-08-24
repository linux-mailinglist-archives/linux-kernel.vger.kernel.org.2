Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D328E3F5A78
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhHXJJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhHXJJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:09:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813EAC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:08:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i9so43947720lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezIe6HxE2ieWh14VeCkqLloBvcx3gl62yY/h5Ittveg=;
        b=nr5NRHM3XNvY8V1DXtuSXQ8Vhl60JFjnfPoOIZ8BAT0DZHaNnb/5wGRkNc8MvRNuSY
         VgR85M/tYBrkZ3pDBcrEgvmkFmZ+EjocvaX8Qt/xDLvuz4mdRjOzOVjFq61U2AEI0PkN
         C9o7B0e6KT5+ubihCF2V5THmO2gSzfmqmIDVnC4F/Gn7tUifzcqJQZd8Ye5KU3SnfEEv
         S0nPUwsDny8BLSiDHhVy7jTLIPbFUqNmNJUcHQ4xOgSPbXM/csnKMTkFqzFqshjAzrpP
         SlT9Rwyrp9Mu6x/GpAPD0I71Nh/FLnUzflcfXRAdes6PU0Kz2TbVrIFVyT7dKSXjm+tL
         EheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezIe6HxE2ieWh14VeCkqLloBvcx3gl62yY/h5Ittveg=;
        b=gnl9umdjtzUKnsyKp6KIw4JPF+QICeJWnqMIoFmL5hiErNysKUYc78t91+53W5zi2Z
         WwCfcCAcuWmt6Mn/mE5AmIoALtyNLTOihLj0gUALT2Ie62DGCjT7rPArIuulvQf9EnA8
         0p/ov2ow6bh2K/rG2jDKrPjCNMAe6d/bItxzAy0XJKx99mkbytLzMGY0kke+Gj6TY1iR
         g5qCDjaSHoh8ZNIp3TTFrtNf048/jukJwR1qd2OF73WAj/KxrCv6tMMZ86voXfODcTJZ
         dvoINhybKzkMDZvH59DE8IBQiFuLqM16aUF/A0MDZLbU/aTbwQMlnFtLcIdocIYZCfrg
         9Cmw==
X-Gm-Message-State: AOAM531qOlPbyk8sn2ebCm+fVnpm9pq7Y2Z0zpPECqru9G1VKH64TF6E
        RxiGG8AEJ/0hO5KJnzfcm7TJhchH4kBge7CuiB1GCw==
X-Google-Smtp-Source: ABdhPJxtOHtfs37VvTT6tFaMl4uWLJqeFSRbU1y1IuLMdB6+QcrdcoKYcI82mmqDbScquyMv34Td9TOfFwxW6499Nhk=
X-Received: by 2002:a05:6512:1041:: with SMTP id c1mr28230612lfb.277.1629796129896;
 Tue, 24 Aug 2021 02:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210823111700.2842997-1-valentin.schneider@arm.com> <20210823111700.2842997-3-valentin.schneider@arm.com>
In-Reply-To: <20210823111700.2842997-3-valentin.schneider@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 24 Aug 2021 11:08:38 +0200
Message-ID: <CAKfTPtDok2mi92-utbWvGgPO37o1CKLj=i4W++XE3r6OOKm+2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] sched/fair: Trigger nohz.next_balance updates when
 a CPU goes NOHZ-idle
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
>
> Use the new nohz.needs_update flag to mark the presence of newly-idle CPUs
> that need their rq->next_balance to be collated into
> nohz.next_balance. Trigger a NOHZ_NEXT_KICK when the flag is set.
>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4a91f3027c92..081a9e54058a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5754,6 +5754,7 @@ static struct {
>         cpumask_var_t idle_cpus_mask;
>         atomic_t nr_cpus;
>         int has_blocked;                /* Idle CPUS has blocked load */
> +       int needs_update;               /* Newly idle CPUs need their next_balance collated */
>         unsigned long next_balance;     /* in jiffy units */
>         unsigned long next_blocked;     /* Next update of blocked load in jiffies */
>  } nohz ____cacheline_aligned;
> @@ -10417,6 +10418,9 @@ static void nohz_balancer_kick(struct rq *rq)
>  unlock:
>         rcu_read_unlock();
>  out:
> +       if (READ_ONCE(nohz.needs_update))
> +               flags |= NOHZ_NEXT_KICK;
> +
>         if (flags)
>                 kick_ilb(flags);
>  }
> @@ -10513,12 +10517,13 @@ void nohz_balance_enter_idle(int cpu)
>         /*
>          * Ensures that if nohz_idle_balance() fails to observe our
>          * @idle_cpus_mask store, it must observe the @has_blocked
> -        * store.
> +        * and @needs_update stores.
>          */
>         smp_mb__after_atomic();
>
>         set_cpu_sd_state_idle(cpu);
>
> +       WRITE_ONCE(nohz.needs_update, 1);
>  out:
>         /*
>          * Each time a cpu enter idle, we assume that it has blocked load and
> @@ -10567,13 +10572,17 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>         /*
>          * We assume there will be no idle load after this update and clear
>          * the has_blocked flag. If a cpu enters idle in the mean time, it will
> -        * set the has_blocked flag and trig another update of idle load.
> +        * set the has_blocked flag and trigger another update of idle load.
>          * Because a cpu that becomes idle, is added to idle_cpus_mask before
>          * setting the flag, we are sure to not clear the state and not
>          * check the load of an idle cpu.
> +        *
> +        * Same applies to idle_cpus_mask vs needs_update.
>          */
>         if (flags & NOHZ_STATS_KICK)
>                 WRITE_ONCE(nohz.has_blocked, 0);
> +       if (flags & NOHZ_NEXT_KICK)
> +               WRITE_ONCE(nohz.needs_update, 0);
>
>         /*
>          * Ensures that if we miss the CPU, we must see the has_blocked
> @@ -10597,6 +10606,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
>                 if (need_resched()) {
>                         if (flags & NOHZ_STATS_KICK)
>                                 has_blocked_load = true;
> +                       if (flags & NOHZ_NEXT_KICK)
> +                               WRITE_ONCE(nohz.needs_update, 1);
>                         goto abort;
>                 }
>
> --
> 2.25.1
>
