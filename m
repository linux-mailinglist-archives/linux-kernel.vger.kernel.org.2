Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8F931FD28
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhBSQeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhBSQd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:33:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2DBC061574;
        Fri, 19 Feb 2021 08:33:15 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613752393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97ZzVtbwKQCfR71IFRR31RjdINHh6ZFDEf68m4R8RI8=;
        b=02RGLpdAAKDIumdEh7HHcouRxkLRCb/aTkhchgac4RgPsOL4Xbd5hk+vVvmWr4FzDiLdkz
        MG3zB6LGgs9O+AQ/d9843UG96N6cAIpcxZ9gX0RShliPbR4kCeRToYTxSvc4yNjaNLVear
        gG9WVxAUYQmOcFRZ4XHcIAIJhU41Awr/17M/k5uMlUaFiwvFDxhfL1hs58kfz7iBSeXkOe
        N+y2i/jf5E2RCbs1Z6QQp/pKV9WSLn1NZKa2uaP6TBUSFN4xti6gftlcvAXtL4iVcLiLOM
        iehmiaWs3RBMt6piExATLxkx1i6zFq5xHMf4KDcTMEn4RJVA7WCDvA2isftBCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613752393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97ZzVtbwKQCfR71IFRR31RjdINHh6ZFDEf68m4R8RI8=;
        b=JHCAP9w1PY9fk6TeY72u5EWHERXslbZzO/KX2y1PtF0133YIJpG1LBI1SeUHfv/sClzjEe
        h/Rwy60HTUlOksAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH printk-rework 08/14] printk: add syslog_lock
In-Reply-To: <875z2o15ha.fsf@jogness.linutronix.de>
References: <20210218081817.28849-1-john.ogness@linutronix.de> <20210218081817.28849-9-john.ogness@linutronix.de> <YC+9gc/IR8PzeIFf@alley> <875z2o15ha.fsf@jogness.linutronix.de>
Date:   Fri, 19 Feb 2021 17:33:13 +0100
Message-ID: <8735xs10hi.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added CC: linux-parisc@vger.kernel.org

On 2021-02-19, John Ogness <john.ogness@linutronix.de> wrote:
>>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>>> index 20c21a25143d..401df370832b 100644
>>> --- a/kernel/printk/printk.c
>>> +++ b/kernel/printk/printk.c
>>> +/* Return a consistent copy of @syslog_seq. */
>>> +static u64 read_syslog_seq_irq(void)
>>> +{
>>> +	u64 seq;
>>> +
>>> +	raw_spin_lock_irq(&syslog_lock);
>>> +	seq = syslog_seq;
>>> +	raw_spin_unlock_irq(&syslog_lock);
>>
>> Is there any particular reason to disable interrupts here?
>>
>> It would make sense only when the lock could be taken in IRQ
>> context. Then we would need to always disable interrupts when
>> the lock is taken. And if it is taken in IRQ context, we would
>> need to safe flags.
>
> All other instances of locking @syslog_lock are done with interrupts
> disabled. And we have:
>
> register_console()
>   logbuf_lock_irqsave()
>     raw_spin_lock(&syslog_lock)
>
> I suppose I need to go through all the console drivers to see if any
> register in interrupt context. If not, that logbuf_lock_irqsave()
> should be replaced with logbuf_lock_irq(). And then locking
> @syslog_lock will not need to disable interrupts.

I found a possible call chain in interrupt context. From arch/parisc
there is the interrupt handler:

handle_interruption(code=1) /* High-priority machine check (HPMC) */
  pdc_console_restart()
    pdc_console_init_force()
      register_console()

All other register_console() calls in the kernel are either during init
(within __init sections and probe functions) or are clearly not in
interrupt context (using mutex, kzalloc, spin_lock_irq, etc).

I am not familiar with parisc, but I am assuming handle_interruption()
is always called with interrupts disabled (unless the HPMC interrupt is
somehow an exception).

John Ogness
