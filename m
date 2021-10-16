Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E94430504
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 23:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbhJPVST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 17:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244660AbhJPVSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 17:18:18 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D8C061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WmWx3eQF29prrcm1i33F+svigfcuy8QUDaRai5h7Weo=; b=uZZZ/5qas/J5fErnQnRiDRdN0o
        WUgkPZeIZTYTHunGeYxis0iO3svEUlyxq4lT5/KhseXLqDDQNx4rrogMnUDeG3Q9RjUC2vc8iKHZw
        rA0CdEYNXhJ/9YPjZrdUzC11ijndnqPn/MzdjClRFsM1DmzWYowLAlQa077AqvH0NsGZ5iEk66Hbs
        kuEaU2DHWNROGRW+khQqd5yTj7gmae6Zp4ct7tcK+ZndK66r/HhCbb1GcUshmeYaxazh5yk/EZT9B
        4caf0wFgv7eUpSxaf8mZx7Y4FCKqTwN+9PBesISzEim+Oow2W7Vi3IpJmEWeUdgGcT2nfS3J2QbWP
        ZhAcuB/w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55150)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mbr29-0003eK-D7; Sat, 16 Oct 2021 22:16:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mbr25-0004MH-Pm; Sat, 16 Oct 2021 22:15:57 +0100
Date:   Sat, 16 Oct 2021 22:15:57 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <YWtBDXJQRLN2T1c6@shell.armlinux.org.uk>
References: <163430224341.459050.2369208860773018092.stgit@devnote2>
 <163430231601.459050.8640625926942332950.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <163430231601.459050.8640625926942332950.stgit@devnote2>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 09:51:56PM +0900, Masami Hiramatsu wrote:
> Currently kretprobe on ARM just fills r0-r11 of pt_regs, but
> that is not enough for the stacktrace. Moreover, from the user
> kretprobe handler, stacktrace needs a frame pointer on the
> __kretprobe_trampoline.
> 
> This adds a frame pointer on __kretprobe_trampoline for both gcc
> and clang case. Those have different frame pointer so we need
> different but similar stack on pt_regs.
> 
> Gcc makes the frame pointer (fp) to point the 'pc' address of
> the {fp, ip (=sp), lr, pc}, this means {r11, r13, r14, r15}.
> Thus if we save the r11 (fp) on pt_regs->r12, we can make this
> set on the end of pt_regs.
> 
> On the other hand, Clang makes the frame pointer to point the
> 'fp' address of {fp, lr} on stack. Since the next to the
> pt_regs->lr is pt_regs->sp, I reused the pair of pt_regs->fp
> and pt_regs->ip.
> So this stores the 'lr' on pt_regs->ip and make the fp to point
> pt_regs->fp.
> 
> For both cases, saves __kretprobe_trampoline address to
> pt_regs->lr, so that the stack tracer can identify this frame
> pointer has been made by the __kretprobe_trampoline.
> 
> Note that if the CONFIG_FRAME_POINTER is not set, this keeps
> fp as is.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm/probes/kprobes/core.c |   29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> index 95f23b47ba27..7cbd65a22769 100644
> --- a/arch/arm/probes/kprobes/core.c
> +++ b/arch/arm/probes/kprobes/core.c
> @@ -368,16 +368,35 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>  /*
>   * When a retprobed function returns, trampoline_handler() is called,
>   * calling the kretprobe's handler. We construct a struct pt_regs to
> - * give a view of registers r0-r11 to the user return-handler.  This is
> - * not a complete pt_regs structure, but that should be plenty sufficient
> - * for kretprobe handlers which should normally be interested in r0 only
> - * anyway.
> + * give a view of registers r0-r11, sp, lr, and pc to the user
> + * return-handler. This is not a complete pt_regs structure, but that
> + * should be enough for stacktrace from the return handler with or
> + * without pt_regs.
>   */
>  void __naked __kprobes __kretprobe_trampoline(void)
>  {
>  	__asm__ __volatile__ (
> -		"sub	sp, sp, #16		\n\t"
> +		"ldr	lr, =__kretprobe_trampoline	\n\t"
> +		"stmdb	sp!, {sp, lr, pc}	\n\t"

I think you really do not want to do that.

From DDI0406C:

"ARM deprecates the use of instructions with the base register in the
list and ! specified. If the base register is not the lowest-numbered
register in the list, such an instruction stores an UNKNOWN value for
the base register."

However, it doesn't say what value is stored if the base register is
the lowest-numbered register in the list. The pseudocode given shows
that it is the original value. However, DDI0100E:

"Operand restrictions
  If <Rn> is specified as <registers> and base register writeback is
  specified:
  • If <Rn> is the lowest-numbered register specified in
    <register_list>, the original value of <Rn> is stored.
  • Otherwise, the stored value of <Rn> is UNPREDICTABLE."

So I guess it might be okay... but it seems a bit dodgy to rely on
this behaviour.

> +#ifdef CONFIG_FRAME_POINTER
> +	/* __kretprobe_trampoline makes a framepointer on pt_regs. */
> +#ifdef CONFIG_CC_IS_CLANG
> +		/* In clang case, pt_regs->ip = lr. */
> +		"stmdb	sp!, {lr}		\n\t"
>  		"stmdb	sp!, {r0 - r11}		\n\t"

This can be simplified to:
		"stmdb	sp!, {r0 - r11, lr}	\n\t"

Also, note the value we store for "fp" is __kretprobe_trampoline.

> +		/* fp points regs->r11 (fp) */
> +		"add	fp, sp,	#44		\n\t"
> +#else /* !CONFIG_CC_IS_CLANG */
> +		/* In gcc case, pt_regs->ip = fp. */
> +		"stmdb	sp!, {fp}		\n\t"
> +		"stmdb	sp!, {r0 - r11}		\n\t"

This can be simplified to:
		"stmdb	sp!, {r0 - r12}		\n\t"

since fp is r12.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
