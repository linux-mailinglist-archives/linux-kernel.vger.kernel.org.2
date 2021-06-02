Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B82F3993B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFBTp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:45:27 -0400
Received: from foss.arm.com ([217.140.110.172]:52998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhFBTpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:45:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B44521063;
        Wed,  2 Jun 2021 12:43:37 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46B793F774;
        Wed,  2 Jun 2021 12:43:36 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Will Deacon <will@kernel.org>
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
Subject: Re: [PATCH 2/2] sched: Plug race between SCA, hotplug and migration_cpu_stop()
In-Reply-To: <20210602152629.GF31179@willie-the-truck>
References: <20210526205751.842360-1-valentin.schneider@arm.com> <20210526205751.842360-3-valentin.schneider@arm.com> <87h7ihfrlf.mognet@arm.com> <20210602152629.GF31179@willie-the-truck>
Date:   Wed, 02 Jun 2021 20:43:31 +0100
Message-ID: <87bl8of3x8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/21 16:26, Will Deacon wrote:
> On Tue, Jun 01, 2021 at 05:59:56PM +0100, Valentin Schneider wrote:
>> On 26/05/21 21:57, Valentin Schneider wrote:
>> > +		dest_cpu = arg->dest_cpu;
>> > +		if (task_on_rq_queued(p)) {
>> > +			/*
>> > +			 * A hotplug operation could have happened between
>> > +			 * set_cpus_allowed_ptr() and here, making dest_cpu no
>> > +			 * longer allowed.
>> > +			 */
>> > +			if (!is_cpu_allowed(p, dest_cpu))
>> > +				dest_cpu = select_fallback_rq(cpu_of(rq), p);
>> > +			/*
>> > +			 * dest_cpu can be victim of hotplug between is_cpu_allowed()
>> > +			 * and here. However, per the synchronize_rcu() in
>> > +			 * sched_cpu_deactivate(), it can't have gone lower than
>> > +			 * CPUHP_AP_ACTIVE, so it's safe to punt it over and let
>> > +			 * balance_push() route it elsewhere.
>> > +			 */
>> > +			update_rq_clock(rq);
>> > +			rq = move_queued_task(rq, &rf, p, dest_cpu);
>>
>> So, while digesting this I started having doubts vs pcpu kthreads since
>> they're allowed on online CPUs. The bogus scenario here would be picking a
>> !active && online CPU, and see it go !online before the move_queued_task().
>>
>> Now, to transition from online -> !online, we have to go through
>> take_cpu_down() which is issued via a stop_machine() call. This means the
>> transition can't happen until all online CPUs are running the stopper task
>> and reach MULTI_STOP_RUN.
>>
>> migration_cpu_stop() being already a stopper callback should thus make it
>> "atomic" vs takedown_cpu(), meaning the above should be fine.
>
> I'd be more inclined to agree with your reasoning if migration_cpu_stop()
> couldn't itself call stop_one_cpu_nowait() to queue more work for the
> stopper thread. What guarantees that takedown_cpu() can't queue its stopper
> work in the middle of that?
>

Harumph...

So something like all CPUs but one are running their take_cpu_down()
callback because one is still running migration_cpu_stop(), i.e.:

  CPU0                   CPU1                ...             CPUN
  <stopper>              <stopper>                           <stopper>
    migration_cpu_stop()   take_cpu_down()@MULTI_STOP_PREPARE    take_cpu_down()@MULTI_STOP_PREPARE

If CPU0 hits that else if (pending) condition, it'll queue a
migration_cpu_stop() elsewhere (say CPU1), then run the take_cpu_down()
callback which follows in its work->list.

If the CPU being brought down is anything else than CPU1, it shouldn't
really matter. If it *is* CPU1, then I think we've got some guarantees.

Namely, there's no (read: there shouldn't be any) way for a task to
still be on CPU1 at this point; per sched_cpu_wait_empty(),
migration-disabled tasks and pcpu kthreads must vacate the CPU before it
then (migrate_disable regions must be bounded, and pcpu kthreads are
expected to be moved away by their respective owners).

With the above, I don't really see how migration_cpu_stop() could queue
itself again on an about-to-die CPU (thus racing with the take_cpu_down()
callback), and even if it did, then we'd still run the callback before
parking the stopper thread (no surprise callback persisting during
offline), in which case we'd either see the task as having moved somewhere
sensible, or we'll queue yet another callback.


I've lost track of how many times I rewrote the above, so it's probably to
be taken with a healthy pinch of salt.

> Will
