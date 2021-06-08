Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9DC39F8D5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhFHOUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbhFHOUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:20:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11486C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 07:18:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623161931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Dp7nljZnOJlBDV9EaPJrDbMemMwXgvkXSdjPBg5uyc=;
        b=SSNWHij8b54wc0U0Hp8/a49MP1Aefwe9hhQCdTJcW/dxqf1tqCcSs2uztUac39xUqUAu0b
        lbuD1oQtESBjXQZLabgnC3mQ+48XChC4BPdz2kdk7/HnTpAQ+NdYvmTlDbCBPogxtFfvfG
        Up+btpzc5GTn2740FSxQumHdDMHTVakroGWstkkcTeG9uMMcfq6czw39yEsDGSRGQ8ThW6
        6jkWP4XAO9muLYmxDZ881v98tryVhJ1uuivjovtQmmIE77bB0joUNl5oC2n8B2bSBDNM/N
        OoyC795KLCqwBQYJUP0cDASebiodCa7EJiDCNfVf+5XNo40cxteSSkMpacDKsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623161931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Dp7nljZnOJlBDV9EaPJrDbMemMwXgvkXSdjPBg5uyc=;
        b=77t931nqkYUHSn8e3foqt5fGlgn6Zms9JKbPC19biM0Jr/mD+hDBJUwVEhW+mzIY2pXSfN
        ngw7aavL8RqWtGCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH next v2 2/2] printk: fix cpu lock ordering
In-Reply-To: <YL9osWvgvdCo4JAK@alley>
References: <20210607200232.22211-1-john.ogness@linutronix.de> <20210607200232.22211-3-john.ogness@linutronix.de> <YL9osWvgvdCo4JAK@alley>
Date:   Tue, 08 Jun 2021 16:18:51 +0200
Message-ID: <875yyoigms.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-08, Petr Mladek <pmladek@suse.com> wrote:
> The change makes perfect sense and the code looks correct.
> But I am not sure about the description of the memory barriers.

OK.

>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index f94babb38493..8c870581cfb4 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3560,10 +3560,29 @@ void printk_cpu_lock_irqsave(bool *lock_flag, unsigned long *irq_flags)
>>  
>>  	cpu = smp_processor_id();
>>  
>> -	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
>> +	/*
>> +	 * Guarantee loads and stores from the previous lock owner are
>> +	 * visible to this CPU once it is the lock owner. This pairs
>> +	 * with cpu_unlock:B.
>
> These things are not easy to describe. It took me quite some time to
> understand the above description. And think that it does not say
> the full storry.
>
> IMHO, the lock should work the way that:
>
>    + The new owner see all writes done or seen by the previous owner(s).
>    + The previous owner(s) never see writes done by the new owner.

You are right. I can describe those independently.

> Honestly, I am not sure if we could describe the barriers correctly
> and effectively at the same time.

For v3 I would describe the 2 cases separately. For lock/acquire:

	/*
	 * Guarantee loads and stores from this CPU when it is the lock owner
	 * are _not_ visible to the previous lock owner. This pairs with
	 * cpu_unlock:B.
	 *
	 * Memory barrier involvement:
	 *
	 * If cpu_lock:A reads from cpu_unlock:B, then cpu_unlock:A can never
	 * read from cpu_lock:B.
	 *
	 * Relies on:
	 *
	 * RELEASE from cpu_unlock:A to cpu_unlock:B
	 *    matching
	 * ACQUIRE from cpu_lock:A to cpu_lock:B
	 */

And for unlock/release:

	/*
	 * Guarantee loads and stores from this CPU when it was the
	 * lock owner are visible to the next lock owner. This pairs
	 * with cpu_lock:A.
	 *
	 * Memory barrier involvement:
	 *
	 * If cpu_lock:A reads from cpu_unlock:B, then cpu_lock:B
	 * reads from cpu_unlock:A.
	 *
	 * Relies on:
	 *
	 * RELEASE from cpu_unlock:A to cpu_unlock:B
	 *    matching
	 * ACQUIRE from cpu_lock:A to cpu_lock:B
	 */

I know you are not a fan of these drawn out memory barrier comments. But
it really simplifies verification and translation to litmus
tests. Without such comments, I would be lost looking back at
printk_ringbuffer.c.

If the previous dump_stack() cpu lock implementation had such comments,
we would know if the missing memory barriers were by design.

John Ogness
