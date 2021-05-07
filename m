Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4F3768E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbhEGQhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:37:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:45492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236791AbhEGQhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:37:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620405378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3vKwfsgh3be3dOtgaX8yOro3hq9XPe5WVhvrNgLNb0Y=;
        b=cbsh3wfRKdG4Xdm7pJXvcfILyJzgdpJpD6FB5Xjy/B/qM8vfwVefv07UIaLXImvZyM0rzD
        ZK21rgDh6zh0qpUYfYfZTIIBqcY5dAaaq7qGcwXT276QKSu+xEmFykHHqGNfukHdAbKdej
        HcHRbTRS/m4CWNoAU1jDJgwNt/3NtIg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE1B2AC36;
        Fri,  7 May 2021 16:36:17 +0000 (UTC)
Date:   Fri, 7 May 2021 18:36:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Luo Jiaxing <luojiaxing@huawei.com>, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        bobo.shaobowang@huawei.com
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
Message-ID: <YJVsgPc66lhaAUN0@alley>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley>
 <YJP4F1UIt/eRZ96s@google.com>
 <YJP5MnkJ8pJevXM6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJP5MnkJ8pJevXM6@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-05-06 23:12:02, Sergey Senozhatsky wrote:
> On (21/05/06 23:07), Sergey Senozhatsky wrote:
> > 
> > Can we count the number of lines that we print from the `current` context
> > in console_unlock() and if after N messages there is no console_lock waiter
> > waiting for the `current` to handover console lock ownership, then create
> > one: schedule IRQ work that will become a console lock owner, spin on
> > console lock and call console_unlock() once it acquired the ownership.
> > That 'artificial' console lock owner will do the same - print N
> > messages, if nothing wants to become a console lock owner then it'll
> > queue another IRQ work.
> 
> Or even simpler
> 
> console_unlock()
> {
> 	...
> 
> 	if (printed_messages > limit && !console_lock_spinning_disable_and_check()) {
> 		printk_safe_exit_irqrestore(flags);
> 
> 		console_locked = 0;
> 		up_console_sem();
> 
> 		defer_console_output();
> 		return;
> 	}
> 
> 	...
> }

No, please, no.

This is exactly the opposite. The original patch tried to keep the
work in the preemtible context. This proposal moves the work into irq
context which is bad. Not to say, that defer_console_output() would
trigger IRQ on the same CPU again and again.

All the problems with printk() are that we try to support all
scenarios. But it simply does not work. We need to say that some
situations are not supported.

Flood of messages and slow console requires a miracle. The only chance
is a huge buffer and get them out later. Infinite flood of messages
is impossible to handle by definition.

I hope that we agreed that the priority is to keep printk() safe
and do not break the system. The ultimate solution is to handle
consoles in a separate preemtible context (kthread).

There should be atomic consoles for those who want to see the messages
immediately with the cost of slowing down the code doing the real job.


I do not have strong opinion whether the proposed patch is worth it.
It is just another compromise that might be better in some situations
and worse in others.

Well, this situation is special. There might be many accumulated
messages during the hibernation. They did not have any chance to
be handled by more CPUs. Using the well known preemtible context
sounds slightly better than risking a random victim in atomic
context.

Anyway, I am fine with discarding this patch and focusing on
the offload to kthreads.

Best Regards,
Petr
