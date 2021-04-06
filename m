Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75FF355F89
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 01:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242705AbhDFXhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 19:37:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:2472 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233184AbhDFXhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:37:32 -0400
IronPort-SDR: dwIzZrz9ewKjJDzaCAaijLNrbr44NxBvKcvBNDU3zs2SxHq/3T8YsEGLCG3elSAGv59M+5bkDD
 bCzQ+DVsHD/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="192718245"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="192718245"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 16:37:23 -0700
IronPort-SDR: g8Qp21V4eKDGDOkBrafrvZ9n3nX6o8xhpNCxqvk379jd98aq+SFYvSzfgdeH6kzoZZh4YQykx2
 7K5bnIKGic2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="441108616"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 06 Apr 2021 16:37:23 -0700
Date:   Tue, 6 Apr 2021 16:36:52 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 2/4] sched/fair: Introduce arch_sched_asym_prefer_early()
Message-ID: <20210406233652.GD27195@ranerica-svr.sc.intel.com>
References: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
 <20210406041108.7416-3-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtBfRCXgfLVbTo1tD+_puzvba8qbhYc99RiL9QchQ+S5ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBfRCXgfLVbTo1tD+_puzvba8qbhYc99RiL9QchQ+S5ew@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 04:31:35PM +0200, Vincent Guittot wrote:
> On Tue, 6 Apr 2021 at 06:11, Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > Introduce arch_sched_asym_prefer_early() so that architectures with SMT
> > can delay the decision to label a candidate busiest group as
> > group_asym_packing.
> >
> > When using asymmetric packing, high priority idle CPUs pull tasks from
> > scheduling groups with low priority CPUs. The decision on using asymmetric
> > packing for load balancing is done after collecting the statistics of a
> > candidate busiest group. However, this decision needs to consider the
> > state of SMT siblings of dst_cpu.
> >
> > Cc: Aubrey Li <aubrey.li@intel.com>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Quentin Perret <qperret@google.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  include/linux/sched/topology.h |  1 +
> >  kernel/sched/fair.c            | 11 ++++++++++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > index 8f0f778b7c91..663b98959305 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -57,6 +57,7 @@ static inline int cpu_numa_flags(void)
> >  #endif
> >
> >  extern int arch_asym_cpu_priority(int cpu);
> > +extern bool arch_sched_asym_prefer_early(int a, int b);
> >
> >  struct sched_domain_attr {
> >         int relax_domain_level;
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 4ef3fa0d5e8d..e74da853b046 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -106,6 +106,15 @@ int __weak arch_asym_cpu_priority(int cpu)
> >         return -cpu;
> >  }
> >
> > +/*
> > + * For asym packing, early check if CPUs with higher priority should be
> > + * preferred. On some architectures, more data is needed to make a decision.
> > + */
> > +bool __weak arch_sched_asym_prefer_early(int a, int b)
> > +{
> > +       return sched_asym_prefer(a, b);
> > +}
> > +
> >  /*
> >   * The margin used when comparing utilization with CPU capacity.
> >   *
> > @@ -8458,7 +8467,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >         if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
> >             env->idle != CPU_NOT_IDLE &&
> >             sgs->sum_h_nr_running &&
> > -           sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> > +           arch_sched_asym_prefer_early(env->dst_cpu, group->asym_prefer_cpu)) {
> 
> If itmt set arch_sched_asym_prefer_early to true all groups will be
> set as group_asym_packing unconditionally which is wrong. The state
> has to be set only when we want asym packing migration

Thanks for your quick review Vincent! 

Indeed, sgs->group_asym_packing should only be set when we want
asym_packing migration. However, for ITMT we also need to know the state
of the SMT siblings of dst_cpu if any. update_sg_lb_stats() does not
anything about the local group. Thus, arch_sched_asym_prefer_early()
intends to give an early decision that can be revoked later when
statistics of the local group are known. I also thought about checking
the state of the SMT siblings from update_sg_lb_stats() but that would
duplicate the functionality of update_sg_lb_stats() when called on the
local group.

The group can still be classified as group_overloaded and
group_imbalanced as they take precedence over group_asym_packing. We
would miss the group_has_spare and group_fully_busy classifications,
though. I can look into fixing that.

Thanks and BR,
Ricardo
