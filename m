Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6383724A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 05:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEDDJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 23:09:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:60136 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhEDDJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 23:09:53 -0400
IronPort-SDR: pWkFdVKsbeZnY0L9/MQakgXp6K1EGRDu18oqMyCC8mX0gh+9QfMxtOIGbOFcLhMU0D3PD5PRHl
 NMT97l7pfOxQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="195832236"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="195832236"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 20:08:59 -0700
IronPort-SDR: jKpwLl465Zg81mZSn3JwczjUGk3mTvXEOnwrdozZaBGDFqv4z3RCLXk5qcI4NhLOV9A7voYGuX
 WZS7AVVQ0N8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="606852163"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2021 20:08:58 -0700
Date:   Mon, 3 May 2021 20:08:14 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2 1/4] sched/fair: Optimize checking for
 group_asym_packing
Message-ID: <20210504030814.GA31635@ranerica-svr.sc.intel.com>
References: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
 <20210414020436.12980-2-ricardo.neri-calderon@linux.intel.com>
 <YI/BSZ9OkOqCp/0F@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YI/BSZ9OkOqCp/0F@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 11:24:25AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 13, 2021 at 07:04:33PM -0700, Ricardo Neri wrote:
> > By checking local_group, we can avoid additional checks and invoking
> > sched_asmy_prefer() when it is not needed.
> 
> This really could do with a few words on *why* that is correct. ISTR
> thinking this made sense when I last looked at it, but today, after
> having the brain reset by not looking at a computer for 4 days its not
> immediate obvious anymore.

Thanks for your feedback Peter! I will add a comment explaining why this
is correct: when we are collecting statistics of the local group,
@env->dst_cpu belongs to @group. @env->dst_cpu may or may not be
@group->asym_prefer_cpu. If @env->dst_cpu, sched_asym_prefer() must return
false because it would be checking for

    arch_asym_cpu_priority(dst_cpu) >  arch_asym_cpu_priority(dst_cpu)

which is false. If @env->dst_cpu is not @group->env_prefer_cpu, it
implies that the former has lower prority than the latter and
sched_asym_prefer() will also return false.

Thanks and BR,
Ricardo

> 
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 04a3ce20da67..4ef3fa0d5e8d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8455,7 +8455,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >  	}
> >  
> >  	/* Check if dst CPU is idle and preferred to this group */
> > -	if (env->sd->flags & SD_ASYM_PACKING &&
> > +	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
> >  	    env->idle != CPU_NOT_IDLE &&
> >  	    sgs->sum_h_nr_running &&
> >  	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
> > -- 
> > 2.17.1
> > 
