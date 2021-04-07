Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A335692F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350812AbhDGKPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbhDGKPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:15:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0CCC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 03:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t7wWkut1jVIUYVgh1lajQt2elv3fSmdJWkrdvlDVH9Y=; b=ojgQfL1/WPhIFR70VsCXSYvPbJ
        0uGeHs1Vi06xsopqNfo1K3M60sx13oPOM2lc1HpnLbLiwZ60smFlgM1l79HzRrZIhcTJ9Wf9T8UsJ
        6PWWYm49AVHFpT0jJjIavRL9ue7b5H8fe2aR8kGN4KsABQC8ayw4JvjCprmZVDwPI+OrLvROMAC6a
        +P+b+9RVpqR6vSMTj2Q+588tcXftQQ3VAo5mw0npgc1HvScnl/85Z7h5QKDwOeBR8ZP+ceJm+AhPG
        9Ye08jSRbPOWZkRFUaja6bAe8QX7nYhGunHIe0kTrEvlG7kw0SvtsCTrpiQlP4tvgnuL0IVjRL7YE
        OHy8vitA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU5DO-004heK-2h; Wed, 07 Apr 2021 10:15:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A9BF30005A;
        Wed,  7 Apr 2021 12:15:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DDF224403D94; Wed,  7 Apr 2021 12:15:13 +0200 (CEST)
Date:   Wed, 7 Apr 2021 12:15:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but
 differently
Message-ID: <YG2GMW0EjsqqnET6@hirez.programming.kicks-ass.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
 <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com>
 <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
 <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net>
 <20210407094106.GC3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407094106.GC3697@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 10:41:06AM +0100, Mel Gorman wrote:

> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6112,6 +6112,27 @@ static int select_idle_core(struct task_
> >  	return -1;
> >  }
> >  
> > +/*
> > + * Scan the local SMT mask for idle CPUs.
> > + */
> > +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> > +{
> > +	int cpu;
> > +
> > +	if (!static_branch_likely(&sched_smt_present))
> > +		return -1;
> > +
> > +	for_each_cpu(cpu, cpu_smt_mask(target)) {
> > +		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> > +		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> > +			continue;
> 
> While I know that !cpumask_test_cpu(cpu, sched_domain_span(sd)) was
> done previously, I found it hard to believe that the test matters. If
> target/prev share a the LLC domain, why would the SMT siblings *not*
> share a LLC?

I think the reason for it is that a cpuset might have split the siblings
apart and disabled load-balancing across them or something.

Then the affinity mask can still cross the partition, but we shouldn't
ever move into it through balancing.
