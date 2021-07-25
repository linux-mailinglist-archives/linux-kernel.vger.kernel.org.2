Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D152F3D4F0A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGYQkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 12:40:05 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:46052 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGYQkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 12:40:01 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7hlX-003rvn-Nr; Sun, 25 Jul 2021 17:18:15 +0000
Date:   Sun, 25 Jul 2021 17:18:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC][CFT] signal handling fixes
Message-ID: <YP2c1xk9LJ0zE3KW@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Back in 2012 or so I'd found a bunch of fun issues with multiple
pending signals on a lot of architectures.  m68k looked scarier than
usual (due to the combination of variable-sized exception frames with the
way kernel stack pointer is handled by the hardware), but I'd convinced
myself that it had been correct.

	Unfortunately, I was wrong - handling of multiple pending signals
does *not* work correctly there.

	Some background: wrt exception stack frames m68k variants fall
into 3 groups -
	1) 68000 and near relatives (all non-MMU): push 32bit PC, then
push 16bit SR.
	2) everything later than that, except for coldfire: push a
variable amount of auxillary data (used for insn restart, among other
things), then 16bit value encoding the format (upper 4 bits) and vector
(lower 12), then same as for (1) - 32bit PC and 16bit SR.  Size of
variable part depends upon the frame type (upper 4 bits of frame/vector
word).	Note that CPU32 falls into that group, even though it's non-MMU.
	3) coldfire (both MMU and non-MMU): push 32bit PC, then 16bit SR,
then 16bit word superficially similar to format/vector combination on (2).

	Handling of (2) is complicated, since we need the right frame
type when we go from kernel to userland.  In particular, we want format 0
(8-byte) for entering a signal handler, no matter how did we enter the
kernel when we caught the signal.  Conversely, when we return from signal
handler, we have format 0 on kernel entry (sigreturn(2) is a syscall) and
we need whatever frame we used to have back when we'd caught the signal.

	The monumentally unpleasant part is that we *must* leave the
kernel mode with the same value of kernel stack pointer we had on entry.
Crossing from user to kernel mode does not set the kernel stack pointer
to known value - its value is kept since the last time we'd left the
kernel mode.

	The sigreturn part is ugly as hell.  Signal delivery avoids
quite that level of nastiness by the following trick: there's an int
(stkadj, initially 0) between the exception frame and the rest of pt_regs.
On the way back from exception we pop the registers, then add stkadj +
4 to stack pointer before doing RTE.  Normally stkadj remains zero;
if we need to shrink the exception stack frame, we put the minimal one
over the aux data and store the offset into stkadj.  When on the way out
we pop our way through the registers, we'll end up with stack pointer
pointing to stkadj (4 bytes below the original exception stack frame)
and once we add 4 + stkadj to stack pointer, we have the minimal exception
stack frame on top of stack and RTE does the right thing.

	The problem with that trick is that exception stack frame in
pt_regs is no longer valid; in the best case regs->format will match
the original exception stack frame format and in the worst case it'll
be overwritten by bits 31..28 of signal handler address (if aux data
used to be 4 bytes long).

	ptrace get_regs()/set_regs() takes that effect into account when
accessing PC and SR; unfortunately, setup_frame() and setup_rt_frame()
do not.  That's not a problem for the first signal - ->stkadj is still
0 at that point.  However, if we end up building multiple sigframes,
we might get screwed.  Not hard to fix, thankfully...

	Another bug is on the sigreturn side of things, and that one is
my fault - in bd6f56a75bb2 ("m68k: Missing syscall_trace() on sigreturn")
I'd missed the fact that we'd just relocated pt_regs, without having
updated ->thread.esp0.

	These two are, IMO, -stable fodder.  The third one isn't -
it cleans sigreturn, hopefully making it less convoluted.  Instead of
doing unnatural things to C stack frames, call chain, etc. we let the
asm wrapper of {rt_,}sigreturn(2) do the following:
	reserve a gap on stack, sufficiently large to hold any aux data
	then call the C side of things, passing pt_regs and switch_stack
pointers to it, same as we do now if C part decides to insert aux data,
	it can simply use memmove
to shift switch_stack + pt_regs and memcpy whatever's needed into the
created gap.  Then we can return without any kind of magic - the C part
of stack is intact.  Just return the new location of switch_stack +
pt_regs to the (asm) caller, so it could set stack pointer to it.

	The series is on top of 5.14-rc1; it lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #untested.m68k
Individual patches in followups...

	_Very_ lightly tested on aranym; no real hardware to test it on.
Any help with review and testing would be very welcome.

PS:  FWIW, ifdefs in arch/m68k/kernel/signal.c are wrong - it's not !MMU
vs. coldfire/MMU vs. classic/MMU.  It's actually 68000 vs. coldfire vs.
everything else.  These days it's nearly correct, but only because on MMU
variants of coldfire we never see exception stack frames with type other
than 4 - it's controlled by alignment of kernel stack pointer on those,
and it's under the kernel control, so it's always 32bit-aligned.  It used
to be more serious back when we had 68360 support - that's !MMU and exception
stack frames are like those on 68020, unless I'm misreading their manual...
