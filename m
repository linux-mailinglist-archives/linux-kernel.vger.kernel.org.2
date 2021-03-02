Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4351732A2B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376930AbhCBISJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381612AbhCBIG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:06:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1160C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:06:09 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614672368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2MUgIPpMgZUtpJ3S+Mem6xRT8FQYaFpTyT34LvLYhFU=;
        b=R1DmxNJO0WmbxKL02Sl+iMHsuEeM7KFdvNkPe0XlXjm+Tz3bLLv8QVWRD+ps1M+CSU2nhe
        +46/chOhcCTJp6LdX0R0n33jE9JK+KqnKljWOj2LCOb3ayaR52leoZxUefZljdHQq8r5pB
        68kC5KFqsyyW9v1+6pqRe/Xfj1g1xGUpptx8xbyInyoik/+Lo5ROyAoR2/JFMvg4O3eXW2
        SUchtqi4OsgPGTqqEJAHvw5VbozvPBYjo+SYwlCtorj7qVwhjLMf052gqsgYesuBBH3Yp9
        cByA59ORNknsonhIS6q9msu5I0JU3AUBnfgwFOUcX7sl9oEsVJQQJ7neIMnTqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614672368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2MUgIPpMgZUtpJ3S+Mem6xRT8FQYaFpTyT34LvLYhFU=;
        b=2Ts8m2woWqX+NifZs1bcTD3vOSENm2+nnyFW6XdQJHvH0hj6e9h42hub1voxdIEWNl232p
        YQiRpQQRhPPBUiDg==
To:     Petr Mladek <pmladek@suse.com>
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
In-Reply-To: <YD0c5jMDTTKVrU8X@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de> <20210225202438.28985-2-john.ogness@linutronix.de> <YD0TYkWZqcS/VO8Z@alley> <YD0c5jMDTTKVrU8X@alley>
Date:   Tue, 02 Mar 2021 09:06:07 +0100
Message-ID: <87y2f6yo7k.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-01, Petr Mladek <pmladek@suse.com> wrote:
>> > diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
>> > index 6516ef1f8274..4869e2cc787c 100644
>> > --- a/arch/um/kernel/kmsg_dump.c
>> > +++ b/arch/um/kernel/kmsg_dump.c
>> > @@ -1,5 +1,6 @@
>> >  // SPDX-License-Identifier: GPL-2.0
>> >  #include <linux/kmsg_dump.h>
>> > +#include <linux/spinlock.h>
>> >  #include <linux/console.h>
>> >  #include <linux/string.h>
>> >  #include <shared/init.h>
>> > @@ -9,6 +10,7 @@
>> >  static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>> >  				enum kmsg_dump_reason reason)
>> >  {
>> > +	static DEFINE_SPINLOCK(lock);
>> >  	static char line[1024];
>> >  	struct console *con;
>> >  	size_t len = 0;
>> > @@ -29,11 +31,16 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>> >  	if (con)
>> >  		return;
>> >  
>> > +	if (!spin_trylock(&lock))
>> 
>> I have almost missed this. It is wrong. The last version correctly
>> used
>> 
>> 	if (!spin_trylock_irqsave(&lock, flags))
>> 
>> kmsg_dump(KMSG_DUMP_PANIC) is called in panic() with interrupts
>> disabled. We have to store the flags here.
>
> Ah, I get always confused with these things. spin_trylock() can
> actually get called in a context with IRQ disabled. So it is not
> as wrong as I thought.
>
> But still. panic() and kmsg_dump() can be called in IRQ context.
> So, this function might be called in IRQ context. So, it feels
> more correct to use the _irqsafe variant here.
>
> I know that there is the trylock so it probably does not matter much.
> Well, the disabled irq might help to serialize the two calls when
> one is in normal context and the other would happen in IRQ one.
>
> As I said, using _irqsafe variant looks better to me.

For the record, the reason I removed the _irqsave for v3 is because I
felt like it was misleading, appearing to be necessary when it is not.

I think anyone could argue both sides. But it really doesn't matter
(especially for arch/um). I will use the _irqsave variant for v4. I am
OK with that.

John Ogness
