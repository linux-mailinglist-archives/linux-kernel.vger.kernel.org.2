Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E3B322C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhBWOjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:39:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:52190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhBWOja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:39:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614091123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gEzw/fCqc7xDdmteohVpYXtaCfPO7dagzCJiczyV3Is=;
        b=P6wOu4KZypeE3B4fYsE42oKLZPm8z5xkL8/VnNXlXpusE6raRAX2yMk3NFK6zCImd9AG8H
        Ur4qcP8W65IBxBSoKuRgq5f35nArdtLA86qgeZW2qL7ITEZr4jn6+1WOdUYrJxbpo+t6u8
        983MX+bz/tQWp0jYAhZIL8LmacgiyWM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 748D9AF28;
        Tue, 23 Feb 2021 14:38:43 +0000 (UTC)
Date:   Tue, 23 Feb 2021 15:38:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 08/14] printk: add syslog_lock
Message-ID: <YDUTcplrbHJ83afV@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-9-john.ogness@linutronix.de>
 <YC+9gc/IR8PzeIFf@alley>
 <875z2o15ha.fsf@jogness.linutronix.de>
 <YDPWPI4aZat+D1DE@alley>
 <87czwst5mb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czwst5mb.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-02-22 17:43:56, John Ogness wrote:
> On 2021-02-22, Petr Mladek <pmladek@suse.com> wrote:
> >>>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >>>> index 20c21a25143d..401df370832b 100644
> >>>> --- a/kernel/printk/printk.c
> >>>> +++ b/kernel/printk/printk.c
> >>>> +/* Return a consistent copy of @syslog_seq. */
> >>>> +static u64 read_syslog_seq_irq(void)
> >>>> +{
> >>>> +	u64 seq;
> >>>> +
> >>>> +	raw_spin_lock_irq(&syslog_lock);
> >>>> +	seq = syslog_seq;
> >>>> +	raw_spin_unlock_irq(&syslog_lock);
> >>>
> >>> Is there any particular reason to disable interrupts here?
> >>>
> >>> It would make sense only when the lock could be taken in IRQ
> >>> context. Then we would need to always disable interrupts when
> >>> the lock is taken. And if it is taken in IRQ context, we would
> >>> need to safe flags.
> >
> > Note that console_lock was a spinlock in 2.3.15.pre1. I see it defined
> > in kernel/printk.c as:
> >
> > spinlock_t console_lock = SPIN_LOCK_UNLOCKED;
> >
> > But it is a sleeping semaphore these days. As a result,
> > register_console(), as it is now, must not be called in an interrupt
> > context.
> 
> OK. So I will change read_syslog_seq_irq() to not disable interrupts. As
> you suggested, we can fix the rest when we remove the safe buffers.

I do not have strong opinion any longer. The disabled interrupts
should not change anything, except theoretically for the parisc
emergency console.

Maybe keep the disabled interrupts there until we have a better solution
for parisc.

Best Regards,
Petr

