Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891C83B0636
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhFVNyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhFVNyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:54:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 976D361363;
        Tue, 22 Jun 2021 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624369906;
        bh=EIxfbfEg1HQQFiuv3Jaw3D2aNsSQzOEzYeGe/1N7ulU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdSfYpEYJ6dO2WISawBmvvmoCu6D0SZIkdcB6QvneSXC54Z1COG7+GMAM6cMWmJXO
         qj86JA/5jNCAnXIoCMzwGNiLkxMcTwkgNbZvxE+5ZdiCS7eZNOOJ473y6Llb6j3+JH
         zTpaA1ljPgmhsySeEel+TvkeLZnj3k1qjPCN3M1ApZLlEncmOsQTXfxniFk5vRxaP3
         d0NgrNHRyfFN1t8bIvRxOWcCT3HN9DllGrXW0Q9Yz8V+p482guEwgoLrvFmY697ti/
         EGeJEjA+U5kfE1jEFF70WmQIdoJc0nZt4CmLCCk2klrRvrABJj/21dyT54LYz8BnBP
         KxAwGhSYw6U5Q==
Date:   Tue, 22 Jun 2021 14:51:41 +0100
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
Message-ID: <20210622135140.GA31071@willie-the-truck>
References: <20210526205751.842360-1-valentin.schneider@arm.com>
 <20210526205751.842360-3-valentin.schneider@arm.com>
 <87h7ihfrlf.mognet@arm.com>
 <20210602152629.GF31179@willie-the-truck>
 <87bl8of3x8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl8of3x8.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

I've been looking at this on and off and I'm afraid I'm still not convinced,
almost certainly due to my own ignorance, but hey :)

On Wed, Jun 02, 2021 at 08:43:31PM +0100, Valentin Schneider wrote:
> On 02/06/21 16:26, Will Deacon wrote:
> > On Tue, Jun 01, 2021 at 05:59:56PM +0100, Valentin Schneider wrote:
> >> On 26/05/21 21:57, Valentin Schneider wrote:
> >> > +		dest_cpu = arg->dest_cpu;
> >> > +		if (task_on_rq_queued(p)) {
> >> > +			/*
> >> > +			 * A hotplug operation could have happened between
> >> > +			 * set_cpus_allowed_ptr() and here, making dest_cpu no
> >> > +			 * longer allowed.
> >> > +			 */
> >> > +			if (!is_cpu_allowed(p, dest_cpu))
> >> > +				dest_cpu = select_fallback_rq(cpu_of(rq), p);
> >> > +			/*
> >> > +			 * dest_cpu can be victim of hotplug between is_cpu_allowed()
> >> > +			 * and here. However, per the synchronize_rcu() in
> >> > +			 * sched_cpu_deactivate(), it can't have gone lower than
> >> > +			 * CPUHP_AP_ACTIVE, so it's safe to punt it over and let
> >> > +			 * balance_push() route it elsewhere.
> >> > +			 */
> >> > +			update_rq_clock(rq);
> >> > +			rq = move_queued_task(rq, &rf, p, dest_cpu);
> >>
> >> So, while digesting this I started having doubts vs pcpu kthreads since
> >> they're allowed on online CPUs. The bogus scenario here would be picking a
> >> !active && online CPU, and see it go !online before the move_queued_task().
> >>
> >> Now, to transition from online -> !online, we have to go through
> >> take_cpu_down() which is issued via a stop_machine() call. This means the
> >> transition can't happen until all online CPUs are running the stopper task
> >> and reach MULTI_STOP_RUN.
> >>
> >> migration_cpu_stop() being already a stopper callback should thus make it
> >> "atomic" vs takedown_cpu(), meaning the above should be fine.
> >
> > I'd be more inclined to agree with your reasoning if migration_cpu_stop()
> > couldn't itself call stop_one_cpu_nowait() to queue more work for the
> > stopper thread. What guarantees that takedown_cpu() can't queue its stopper
> > work in the middle of that?
> >
> 
> Harumph...
> 
> So something like all CPUs but one are running their take_cpu_down()
> callback because one is still running migration_cpu_stop(), i.e.:
> 
>   CPU0                   CPU1                ...             CPUN
>   <stopper>              <stopper>                           <stopper>
>     migration_cpu_stop()   take_cpu_down()@MULTI_STOP_PREPARE    take_cpu_down()@MULTI_STOP_PREPARE
> 
> If CPU0 hits that else if (pending) condition, it'll queue a
> migration_cpu_stop() elsewhere (say CPU1), then run the take_cpu_down()
> callback which follows in its work->list.
> 
> If the CPU being brought down is anything else than CPU1, it shouldn't
> really matter. If it *is* CPU1, then I think we've got some guarantees.
> 
> Namely, there's no (read: there shouldn't be any) way for a task to
> still be on CPU1 at this point; per sched_cpu_wait_empty(),
> migration-disabled tasks and pcpu kthreads must vacate the CPU before it
> then (migrate_disable regions must be bounded, and pcpu kthreads are
> expected to be moved away by their respective owners).

I agree with that, but the stopper is still running on CPU1 and so
migration_cpu_stop() could still queue work there after sched_cpu_wait_empty()
has returned but before stop_machine_park(), afaict.

Actually, it looks like migration_cpu_stop() ignores the return value of
stop_one_cpu_nowait(), so if the stopper thread has been parked I think
we'll quietly do nothing there as well.

> With the above, I don't really see how migration_cpu_stop() could queue
> itself again on an about-to-die CPU (thus racing with the take_cpu_down()
> callback), and even if it did, then we'd still run the callback before
> parking the stopper thread (no surprise callback persisting during
> offline), in which case we'd either see the task as having moved somewhere
> sensible, or we'll queue yet another callback.

In this case, I think we'd run the migration_cpu_stop() callback, but
then __migrate_task() would fail to move the task because the CPU would
be !online.

Will
