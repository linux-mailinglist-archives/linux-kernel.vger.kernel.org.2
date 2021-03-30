Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF54534E47E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhC3JeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhC3Jdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:33:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E69F06196A;
        Tue, 30 Mar 2021 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617096819;
        bh=dYLugLc2SuF0iK6NmBheI9/uixh1V9koKnsv2y5J0l0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HZt6JV/OAnSHC4xC5UNG10NWYm4QK27EYcF4BJQorN2o003E6NyJRWEJgh/fa0Xv2
         UdSOg440QgXpJ+Xk1NztoAJLtbCxlKWaJM9hIMdDpoVNju6yrGOH7xkt6Gnjova+3j
         7i7IbLl2HN0+sV3x8kBDQltM4Zz1K67xS94YZyiJgcCXqTqDddD76QKTFLlRg7BvAj
         SST8ZD0LpKc/15Ts4NFbLiDvdy8/8TGLk8eVEtHcr2EwVG7UUwyWgUHkvMGMRTmDyf
         jbj8tPMUQOywNpe0/UWONHbKbr8uh+SIQz6nQx/LIRYF7q+264hpm8n/VWzopoW4Cv
         nFKyJSp//52+w==
Date:   Tue, 30 Mar 2021 18:33:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@linux.alibaba.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: keep interrupts disabled for BREAKPOINT
 exception
Message-Id: <20210330183316.942215efe8e6e8455ad14113@kernel.org>
In-Reply-To: <20210330021624.2b776386@xhacker>
References: <20210330021624.2b776386@xhacker>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Tue, 30 Mar 2021 02:16:24 +0800
Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:

> From: Jisheng Zhang <jszhang@kernel.org>
> 
> Current riscv's kprobe handlers are run with both preemption and
> interrupt enabled, this violates kprobe requirements. Fix this issue
> by keeping interrupts disabled for BREAKPOINT exception.

Not only while the breakpoint exception but also until the end of
the single step (maybe you are using __BUG_INSN_32 ??) need to be
disable interrupts. Can this do that?

Thank you,

> 
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/entry.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 744f3209c48d..4114b65698ec 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -130,6 +130,8 @@ skip_context_tracking:
>  	 */
>  	andi t0, s1, SR_PIE
>  	beqz t0, 1f
> +	li t0, EXC_BREAKPOINT
> +	beq s4, t0, 1f
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	call trace_hardirqs_on
>  #endif
> -- 
> 2.31.0
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
