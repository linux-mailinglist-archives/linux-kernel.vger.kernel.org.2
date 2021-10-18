Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A23430F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhJRFBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 01:01:43 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:44337 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhJRFBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:01:40 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 19I4wT6m015467;
        Mon, 18 Oct 2021 06:58:29 +0200
Date:   Mon, 18 Oct 2021 06:58:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Bedirhan KURT <windowz414@gnuweeb.org>,
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: Re: [PATCH 2/2] tools/nolibc: x86-64: Fix startup code bug
Message-ID: <20211018045828.GA15329@1wt.eu>
References: <20211013090339.622070-1-ammar.faizi@students.amikom.ac.id>
 <dRLArKzRMqajy1jA86k0vg-ammarfaizi2@gnuweeb.org>
 <CtypPaXXhVINRV0090UVzA-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CtypPaXXhVINRV0090UVzA-ammarfaizi2@gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ammar,

sorry for the delay, I needed to check a few things first.

On Fri, Oct 15, 2021 at 03:25:07PM +0700, Ammar Faizi wrote:
> Before this patch, the _start function looks like this:
> 
> 0000000000001170 <_start>:
>     1170:	pop    %rdi
>     1171:	mov    %rsp,%rsi
>     1174:	lea    0x8(%rsi,%rdi,8),%rdx
>     1179:	and    $0xfffffffffffffff0,%rsp
>     117d:	sub    $0x8,%rsp
>     1181:	call   1000 <main>
>     1186:	movzbq %al,%rdi
>     118a:	mov    $0x3c,%rax
>     1191:	syscall
>     1193:	hlt
>     1194:	data16 cs nopw 0x0(%rax,%rax,1)
>     119f:	nop
> 
> Note the "and" to %rsp, it makes the %rsp be 16-byte aligned, but then
> there is a "sub" with $0x8 which makes the %rsp no longer 16-byte
> aligned, then it calls main. That's the bug!
> 
> Right before "call", the %rsp must be 16-byte aligned. So the "sub"
> here breaks the alignment. Remove it.

That's very interesting because my understanding till now was that
the stack had to be 16-aligned in the callee, not the caller. But I've
checked the psABI doc, and it indeed says in section 3.2.2 that it's
rsp+8 which is 16-aligned. Of course, when pushing a frame pointer
onto the stack, it becomes the same. Thanks for spotting this one!

> Also the content of %rbp may be unspecified at process initialization
> time. For example, if the _start gets called by an interpreter, the
> interpreter may not zero the %rbp, so we should zero the %rbp on _start.

OK.

> Extra fixes:
>   - Use NR_exit_group instead of NR_exit.

Please, this is independent on the fix above so it must be subject
of a different patch with its own justification. Also it should cover
all supported architectures, otherwise programs will start to behave
differently on different targets.

>   - Use `mov %eax,%edi` instead of `movzbq %al,%rdi`. This makes the
>     exit code more observable from strace. While the exit code is
>     only 8-bit, the kernel has taken care of that, so no need to
>     worry about it.

I'm fine with this one as well, but similarly, it should be in its own
patch and applied to all architectures.

>  /* startup code */
> -asm(".section .text\n"
> -    ".global _start\n"
> -    "_start:\n"
> -    "pop %rdi\n"                // argc   (first arg, %rdi)
> -    "mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
> -    "lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
> -    "and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned when
> -    "sub $8, %rsp\n"            // entering the callee
> -    "call main\n"               // main() returns the status code, we'll exit with it.
> -    "movzb %al, %rdi\n"         // retrieve exit code from 8 lower bits
> -    "mov $60, %rax\n"           // NR_exit == 60
> -    "syscall\n"                 // really exit
> -    "hlt\n"                     // ensure it does not return
> -    "");
> +asm(
> +	".section .text\n"
> +	".global _start\n"
> +
> +	"_start:\n\t"
> +	"popq %rdi\n\t"			// argc   (first arg, %rdi)
> +	"movq %rsp, %rsi\n\t"		// argv[] (second arg, %rsi)
> +	"leaq 8(%rsi,%rdi,8), %rdx\n\t"	// then a NULL, then envp (third arg, %rdx)
> +
> +	/*
> +	 * The System V ABI mandates the deepest stack frame should be zero.
> +	 * Thus we zero the %rbp here.
> +	 */
> +	"xorl %ebp, %ebp\n\t"
> +
> +	/*
> +	 * The System V ABI mandates the %rsp needs to be aligned at 16-byte
> +	 * before performing a function call.
> +	 */
> +	"andq $-16, %rsp\n\t"
> +
> +	/*
> +	 * main() returns the status code, we will exit with it.
> +	 */
> +	"callq main\n\t"
> +
> +	/*
> +	 * Move the return value to the first argument of exit_group.
> +	 */
> +	"movl %eax, %edi\n\t"
> +
> +	/*
> +	 * NR_exit_group == 231
> +	 */
> +	"movl $231, %eax\n\t"
> +
> +	/*
> +	 * Really exit.
> +	 */
> +	"syscall\n\t"
> +
> +	/*
> +	 * Ensure it does not return.
> +	 */
> +	"hlt\n\t"
> +);

I find the whole thing much less readable here, as asm code tends to
be read as visual groups of patterns. I'm suggesting that you place a
multi-line comment before the asm statement indicating the general
rules (e.g. lowest stack frame must be zero, rsp+8 must be multiple of
16 etc), then only comment each instruction on the same line as it was
before.

Thank you!
Willy
