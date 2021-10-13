Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA0842B30B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbhJMDDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:03:49 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44210 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236349AbhJMDDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:03:48 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19D31WW3004606;
        Wed, 13 Oct 2021 05:01:32 +0200
Date:   Wed, 13 Oct 2021 05:01:32 +0200
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
Message-ID: <20211013030131.GD4253@1wt.eu>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 05:23:11AM +0700, Ammar Faizi wrote:
> > > A.2.1 Calling Conventions"
> > >
> > > and that section explains which regs go where.
> >
> > Ok, that didn't point to the exact answer - I realize now. I believe
> > what you're looking for in that doc is "Figure 3.4: Register Usage"
> > which has a column "callee saved" and says that the syscall arg
> > registers are all not callee-saved.
> 
> No, you were right. A.2.1 was the part we are looking for, thanks for
> pointed that. That's the exact answer.

Yes I agree, that's exactly it, thank you Boris!

> According to x86-64 ABI about syscall section A.2 AMD64 Linux Kernel
> Conventions, A.2.1 Calling Conventions [1]:
> 
> 1) User-level applications use as integer registers for passing the
>    sequence %rdi, %rsi, %rdx, %rcx, %r8 and %r9. The kernel interface
>    uses %rdi, %rsi, %rdx, %r10, %r8 and %r9.
> 
> 2) A system-call is done via the syscall instruction. The kernel
>    destroys registers %rcx and %r11.
> 
> 3) The number of the syscall has to be passed in register %rax.
> 
> 4) System-calls are limited to six arguments, no argument is passed
>    directly on the stack.
> 
> 5) Returning from the syscall, register %rax contains the result of
>    the system-call. A value in the range between -4095 and -1
>    indicates an error, it is -errno.
> 
> 6) Only values of class INTEGER or class MEMORY are passed to the
>    kernel.
> 
> From (2), (5) and (6), we can conclude that Linux x86-64 syscall only
> clobbers rax, rcx and r11 (and "memory").
> 
>   - rax for the return value.
>   - rcx to save the return address.
>   - r11 to save the rflags.
> 
> Other registers are preserved. Right?

I totally agree, and this doc is perfectly clear on this. I think it
would be worth updating the comments in calling.h to reference this
document and remind these rules, given that they're not trivial to
figure from the code itself.

Willy
