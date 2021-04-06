Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2353355764
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345495AbhDFPKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhDFPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:10:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBB3C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 08:10:29 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z8so16859908ljm.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHyCt3+3ROsg7DoWYdHlXlVTLvXgZLRc7i9sKG8h3XY=;
        b=vplVZm/LkWI6XfVVnEVGwFjVh6Z9rokTELj8tYPDvoPGc4+bnEElq+0LanSpXzbOml
         kf8B0f3LiyPs6PYi6iSapwKB8qrSluZlaNCCOAR+O1YsoRblPLeYOHn2mQbXbIC9GHZX
         avuLHdboxP8uDX2VQwGSLbFqvaHOAL8yNuptA5ZgHpIBAVUGDvF3uBRWlbd2eupujiyC
         fmAkiOTnOY7jy6m6g93HMJiS0fpypkt8TwdrHpS+e+zmXLBBysMQYxYcvSt+QJS/XaB4
         hHNvfVnOJT254U7ps1Vdq6FlWzfzh2IA1WEB8OstQqzl5Y616rI1Z6Kfsk47mA6gJ0zH
         O2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHyCt3+3ROsg7DoWYdHlXlVTLvXgZLRc7i9sKG8h3XY=;
        b=tHNtObE5B7X1UsM4QoG3RhIrqn66Z8xHlVnittG7k1C93XGsQdNgnM2cfh62gYPM2E
         zQNyVQVyI/yv9GkopZ0xW9IakFqQXTC0XxW8+pTds5v00SwVFYCreOXl9GmH1OyzNhG1
         mM++U4lkAd+CxKP7zdejOfvrNdcKmd0CQCnAVPxuY5G/UQYl+sNLN8K2DMOESmuiDiSj
         H23vqVEetN6ouD11jqXyYWJQqZ2EeYH6dvOaZaBhQDqq02fE+Dz11uTx8j7HTqLqy12L
         +MLhSdzHeFAGg3k4XPZqsuHPjSm35DvHlnBhr9a/WOOpEnPH6qP2VQDNF775aMTkK2re
         GZfA==
X-Gm-Message-State: AOAM530ZpGq8+3dgGzPV03H0l/PnzQPm0XKn/dK7Bu5IxaKUX+HFvijm
        idRMFek6NvOzY2NFl5SC9ejb4NFLim0I/cPBOUyPd/pJeaqoOA==
X-Google-Smtp-Source: ABdhPJw0a8VnD6iKPgmP7qkFl6yXqLCO9xrUlajzUomQypCkGNkkUfH7Lpv+gT6k4CUsWArWCIoSjN4ne7sL/q23xcY=
X-Received: by 2002:a2e:730b:: with SMTP id o11mr19337401ljc.221.1617721828007;
 Tue, 06 Apr 2021 08:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210321150358.71ef52b1@imladris.surriel.com> <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com>
In-Reply-To: <20210326151932.2c187840@imladris.surriel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 6 Apr 2021 17:10:16 +0200
Message-ID: <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but differently
To:     Rik van Riel <riel@surriel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2021 at 20:19, Rik van Riel <riel@surriel.com> wrote:
>
> On Mon, 22 Mar 2021 11:03:06 +0000
> Mel Gorman <mgorman@techsingularity.net> wrote:
>
>
> > Second, select_idle_smt() does not use the cpus mask so consider moving
> > the cpus initialisation after select_idle_smt() has been called.
> > Specifically this initialisation
> >
> >       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >
> > Alternatively, clear the bits in the SMT sibling scan to avoid checking
> > the siblings twice. It's a tradeoff because initialising and clearing
> > bits is not free and the cost is wasted if a sibling is free.
>
> I tried a number of different variations on moving the CPU mask
> initialization, and clearing CPUs from the mask, and failed to
> get any clear results from those in testing, even in workloads
> with lots of context switches.
>
> Below is a simple version that seems to perform identically to
> more complicated versions :)
>
> ---8<---
> sched,fair: bring back select_idle_smt, but differently
>
> Mel Gorman did some nice work in 9fe1f127b913
> ("sched/fair: Merge select_idle_core/cpu()"), resulting in the kernel
> being more efficient at finding an idle CPU, and in tasks spending less
> time waiting to be run, both according to the schedstats run_delay
> numbers, and according to measured application latencies. Yay.
>
> The flip side of this is that we see more task migrations (about
> 30% more), higher cache misses, higher memory bandwidth utilization,
> and higher CPU use, for the same number of requests/second.
>
> This is most pronounced on a memcache type workload, which saw
> a consistent 1-3% increase in total CPU use on the system, due
> to those increased task migrations leading to higher L2 cache
> miss numbers, and higher memory utilization. The exclusive L3
> cache on Skylake does us no favors there.
>
> On our web serving workload, that effect is usually negligible.
>
> It appears that the increased number of CPU migrations is generally
> a good thing, since it leads to lower cpu_delay numbers, reflecting
> the fact that tasks get to run faster. However, the reduced locality
> and the corresponding increase in L2 cache misses hurts a little.
>
> The patch below appears to fix the regression, while keeping the
> benefit of the lower cpu_delay numbers, by reintroducing select_idle_smt
> with a twist: when a socket has no idle cores, check to see if the
> sibling of "prev" is idle, before searching all the other CPUs.
>
> This fixes both the occasional 9% regression on the web serving
> workload, and the continuous 2% CPU use regression on the memcache
> type workload.
>
> With Mel's patches and this patch together, task migrations are still
> high, but L2 cache misses, memory bandwidth, and CPU time used are back
> down to what they were before. The p95 and p99 response times for the
> memcache type application improve by about 10% over what they were
> before Mel's patches got merged.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  kernel/sched/fair.c | 68 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 52 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..69680158963f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6098,6 +6098,28 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
>         return -1;
>  }
>
> +/*
> + * Scan the local SMT mask for idle CPUs.
> + */
> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int
> +target)
> +{
> +       int cpu;
> +
> +       if (!static_branch_likely(&sched_smt_present))
> +               return -1;
> +
> +       for_each_cpu(cpu, cpu_smt_mask(target)) {
> +               if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> +                   !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> +                       continue;
> +               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> +                       return cpu;
> +       }
> +
> +       return -1;
> +}
> +
>  #else /* CONFIG_SCHED_SMT */
>
>  static inline void set_idle_cores(int cpu, int val)
> @@ -6114,6 +6136,11 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
>         return __select_idle_cpu(core);
>  }
>
> +static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +       return -1;
> +}
> +
>  #endif /* CONFIG_SCHED_SMT */
>
>  /*
> @@ -6121,7 +6148,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>   * average idle time for this rq (as found in rq->avg_idle).
>   */
> -static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
> +static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int prev, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>         int i, cpu, idle_cpu = -1, nr = INT_MAX;
> @@ -6136,23 +6163,32 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
> -       if (sched_feat(SIS_PROP) && !smt) {
> -               u64 avg_cost, avg_idle, span_avg;
> +       if (!smt) {
> +               if (cpus_share_cache(prev, target)) {

Have you checked the impact on no smt system ? would worth a static branch.

Also, this doesn't need to be in select_idle_cpu() which aims to loop
the sched_domain becaus you only compare  target and prev. So you can
move this call to select_idle_smt() in select_idle_sibling() as part
of all the others tests done on prev/target/recent_used_cpu before
calling select_idle_cpu() and even save a useless  sd =
rcu_dereference(per_cpu(sd_llc, target));


> +                       /* No idle core. Check if prev has an idle sibling. */
> +                       i = select_idle_smt(p, sd, prev);
> +                       if ((unsigned int)i < nr_cpumask_bits)
> +                               return i;
> +               }
>
> -               /*
> -                * Due to large variance we need a large fuzz factor;
> -                * hackbench in particularly is sensitive here.
> -                */
> -               avg_idle = this_rq()->avg_idle / 512;
> -               avg_cost = this_sd->avg_scan_cost + 1;
> +               if (sched_feat(SIS_PROP)) {
> +                       u64 avg_cost, avg_idle, span_avg;
>
> -               span_avg = sd->span_weight * avg_idle;
> -               if (span_avg > 4*avg_cost)
> -                       nr = div_u64(span_avg, avg_cost);
> -               else
> -                       nr = 4;
> +                       /*
> +                        * Due to large variance we need a large fuzz factor;
> +                        * hackbench in particularly is sensitive here.
> +                        */
> +                       avg_idle = this_rq()->avg_idle / 512;
> +                       avg_cost = this_sd->avg_scan_cost + 1;
>
> -               time = cpu_clock(this);
> +                       span_avg = sd->span_weight * avg_idle;
> +                       if (span_avg > 4*avg_cost)
> +                               nr = div_u64(span_avg, avg_cost);
> +                       else
> +                               nr = 4;
> +
> +                       time = cpu_clock(this);
> +               }
>         }
>
>         for_each_cpu_wrap(cpu, cpus, target) {
> @@ -6307,7 +6343,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         if (!sd)
>                 return target;
>
> -       i = select_idle_cpu(p, sd, target);
> +       i = select_idle_cpu(p, sd, prev, target);
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
> --
> 2.25.4
>
>
