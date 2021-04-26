Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7F836B266
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhDZLgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:36:18 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:45247 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhDZLgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:36:17 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id EC017F850C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 12:35:34 +0100 (IST)
Received: (qmail 19014 invoked from network); 26 Apr 2021 11:35:34 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.248])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Apr 2021 11:35:34 -0000
Date:   Mon, 26 Apr 2021 12:35:33 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH 00/10] sched/fair: wake_affine improvements
Message-ID: <20210426113533.GD4239@techsingularity.net>
References: <20210422102326.35889-1-srikar@linux.vnet.ibm.com>
 <20210423082532.GA4239@techsingularity.net>
 <20210423103129.GH2633526@linux.vnet.ibm.com>
 <20210423123854.GC4239@techsingularity.net>
 <20210426103032.GI2633526@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210426103032.GI2633526@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 04:00:32PM +0530, Srikar Dronamraju wrote:
> * Mel Gorman <mgorman@techsingularity.net> [2021-04-23 13:38:55]:
> 
> Hi Mel,
> 
> > On Fri, Apr 23, 2021 at 04:01:29PM +0530, Srikar Dronamraju wrote:
> > > > The series also oopses a *lot* and didn't get through a run of basic
> > > > workloads on x86 on any of three machines. An example oops is
> > > > 
> > > 
> > > Can you pass me your failing config. I am somehow not been seeing this
> > > either on x86 or on Powerpc on multiple systems.
> > 
> > The machines have since moved onto testing something else (Rik's patch
> > for newidle) but the attached config should be close enough.
> > 
> > > Also if possible cat /proc/schedstat and cat
> > > /proc/sys/kernel/sched_domain/cpu0/domain*/name
> > > 
> > 
> > For the vanilla kernel
> > 
> > SMT
> > MC
> > NUMA
> 
> I was able to reproduce the problem and analyze why it would panic in
> cpus_share_cache.
> 
> In my patch(es), we have code snippets like this.
> 
> 	if (tsds->idle_core != -1) {
> 		if (cpumask_test_cpu(tsds->idle_core, p->cpus_ptr))
> 			return tsds->idle_core;
> 		return this_cpu;
> 	}
> 
> Here when we tested the idle_core and cpumask_test_cpu,
> tsds->idle_core may not have been -1; However by the time it returns,
> tsds->idle_core could be -1;
> 
> cpus_share_cpus() then tries to find sd_llc_id for -1 and crashes.
> 
> Its more easier to reproduce this on a machine with more cores in a
> LLC than say a Power10/Power9.  Hence we are hitting this more often
> on x86.
> 
> One way could be to save the idle_core to a local variable, but that
> negates the whole purpose since we may end up choosing a busy CPU.  I
> will find a way to fix this problem.
> 

As there is no locking that protects the variable, it's inherently
race-prone. A READ_ONCE to a local variable may be your only choice

-- 
Mel Gorman
SUSE Labs
