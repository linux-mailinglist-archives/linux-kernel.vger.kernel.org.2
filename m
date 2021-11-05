Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372684466EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhKEQ00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:26:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46998 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhKEQ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:26:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 91DE4212BC;
        Fri,  5 Nov 2021 16:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636129424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FcmEpSdvpRAw1DH1xDlu+cpQVWWLRqY9tKa4dTZkU94=;
        b=APbqb1DDidz+TjLCxY94do2ZwrbxXNUgxU0hYlglFJtB+b9Wd3hl1NawU9NvhiXOWNJckU
        Pl3GwS5FuYL7Sps2Z3BQnaPjgE5PzTZ6yBB43i2LGmn06RelsGL8AX917IFF+MqEIf59PB
        xnsI5imwbMKNS/AZgdgnS/FXF4OWn9c=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 75B0B2C144;
        Fri,  5 Nov 2021 16:23:44 +0000 (UTC)
Date:   Fri, 5 Nov 2021 17:23:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Removal of printk safe buffers delays NMI context printk
Message-ID: <YYVakNdzjrYuBmhf@alley>
References: <1636039236.y415994wfa.astroid@bobo.none>
 <87ee7vki7f.fsf@jogness.linutronix.de>
 <1636073838.qpmyp6q17i.astroid@bobo.none>
 <87r1bv2aga.fsf@jogness.linutronix.de>
 <1636111599.wwppq55w4t.astroid@bobo.none>
 <87h7cqg0xk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7cqg0xk.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-11-05 15:03:27, John Ogness wrote:
> On 2021-11-05, Nicholas Piggin <npiggin@gmail.com> wrote:
> >> What was removed from 93d102f094b was irq_work triggering on all
> >> CPUs.
> >
> > No, it was the caller executing the flush for all remote CPUs itself.
> > irq work was not involved (and irq work can't be raised in a remote
> > CPU from NMI context).
> 
> Maybe I am missing something. In 93d102f094b~1 I see:
> 
> watchdog_smp_panic
>   printk_safe_flush
>     __printk_safe_flush
>       printk_safe_flush_buffer
>         printk_safe_flush_line
>           printk_deferred
>             vprintk_deferred
>               vprintk_emit (but no direct printing)
>               defer_console_output
>                 irq_work_queue
> 
> AFAICT, using defer_console_output() instead of your new printk_flush()
> should cause the exact behavior as before.

I agree. printk_safe_flush() used printk_deferred(). It only queued
the irq_work and never called consoles directly.

> > but we do need that printk flush capability back there and for
> > nmi_backtrace.
> 
> Agreed. I had not considered this necessary side-effect when I removed
> the NMI safe buffers.

Honestly, I do not understand why it stopped working or how
it worked before.

printk() calls vprintk(). Current vprintk() does:

asmlinkage int vprintk(const char *fmt, va_list args)
{
[...]
	/*
	 * Use the main logbuf even in NMI. But avoid calling console
	 * drivers that might have their own locks.
	 */
	if (this_cpu_read(printk_context) || in_nmi()) {
		int len;

		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
		defer_console_output();
		return len;
	}

	/* No obstacles. */
	return vprintk_default(fmt, args);
}

By other words, current vprintk():

   + queues irq_work() in NMI context
   + tries to flush consoles immeditely otherwise


> I am just wondering if we should fix the regression by going back to
> using irq_work (such as defer_console_output()) or if we want to
> introduce something new that introduces direct printing.

Yup, defer_console_output() should do the same as printk_safe_flush()
before. We do not longer need to copy the messages because they are
already in the main lockless log buffer.

Well, I am curious about the original code. The commit 93d102f094be9beab28e5
("printk: remove safe buffers") did the following:

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index c9a8f4781a10..dc17d8903d4f 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -183,11 +183,6 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 
        wd_smp_unlock(&flags);
 
-       printk_safe_flush();
-       /*
-        * printk_safe_flush() seems to require another print
-        * before anything actually goes out to console.
-        */
        if (sysctl_hardlockup_all_cpu_backtrace)
                trigger_allbutself_cpu_backtrace();

And I am curious because:

   + Why was printk_safe_flush() called before triggering backtraces
     on other CPUs?

   + The comment says that another print is needed before the messages
     goes to the console. It makes sense because printk_safe_flush()
     only set irq_work. But the patch did not remove any printk().
     So, nobody called any printk() even before.

Best Regards,
Petr
