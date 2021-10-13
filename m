Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D33242BA01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbhJMIRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238871AbhJMIQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:16:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD54460FDA;
        Wed, 13 Oct 2021 08:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634112890;
        bh=Kr5n30jWJFn/1ztvhvCbSOta4kJ1v2lin+xuRMC2dz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lQUEFZWpunPpDLyiyf/ScamsM3tBj/uky2XgVcM3Vq7YyWv78uyBjg5kOYg8BdZ7L
         2C1shLcdXbmwns55oM0aA5MqrZvlOAJCaWzahBY5MFMl24l8ovnERcZ136C+eJMgUZ
         PQSHwmo5iMqFzmVDXHtJu95xzyYdxNTwSRm+wy5Cx9i7DdVVmSpWeqA/UDo9v4WdcF
         DUnfm2MvvVJk1wb6me+KBz3LXYQRJh2IRVgRE7bw8MMHQP9MbwFHuvC0tfYOAQRHLc
         1y4V4mqC+CeFOIcY8rFuET5U/ufRaToQH7h7s0W3jG/5r1qv51uPAA2+W88x+2lC0C
         JH5DxEHEFvsGw==
Date:   Wed, 13 Oct 2021 09:14:45 +0100
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
Subject: Re: [PATCH 3/8] arm64: kprobes: Record frame pointer with kretprobe
 instance
Message-ID: <20211013081445.GD6701@willie-the-truck>
References: <163369609308.636038.15295764725220907794.stgit@devnote2>
 <163369611948.636038.11552166777773804729.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163369611948.636038.11552166777773804729.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:28:39PM +0900, Masami Hiramatsu wrote:
> Record the frame pointer instead of stack address with kretprobe
> instance as the identifier on the instance list.
> Since arm64 always enable CONFIG_FRAME_POINTER, we can use the
> actual frame pointer (x29).
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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

Acked-by: Will Deacon <will@kernel.org>

Will
