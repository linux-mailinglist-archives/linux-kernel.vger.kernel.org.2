Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B374429B1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 09:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhKBIoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 04:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBIoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 04:44:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114DC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3BEXy8GwzZQ3fDm1+lqzvru3zKOVn9eL8TsT/KZwkmc=; b=mC5U9NcELcrsmslzdOXAIF1hvO
        CcOzlWzFkcgY/kPpx7DL9zevDZk8shKWYTf9z6USZ7DLgZiOUa0QVRTaTCYVWlXV79hWg63kpk6dN
        DM7PB3Rj2/e8nKVyo3oo9piMIOXqRkb9l0wh46nLanlo2mT9inJVhUMAmgb/xi7yoB56PipVEqhFr
        lw/iOyhWQsHg2WgoHj3xsAjGOI7kXTk4ZlxRw9zvwjSfBG7LFnwXJ9aR17tR63RZjqeWi67o/X6Rb
        WTiINrP3kYpLAEty/wwcbl3AUkZNp+z6lPvG0ZV7xzjhVNh2AWltFMyX3rRdE0i0gA+vMlDHCzF3w
        F9fgXniQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhpMG-00DiyZ-4v; Tue, 02 Nov 2021 08:41:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 359F7300366;
        Tue,  2 Nov 2021 09:41:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1253C2D202F0C; Tue,  2 Nov 2021 09:41:26 +0100 (CET)
Date:   Tue, 2 Nov 2021 09:41:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [GIT pull] sched/core for v5.16-rc1
Message-ID: <YYD5ti23DQUjdQdz@hirez.programming.kicks-ass.net>
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864855.3357115.17938524897008353101.tglx@xen13>
 <CAHk-=whEbr+0ZSRMkQ1wqLCeBEiK7o2-Hm=55aTBpdeVxnFbVQ@mail.gmail.com>
 <CAHk-=whwxyA11LQ+0y73nJAS4ZB=s8CeYM6OGCEzKiy+8fyLiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whwxyA11LQ+0y73nJAS4ZB=s8CeYM6OGCEzKiy+8fyLiw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 02:27:49PM -0700, Linus Torvalds wrote:
> On Mon, Nov 1, 2021 at 2:01 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Unwinders that need locks because they can do bad things if they are
> > working on unstable data are EVIL and WRONG.
> 
> Note that this is fundamental: if you can fool an unwider to do
> something bad just because the data isn't stable, then the unwinder is
> truly horrendously buggy, and not usable.

From what I've been led to believe, quite a few of our arch unwinders
seem to fall in that category. They're mostly only happy when unwinding
self and don't have many guardrails on otherwise.

> It could be a user process doing bad things to the user stack frame
> from another thread when profiling is enabled.

Most of the unwinders seem to only care about the kernel stack. Not the
user stack.

> It could be debug code unwinding without locks for random reasons.
> 
> So I really don't like "take a lock for unwinding". It's a pretty bad
> bug if the lock required.

Fair enough; te x86 unwinder is pretty robust in this regard, but it
seems to be one of few :/

> The "Link" in the commit also is entirely useless, pointing back to
> the emailed submission of the patch, rather than any useful discussion
> about why the patch happened.

So the initial discussion started here:

  https://lkml.kernel.org/r/20210923233105.4045080-1-keescook@chromium.org

A later thread that might also be of interest is:

  https://lkml.kernel.org/r/YWgyy+KvNLQ7eMIV@shell.armlinux.org.uk

Also, an even later thread proposes to push that lock into more stack
unwinding functions (anything doing remote unwinds):

  https://lkml.kernel.org/r/20211022150933.883959987@infradead.org

But it seems to be you're thinking that's fundamentally buggered and
people should instead invest in fixing their unwinders already.


Now, as is, this stuff is user exposed through /proc/$pid/{wchan,stack}
and as such I think it *can* do with a few extra guardrails in generic
code. OTOH, /proc/$pid/stack is root only.

Also, the remote stack-trace code is hooked into bpf (because
kitchen-sink) and while I didn't look too hard, I can imagine it could
be used to trigger crashes on our less robust architectures if prodded
just right.

Should I care about all this from a generic code PoV, or simply let the
architectures that got it 'wrong' deal with it?
