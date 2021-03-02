Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D3232A441
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382999AbhCBK2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:28:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:38720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382760AbhCBKN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:13:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614679962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YXXc7AQv1pqE/dRNpAhoKuRsqfR3x8w5S1lFIECmSg8=;
        b=KaQ2PwfYTSpIajwKR1VYEfuRJRuYlLHKOvPxekMwA9Bfn80eDSNCLaK0Wt2Xasak8hSV1f
        0Ra0VPZPtM3rlGFqSgyxu5igRjnd3QlMKZrUKB0TL0x8X47zfaDCm48KD52wtGYhr00SJY
        fcNDNvmTOymy3TQbRFhPdEDcDFEdUyA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4E0DB07D;
        Tue,  2 Mar 2021 10:12:41 +0000 (UTC)
Date:   Tue, 2 Mar 2021 11:12:41 +0100
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
Message-ID: <YD4Pmfb/CTCGsv9g@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de>
 <20210225202438.28985-2-john.ogness@linutronix.de>
 <YD0TYkWZqcS/VO8Z@alley>
 <YD0c5jMDTTKVrU8X@alley>
 <87y2f6yo7k.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2f6yo7k.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-02 09:06:07, John Ogness wrote:
> On 2021-03-01, Petr Mladek <pmladek@suse.com> wrote:
> >> > diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> >> > index 6516ef1f8274..4869e2cc787c 100644
> >> > --- a/arch/um/kernel/kmsg_dump.c
> >> > +++ b/arch/um/kernel/kmsg_dump.c
> >> > @@ -1,5 +1,6 @@
> >> >  // SPDX-License-Identifier: GPL-2.0
> >> >  #include <linux/kmsg_dump.h>
> >> > +#include <linux/spinlock.h>
> >> >  #include <linux/console.h>
> >> >  #include <linux/string.h>
> >> >  #include <shared/init.h>
> >> > @@ -9,6 +10,7 @@
> >> >  static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> >> >  				enum kmsg_dump_reason reason)
> >> >  {
> >> > +	static DEFINE_SPINLOCK(lock);
> >> >  	static char line[1024];
> >> >  	struct console *con;
> >> >  	size_t len = 0;
> >> > @@ -29,11 +31,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> >> >  	if (con)
> >> >  		return;
> >> >  
> >> > +	if (!spin_trylock(&lock))
> >> 
> >> I have almost missed this. It is wrong. The last version correctly
> >> used
> >> 
> >> 	if (!spin_trylock_irqsave(&lock, flags))
> >> 
> >> kmsg_dump(KMSG_DUMP_PANIC) is called in panic() with interrupts
> >> disabled. We have to store the flags here.
> >
> > Ah, I get always confused with these things. spin_trylock() can
> > actually get called in a context with IRQ disabled. So it is not
> > as wrong as I thought.
> >
> > But still. panic() and kmsg_dump() can be called in IRQ context.
> > So, this function might be called in IRQ context. So, it feels
> > more correct to use the _irqsafe variant here.
> >
> > I know that there is the trylock so it probably does not matter much.
> > Well, the disabled irq might help to serialize the two calls when
> > one is in normal context and the other would happen in IRQ one.
> >
> > As I said, using _irqsafe variant looks better to me.
> 
> For the record, the reason I removed the _irqsave for v3 is because I
> felt like it was misleading, appearing to be necessary when it is not.
> 
> I think anyone could argue both sides.

Yeah, I could imagine myself to have different opinion another day
or year. I am sorry for the noise.

> But it really doesn't matter
> (especially for arch/um). I will use the _irqsave variant for v4. I am
> OK with that.

Please do, if it is easy. You are going to send v4 anyway.

Best Regards,
Petr
