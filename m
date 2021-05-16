Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62C381DCC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhEPKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 06:03:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhEPKDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 06:03:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDCE160FE8;
        Sun, 16 May 2021 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621159328;
        bh=xwcWb/a+gTw+8foQ3vOUhNlB5EKgOWD4mpKhelpV5io=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rv8DC8j5B5ScR2jim3CnYeXDeavAc4fE5qaDg9SYzdiJIQcM//XN+xfWhqKSYiAxS
         33DzrLQBdURT8qs8KR+oHwBBWsbP5hB7AgvuoFOQ7OoDDKimGq5rDp91U2S5toqL3u
         0AWne+T44B1oNQR5Dc1sxOAc3KghM9XwWk0cUV1ZRTbi6RjOsnkIE2sFtvNQF89qPN
         mmAsHvWN+8kj2mVFABbOqBdYV4Qt0nQaDlvAL7lKJHYQrrPRXen4LlgHWdE3sgLlz0
         4CDncVlSecqvFDn2my/VCuRETQpAHaXiXg/9XdKEIaWkSleDLxvM1pF4CGkc4ZnHNs
         dhuiFQcm+77vg==
Date:   Sun, 16 May 2021 19:02:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, Marc Koderer <marc@koderer.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Randy Dunlap <randy.dunlap@oracle.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v3] samples/kprobes: Fix typo in handler_{post,fault}()
Message-Id: <20210516190201.790f4f2085e2691bbb96c58c@kernel.org>
In-Reply-To: <1621046346-7855-1-git-send-email-yangtiezhu@loongson.cn>
References: <1621046346-7855-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 May 2021 10:39:06 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> It should use post_handler instead of pre_handler in handler_post().
> 
> As Joe Perches suggested, it would be better to use pr_fmt and remove
> all the embedded pre/post strings. This would change the style of the
> output through.
> 

NAK, this also shows which handler cought the event.
If you wanna change it. Please replace it with __func__ instead.

> Also fix a defective format in handler_fault() ending with an 'n' that
> should be '\n'.

This is another typo. Please split the fix from this patch.

Thank you,

> 
> Fixes: e16c5dd5157e ("samples/kprobes: Add s390 case in kprobe example module")
> Fixes: 804defea1c02 ("Kprobes: move kprobe examples to samples/")
> Acked-by: Marc Koderer <marc@koderer.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> 
> v3: use pr_fmt and fix typo in handler_fault() suggested by Joe Perches
> 
> v2: rebase on the latest mainline kernel
> 
>  samples/kprobes/kprobe_example.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index c495664..5f1eb8b 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -10,6 +10,8 @@
>   * whenever kernel_clone() is invoked to create a new process.
>   */
>  
> +#define pr_fmt(fmt) "%s: " fmt, __func__
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/kprobes.h>
> @@ -27,32 +29,31 @@ static struct kprobe kp = {
>  static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
>  {
>  #ifdef CONFIG_X86
> -	pr_info("<%s> pre_handler: p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, ip = %lx, flags = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->ip, regs->flags);
>  #endif
>  #ifdef CONFIG_PPC
> -	pr_info("<%s> pre_handler: p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, nip = 0x%lx, msr = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->nip, regs->msr);
>  #endif
>  #ifdef CONFIG_MIPS
> -	pr_info("<%s> pre_handler: p->addr = 0x%p, epc = 0x%lx, status = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, epc = 0x%lx, status = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->cp0_epc, regs->cp0_status);
>  #endif
>  #ifdef CONFIG_ARM64
> -	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx,"
> -			" pstate = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, pc = 0x%lx, pstate = 0x%lx\n",
>  		p->symbol_name, p->addr, (long)regs->pc, (long)regs->pstate);
>  #endif
>  #ifdef CONFIG_ARM
> -	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx, cpsr = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, pc = 0x%lx, cpsr = 0x%lx\n",
>  		p->symbol_name, p->addr, (long)regs->ARM_pc, (long)regs->ARM_cpsr);
>  #endif
>  #ifdef CONFIG_RISCV
> -	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx, status = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, pc = 0x%lx, status = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->epc, regs->status);
>  #endif
>  #ifdef CONFIG_S390
> -	pr_info("<%s> pre_handler: p->addr, 0x%p, ip = 0x%lx, flags = 0x%lx\n",
> +	pr_info("<%s> p->addr, 0x%p, ip = 0x%lx, flags = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->psw.addr, regs->flags);
>  #endif
>  
> @@ -65,31 +66,31 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
>  				unsigned long flags)
>  {
>  #ifdef CONFIG_X86
> -	pr_info("<%s> post_handler: p->addr = 0x%p, flags = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, flags = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->flags);
>  #endif
>  #ifdef CONFIG_PPC
> -	pr_info("<%s> post_handler: p->addr = 0x%p, msr = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, msr = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->msr);
>  #endif
>  #ifdef CONFIG_MIPS
> -	pr_info("<%s> post_handler: p->addr = 0x%p, status = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, status = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->cp0_status);
>  #endif
>  #ifdef CONFIG_ARM64
> -	pr_info("<%s> post_handler: p->addr = 0x%p, pstate = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, pstate = 0x%lx\n",
>  		p->symbol_name, p->addr, (long)regs->pstate);
>  #endif
>  #ifdef CONFIG_ARM
> -	pr_info("<%s> post_handler: p->addr = 0x%p, cpsr = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, cpsr = 0x%lx\n",
>  		p->symbol_name, p->addr, (long)regs->ARM_cpsr);
>  #endif
>  #ifdef CONFIG_RISCV
> -	pr_info("<%s> post_handler: p->addr = 0x%p, status = 0x%lx\n",
> +	pr_info("<%s> p->addr = 0x%p, status = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->status);
>  #endif
>  #ifdef CONFIG_S390
> -	pr_info("<%s> pre_handler: p->addr, 0x%p, flags = 0x%lx\n",
> +	pr_info("<%s> p->addr, 0x%p, flags = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->flags);
>  #endif
>  }
> @@ -101,7 +102,7 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
>   */
>  static int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
>  {
> -	pr_info("fault_handler: p->addr = 0x%p, trap #%dn", p->addr, trapnr);
> +	pr_info("p->addr = 0x%p, trap #%d\n", p->addr, trapnr);
>  	/* Return 0 because we don't handle the fault. */
>  	return 0;
>  }
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
