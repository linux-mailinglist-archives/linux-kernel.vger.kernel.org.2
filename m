Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1158324C99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhBYJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236084AbhBYJL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:11:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A109464EC3;
        Thu, 25 Feb 2021 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614244278;
        bh=X5KBf9U/WobuVOv+5t26GFL+AWng3GR196FyiFebKpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ion9QI3SaDmFVBubZgTlqOG+wr2ovnWaWNJkKlQitEA5BT7PEfA3dPT01D+jngZwe
         O3AXmfTFyrAc4jOEIuQjbtEqi1V48deQK7Yk0k+Rs5LgbvHxwlrS0uEOpHVqGtFOIv
         sNY6vbHfA+JhzBx8eFmRVJyhcasdGCPKdGzHtp4FxQ+Jsz4Kaje0KqCvbBImAxJvLg
         WsuMXrumUYowYcr3hdSLSa9cF+Rf8RYdN4fzN3ZIEpOPBean1cuWrK9afS5oXv23na
         tH5US1o7oHxKpiOk4PuWaQAL5pPAmqY1s6F1BbrqTC47T1DtiNVv1fnQzWUYdAi4+f
         quYxNiHakwGEw==
Date:   Thu, 25 Feb 2021 18:11:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Why do kprobes and uprobes singlestep?
Message-Id: <20210225181114.e8e92e2fc2a204219b1bd28d@kernel.org>
In-Reply-To: <CALCETrVUBd5CuAh5TRTFqbCE2mYCiBvqrPouTicC0pyO7A6GWw@mail.gmail.com>
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
        <20210224101756.bbdf95b9b6dfc982bff21324@kernel.org>
        <CALCETrWoKh0aemrvTGZ13bUzN27s3WGW3CyvTptvayWLQEk91Q@mail.gmail.com>
        <20210225112245.607c70ec13cf8d279390e89e@kernel.org>
        <CALCETrVUBd5CuAh5TRTFqbCE2mYCiBvqrPouTicC0pyO7A6GWw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 22:03:12 -0800
Andy Lutomirski <luto@kernel.org> wrote:

> On Wed, Feb 24, 2021 at 6:22 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed, 24 Feb 2021 11:45:10 -0800
> > Andy Lutomirski <luto@kernel.org> wrote:
> >
> > > On Tue, Feb 23, 2021 at 5:18 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Tue, 23 Feb 2021 15:24:19 -0800
> > > > Andy Lutomirski <luto@kernel.org> wrote:
> > > >
> > > > > A while back, I let myself be convinced that kprobes genuinely need to
> > > > > single-step the kernel on occasion, and I decided that this sucked but
> > > > > I could live with it.  it would, however, be Really Really Nice (tm)
> > > > > if we could have a rule that anyone running x86 Linux who single-steps
> > > > > the kernel (e.g. kgdb and nothing else) gets to keep all the pieces
> > > > > when the system falls apart around them.  Specifically, if we don't
> > > > > allow kernel single-stepping and if we suitably limit kernel
> > > > > instruction breakpoints (the latter isn't actually a major problem),
> > > > > then we don't really really need to use IRET to return to the kernel,
> > > > > and that means we can avoid some massive NMI nastiness.
> > > >
> > > > Would you mean using "pop regs + popf + ret" instead of IRET after
> > > > int3 handled for avoiding IRET releasing the NMI mask? Yeah, it is
> > > > possible. I don't complain about that.
> > >
> > > Yes, more or less.
> > >
> > > >
> > > > However, what is the relationship between the IRET and single-stepping?
> > > > I think we can do same thing in do_debug...
> > >
> > > Because there is no way to single-step without using IRET.  POPF; RET
> > > will trap after RET and you won't make forward progress.
> >
> > Ah, indeed. "POPF; RET" is not atomically exceute.
> >
> > > > > But I was contemplating the code, and I'm no longer convinced.
> > > > > Uprobes seem to single-step user code for no discernable reason.
> > > > > (They want to trap after executing an out of line instruction, AFAICT.
> > > > > Surely INT3 or even CALL after the out-of-line insn would work as well
> > > > > or better.)  Why does kprobe single-step?  I spend a while staring at
> > > > > the code, and it was entirely unclear to me what the purpose of the
> > > > > single-step is.
> > > >
> > > > For kprobes, there are 2 major reasons for (still relaying on) single stepping.
> > > > One is to provide post_handler, another is executing the original code,
> > > > which is replaced by int3, without modifying code nor emulation.
> > >
> > > I don't follow.  Suppose we execute out of line.  If we originally have:
> > >
> > > INSN
> > >
> > > we replace it with:
> > >
> > > INT3
> > >
> > > and we have, out of line:
> > >
> > > INSN [but with displacement modified if it's RIP-relative]
> > >
> > > right now, we single-step the out of line copy.  But couldn't we instead do:
> > >
> > > INSN [but with displacement modified if it's RIP-relative]
> > > INT3
> >
> > If the INSN is "jmp +127", it will skip the INT3. So those instructions
> > must be identified and emulated. We did it already in the arm64 (see commit
> > 7ee31a3aa8f4 ("arm64: kprobes: Use BRK instead of single-step when executing
> >  instructions out-of-line")), because arm64 already emulated the branch
> > instructions. I have to check x86 insns can be emulated without side-effects.
> 
> Off the top of my head:
> 
> JMP changes RIP but has no other side effects.  Jcc is the same except
> that the condition needs checking, which would be a bit tedious.
> 
> CALL changes RIP and does a push but has no other side effects.  We
> have special infrastructure to emulate CALL from int3 context:
> int3_emulate_call().

Yeah, I remember that a gap was introduced for int3_emulate_call().
These helps me to implement emulation.

> 
> RET pops and changes RIP.  No other side effects.
> 
> RET imm is rare.  I don't think it occurs in the kernel at all.
> 
> LRET is rare.  I don't think kprobe needs to support it.
> 
> JMP FAR and CALL FAR are rare.  I see no reason to support them.

I see those are rare, but supporting those is not hard.

> 
> IRET is rare, and trying to kprobe it seems likely to cause a
> disaster, although it's within the realm of possibility that the IRET
> in sync_core() could work.

Agreed. Iret should not be probed.


> > > or even
> > >
> > > INSN [but with displacement modified if it's RIP-relative]
> > > JMP kprobe_post_handler
> >
> > This needs a sequence of push-regs etc. ;)
> >
> > >
> > > and avoid single-stepping?
> > >
> > > I guess I see the point for CALL, JMP and RET, but it seems like we
> > > could emulate those cases instead fairly easily.
> >
> > OK, let's try to do it. I think it should be possible because even in the
> > current code, resume fixup code (adjust IP register) works only for a few
> > groups of instructions.
> 
> I suspect that emulating them would give a nice performance boost,
> too.  Single-stepping is very slow on x86.

Yeah, that's same on arm64. Jean reported eliminating single-step
gained the performance.

> 
> I should let you know, though, that I might have found a sneaky
> alternative solution to handling NMIs, so this is a bit lower priority
> from my perspective than I thought it was.  I'm not quite 100%
> convinced my idea works, but I'll play with it.

Does that involve kprobes? Anyway, I'll try to remove single-step by
emulation and int3.

Thank you,


> 
> --Andy
> 
> >
> > Thank you,
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
