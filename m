Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2213109CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhBELGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:06:16 -0500
Received: from foss.arm.com ([217.140.110.172]:55830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhBELDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:03:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A4E1D6E;
        Fri,  5 Feb 2021 03:02:34 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 574763F73B;
        Fri,  5 Feb 2021 03:02:32 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [RFC PATCH] sched/core: Fix premature p->migration_pending completion
In-Reply-To: <20210204153040.qqkoa5sjztqeskoc@e107158-lin>
References: <20210127193035.13789-1-valentin.schneider@arm.com> <20210203172344.uzq2iod4g46ffame@e107158-lin> <jhjft2d2d1f.mognet@arm.com> <20210204153040.qqkoa5sjztqeskoc@e107158-lin>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Fri, 05 Feb 2021 11:02:27 +0000
Message-ID: <jhj1rdu3hh8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/21 15:30, Qais Yousef wrote:
> On 02/03/21 18:59, Valentin Schneider wrote:
>> On 03/02/21 17:23, Qais Yousef wrote:
>> > On 01/27/21 19:30, Valentin Schneider wrote:
>> >>   Initial conditions:
>> >>     victim.cpus_mask = {CPU0, CPU1}
>> >>
>> >>   CPU0                             CPU1                             CPU<don't care>
>> >>
>> >>   switch_to(victim)
>> >>                                                               set_cpus_allowed(victim, {CPU1})
>> >>                                                                 kick CPU0 migration_cpu_stop({.dest_cpu = CPU1})
>> >>   switch_to(stopper/0)
>> >>                                                               // e.g. CFS load balance
>> >>                                                               move_queued_task(CPU0, victim, CPU1);
>> >>                              switch_to(victim)
>> >>                                                               set_cpus_allowed(victim, {CPU0});
>> >>                                                                 task_rq_unlock();
>> >>   migration_cpu_stop(dest_cpu=CPU1)
>> >
>> > This migration stop is due to set_cpus_allowed(victim, {CPU1}), right?
>> >
>>
>> Right
>>
>> >>     task_rq(p) != rq && pending
>> >>       kick CPU1 migration_cpu_stop({.dest_cpu = CPU1})
>> >>
>> >>                              switch_to(stopper/1)
>> >>                              migration_cpu_stop(dest_cpu=CPU1)
>> >
>> > And this migration stop is due to set_cpus_allowed(victim, {CPU0}), right?
>> >
>>
>> Nein! This is a retriggering of the "current" stopper (triggered by
>> set_cpus_allowed(victim, {CPU1})), see the tail of that
>>
>>   else if (dest_cpu < 0 || pending)
>>
>> branch in migration_cpu_stop(), is what I'm trying to hint at with that
>>
>> task_rq(p) != rq && pending
>
> Okay I see. But AFAIU, the work will be queued in order. So we should first
> handle the set_cpus_allowed_ptr(victim, {CPU0}) before the retrigger, no?
>
> So I see migration_cpu_stop() running 3 times
>
>       1. because of set_cpus_allowed(victim, {CPU1}) on CPU0
>       2. because of set_cpus_allowed(victim, {CPU0}) on CPU1
>       3. because of retrigger of '1' on CPU0
>

On that 'CPU<don't care>' lane, I intentionally included task_rq_unlock()
but not 'kick CPU1 migration_cpu_stop({.dest_cpu = CPU0})'. IOW, there is
nothing in that trace that queues a stopper work for 2. - it *will* happen
at some point, but harm will already have been done.

The migrate_task_to() example is potentially worse, because it doesn't rely
on which stopper work gets enqueued first - only that an extra affinity
change happens before the first stopper work grabs the pi_lock and completes.
