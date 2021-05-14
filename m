Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7EE381011
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhENSxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:53:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhENSxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:53:46 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621018353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=is15u10e+NC8dxozyXP6c/Q6J22aB68945/PXFPcrHI=;
        b=zmWJgrWsb20Ftd0ozKK5PXQP43rhZfsR3I1/uUT6runpvkMGzovn5ZWb7m2oiPlMTg3g9F
        VeKL6rRDSE5lKV21/ai65HCy+WnepSHc7E56KYZsiNA9DvO1Fhtou4pzz+zMqxvup+e0nJ
        RE8LSVIK4zmFCJySFUe74nZY9ZL4ooW/icw5Y4oJRT1FrID62C/UZLc+ZboEQX3MsNFF26
        RKM4mpeTdRElLqh9lUXFJQAQyB7oRoDsvogP+Qb/p2ARqyF1gOG1DwS/pd3L5GI/ADwsBF
        AAWqj31IzGqZD2YrL9VwITLBLKOdG3m1VLR81Ya6TWUf0cHk/ecDTbSfpc5anA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621018353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=is15u10e+NC8dxozyXP6c/Q6J22aB68945/PXFPcrHI=;
        b=zW883NNiIaXe7S6IbeyxgvYFP1eOjVjNllOFmvuLFG8lH/W8EEMLpJ32xQWO7yziWUnnO0
        568gD7c3KA4V5XCw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [patch 7/8] hrtimer: Avoid unnecessary SMP function calls in clock_was_set()
In-Reply-To: <YJ0+6vfkC+LTPkkw@hirez.programming.kicks-ass.net>
References: <20210427082537.611978720@linutronix.de> <20210427083724.732437214@linutronix.de> <YJ0+6vfkC+LTPkkw@hirez.programming.kicks-ass.net>
Date:   Fri, 14 May 2021 20:52:33 +0200
Message-ID: <87bl9d407i.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13 2021 at 16:59, Peter Zijlstra wrote:
> On Tue, Apr 27, 2021 at 10:25:44AM +0200, Thomas Gleixner wrote:
>> -	/* Retrigger the CPU local events everywhere */
>> -	on_each_cpu(retrigger_next_event, NULL, 1);
>> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
>> +		on_each_cpu(retrigger_next_event, NULL, 1);
>
> This will violate NOHZ_FULL;

Only if that allocation fails.

Aside of that any CPU which has an affected timer will get notified even
on NOHZ_FULL.

>> +		goto out_timerfd;
>> +	}
>> +
>> +	/* Avoid interrupting CPUs if possible */
>> +	cpus_read_lock();
>> +	for_each_online_cpu(cpu) {
>> +		struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
>> +		unsigned long flags;
>> +
>> +		raw_spin_lock_irqsave(&cpu_base->lock, flags);
>> +		/*
>> +		 * Only send the IPI when there are timers queued in one of
>> +		 * the affected clock bases. Otherwise update the base
>> +		 * remote to ensure that the next enqueue of a timer on
>> +		 * such a clock base will see the correct offsets.
>> +		 */
>> +		if (cpu_base->active_bases & bases)
>> +			cpumask_set_cpu(cpu, mask);
>> +		else
>> +			hrtimer_update_base(cpu_base);
>> +		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
>> +	}
>> +
>> +	preempt_disable();
>> +	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
>
> The sane option is:
>
> 	smp_call_function_many_cond(cpu_online_mask, retrigger_next_event,
> 				    NULL, SCF_WAIT, update_needs_ipi);
>
> Which does all of the above, but better.

With the difference that the for_each_cpu() loop runs with preemption
disabled, while with this approach preemption is only disabled accross
the function call.

Thanks,

        tglx


