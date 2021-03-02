Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADDB32A676
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448552AbhCBPFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:05:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:42022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350774AbhCBMts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:49:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614689304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LmimWd63WkUfPWADlD3zBnnPZ6h7AIB2oXCZzzXjlJw=;
        b=mPQMTl8fVDM8qIPI5TkL3p1CaW2GOGMEx9OkvNmBms+ceLRjwgbXn3z390vKN806puhD2k
        cPbmjYXeCCaGE9ANqE0n2RVQRigw7DJw/ZEIEEfKc7+D/QJoydsSU0laPEz2jkqbC1h/5V
        vNprbyefwf+gWEYUGsnXZPAtZlcKSbg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DFAE3AF63;
        Tue,  2 Mar 2021 12:48:23 +0000 (UTC)
Date:   Tue, 2 Mar 2021 13:48:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH next v3 02/15] mtd: mtdoops: synchronize kmsg_dumper
Message-ID: <YD40FzHeLkpMXkxn@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-3-john.ogness@linutronix.de>
 <YDzaYqrk3Dv37uDa@alley>
 <87tuptq1fc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuptq1fc.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-02 11:45:27, John Ogness wrote:
> On 2021-03-01, Petr Mladek <pmladek@suse.com> wrote:
> >> The kmsg_dumper can be called from any context and CPU, possibly
> >> from multiple CPUs simultaneously. Since the writing of the buffer
> >> can occur from a later scheduled work queue, the oops buffer must
> >> be protected against simultaneous dumping.
> >> 
> >> Use an atomic bit to mark when the buffer is protected. Release the
> >> protection in between setting the buffer and the actual writing in
> >> order for a possible panic (immediate write) to be written during
> >> the scheduling of a previous oops (delayed write).
> >
> > Just to be sure. You did not use spin lock to prevent problems
> > with eventual double unlock in panic(). Do I get it correctly,
> > please?
> 
> I do not understand what possible double unlock you are referring to.

I was wrong. I meant the tricks that are under in console drivrers,
for example:

static void mvebu_uart_console_write(struct console *co, const char *s,
				     unsigned int count)
{
	int locked = 1;

	if (oops_in_progress)
		locked = spin_trylock_irqsave(&port->lock, flags);
	else
		spin_lock_irqsave(&port->lock, flags);

	/* do the job */

	if (locked)
		spin_unlock_irqrestore(&port->lock, flags);
}

But this is not a problem here because the kmsg dumper bails out
when the lock could not be taken.

> I chose not to use spinlocks because I wanted something that does not
> cause any scheduling or preemption side-effects for mtd. The mtd dumper
> sometimes dumps directly, sometimes delayed (via scheduled work), and
> they use different mtd callbacks in different contexts.
>
> mtd_write() expects to be called in a non-atomic context. The callbacks
> can take a mutex.

Makes sense. Could you please mention this in the commit message?

Best Regards,
Petr
