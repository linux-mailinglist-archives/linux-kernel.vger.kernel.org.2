Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46ABE38E0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhEXFcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhEXFcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:32:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E14D61026;
        Mon, 24 May 2021 05:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621834249;
        bh=FmFGLF8f0CXz45WOV7/sWm7X4XneoYUIfEcFrZQ9AJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EfxKrh7H3kUAokW6yEhtHQT90iWDT/Lgdy3DxDcJvXsGSkwQmFGt/lwvfAxWmCGt0
         c83dekrLr3829CpV5WnDC6Y81ANcB29wCimVq9ySveCKVLY3IQKad6cb2oyELj3h3y
         th6y3hN1FIsjABH2+XbrTtqZ+RMxoxVwU2hwAdMwTYV9BbEG2eKH1YQpMEqlsSebck
         8jdxvYnGbhdnjjc8nWS96P0A+5QzR88iBK/rs9hVP+VUyNReIv9wqFbad0iEne2uIu
         qIp5Jxgkn94Cy422o7A5pxZgmP+d+7sPngIl1BoGaGHYzh7Fc4AfCQNeMCzH4cSS4V
         XA8tJf/OlTIjw==
Date:   Mon, 24 May 2021 14:30:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [BUGFIX PATCH -tip] x86/kprobes: Fix to call previous kprobe's
 fault handler
Message-Id: <20210524143045.87d7ba5830c9662c2c9862a3@kernel.org>
In-Reply-To: <162182673618.114649.7393137495689996180.stgit@devnote2>
References: <162182673618.114649.7393137495689996180.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 12:25:36 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix to call the previous kprobe's fault handler when a page fault
> occurred in reentered kprobes.
> This may happen if kprobes handler calls a function which can cause
> a page fault (e.g. access user page) and another kprobe probes that
> instruction.
> Without the 2nd kprobe, the 1st kprobe can handle the page fault,
> but with the 2nd kprobe, the 1st one can not handle it.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, this is a kind of a rare case bug, but exists from very early day.

E.g. reenter case has been decoupled in the kprobe_fault_handler()
by commit b4026513b88e ("[PATCH] kprobes: fix broken fault handling 
for i386"), but even without that commit, kprobes never call previous
kprobe fault handler.

So it seems that this bug has been there from the commit 417c8da6511b
 ("[PATCH] kprobes: Temporary disarming of reentrant probe for i386")
which introduces the "reenter" kprobes.

Fixes: 417c8da6511b ("[PATCH] kprobes: Temporary disarming of reentrant probe for i386")
Cc: stable@vger.kernel.org

Note that this patch itself can be cleanly applied from commit
2bbda764d720 ("kprobes/x86: Do not disable preempt on int3 path")

and before commit 6381c24cd6d5 ("kprobes/x86: Fix page-fault handling logic")
this needs the above commit.

BTW, there is another discussion to remove user fault_handler from
kprobes. In that case, this patch is not needed anymore.

Thank you,

> ---
>  arch/x86/kernel/kprobes/core.c |   19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 7c4d0736a998..ac2514f1e195 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -1098,12 +1098,21 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>  		 */
>  		regs->flags |= kcb->kprobe_old_flags;
>  
> -		if (kcb->kprobe_status == KPROBE_REENTER)
> -			restore_previous_kprobe(kcb);
> -		else
> +		if (kcb->kprobe_status != KPROBE_REENTER) {
>  			reset_current_kprobe();
> -	} else if (kcb->kprobe_status == KPROBE_HIT_ACTIVE ||
> -		   kcb->kprobe_status == KPROBE_HIT_SSDONE) {
> +			return 0;
> +		}
> +		restore_previous_kprobe(kcb);
> +		/*
> +		 * If reentered kprobes caused a page fault, it must be
> +		 * handled by the previous kprobe too. But we don't bother
> +		 * checking KPROBE_HIT_SS again because kprobes can not
> +		 * probe another kprobe's single stepping buffer.
> +		 */
> +	}
> +
> +	if (kcb->kprobe_status == KPROBE_HIT_ACTIVE ||
> +	    kcb->kprobe_status == KPROBE_HIT_SSDONE) {
>  		/*
>  		 * We increment the nmissed count for accounting,
>  		 * we can also use npre/npostfault count for accounting
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
