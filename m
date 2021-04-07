Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBA735698A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbhDGKZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351052AbhDGKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:25:00 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A00C0613D7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 03:24:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id v140so9859350lfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 03:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNciv7jHUpy2zkVg/tTPcs3T/rdE2i4ke8yZXyNsY6k=;
        b=GdtU8sJcG7nn7gpiy3SHoknwbtp0/tySY6qK8EK88EkBAKRzCZuUtFvbSsm55K/9Oi
         XEXJQ43xcLF2yyBVojQObTCF6B2Ys2oQeqdd5OpHQSkIg6MpeTBF+rxarIJnu+/ss1cQ
         2CGeA4xjYDc9ReYz57PeilpE5EM0qo+fPeeradvXUTAU2h+BBWAt9N0ZEEuENPf+G7i+
         NsMh45qgPdHAV+URN91suJUPciCis8g1/wBtot2ZYlRlrA8lBA60nC/AV5FqbmSqks7/
         2Ikskmymy+BFwuVc2TNH5f9zCkPO/uQRECQUJAM2fRA0o9EOATu9ZwJZ60P9tjkwm8/P
         Zaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNciv7jHUpy2zkVg/tTPcs3T/rdE2i4ke8yZXyNsY6k=;
        b=LkeEWLBFQGIOq9fifmxKlMhjeGtbK1Nw5Ge7Q/j2uEW1n+SGGZP78jzSQUnF6XKupq
         wyuItGLGzDjtqxuh8mpWp4exeHvFw2LHcnv/ZTWEu4T0oN6a4J/6vvDoPxzHo2y6QCYq
         VUzyQQyyb+0gEeHYBR9Jtj20ijbAvVu1yMySCI+CvE8zze/46xwAzuNj/ApjePg7Bhrv
         k28aoAJJwZxuy5iAtRZsEkR9Bn8Ow2PdWzdUncRidCjPyb9JaDyMym2DfHNNWm91Lioj
         c59Tg5PMFVmjigT2ZjRBeVoJvRhq9dtAhqwI2J9SLfoQHn+W6TGna+LkhRV8MhlLXZ7V
         kNgQ==
X-Gm-Message-State: AOAM533n5Y9howkmiBG+mfH5YhbYUyROQngFx484OPt5ZgvppbFp3sxg
        TZ1BDsVfMSev0we+CCedb/DhqyJnEDDrHajStvj7ig==
X-Google-Smtp-Source: ABdhPJyTtwf7W2hyTtpTrSbdAe7NWJGtPgyEl7nqWYeBTsduFMXieKKaboaWlgkjAYEoStYASlIIzmZHptDNUbRwCAs=
X-Received: by 2002:a19:f812:: with SMTP id a18mr2024964lff.254.1617791088876;
 Wed, 07 Apr 2021 03:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210321150358.71ef52b1@imladris.surriel.com> <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com> <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
 <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net> <20210407094217.GA2926@vingu-book>
 <YG2BXRm60IhpumD8@hirez.programming.kicks-ass.net> <YG2HPUfrb0YyB1SG@hirez.programming.kicks-ass.net>
In-Reply-To: <YG2HPUfrb0YyB1SG@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Apr 2021 12:24:35 +0200
Message-ID: <CAKfTPtA+cMS3dj3FcwiV_TzeLGx8tTX47tafnDKAWtnu9pwkWQ@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but differently
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 at 12:19, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 07, 2021 at 11:54:37AM +0200, Peter Zijlstra wrote:
>
> > Let me have another poke at it.
>
> Pretty much what you did, except I also did s/smt/has_idle_core/ and
> fixed that @sd thing.
>
> Like so then?

Yes. Looks good to me

>
> ---
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6038,11 +6038,9 @@ static inline bool test_idle_cores(int c
>  {
>         struct sched_domain_shared *sds;
>
> -       if (static_branch_likely(&sched_smt_present)) {
> -               sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> -               if (sds)
> -                       return READ_ONCE(sds->has_idle_cores);
> -       }
> +       sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +       if (sds)
> +               return READ_ONCE(sds->has_idle_cores);
>
>         return def;
>  }
> @@ -6112,6 +6110,24 @@ static int select_idle_core(struct task_
>         return -1;
>  }
>
> +/*
> + * Scan the local SMT mask for idle CPUs.
> + */
> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +       int cpu;
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
> @@ -6128,6 +6144,11 @@ static inline int select_idle_core(struc
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
> @@ -6135,11 +6156,10 @@ static inline int select_idle_core(struc
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>   * average idle time for this rq (as found in rq->avg_idle).
>   */
> -static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
> +static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
>  {
>         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>         int i, cpu, idle_cpu = -1, nr = INT_MAX;
> -       bool smt = test_idle_cores(target, false);
>         int this = smp_processor_id();
>         struct sched_domain *this_sd;
>         u64 time;
> @@ -6150,7 +6170,7 @@ static int select_idle_cpu(struct task_s
>
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
> -       if (sched_feat(SIS_PROP) && !smt) {
> +       if (sched_feat(SIS_PROP) && !has_idle_core) {
>                 u64 avg_cost, avg_idle, span_avg;
>
>                 /*
> @@ -6170,7 +6190,7 @@ static int select_idle_cpu(struct task_s
>         }
>
>         for_each_cpu_wrap(cpu, cpus, target) {
> -               if (smt) {
> +               if (has_idle_core) {
>                         i = select_idle_core(p, cpu, cpus, &idle_cpu);
>                         if ((unsigned int)i < nr_cpumask_bits)
>                                 return i;
> @@ -6184,10 +6204,10 @@ static int select_idle_cpu(struct task_s
>                 }
>         }
>
> -       if (smt)
> +       if (has_idle_core)
>                 set_idle_cores(this, false);
>
> -       if (sched_feat(SIS_PROP) && !smt) {
> +       if (sched_feat(SIS_PROP) && !has_idle_core) {
>                 time = cpu_clock(this) - time;
>                 update_avg(&this_sd->avg_scan_cost, time);
>         }
> @@ -6242,6 +6262,7 @@ static inline bool asym_fits_capacity(in
>   */
>  static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  {
> +       bool has_idle_core = false;
>         struct sched_domain *sd;
>         unsigned long task_util;
>         int i, recent_used_cpu;
> @@ -6321,7 +6342,17 @@ static int select_idle_sibling(struct ta
>         if (!sd)
>                 return target;
>
> -       i = select_idle_cpu(p, sd, target);
> +       if (static_branch_likely(&sched_smt_present)) {
> +               has_idle_core = test_idle_cores(target, false);
> +
> +               if (!has_idle_core && cpus_share_cache(prev, target)) {
> +                       i = select_idle_smt(p, sd, prev);
> +                       if ((unsigned int)i < nr_cpumask_bits)
> +                               return i;
> +               }
> +       }
> +
> +       i = select_idle_cpu(p, sd, has_idle_core, target);
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
