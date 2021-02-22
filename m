Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8B0321C6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhBVQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:09:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:39558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231649AbhBVQGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:06:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614009917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fymWnnsJD9yF0KQNLsNQHmDiy5LI+Jp/eC+pUhdETqg=;
        b=Mp7Bpn1ZgI/7N6RkHbPs4X/sFZCgDuoQZZUGyqGIpXabF5OX+SFPdoEPKuXIPJ6sQbIx1H
        8ql2HRLV0xKd/P8wXFM6yWDZoL4ovfFOUr8VBGPiatlQodPGDTKSCSC2nIIJ1qMhKn/hoB
        V34fL+EKXysVgBiQx9qfIzMYCuAODsc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8B16AFD8;
        Mon, 22 Feb 2021 16:05:16 +0000 (UTC)
Date:   Mon, 22 Feb 2021 17:05:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 08/14] printk: add syslog_lock
Message-ID: <YDPWPI4aZat+D1DE@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-9-john.ogness@linutronix.de>
 <YC+9gc/IR8PzeIFf@alley>
 <875z2o15ha.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z2o15ha.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-02-19 15:45:21, John Ogness wrote:
> On 2021-02-19, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index 20c21a25143d..401df370832b 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> +/* Return a consistent copy of @syslog_seq. */
> >> +static u64 read_syslog_seq_irq(void)
> >> +{
> >> +	u64 seq;
> >> +
> >> +	raw_spin_lock_irq(&syslog_lock);
> >> +	seq = syslog_seq;
> >> +	raw_spin_unlock_irq(&syslog_lock);
> >
> > Is there any particular reason to disable interrupts here?
> >
> > It would make sense only when the lock could be taken in IRQ
> > context. Then we would need to always disable interrupts when
> > the lock is taken. And if it is taken in IRQ context, we would
> > need to safe flags.
> 
> All other instances of locking @syslog_lock are done with interrupts
> disabled. And we have:
> 
> register_console()
>   logbuf_lock_irqsave()
>     raw_spin_lock(&syslog_lock)

I see. We should revisit this after removing logbuf_lock and
printk_safe context.

> Looking back through history, I found that locking of the "console lock"
> in register_console() was changed from spin_lock_irq() to
> spin_lock_irqsave() for 2.3.15pre1 [0]. The only reason I can find why
> that was done is because sparc64 was regstering its console in a PROM
> callback (the comments there: "Pretty sick eh?").

Note that console_lock was a spinlock in 2.3.15.pre1. I see it defined
in kernel/printk.c as:

spinlock_t console_lock = SPIN_LOCK_UNLOCKED;

But it is a sleeping semaphore these days. As a result,
register_console(), as it is now, must not be called in an interrupt context.

Best Regards,
Petr
