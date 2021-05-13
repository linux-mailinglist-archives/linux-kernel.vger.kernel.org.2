Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71C37F393
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 09:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhEMHdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 03:33:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46294 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230443AbhEMHdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 03:33:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14D7EhL4181535;
        Thu, 13 May 2021 03:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=2f/QlzHVCEOcAkYSTC7Y47fpxzrNHvBWlrXfnwJSqkc=;
 b=IfNQ4BxSHvmKfGqXZpL8eGbKEeFoI+hBl/PfepWMd9J7wc0MB6iWGYcmcjTcGcp5gRHP
 KOK4EKeXnTZUFCLPt4XlmVbti0SCJA0dOYW1i+ahfNQxxeeRF70R4mmMut1Lv5SNQcel
 YYMGYY7RV+jkc/JkrKCSke7aWnqmztIx/2PzyP65PTFbVnwHaQOxvE8+GVnO1k+dXb6H
 uylV4AC47sYe7uO89XIXHudQ9kDjlOfuhAHt4YF5aP6/rTg5+PZv+JPFMANDldfv/0rq
 PVK7jk/Xw5Yy3XrWqtsQoN4zmJfZjI3mrRsRla5F9dpqqSFy5GD8W/MV7OZAD8SthUrF Pg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38gyhyrc71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 03:31:20 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14D7RCKt009646;
        Thu, 13 May 2021 07:31:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 38fxx00e00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 07:31:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14D7UmCP17826072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 07:30:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8E8FAE055;
        Thu, 13 May 2021 07:31:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85FAAAE051;
        Thu, 13 May 2021 07:31:13 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 13 May 2021 07:31:13 +0000 (GMT)
Date:   Thu, 13 May 2021 13:01:12 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH v2 6/8] sched/idle: Move busy_cpu accounting to idle
 callback
Message-ID: <20210513073112.GV2633526@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
 <47d29f1d-cea6-492a-5125-85db6bce0fa7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <47d29f1d-cea6-492a-5125-85db6bce0fa7@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DS_K0QQ847pq5mIjRujuVq5jQwKTgtTz
X-Proofpoint-ORIG-GUID: DS_K0QQ847pq5mIjRujuVq5jQwKTgtTz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_03:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aubrey Li <aubrey.li@linux.intel.com> [2021-05-12 16:08:24]:

> On 5/7/21 12:45 AM, Srikar Dronamraju wrote:
> > Currently we account nr_busy_cpus in no_hz idle functions.
> > There is no reason why nr_busy_cpus should updated be in NO_HZ_COMMON
> > configs only. Also scheduler can mark a CPU as non-busy as soon as an
> > idle class task starts to run. Scheduler can then mark a CPU as busy
> > as soon as its woken up from idle or a new task is placed on it's
> > runqueue.
> 
> IIRC, we discussed this before, if a SCHED_IDLE task is placed on the
> CPU's runqueue, this CPU should be still taken as a wakeup target.
> 

Yes, this CPU is still a wakeup target, its only when this CPU is busy, that
we look at other CPUs

> Also, for those frequent context-switching tasks with very short idle,
> it's expensive for scheduler to mark idle/busy every time, that's why
> my patch only marks idle every time and marks busy ratelimited in
> scheduler tick.
> 

I have tried few tasks with very short idle times and updating nr_busy
everytime, doesnt seem to be impacting. Infact, it seems to help in picking
the idler-llc more often.

> Thanks,
> -Aubrey
> 
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
> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > ---
> >  kernel/sched/fair.c     |  6 ++++--
> >  kernel/sched/idle.c     | 29 +++++++++++++++++++++++++++--
> >  kernel/sched/sched.h    |  1 +
> >  kernel/sched/topology.c |  2 ++
> >  4 files changed, 34 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c30587631a24..4d3b0928fe98 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10394,7 +10394,10 @@ static void set_cpu_sd_state_busy(int cpu)
> >  		goto unlock;
> >  	sd->nohz_idle = 0;
> >  
> > -	atomic_inc(&sd->shared->nr_busy_cpus);
> > +	if (sd && per_cpu(is_idle, cpu)) {
> > +		atomic_add_unless(&sd->shared->nr_busy_cpus, 1, per_cpu(sd_llc_size, cpu));
> > +		per_cpu(is_idle, cpu) = 0;
> > +	}
> >  unlock:
> >  	rcu_read_unlock();
> >  }
> > @@ -10424,7 +10427,6 @@ static void set_cpu_sd_state_idle(int cpu)
> >  		goto unlock;
> >  	sd->nohz_idle = 1;
> >  
> > -	atomic_dec(&sd->shared->nr_busy_cpus);
> >  unlock:
> >  	rcu_read_unlock();
> >  }
> > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > index cc828f3efe71..e624a05e48bd 100644
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -425,12 +425,25 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
> >  
> >  static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
> >  {
> > -#ifdef CONFIG_SCHED_SMT
> > +#ifdef CONFIG_SMP
> > +	struct sched_domain_shared *sds;
> >  	int cpu = rq->cpu;
> >  
> > +#ifdef CONFIG_SCHED_SMT
> >  	if (static_branch_likely(&sched_smt_present))
> >  		set_core_busy(cpu);
> >  #endif
> > +
> > +	rcu_read_lock();
> > +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > +	if (sds) {
> > +		if (per_cpu(is_idle, cpu)) {
> > +			atomic_inc(&sds->nr_busy_cpus);
> > +			per_cpu(is_idle, cpu) = 0;
> > +		}
> > +	}
> > +	rcu_read_unlock();
> > +#endif
> >  }
> >  
> >  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
> > @@ -442,9 +455,21 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
> >  struct task_struct *pick_next_task_idle(struct rq *rq)
> >  {
> >  	struct task_struct *next = rq->idle;
> > +#ifdef CONFIG_SMP
> > +	struct sched_domain_shared *sds;
> > +	int cpu = rq->cpu;
> >  
> > -	set_next_task_idle(rq, next, true);
> > +	rcu_read_lock();
> > +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> > +	if (sds) {
> > +		atomic_add_unless(&sds->nr_busy_cpus, -1, 0);
> > +		per_cpu(is_idle, cpu) = 1;
> > +	}
> >  
> > +	rcu_read_unlock();
> > +#endif
> > +
> > +	set_next_task_idle(rq, next, true);
> >  	return next;
> >  }
> >  
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 5c0bd4b0e73a..baf8d9a4cb26 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1483,6 +1483,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
> >  #ifdef CONFIG_SCHED_SMT
> >  DECLARE_PER_CPU(int, smt_id);
> >  #endif
> > +DECLARE_PER_CPU(int, is_idle);
> >  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
> >  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 8db40c8a6ad0..00e4669bb241 100644
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
> >  	per_cpu(smt_id, cpu) = cpumask_first(cpu_smt_mask(cpu));
> >  #endif
> > +	per_cpu(is_idle, cpu) = 1;
> >  	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
> >  
> >  	sd = lowest_flag_domain(cpu, SD_NUMA);
> > 
> 

-- 
Thanks and Regards
Srikar Dronamraju
