Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44158398E89
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhFBP2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhFBP2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:28:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4C5761360;
        Wed,  2 Jun 2021 15:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622647594;
        bh=LHNYE6qLEHTjBMpXd1FFTxXKp/FfRkEJFT/IqvjWcK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOSS4IAArR7BGlZgoGDjTz79THCDczQ2h/gaiMzFJIsBqOlbPE8NyhxfKFjAYKj5e
         E5Q2LiuAEHXnUyHHi0Xh6PXIAl2B4ZDbCQFbppd6mwAeQN2VhEKeeRqSQqBpEniZr8
         gQ/8A2D1P2IFA+LjJX9389rvV//yB8G8y4wqRAJrt7bU1TdfCBDvSqwq33iecg0YdC
         ubVW/JUjYANrfn+Vi37BJn/YhxEEk+MmFYXUVOW61zL9O/uQJUBsnDCu+WB9wS3wgU
         MUoRdRBeKfrucwyssOc0blDSjGAcUYVscwh/+Fd3M5y6hYsfarpplNECFtLiE2ld81
         TSu9BMK7cwuiw==
Date:   Wed, 2 Jun 2021 16:26:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH 2/2] sched: Plug race between SCA, hotplug and
 migration_cpu_stop()
Message-ID: <20210602152629.GF31179@willie-the-truck>
References: <20210526205751.842360-1-valentin.schneider@arm.com>
 <20210526205751.842360-3-valentin.schneider@arm.com>
 <87h7ihfrlf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7ihfrlf.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 05:59:56PM +0100, Valentin Schneider wrote:
> On 26/05/21 21:57, Valentin Schneider wrote:
> > +		dest_cpu = arg->dest_cpu;
> > +		if (task_on_rq_queued(p)) {
> > +			/*
> > +			 * A hotplug operation could have happened between
> > +			 * set_cpus_allowed_ptr() and here, making dest_cpu no
> > +			 * longer allowed.
> > +			 */
> > +			if (!is_cpu_allowed(p, dest_cpu))
> > +				dest_cpu = select_fallback_rq(cpu_of(rq), p);
> > +			/*
> > +			 * dest_cpu can be victim of hotplug between is_cpu_allowed()
> > +			 * and here. However, per the synchronize_rcu() in
> > +			 * sched_cpu_deactivate(), it can't have gone lower than
> > +			 * CPUHP_AP_ACTIVE, so it's safe to punt it over and let
> > +			 * balance_push() route it elsewhere.
> > +			 */
> > +			update_rq_clock(rq);
> > +			rq = move_queued_task(rq, &rf, p, dest_cpu);
> 
> So, while digesting this I started having doubts vs pcpu kthreads since
> they're allowed on online CPUs. The bogus scenario here would be picking a
> !active && online CPU, and see it go !online before the move_queued_task().
> 
> Now, to transition from online -> !online, we have to go through
> take_cpu_down() which is issued via a stop_machine() call. This means the
> transition can't happen until all online CPUs are running the stopper task
> and reach MULTI_STOP_RUN.
> 
> migration_cpu_stop() being already a stopper callback should thus make it
> "atomic" vs takedown_cpu(), meaning the above should be fine.

I'd be more inclined to agree with your reasoning if migration_cpu_stop()
couldn't itself call stop_one_cpu_nowait() to queue more work for the
stopper thread. What guarantees that takedown_cpu() can't queue its stopper
work in the middle of that?

Will
