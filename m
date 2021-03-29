Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025F134CD97
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 12:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhC2KEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 06:04:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232383AbhC2KEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 06:04:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617012281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GNE8QGhIA/QD9lakMGdqAV65OAeWWmq7F4C1CSmNnNA=;
        b=k8mzcRXE4Od3/N55AyhvaLae04t+5A1u52vRoPIWPL6EC58mjgqlveXjfPRdzauZEMCPHR
        6sZoemDhRalUXdDGXlRv3mmpTkbivMvA7WZGXDfFu8LOInpfH5rYlT8d/Yu+8GebPjLQF1
        oqWPXAhJoL8QKIAbv3LJCKN2fUo1vBs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46D28B3DE;
        Mon, 29 Mar 2021 10:04:41 +0000 (UTC)
Date:   Mon, 29 Mar 2021 12:04:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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
Message-ID: <YGGmNu5ilDnSKH3g@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-3-john.ogness@linutronix.de>
 <YFnHKlCvIA2nI41c@alley>
 <87pmzmi2xm.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmzmi2xm.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-03-26 12:12:37, John Ogness wrote:
> On 2021-03-23, Petr Mladek <pmladek@suse.com> wrote:
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> -
> >>  	if (seq != prb_next_seq(&printk_rb_static)) {
> >>  		pr_err("dropped %llu messages\n",
> >>  		       prb_next_seq(&printk_rb_static) - seq);
> >> @@ -2666,7 +2631,6 @@ void console_unlock(void)
> >>  		size_t ext_len = 0;
> >>  		size_t len;
> >>  
> >> -		printk_safe_enter_irqsave(flags);
> >>  skip:
> >>  		if (!prb_read_valid(prb, console_seq, &r))
> >>  			break;
> >> @@ -2711,6 +2675,8 @@ void console_unlock(void)
> >>  				printk_time);
> >>  		console_seq++;
> >>  
> >> +		printk_safe_enter_irqsave(flags);
> >
> > What is the purpose of the printk_safe context here, please?
> 
> console_lock_spinning_enable() needs to be called with interrupts
> disabled. I should have just used local_irq_save().
> 
> I could add local_irq_save() to console_lock_spinning_enable() and
> restore them at the end of console_lock_spinning_disable_and_check(),
> but then I would need to add a @flags argument to both functions. I
> think it is simpler to just do the disable/enable from the caller,
> console_unlock().

I see. I have missed it that all this code have to be called with
interrupts disabled.

OK, it is a must-to-have because of the spinning. But I wonder if some
console drivers rely on the fact that the write() callback is
called with interrupts disabled.

IMHO, it would be a bug when any write() callback expects that
callers disabled the interrupts.

Do you plan to remove the console-spinning stuff after offloading
consoles to the kthreads?

Will you call console write() callback with irq enabled from
the kthread?

Anyway, we should at least add a comment why the interrupts are
disabled.


> BTW, I could not find any sane way of disabling interrupts via a
> raw_spin_lock_irqsave() of @console_owner_lock because of the how it is
> used with lockdep. In particular for
> console_lock_spinning_disable_and_check().

I see. IMHO, we would need to explicitly call local_irq_save()/restore()
if we moved them to console_lock_spinning_enable()/disable_and_check().
I mean to do:


static void console_lock_spinning_enable(unsigned long *flags)
{
	local_irq_save(*flags);

	raw_spin_lock(&console_owner_lock);
	console_owner = current;
	raw_spin_unlock(&console_owner_lock);

	/* The waiter may spin on us after setting console_owner */
	spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
}

...

Best Regards,
Petr
