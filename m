Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394FD331018
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCHNzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhCHNwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:52:53 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EFCC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:52:52 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id i26so4528822ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TyISWynkQbLsmqv63EbXbzn/gdQBbTdz+mBz2pEw8Sc=;
        b=E3LoPVy5zK5fUvHnnqH5ZcM5FsjntJYlmY4qQeK18Z4U7XRmoQ2JcCDVpsLfeTp8+0
         8mxer5bbY6Z6SHRo8P98OVLbBCACXBQgLbHDWYNWt8XehDUPdu4qxQKRIfJIEpoGhSe9
         phOjZVHCuhllTkDUXny/DqhW7rW5rotxFhBJGVvomWb/IgfGNzXBQGUeTpYM25V/peM3
         U99ryf4H2hbLUIkjsbkjOT6J0akgrm7MROUZvkYnlUHh8BHDEftmmJJldNVYPg3CoF/Z
         FJKDFLc+EEvAYL0Doz11vG8y6l3cyhElXITnjR53V4I10iftk0o7ezxA/HuvgcSSHFNy
         PMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TyISWynkQbLsmqv63EbXbzn/gdQBbTdz+mBz2pEw8Sc=;
        b=iJTvXnseKyWjTEPoDD4S+edvmiSjqMBIC9cm95b1vb/NjYS/9m9BHoLCiXkREDQb3u
         F2qKbo13O7Xx8G5v3KZpzqvsuCZm5S8XW8MVSrUOWtCXblc8Sg8d/gJ8IWlx9lxzZtzf
         t6U0DLcBeIqU47Wk7CG2vENKyKEgSTjgMc+/eB/o0aMAtTdnGcZSnE1GF3exMrOG7jGJ
         gxl/hOgnQ+mk8/ySI0ssiSMiJme1EBa5zlFZRFpzJuTVBpS2LTr2lYF39i+VaB15sMhd
         VpXCg8hGMTi3KrBRmjx8LGpYriux3JGfbSgnnIjauA5MmIT4Bvp8RxuzavkIeQCOuha/
         rlOQ==
X-Gm-Message-State: AOAM533ZABY04+giWzAKE0H0hLrLNa+z7sJ16a6Lur4vpbxVjrHMjwAw
        HuYondipZbh6aeyviqShiEedN7PjmjsfXCcS6L18kw==
X-Google-Smtp-Source: ABdhPJyx6bN1g8/bjXem4NdE2WFDgdHnocy7DAhk1Inj4reFt548zawnjVaUqBkyk0kFgVUN2A5+g+qE9tu0zhR2qR0=
X-Received: by 2002:a2e:5315:: with SMTP id h21mr13383433ljb.299.1615211571371;
 Mon, 08 Mar 2021 05:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
In-Reply-To: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 8 Mar 2021 14:52:39 +0100
Message-ID: <CAKfTPtA2XSmqt1L2X9WvdtdA5eqNYuhSws8jDOr1HA1xqXWfDQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 at 17:41, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> On POWER8 and POWER9, the last level cache (L2) has been at the level of
> a group of 8 threads (SMT8 on POWER8, a big-core comprising of a pair of
> SMT4 cores on POWER9). However, on POWER10, the LLC domain is at the
> level of a group of SMT4 threads within the SMT8 core. Due to the
> shrinking in the size of the LLC domain, the probability of finding an
> idle CPU in the LLC domain of the target is lesser on POWER10 compared
> to the previous generation processors.
>
> With commit 9538abee18cc ("powerpc/smp: Add support detecting
> thread-groups sharing L2 cache") benchmarks such as Daytrader
> (https://github.com/WASdev/sample.daytrader7) show a drop in throughput
> in a configuration consisting of 1 JVM spanning across 6-8 Bigcores on
> POWER10.  Analysis showed that this was because more number of wakeups
> were happening on busy CPUs when the utilization was 60-70%. This drop
> in throughput also shows up as a drop in CPU utilization. However most
> other benchmarks benefit with detecting the thread-groups that share L2
> cache.
>
> Current order of preference to pick a LLC while waking a wake-affine
> task:
> 1. Between the waker CPU and previous CPU, prefer the LLC of the CPU
>    that is idle.
>
> 2. Between the waker CPU and previous CPU, prefer the LLC of the CPU
>    that is less lightly loaded.
>
> In the current situation where waker and previous CPUs are busy, but
> only one of its LLC has an idle CPU, Scheduler may end up picking a LLC
> with no idle CPUs. To mitigate this, add a new step between 1 and 2
> where Scheduler compares idle CPUs in waker and previous LLCs and picks
> the appropriate one.
>
> The other alternative is to search for an idle CPU in the other LLC, if
> the current select_idle_sibling is unable to find an idle CPU in the
> preferred LLC. But that may increase the time to select a CPU.
>
>
>                                      5.11-rc6      5.11-rc6+revert   5.11-rc6+patch
> 8CORE/1JVM  80USERS   throughput     6651.6        6716.3 (0.97%)    6940 (4.34%)
>                       sys/user:time  59.75/23.86   61.77/24.55       60/24
>
> 8CORE/2JVM  80USERS   throughput     6425.4        6446.8 (0.33%)    6473.2 (0.74%)
>                       sys/user:time  70.59/24.25   72.28/23.77       70/24
>
> 8CORE/4JVM  80USERS   throughput     5355.3        5551.2 (3.66%)    5586.6 (4.32%)
>                       sys/user:time  76.74/21.79   76.54/22.73       76/22
>
> 8CORE/8JVM  80USERS   throughput     4420.6        4553.3 (3.00%)    4405.8 (-0.33%)
>                       sys/user:time  79.13/20.32   78.76/21.01       79/20
>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Cc: Parth Shah <parth@linux.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Co-developed-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Co-developed-by: Parth Shah <parth@linux.ibm.com>
> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c     | 41 +++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/features.h |  2 ++
>  2 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a8bd7b13634..d49bfcdc4a19 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5869,6 +5869,36 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
>         return this_eff_load < prev_eff_load ? this_cpu : nr_cpumask_bits;
>  }
>
> +static int prefer_idler_llc(int this_cpu, int prev_cpu, int sync)
> +{
> +       struct sched_domain_shared *tsds, *psds;
> +       int pnr_busy, pllc_size, tnr_busy, tllc_size, diff;
> +
> +       tsds = rcu_dereference(per_cpu(sd_llc_shared, this_cpu));
> +       tnr_busy = atomic_read(&tsds->nr_busy_cpus);
> +       tllc_size = per_cpu(sd_llc_size, this_cpu);
> +
> +       psds = rcu_dereference(per_cpu(sd_llc_shared, prev_cpu));
> +       pnr_busy = atomic_read(&psds->nr_busy_cpus);
> +       pllc_size = per_cpu(sd_llc_size, prev_cpu);
> +
> +       /* No need to compare, if both LLCs are fully loaded */
> +       if (pnr_busy == pllc_size && tnr_busy == pllc_size)
> +               return nr_cpumask_bits;
> +
> +       if (sched_feat(WA_WAKER) && tnr_busy < tllc_size)
> +               return this_cpu;

Why have you chosen to favor this_cpu instead of prev_cpu unlike for wake_idle ?

> +
> +       /* For better wakeup latency, prefer idler LLC to cache affinity */
> +       diff = tnr_busy * pllc_size - sync - pnr_busy * tllc_size;
> +       if (!diff)
> +               return nr_cpumask_bits;
> +       if (diff < 0)
> +               return this_cpu;
> +
> +       return prev_cpu;
> +}
> +
>  static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>                        int this_cpu, int prev_cpu, int sync)
>  {
> @@ -5877,6 +5907,10 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>         if (sched_feat(WA_IDLE))
>                 target = wake_affine_idle(this_cpu, prev_cpu, sync);
>
> +       if (sched_feat(WA_IDLER_LLC) && target == nr_cpumask_bits &&
> +                               !cpus_share_cache(this_cpu, prev_cpu))
> +               target = prefer_idler_llc(this_cpu, prev_cpu, sync);

could you use the same naming convention as others function ?
wake_affine_llc as an example

> +
>         if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
>                 target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
>
> @@ -5884,8 +5918,11 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>         if (target == nr_cpumask_bits)
>                 return prev_cpu;
>
> -       schedstat_inc(sd->ttwu_move_affine);
> -       schedstat_inc(p->se.statistics.nr_wakeups_affine);
> +       if (target == this_cpu) {

How is this condition related to $subject ?

> +               schedstat_inc(sd->ttwu_move_affine);
> +               schedstat_inc(p->se.statistics.nr_wakeups_affine);
> +       }
> +
>         return target;
>  }
>
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 1bc2b158fc51..e2de3ba8d5b1 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -83,6 +83,8 @@ SCHED_FEAT(ATTACH_AGE_LOAD, true)
>
>  SCHED_FEAT(WA_IDLE, true)
>  SCHED_FEAT(WA_WEIGHT, true)
> +SCHED_FEAT(WA_IDLER_LLC, true)
> +SCHED_FEAT(WA_WAKER, false)
>  SCHED_FEAT(WA_BIAS, true)
>
>  /*
> --
> 2.18.4
>
