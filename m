Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38B388050
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbhERTJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:09:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:11296 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237963AbhERTJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:09:48 -0400
IronPort-SDR: Q0DIsj5QO3JA7SPoWZ5Enk4/AaSP0Y2fzb1CFie8l8MRG/lpPXUCsVVCysmUSsa97ADzDiWBXa
 VjOhotf/+sSw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="187920921"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="187920921"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 12:08:30 -0700
IronPort-SDR: E9Mhi/pl5lPivUHwoIgo5A4nYo3UxNeOuVe0huT6qSCD08qMTcTy6yf8yJHvOwqghRRIABzQJU
 Jp3GfO/6WoRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439244218"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 18 May 2021 12:08:29 -0700
Date:   Tue, 18 May 2021 12:07:40 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 5/6] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <20210518190740.GA15251@ranerica-svr.sc.intel.com>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
 <20210513154909.6385-6-ricardo.neri-calderon@linux.intel.com>
 <YJ5HQR943rSFsLxw@hirez.programming.kicks-ass.net>
 <20210515021415.GB14212@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515021415.GB14212@ranerica-svr.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 07:14:15PM -0700, Ricardo Neri wrote:
> On Fri, May 14, 2021 at 11:47:45AM +0200, Peter Zijlstra wrote:
> > On Thu, May 13, 2021 at 08:49:08AM -0700, Ricardo Neri wrote:
> > >  include/linux/sched/topology.h |   1 +
> > >  kernel/sched/fair.c            | 101 +++++++++++++++++++++++++++++++++
> > >  2 files changed, 102 insertions(+)
> > > 
> > > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > > index 8f0f778b7c91..43bdb8b1e1df 100644
> > > --- a/include/linux/sched/topology.h
> > > +++ b/include/linux/sched/topology.h
> > > @@ -57,6 +57,7 @@ static inline int cpu_numa_flags(void)
> > >  #endif
> > >  
> > >  extern int arch_asym_cpu_priority(int cpu);
> > > +extern bool arch_asym_check_smt_siblings(void);
> > >  
> > >  struct sched_domain_attr {
> > >  	int relax_domain_level;
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index c8b66a5d593e..3d6cc027e6e6 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -106,6 +106,15 @@ int __weak arch_asym_cpu_priority(int cpu)
> > >  	return -cpu;
> > >  }
> > >  
> > > +/*
> > > + * For asym packing, first check the state of SMT siblings before deciding to
> > > + * pull tasks.
> > > + */
> > > +bool __weak arch_asym_check_smt_siblings(void)
> > > +{
> > > +	return false;
> > > +}
> > > +
> > >  /*
> > >   * The margin used when comparing utilization with CPU capacity.
> > >   *
> > 
> > > @@ -8458,6 +8550,9 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
> > >  	if (group == sds->local)
> > >  		return false;
> > >  
> > > +	if (arch_asym_check_smt_siblings())
> > > +		return asym_can_pull_tasks(env->dst_cpu, sds, sgs, group);
> > > +
> > >  	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
> > >  }
> > 
> > So I'm thinking that this is a property of having ASYM_PACKING at a core
> > level, rather than some arch special. Wouldn't something like this be
> > more appropriate?
> > 
> > ---
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -57,7 +57,6 @@ static inline int cpu_numa_flags(void)
> >  #endif
> >  
> >  extern int arch_asym_cpu_priority(int cpu);
> > -extern bool arch_asym_check_smt_siblings(void);
> >  
> >  struct sched_domain_attr {
> >  	int relax_domain_level;
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -107,15 +107,6 @@ int __weak arch_asym_cpu_priority(int cp
> >  }
> >  
> >  /*
> > - * For asym packing, first check the state of SMT siblings before deciding to
> > - * pull tasks.
> > - */
> > -bool __weak arch_asym_check_smt_siblings(void)
> > -{
> > -	return false;
> > -}
> > -
> > -/*
> >   * The margin used when comparing utilization with CPU capacity.
> >   *
> >   * (default: ~20%)
> > @@ -8550,7 +8541,8 @@ sched_asym(struct lb_env *env, struct sd
> >  	if (group == sds->local)
> >  		return false;
> >  
> > -	if (arch_asym_check_smt_siblings())
> > +	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
> > +	    (group->flags & SD_SHARE_CPUCAPACITY))
> >  		return asym_can_pull_tasks(env->dst_cpu, sds, sgs, group);
> 
> Thanks Peter for the quick review! This makes sense to me. The only
> reason we proposed arch_asym_check_smt_siblings() is because we were
> about breaking powerpc (I need to study how they set priorities for SMT,
> if applicable). If you think this is not an issue I can post a
> v4 with this update.

As far as I can see, priorities in powerpc are set by the CPU number.
However, I am not sure how CPUs are enumerated? If CPUs in brackets are
SMT sibling, Does an enumeration looks like A) [0, 1], [2, 3] or B) [0, 2],
[1, 3]? I guess B is the right answer. Otherwise, both SMT siblings of a
core would need to be busy before a new core is used.

Still, I think the issue described in the cover letter may be
reproducible in powerpc as well. If CPU3 is offlined, and [0, 2] pulled
tasks from [1, -] so that both CPU0 and CPU2 become busy, CPU1 would not be
able to help since CPU0 has the highest priority.

I am cc'ing the linuxppc list to get some feedback.

Thanks and BR,
Ricardo
