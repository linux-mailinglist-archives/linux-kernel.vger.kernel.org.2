Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D445A32353F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 02:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBXBZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 20:25:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234266AbhBXBSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 20:18:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19AEA64E21;
        Wed, 24 Feb 2021 01:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614129480;
        bh=86XcHlF24lJqHiMo+fdjoQ2fYPikmlQK7DrPdc7bRno=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ueF7RoYxYz8iPaU9NGA6xd65paklKB+k8vqv8jFT+QWFq43XD+lcj/6kxXniAKOiu
         PmsB7JPU0LmUzK0EUjftALWmFJh3WBZvmx72CcyvOyRuyhKEDNa4MmY2C/sAw6FyKp
         GfTu9UUybxPsICc5zYkkdK1xQsoQaoRxEM1GKEU0EZ8X4RHVIhtzxnVSdLkGoxrIve
         V8psx+Tjstaj4FDhagIquZTKhphbUtu0j43qyOirMHlQ0R8C7b6bwX1NKKrKerfkVO
         TPI3nVhMyjW61EMM90NJTbubqXiUydLRSH10yluwNveTEqqLFGEs3ZnrZxPS38Y5Q0
         /aRchvxKO1Sng==
Date:   Wed, 24 Feb 2021 10:17:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: Why do kprobes and uprobes singlestep?
Message-Id: <20210224101756.bbdf95b9b6dfc982bff21324@kernel.org>
In-Reply-To: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 15:24:19 -0800
Andy Lutomirski <luto@kernel.org> wrote:

> A while back, I let myself be convinced that kprobes genuinely need to
> single-step the kernel on occasion, and I decided that this sucked but
> I could live with it.  it would, however, be Really Really Nice (tm)
> if we could have a rule that anyone running x86 Linux who single-steps
> the kernel (e.g. kgdb and nothing else) gets to keep all the pieces
> when the system falls apart around them.  Specifically, if we don't
> allow kernel single-stepping and if we suitably limit kernel
> instruction breakpoints (the latter isn't actually a major problem),
> then we don't really really need to use IRET to return to the kernel,
> and that means we can avoid some massive NMI nastiness.

Would you mean using "pop regs + popf + ret" instead of IRET after
int3 handled for avoiding IRET releasing the NMI mask? Yeah, it is
possible. I don't complain about that.

However, what is the relationship between the IRET and single-stepping?
I think we can do same thing in do_debug...

> But I was contemplating the code, and I'm no longer convinced.
> Uprobes seem to single-step user code for no discernable reason.
> (They want to trap after executing an out of line instruction, AFAICT.
> Surely INT3 or even CALL after the out-of-line insn would work as well
> or better.)  Why does kprobe single-step?  I spend a while staring at
> the code, and it was entirely unclear to me what the purpose of the
> single-step is.

For kprobes, there are 2 major reasons for (still relaying on) single stepping.
One is to provide post_handler, another is executing the original code,
which is replaced by int3, without modifying code nor emulation.
Indeed, most of the instructions actually not depends on the ip register,
in that case (and user doesn't set post_handler), kprobe already skips
single stepping (a.k.a. kprobe booster, jump back to the kernel code after
executing out-of-line instruction.)
However, since some instructions, e.g. jump, call and ret, changes the ip
register (and stack), we have to do a fixup afterwards. 

But yes, it is possible to emulate, as same as arm/arm64 does. I just
concern about side-effects of the emulation, need to be carefully
implemented.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
