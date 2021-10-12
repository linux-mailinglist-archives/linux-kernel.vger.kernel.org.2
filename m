Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC4F8429D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhJLFbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:31:05 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44157 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231814AbhJLFa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:30:58 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19C5SMC5029148;
        Tue, 12 Oct 2021 07:28:22 +0200
Date:   Tue, 12 Oct 2021 07:28:22 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Message-ID: <20211012052822.GA28951@1wt.eu>
References: <20211011040344.437264-1-ammar.faizi@students.amikom.ac.id>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011040344.437264-1-ammar.faizi@students.amikom.ac.id>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ammar,

First, thanks for your patch. I have a few questions below.

On Mon, Oct 11, 2021 at 11:03:44AM +0700, Ammar Faizi wrote:
> Linux x86-64 syscall only clobbers rax, rcx and r11 (and "memory").
> 
>   - rax for the return value.
>   - rcx to save the return address.
>   - r11 to save the rflags.
> 
> Other registers are preserved.
> 
> Having r8, r9 and r10 in the syscall clobber list is harmless, but this
> results in a missed-optimization.
> 
> As the syscall doesn't clobber r8-r10, GCC should be allowed to reuse
> their value after the syscall returns to userspace. But since they are
> in the clobber list, GCC will always miss this opportunity.

I agree with your conclusion about this but need to be perfectly sure
about the exact clobber list since I got a different impression when
implementing the calls. I got the impression that these ones were
clobbered by reading entry_64.S below:

 * Registers on entry:
 * rax  system call number
 * rcx  return address
 * r11  saved rflags (note: r11 is callee-clobbered register in C ABI)
 * rdi  arg0
 * rsi  arg1
 * rdx  arg2
 * r10  arg3 (needs to be moved to rcx to conform to C ABI)
 * r8   arg4
 * r9   arg5
 * (note: r12-r15, rbp, rbx are callee-preserved in C ABI)

See this last note ? Indicating that r12-15, rbp and rbx are preserved
made me think it's not the case for the other ones, but that might of
course be a misunderstanding.

And calling.h says this:

 x86 function call convention, 64-bit:
 -------------------------------------
  arguments           |  callee-saved      | extra caller-saved | return
 [callee-clobbered]   |                    | [callee-clobbered] |
 ---------------------------------------------------------------------------
 rdi rsi rdx rcx r8-9 | rbx rbp [*] r12-15 | r10-11             | rax, rdx [**]

Note that it's indicated "function call convention", not "syscall",
leaving it open to have extra restrictions on syscalls. Later by
reading the POP_REGS macro called with pop_rdi=0 and skipr11rcx=1
on syscall leave, it seems to restore everything but r11, rcx, rax
and rdi (which is restored last with rsp).

As such, could you please add in your commit message a link to the
location where you found that authoritative information above it there
is a better place (i.e. one that doesn't require to read all the macros)?
This would significantly help anyone facing the same doubts about this
in the future.

Thank you!
Willy
