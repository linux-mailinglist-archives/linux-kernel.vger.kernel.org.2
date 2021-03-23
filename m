Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E94345B43
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCWJqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:46:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:35828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhCWJqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:46:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616492797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9bkP1bfooCaeb3dEPDdMPWKx/OWcMw/3cK8FHR3F0cA=;
        b=SNkwL7lnmQufoyUrenTcr4Cz0rKu3g4hAXNc5Gnu1OA1EsXxaWErkiVzQudObaZ6ipueWG
        C/F9pI2jDwwImja16SCp1CbctbaRzSxQGCk4ly/CQ8gOkjudE5+BX7cJKVTP5lr/fECou5
        kt2LbudWEnyqFZYcRaSltZkvcdhKSmU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84607AC3E;
        Tue, 23 Mar 2021 09:46:37 +0000 (UTC)
Date:   Tue, 23 Mar 2021 10:46:31 +0100
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
Message-ID: <YFm4994WbYdQbYoD@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-3-john.ogness@linutronix.de>
 <YFbY8kF7ilYoxvYp@google.com>
 <87k0pzmoao.fsf@jogness.linutronix.de>
 <YFjbwxhZNnC52aSP@alley>
 <87ft0mg8a0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ft0mg8a0.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-03-22 22:58:47, John Ogness wrote:
> On 2021-03-22, Petr Mladek <pmladek@suse.com> wrote:
> > On Mon 2021-03-22 12:16:15, John Ogness wrote:
> >> On 2021-03-21, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> >> >> @@ -369,7 +70,10 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
> >> >>  	 * Use the main logbuf even in NMI. But avoid calling console
> >> >>  	 * drivers that might have their own locks.
> >> >>  	 */
> >> >> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
> >> >> +	if (this_cpu_read(printk_context) &
> >> >> +	    (PRINTK_NMI_DIRECT_CONTEXT_MASK |
> >> >> +	     PRINTK_NMI_CONTEXT_MASK |
> >> >> +	     PRINTK_SAFE_CONTEXT_MASK)) {
> >> >

> >> But I suppose I could switch
> >> the 1 printk_nmi_direct_enter() user to printk_nmi_enter() so that
> >> PRINTK_NMI_DIRECT_CONTEXT_MASK can be removed now. I would do this in a
> >> 4th patch of the series.
> >
> > Yes, please unify the PRINTK_NMI_CONTEXT. One is enough.
> 
> Agreed. (But I'll go even further. See below.)
> 
> > I wonder if it would make sense to go even further at this stage.
> > What is possible?
> >
> > 1. We could get rid of printk_nmi_enter()/exit() and
> >    PRINTK_NMI_CONTEXT completely already now. It is enough
> >    to check in_nmi() in printk_func().
> >
> 
> Agreed. in_nmi() within vprintk_emit() is enough to detect if the
> console code should be skipped:
> 
>     if (!in_sched && !in_nmi()) {
>         ...
>     }

Well, we also need to make sure that the irq work is scheduled to
call console later. We should keep this dicision in
printk_func(). I mean to replace the current

	if (this_cpu_read(printk_context) &
	    (PRINTK_NMI_DIRECT_CONTEXT_MASK |
	     PRINTK_NMI_CONTEXT_MASK |
	     PRINTK_SAFE_CONTEXT_MASK)) {

with

	/*
	 * Avoid calling console drivers in recursive printk()
	 * and in NMI context.
	 */
	if (this_cpu_read(printk_context) || in_nmi() {

That said, I am not sure how this fits your further rework.
I do not want to complicate it too much.

I am just afraid that the discussion about console rework might
take some time. And this would remove some complexity before we
started the more complicated or controversial changes.


> > 2. I thought about unifying printk_safe_enter()/exit() and
> >    printk_enter()/exit(). They both count recursion with
> >    IRQs disabled, have similar name. But they are used
> >    different way.
> >
> >    But better might be to rename printk_safe_enter()/exit() to
> >    console_enter()/exit() or to printk_deferred_enter()/exit().
> >    It would make more clear what it does now. And it might help
> >    to better distinguish it from the new printk_enter()/exit().
> >
> >    I am not sure if it is worth it.
> 
> I am also not sure if it is worth the extra "noise" just to give the
> function a more appropriate name. The plan is to remove it completely
> soon anyway. My vote is to leave the name as it is.

OK, let's keep printk_safe() name. It was just an idea. I wrote it
primary to sort my thoughts.

Best Regards,
Petr
