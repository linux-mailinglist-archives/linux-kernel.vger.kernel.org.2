Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925A631FB25
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBSOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBSOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:46:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D89C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 06:45:23 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613745921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWPAM6U+VW0lbgRd8l+oMbmlE0aCg9RRcSxOAGsnt2w=;
        b=JUNAbDB6jsKDGpmQ/9Cut4oMckD6NSBtuMVbL6DaYpHhqS/AhG8Y8GUqukyEw4G9hTE/R9
        nfNut92IB8YV/dGjhSzBA+sM02C5Kmch0tmhOC2OzpidMHdVfpX1FhIO2DgW4pRaNRsMwQ
        tumgbNFNJKTyh4RqVjNWiSuKW4p6FDi59N/fXJ13V6VtQmQIc/O4v3tyMAuIUzBoMaquoG
        Q0Go9ZQHJFScAiOS9yg8F1oZzLr0y4xy+2wmYuddiqotGKGdMaWkJrPFn7DOHXbn3E0mHz
        i6fzhWPG4jnKQxC+OMJt1DGmmsKlcX4YUbx0V/HmDjMGWLKFrcktXxILDSjVhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613745921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fWPAM6U+VW0lbgRd8l+oMbmlE0aCg9RRcSxOAGsnt2w=;
        b=9uPJG8kUq/9yrFFZBCMbuBqnW6t6hBPkKuyVUhGGkSIOqfRTqq3gBdwmeFMePK5bAMyPXJ
        RoNONtsUOH7w8VBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 08/14] printk: add syslog_lock
In-Reply-To: <YC+9gc/IR8PzeIFf@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de> <20210218081817.28849-9-john.ogness@linutronix.de> <YC+9gc/IR8PzeIFf@alley>
Date:   Fri, 19 Feb 2021 15:45:21 +0100
Message-ID: <875z2o15ha.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-19, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 20c21a25143d..401df370832b 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> +/* Return a consistent copy of @syslog_seq. */
>> +static u64 read_syslog_seq_irq(void)
>> +{
>> +	u64 seq;
>> +
>> +	raw_spin_lock_irq(&syslog_lock);
>> +	seq = syslog_seq;
>> +	raw_spin_unlock_irq(&syslog_lock);
>
> Is there any particular reason to disable interrupts here?
>
> It would make sense only when the lock could be taken in IRQ
> context. Then we would need to always disable interrupts when
> the lock is taken. And if it is taken in IRQ context, we would
> need to safe flags.

All other instances of locking @syslog_lock are done with interrupts
disabled. And we have:

register_console()
  logbuf_lock_irqsave()
    raw_spin_lock(&syslog_lock)

Looking back through history, I found that locking of the "console lock"
in register_console() was changed from spin_lock_irq() to
spin_lock_irqsave() for 2.3.15pre1 [0]. The only reason I can find why
that was done is because sparc64 was regstering its console in a PROM
callback (the comments there: "Pretty sick eh?").

Today sparc64 is setting up the console in init code. I suppose I need
to go through all the console drivers to see if any register in
interrupt context. If not, that logbuf_lock_irqsave() should be replaced
with logbuf_lock_irq(). And then locking @syslog_lock will not need to
disable interrupts.

John Ogness

[0] https://github.com/schwabe/davej-history/commit/f91c3404ba16c88cdb33824bf0249c6263cd4465#diff-84036d1e27f4207c783a3b876aef4e45340d30f43b1319bca382f5775a9b14beL348
