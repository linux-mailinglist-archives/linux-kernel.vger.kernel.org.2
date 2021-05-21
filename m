Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0ED38C7BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhEUNXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:23:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230391AbhEUNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:23:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LDHf7W024847;
        Fri, 21 May 2021 09:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=FFqZPYLLkFICIyMk/i9wtvcpl+htlEmnc20tgBWCi5k=;
 b=WtWyy/s6jP/wuMY2S53uDF8D5+j3gVPcRLvOeTer0HvtGyiaykYLWhqmZoUlTH+WVjAJ
 q/9KGldPTvXP6TFrfwlmMtgYTHW0aGh1zRZEOtD4hscLHYPdrPL+T1gj95BOxLFMeT38
 Le97HUozgz907Hxudkx6Xzw6wnSsNYA5ATUQJrqdiQJid+bCWGdeRj8D5teKHJBOk/v1
 cWuiZDZ1wnUOdt0UPwEAba+U8JtaOe3HJAxDBiHPrs4Mn7XMc3xS21FXVzbA0H7cU0MJ
 TBsi7H084CKVl27O359Mgg6WODiSBdgVaEie1g7r+TMjFjGCFgTHN/tjsO3vgzdZg6Et qg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38pdmb81ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 09:21:30 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14LD3Tg6029271;
        Fri, 21 May 2021 13:21:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 38j5jgu57q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 May 2021 13:21:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14LDLQXe11075988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 13:21:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B48F6AE053;
        Fri, 21 May 2021 13:21:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D67DAE04D;
        Fri, 21 May 2021 13:21:24 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 21 May 2021 13:21:24 +0000 (GMT)
Date:   Fri, 21 May 2021 18:51:23 +0530
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
Subject: Re: [PATCH v3 6/8] sched/idle: Move busy_cpu accounting to idle
 callback
Message-ID: <20210521132123.GH2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
 <20210513074027.543926-7-srikar@linux.vnet.ibm.com>
 <CAKfTPtB05dxcXPX_hZOFXHYaW98sdcykxVYnWdNdMOBHqLMBow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKfTPtB05dxcXPX_hZOFXHYaW98sdcykxVYnWdNdMOBHqLMBow@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ypd_0MbWUCdiLgV8IZ0BMKBLuKfL5wZn
X-Proofpoint-GUID: ypd_0MbWUCdiLgV8IZ0BMKBLuKfL5wZn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-21_04:2021-05-20,2021-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [2021-05-21 14:37:51]:

> On Thu, 13 May 2021 at 09:41, Srikar Dronamraju
> <srikar@linux.vnet.ibm.com> wrote:
> >
> > Currently we account nr_busy_cpus in no_hz idle functions.
> > There is no reason why nr_busy_cpus should updated be in NO_HZ_COMMON
> > configs only. Also scheduler can mark a CPU as non-busy as soon as an
> > idle class task starts to run. Scheduler can then mark a CPU as busy
> > as soon as its woken up from idle or a new task is placed on it's
> > runqueue.
> >
> > Cc: LKML <linux-kernel@vger.kernel.org>
> > Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> > Cc: Parth Shah <parth@linux.ibm.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > ---
> >  kernel/sched/fair.c     |  6 ++++--
> >  kernel/sched/idle.c     | 29 +++++++++++++++++++++++++++--
> >  kernel/sched/sched.h    |  1 +
> >  kernel/sched/topology.c |  2 ++
> >  4 files changed, 34 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 0dfe01de22d6..8f86359efdbd 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10410,7 +10410,10 @@ static void set_cpu_sd_state_busy(int cpu)
> >                 goto unlock;
> >         sd->nohz_idle = 0;
> >
> > -       atomic_inc(&sd->shared->nr_busy_cpus);
> > +       if (sd && per_cpu(is_idle, cpu)) {
> > +               atomic_add_unless(&sd->shared->nr_busy_cpus, 1, per_cpu(sd_llc_size, cpu));
> > +               per_cpu(is_idle, cpu) = 0;
> > +       }
> >  unlock:
> >         rcu_read_unlock();
> >  }
> > @@ -10440,7 +10443,6 @@ static void set_cpu_sd_state_idle(int cpu)
> >                 goto unlock;
> >         sd->nohz_idle = 1;
> >
> > -       atomic_dec(&sd->shared->nr_busy_cpus);
> >  unlock:
> >         rcu_read_unlock();
> >  }
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index a9f5a8ace59e..c13105fe06b3 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -431,12 +431,25 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
> >
> >  static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
> >  {
> > -#ifdef CONFIG_SCHED_SMT
> > +#ifdef CONFIG_SMP
> > +       struct sched_domain_shared *sds;
> >         int cpu = rq->cpu;
> >
> > +#ifdef CONFIG_SCHED_SMT
> >         if (static_branch_likely(&sched_smt_present))
> >                 set_core_busy(cpu);
> >  #endif
> > +
> > +       rcu_read_lock();
> > +       sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > +       if (sds) {
> > +               if (per_cpu(is_idle, cpu)) {
> > +                       atomic_inc(&sds->nr_busy_cpus);
> > +                       per_cpu(is_idle, cpu) = 0;
> > +               }
> > +       }
> > +       rcu_read_unlock();
> > +#endif
> >  }
> >
> >  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
> > @@ -448,9 +461,21 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
> >  struct task_struct *pick_next_task_idle(struct rq *rq)
> >  {
> >         struct task_struct *next = rq->idle;
> > +#ifdef CONFIG_SMP
> > +       struct sched_domain_shared *sds;
> > +       int cpu = rq->cpu;
> >
> > -       set_next_task_idle(rq, next, true);
> > +       rcu_read_lock();
> > +       sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > +       if (sds) {
> > +               atomic_add_unless(&sds->nr_busy_cpus, -1, 0);
> > +               per_cpu(is_idle, cpu) = 1;
> > +       }
> 
> One reason to update nr_busy_cpus only during tick is and not at each
> and every single sleep/wakeup to limit the number of atomic_inc/dec in
> case of storm of short running tasks. Because at the end , you waste
> more time trying to accurately follow the current state of the CPU
> than doing work
> 

Yes, I do understand that for short running tasks or if the CPUs are
entering idle for a very short interval; we are unnecessarily tracking the
number of busy_cpus.

However lets assume we have to compare 2 LLCs and have to choose a better
one for a wakeup.
1. We can look at nr_busy_cpus which may not have been updated at every
CPU idle.
2. We can look at nr_busy_cpus which has been updated at every CPU idle.
3. We start aggregating the load of all the CPUs in the LLC.
4. Use the current method, where it only compares the load on previous CPU
and current CPU. However that doesnt give too much indication if the other
CPUs in those LLCs were free.

or probably some other method.

I thought option 2 would be better but I am okay with option 1 too.
Please let me know what option you would prefer.

> >
> > +       rcu_read_unlock();
> > +#endif
> > +
> > +       set_next_task_idle(rq, next, true);
> >         return next;
> >  }
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 98c3cfbc5d26..b66c4dad5fd2 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1496,6 +1496,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
> >  #ifdef CONFIG_SCHED_SMT
> >  DECLARE_PER_CPU(int, smt_id);
> >  #endif
> > +DECLARE_PER_CPU(int, is_idle);
> >  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 232fb261dfc2..730252937712 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -647,6 +647,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
> >  #ifdef CONFIG_SCHED_SMT
> >  DEFINE_PER_CPU(int, smt_id);
> >  #endif
> > +DEFINE_PER_CPU(int, is_idle);
> >  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > @@ -673,6 +674,7 @@ static void update_top_cache_domain(int cpu)
> >  #ifdef CONFIG_SCHED_SMT
> >         per_cpu(smt_id, cpu) = cpumask_first(cpu_smt_mask(cpu));
> >  #endif
> > +       per_cpu(is_idle, cpu) = 1;
> >         rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> >
> >         sd = lowest_flag_domain(cpu, SD_NUMA);
> > --
> > 2.18.2
> >

-- 
Thanks and Regards
Srikar Dronamraju
