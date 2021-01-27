Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4051E3058CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhA0KuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbhA0KpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:45:04 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50595C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:43:35 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id y11so1532203ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wz3Wy01wkKMxIhv7JYoPQskmaJ3uYiOSVyJgUCeiQMA=;
        b=Y9JbmVfH7o/xOhHWdLIJQcEvyRAHSvrulYDFHzrZ+k25GD6Kzxx3/RC5BXZVIwx4Go
         Hp/MJgQmYiwS0ySLAriBu698G+MOYKZc/MmwrC+Mg2oATGwilXGTjOTrkRmbEBTqSYJA
         VsKNYa6ThMwFMCKOq1d+2/XdbfR+xT8dWBA8NsmOSlbz8cAYV9Sn0cYBSlG3Jk1VFWCs
         omJ4A4yQIxpMbfletbnhrBNndBPKKZ3OYD2YgeYotkRIVCSK3uqf0ug8Qef020RNB3qt
         DgM3pjDDF8hBOzg4xr6h0xzSJgAsVjJZaButuAu0suqV9BjPYtKbhzk75TTkZE3MgN6L
         xW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wz3Wy01wkKMxIhv7JYoPQskmaJ3uYiOSVyJgUCeiQMA=;
        b=PKHvHM1wj7zY2XyeuBWVfiyu6vl76Z2XgvKHQSPPc8+tWW0GNRktD+7miyeDwZw1dY
         MUm1s63DzJK6QdhA/wQN+S6GP2HEIxksnDjTCMG2oRyf5VgjlGqSFMku/Ta28A/3NG/i
         rPs+Y6dyAXJXRzNjmwSOUrq+NYrqam41oNIqlbCmh5Auk7vdWLrk0YeQbKrAvT/isxS+
         7sN/ZM6agoJvzKP+sFzPl+A6ybOKV7YnGC5RlOldNPKqcRAddK+w4erqgqXcJom8wdWm
         7E+5Uko1TLKAZtnma2Hx9V5ZoyfOkPMMCnoiBCmp+MKEpsvU0WYLJbZDdUP1dSCRyCW1
         MJwg==
X-Gm-Message-State: AOAM530BYDCPoBq8qkgNI+lzfzSQzLBsWnDMxWxL1RfOL9e226wrt7Mo
        +02w3oPsRfPwA7jYYto7CztpGof8roFBMrBX1s0O5g==
X-Google-Smtp-Source: ABdhPJwlJqojxck/fCMEB8bLkNsM00gWH4KVmlODosq+pkBcaedJ4AAVupzpKnPOVwNKH8l+azeL1mOLYYJCkaLMBI8=
X-Received: by 2002:a2e:9548:: with SMTP id t8mr4676622ljh.284.1611744213762;
 Wed, 27 Jan 2021 02:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20210125085909.4600-1-mgorman@techsingularity.net> <20210125085909.4600-5-mgorman@techsingularity.net>
In-Reply-To: <20210125085909.4600-5-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 27 Jan 2021 11:43:22 +0100
Message-ID: <CAKfTPtBhq25D8iZ67n+kkf9Mdyf+OradvVC5pG0MeZEMKZmU2g@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: Merge select_idle_core/cpu()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 09:59, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Both select_idle_core() and select_idle_cpu() do a loop over the same
> cpumask. Observe that by clearing the already visited CPUs, we can
> fold the iteration and iterate a core at a time.
>
> All we need to do is remember any non-idle CPU we encountered while
> scanning for an idle core. This way we'll only iterate every CPU once.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 101 ++++++++++++++++++++++++++------------------
>  1 file changed, 61 insertions(+), 40 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fe587350ea14..52a650aa2108 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6006,6 +6006,14 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>         return new_cpu;
>  }
>
> +static inline int __select_idle_cpu(int cpu)
> +{
> +       if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> +               return cpu;
> +
> +       return -1;
> +}
> +
>  #ifdef CONFIG_SCHED_SMT
>  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>  EXPORT_SYMBOL_GPL(sched_smt_present);
> @@ -6064,48 +6072,51 @@ void __update_idle_core(struct rq *rq)
>   * there are no idle cores left in the system; tracked through
>   * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
>   */
> -static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
> +static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
>  {
> -       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> -       int core, cpu;
> +       bool idle = true;
> +       int cpu;
>
>         if (!static_branch_likely(&sched_smt_present))
> -               return -1;
> -
> -       if (!test_idle_cores(target, false))
> -               return -1;
> -
> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +               return __select_idle_cpu(core);
>
> -       for_each_cpu_wrap(core, cpus, target) {
> -               bool idle = true;
> -
> -               for_each_cpu(cpu, cpu_smt_mask(core)) {
> -                       if (!available_idle_cpu(cpu)) {
> -                               idle = false;
> -                               break;
> +       for_each_cpu(cpu, cpu_smt_mask(core)) {
> +               if (!available_idle_cpu(cpu)) {
> +                       idle = false;
> +                       if (*idle_cpu == -1) {
> +                               if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +                                       *idle_cpu = cpu;
> +                                       break;
> +                               }
> +                               continue;
>                         }
> +                       break;
>                 }
> -
> -               if (idle)
> -                       return core;
> -
> -               cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> +               if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
> +                       *idle_cpu = cpu;
>         }
>
> -       /*
> -        * Failed to find an idle core; stop looking for one.
> -        */
> -       set_idle_cores(target, 0);
> +       if (idle)
> +               return core;
>
> +       cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
>         return -1;
>  }
>
>  #else /* CONFIG_SCHED_SMT */
>
> -static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
> +static inline void set_idle_cores(int cpu, int val)
>  {
> -       return -1;
> +}
> +
> +static inline bool test_idle_cores(int cpu, bool def)
> +{
> +       return def;
> +}
> +
> +static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
> +{
> +       return __select_idle_cpu(core);
>  }
>
>  #endif /* CONFIG_SCHED_SMT */
> @@ -6118,10 +6129,11 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +       int i, cpu, idle_cpu = -1, nr = INT_MAX;
> +       bool smt = test_idle_cores(target, false);
> +       int this = smp_processor_id();
>         struct sched_domain *this_sd;
>         u64 time;
> -       int this = smp_processor_id();
> -       int cpu, nr = INT_MAX;
>
>         this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>         if (!this_sd)
> @@ -6129,7 +6141,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
> -       if (sched_feat(SIS_PROP)) {
> +       if (sched_feat(SIS_PROP) && !smt) {
>                 u64 avg_cost, avg_idle, span_avg;
>
>                 /*
> @@ -6149,18 +6161,31 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>         }
>
>         for_each_cpu_wrap(cpu, cpus, target) {
> -               if (!--nr)
> -                       return -1;
> -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> -                       break;
> +               if (smt) {
> +                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +                       if ((unsigned int)i < nr_cpumask_bits)
> +                               return i;
> +
> +               } else {
> +                       if (!--nr)
> +                               return -1;
> +                       i = __select_idle_cpu(cpu);

you should use idle_cpu directly instead of this intermediate i variable

+                       idle_cpu = __select_idle_cpu(cpu);
+                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
+                               break;

Apart ths small comment above, the patch looks good to me and I
haven't any performance regression anymore


> +                       if ((unsigned int)i < nr_cpumask_bits) {
> +                               idle_cpu = i;
> +                               break;
> +                       }
> +               }
>         }
>
> -       if (sched_feat(SIS_PROP)) {
> +       if (smt)
> +               set_idle_cores(this, false);
> +
> +       if (sched_feat(SIS_PROP) && !smt) {
>                 time = cpu_clock(this) - time;
>                 update_avg(&this_sd->avg_scan_cost, time);
>         }
>
> -       return cpu;
> +       return idle_cpu;
>  }
>
>  /*
> @@ -6289,10 +6314,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>         if (!sd)
>                 return target;
>
> -       i = select_idle_core(p, sd, target);
> -       if ((unsigned)i < nr_cpumask_bits)
> -               return i;
> -
>         i = select_idle_cpu(p, sd, target);
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
> --
> 2.26.2
>
