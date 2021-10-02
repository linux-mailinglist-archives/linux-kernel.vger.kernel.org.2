Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A5B41FED3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 01:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhJBX7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 19:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234050AbhJBX7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 19:59:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BEC161A03;
        Sat,  2 Oct 2021 23:57:20 +0000 (UTC)
Date:   Sat, 2 Oct 2021 19:57:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC][PATCH] tracing: Define "fake" struct trace_pid_list
Message-ID: <20211002195718.0b5d9b67@oasis.local.home>
In-Reply-To: <CAHk-=whpkoC4wDPDUtVs22aZ=5v2bzAUPTGZTxnK19qB6euRug@mail.gmail.com>
References: <7E585A79-A705-4CB9-9E4C-0E73DCE237E2@goodmis.org>
        <CAHk-=whpkoC4wDPDUtVs22aZ=5v2bzAUPTGZTxnK19qB6euRug@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Oct 2021 15:39:45 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Oct 2, 2021 at 1:04 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> > [ Note, this is on top of my tree in ftrace/core, but wanted to ask if
> >   this is the proper "fix".  
> 
> Ugh, please no. This is going to be very confusing, and it's going to
> mess with anything that does things based on type (eg traditionally
> module signatures etc).

This is why I asked ;-)

> 
> I'd rather you just expose the proper type, if that is what it takes.

I can, as I'm currently the only one using this, it should be fine. I
just like to not expose structures that shouldn't be touched, but
that's my preference, but that's not really that common of a habit in
the kernel anyway.

> 
> > Some compilers give this error:  
> 
> Only some? Which ones? And what did you do to make it appear? Sounds
> like whatever change wasn't worth it.

Yes, this is what surprised me. It worked on all my machines and for
most of my tests, which are pretty much all gcc 10.X. But for one of my
tests, I compile with gcc 8.1.0 (one I pulled down from kernel.org a
while ago), and that's the one that blew up.

It has nothing to do with the config (the same config compiles fine
with gcc 10.x). And if I didn't have a test that compiled with 8.1.0, I
would never had know this was an issue.

> 
> The advantage of some "opaque type" does _not_ override the
> disadvantage of then having to make up these kinds of horrific
> workarounds that actively lie to the compiler.

I felt uncomfortable with the change, and that's why I wanted to get
your opinion before having you first see it in a pull request.

> 
> We have tons of structures (and occasionally single structure members)
> that we don't want people to access directly, and instead use a
> wrapper function. That doesn't mean that they can't be exposed as a
> type.
> 
> > The reason is that rcu_dereference_sched() has a check that uses
> > typeof(*p) of the pointer passed to it.  
> 
> Sadly, we do that for a reason - we do a
> 
>      typeof(*p) *__local_p;
> 
> to drop the address space specifiers from (or add them to) the pointer.
> 
> That said, I wonder how many of them are actually needed. At least
> some of them are purely for sparse
> 
> So at least some could probably just use
> 
>      typeof(p) __local_p;
> 
> instead, which would avoid the problem with a pointer to an incomplete
> type (and keep it as a pointer to an incomplete type).
> 
> So one option might be to work on the RCU accessor macros instead.

I looked at changing them, but for the one place:

	((typeof(*p) __force __kernel *)(_________p1)); 

Where there's a separation from the type and adding of "__force __kernel"
before the pointer. Not sure if it matters or not.

I'll do a little investigation, and see if tweaks to these RCU macros
will fix it, otherwise, I'll just move the structure back out to being
public.

Thanks for the feedback,

-- Steve
