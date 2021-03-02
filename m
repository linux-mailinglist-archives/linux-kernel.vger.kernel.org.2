Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7D632A0D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576680AbhCBEcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:32:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1443711AbhCBCXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:23:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BFDD614A7;
        Tue,  2 Mar 2021 02:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614651750;
        bh=twucalpitITdHszx7+x7EMGhA3/YxluCVY+oR0edqW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LFinN9m/tx28kMdWUQbQb8VIklLB1k4t8oBFCQWx3cLQ/kN3j6SEjnM0roIDjMS5h
         PGtbAcXUayBAWIwpUcvcj1+UhtPEgmszxmpjJe/CVR3iZtsnl1MoF6nSheHaD6blH2
         /FYY6D+DNyG0SbiBikm0pYVSzSRFOpeQrm8SxIidXKiWo+l78XE6HOCCBmyxJIvzvr
         0wbgz3n1+2/GGhfTnYQb7jKMSrm8Vh7VSRxN4ixMAeYjpxyp41AUtt0WIcdUxxHLul
         xXyUOs932wF0bhN5pZCRHNRsw6jra/tjRD7mQPl+C62zvGAIsf5UbzOFmk0itiIDE8
         kCo2exah6Xysw==
Date:   Tue, 2 Mar 2021 11:22:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Why do kprobes and uprobes singlestep?
Message-Id: <20210302112224.6b3568434be490fbfbdec790@kernel.org>
In-Reply-To: <20210301165130.GA5351@redhat.com>
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
        <20210301165130.GA5351@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg and Andy,

On Mon, 1 Mar 2021 17:51:31 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> Hi Andy,
> 
> sorry for delay.
> 
> On 02/23, Andy Lutomirski wrote:
> >
> > A while back, I let myself be convinced that kprobes genuinely need to
> > single-step the kernel on occasion, and I decided that this sucked but
> > I could live with it.  it would, however, be Really Really Nice (tm)
> > if we could have a rule that anyone running x86 Linux who single-steps
> > the kernel (e.g. kgdb and nothing else) gets to keep all the pieces
> > when the system falls apart around them.  Specifically, if we don't
> > allow kernel single-stepping and if we suitably limit kernel
> > instruction breakpoints (the latter isn't actually a major problem),
> > then we don't really really need to use IRET to return to the kernel,
> > and that means we can avoid some massive NMI nastiness.
> 
> Not sure I understand you correctly, I know almost nothing about low-level
> x86  magic.

x86 has normal interrupt and NMI. When an NMI occurs the CPU masks NMI
(the mask itself is hidden status) and IRET releases the mask. The problem
is that if an INT3 is hit in the NMI handler and does a single-stepping,
it has to use IRET for atomically setting TF and return.

> 
> But I guess this has nothing to do with uprobes, they do not single-step
> in kernel mode, right?

Agreed, if the problematic case is IRET from NMI handler, uprobes doesn't
hit because it only invoked from user-space.
Andy, what would you think?

> > Uprobes seem to single-step user code for no discernable reason.
> > (They want to trap after executing an out of line instruction, AFAICT.
> > Surely INT3 or even CALL after the out-of-line insn would work as well
> > or better.)
> 
> Uprobes use single-step from the very beginning, probably because this
> is the most simple and "standard" way to implement xol.
> 
> And please note that CALL/JMP/etc emulation was added much later to fix the
> problems with non-canonical addresses, and this emulation it still incomplete.

Yeah, I found another implementation of the emulation afterwards. Of cource
since uprobes only treat user-space, it maybe need more care.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
