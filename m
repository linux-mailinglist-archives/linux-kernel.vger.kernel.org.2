Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E4E34E435
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhC3JWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231653AbhC3JWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:22:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF7236024A;
        Tue, 30 Mar 2021 09:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617096137;
        bh=uDfFMsetRa84Y+TVUQV9pEFfOKCsf9PIepiuOFlvhUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ItwDsKq5s0Tqu1E4H9sjbwyjediMnllkizLTx8/OluZVtW+Sm7d9XzHOe3dZ/upKK
         wW9JsfyqBD9R3oCMJbNrXHjINjeXH8Z2xu9Kw1QjJltIChjlCGZDu1r026hTmYDjI+
         EILJTAqKPOsRPZK+yXImN3nLz4aiXT1Zyzg+Usu16nwjiVbFuP7g0Um38UsMs5OBsV
         nt2kH+eoGaM5HY0lUgvP/t7oSmGwXC60yZMYry7MZmkdPfm7zkqHH0mTJuXoIMtbvT
         4y8xKB3K4iG9P1H+L+h0wLnhaqgsVUQ7SnmE9NhcArki9AlIsUD+ogyPZ3p/s2eRLH
         UAi0ymSJGXqZA==
Date:   Tue, 30 Mar 2021 18:21:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] samples/kprobes: Add riscv support
Message-Id: <20210330182156.d2cd8680e99cfe1a75068732@kernel.org>
In-Reply-To: <20210330020416.129505e6@xhacker>
References: <20210330020416.129505e6@xhacker>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 02:04:16 +0800
Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:

> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Add riscv specific info dump in both handler_pre() and handler_post().
> 

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  samples/kprobes/kprobe_example.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index 331dcf151532..c495664c0a9b 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -47,6 +47,10 @@ static int __kprobes handler_pre(struct kprobe *p, struct pt_regs *regs)
>  	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx, cpsr = 0x%lx\n",
>  		p->symbol_name, p->addr, (long)regs->ARM_pc, (long)regs->ARM_cpsr);
>  #endif
> +#ifdef CONFIG_RISCV
> +	pr_info("<%s> pre_handler: p->addr = 0x%p, pc = 0x%lx, status = 0x%lx\n",
> +		p->symbol_name, p->addr, regs->epc, regs->status);
> +#endif
>  #ifdef CONFIG_S390
>  	pr_info("<%s> pre_handler: p->addr, 0x%p, ip = 0x%lx, flags = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->psw.addr, regs->flags);
> @@ -80,6 +84,10 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
>  	pr_info("<%s> post_handler: p->addr = 0x%p, cpsr = 0x%lx\n",
>  		p->symbol_name, p->addr, (long)regs->ARM_cpsr);
>  #endif
> +#ifdef CONFIG_RISCV
> +	pr_info("<%s> post_handler: p->addr = 0x%p, status = 0x%lx\n",
> +		p->symbol_name, p->addr, regs->status);
> +#endif
>  #ifdef CONFIG_S390
>  	pr_info("<%s> pre_handler: p->addr, 0x%p, flags = 0x%lx\n",
>  		p->symbol_name, p->addr, regs->flags);
> -- 
> 2.31.0
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
