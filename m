Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4CD38D5DB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 14:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhEVMnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 08:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhEVMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 08:43:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0631C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 05:42:12 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z13so33681151lft.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5oBTaw2GvaH4lprog1LqHhwsQe3m52KatRJeBrDmBc=;
        b=B0OvOAxVSABeb6Saw9nDIepoTSW9FOCL3WjbHi0KrSZJQua3nBXWE+ZqsXJdNmY5WF
         ZaKDw8DcsVCpdGqGNlR24hWwfvV2rPJum0Cf18IOOmrR98EspGU4MX68yYtySN53iFl1
         n3PI7nnIfXQSy0pniEMJp2DbQPfpzDMFPQ/0KWbhlEmIw+k47mIwRXjFw8OeotwfhuOq
         q1KGiL2BZjqO53X7yBkLC3iTRbinN1CtCAS6z9D1uZ4PMc1k4CLIk30SNRvWaN1o2OBe
         leM0DIJi54i7yK269jJ9MwP4yMuAO1xeKDjy0+C4cfdHem90gOZh6BbgZV2aXf8ATA3n
         Th4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5oBTaw2GvaH4lprog1LqHhwsQe3m52KatRJeBrDmBc=;
        b=QU5fT/YBCfKrUxH1Je+kXvlo8QugmdMUgpRFBPASW1VnCExnI0bP6Mjbc3PD3Mi0On
         rohNU8f0rVSljuwN4+tmbY7xt7kZhKcUgYCt3D50Qyy3Ev6DzcmXTlVdGcYPSdX9bKx/
         mu2PLbT2IviH9ON4Hny8gZ9eDyJgUjuduEPNbGvuCHVF5e5a0MK6gtaRYAFHmLiCgbgh
         dafEfkL18WeHXN3BzlRucXr8417t6gnVKthqt7Iixf9w+6X8FrvcPO09SLZ9cmVb2CMs
         pRfAho4mZoC4vgTBvUpzRErnwKJihOlLwBewN0hMtCKmSqhISwmJFhBIxrjC9t+NJ4vx
         YGcw==
X-Gm-Message-State: AOAM5315aimNewRl60oUnTKETga+MhQeG9xFhes3T4PKmpG24XPCMKkU
        gR7NK5LewQ8GMs+63rY8o7Oc5FobNMJfEcWtzB2CoA==
X-Google-Smtp-Source: ABdhPJzofFxMD4zQCabjQtI4q3NUfhn4QebWicEZ6UzUloALDmV9LrgrskdLTzEpOYRbjrbdCt8QOGbOlhuUpnoF6mg=
X-Received: by 2002:a05:6512:234d:: with SMTP id p13mr5331126lfu.470.1621687331168;
 Sat, 22 May 2021 05:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
 <20210513074027.543926-3-srikar@linux.vnet.ibm.com> <CAKfTPtCHb=tjZT60s_Gyp-mfO-rS57XUfn2hXEftJgtMBubA-g@mail.gmail.com>
 <20210521133109.GI2633526@linux.vnet.ibm.com>
In-Reply-To: <20210521133109.GI2633526@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sat, 22 May 2021 14:42:00 +0200
Message-ID: <CAKfTPtCwn1Rr5aeM5HjVeehvWBhXdFBEJm7Tar7kde43C9GKrg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] sched/fair: Maintain the identity of idle-core
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 at 15:31, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [2021-05-21 14:36:15]:
>
> > On Thu, 13 May 2021 at 09:40, Srikar Dronamraju
> > <srikar@linux.vnet.ibm.com> wrote:
> > >
> > > Scheduler maintains a per LLC info which tells if there is any idle core
> > > in that LLC. However this information doesn't provide which core is idle.
> > >
> > > So when iterating for idle-cores, if select_idle_core() finds an
> > > idle-core, then it doesn't try to reset this information.
> > >
> > > So if there was only one idle core in the LLC and select_idle_core()
> > > selected the idle-core, the LLC will maintain that it still has a
> > > idle-core.
> > >
> > > On the converse, if a task is pinned, and has a restricted
> > > cpus_allowed_list and LLC has multiple idle-cores, but select_idle_core
> > > cannot find a idle-core, LLC will no more maintain that it has an
> > > idle-core.
> > >
> > > As a first step to solve this problem, LLC will maintain the identity of
> > > the idle core instead of just the information that LLC has an idle core
> > >
> > > Along with maintaining, this change will solve both the problems listed
> > > above. However there are other problems that exist with the current
> > > infrastructure and those will continue to exist with this change and
> > > would be handled in subsequent patches.
> > >
> > > Cc: LKML <linux-kernel@vger.kernel.org>
> > > Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> > > Cc: Parth Shah <parth@linux.ibm.com>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > Cc: Mel Gorman <mgorman@techsingularity.net>
> > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > > Cc: Rik van Riel <riel@surriel.com>
> > > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > > ---
> > > Changelog v2->v3:
> > >  -  Rebase to tip/sched/core
> > >                 (Valentin)
> > >
> > >  include/linux/sched/topology.h |  2 +-
> > >  kernel/sched/fair.c            | 52 ++++++++++++++++++----------------
> > >  kernel/sched/sched.h           |  3 ++
> > >  kernel/sched/topology.c        |  7 +++++
> > >  4 files changed, 39 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > > index 8f0f778b7c91..285165a35f21 100644
> > > --- a/include/linux/sched/topology.h
> > > +++ b/include/linux/sched/topology.h
> > > @@ -73,7 +73,7 @@ struct sched_group;
> > >  struct sched_domain_shared {
> > >         atomic_t        ref;
> > >         atomic_t        nr_busy_cpus;
> > > -       int             has_idle_cores;
> > > +       int             idle_core;
> > >  };
> > >
> > >  struct sched_domain {
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 7920f2a4d257..c42b2b3cd08f 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -1578,11 +1578,11 @@ numa_type numa_classify(unsigned int imbalance_pct,
> > >
> > >  #ifdef CONFIG_SCHED_SMT
> > >  /* Forward declarations of select_idle_sibling helpers */
> > > -static inline bool test_idle_cores(int cpu, bool def);
> > > +static inline int get_idle_core(int cpu, int def);
> > >  static inline int numa_idle_core(int idle_core, int cpu)
> > >  {
> > >         if (!static_branch_likely(&sched_smt_present) ||
> > > -           idle_core >= 0 || !test_idle_cores(cpu, false))
> > > +           idle_core >= 0 || get_idle_core(cpu, -1) < 0)
> > >                 return idle_core;
> > >
> > >         /*
> > > @@ -6039,29 +6039,31 @@ static inline int __select_idle_cpu(int cpu)
> > >  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
> > >  EXPORT_SYMBOL_GPL(sched_smt_present);
> > >
> > > -static inline void set_idle_cores(int cpu, int val)
> > > +static inline void set_idle_core(int cpu, int val)
> > >  {
> > >         struct sched_domain_shared *sds;
> > >
> > >         sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > >         if (sds)
> > > -               WRITE_ONCE(sds->has_idle_cores, val);
> > > +               WRITE_ONCE(sds->idle_core, val);
> > >  }
> > >
> > > -static inline bool test_idle_cores(int cpu, bool def)
> > > +static inline int get_idle_core(int cpu, int def)
> > >  {
> > >         struct sched_domain_shared *sds;
> > >
> > > -       sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > > -       if (sds)
> > > -               return READ_ONCE(sds->has_idle_cores);
> > > +       if (static_branch_likely(&sched_smt_present)) {
> >
> > Would be good to explain why it is needed to add back the statis branch
> >
>
> Agree, this is not needed. will fix in the next version.
> Thanks for pointing out.
>
> > > +               sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > > +               if (sds)
> > > +                       return READ_ONCE(sds->idle_core);
> > > +       }
> > >
> > >         return def;
> > >  }
> > >
> > >  /*
> > >   * Scans the local SMT mask to see if the entire core is idle, and records this
> > > - * information in sd_llc_shared->has_idle_cores.
> > > + * information in sd_llc_shared->idle_core.
> > >   *
> > >   * Since SMT siblings share all cache levels, inspecting this limited remote
> > >   * state should be fairly cheap.
> > > @@ -6072,7 +6074,7 @@ void __update_idle_core(struct rq *rq)
> > >         int cpu;
> > >
> > >         rcu_read_lock();
> > > -       if (test_idle_cores(core, true))
> > > +       if (get_idle_core(core, 0) >= 0)
> > >                 goto unlock;
> > >
> > >         for_each_cpu(cpu, cpu_smt_mask(core)) {
> > > @@ -6083,7 +6085,7 @@ void __update_idle_core(struct rq *rq)
> > >                         goto unlock;
> > >         }
> > >
> > > -       set_idle_cores(core, 1);
> > > +       set_idle_core(core, per_cpu(smt_id, core));
> > >  unlock:
> > >         rcu_read_unlock();
> > >  }
> > > @@ -6091,7 +6093,7 @@ void __update_idle_core(struct rq *rq)
> > >  /*
> > >   * Scan the entire LLC domain for idle cores; this dynamically switches off if
> > >   * there are no idle cores left in the system; tracked through
> > > - * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
> > > + * sd_llc->shared->idle_core and enabled through update_idle_core() above.
> > >   */
> > >  static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
> > >  {
> > > @@ -6144,11 +6146,11 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
> > >
> > >  #else /* CONFIG_SCHED_SMT */
> > >
> > > -static inline void set_idle_cores(int cpu, int val)
> > > +static inline void set_idle_core(int cpu, int val)
> > >  {
> > >  }
> > >
> > > -static inline bool test_idle_cores(int cpu, bool def)
> > > +static inline bool get_idle_core(int cpu, int def)
> > >  {
> > >         return def;
> > >  }
> > > @@ -6170,10 +6172,11 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
> > >   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> > >   * average idle time for this rq (as found in rq->avg_idle).
> > >   */
> > > -static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
> > > +static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int idle_core, int target)
> > >  {
> > >         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> > >         int i, cpu, idle_cpu = -1, nr = INT_MAX;
> > > +       bool has_idle_core = (idle_core != -1);
> > >         int this = smp_processor_id();
> > >         struct sched_domain *this_sd;
> > >         u64 time;
> > > @@ -6206,8 +6209,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > >         for_each_cpu_wrap(cpu, cpus, target) {
> > >                 if (has_idle_core) {
> > >                         i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > > -                       if ((unsigned int)i < nr_cpumask_bits)
> > > +                       if ((unsigned int)i < nr_cpumask_bits) {
> > > +#ifdef CONFIG_SCHED_SMT
> > > +                               if ((per_cpu(smt_id, i)) == idle_core)
> > > +                                       set_idle_core(i, -1);
> > > +#endif
> >
> > CPUA-core0 enters idle
> > All other CPUs of core0 are already idle
> > set idle_core = core0
> > CPUB-core1 enters idle
> > All other CPUs of core1 are already idle so core1 becomes idle
> >
> > A task wakes up and select_idle_core returns CPUA-core0
> > then idle_core=-1
> >
> > At next wake up, we skip select_idlecore whereas core1 is idle
> >
> > Do I miss something ?
> >
>
> You are right, but this is similar to what we do currently do too. Even
> without this patch, we got ahead an unconditionally (We dont even have an
> option to see if the selected CPU was from an idle-core.) set the idle-core
> to -1. (Please see the hunk I removed below)

The current race window is limited between select_idle_core() not
finding an idle core and the call of set_idle_cores(this, false);
later in end select_idle_cpu().

In your proposal, the race is not limited in time anymore. As soon as
the 1st core being idle and setting idle_core is then selected by
select_idle_core, then idle_core is broken

>
> I try to improve upon this in the next iteration. But that again we are
> seeing some higher utilization probably with that change.
>
> I plan to move to a cpumask based approach in v4.
> By which we dont have to search for setting an idle-core but we still know
> if any idle-cores are around. However that will have the extra penalty of
> atomic operations that you commented to in one of my patches.
>
> But if you have other ideas, I would be willing to try out.
>
> >
> >
> > >                                 return i;
> > > +                       }
> > >
> > >                 } else {
> > >                         if (!--nr)
> > > @@ -6218,9 +6226,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > >                 }
> > >         }
> > >
> > > -       if (has_idle_core)
> > > -               set_idle_cores(this, false);
> > > -
>
> I was referring to this hunk.
>
> > >         if (sched_feat(SIS_PROP) && !has_idle_core) {
> > >                 time = cpu_clock(this) - time;
> > >                 update_avg(&this_sd->avg_scan_cost, time);
> > > @@ -6276,10 +6281,9 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
> > >   */
> > >  static int select_idle_sibling(struct task_struct *p, int prev, int target)
> > >  {
> > > -       bool has_idle_core = false;
> > > +       int i, recent_used_cpu, idle_core = -1;
> > >         struct sched_domain *sd;
> > >         unsigned long task_util;
> > > -       int i, recent_used_cpu;
> > >
> > >         /*
> > >          * On asymmetric system, update task utilization because we will check
> > > @@ -6357,16 +6361,16 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> > >                 return target;
> > >
> > >         if (sched_smt_active()) {
> > > -               has_idle_core = test_idle_cores(target, false);
> > > +               idle_core = get_idle_core(target, -1);
> > >
> > > -               if (!has_idle_core && cpus_share_cache(prev, target)) {
> > > +               if (idle_core < 0 && cpus_share_cache(prev, target)) {
> > >                         i = select_idle_smt(p, sd, prev);
> > >                         if ((unsigned int)i < nr_cpumask_bits)
> > >                                 return i;
> > >                 }
> > >         }
> > >
> > > -       i = select_idle_cpu(p, sd, has_idle_core, target);
> > > +       i = select_idle_cpu(p, sd, idle_core, target);
> > >         if ((unsigned)i < nr_cpumask_bits)
> > >                 return i;
> > >
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index a189bec13729..22fbb50b036e 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -1491,6 +1491,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
> > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> > >  DECLARE_PER_CPU(int, sd_llc_size);
> > >  DECLARE_PER_CPU(int, sd_llc_id);
> > > +#ifdef CONFIG_SCHED_SMT
> > > +DECLARE_PER_CPU(int, smt_id);
> > > +#endif
> > >  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > index 55a0a243e871..232fb261dfc2 100644
> > > --- a/kernel/sched/topology.c
> > > +++ b/kernel/sched/topology.c
> > > @@ -644,6 +644,9 @@ static void destroy_sched_domains(struct sched_domain *sd)
> > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> > >  DEFINE_PER_CPU(int, sd_llc_size);
> > >  DEFINE_PER_CPU(int, sd_llc_id);
> > > +#ifdef CONFIG_SCHED_SMT
> > > +DEFINE_PER_CPU(int, smt_id);
> > > +#endif
> > >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > > @@ -667,6 +670,9 @@ static void update_top_cache_domain(int cpu)
> > >         rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
> > >         per_cpu(sd_llc_size, cpu) = size;
> > >         per_cpu(sd_llc_id, cpu) = id;
> > > +#ifdef CONFIG_SCHED_SMT
> > > +       per_cpu(smt_id, cpu) = cpumask_first(cpu_smt_mask(cpu));
> > > +#endif
> > >         rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> > >
> > >         sd = lowest_flag_domain(cpu, SD_NUMA);
> > > @@ -1497,6 +1503,7 @@ sd_init(struct sched_domain_topology_level *tl,
> > >                 sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
> > >                 atomic_inc(&sd->shared->ref);
> > >                 atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> > > +               sd->shared->idle_core = -1;
> > >         }
> > >
> > >         sd->private = sdd;
> > > --
> > > 2.18.2
> > >
>
> --
> Thanks and Regards
> Srikar Dronamraju
