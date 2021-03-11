Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862B6337974
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhCKQdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhCKQdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:33:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5F6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 08:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tr4GBE5MFA92zo82h4paz2mI4PSLW6cYH8JluPP0CR8=; b=SF8NI3bBDGDIhT9auQBE9A0VIw
        NaXNo7W5jsWmsBPrRVirc3kxt7bSrvWs2BTlErXkRhHqFOsMqpyc1mmigJzGYRd78InETQgboCF83
        gqAtlEF2EIZ0uLbOwaKCxyqHS2yE28hRf5/MLzJpb9zf+XhEQqUkJfWItnSZQIl0Mn7Sjm6YKRqj8
        6oWgoRAlEVx+Nq6ytQl7FHlMCsjGtjtpz6YEKTG3ZbMeLeS//DWeORlRw3PjJHqfJ/CxV7fBzAqe3
        IItw2J7ajherRLzhwBEevUUVf476x9wMeXJD3x3j3g3UG13Aw2qWiYWNIg0l0+kfAi3eviguXo1+u
        +1i67ftQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKOF0-009a3G-Qw; Thu, 11 Mar 2021 16:32:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24FCB300455;
        Thu, 11 Mar 2021 17:32:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12A3529E5D627; Thu, 11 Mar 2021 17:32:50 +0100 (CET)
Date:   Thu, 11 Mar 2021 17:32:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V2 20/25] perf/x86/intel: Add Alder Lake Hybrid support
Message-ID: <YEpGMm2xnfbxDZpp@hirez.programming.kicks-ass.net>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
 <1615394281-68214-21-git-send-email-kan.liang@linux.intel.com>
 <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEpAtTttSxMVDWYp@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 05:09:25PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 10, 2021 at 08:37:56AM -0800, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Alder Lake Hybrid system has two different types of core, Golden Cove
> > core and Gracemont core. The Golden Cove core is registered to
> > "cpu_core" PMU. The Gracemont core is registered to "cpu_atom" PMU.
> > 
> > The difference between the two PMUs include:
> > - Number of GP and fixed counters
> > - Events
> > - The "cpu_core" PMU supports Topdown metrics.
> >   The "cpu_atom" PMU supports PEBS-via-PT.
> > 
> > The "cpu_core" PMU is similar to the Sapphire Rapids PMU, but without
> > PMEM.
> > The "cpu_atom" PMU is similar to Tremont, but with different
> > event_constraints, extra_regs and number of counters.
> > 
> 
> > +		/* Initialize big core specific PerfMon capabilities.*/
> > +		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
> > +		pmu->name = "cpu_core";
> 
> > +		/* Initialize Atom core specific PerfMon capabilities.*/
> > +		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
> > +		pmu->name = "cpu_atom";
> 
> So do these things use the same event lists as SPR and TNT? Is there any
> way to discover that, because AFAICT /proc/cpuinfo will say every CPU
> is 'Alderlake', and the above also doesn't give any clue.
> 
> FWIW, ARM big.LITTLE does discriminate in its /proc/cpuinfo, but I'm not
> entirely sure it's really useful. Mark said perf userspace uses
> somethink akin to our CPUID, except exposed through sysfs, to find the
> event lists.
> 
> My desktop has: cpu/caps/pmu_name and that gives "skylake", do we want
> the above to have cpu_core/caps/pmu_name give "sapphire_rapids" etc.. ?

FWIW, "Tremont" is the only pmu_name with a capital :-( I don't suppose
we can still fix that?
