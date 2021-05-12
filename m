Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B2237B784
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhELIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:09:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:45922 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhELIJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:09:38 -0400
IronPort-SDR: BGufosqlpCyYGyeiYbd4E4P05KRI9PEgyaGBFU49MuZXf7aVYalCW17aO8t3x7xnk7nwsOFGnb
 FwHQcn6iY5Rg==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="263574324"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="263574324"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 01:08:25 -0700
IronPort-SDR: PCDFUll6IBBso3MPC9/0iQr9dpJJ9SWelorUZvb8tp5qi/ajZiSgNPfa3G5N6ecvMYGjdfQKvd
 vbEOd1/u9J/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="455479215"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga004.fm.intel.com with ESMTP; 12 May 2021 01:08:21 -0700
Subject: Re: [PATCH v2 6/8] sched/idle: Move busy_cpu accounting to idle
 callback
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <47d29f1d-cea6-492a-5125-85db6bce0fa7@linux.intel.com>
Date:   Wed, 12 May 2021 16:08:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/21 12:45 AM, Srikar Dronamraju wrote:
> Currently we account nr_busy_cpus in no_hz idle functions.
> There is no reason why nr_busy_cpus should updated be in NO_HZ_COMMON
> configs only. Also scheduler can mark a CPU as non-busy as soon as an
> idle class task starts to run. Scheduler can then mark a CPU as busy
> as soon as its woken up from idle or a new task is placed on it's
> runqueue.

IIRC, we discussed this before, if a SCHED_IDLE task is placed on the
CPU's runqueue, this CPU should be still taken as a wakeup target.

Also, for those frequent context-switching tasks with very short idle,
it's expensive for scheduler to mark idle/busy every time, that's why
my patch only marks idle every time and marks busy ratelimited in
scheduler tick.

Thanks,
-Aubrey

> 
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Cc: Parth Shah <parth@linux.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Rik van Riel <riel@surriel.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c     |  6 ++++--
>  kernel/sched/idle.c     | 29 +++++++++++++++++++++++++++--
>  kernel/sched/sched.h    |  1 +
>  kernel/sched/topology.c |  2 ++
>  4 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c30587631a24..4d3b0928fe98 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10394,7 +10394,10 @@ static void set_cpu_sd_state_busy(int cpu)
>  		goto unlock;
>  	sd->nohz_idle = 0;
>  
> -	atomic_inc(&sd->shared->nr_busy_cpus);
> +	if (sd && per_cpu(is_idle, cpu)) {
> +		atomic_add_unless(&sd->shared->nr_busy_cpus, 1, per_cpu(sd_llc_size, cpu));
> +		per_cpu(is_idle, cpu) = 0;
> +	}
>  unlock:
>  	rcu_read_unlock();
>  }
> @@ -10424,7 +10427,6 @@ static void set_cpu_sd_state_idle(int cpu)
>  		goto unlock;
>  	sd->nohz_idle = 1;
>  
> -	atomic_dec(&sd->shared->nr_busy_cpus);
>  unlock:
>  	rcu_read_unlock();
>  }
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index cc828f3efe71..e624a05e48bd 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -425,12 +425,25 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
>  
>  static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
>  {
> -#ifdef CONFIG_SCHED_SMT
> +#ifdef CONFIG_SMP
> +	struct sched_domain_shared *sds;
>  	int cpu = rq->cpu;
>  
> +#ifdef CONFIG_SCHED_SMT
>  	if (static_branch_likely(&sched_smt_present))
>  		set_core_busy(cpu);
>  #endif
> +
> +	rcu_read_lock();
> +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +	if (sds) {
> +		if (per_cpu(is_idle, cpu)) {
> +			atomic_inc(&sds->nr_busy_cpus);
> +			per_cpu(is_idle, cpu) = 0;
> +		}
> +	}
> +	rcu_read_unlock();
> +#endif
>  }
>  
>  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
> @@ -442,9 +455,21 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
>  struct task_struct *pick_next_task_idle(struct rq *rq)
>  {
>  	struct task_struct *next = rq->idle;
> +#ifdef CONFIG_SMP
> +	struct sched_domain_shared *sds;
> +	int cpu = rq->cpu;
>  
> -	set_next_task_idle(rq, next, true);
> +	rcu_read_lock();
> +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +	if (sds) {
> +		atomic_add_unless(&sds->nr_busy_cpus, -1, 0);
> +		per_cpu(is_idle, cpu) = 1;
> +	}
>  
> +	rcu_read_unlock();
> +#endif
> +
> +	set_next_task_idle(rq, next, true);
>  	return next;
>  }
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 5c0bd4b0e73a..baf8d9a4cb26 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1483,6 +1483,7 @@ DECLARE_PER_CPU(int, sd_llc_id);
>  #ifdef CONFIG_SCHED_SMT
>  DECLARE_PER_CPU(int, smt_id);
>  #endif
> +DECLARE_PER_CPU(int, is_idle);
>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8db40c8a6ad0..00e4669bb241 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -647,6 +647,7 @@ DEFINE_PER_CPU(int, sd_llc_id);
>  #ifdef CONFIG_SCHED_SMT
>  DEFINE_PER_CPU(int, smt_id);
>  #endif
> +DEFINE_PER_CPU(int, is_idle);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> @@ -673,6 +674,7 @@ static void update_top_cache_domain(int cpu)
>  #ifdef CONFIG_SCHED_SMT
>  	per_cpu(smt_id, cpu) = cpumask_first(cpu_smt_mask(cpu));
>  #endif
> +	per_cpu(is_idle, cpu) = 1;
>  	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
>  
>  	sd = lowest_flag_domain(cpu, SD_NUMA);
> 

