Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BB3430FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 07:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhJRF5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 01:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhJRF5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:57:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDA2A610A3;
        Mon, 18 Oct 2021 05:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634536541;
        bh=zq+/0mVkbC+cTecYxyS7l8jTkHvXioSJhk3wXWnhXps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rF7K0f8lWCBtfjLD+6jzcfqvpmyRCeRxvhAhjfAibl5GXqGrfW3JmlomsyAQDEVhg
         qwBn2IZ2xUlvZSkZy4oUD9Azqm0NMvYlZRNMz6fi0ShN+UWMO4wg23rV63AUHS+6W1
         IztMX0dl+QWACIJIbcruB9Oa6wmS3eswnf31xPv3TZDT8e8E/F4sf8CjakkSDQdfwb
         YXcvDVoIRAekAjajZvonACs4xpBrHXAssujzTK6V6VEseQjt6r2AD6nvbFpCBg/8ii
         dssrXQXsz8P+rGhphwLrTmbGTxLiXbTPMhHZILSHvvlNPs5SaMiANdZsnZC0MbmNoq
         WVOVfriMw9XJA==
Date:   Mon, 18 Oct 2021 14:55:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/10] ARM: kprobes: Make a frame pointer on
 __kretprobe_trampoline
Message-Id: <20211018145536.3cb042e574560fa4a00aa575@kernel.org>
In-Reply-To: <YWtBDXJQRLN2T1c6@shell.armlinux.org.uk>
References: <163430224341.459050.2369208860773018092.stgit@devnote2>
        <163430231601.459050.8640625926942332950.stgit@devnote2>
        <YWtBDXJQRLN2T1c6@shell.armlinux.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2021 22:15:57 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Fri, Oct 15, 2021 at 09:51:56PM +0900, Masami Hiramatsu wrote:
> > Currently kretprobe on ARM just fills r0-r11 of pt_regs, but
> > that is not enough for the stacktrace. Moreover, from the user
> > kretprobe handler, stacktrace needs a frame pointer on the
> > __kretprobe_trampoline.
> > 
> > This adds a frame pointer on __kretprobe_trampoline for both gcc
> > and clang case. Those have different frame pointer so we need
> > different but similar stack on pt_regs.
> > 
> > Gcc makes the frame pointer (fp) to point the 'pc' address of
> > the {fp, ip (=sp), lr, pc}, this means {r11, r13, r14, r15}.
> > Thus if we save the r11 (fp) on pt_regs->r12, we can make this
> > set on the end of pt_regs.
> > 
> > On the other hand, Clang makes the frame pointer to point the
> > 'fp' address of {fp, lr} on stack. Since the next to the
> > pt_regs->lr is pt_regs->sp, I reused the pair of pt_regs->fp
> > and pt_regs->ip.
> > So this stores the 'lr' on pt_regs->ip and make the fp to point
> > pt_regs->fp.
> > 
> > For both cases, saves __kretprobe_trampoline address to
> > pt_regs->lr, so that the stack tracer can identify this frame
> > pointer has been made by the __kretprobe_trampoline.
> > 
> > Note that if the CONFIG_FRAME_POINTER is not set, this keeps
> > fp as is.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/arm/probes/kprobes/core.c |   29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> > index 95f23b47ba27..7cbd65a22769 100644
> > --- a/arch/arm/probes/kprobes/core.c
> > +++ b/arch/arm/probes/kprobes/core.c
> > @@ -368,16 +368,35 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
> >  /*
> >   * When a retprobed function returns, trampoline_handler() is called,
> >   * calling the kretprobe's handler. We construct a struct pt_regs to
> > - * give a view of registers r0-r11 to the user return-handler.  This is
> > - * not a complete pt_regs structure, but that should be plenty sufficient
> > - * for kretprobe handlers which should normally be interested in r0 only
> > - * anyway.
> > + * give a view of registers r0-r11, sp, lr, and pc to the user
> > + * return-handler. This is not a complete pt_regs structure, but that
> > + * should be enough for stacktrace from the return handler with or
> > + * without pt_regs.
> >   */
> >  void __naked __kprobes __kretprobe_trampoline(void)
> >  {
> >  	__asm__ __volatile__ (
> > -		"sub	sp, sp, #16		\n\t"
> > +		"ldr	lr, =__kretprobe_trampoline	\n\t"
> > +		"stmdb	sp!, {sp, lr, pc}	\n\t"
> 
> I think you really do not want to do that.

Yes, I just wants to save the {sp, lr, pc} to mimic the
framepointer.

> 
> From DDI0406C:
> 
> "ARM deprecates the use of instructions with the base register in the
> list and ! specified. If the base register is not the lowest-numbered
> register in the list, such an instruction stores an UNKNOWN value for
> the base register."
> 
> However, it doesn't say what value is stored if the base register is
> the lowest-numbered register in the list. The pseudocode given shows
> that it is the original value. However, DDI0100E:
> 
> "Operand restrictions
>   If <Rn> is specified as <registers> and base register writeback is
>   specified:
>   • If <Rn> is the lowest-numbered register specified in
>     <register_list>, the original value of <Rn> is stored.
>   • Otherwise, the stored value of <Rn> is UNPREDICTABLE."
> 
> So I guess it might be okay... but it seems a bit dodgy to rely on
> this behaviour.

Oh, OK. I just tested it on qemu-arm so maybe it was wrong.


> 
> > +#ifdef CONFIG_FRAME_POINTER
> > +	/* __kretprobe_trampoline makes a framepointer on pt_regs. */
> > +#ifdef CONFIG_CC_IS_CLANG
> > +		/* In clang case, pt_regs->ip = lr. */
> > +		"stmdb	sp!, {lr}		\n\t"
> >  		"stmdb	sp!, {r0 - r11}		\n\t"
> 
> This can be simplified to:
> 		"stmdb	sp!, {r0 - r11, lr}	\n\t"
> 
> Also, note the value we store for "fp" is __kretprobe_trampoline.

Oh, I thought 'r11' is 'fp' from arch/arm/include/uapi/asm/ptrace.h
...
#define ARM_ip          uregs[12]
#define ARM_fp          uregs[11]
#define ARM_r10         uregs[10]
...

Is that fp? or ip?

> 
> > +		/* fp points regs->r11 (fp) */
> > +		"add	fp, sp,	#44		\n\t"
> > +#else /* !CONFIG_CC_IS_CLANG */
> > +		/* In gcc case, pt_regs->ip = fp. */
> > +		"stmdb	sp!, {fp}		\n\t"
> > +		"stmdb	sp!, {r0 - r11}		\n\t"
> 
> This can be simplified to:
> 		"stmdb	sp!, {r0 - r12}		\n\t"
> 
> since fp is r12.

Ditto. The arch/arm/include/uapi/asm/ptrace.h seems to say 'r12' is 'ip'.

Thank you,

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
