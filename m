Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1DF4442BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhKCN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 09:56:11 -0400
Received: from foss.arm.com ([217.140.110.172]:59644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhKCNzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 09:55:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2385ED1;
        Wed,  3 Nov 2021 06:52:58 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.75.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5E03F7B4;
        Wed,  3 Nov 2021 06:52:57 -0700 (PDT)
Date:   Wed, 3 Nov 2021 13:52:49 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] sched/core for v5.16-rc1
Message-ID: <20211103135249.GA38767@C02TD0UTHF1T.local>
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864855.3357115.17938524897008353101.tglx@xen13>
 <CAHk-=whEbr+0ZSRMkQ1wqLCeBEiK7o2-Hm=55aTBpdeVxnFbVQ@mail.gmail.com>
 <CAHk-=whwxyA11LQ+0y73nJAS4ZB=s8CeYM6OGCEzKiy+8fyLiw@mail.gmail.com>
 <YYD5ti23DQUjdQdz@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYD5ti23DQUjdQdz@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 09:41:26AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 01, 2021 at 02:27:49PM -0700, Linus Torvalds wrote:
> > On Mon, Nov 1, 2021 at 2:01 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > Unwinders that need locks because they can do bad things if they are
> > > working on unstable data are EVIL and WRONG.
> > 
> > Note that this is fundamental: if you can fool an unwider to do
> > something bad just because the data isn't stable, then the unwinder is
> > truly horrendously buggy, and not usable.
> 
> From what I've been led to believe, quite a few of our arch unwinders
> seem to fall in that category. They're mostly only happy when unwinding
> self and don't have many guardrails on otherwise.
> 
> > It could be a user process doing bad things to the user stack frame
> > from another thread when profiling is enabled.
> 
> Most of the unwinders seem to only care about the kernel stack. Not the
> user stack.

Yup; there are usually separate unwinders for user/kernel, since there
are different constaints (and potentially different ABIs for unwinding).

> > It could be debug code unwinding without locks for random reasons.
> > 
> > So I really don't like "take a lock for unwinding". It's a pretty bad
> > bug if the lock required.
> 
> Fair enough; te x86 unwinder is pretty robust in this regard, but it
> seems to be one of few :/

FWIW, the arm64 kernel unwinder also shouldn't blow up (so long as the
target stack is pinned via try_get_stack() or similar).

However, depending on how the task reuses the stack, the results can be
entirely bogus rather than just stale, since data on the stack can look
like a kernel pointer (even if that's fairly unllikely). I'm happy to
believe that we don't care aobut that for wchan, but it's not something
I'd like to see spread.

> > The "Link" in the commit also is entirely useless, pointing back to
> > the emailed submission of the patch, rather than any useful discussion
> > about why the patch happened.
> 
> So the initial discussion started here:
> 
>   https://lkml.kernel.org/r/20210923233105.4045080-1-keescook@chromium.org
> 
> A later thread that might also be of interest is:
> 
>   https://lkml.kernel.org/r/YWgyy+KvNLQ7eMIV@shell.armlinux.org.uk
> 
> Also, an even later thread proposes to push that lock into more stack
> unwinding functions (anything doing remote unwinds):
> 
>   https://lkml.kernel.org/r/20211022150933.883959987@infradead.org
> 
> But it seems to be you're thinking that's fundamentally buggered and
> people should instead invest in fixing their unwinders already.
> 
> Now, as is, this stuff is user exposed through /proc/$pid/{wchan,stack}
> and as such I think it *can* do with a few extra guardrails in generic
> code. OTOH, /proc/$pid/stack is root only.
> 
> Also, the remote stack-trace code is hooked into bpf (because
> kitchen-sink) and while I didn't look too hard, I can imagine it could
> be used to trigger crashes on our less robust architectures if prodded
> just right.

I do worry that remote unwinds from BPF are just silently generating
junk, but it's not clear to me what they're actually used for and how
much that matters. I don't understand why a remote unwind is necessary
at all.

> Should I care about all this from a generic code PoV, or simply let the
> architectures that got it 'wrong' deal with it?

FWIW I'm happy either way. There are some upcoming improvements to the
arm64 unwinder that currently conflict and I need to know whether to
wait and rebase or assume that we take those first.

Thanks,
Mark.
