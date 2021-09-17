Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0F140EE8D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 03:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242041AbhIQBCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 21:02:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:4234 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhIQBCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 21:02:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="308239022"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="308239022"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 18:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="583842727"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2021 18:01:11 -0700
Date:   Thu, 16 Sep 2021 18:00:44 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
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
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5 6/6] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <20210917010044.GA23727@ranerica-svr.sc.intel.com>
References: <20210911011819.12184-1-ricardo.neri-calderon@linux.intel.com>
 <20210911011819.12184-7-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtBcDP3Yp54sd4+1kP=o=4e_1HEmOf=eMXydag_J38CEng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBcDP3Yp54sd4+1kP=o=4e_1HEmOf=eMXydag_J38CEng@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 05:43:44PM +0200, Vincent Guittot wrote:
> On Sat, 11 Sept 2021 at 03:19, Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > When deciding to pull tasks in ASYM_PACKING, it is necessary not only to
> > check for the idle state of the destination CPU, dst_cpu, but also of
> > its SMT siblings.
> >
> > If dst_cpu is idle but its SMT siblings are busy, performance suffers
> > if it pulls tasks from a medium priority CPU that does not have SMT
> > siblings.
> >
> > Implement asym_smt_can_pull_tasks() to inspect the state of the SMT
> > siblings of both dst_cpu and the CPUs in the candidate busiest group.
> >
> > Cc: Aubrey Li <aubrey.li@intel.com>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Quentin Perret <qperret@google.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v4:
> >   * Use sg_lb_stats::sum_nr_running the idle state of a scheduling group.
> >     (Vincent, Peter)
> >   * Do not even idle CPUs in asym_smt_can_pull_tasks(). (Vincent)
> >   * Updated function documentation and corrected a typo.
> >
> > Changes since v3:
> >   * Removed the arch_asym_check_smt_siblings() hook. Discussions with the
> >     powerpc folks showed that this patch should not impact them. Also, more
> >     recent powerpc processor no longer use asym_packing. (PeterZ)
> >   * Removed unnecessary local variable in asym_can_pull_tasks(). (Dietmar)
> >   * Removed unnecessary check for local CPUs when the local group has zero
> >     utilization. (Joel)
> >   * Renamed asym_can_pull_tasks() as asym_smt_can_pull_tasks() to reflect
> >     the fact that it deals with SMT cases.
> >   * Made asym_smt_can_pull_tasks() return false for !CONFIG_SCHED_SMT so
> >     that callers can deal with non-SMT cases.
> >
> > Changes since v2:
> >   * Reworded the commit message to reflect updates in code.
> >   * Corrected misrepresentation of dst_cpu as the CPU doing the load
> >     balancing. (PeterZ)
> >   * Removed call to arch_asym_check_smt_siblings() as it is now called in
> >     sched_asym().
> >
> > Changes since v1:
> >   * Don't bailout in update_sd_pick_busiest() if dst_cpu cannot pull
> >     tasks. Instead, reclassify the candidate busiest group, as it
> >     may still be selected. (PeterZ)
> >   * Avoid an expensive and unnecessary call to cpumask_weight() when
> >     determining if a sched_group is comprised of SMT siblings.
> >     (PeterZ).
> > ---
> >  kernel/sched/fair.c | 94 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 26db017c14a3..8d763dd0174b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8597,10 +8597,98 @@ group_type group_classify(unsigned int imbalance_pct,
> >         return group_has_spare;
> >  }
> >
> > +/**
> > + * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
> > + * @dst_cpu:   Destination CPU of the load balancing
> > + * @sds:       Load-balancing data with statistics of the local group
> > + * @sgs:       Load-balancing statistics of the candidate busiest group
> > + * @sg:                The candidate busiest group
> > + *
> > + * Check the state of the SMT siblings of both @sds::local and @sg and decide
> > + * if @dst_cpu can pull tasks.
> > + *
> > + * If @dst_cpu does not have SMT siblings, it can pull tasks if two or more of
> > + * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
> > + * only if @dst_cpu has higher priority.
> > + *
> > + * If both @dst_cpu and @sg have SMT siblings, and @sg has exactly one more
> > + * busy CPU than @sds::local, let @dst_cpu pull tasks if it has higher priority.
> > + * Bigger imbalances in the number of busy CPUs will be dealt with in
> > + * update_sd_pick_busiest().
> > + *
> > + * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
> > + * of @dst_cpu are idle and @sg has lower priority.
> > + */
> > +static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> > +                                   struct sg_lb_stats *sgs,
> > +                                   struct sched_group *sg)
> > +{
> > +#ifdef CONFIG_SCHED_SMT
> > +       bool local_is_smt, sg_is_smt;
> > +       int sg_busy_cpus;
> > +
> > +       local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
> > +       sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
> > +
> > +       sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
> > +
> > +       if (!local_is_smt) {
> > +               /*
> > +                * If we are here, @dst_cpu is idle and does not have SMT
> > +                * siblings. Pull tasks if candidate group has two or more
> > +                * busy CPUs.
> > +                */
> > +               if (sg_is_smt && sg_busy_cpus >= 2)
> 
> Do you really need to test sg_is_smt ? if sg_busy_cpus >= 2 then
> sd_is_smt must be true ?

Thank you very much for your feedback Vincent!

Yes, it is true that sg_busy_cpus >=2 is only true if @sg is SMT. I will
remove this check.

> 
> Also, This is the default behavior where we want to even the number of
> busy cpu. Shouldn't you return false and fall back to the default
> behavior ?

This is also true.

> 
> That being said, the default behavior tries to even the number of idle
> cpus which is easier to compute and is equal to even the number of
> busy cpus in "normal" system with the same number of cpus in groups
> but this is not the case here. It could be good to change the default
> behavior to even the number of busy cpus and that you use the default
> behavior here. Additional condition will be used to select the busiest
> group like more busy cpu or more number of running tasks

That is a very good observation. Checking the number of idle CPUs
assumes that both groups have the same number of CPUs. I'll look into
modifying the default behavior.

> 
> > +                       return true;
> > +
> > +               /*
> > +                * @dst_cpu does not have SMT siblings. @sg may have SMT
> > +                * siblings and only one is busy. In such case, @dst_cpu
> > +                * can help if it has higher priority and is idle (i.e.,
> > +                * it has no running tasks).
> 
> The previous comment above assume that "@dst_cpu is idle" but now you
> need to check that sds->local_stat.sum_nr_running == 0

But we already know that, right? We are here because in
update_sg_lb_stats() we determine that dst CPU is idle (env->idle !=
CPU_NOT_IDLE).

Thanks and BR,
Ricardo
