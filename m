Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8B342BC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbhJMKD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:03:57 -0400
Received: from foss.arm.com ([217.140.110.172]:59792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239238AbhJMKDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:03:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 073791063;
        Wed, 13 Oct 2021 03:01:52 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3DB3F70D;
        Wed, 13 Oct 2021 03:01:49 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:01:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/8] arm64: kprobes: Record frame pointer with kretprobe
 instance
Message-ID: <20211013100126.GA3187@C02TD0UTHF1T.local>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
 <163369611948.636038.11552166777773804729.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163369611948.636038.11552166777773804729.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:28:39PM +0900, Masami Hiramatsu wrote:
> Record the frame pointer instead of stack address with kretprobe
> instance as the identifier on the instance list.
> Since arm64 always enable CONFIG_FRAME_POINTER, we can use the
> actual frame pointer (x29).

Just to check, why do we need to use the FP rather than SP? It wasn't
clear to me if that's necessary later in the series, or if I'm missing
something here.

FWIW, I plan to rework arm64's ftrace bits to use FP for
HAVE_FUNCTION_GRAPH_RET_ADDR_PTR, so I'm happy to do likewise here.

> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Regardless of the above:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/probes/kprobes.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index e7ad6da980e8..d9dfa82c1f18 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -401,14 +401,14 @@ int __init arch_populate_kprobe_blacklist(void)
>  
>  void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
>  {
> -	return (void *)kretprobe_trampoline_handler(regs, (void *)kernel_stack_pointer(regs));
> +	return (void *)kretprobe_trampoline_handler(regs, (void *)regs->regs[29]);
>  }
>  
>  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  				      struct pt_regs *regs)
>  {
>  	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
> -	ri->fp = (void *)kernel_stack_pointer(regs);
> +	ri->fp = (void *)regs->regs[29];
>  
>  	/* replace return addr (x30) with trampoline */
>  	regs->regs[30] = (long)&__kretprobe_trampoline;
> 
