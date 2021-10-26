Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ED743B02E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhJZKjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:39:41 -0400
Received: from foss.arm.com ([217.140.110.172]:56576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234886AbhJZKjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:39:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D1501FB;
        Tue, 26 Oct 2021 03:37:00 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.74.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 190393F73D;
        Tue, 26 Oct 2021 03:36:57 -0700 (PDT)
Date:   Tue, 26 Oct 2021 11:36:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
Message-ID: <20211026103655.GB30152@C02TD0UTHF1T.local>
References: <20211025122102.46089-1-frederic@kernel.org>
 <20211025122102.46089-3-frederic@kernel.org>
 <YXa3q2AOH0T+smFy@hirez.programming.kicks-ass.net>
 <CAMj1kXELqoVp5zBcQ8g+0O56sBq9qAEDO-7OTenDkpRcb7oeQQ@mail.gmail.com>
 <YXa85OTw7i3Bg9yj@hirez.programming.kicks-ass.net>
 <YXbC3NRWDDfsW6DG@hirez.programming.kicks-ass.net>
 <CAMj1kXEKASsYJMHHNA=uNGTnLMoXO_4BP0--1k7cEfZZupdsog@mail.gmail.com>
 <YXbHJCtkBdMP/bF6@hirez.programming.kicks-ass.net>
 <CAMj1kXHYXzU=pW6tUJB61QW5VBL7WKBhT7BkNJ970FQdHz1VVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHYXzU=pW6tUJB61QW5VBL7WKBhT7BkNJ970FQdHz1VVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 05:10:24PM +0200, Ard Biesheuvel wrote:
> On Mon, 25 Oct 2021 at 17:05, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Oct 25, 2021 at 04:55:17PM +0200, Ard Biesheuvel wrote:
> > > On Mon, 25 Oct 2021 at 16:47, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > Perhaps a little something like so.. Shaves 2 instructions off each
> > > > trampoline.
> > > >
> > > > --- a/arch/arm64/include/asm/static_call.h
> > > > +++ b/arch/arm64/include/asm/static_call.h
> > > > @@ -11,9 +11,7 @@
> > > >             "   hint    34      /* BTI C */                             \n" \
> > > >                 insn "                                                  \n" \
> > > >             "   ldr     x16, 0b                                         \n" \
> > > > -           "   cbz     x16, 1f                                         \n" \
> > > >             "   br      x16                                             \n" \
> > > > -           "1: ret                                                     \n" \
> > > >             "   .popsection                                             \n")
> > > >
> > > >  #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)                      \
> > > > --- a/arch/arm64/kernel/patching.c
> > > > +++ b/arch/arm64/kernel/patching.c
> > > > @@ -90,6 +90,11 @@ int __kprobes aarch64_insn_write(void *a
> > > >         return __aarch64_insn_write(addr, &i, AARCH64_INSN_SIZE);
> > > >  }
> > > >
> > > > +asm("__static_call_ret:                \n"
> > > > +    "  ret                     \n")
> > > > +
> > >
> > > This breaks BTI as it lacks the landing pad, and it will be called indirectly.
> >
> > Argh!
> >
> > > > +extern void __static_call_ret(void);
> > > > +
> > >
> > > Better to have an ordinary C function here (with consistent linkage),
> > > but we need to take the address in a way that works with Clang CFI.
> >
> > There is that.
> >
> > > As the two additional instructions are on an ice cold path anyway, I'm
> > > not sure this is an obvious improvement tbh.
> >
> > For me it's both simpler -- by virtue of being more consistent, and
> > smaller. So double win :-)
> >
> > That is; you're already relying on the literal being unconditionally
> > updated for the normal B foo -> NOP path, and having the RET -> NOP path
> > be handled differently is just confusing.
> >
> > At least, that's how I'm seeing it today...
> 
> Fair enough. I don't have a strong opinion either way, so I'll let
> some other arm64 folks chime in as well.

My preference overall is to keep the trampoline self-contained, and I'd
prefer to keep the RET inline in the trampoline rather than trying to
factor it out so that all the control-flow is clearly in one place.

So I'd prefer that we have the sequence as-is:

| 0:	.quad 0x0
| 	bti	c
| 	< insn >
| 	ldr	x16, 0b
| 	cbz	x16, 1f
| 	br	x16
| 1:	ret

If we knew these were only called with IRQs enabled (and so we can take
an IPI to generate a context synchronization event), we could patch
<insn> to a RET and point the literal back at the BTI, e.g.

| 0:	.quad 0x0
| 	bti	c
| 	< insn >
| 	ldr	x16, 0b
| 	br	x16

... but I'm pretty sure there are CPUs that will never re-fetch <insn>
in that case, and will get stuck in an infinite loop.

Thanks,
Mark.
