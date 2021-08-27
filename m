Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF683FA018
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhH0ToT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:44:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:56885 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhH0ToP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:44:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="197581563"
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="197581563"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 12:43:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="528418837"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Aug 2021 12:43:22 -0700
Date:   Fri, 27 Aug 2021 12:43:14 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v4 6/6] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <20210827194314.GA14720@ranerica-svr.sc.intel.com>
References: <20210810144145.18776-1-ricardo.neri-calderon@linux.intel.com>
 <20210810144145.18776-7-ricardo.neri-calderon@linux.intel.com>
 <CAKfTPtArtmhLG5QYR6TzKevDrEuiQu2HJxm_C3pe549XdGU-1g@mail.gmail.com>
 <YSj7PrVGVpcKf/vz@hirez.programming.kicks-ass.net>
 <CAKfTPtBvhHBA-BLkh-fd2eJk_JOm2chgMy6AKpR=WV_hc3sQKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBvhHBA-BLkh-fd2eJk_JOm2chgMy6AKpR=WV_hc3sQKA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 05:17:22PM +0200, Vincent Guittot wrote:
> On Fri, 27 Aug 2021 at 16:50, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Aug 27, 2021 at 12:13:42PM +0200, Vincent Guittot wrote:
> > > > +/**
> > > > + * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
> > > > + * @dst_cpu:   Destination CPU of the load balancing
> > > > + * @sds:       Load-balancing data with statistics of the local group
> > > > + * @sgs:       Load-balancing statistics of the candidate busiest group
> > > > + * @sg:                The candidate busiet group
> > > > + *
> > > > + * Check the state of the SMT siblings of both @sds::local and @sg and decide
> > > > + * if @dst_cpu can pull tasks. If @dst_cpu does not have SMT siblings, it can
> > > > + * pull tasks if two or more of the SMT siblings of @sg are busy. If only one
> > > > + * CPU in @sg is busy, pull tasks only if @dst_cpu has higher priority.
> > > > + *
> > > > + * If both @dst_cpu and @sg have SMT siblings, even the number of idle CPUs
> > > > + * between @sds::local and @sg. Thus, pull tasks from @sg if the difference
> > > > + * between the number of busy CPUs is 2 or more. If the difference is of 1,
> > > > + * only pull if @dst_cpu has higher priority. If @sg does not have SMT siblings
> > > > + * only pull tasks if all of the SMT siblings of @dst_cpu are idle and @sg
> > > > + * has lower priority.
> > > > + */
> > > > +static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> > > > +                                   struct sg_lb_stats *sgs,
> > > > +                                   struct sched_group *sg)
> > > > +{
> > > > +#ifdef CONFIG_SCHED_SMT
> > > > +       bool local_is_smt, sg_is_smt;
> > > > +       int sg_busy_cpus;
> > > > +
> > > > +       local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
> > > > +       sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
> > > > +
> > > > +       sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
> > > > +
> > > > +       if (!local_is_smt) {
> > > > +               /*
> > > > +                * If we are here, @dst_cpu is idle and does not have SMT
> > > > +                * siblings. Pull tasks if candidate group has two or more
> > > > +                * busy CPUs.
> > > > +                */
> > > > +               if (sg_is_smt && sg_busy_cpus >= 2)
> > > > +                       return true;
> > > > +
> > > > +               /*
> > > > +                * @dst_cpu does not have SMT siblings. @sg may have SMT
> > > > +                * siblings and only one is busy. In such case, @dst_cpu
> > > > +                * can help if it has higher priority and is idle.
> > > > +                */
> > > > +               return !sds->local_stat.group_util &&
> > >
> > > sds->local_stat.group_util can't be used to decide if a CPU or group
> > > of CPUs is idle. util_avg is usually not null when a CPU becomes idle
> > > and you can have to wait  more than 300ms before it becomes Null
> > > At the opposite, the utilization of a CPU can be null but a task with
> > > null utilization has just woken up on it.
> > > Utilization is used to reflect the average work of the CPU or group of
> > > CPUs but not the current state
> >
> > If you want immediate idle, sgs->nr_running == 0 or sgs->idle_cpus ==
> > sgs->group_weight come to mind.
> 
> yes, I have the same in mind

Thank you very much Vincent and Peter for the feedback! I'll look at
using these stats to determine immediate idle.

> 
> >
> > > > +                      sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
> > > > +       }
> > > > +
> > > > +       /* @dst_cpu has SMT siblings. */
> > > > +
> > > > +       if (sg_is_smt) {
> > > > +               int local_busy_cpus = sds->local->group_weight -
> > > > +                                     sds->local_stat.idle_cpus;
> > > > +               int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
> > > > +
> > > > +               /* Local can always help to even the number busy CPUs. */
> > >
> > > default behavior of the load balance already tries to even the number
>  a> > of idle CPUs.
> >
> > Right, but I suppose this is because we're trapped here and have to deal
> > with the SMT-SMT case too. Ricardo, can you clarify?
> 
> IIUC, this function is used in sg_lb_stats to set
> sgs->group_asym_packing which is then used to set the group state to
> group_asym_packing and force asym migration.
> But if we only want to even the number of busy CPUs between the group,
> we should not need to set the group state to  group_asym_packing

Yes, what Vincent describe is the intent. Then, I think it is probably
true that it is not necessary to even the number of idle CPUs here.
> 
> >
> > > > +               if (busy_cpus_delta >= 2)
> > > > +                       return true;
> > > > +
> > > > +               if (busy_cpus_delta == 1)
> > > > +                       return sched_asym_prefer(dst_cpu,
> > > > +                                                sg->asym_prefer_cpu);

I think we should keep this check in order to move tasks to higher
priority CPUs.

> > > > +
> > > > +               return false;
> > > > +       }
> > > > +
> > > > +       /*
> > > > +        * @sg does not have SMT siblings. Ensure that @sds::local does not end
> > > > +        * up with more than one busy SMT sibling and only pull tasks if there
> > > > +        * are not busy CPUs. As CPUs move in and out of idle state frequently,
> > > > +        * also check the group utilization to smoother the decision.
> > > > +        */
> > > > +       if (!sds->local_stat.group_util)
> > >
> > > same comment as above about the meaning of group_util == 0

I will look into using the suggested statistics.

Thanks and BR,
Ricardo
