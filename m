Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16AD38D622
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 16:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhEVOMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 10:12:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230301AbhEVOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 10:12:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14ME3cYf020279;
        Sat, 22 May 2021 10:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=/cd0vYur7YF/hIbikgoKa+n1VnR6lXM7s/4B7wwvqng=;
 b=iX2wzZQAeRZraoOQ4ldcEvp/sQyybMynDV+9sy5KxAGZ+hc+VflKfoP58TvxCF6v7tuW
 9SJDsZrEdjT/ajoM1NWFqUwRBOKJSd6jwBCogaVf3pu5kgHIbyhnsNagOM2axfCfsToN
 QcJ873fV/iU9pYg+Qlb2KjsVeL8ejV6g4kM5/NofFphHOWtOrSddBl9e1CuPXfvgZLbH
 Oj9Rf0U6GD4c2nZAJ52YtHVBISHfdT8vnSYj5RRuNq9mn+QPIyBb5qPCV38Uwm4T9fFF
 7dbs5JwZStMPKx9BOlEYjaIr8jD53qyA+KI3qS9Bd9MyjX7amWK5uLfDiyxeHXtrekDH Gg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38q2npgqqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 May 2021 10:10:53 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14ME3WnX031713;
        Sat, 22 May 2021 14:10:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 38psk884r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 May 2021 14:10:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14MEAmC441681178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 May 2021 14:10:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB626AE051;
        Sat, 22 May 2021 14:10:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C739AE045;
        Sat, 22 May 2021 14:10:46 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Sat, 22 May 2021 14:10:46 +0000 (GMT)
Date:   Sat, 22 May 2021 19:40:45 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH v3 2/8] sched/fair: Maintain the identity of idle-core
Message-ID: <20210522141045.GJ2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
 <20210513074027.543926-3-srikar@linux.vnet.ibm.com>
 <CAKfTPtCHb=tjZT60s_Gyp-mfO-rS57XUfn2hXEftJgtMBubA-g@mail.gmail.com>
 <20210521133109.GI2633526@linux.vnet.ibm.com>
 <CAKfTPtCwn1Rr5aeM5HjVeehvWBhXdFBEJm7Tar7kde43C9GKrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKfTPtCwn1Rr5aeM5HjVeehvWBhXdFBEJm7Tar7kde43C9GKrg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _Bjs1mCRKktYV6OwoKXkiJn_fs4LTcIx
X-Proofpoint-GUID: _Bjs1mCRKktYV6OwoKXkiJn_fs4LTcIx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-22_06:2021-05-20,2021-05-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105220101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [2021-05-22 14:42:00]:

> On Fri, 21 May 2021 at 15:31, Srikar Dronamraju
> <srikar@linux.vnet.ibm.com> wrote:
> >
> > * Vincent Guittot <vincent.guittot@linaro.org> [2021-05-21 14:36:15]:
> >
> > > On Thu, 13 May 2021 at 09:40, Srikar Dronamraju
> > > <srikar@linux.vnet.ibm.com> wrote:
> > > >
> > > > Scheduler maintains a per LLC info which tells if there is any idle core
> > > > in that LLC. However this information doesn't provide which core is idle.
> > > >
> > > > So when iterating for idle-cores, if select_idle_core() finds an
> > > > idle-core, then it doesn't try to reset this information.
> > > >
> > > > So if there was only one idle core in the LLC and select_idle_core()
> > > > selected the idle-core, the LLC will maintain that it still has a
> > > > idle-core.
> > > >
> > > > On the converse, if a task is pinned, and has a restricted
> > > > cpus_allowed_list and LLC has multiple idle-cores, but select_idle_core
> > > > cannot find a idle-core, LLC will no more maintain that it has an
> > > > idle-core.
> > > >
> > > > As a first step to solve this problem, LLC will maintain the identity of
> > > > the idle core instead of just the information that LLC has an idle core
> > > >
> > > > Along with maintaining, this change will solve both the problems listed
> > > > above. However there are other problems that exist with the current
> > > > infrastructure and those will continue to exist with this change and
> > > > would be handled in subsequent patches.
> > > >
> > > > Cc: LKML <linux-kernel@vger.kernel.org>
> > > > Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> > > > Cc: Parth Shah <parth@linux.ibm.com>
> > > > Cc: Ingo Molnar <mingo@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > > Cc: Mel Gorman <mgorman@techsingularity.net>
> > > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > > > Cc: Rik van Riel <riel@surriel.com>
> > > > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > > > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > > > ---
> > > > Changelog v2->v3:
> > > >  -  Rebase to tip/sched/core
> > > >                 (Valentin)
> > > >
> > > >  include/linux/sched/topology.h |  2 +-
> > > >  kernel/sched/fair.c            | 52 ++++++++++++++++++----------------
> > > >  kernel/sched/sched.h           |  3 ++
> > > >  kernel/sched/topology.c        |  7 +++++
> > > >  4 files changed, 39 insertions(+), 25 deletions(-)
> > > >
> > > > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > > > index 8f0f778b7c91..285165a35f21 100644
> > > > --- a/include/linux/sched/topology.h
> > > > +++ b/include/linux/sched/topology.h
> > > > @@ -73,7 +73,7 @@ struct sched_group;
> > > >  struct sched_domain_shared {
> > > >         atomic_t        ref;
> > > >         atomic_t        nr_busy_cpus;
> > > > -       int             has_idle_cores;
> > > > +       int             idle_core;
> > > >  };
> > > >
> > > >  struct sched_domain {
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 7920f2a4d257..c42b2b3cd08f 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -1578,11 +1578,11 @@ numa_type numa_classify(unsigned int imbalance_pct,
> > > >
> > > >  #ifdef CONFIG_SCHED_SMT
> > > >  /* Forward declarations of select_idle_sibling helpers */
> > > > -static inline bool test_idle_cores(int cpu, bool def);
> > > > +static inline int get_idle_core(int cpu, int def);
> > > >  static inline int numa_idle_core(int idle_core, int cpu)
> > > >  {
> > > >         if (!static_branch_likely(&sched_smt_present) ||
> > > > -           idle_core >= 0 || !test_idle_cores(cpu, false))
> > > > +           idle_core >= 0 || get_idle_core(cpu, -1) < 0)
> > > >                 return idle_core;
> > > >
> > > >         /*
> > > > @@ -6039,29 +6039,31 @@ static inline int __select_idle_cpu(int cpu)
> > > >  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
> > > >  EXPORT_SYMBOL_GPL(sched_smt_present);
> > > >
> > > > -static inline void set_idle_cores(int cpu, int val)
> > > > +static inline void set_idle_core(int cpu, int val)
> > > >  {
> > > >         struct sched_domain_shared *sds;
> > > >
> > > >         sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > > >         if (sds)
> > > > -               WRITE_ONCE(sds->has_idle_cores, val);
> > > > +               WRITE_ONCE(sds->idle_core, val);
> > > >  }
> > > >
> > > > -static inline bool test_idle_cores(int cpu, bool def)
> > > > +static inline int get_idle_core(int cpu, int def)
> > > >  {
> > > >         struct sched_domain_shared *sds;
> > > >
> > > > -       sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > > > -       if (sds)
> > > > -               return READ_ONCE(sds->has_idle_cores);
> > > > +       if (static_branch_likely(&sched_smt_present)) {
> > >
> > > Would be good to explain why it is needed to add back the statis branch
> > >
> >
> > Agree, this is not needed. will fix in the next version.
> > Thanks for pointing out.
> >
> > > > +               sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > > > +               if (sds)
> > > > +                       return READ_ONCE(sds->idle_core);
> > > > +       }
> > > >
> > > >         return def;
> > > >  }
> > > >
> > > >  /*
> > > >   * Scans the local SMT mask to see if the entire core is idle, and records this
> > > > - * information in sd_llc_shared->has_idle_cores.
> > > > + * information in sd_llc_shared->idle_core.
> > > >   *
> > > >   * Since SMT siblings share all cache levels, inspecting this limited remote
> > > >   * state should be fairly cheap.
> > > > @@ -6072,7 +6074,7 @@ void __update_idle_core(struct rq *rq)
> > > >         int cpu;
> > > >
> > > >         rcu_read_lock();
> > > > -       if (test_idle_cores(core, true))
> > > > +       if (get_idle_core(core, 0) >= 0)
> > > >                 goto unlock;
> > > >
> > > >         for_each_cpu(cpu, cpu_smt_mask(core)) {
> > > > @@ -6083,7 +6085,7 @@ void __update_idle_core(struct rq *rq)
> > > >                         goto unlock;
> > > >         }
> > > >
> > > > -       set_idle_cores(core, 1);
> > > > +       set_idle_core(core, per_cpu(smt_id, core));
> > > >  unlock:
> > > >         rcu_read_unlock();
> > > >  }
> > > > @@ -6091,7 +6093,7 @@ void __update_idle_core(struct rq *rq)
> > > >  /*
> > > >   * Scan the entire LLC domain for idle cores; this dynamically switches off if
> > > >   * there are no idle cores left in the system; tracked through
> > > > - * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
> > > > + * sd_llc->shared->idle_core and enabled through update_idle_core() above.
> > > >   */
> > > >  static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
> > > >  {
> > > > @@ -6144,11 +6146,11 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
> > > >
> > > >  #else /* CONFIG_SCHED_SMT */
> > > >
> > > > -static inline void set_idle_cores(int cpu, int val)
> > > > +static inline void set_idle_core(int cpu, int val)
> > > >  {
> > > >  }
> > > >
> > > > -static inline bool test_idle_cores(int cpu, bool def)
> > > > +static inline bool get_idle_core(int cpu, int def)
> > > >  {
> > > >         return def;
> > > >  }
> > > > @@ -6170,10 +6172,11 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
> > > >   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> > > >   * average idle time for this rq (as found in rq->avg_idle).
> > > >   */
> > > > -static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
> > > > +static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int idle_core, int target)
> > > >  {
> > > >         struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> > > >         int i, cpu, idle_cpu = -1, nr = INT_MAX;
> > > > +       bool has_idle_core = (idle_core != -1);
> > > >         int this = smp_processor_id();
> > > >         struct sched_domain *this_sd;
> > > >         u64 time;
> > > > @@ -6206,8 +6209,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > > >         for_each_cpu_wrap(cpu, cpus, target) {
> > > >                 if (has_idle_core) {
> > > >                         i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > > > -                       if ((unsigned int)i < nr_cpumask_bits)
> > > > +                       if ((unsigned int)i < nr_cpumask_bits) {
> > > > +#ifdef CONFIG_SCHED_SMT
> > > > +                               if ((per_cpu(smt_id, i)) == idle_core)
> > > > +                                       set_idle_core(i, -1);
> > > > +#endif
> > >
> > > CPUA-core0 enters idle
> > > All other CPUs of core0 are already idle
> > > set idle_core = core0
> > > CPUB-core1 enters idle
> > > All other CPUs of core1 are already idle so core1 becomes idle
> > >
> > > A task wakes up and select_idle_core returns CPUA-core0
> > > then idle_core=-1
> > >
> > > At next wake up, we skip select_idlecore whereas core1 is idle
> > >
> > > Do I miss something ?
> > >
> >
> > You are right, but this is similar to what we do currently do too. Even
> > without this patch, we got ahead an unconditionally (We dont even have an
> > option to see if the selected CPU was from an idle-core.) set the idle-core
> > to -1. (Please see the hunk I removed below)
> 
> The current race window is limited between select_idle_core() not
> finding an idle core and the call of set_idle_cores(this, false);
> later in end select_idle_cpu().
> 

However lets say there was only one idle-core, and select_idle_core() finds
this idle-core, it just doesn't reset has-idle-core. So on the next wakeup,
we end up iterating through the whole LLC to find if we have an idle-core.

Also even if there were more than one idle-core in LLC and the task had a
limited cpu_allowed_list, and hence had to skip the idle-core, then we still
go ahead and reset the idle-core.

> In your proposal, the race is not limited in time anymore. As soon as
> the 1st core being idle and setting idle_core is then selected by
> select_idle_core, then idle_core is broken
> 

Yes, but with the next patch, as soon as a CPU within this LLC goes to idle,
it will search and set the right idle-core.

> >
> > I try to improve upon this in the next iteration. But that again we are
> > seeing some higher utilization probably with that change.
> >
> > I plan to move to a cpumask based approach in v4.
> > By which we dont have to search for setting an idle-core but we still know
> > if any idle-cores are around. However that will have the extra penalty of
> > atomic operations that you commented to in one of my patches.
> >
> > But if you have other ideas, I would be willing to try out.
> >
> > >
> > >
> > > >                                 return i;
> > > > +                       }
> > > >
> > > >                 } else {
> > > >                         if (!--nr)
> > > > @@ -6218,9 +6226,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> > > >                 }
> > > >         }
> > > >
> > > > -       if (has_idle_core)
> > > > -               set_idle_cores(this, false);
> > > > -
> >
> > I was referring to this hunk.
> >
> > > >         if (sched_feat(SIS_PROP) && !has_idle_core) {
> > > >                 time = cpu_clock(this) - time;
> > > >                 update_avg(&this_sd->avg_scan_cost, time);
> > > > @@ -6276,10 +6281,9 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
> > > >   */
> > > >  static int select_idle_sibling(struct task_struct *p, int prev, int target)
> > > >  {
> > > > -       bool has_idle_core = false;
> > > > +       int i, recent_used_cpu, idle_core = -1;
> > > >         struct sched_domain *sd;
> > > >         unsigned long task_util;
> > > > -       int i, recent_used_cpu;
> > > >
> > > >         /*
> > > >          * On asymmetric system, update task utilization because we will check
> > > > @@ -6357,16 +6361,16 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> > > >                 return target;
> > > >
> > > >         if (sched_smt_active()) {
> > > > -               has_idle_core = test_idle_cores(target, false);
> > > > +               idle_core = get_idle_core(target, -1);
> > > >
> > > > -               if (!has_idle_core && cpus_share_cache(prev, target)) {
> > > > +               if (idle_core < 0 && cpus_share_cache(prev, target)) {
> > > >                         i = select_idle_smt(p, sd, prev);
> > > >                         if ((unsigned int)i < nr_cpumask_bits)
> > > >                                 return i;
> > > >                 }
> > > >         }
> > > >
> > > > -       i = select_idle_cpu(p, sd, has_idle_core, target);
> > > > +       i = select_idle_cpu(p, sd, idle_core, target);
> > > >         if ((unsigned)i < nr_cpumask_bits)
> > > >                 return i;
> > > >
> > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > index a189bec13729..22fbb50b036e 100644
> > > > --- a/kernel/sched/sched.h
> > > > +++ b/kernel/sched/sched.h
> > > > @@ -1491,6 +1491,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
> > > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> > > >  DECLARE_PER_CPU(int, sd_llc_size);
> > > >  DECLARE_PER_CPU(int, sd_llc_id);
> > > > +#ifdef CONFIG_SCHED_SMT
> > > > +DECLARE_PER_CPU(int, smt_id);
> > > > +#endif
> > > >  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> > > >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > > index 55a0a243e871..232fb261dfc2 100644
> > > > --- a/kernel/sched/topology.c
> > > > +++ b/kernel/sched/topology.c
> > > > @@ -644,6 +644,9 @@ static void destroy_sched_domains(struct sched_domain *sd)
> > > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> > > >  DEFINE_PER_CPU(int, sd_llc_size);
> > > >  DEFINE_PER_CPU(int, sd_llc_id);
> > > > +#ifdef CONFIG_SCHED_SMT
> > > > +DEFINE_PER_CPU(int, smt_id);
> > > > +#endif
> > > >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> > > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> > > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > > > @@ -667,6 +670,9 @@ static void update_top_cache_domain(int cpu)
> > > >         rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
> > > >         per_cpu(sd_llc_size, cpu) = size;
> > > >         per_cpu(sd_llc_id, cpu) = id;
> > > > +#ifdef CONFIG_SCHED_SMT
> > > > +       per_cpu(smt_id, cpu) = cpumask_first(cpu_smt_mask(cpu));
> > > > +#endif
> > > >         rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> > > >
> > > >         sd = lowest_flag_domain(cpu, SD_NUMA);
> > > > @@ -1497,6 +1503,7 @@ sd_init(struct sched_domain_topology_level *tl,
> > > >                 sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
> > > >                 atomic_inc(&sd->shared->ref);
> > > >                 atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> > > > +               sd->shared->idle_core = -1;
> > > >         }
> > > >
> > > >         sd->private = sdd;
> > > > --
> > > > 2.18.2
> > > >
> >
> > --
> > Thanks and Regards
> > Srikar Dronamraju

-- 
Thanks and Regards
Srikar Dronamraju
