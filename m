Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33CF38FB73
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhEYHMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbhEYHMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:12:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991F5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:11:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c10so23419582lfm.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5+gUZWwnHZvkh3yxCyefViw1Y/DH1x6AD3SJttv7AQ=;
        b=FL7w5vtFS+a25cSaU48dZDwAenHE6iI438/IeGs1nZhG0Ly0ca95yOTCVzkh9d2fkE
         BlquR7cMSFUc14v/iN6UM7GWEpKfwC2nSrAHCe8afMiBJf25Ill+c3cx7crMpndmgtdB
         M8SDv+OCjYsfmooyXPPKeN2BwmI8DbIJkVOEyoqEaIzYdUpDR2Q7OQjKLf4R1rP0vgFw
         3zv/vo+gCifPvfJwbpgTh1ctttDyaT4Jvb2BtGT1vCMnA1JQGNhdPB7a/aQfI3ZFE6Ge
         gMLXzhhk1OhnlMaxYYFP5EKaH67wzkkexskulHv0LYZLQL2xj6vIIq/pOEkli2/7JQMB
         h9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5+gUZWwnHZvkh3yxCyefViw1Y/DH1x6AD3SJttv7AQ=;
        b=ZmsB2aAx9cEZ+Ts8Dpf10K0XyOPdu4g8Xj27LgGOuW64o3/ssoBA0wmiZIKW4vtXWQ
         9HaTv/dx87iKfNEk2t2vL+Pcgpmbky3b1Mp4Zd1OQ677JBrSnGssiPOtuQLscIBIbDQF
         n1fvr4scvIp90i2oa3Mfry04jmNHsN5dzj/yXzlcJyRDKHhSAWZsGKmrRFMDxLxmKH62
         fzXcsle22i36ydLt97Jjk8A1jSXPo+Cql4nPBpPZmJdWWYTKlKTH1XK0t1tCr5Mx1XNT
         WP8aMwgx/M37Yw0TOQUBObW3Iy8cxzl+6RDIDV8tCr/LJoTCmnHbpp8lxQMWuTJ6m5i1
         233A==
X-Gm-Message-State: AOAM5315IhBXZ6W3pnL10kW5yikz6RUQw1c9f+CmZI8mrvIyMgTKmFGt
        xcwCGeq4qaZ5plxpLV50CU9TXRjB/EMO6rqNomIbMg==
X-Google-Smtp-Source: ABdhPJytHebJHI8wDubEQVpJewrH4wUBo154QWbyay77wd4Mt6+1aCPkUMlPQWyqK2EUBBNe567xABAKiZIBBvBt3X4=
X-Received: by 2002:ac2:59c4:: with SMTP id x4mr14185839lfn.305.1621926677722;
 Tue, 25 May 2021 00:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
 <20210513074027.543926-3-srikar@linux.vnet.ibm.com> <CAKfTPtCHb=tjZT60s_Gyp-mfO-rS57XUfn2hXEftJgtMBubA-g@mail.gmail.com>
 <20210521133109.GI2633526@linux.vnet.ibm.com> <CAKfTPtCwn1Rr5aeM5HjVeehvWBhXdFBEJm7Tar7kde43C9GKrg@mail.gmail.com>
 <20210522141045.GJ2633526@linux.vnet.ibm.com>
In-Reply-To: <20210522141045.GJ2633526@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 25 May 2021 09:11:06 +0200
Message-ID: <CAKfTPtCMGqdSzDx+ioHpFhURAOESxR6SpH1T_GP-fb83xdRUEA@mail.gmail.com>
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

On Sat, 22 May 2021 at 16:11, Srikar Dronamraju
<srikar@linux.vnet.ibm.com> wrote:
>
> * Vincent Guittot <vincent.guittot@linaro.org> [2021-05-22 14:42:00]:
>
> > On Fri, 21 May 2021 at 15:31, Srikar Dronamraju
> > <srikar@linux.vnet.ibm.com> wrote:
> > >
> > > * Vincent Guittot <vincent.guittot@linaro.org> [2021-05-21 14:36:15]:
> > >
> > > > On Thu, 13 May 2021 at 09:40, Srikar Dronamraju
> > > > <srikar@linux.vnet.ibm.com> wrote:

...

> > > > > +#endif
> > > >
> > > > CPUA-core0 enters idle
> > > > All other CPUs of core0 are already idle
> > > > set idle_core = core0
> > > > CPUB-core1 enters idle
> > > > All other CPUs of core1 are already idle so core1 becomes idle
> > > >
> > > > A task wakes up and select_idle_core returns CPUA-core0
> > > > then idle_core=-1
> > > >
> > > > At next wake up, we skip select_idlecore whereas core1 is idle
> > > >
> > > > Do I miss something ?
> > > >
> > >
> > > You are right, but this is similar to what we do currently do too. Even
> > > without this patch, we got ahead an unconditionally (We dont even have an
> > > option to see if the selected CPU was from an idle-core.) set the idle-core
> > > to -1. (Please see the hunk I removed below)
> >
> > The current race window is limited between select_idle_core() not
> > finding an idle core and the call of set_idle_cores(this, false);
> > later in end select_idle_cpu().
> >
>
> However lets say there was only one idle-core, and select_idle_core() finds
> this idle-core, it just doesn't reset has-idle-core. So on the next wakeup,
> we end up iterating through the whole LLC to find if we have an idle-core.

Yes, the current algorithm is clearing the idle core flag only when it
hasn't been able to find one in order to stay cheap in the fast wakeup
path.


>
> Also even if there were more than one idle-core in LLC and the task had a
> limited cpu_allowed_list, and hence had to skip the idle-core, then we still
> go ahead and reset the idle-core.
>
> > In your proposal, the race is not limited in time anymore. As soon as
> > the 1st core being idle and setting idle_core is then selected by
> > select_idle_core, then idle_core is broken
> >
>
> Yes, but with the next patch, as soon as a CPU within this LLC goes to idle,
> it will search and set the right idle-core.
>
> > >
> > > I try to improve upon this in the next iteration. But that again we are
> > > seeing some higher utilization probably with that change.
> > >
> > > I plan to move to a cpumask based approach in v4.
> > > By which we dont have to search for setting an idle-core but we still know
> > > if any idle-cores are around. However that will have the extra penalty of
> > > atomic operations that you commented to in one of my patches.
> > >
> > > But if you have other ideas, I would be willing to try out.
> > >
> > > >
> > > >
> > > > >                                 return i;
> > > > > +                       }
> > > > >
> > > > >                 } else {
> > > > >                         if (!--nr)
> > > > > @@ -6218,9 +6226,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > > > >                 }
> > > > >         }
> > > > >
> > > > > -       if (has_idle_core)
> > > > > -               set_idle_cores(this, false);
> > > > > -
> > >
> > > I was referring to this hunk.
> > >
> > > > >         if (sched_feat(SIS_PROP) && !has_idle_core) {
> > > > >                 time = cpu_clock(this) - time;
> > > > >                 update_avg(&this_sd->avg_scan_cost, time);
> > > > > @@ -6276,10 +6281,9 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
> > > > >   */
> > > > >  static int select_idle_sibling(struct task_struct *p, int prev, int target)
> > > > >  {
> > > > > -       bool has_idle_core = false;
> > > > > +       int i, recent_used_cpu, idle_core = -1;
> > > > >         struct sched_domain *sd;
> > > > >         unsigned long task_util;
> > > > > -       int i, recent_used_cpu;
> > > > >
> > > > >         /*
> > > > >          * On asymmetric system, update task utilization because we will check
> > > > > @@ -6357,16 +6361,16 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> > > > >                 return target;
> > > > >
> > > > >         if (sched_smt_active()) {
> > > > > -               has_idle_core = test_idle_cores(target, false);
> > > > > +               idle_core = get_idle_core(target, -1);
> > > > >
> > > > > -               if (!has_idle_core && cpus_share_cache(prev, target)) {
> > > > > +               if (idle_core < 0 && cpus_share_cache(prev, target)) {
> > > > >                         i = select_idle_smt(p, sd, prev);
> > > > >                         if ((unsigned int)i < nr_cpumask_bits)
> > > > >                                 return i;
> > > > >                 }
> > > > >         }
> > > > >
> > > > > -       i = select_idle_cpu(p, sd, has_idle_core, target);
> > > > > +       i = select_idle_cpu(p, sd, idle_core, target);
> > > > >         if ((unsigned)i < nr_cpumask_bits)
> > > > >                 return i;
> > > > >
> > > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > > index a189bec13729..22fbb50b036e 100644
> > > > > --- a/kernel/sched/sched.h
> > > > > +++ b/kernel/sched/sched.h
> > > > > @@ -1491,6 +1491,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
> > > > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> > > > >  DECLARE_PER_CPU(int, sd_llc_size);
> > > > >  DECLARE_PER_CPU(int, sd_llc_id);
> > > > > +#ifdef CONFIG_SCHED_SMT
> > > > > +DECLARE_PER_CPU(int, smt_id);
> > > > > +#endif
> > > > >  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > > > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> > > > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > > > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > > > index 55a0a243e871..232fb261dfc2 100644
> > > > > --- a/kernel/sched/topology.c
> > > > > +++ b/kernel/sched/topology.c
> > > > > @@ -644,6 +644,9 @@ static void destroy_sched_domains(struct sched_domain *sd)
> > > > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> > > > >  DEFINE_PER_CPU(int, sd_llc_size);
> > > > >  DEFINE_PER_CPU(int, sd_llc_id);
> > > > > +#ifdef CONFIG_SCHED_SMT
> > > > > +DEFINE_PER_CPU(int, smt_id);
> > > > > +#endif
> > > > >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > > > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> > > > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > > > > @@ -667,6 +670,9 @@ static void update_top_cache_domain(int cpu)
> > > > >         rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
> > > > >         per_cpu(sd_llc_size, cpu) = size;
> > > > >         per_cpu(sd_llc_id, cpu) = id;
> > > > > +#ifdef CONFIG_SCHED_SMT
> > > > > +       per_cpu(smt_id, cpu) = cpumask_first(cpu_smt_mask(cpu));
> > > > > +#endif
> > > > >         rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> > > > >
> > > > >         sd = lowest_flag_domain(cpu, SD_NUMA);
> > > > > @@ -1497,6 +1503,7 @@ sd_init(struct sched_domain_topology_level *tl,
> > > > >                 sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
> > > > >                 atomic_inc(&sd->shared->ref);
> > > > >                 atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> > > > > +               sd->shared->idle_core = -1;
> > > > >         }
> > > > >
> > > > >         sd->private = sdd;
> > > > > --
> > > > > 2.18.2
> > > > >
> > >
> > > --
> > > Thanks and Regards
> > > Srikar Dronamraju
>
> --
> Thanks and Regards
> Srikar Dronamraju
