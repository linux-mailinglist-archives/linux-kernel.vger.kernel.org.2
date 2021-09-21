Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB80413643
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhIUPf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:35:26 -0400
Received: from foss.arm.com ([217.140.110.172]:35258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233985AbhIUPfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:35:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEEA5113E;
        Tue, 21 Sep 2021 08:33:56 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 451273F718;
        Tue, 21 Sep 2021 08:33:55 -0700 (PDT)
Date:   Tue, 21 Sep 2021 16:33:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Quentin Perret <qperret@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 2/4] arm64: implement support for static call trampolines
Message-ID: <20210921153352.GC35846@C02TD0UTHF1T.local>
References: <20210920233237.90463-1-frederic@kernel.org>
 <20210920233237.90463-3-frederic@kernel.org>
 <YUmFFvZCb2yXn3os@hirez.programming.kicks-ass.net>
 <CAMj1kXEVjKGkRU_4JWH5d9YzT+pYVuEZYPNLw0VkUAb6d+W9kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEVjKGkRU_4JWH5d9YzT+pYVuEZYPNLw0VkUAb6d+W9kQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:44:56PM +0200, Ard Biesheuvel wrote:
> On Tue, 21 Sept 2021 at 09:10, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Sep 21, 2021 at 01:32:35AM +0200, Frederic Weisbecker wrote:
> >
> > > +#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, target)                            \
> > > +     asm("   .pushsection    .static_call.text, \"ax\"               \n" \
> > > +         "   .align          3                                       \n" \
> > > +         "   .globl          " STATIC_CALL_TRAMP_STR(name) "         \n" \
> > > +         STATIC_CALL_TRAMP_STR(name) ":                              \n" \
> > > +         "   hint    34      /* BTI C */                             \n" \
> > > +         "   adrp    x16, 1f                                         \n" \
> > > +         "   ldr     x16, [x16, :lo12:1f]                            \n" \
> > > +         "   cbz     x16, 0f                                         \n" \
> > > +         "   br      x16                                             \n" \
> > > +         "0: ret                                                     \n" \
> > > +         "   .popsection                                             \n" \
> > > +         "   .pushsection    .rodata, \"a\"                          \n" \
> > > +         "   .align          3                                       \n" \
> > > +         "1: .quad           " target "                              \n" \
> > > +         "   .popsection                                             \n")
> >
> > So I like what Christophe did for PPC32:
> >
> >   https://lkml.kernel.org/r/6ec2a7865ed6a5ec54ab46d026785bafe1d837ea.1630484892.git.christophe.leroy@csgroup.eu
> >
> > Where he starts with an unconditional jmp and uses that IFF the offset
> > fits and only does the data load when it doesn't. Ard, woulnd't that
> > also make sense on ARM64? I'm thinking most in-kernel function pointers
> > would actually fit, it's just the module muck that gets to have too
> > large pointers, no?
> >
> 
> Yeah, I'd have to page that back in. But it seems like the following
> 
>   bti c
>   <branch>
>   adrp x16, <literal>
>   ldr x16, [x16, ...]
>   br x16
>
> with <branch> either set to 'b target' for the near targets, 'ret' for
> the NULL target, and 'nop' for the far targets should work, and the
> architecture permits patching branches into NOPs and vice versa
> without special synchronization.

I think so, yes. We can do sligntly better with an inline literal pool
and a PC-relative LDR to fold the ADRP+LDR, e.g.

	.align 3
tramp:
	BTI	C
	{B <func> | RET | NOP}
	LDR	X16, 1f
	BR	X16
1:	.quad	<literal>

Since that's in the .text, it's RO for regular accesses anyway.

> But I must be missing something here, or why did we have that long
> discussion before?

I think the long discussion was because v2 had some more complex options
(mostly due to trying to use ADRP+ADD) and atomicity/preemption issues
meant we could only transition between some of those one-way, and it was
subtle/complex:

https://lore.kernel.org/linux-arm-kernel/20201028184114.6834-1-ardb@kernel.org/

For v3, that was all gone, but we didn't have a user.

Since the common case *should* be handled by {B <func> | RET | NOP }, I
reckon it's fine to have just that and the literal pool fallback (which
I'll definitely need for the sorts of kernel I run when fuzzing, where
the kernel Image itself can be 100s of MiBs).

Thanks,
Mark.
