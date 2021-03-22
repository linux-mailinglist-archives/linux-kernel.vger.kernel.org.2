Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24699344E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhCVSDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:03:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:53974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231463AbhCVSCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:02:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616436167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D5pjW6hl1L/E/T34O6RfxDfAes9ajgyDFpOMsQvndO0=;
        b=ARHbvQqqW6A+tZ/E1qNFclMm2QCKHvi+lJJpUnJcHZOHvfUgWblMNeIqhQbhYmkEdquavU
        L23UY55/WkSvPHsqe8uWVaHLajSsSUvn1LEuqfoh7zze+K1wAJpFWHDXQkE33QXbUf7K0x
        q7MReOqUGRxWOQ5jfqJxFHKyr7rPSQU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 141A4AB8A;
        Mon, 22 Mar 2021 18:02:47 +0000 (UTC)
Date:   Mon, 22 Mar 2021 19:02:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Rafael Aquini <aquini@redhat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
Message-ID: <YFjbwxhZNnC52aSP@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-3-john.ogness@linutronix.de>
 <YFbY8kF7ilYoxvYp@google.com>
 <87k0pzmoao.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0pzmoao.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-03-22 12:16:15, John Ogness wrote:
> On 2021-03-21, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> >> @@ -369,7 +70,10 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
> >>  	 * Use the main logbuf even in NMI. But avoid calling console
> >>  	 * drivers that might have their own locks.
> >>  	 */
> >> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
> >> +	if (this_cpu_read(printk_context) &
> >> +	    (PRINTK_NMI_DIRECT_CONTEXT_MASK |
> >> +	     PRINTK_NMI_CONTEXT_MASK |
> >> +	     PRINTK_SAFE_CONTEXT_MASK)) {
> >
> > Do we need printk_nmi_direct_enter/exit() and
> > PRINTK_NMI_DIRECT_CONTEXT_MASK?  Seems like all printk_safe() paths
> > are now DIRECT - we store messages to the prb, but don't call console
> > drivers.
>
> I was planning on waiting until the kthreads are introduced, in which
> case printk_safe.c is completely removed.

You want to keep printk_safe() context because it prevents calling
consoles even in normal context. Namely, it prevents deadlock by
recursively taking, for example, sem->lock in console_lock() or
console_owner_lock in console_trylock_spinning(). Am I right?


> But I suppose I could switch
> the 1 printk_nmi_direct_enter() user to printk_nmi_enter() so that
> PRINTK_NMI_DIRECT_CONTEXT_MASK can be removed now. I would do this in a
> 4th patch of the series.

Yes, please unify the PRINTK_NMI_CONTEXT. One is enough.

I wonder if it would make sense to go even further at this stage.
There will still be 4 contexts that modify the printk behavior after
this patchset:

  + printk_count set by printk_enter()/exit()
      + prevents: infinite recursion
      + context: any context
      + action: skips entire printk at 3rd recursion level

  + prink_context set by printk_safe_enter()/exit()
      + prevents: dead lock caused by recursion into some
		console code in any context
      + context: any
      + action: skips console call at 1st recursion level

  + printk_context set by printk_nmi_enter()/exit()
      + prevents: dead lock caused by any console lock recursion
      + context: NMI
      + action: skips console calls at 0th recursion level

  + kdb_trap_printk
      + redirects printk() to kdb_printk() in kdb context


What is possible?

1. We could get rid of printk_nmi_enter()/exit() and
   PRINTK_NMI_CONTEXT completely already now. It is enough
   to check in_nmi() in printk_func().

   printk_nmi_enter() was added by the commit 42a0bb3f71383b457a7db362
   ("printk/nmi: generic solution for safe printk in NMI"). It was
   really needed to modify @printk_func pointer.

   We did not remove it later when printk_function became a real
   function. The idea was to track all printk contexts in a single
   variable. But we never added kdb context.

   It might make sense to remove it now. Peter Zijstra would be happy.
   There already were some churns with tracking printk_context in NMI.
   For example, see
   https://lore.kernel.org/r/20200219150744.428764577@infradead.org

   IMHO, it does not make sense to wait until the entire console-stuff
   rework is done in this case.


2. I thought about unifying printk_safe_enter()/exit() and
   printk_enter()/exit(). They both count recursion with
   IRQs disabled, have similar name. But they are used
   different way.

   But better might be to rename printk_safe_enter()/exit() to
   console_enter()/exit() or to printk_deferred_enter()/exit().
   It would make more clear what it does now. And it might help
   to better distinguish it from the new printk_enter()/exit().

   This patchset actually splits the original printk_safe()
   functionality into two:

       + printk_count prevents infinite recursion
       + printk_deferred_enter() deffers console handling.

   I am not sure if it is worth it. But it might help people (even me)
   when digging into the printk history. Different name will help to
   understand the functionality at the given time.


What do you think, please?

Best Regards,
Petr
