Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66042328F9A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 20:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbhCATxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 14:53:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:47970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236043AbhCAQ6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:58:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614617832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VDG8U6jJIt3/CZoTt/qFRKFaEBWJcLlgnluTxbsCik=;
        b=rGMKhxcgo6S3MzF2SP0dm+wGw9IFz/nOVw8gsX9TXPX0MNySZgWceZVBZqcPmWBxDEe/56
        S8Hix4wkOtA5SAay/ZtFwq21D0RJEKY+hpACdZO3lRer4dlFCHv1Oc9FQzK8fuGtQOCfey
        eQQ/HK0+EiKv6Xvoc9LLW6mCpfs4rvM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CA85B018;
        Mon,  1 Mar 2021 16:57:12 +0000 (UTC)
Date:   Mon, 1 Mar 2021 17:57:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH next v3 01/15] um: synchronize kmsg_dumper
Message-ID: <YD0c5jMDTTKVrU8X@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-2-john.ogness@linutronix.de>
 <YD0TYkWZqcS/VO8Z@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD0TYkWZqcS/VO8Z@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-03-01 17:16:35, Petr Mladek wrote:
> On Thu 2021-02-25 21:24:24, John Ogness wrote:
> > The kmsg_dumper can be called from any context and CPU, possibly
> > from multiple CPUs simultaneously. Since a static buffer is used
> > to retrieve the kernel logs, this buffer must be protected against
> > simultaneous dumping. Skip dumping if another context is already
> > dumping.
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  arch/um/kernel/kmsg_dump.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> > index 6516ef1f8274..4869e2cc787c 100644
> > --- a/arch/um/kernel/kmsg_dump.c
> > +++ b/arch/um/kernel/kmsg_dump.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/kmsg_dump.h>
> > +#include <linux/spinlock.h>
> >  #include <linux/console.h>
> >  #include <linux/string.h>
> >  #include <shared/init.h>
> > @@ -9,6 +10,7 @@
> >  static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> >  				enum kmsg_dump_reason reason)
> >  {
> > +	static DEFINE_SPINLOCK(lock);
> >  	static char line[1024];
> >  	struct console *con;
> >  	size_t len = 0;
> > @@ -29,11 +31,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> >  	if (con)
> >  		return;
> >  
> > +	if (!spin_trylock(&lock))
> 
> I have almost missed this. It is wrong. The last version correctly
> used
> 
> 	if (!spin_trylock_irqsave(&lock, flags))
> 
> kmsg_dump(KMSG_DUMP_PANIC) is called in panic() with interrupts
> disabled. We have to store the flags here.

Ah, I get always confused with these things. spin_trylock() can
actually get called in a context with IRQ disabled. So it is not
as wrong as I thought.

But still. panic() and kmsg_dump() can be called in IRQ context.
So, this function might be called in IRQ context. So, it feels
more correct to use the _irqsafe variant here.

I know that there is the trylock so it probably does not matter much.
Well, the disabled irq might help to serialize the two calls when
one is in normal context and the other would happen in IRQ one.

As I said, using _irqsafe variant looks better to me.

What do you think, please?

Best Regards,
Petr

PS: Heh, IMHO, I do not use an authoritative style too often. But my
feeling is that every time I use it then I am proven to be wrong.
And it has happened again.
