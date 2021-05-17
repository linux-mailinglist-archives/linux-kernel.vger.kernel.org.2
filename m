Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE453823D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 07:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbhEQFsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 01:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234465AbhEQFr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 01:47:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CA1461206;
        Mon, 17 May 2021 05:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621230403;
        bh=JmwgZScpv1Y6+afuL5rc+s/6SWk09tL43qq7urCSkc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RlR7zpE2Szs2oi7uznuAVwPN9RZj4qP1MdQDKHZaZsdhQ66MphvcDWJihoGKE/nib
         wg0YbhA+t0vrm7CkB25WX3vsGl1fIMbjmCZv1i9pTbMN8zKfWbkBk8gnnK5MRkx0ZG
         1oxOZLY30gGbPWDXOpP6bZdkU+GToIs4nRGhrAnoyH5JkYmVsSeIJusks5SlyFlr9s
         YpkP8k3JQ5F+Ouv+T8W2O9C+XLyUlYl1XlEwtoZYIO2C9DyFf6Z1h7pRbFtTPwfcGK
         Z7SO5nH8hpKZg/smRhpSL9JtGZR50ZjrfjVGZgyd0chq2QpWFpd4R82kaH7AehH353
         fS1S0RgK5+Usg==
Date:   Mon, 17 May 2021 14:46:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, Marc Koderer <marc@koderer.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v4 2/2] samples/kprobes: Fix typo in handler_post()
Message-Id: <20210517144637.b781d07770621c3d81b2990e@kernel.org>
In-Reply-To: <1621218083-23519-3-git-send-email-yangtiezhu@loongson.cn>
References: <1621218083-23519-1-git-send-email-yangtiezhu@loongson.cn>
        <1621218083-23519-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 10:21:23 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> It should use post_handler instead of pre_handler in handler_post().
> 
> As Joe Perches suggested, it would be better to use pr_fmt and remove
> all the embedded pre/post/fault strings. This would change the style of
> the output through.
> 

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> Fixes: e16c5dd5157e ("samples/kprobes: Add s390 case in kprobe example module")
> Acked-by: Marc Koderer <marc@koderer.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  samples/kprobes/kprobe_example.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index d77a546..5f1eb8b 100644
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
> -	pr_info("fault_handler: p->addr = 0x%p, trap #%d\n", p->addr, trapnr);
> +	pr_info("p->addr = 0x%p, trap #%d\n", p->addr, trapnr);
>  	/* Return 0 because we don't handle the fault. */
>  	return 0;
>  }
> -- 
> 2.1.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
