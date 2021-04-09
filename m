Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1BE35945B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhDIFOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:14:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:3014 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhDIFOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:14:39 -0400
IronPort-SDR: UeOJBiWJD3EXvZ7xCeIAwa3MFmFQbUBL/kMXoKeN8+mRb6YN7e51XZjbJT8F4DDe2GK8GUMbtr
 Wzn6sn6T+cSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="190491043"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="190491043"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 22:14:26 -0700
IronPort-SDR: x/UCBqiddqEFH6LPDXNCZrjRA1zH1PD4/T1dOslTk+J5c9N/OlDi9cuZHKe9dA/rU5HRZHGyEf
 ATofas7Jd4JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="381978473"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 08 Apr 2021 22:14:25 -0700
Date:   Thu, 8 Apr 2021 22:13:53 -0700
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
Message-ID: <20210409051353.GB26235@ranerica-svr.sc.intel.com>
References: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
 <20210406041108.7416-4-ricardo.neri-calderon@linux.intel.com>
 <YGxDcccJ1U9ru0kV@hirez.programming.kicks-ass.net>
 <20210406231751.GC27195@ranerica-svr.sc.intel.com>
 <YG7nMj8RxoyX9D3B@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG7nMj8RxoyX9D3B@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:21:22PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 06, 2021 at 04:17:51PM -0700, Ricardo Neri wrote:
> > On Tue, Apr 06, 2021 at 01:18:09PM +0200, Peter Zijlstra wrote:
> > > On Mon, Apr 05, 2021 at 09:11:07PM -0700, Ricardo Neri wrote:
> > > > +static bool cpu_group_is_smt(int cpu, struct sched_group *sg)
> > > > +{
> > > > +#ifdef CONFIG_SCHED_SMT
> > > > +	if (!static_branch_likely(&sched_smt_present))
> > > > +		return false;
> > > > +
> > > > +	if (sg->group_weight == 1)
> > > > +		return false;
> > > > +
> > > > +	if (cpumask_weight(cpu_smt_mask(cpu)) == 1)
> > > > +		return false;
> > > 
> > > Please explain this condition. Why is it required?
> > 
> > Thank you for your quick review Peter!
> > 
> > Probably this is not required since the previous check verifies the
> > group weight, and the subsequent check makes sure that @sg matches the
> > SMT siblings of @cpu.
> 
> So the thing is that cpumask_weight() can be fairly expensive, depending
> on how large the machine is.
> 
> Now I suppose this mixing of SMT and !SMT cores is typical for 'small'
> machines (for now), but this is enabled for everything with ITMT on,
> which might very well include large systems.
> 
> So yes, if it can go away, that'd be good.

Sure Peter, I think this check can be removed. I'll post a v2 with the
updates.

Thanks and BR,
Ricardo
