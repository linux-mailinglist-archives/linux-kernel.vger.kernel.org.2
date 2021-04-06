Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5932F355F4E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbhDFXSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 19:18:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:31810 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236097AbhDFXSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 19:18:31 -0400
IronPort-SDR: 6u204t4qKuwZmBaVxsuhMVg6yJfUhuNUWtw/eYWQl2wxzqPZfKfSfPXQNCgM0yQctLYYa8T9jV
 8cgQ99Zeg0CA==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="193221040"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="193221040"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 16:18:22 -0700
IronPort-SDR: lxOJWjXcqR/XY9W4EKiwmcEw9rjXHb0ObUh7ty8uOnvzd5sYGxlFECtMPNx1LCLZBicStTpI7A
 4KMI3A8kcCSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="414999327"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 06 Apr 2021 16:18:22 -0700
Date:   Tue, 6 Apr 2021 16:17:51 -0700
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
Message-ID: <20210406231751.GC27195@ranerica-svr.sc.intel.com>
References: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
 <20210406041108.7416-4-ricardo.neri-calderon@linux.intel.com>
 <YGxDcccJ1U9ru0kV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGxDcccJ1U9ru0kV@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 01:18:09PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 05, 2021 at 09:11:07PM -0700, Ricardo Neri wrote:
> > +static bool cpu_group_is_smt(int cpu, struct sched_group *sg)
> > +{
> > +#ifdef CONFIG_SCHED_SMT
> > +	if (!static_branch_likely(&sched_smt_present))
> > +		return false;
> > +
> > +	if (sg->group_weight == 1)
> > +		return false;
> > +
> > +	if (cpumask_weight(cpu_smt_mask(cpu)) == 1)
> > +		return false;
> 
> Please explain this condition. Why is it required?

Thank you for your quick review Peter!

Probably this is not required since the previous check verifies the
group weight, and the subsequent check makes sure that @sg matches the
SMT siblings of @cpu.

Thanks and BR,
Ricardo
