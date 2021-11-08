Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED7344817F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbhKHOYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbhKHOX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:23:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EAFC0613F5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 06:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xmXlf3SMHKf2Jf9ppr2fljTFcDzPGdxH5LWVioGEiI8=; b=u5+e3GO0NacEGFardo3PziNuIs
        vOKbYUSNjX17VDF42F5N+C+Q0CRLpOeiPc+0sz4Sp9G0jiYH/kdmSfZePiUfYAe5YjiZTReC/zYHq
        3TUChBS7d6FH3f2ahx82/a9ne50cfmfeqPYsBuU3KXL3pyAnecFdBSKATiski+tLE5Sitb3SsUAb+
        SHhLT5CFDmEvAFgjj+/O7YnluK/WZYYdkDlncthhq6tpI2d2XH5TO2m4puO7x7H6PIDl2ZKCavFK0
        xw4ER3Se2eTD/gDmEIWwsqEzuUNYxdMDlfIB4LZzgksUN7Y5RjF0KPVZbsaiCMR1SRal4JdlhRRUC
        EOSo1OfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mk5WE-000FKR-Fb; Mon, 08 Nov 2021 14:21:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B92EE30030B;
        Mon,  8 Nov 2021 15:21:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5BE2202A0130; Mon,  8 Nov 2021 15:21:05 +0100 (CET)
Date:   Mon, 8 Nov 2021 15:21:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Srinivasan, Sadagopan" <Sadagopan.Srinivasan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <YYkyUT5etDBBjfIE@hirez.programming.kicks-ass.net>
References: <20211028130305.GS3959@techsingularity.net>
 <YYkGkx+Wq6Ol2N9i@hirez.programming.kicks-ass.net>
 <20211108115948.GH3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108115948.GH3959@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 11:59:48AM +0000, Mel Gorman wrote:
> On Mon, Nov 08, 2021 at 12:14:27PM +0100, Peter Zijlstra wrote:
> > On Thu, Oct 28, 2021 at 02:03:05PM +0100, Mel Gorman wrote:
> > 
> > > @@ -1926,8 +1926,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
> > >  		src_running = env->src_stats.nr_running - 1;
> > >  		dst_running = env->dst_stats.nr_running + 1;
> > >  		imbalance = max(0, dst_running - src_running);
> > > -		imbalance = adjust_numa_imbalance(imbalance, dst_running,
> > > -							env->dst_stats.weight);
> > > +		imbalance = adjust_numa_imbalance(imbalance, env->dst_cpu,
> > > +					dst_running, env->dst_stats.weight);
> > 
> > Can we please align at (0 ?
> > 
> 
> i.e.
> 		imbalance = adjust_numa_imbalance(imbalance, env->dst_cpu,
> 						  dst_running,
> 						  env->dst_stats.weight);
> 
> ?

Yep. For those using vim: :set cino=(0:0

Might as well clean that up while we touch the thing anyway.

> > >  
> > >  		/* Use idle CPU if there is no imbalance */
> > >  		if (!imbalance) {
> > 
> > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > index 4e8698e62f07..08fb02510967 100644
> > > --- a/kernel/sched/topology.c
> > > +++ b/kernel/sched/topology.c
> > > @@ -644,6 +644,7 @@ static void destroy_sched_domains(struct sched_domain *sd)
> > >  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
> > >  DEFINE_PER_CPU(int, sd_llc_size);
> > >  DEFINE_PER_CPU(int, sd_llc_id);
> > > +DEFINE_PER_CPU(int, sd_numaimb_shift);
> > 
> > Why does it make sense for this to be a per-cpu variable? Yes, I suppose
> > people can get creative with cpusets, but what you're trying to capture
> > seems like a global system propery, no?
> > 
> 
> I thought things might get weird around CPU hotplug and as llc_size was
> tracked per-cpu, I thought it made sense to also do it for
> sd_numaimb_shift.

Ah, there were performance arguments for llc_id (saves a bunch of
indirections trying to look up the LLC domain) and llc_size IIRC. While
in this case, the user actually has a struct sched_domain handy.


> > I'm thinking you can perhaps use something like:
> > 
> > 	if (!(sd->flags & SD_SHARE_PKG_RESROUCES) &&
> > 	    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > 
> > 		/* this is the first domain not sharing LLC */
> > 		sd->new_magic_imb = /*  magic incantation goes here */
> > 	}
> 
> Thanks, I'll give it a shot and see what I come up with, it'll probably
> take me a few days to clear my table of other crud to focus on it.

Sure thing.
