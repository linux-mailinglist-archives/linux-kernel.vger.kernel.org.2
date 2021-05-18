Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD98388054
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 21:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbhERTND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 15:13:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:27653 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237158AbhERTNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 15:13:02 -0400
IronPort-SDR: gLnCtBRxzprdP3A9vmRXbZ2NiOxQXyOPRTmQt5z1rlbnvABa1qs/m3kFgL8PB2btFSX0mt2pGv
 wDgok45v6/Jg==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="188204657"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="188204657"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 12:11:29 -0700
IronPort-SDR: Oy/DYjgEn0wFps9s1XM+TzK+IBDVccQCVmCc/glFBWPHnP6kDaVtbKEm2JxFrltlYh98jZ8Bwx
 95LkY064NwmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="473956127"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 18 May 2021 12:11:28 -0700
Date:   Tue, 18 May 2021 12:10:39 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <20210518191039.GB15251@ranerica-svr.sc.intel.com>
References: <20210513154909.6385-1-ricardo.neri-calderon@linux.intel.com>
 <20210513154909.6385-6-ricardo.neri-calderon@linux.intel.com>
 <3e346f3d-45c4-bd8c-57d9-a11feda42834@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e346f3d-45c4-bd8c-57d9-a11feda42834@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 05:18:29PM +0200, Dietmar Eggemann wrote:
> On 13/05/2021 17:49, Ricardo Neri wrote:
> 
> [...]
> 
> > @@ -8447,6 +8456,89 @@ group_type group_classify(unsigned int imbalance_pct,
> >  	return group_has_spare;
> >  }
> >  
> > +/**
> > + * asym_can_pull_tasks - Check whether the load balancing CPU can pull tasks
> > + * @dst_cpu:	Destination CPU of the load balancing
> > + * @sds:	Load-balancing data with statistics of the local group
> > + * @sgs:	Load-balancing statistics of the candidate busiest group
> > + * @sg:		The candidate busiet group
> > + *
> > + * Check the state of the SMT siblings of both @sds::local and @sg and decide
> > + * if @dst_cpu can pull tasks. If @dst_cpu does not have SMT siblings, it can
> > + * pull tasks if two or more of the SMT siblings of @sg are busy. If only one
> > + * CPU in @sg is busy, pull tasks only if @dst_cpu has higher priority.
> > + *
> > + * If both @dst_cpu and @sg have SMT siblings. Even the number of idle CPUs
> > + * between @sds::local and @sg. Thus, pull tasks from @sg if the difference
> > + * between the number of busy CPUs is 2 or more. If the difference is of 1,
> > + * only pull if @dst_cpu has higher priority. If @sg does not have SMT siblings
> > + * only pull tasks if all of the SMT siblings of @dst_cpu are idle and @sg
> > + * has lower priority.
> > + */
> > +static bool asym_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> > +				struct sg_lb_stats *sgs, struct sched_group *sg)
> > +{
> > +#ifdef CONFIG_SCHED_SMT
> > +	int cpu, local_busy_cpus, sg_busy_cpus;
> > +	bool local_is_smt, sg_is_smt;
> > +
> > +	cpu = group_first_cpu(sg);
> 
> Looks like `cpu` isn't used.

Thank you very much for your feedback Dietmar!

Ah! That is correct. I will remove this variable.

Thanks and BR,
Ricardo
> 
> [...]
