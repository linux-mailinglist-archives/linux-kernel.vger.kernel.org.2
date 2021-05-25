Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096753903D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 16:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhEYOWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 10:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233918AbhEYOWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 10:22:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5FD6613F9;
        Tue, 25 May 2021 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621952467;
        bh=1NVRT3c3rAGoTvn+BDJW+JrM2M2mhYsAZiwJZ/3l5GA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LLUjTXrgKn6t2LhNGBZpvy5ZW1SNqGaV5HPiN/ejj2muRJpl9ou/TjgNJG1RniMX8
         e1YekYo5ydewHpXdDRCzuF4Wy9A4QBU23BjwmhifQptMHEwIsVAA+gvrb8OY12bsb1
         Uippvv7ErxH/5sTN82T2I9q6yIZ7Fdg/DBfIbJoozHFuP1laTWDT3TJntKU5PDKw33
         m8iRSaJf7rk+TEV9ohNPAvUCveD0DocK1ZcA9WBUGWrzQxRhMyuN4J4TxDTEGyrcGj
         Djl5n9IxPaLWIuk2HeI5CKTjkJLrSFsnXqP5yO+HauA6FFImDSQiuGG+X1Nkt01NRj
         81DL9htsNEfug==
Date:   Tue, 25 May 2021 23:21:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        rostedt@goodmis.org, naveen.n.rao@linux.vnet.ibm.com,
        ananth@linux.ibm.com, x86@kernel.org
Subject: Re: [PATCH 2/2] x86,kprobes: WARN if kprobes tries to handle a
 fault
Message-Id: <20210525232103.9d79ff5e396cddd2a9eb818f@kernel.org>
In-Reply-To: <20210525073213.660594073@infradead.org>
References: <20210525072518.791889911@infradead.org>
        <20210525073213.660594073@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 09:25:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> With the removal of kprobe::handle_fault there is no reason left that
> kprobe_page_fault() would ever return true on x86, make sure it
> doesn't happen by accident.

OK, this is reasonable to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/mm/fault.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1186,7 +1186,7 @@ do_kern_addr_fault(struct pt_regs *regs,
>  		return;
>  
>  	/* kprobes don't want to hook the spurious faults: */
> -	if (kprobe_page_fault(regs, X86_TRAP_PF))
> +	if (WARN_ON_ONCE(kprobe_page_fault(regs, X86_TRAP_PF)))
>  		return;
>  
>  	/*
> @@ -1239,7 +1239,7 @@ void do_user_addr_fault(struct pt_regs *
>  	}
>  
>  	/* kprobes don't want to hook the spurious faults: */
> -	if (unlikely(kprobe_page_fault(regs, X86_TRAP_PF)))
> +	if (WARN_ON_ONCE(kprobe_page_fault(regs, X86_TRAP_PF)))
>  		return;
>  
>  	/*
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
