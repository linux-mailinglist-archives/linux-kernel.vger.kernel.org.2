Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD253B2B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhFXJfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:35:33 -0400
Received: from foss.arm.com ([217.140.110.172]:51546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhFXJfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:35:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B07481042;
        Thu, 24 Jun 2021 02:33:13 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41F6C3F718;
        Thu, 24 Jun 2021 02:33:12 -0700 (PDT)
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
In-Reply-To: <20210622135140.GA31071@willie-the-truck>
References: <20210526205751.842360-1-valentin.schneider@arm.com> <20210526205751.842360-3-valentin.schneider@arm.com> <87h7ihfrlf.mognet@arm.com> <20210602152629.GF31179@willie-the-truck> <87bl8of3x8.mognet@arm.com> <20210622135140.GA31071@willie-the-truck>
Date:   Thu, 24 Jun 2021 10:33:07 +0100
Message-ID: <87v9638v58.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/06/21 14:51, Will Deacon wrote:
> Hi Valentin,
>
> I've been looking at this on and off and I'm afraid I'm still not convinced,
> almost certainly due to my own ignorance, but hey :)
>

Nah, this thing is nasty, I still haven't regrown the hair I lost from last
time I stared at it.

> On Wed, Jun 02, 2021 at 08:43:31PM +0100, Valentin Schneider wrote:
>> Harumph...
>>
>> So something like all CPUs but one are running their take_cpu_down()
>> callback because one is still running migration_cpu_stop(), i.e.:
>>
>>   CPU0                   CPU1                ...             CPUN
>>   <stopper>              <stopper>                           <stopper>
>>     migration_cpu_stop()   take_cpu_down()@MULTI_STOP_PREPARE    take_cpu_down()@MULTI_STOP_PREPARE
>>
>> If CPU0 hits that else if (pending) condition, it'll queue a
>> migration_cpu_stop() elsewhere (say CPU1), then run the take_cpu_down()
>> callback which follows in its work->list.
>>
>> If the CPU being brought down is anything else than CPU1, it shouldn't
>> really matter. If it *is* CPU1, then I think we've got some guarantees.
>>
>> Namely, there's no (read: there shouldn't be any) way for a task to
>> still be on CPU1 at this point; per sched_cpu_wait_empty(),
>> migration-disabled tasks and pcpu kthreads must vacate the CPU before it
>> then (migrate_disable regions must be bounded, and pcpu kthreads are
>> expected to be moved away by their respective owners).
>
> I agree with that, but the stopper is still running on CPU1 and so
> migration_cpu_stop() could still queue work there after sched_cpu_wait_empty()
> has returned but before stop_machine_park(), afaict.
>

Right, the stopper should flush its work before parking itself - in the
above scenario migration_cpu_stop() is already on CPU1's work list when it
finishes running take_cpu_down(), so that should run before any parking
happens.

> Actually, it looks like migration_cpu_stop() ignores the return value of
> stop_one_cpu_nowait(), so if the stopper thread has been parked I think
> we'll quietly do nothing there as well.
>

There's a handful of loosely related cogs (including those added by the
patch) that *I think* give us sufficient guarantees this can't happen. Let
me try to structure this somehow, and please point out any inane bit.

1) Per the synchronize_rcu() in CPUHP_AP_ACTIVE.teardown(), the return
   value of is_cpu_allowed(p, cpu) is stable within a migration_cpu_stop()
   invocation for any p allowed on *active* CPUs.
2) Per the serialization of stopper callbacks, the return value of
   is_cpu_allowed(p, cpu) is stable within a migration_cpu_stop()
   invocation for any p allowed on *online* CPUs: migration_cpu_stop()
   has to complete before any CPU can do an online -> !online transition.

  (I would also add here that I don't expect any task to be migrated to an
  !active && online dying CPU via migration_cpu_stop(): the only tasks
  allowed on such CPUs are pcpu kthreads, which will be parked rather than
  migrated, and migrate_disabled() tasks which, unsurprisingly, aren't
  migrated - they just get to *stay* on their CPU longer than regular tasks)

3) Per 1) + 2), the move_queued_task() call in migration_cpu_stop() cannot
   silently fail.


4) No task other than a hotplug thread or a stopper thread may run on a
   CPU beyond CPUHP_AP_SCHED_WAIT_EMPTY.teardown()
5) Per 4), no (queued) task p passed to migration_cpu_stop() can have
   task_cpu(p) be a dying CPU with hotplug state below
   CPUHP_AP_SCHED_WAIT_EMPTY.
6) Per 5), migration_cpu_stop() cannot invoke stop_one_cpu_nowait() on a
   CPU with a parked stopper.
7) Per 6), migration_cpu_stop() self-queuing cannot be silently discarded
   and will always end up executed

Per 3) + 7), we're good?
