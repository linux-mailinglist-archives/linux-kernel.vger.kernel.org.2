Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2B135945A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhDIFNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:13:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:31444 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhDIFNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:13:15 -0400
IronPort-SDR: NbeFeUw4HUyz2ggtTVyNEopxg9hUCtt5LqTk5QNWWbHb4HN7aOMxWCGTerOe8HAHuwquUedPh1
 ZfL3+0JLjujQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="257673811"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="257673811"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 22:13:02 -0700
IronPort-SDR: rbgT0gN7+2TVPn01u19GTId7nd/D30ej9gmrOIQyy+7IYckVCbbwh5OMx3FUHKN3LAH4cRHD/X
 ODLgoKOMphUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="419403484"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 08 Apr 2021 22:13:01 -0700
Date:   Thu, 8 Apr 2021 22:12:29 -0700
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
Message-ID: <20210409051229.GA26235@ranerica-svr.sc.intel.com>
References: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
 <20210406041108.7416-4-ricardo.neri-calderon@linux.intel.com>
 <YGxDSMorjMADJGIT@hirez.programming.kicks-ass.net>
 <20210406231710.GB27195@ranerica-svr.sc.intel.com>
 <YG7kr0Gyj86sMBF8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG7kr0Gyj86sMBF8@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:10:39PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 06, 2021 at 04:17:10PM -0700, Ricardo Neri wrote:
> > On Tue, Apr 06, 2021 at 01:17:28PM +0200, Peter Zijlstra wrote:
> > > On Mon, Apr 05, 2021 at 09:11:07PM -0700, Ricardo Neri wrote:
> > > > @@ -8507,6 +8619,10 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> > > >  	if (!sgs->sum_h_nr_running)
> > > >  		return false;
> > > >  
> > > > +	if (sgs->group_type == group_asym_packing &&
> > > > +	    !asym_can_pull_tasks(env->dst_cpu, sds, sgs, sg))
> > > > +		return false;
> > > 
> > > All of this makes my head hurt; but afaict this isn't right.
> > > 
> > > Your update_sg_lb_stats() change makes that we unconditionally set
> > > sgs->group_asym_packing, and then this is to undo that. But it's not
> > > clear this covers all cases right.
> > 
> > We could not make a decision to set sgs->group_asym_packing in
> > update_sg_lb_stats() because we don't have information about the dst_cpu
> > and its SMT siblings if any. That is the reason I proposed to delay the
> > decision to update_sd_pick_busiest(), where we can compare local and
> > sgs.
> 
> Yeah, I sorta got that.
> 
> > > Even if !sched_asym_prefer(), we could end up selecting this sg as
> > > busiest, but you're just bailing out here.
> > 
> > Even if sgs->group_asym_packing is unconditionally set, sgs can still
> > be classified as group_overloaded and group_imbalanced. In such cases
> > we wouldn't bailout. sgs could not be classified as group_fully_busy
> > or group_has_spare and we would bailout, though. Is your concern about
> > these? I can fixup these two cases.
> 
> Yes. Either explain (in a comment) why those cases are not relevant, or
> handle them properly.
> 
> Because when reading this, it wasn't at all obvious that this is correct
> or as intended.

Sure Peter, I will post a v2 handling the remaining cases properly.

Thanks and BR,
Ricardo
