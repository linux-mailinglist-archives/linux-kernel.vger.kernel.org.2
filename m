Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AA935CF58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 19:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243915AbhDLRXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 13:23:05 -0400
Received: from foss.arm.com ([217.140.110.172]:56364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243299AbhDLRXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 13:23:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D43831B;
        Mon, 12 Apr 2021 10:22:46 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 582F93F73B;
        Mon, 12 Apr 2021 10:22:44 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs hotplug-rollback
In-Reply-To: <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net>
References: <20210310145258.899619710@infradead.org> <20210310150109.259726371@infradead.org> <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me> <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net>
Date:   Mon, 12 Apr 2021 18:22:42 +0100
Message-ID: <87r1jfmn8d.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/21 14:03, Peter Zijlstra wrote:
> On Thu, Mar 11, 2021 at 03:13:04PM +0000, Valentin Schneider wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>> > @@ -7910,6 +7908,14 @@ int sched_cpu_deactivate(unsigned int cp
>> >    }
>> >    rq_unlock_irqrestore(rq, &rf);
>> >
>> > +	/*
>> > +	 * From this point forward, this CPU will refuse to run any task that
>> > +	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
>> > +	 * push those tasks away until this gets cleared, see
>> > +	 * sched_cpu_dying().
>> > +	 */
>> > +	balance_push_set(cpu, true);
>> > +
>>
>> AIUI with cpu_dying_mask being flipped before even entering
>> sched_cpu_deactivate(), we don't need this to be before the
>> synchronize_rcu() anymore; is there more than that to why you're punting it
>> back this side of it?
>
> I think it does does need to be like this, we need to clearly separate
> the active=true and balance_push_set(). If we were to somehow observe
> both balance_push_set() and active==false, we'd be in trouble.
>

I'm afraid I don't follow; we're replacing a read of rq->balance_push with
cpu_dying(), and those are still written on the same side of the
synchronize_rcu(). What am I missing?

>> >  #ifdef CONFIG_SCHED_SMT
>> >    /*
>> >     * When going down, decrement the number of cores with SMT present.
>>
>> > @@ -8206,7 +8212,7 @@ void __init sched_init(void)
>> >            rq->sd = NULL;
>> >            rq->rd = NULL;
>> >            rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
>> > -		rq->balance_callback = NULL;
>> > +		rq->balance_callback = &balance_push_callback;
>> >            rq->active_balance = 0;
>> >            rq->next_balance = jiffies;
>> >            rq->push_cpu = 0;
>> > @@ -8253,6 +8259,7 @@ void __init sched_init(void)
>> >
>> >  #ifdef CONFIG_SMP
>> >    idle_thread_set_boot_cpu();
>> > +	balance_push_set(smp_processor_id(), false);
>> >  #endif
>> >    init_sched_fair_class();
>> >
>>
>> I don't get what these two changes do - the end result is the same as
>> before, no?
>
> Not quite; we have to make sure the state of the offline CPUs matches
> that of a CPU that's been offlined. For consistency if nothing else, but
> it's actually important for a point below.
>
>> Also, AIUI this patch covers the cpu_dying -> !cpu_dying rollback case
>> since balance_push gets numbed down by !cpu_dying. What about the other way
>> around (hot-plug failure + rollback)? We may have allowed !pcpu tasks on the
>> now-dying CPU, and we'd need to re-install the balance_push callback.
>
> This is in fact handled. Note how the previous point initialized the
> offline CPU to have the push_callback installed.
>
> Also note how balance_push() re-instates itself unconditionally.
>
> So the thing is, we install the push callback on deactivate() and leave
> it in place until activate, it is always there, regardless what way
> we're moving.
>
> However, it is only effective whild going down, see the early exit.


Oooh, I can't read, only the boot CPU gets its callback uninstalled in
sched_init()! So secondaries keep push_callback installed up until
sched_cpu_activate(), but as you said it's not effective unless a rollback
happens.

Now, doesn't that mean we should *not* uninstall the callback in
sched_cpu_dying()? AFAIK it's possible for the initial secondary CPU
boot to go fine, but the next offline+online cycle fails while going up -
that would need to rollback with push_callback installed.
