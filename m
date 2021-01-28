Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C583B307E90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 20:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhA1TCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 14:02:10 -0500
Received: from foss.arm.com ([217.140.110.172]:37758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232640AbhA1S6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:58:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 714D113A1;
        Thu, 28 Jan 2021 10:56:09 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 350863F719;
        Thu, 28 Jan 2021 10:56:07 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: Re: [RFC PATCH] sched/core: Fix premature p->migration_pending completion
In-Reply-To: <BN8PR12MB2978A9A4435A01EDC97D27E89ABA9@BN8PR12MB2978.namprd12.prod.outlook.com>
References: <20210127193035.13789-1-valentin.schneider@arm.com> <BN8PR12MB2978A9A4435A01EDC97D27E89ABA9@BN8PR12MB2978.namprd12.prod.outlook.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 28 Jan 2021 18:56:01 +0000
Message-ID: <jhj4kj028n2.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/21 01:02, Tao Zhou wrote:
> Hi,
>
> On Wed, Jan 27, 2021 at 07:30:35PM +0000, Valentin Schneider wrote:
>
>> Fiddling some more with a TLA+ model of set_cpus_allowed_ptr() & friends
>> unearthed one more outstanding issue. This doesn't even involve
>> migrate_disable(), but rather affinity changes and execution of the stopper
>> racing with each other.
>>
>> My own interpretation of the (lengthy) TLA+ splat (note the potential for
>> errors at each level) is:
>>
>>   Initial conditions:
>>     victim.cpus_mask = {CPU0, CPU1}
>>
>>   CPU0                             CPU1                             CPU<don't care>
>>
>>   switch_to(victim)
>>                                                                  set_cpus_allowed(victim, {CPU1})
>>                                                                    kick CPU0 migration_cpu_stop({.dest_cpu = CPU1})
>>   switch_to(stopper/0)
>>                                                                  // e.g. CFS load balance
>>                                                                  move_queued_task(CPU0, victim, CPU1);
>                                     ^^^^^^^^^^^^^^^^
>
> Why is move_queued_task() not attach_task()/detach_task() for CFS load..
>

Heh I expected that one; it is indeed detach_task()/attach_task() for CFS
LB. I didn't want to make this any longer than it needed to, and I figured
that move_queued_task() being a composition of detach_task(), attach_task() and
rq_locks, this would get the point across.

This does raise an "interesting" point that ATM I think this issue cannot
actually involve move_queued_task(), since all current move_queued_task()
callsites are issued either from a stopper or from set_cpus_allowed_ptr().

CFS' detach_task() + attach_task() could do it, though.

>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 06b449942adf..b57326b0a742 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1923,20 +1923,28 @@ static int migration_cpu_stop(void *data)
>>                      complete = true;
>>              }
>>
>> -		/* migrate_enable() --  we must not race against SCA */
>> -		if (dest_cpu < 0) {
>> -			/*
>> -			 * When this was migrate_enable() but we no longer
>> -			 * have a @pending, a concurrent SCA 'fixed' things
>> -			 * and we should be valid again. Nothing to do.
>> -			 */
>> -			if (!pending) {
>> -				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
>> -				goto out;
>> -			}
>> +	       /*
>> +		* When this was migrate_enable() but we no longer
>> +		* have a @pending, a concurrent SCA 'fixed' things
>> +		* and we should be valid again.
>> +		*
>> +		* This can also be a stopper invocation that was 'fixed' by an
>> +		* earlier one.
>> +		*
>> +		* Nothing to do.
>> +		*/
>> +		if ((dest_cpu < 0 || dest_cpu == cpu_of(rq)) && !pending) {
>
> When the condition 'dest_cpu == cpu_of(rq)' is true, pending is not NULL.
> The condition may be like this:
>
>     if ((dest_cpu < 0 && !pending) || dest_cpu == cpu_of(rq))
>
> We want to choose one cpu in the new(currently modified) cpu_mask and
> complete all.
>

Consider the execution of migration_cpu_stop() in above trace with
migrate_task_to(). We do have:
- dest_cpu == cpu_of(rq)
- p->migration_pending

but we do *not* want to bail out at this condition, because we need to fix
up dest_cpu.
