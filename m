Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A6D44AFD1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 15:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhKIO7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 09:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbhKIO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 09:59:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14F1C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 06:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TE5nwlTvkafC/RL3ZP05CpG0F4N27gWH3FYNvovOc/g=; b=nLXk2YUTsdjac/qXWxPpCHKBol
        0UJMm/kHZi4Z7lA1PKKtlrrxzcT2do3HHqIVfXegE0TsmDhFlBUTWxT7UxhH27Ow/BBp08dg2dFsc
        ImeCHZpnvZYofyVPr8HEMgiJ4vGTCTWmB/bx3Z8OB+9B/dqR79ukERrwjkkzp9CCyNWDyHnAvzeaf
        MiQ5UYaX/SRJI4N6HPU9fr41JF9Hkpss4QlCRhwaX1/cu6Mf4POASOR3pehNRWkVtUQhUSffBF9qG
        ndYiXd2NJJb0fPsoIIROUU5fLvYxTlxmGuVbY3b80PlVrfL1twwwcs+gdNCymZ6CCg0XkCiNJVBXI
        rP9z5xqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkSY9-0016rd-JC; Tue, 09 Nov 2021 14:56:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FB4F3001C7;
        Tue,  9 Nov 2021 15:56:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41D732D92505C; Tue,  9 Nov 2021 15:56:36 +0100 (CET)
Date:   Tue, 9 Nov 2021 15:56:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Resend PATCH] psi : calc cfs task memstall time more precisely
Message-ID: <YYqMJLXcQ4a+Lh/4@hirez.programming.kicks-ass.net>
References: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
 <YYGV1TxsZXzGXFmx@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYGV1TxsZXzGXFmx@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 03:47:33PM -0400, Johannes Weiner wrote:
> CC peterz as well for rt and timekeeping magic
> 
> On Fri, Oct 15, 2021 at 02:16:52PM +0800, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > 
> > In an EAS enabled system, there are two scenarios discordant to current design,
> > 
> > 1. workload used to be heavy uneven among cores for sake of scheduler policy.
> > RT task usually preempts CFS task in little core.
> > 2. CFS task's memstall time is counted as simple as exit - entry so far, which
> > ignore the preempted time by RT, DL and Irqs.

It ignores preemption full-stop. I don't see why RT/IRQ should be
special cased here.

> > With these two constraints, the percpu nonidle time would be mainly consumed by
> > none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
> > via the proportion of cfs_rq's utilization on the whole rq.


> > +static unsigned long psi_memtime_fixup(u32 growth)
> > +{
> > +	struct rq *rq = task_rq(current);
> > +	unsigned long growth_fixed = (unsigned long)growth;
> > +
> > +	if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
> > +		return growth_fixed;
> > +
> > +	if (current->in_memstall)
> > +		growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
> > +					- rq->avg_irq.util_avg + 1) * growth, 1024);
> > +
> > +	return growth_fixed;
> > +}
> > +
> >  static void init_triggers(struct psi_group *group, u64 now)
> >  {
> >  	struct psi_trigger *t;
> > @@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
> >  	}
> >  
> >  	if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
> > +		delta = psi_memtime_fixup(delta);
> 
> Ok, so we want to deduct IRQ and RT preemption time from the memstall
> period of an active reclaimer, since it's technically not stalled on
> memory during this time but on CPU.
> 
> However, we do NOT want to deduct IRQ and RT time from memstalls that
> are sleeping on refaults swapins, since they are not affected by what
> is going on on the CPU.

I think that focus on RT/IRQ is mis-guided here, and the implementation
is horrendous.

So the fundamental question seems to be; and I think Johannes is the one
to answer that: What time-base do these metrics want to use?

Do some of these states want to account in task-time instead of
wall-time perhaps? I can't quite remember, but vague memories are
telling me most of the PSI accounting was about blocked tasks, not
running tasks, which makes all this rather more complicated.

Randomly scaling time as proposed seems almost certainly wrong. What
would that make the stats mean?
