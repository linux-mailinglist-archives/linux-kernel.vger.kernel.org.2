Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A042D3AD072
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbhFRQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235867AbhFRQeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:34:05 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C5ED61260;
        Fri, 18 Jun 2021 16:31:54 +0000 (UTC)
Date:   Fri, 18 Jun 2021 12:31:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH next v4 1/2] lib/dump_stack: move cpu lock to printk.c
Message-ID: <20210618123152.35a992ea@oasis.local.home>
In-Reply-To: <877dirb4t2.fsf@jogness.linutronix.de>
References: <20210617095051.4808-1-john.ogness@linutronix.de>
        <20210617095051.4808-2-john.ogness@linutronix.de>
        <20210617093243.795b4853@gandalf.local.home>
        <877dirb4t2.fsf@jogness.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2021 17:01:37 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> Since the cpu lock is also taken in NMI context (for example, via
> nmi_cpu_backtrace()/dump_stack()), the main concerns are:
> 
> 1. locks that are taken by a CPU that is holding the cpu lock
> 
> 2. NMI contexts that take any type of lock
> 
> (Actually, #2 is just a special case of #1 where an NMI interrupted a
> task that was holding the cpu lock.)
> 
> For early_printk() the early USB devices look to be a
> problem. early_xdbc_write() will take a spinlock. Assuming the
> early_console was also registered as a normal console (via "keep") we
> could end up in the following deadlock between the normal console and
> early_printk() writes:

My use case of earlyprintk is to avoid all the crud in printk, and
just have something to print to the serial console. USB early printk is
not my use case, as that adds even more crud.

Thus, I don't care about this being an issue with USB early printk ;-)


> 
>     CPU0                          CPU1
>     ----                          ----
>     early_printk()                console->write()
>       cpu_lock()                    spinlock()
>       early_console->write()      *NMI*
>         spinlock()                cpu_lock()
> 
> The upcoming atomic console work addresses this by implementing a new
> write_atomic() callback that is lockless (and SMP-safe) or aware of the
> cpu lock to avoid dead locks such as above.
> 
> AFAICT, the USB devices (CONFIG_EARLY_PRINTK_USB) are the only
> early_printk() candidates that use locking. So for all other
> early_printk() implementations I think your suggestion would work fine.
> 
> Although, in general, early_printk() is not SMP-safe. So I'm not sure
> how much safety we need to include at this point.
> 

Right. I say we ignore the issue with usb earlyprintk. The only time I
can see that even useful, is for issues that are happening before
printk is initialized, and all you have for a console is the usb for
early printk, and the above scenario shouldn't be an issue. But for
places that would utilize early printk for later on in the boot process
(and normal activity), any console that takes locks would be useless.

-- Steve
