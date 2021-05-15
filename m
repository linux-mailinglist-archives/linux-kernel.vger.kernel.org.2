Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E272338151F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 04:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhEOCQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 22:16:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:41198 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234987AbhEOCQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 22:16:16 -0400
IronPort-SDR: 3MdbSJqxT0M94P2VbtMwhe+TmixezuvodBGFJ0Ms8AhCcUm9IiIDVAnE1PxRgVBPozJME1YL+Q
 KrcSNqQMcGyg==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="198304109"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="198304109"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 19:15:03 -0700
IronPort-SDR: mwJQ0TI4ox0fUAVP+JNKP9ZbnLOGGtLua7hxrrEDIVF1TsO0YeEtxqnK7DHuoRoAWXV3PThUJ/
 hUQjQOjL188g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="393809908"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 14 May 2021 19:15:02 -0700
Date:   Fri, 14 May 2021 19:14:15 -0700
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
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 5/6] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <20210515021415.GB14212@ranerica-svr.sc.intel.com>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
 <20210513154909.6385-6-ricardo.neri-calderon@linux.intel.com>
 <YJ5HQR943rSFsLxw@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ5HQR943rSFsLxw@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:47:45AM +0200, Peter Zijlstra wrote:
> On Thu, May 13, 2021 at 08:49:08AM -0700, Ricardo Neri wrote:
> >  include/linux/sched/topology.h |   1 +
> >  kernel/sched/fair.c            | 101 +++++++++++++++++++++++++++++++++
> >  2 files changed, 102 insertions(+)
> > 
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > index 8f0f778b7c91..43bdb8b1e1df 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -57,6 +57,7 @@ static inline int cpu_numa_flags(void)
> >  #endif
> >  
> >  extern int arch_asym_cpu_priority(int cpu);
> > +extern bool arch_asym_check_smt_siblings(void);
> >  
> >  struct sched_domain_attr {
> >  	int relax_domain_level;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c8b66a5d593e..3d6cc027e6e6 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -106,6 +106,15 @@ int __weak arch_asym_cpu_priority(int cpu)
> >  	return -cpu;
> >  }
> >  
> > +/*
> > + * For asym packing, first check the state of SMT siblings before deciding to
> > + * pull tasks.
> > + */
> > +bool __weak arch_asym_check_smt_siblings(void)
> > +{
> > +	return false;
> > +}
> > +
> >  /*
> >   * The margin used when comparing utilization with CPU capacity.
> >   *
> 
> > @@ -8458,6 +8550,9 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
> >  	if (group == sds->local)
> >  		return false;
> >  
> > +	if (arch_asym_check_smt_siblings())
> > +		return asym_can_pull_tasks(env->dst_cpu, sds, sgs, group);
> > +
> >  	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
> >  }
> 
> So I'm thinking that this is a property of having ASYM_PACKING at a core
> level, rather than some arch special. Wouldn't something like this be
> more appropriate?
> 
> ---
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -57,7 +57,6 @@ static inline int cpu_numa_flags(void)
>  #endif
>  
>  extern int arch_asym_cpu_priority(int cpu);
> -extern bool arch_asym_check_smt_siblings(void);
>  
>  struct sched_domain_attr {
>  	int relax_domain_level;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -107,15 +107,6 @@ int __weak arch_asym_cpu_priority(int cp
>  }
>  
>  /*
> - * For asym packing, first check the state of SMT siblings before deciding to
> - * pull tasks.
> - */
> -bool __weak arch_asym_check_smt_siblings(void)
> -{
> -	return false;
> -}
> -
> -/*
>   * The margin used when comparing utilization with CPU capacity.
>   *
>   * (default: ~20%)
> @@ -8550,7 +8541,8 @@ sched_asym(struct lb_env *env, struct sd
>  	if (group == sds->local)
>  		return false;
>  
> -	if (arch_asym_check_smt_siblings())
> +	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
> +	    (group->flags & SD_SHARE_CPUCAPACITY))
>  		return asym_can_pull_tasks(env->dst_cpu, sds, sgs, group);

Thanks Peter for the quick review! This makes sense to me. The only
reason we proposed arch_asym_check_smt_siblings() is because we were
about breaking powerpc (I need to study how they set priorities for SMT,
if applicable). If you think this is not an issue I can post a
v4 with this update.

Thanks and BR,
Ricardo
