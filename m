Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010FE321D59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhBVQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:46:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46392 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhBVQoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:44:39 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614012236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3/fQ8WtYTf7NEsBwWhpZFayVKjGGGhQ6OwWxbAH/As=;
        b=TNmXRHzQVLwv9K6Y/ycGmRWXOhV0+hMrY3wmMO5ceRxMkNfcmLlF8yaR4qUMpvEH5u+diG
        Atcj1TXCZnX1lboBQPAVCpj6HG7tl+XtmeKMqNp7jhiAHiyN1kqs1eTRNbKXPglX8dDPGP
        LjlsLwADHQfeBAKrQvdnDtdWHfX3JKt8ONOJ3+PzeATQcYFtmNAW+5/xg5Pk8bV/xofQlE
        LjRh10mv/bdcM7dcMssXxIjYbeVVbaep/ht34+O0N40/6h00DZ+4aKY65TZYDtMHJ7hNXO
        XegIrSQnZConScNzbd8vYdsJaN4RB8F3BzW5WQlxrayUqO9y2lba+UiF8v4eXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614012236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3/fQ8WtYTf7NEsBwWhpZFayVKjGGGhQ6OwWxbAH/As=;
        b=uVCPExwZEHGnLA9xDl+f3uOFhDkbF/xnmI/o2UqBcBOahXE0WzJQyqK3R3g2/gLebauoAS
        uDCnSCwcUs9EcbBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 08/14] printk: add syslog_lock
In-Reply-To: <YDPWPI4aZat+D1DE@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de> <20210218081817.28849-9-john.ogness@linutronix.de> <YC+9gc/IR8PzeIFf@alley> <875z2o15ha.fsf@jogness.linutronix.de> <YDPWPI4aZat+D1DE@alley>
Date:   Mon, 22 Feb 2021 17:43:56 +0100
Message-ID: <87czwst5mb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-22, Petr Mladek <pmladek@suse.com> wrote:
>>>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>>>> index 20c21a25143d..401df370832b 100644
>>>> --- a/kernel/printk/printk.c
>>>> +++ b/kernel/printk/printk.c
>>>> +/* Return a consistent copy of @syslog_seq. */
>>>> +static u64 read_syslog_seq_irq(void)
>>>> +{
>>>> +	u64 seq;
>>>> +
>>>> +	raw_spin_lock_irq(&syslog_lock);
>>>> +	seq = syslog_seq;
>>>> +	raw_spin_unlock_irq(&syslog_lock);
>>>
>>> Is there any particular reason to disable interrupts here?
>>>
>>> It would make sense only when the lock could be taken in IRQ
>>> context. Then we would need to always disable interrupts when
>>> the lock is taken. And if it is taken in IRQ context, we would
>>> need to safe flags.
>
> Note that console_lock was a spinlock in 2.3.15.pre1. I see it defined
> in kernel/printk.c as:
>
> spinlock_t console_lock = SPIN_LOCK_UNLOCKED;
>
> But it is a sleeping semaphore these days. As a result,
> register_console(), as it is now, must not be called in an interrupt
> context.

OK. So I will change read_syslog_seq_irq() to not disable interrupts. As
you suggested, we can fix the rest when we remove the safe buffers.

John Ogness
