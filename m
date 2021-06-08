Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E32C39F831
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhFHN5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:57:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhFHN5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:57:30 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623160536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GthawrUV0muimHEvK6zmrGcJCGq8jZiO7aULAQyY0Y4=;
        b=KqB2XeLPb2pn31XBafOH88rFZJ0m1XFlCaBHWP51L91TN2FL8df9Qw4RpS2uAvUMOQ2Ylt
        xEuiFsfj4/LkqYFGr9KcRPfFZIn9ERmWSfySq0RW6pSqiTp/VdjBux9l9nXUBsqrpcGDkb
        iPwfnFHpb+RWUPb1vKPkV57HT451MqRlZkdChbjbtrPWPkeez1QVzHYTH1eV+nYAttliMg
        5dGoxI+eXaxM2PcbKRHPKqZyu8jLZqD3cJCj2CYmIOHlROaBlFbBhtRoUxrl3FrOD6M17m
        kGxXdqJ5LBuUFbBFsmGzoV0S8lQMh59HrJy2eVTpOrDjWSrIn2uSh5zNpcXnwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623160536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GthawrUV0muimHEvK6zmrGcJCGq8jZiO7aULAQyY0Y4=;
        b=EbpYJIH/ZsDWszGBdq5OQx13lCRmoeaq5h+qUNhz2qv34+MkW5vgKmX+0vm8ibRGXEhGOM
        yL01FENDgggioiAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH next v2 1/2] dump_stack: move cpu lock to printk.c
In-Reply-To: <YL9XMBxeZ4fGRS79@alley>
References: <20210607200232.22211-1-john.ogness@linutronix.de> <20210607200232.22211-2-john.ogness@linutronix.de> <YL9XMBxeZ4fGRS79@alley>
Date:   Tue, 08 Jun 2021 15:55:35 +0200
Message-ID: <878s3kihpk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-08, Petr Mladek <pmladek@suse.com> wrote:
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3532,3 +3532,78 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
>> +void printk_cpu_lock_irqsave(bool *lock_flag, unsigned long *irq_flags)
>> +{
>> +	int old;
>> +	int cpu;
>> +
>> +retry:
>> +	local_irq_save(*irq_flags);
>> +
>> +	cpu = smp_processor_id();
>> +
>> +	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
>> +	if (old == -1) {
>> +		/* This CPU is now the owner. */
>> +
>
> Superfluous space?

I was concerned that people may associate the comment with the following
line of code. Especially in the next patch when many more lines are
added. The comment is for the whole conditional block.

>> +		*lock_flag = true;
>
> The original name name "was_locked" was more descriptive. I agree that
> it was not good for an API. What about keeping the inverted logic and
> calling it "lock_nested" ?
>
> I do not resist on any change. The logic is trivial so...

I wanted it to be an opaque variable, which is why it is named so. But I
can rename it for v3. There is no need to debate naming here.

>> +
>> +	} else if (old == cpu) {
>> +		/* This CPU is already the owner. */
>> +
>> +		*lock_flag = false;
>> +
>
> Even more superfluous spaces?

This code is not trivial and it is absolutely critical when we introduce
atomic consoles. My goal is clarity rather than compactness
(particularly after proper memory barrier comments are added).

>> +	} else {
>> +		local_irq_restore(*irq_flags);
>> +
>> +		/*
>> +		 * Wait for the lock to release before jumping to cmpxchg()
>> +		 * in order to mitigate the thundering herd problem.
>> +		 */
>> +		do {
>> +			cpu_relax();
>> +		} while (atomic_read(&printk_cpulock_owner) != -1);
>> +
>> +		goto retry;
>> +	}
>> +}
>> +EXPORT_SYMBOL(printk_cpu_lock_irqsave);
>> +
>> +/*
>> + * printk_cpu_unlock_irqrestore: Release the printk cpu-reentrant spinning
>> + *                               lock and restore interrupts.
>> + * @lock_flag: The current lock state.
>> + * @irq_flags: The current irq state.
>
> "The current" is a bit misleading. Both values actually describe
> the state before the related printk_cpu_lock_irqsave().
> What about something like?
>
>   * @lock_nested: Lock state set when the lock was taken.
>   * @irq_flags: IRQ flags stored when the lock was taken.

OK. I will make this change for v3.

John Ogness
