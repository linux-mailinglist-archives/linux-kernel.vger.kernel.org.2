Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1523D42BA03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbhJMIRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:17:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238879AbhJMIRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:17:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52B8D603E5;
        Wed, 13 Oct 2021 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634112902;
        bh=tkpjOjlIspU1fO21Mw4tWKGAWZohLqWteK7ZGUv5w5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuXhmlhp+E5VlaEvzFqNpqiLMdLY9oG6EwoYfmpY7Wtw/u1oKkQVnPPqeyQOGxrre
         Mxia2/m7W3IkjMbZuUCo+VbbdJKO3+cG5EZZ6qLoQ2sNGhuBm8t0RwR4USqqGYREYz
         GdyWlVnva078PLj3j4rq53BzCvjZRt4l6u/2H74MixYqZW1yml+FUuT6A5/+qaXCum
         l8WflP4odF3mcLe5kzDoAdzVHSnus/WI8vvdClmkyCHNYfpy5pfcoSsuy+6y0oip5V
         kPY1h9mjvMEiBVSu+qzrQVvcZHwkGuNmpPiRy+/Cc7OWZoKHJPM3O4ODKYUX7EkvDa
         SISh6rpQmbhtw==
Date:   Wed, 13 Oct 2021 09:14:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/8] arm64: kprobes: Make a frame pointer on
 __kretprobe_trampoline
Message-ID: <20211013081456.GE6701@willie-the-truck>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
 <163369612899.636038.6691283708565501775.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163369612899.636038.6691283708565501775.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:28:49PM +0900, Masami Hiramatsu wrote:
> Make a frame pointer (make the x29 register points the
> address of pt_regs->regs[29]) on __kretprobe_trampoline.
> 
> This frame pointer will be used by the stacktracer when it is
> called from the kretprobe handlers. In this case, the stack
> tracer will unwind stack to trampoline_probe_handler() and
> find the next frame pointer in the stack frame of the
> __kretprobe_trampoline().
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm64/kernel/probes/kprobes_trampoline.S |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes_trampoline.S b/arch/arm64/kernel/probes/kprobes_trampoline.S
> index 520ee8711db1..9a6499bed58b 100644
> --- a/arch/arm64/kernel/probes/kprobes_trampoline.S
> +++ b/arch/arm64/kernel/probes/kprobes_trampoline.S
> @@ -66,6 +66,9 @@ SYM_CODE_START(__kretprobe_trampoline)
>  
>  	save_all_base_regs
>  
> +	/* Setup a frame pointer. */
> +	add x29, sp, #S_FP
> +
>  	mov x0, sp
>  	bl trampoline_probe_handler
>  	/*
> @@ -74,6 +77,7 @@ SYM_CODE_START(__kretprobe_trampoline)
>  	 */
>  	mov lr, x0
>  
> +	/* The frame pointer (x29) is restored with other registers. */
>  	restore_all_base_regs
>  
>  	add sp, sp, #PT_REGS_SIZE

Acked-by: Will Deacon <will@kernel.org>

Will
