Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715A541378C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhIUQ3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:29:38 -0400
Received: from foss.arm.com ([217.140.110.172]:36200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhIUQ3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:29:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EC87113E;
        Tue, 21 Sep 2021 09:28:08 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D13C53F718;
        Tue, 21 Sep 2021 09:28:06 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:28:04 +0100
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
Message-ID: <20210921162804.GD35846@C02TD0UTHF1T.local>
References: <20210920233237.90463-1-frederic@kernel.org>
 <20210920233237.90463-3-frederic@kernel.org>
 <YUmFFvZCb2yXn3os@hirez.programming.kicks-ass.net>
 <CAMj1kXEVjKGkRU_4JWH5d9YzT+pYVuEZYPNLw0VkUAb6d+W9kQ@mail.gmail.com>
 <20210921153352.GC35846@C02TD0UTHF1T.local>
 <CAMj1kXHQM9WOQutZg6P63=zQDE67jjfGv1tub1+W44LoZrON+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHQM9WOQutZg6P63=zQDE67jjfGv1tub1+W44LoZrON+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:55:11PM +0200, Ard Biesheuvel wrote:
> On Tue, 21 Sept 2021 at 17:33, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Sep 21, 2021 at 04:44:56PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 21 Sept 2021 at 09:10, Peter Zijlstra <peterz@infradead.org> wrote:
> ...
> > > >
> > > > So I like what Christophe did for PPC32:
> > > >
> > > >   https://lkml.kernel.org/r/6ec2a7865ed6a5ec54ab46d026785bafe1d837ea.1630484892.git.christophe.leroy@csgroup.eu
> > > >
> > > > Where he starts with an unconditional jmp and uses that IFF the offset
> > > > fits and only does the data load when it doesn't. Ard, woulnd't that
> > > > also make sense on ARM64? I'm thinking most in-kernel function pointers
> > > > would actually fit, it's just the module muck that gets to have too
> > > > large pointers, no?
> > > >
> > >
> > > Yeah, I'd have to page that back in. But it seems like the following
> > >
> > >   bti c
> > >   <branch>
> > >   adrp x16, <literal>
> > >   ldr x16, [x16, ...]
> > >   br x16
> > >
> > > with <branch> either set to 'b target' for the near targets, 'ret' for
> > > the NULL target, and 'nop' for the far targets should work, and the
> > > architecture permits patching branches into NOPs and vice versa
> > > without special synchronization.
> >
> > I think so, yes. We can do sligntly better with an inline literal pool
> > and a PC-relative LDR to fold the ADRP+LDR, e.g.
> >
> >         .align 3
> > tramp:
> >         BTI     C
> >         {B <func> | RET | NOP}
> >         LDR     X16, 1f
> >         BR      X16
> > 1:      .quad   <literal>
> >
> > Since that's in the .text, it's RO for regular accesses anyway.
> >
> 
> I tried to keep the literal in .rodata to avoid inadvertent gadgets
> and/or anticipate exec-only mappings of .text, but that may be a bit
> overzealous.

I think that in practice the risk of gadgetisation is minimal, and
having it inline means we only need to record a single address per
trampoline, so there's less risk that we get the patching wrong.

> > > But I must be missing something here, or why did we have that long
> > > discussion before?
> >
> > I think the long discussion was because v2 had some more complex options
> > (mostly due to trying to use ADRP+ADD) and atomicity/preemption issues
> > meant we could only transition between some of those one-way, and it was
> > subtle/complex:
> >
> > https://lore.kernel.org/linux-arm-kernel/20201028184114.6834-1-ardb@kernel.org/
> >
> 
> Ah yes, I was trying to use ADRP/ADD to avoid the load, and this is
> what created all the complexity.
> 
> > For v3, that was all gone, but we didn't have a user.
> >
> > Since the common case *should* be handled by {B <func> | RET | NOP }, I
> > reckon it's fine to have just that and the literal pool fallback (which
> > I'll definitely need for the sorts of kernel I run when fuzzing, where
> > the kernel Image itself can be 100s of MiBs).
> 
> Ack. So I'll respin this along these lines.

Sounds good!

> Do we care deeply about the branch and the literal being transiently
> out of sync?

I don't think we care about the tranisent window, since even if we just
patched a branch, a thread could be preempted immediately after the
branch and sit around blocked for a while. So it's always necessary to
either handle such threads taking stale branches, or to flip the branch
such that this doesn't matter (e.g. done once at boot time).

That said, I'd suggest that we always patch the literal, then patch the
{B| RET | NOP}, so that outside of patch times those are consistent with
one another and we can't accidentally get into a state were we use a
stale/bogus target after multiple patches. We can align the trampoline
such that we know it falls within a single page, so that we only need to
map/unmap it once (and the cost of the extra STR will be far smaller
than the map/unmap anyhow).

Thanks,
Mark.
