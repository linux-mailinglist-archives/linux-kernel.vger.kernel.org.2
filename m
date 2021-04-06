Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47A1355F4C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 01:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbhDFXRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 19:17:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:17983 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236118AbhDFXRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:17:50 -0400
IronPort-SDR: ltDpjYSg7IUbNL7yUImVzjPtmWP8Dhe+mdvXnalDhqxb/4SNd2BFg+NTB05CavV9m8GGQ0bn/e
 a2y2XCC+Omog==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="192715476"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="192715476"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 16:17:42 -0700
IronPort-SDR: kuLm78UvGABZi2bp71p/ih6YiYOwDTZfPzaynHyQhGR1jLr4x0NASZI4PZ/1BeWNrWadgQCsEG
 J526yQUpyONw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="414999081"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 06 Apr 2021 16:17:40 -0700
Date:   Tue, 6 Apr 2021 16:17:10 -0700
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
Subject: Re: [PATCH 3/4] sched/fair: Consider SMT in ASYM_PACKING load balance
Message-ID: <20210406231710.GB27195@ranerica-svr.sc.intel.com>
References: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
 <20210406041108.7416-4-ricardo.neri-calderon@linux.intel.com>
 <YGxDSMorjMADJGIT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGxDSMorjMADJGIT@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 01:17:28PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 05, 2021 at 09:11:07PM -0700, Ricardo Neri wrote:
> > @@ -8507,6 +8619,10 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >  	if (!sgs->sum_h_nr_running)
> >  		return false;
> >  
> > +	if (sgs->group_type == group_asym_packing &&
> > +	    !asym_can_pull_tasks(env->dst_cpu, sds, sgs, sg))
> > +		return false;
> 
> All of this makes my head hurt; but afaict this isn't right.
> 
> Your update_sg_lb_stats() change makes that we unconditionally set
> sgs->group_asym_packing, and then this is to undo that. But it's not
> clear this covers all cases right.

We could not make a decision to set sgs->group_asym_packing in
update_sg_lb_stats() because we don't have information about the dst_cpu
and its SMT siblings if any. That is the reason I proposed to delay the
decision to update_sd_pick_busiest(), where we can compare local and
sgs.
> 
> Even if !sched_asym_prefer(), we could end up selecting this sg as
> busiest, but you're just bailing out here.

Even if sgs->group_asym_packing is unconditionally set, sgs can still
be classified as group_overloaded and group_imbalanced. In such cases
we wouldn't bailout. sgs could not be classified as group_fully_busy
or group_has_spare and we would bailout, though. Is your concern about
these? I can fixup these two cases.

Thanks and BR,
Ricardo
> 
