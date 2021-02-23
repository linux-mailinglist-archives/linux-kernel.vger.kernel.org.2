Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514A0322C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhBWOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:24:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:38998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232923AbhBWOYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:24:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614090213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DiztHJZUPXTMIMmPaqzkWuxBFMESJZObqRiKrNQE7VI=;
        b=dV+EafLiJt9Kwur6/xPyqu2ANfZg4Ah+uDddZQfEibwYy+T6gMFtUXbvjYAl9yD+rJm9nA
        QDdjw7lbAZufWznD1D2P0SRaiLlhsORsZnynnqSXO4OMsJu6W0bw4MsC2TVLtE/gBmwo+c
        DuzNkyzCpCpSOewlJ07SwyLKNCm/CNw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50E10ACD4;
        Tue, 23 Feb 2021 14:23:33 +0000 (UTC)
Date:   Tue, 23 Feb 2021 15:23:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Helge Deller <deller@gmx.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH printk-rework 08/14] printk: add syslog_lock
Message-ID: <YDUP5J+AJwYjx5P4@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-9-john.ogness@linutronix.de>
 <YC+9gc/IR8PzeIFf@alley>
 <875z2o15ha.fsf@jogness.linutronix.de>
 <8735xs10hi.fsf@jogness.linutronix.de>
 <db43de06-3183-7401-30f2-0e9302cc48e0@gmx.de>
 <YDPbqhi6wVwGa5rF@alley>
 <b8ddd9e3-896f-cd9a-a340-0a7e139fee2e@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ddd9e3-896f-cd9a-a340-0a7e139fee2e@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-23 13:22:22, Helge Deller wrote:
> On 2/22/21 5:28 PM, Petr Mladek wrote:
> > On Sun 2021-02-21 22:39:42, Helge Deller wrote:
> > > On 2/19/21 5:33 PM, John Ogness wrote:
> > > > Added CC: linux-parisc@vger.kernel.org
> > > > 
> > > > On 2021-02-19, John Ogness <john.ogness@linutronix.de> wrote:
> > > > > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > > > > index 20c21a25143d..401df370832b 100644
> > > > > > > --- a/kernel/printk/printk.c
> > > > > > > +++ b/kernel/printk/printk.c
> > > > > > > +/* Return a consistent copy of @syslog_seq. */
> > > > > > > +static u64 read_syslog_seq_irq(void)
> > > > > > > +{
> > > > > > > +	u64 seq;
> > > > > > > +
> > > > > > > +	raw_spin_lock_irq(&syslog_lock);
> > > > > > > +	seq = syslog_seq;
> > > > > > > +	raw_spin_unlock_irq(&syslog_lock);
> > > > > > 
> > > > > > Is there any particular reason to disable interrupts here?
> > > > > > 
> > > > I found a possible call chain in interrupt context. From arch/parisc
> > > > there is the interrupt handler:
> > > > 
> > > Yes, handle_interruption() is the irq handler, running with irqs off.
> > > HPMC is the crash handler - it's called when the kernel will stop
> > > anyway. pdc_console is a very basic firmware console which prints
> > > the last messages before the machine halts on fatal errors.
> > > So, this code it's not the typical use case....
> > 
> > Thanks for information.
> > 
> > Is this code supposed to work only during early boot or anytime,
> > please?
> 
> No.
> It's only called when the kernel completely crashes, when all
> spinlocks should get busted and so on.
> It's the emergency way to get some info out at least.

OK.

> > Note that it is not safe because register_console() takes
> > console_lock() which is a sleeping lock.
> 
> As I said, in that stage the plan is to bust all spinlocks.

Just to be sure. Note that that register_console() does not bust
console_lock in panic.

bust_spinlocks() just increments oops_in_progress counter. It has
effect only when the caller checks this variable and use trylock
when it is set. For example, see serial8250_console_write():

void serial8250_console_write(struct uart_8250_port *up, const char *s,
			      unsigned int count)
{
	int locked = 1;

	if (oops_in_progress)
		locked = spin_trylock_irqsave(&port->lock, flags);
	else
		spin_lock_irqsave(&port->lock, flags);


	...


	if (locked)
		spin_unlock_irqrestore(&port->lock, flags);
}

register_console() does not check oops_in_progress at the moment
and might get blocked on console_sem.

We could add the checks for oops_in_progress into register_console().
But I am not sure if it is worth it. It seems that you used this code
for ages. The risk of the deadlock is small. It likely works most
of the time. The upcoming printk rework should allow a cleaner
solution.

Best Regards,
Petr
