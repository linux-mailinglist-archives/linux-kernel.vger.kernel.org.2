Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F143448CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhCVPI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:08:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:38970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhCVPHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:07:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616425673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HsDSvSeowDWQ/lfKAfx8rm5MByzhwMWt8jt3AkHwgSg=;
        b=LdyocxSHytRNTBCqzl5t9BLDlmLXU73PocsSRnAGcJk9tqwdyuwTpj8ZLL5T2Tg4J4TS0C
        3qJC8eJiPQwdT1uDeSzxvEGAxZlyQlLjIUVe7rExuWutC9YOhhyIQYd+B5tVc2OOyBxAr1
        Lql9uHWMR5UVf1UMD/CVEPdE4KdVDp0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDB40AD74;
        Mon, 22 Mar 2021 15:07:53 +0000 (UTC)
Date:   Mon, 22 Mar 2021 16:07:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v1 1/3] printk: track/limit recursion
Message-ID: <YFiyyWnROBD29tC5@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-2-john.ogness@linutronix.de>
 <YFba1Fje6+TeIiGW@google.com>
 <87mtuvmpcl.fsf@jogness.linutronix.de>
 <YFh770T97jwQLRKu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFh770T97jwQLRKu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-03-22 20:13:51, Sergey Senozhatsky wrote:
> On (21/03/22 11:53), John Ogness wrote:
> > On 2021-03-21, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > >> @@ -2055,6 +2122,9 @@ int vprintk_store(int facility, int level,
> > >>  	 */
> > >>  	ts_nsec = local_clock();
> > >>  
> > >> +	if (!printk_enter_irqsave(&irqflags))
> > >> +		return 0;
> > >
> > > I guess it can be interesting to somehow signal us that we had
> > > printk() recursion overflow, and how many messages we lost.
> > 
> > Honestly, if we hit 3 levels of recursion, we are probably dealing with
> > an infinite recursion issue.
> 
> I tend to agree.
> 
> > I do not see the value of counting the overflows in that case. The
> > logged messages at that recursion level would ben enough to point
> > us to the problem.
> >
> > > 3 levels of recursion seem like reasonable limit, but I maybe wouldn't
> > > mind one extra level.
> >
> > With 3 levels, we will see all the messages of:
> >
> >     printk -> WARN_ON -> WARN_ON -> WARN_ON

This is the worst case. Many messages are just a single line or
we use WARN_ON_ONCE.


> Well, not necessarily this simple.
> 
> printk
>  vsprintf
>   handle_foo_specifier
>    printk
>     call_console_drivers
>      timekeeping
>       printk
>        vsprintf
> 
> We saw in the past that enabling CONFIG_DEBUG_OBJECTS (if I'm not
> mistaken) can add quite a bit of extra printk recursion paths.
> 
> We also have other CONFIG_DEBUG_* config options that can pop up as
> recursive printk-s here and there. For instance, from vsprintf::foo_specifier()
> where we escape from printk() to various kernel subsystems: net, block,
> etc.
> 
> Maybe sometimes on level 3+ we'll see something interesting,
> but I've no strong opinion on this.

Honestly, my first reaction was the same as Sergey's. But John has
a point that too many levels might be hard to read.

I think that 3 levels are a good start. We could always change it when we
hit a problem in practice.

> > Keep in mind that each additional level causes the reading of the logs
> > to be significantly more complex. Each level increases the output
> > exponentially:
> 
> Yes, I realize that. That's why I suggested that maybe recursive
> printk-s can have some special extra prefix. Recursive printk-s
> will interleave with whatever is being printed on this_cpu, so
> prefix might be helpful.

This is an interesting area, definitely. I am not sure if it is worth
it though.

I would keep it simple and cut output on 3rd level for now. We could
always improve it when we hit a problem in the real life.

Best Regards,
Petr
