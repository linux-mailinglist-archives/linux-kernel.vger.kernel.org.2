Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D71C358A18
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhDHQtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbhDHQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:49:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A019C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eDXuXfPu6U8PMFwNwxnixEWdq5QiK2WA+RHiex0w0R0=; b=Jcy0jEOihjj7N6dLrEsiR8UDdD
        AFKzRDKxypwaKFRzR+4F+jMvQtmBUL3MnjNggzkiGMlr73sN9iX8Of1eD6UTNzbTsEn4RV2FtMj5S
        u917LGQ9Jaho/RnJY5GXur2erLu2883a9VuhZov796cDdm7lCjOYrYxh9dohFWM0dhR2TWIRCSf9f
        tpR0sFv6Qtf+NNYO+I3Z5Mcv82rMz8/yOCG9LHwYoXrgO5K/18AHxmT8hpBFi60tOCKhqCGsUWN6H
        VxD/JAZI6geEVUJTXOpfkrjHCcxtxqSQ++g2icWkkiutGvDiHAysy35f8s7olIvv42x9x6zVLinHp
        Vhs/hXhw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUXnx-00GXdF-3J; Thu, 08 Apr 2021 16:47:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E832730015F;
        Thu,  8 Apr 2021 18:46:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A39EF2B71A279; Thu,  8 Apr 2021 13:21:22 +0200 (CEST)
Date:   Thu, 8 Apr 2021 13:21:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
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
Message-ID: <YG7nMj8RxoyX9D3B@hirez.programming.kicks-ass.net>
References: <20210406041108.7416-1-ricardo.neri-calderon@linux.intel.com>
 <20210406041108.7416-4-ricardo.neri-calderon@linux.intel.com>
 <YGxDcccJ1U9ru0kV@hirez.programming.kicks-ass.net>
 <20210406231751.GC27195@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406231751.GC27195@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 04:17:51PM -0700, Ricardo Neri wrote:
> On Tue, Apr 06, 2021 at 01:18:09PM +0200, Peter Zijlstra wrote:
> > On Mon, Apr 05, 2021 at 09:11:07PM -0700, Ricardo Neri wrote:
> > > +static bool cpu_group_is_smt(int cpu, struct sched_group *sg)
> > > +{
> > > +#ifdef CONFIG_SCHED_SMT
> > > +	if (!static_branch_likely(&sched_smt_present))
> > > +		return false;
> > > +
> > > +	if (sg->group_weight == 1)
> > > +		return false;
> > > +
> > > +	if (cpumask_weight(cpu_smt_mask(cpu)) == 1)
> > > +		return false;
> > 
> > Please explain this condition. Why is it required?
> 
> Thank you for your quick review Peter!
> 
> Probably this is not required since the previous check verifies the
> group weight, and the subsequent check makes sure that @sg matches the
> SMT siblings of @cpu.

So the thing is that cpumask_weight() can be fairly expensive, depending
on how large the machine is.

Now I suppose this mixing of SMT and !SMT cores is typical for 'small'
machines (for now), but this is enabled for everything with ITMT on,
which might very well include large systems.

So yes, if it can go away, that'd be good.
