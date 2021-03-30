Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A920A34E431
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhC3JVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhC3JVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:21:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 451A36024A;
        Tue, 30 Mar 2021 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617096070;
        bh=4R/2RqA5Y/KuA/x2pUUPA6JHkojRGW/5pd8HtMfeQY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cy2uNLDJC2WSJyN5Jhbvad2rPcKnpg0I9jfbw3PLlljdmZpPLSILGPwooa2EXBj03
         WjRWby+w3gfdlmyTBktRFaetLTiIVYiLPHBJNAPsUbGYQUUDksWyzIJSCKKOfA+f99
         9D4Y66szN9uxWbtgnVlabzIPI8gUvJn2h8/nC5Z5fiHRvsuYtaq3GbfZVWJWsvwOHK
         HcaLhHA4c7LojzqaOHBAPBdd5fy9U/6d1o00/zSb7dMlii9SA70oytfZQQcbWUY2Ft
         8wPZu/UzuVGTIhOlT04n60C7ewEzzsHUyGatHRedppAAzldHVdEFXzBEblVS0pS5wd
         uEoOlxcERpuQQ==
Date:   Tue, 30 Mar 2021 18:21:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: add do_page_fault and do_trap_break into the
 kprobes blacklist
Message-Id: <20210330182105.47a24038fc014ba0dcd917a4@kernel.org>
In-Reply-To: <20210330021226.2fc7b2ec@xhacker>
References: <20210330021226.2fc7b2ec@xhacker>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 02:12:26 +0800
Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:

> From: Jisheng Zhang <jszhang@kernel.org>
> 
> These two functions are used to implement the kprobes feature so they
> can't be kprobed.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/traps.c | 1 +
>  arch/riscv/mm/fault.c     | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 0879b5df11b9..1357abf79570 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -178,6 +178,7 @@ asmlinkage __visible void do_trap_break(struct pt_regs *regs)
>  	else
>  		die(regs, "Kernel BUG");
>  }
> +NOKPROBE_SYMBOL(do_trap_break);
>  
>  #ifdef CONFIG_GENERIC_BUG
>  int is_valid_bugaddr(unsigned long pc)
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 8f17519208c7..c5dbd55cbf7c 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -328,3 +328,4 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
>  	}
>  	return;
>  }
> +NOKPROBE_SYMBOL(do_page_fault);
> -- 
> 2.31.0
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
