Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CA93FEB0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245147AbhIBJQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbhIBJQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:16:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109ACC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vZXewvd5uQfz8mD6NRgiq7Yq8l5foALrwhdERkp8WJE=; b=jWDR2eW03qGMMEzPGmhHjqp49F
        MiWijT2tktjOFwWbZrosEeoNhzAGRmp3A7B5MNR9a8uOCq6PBCuGRmmac5ZJUmiHkhuCArvIpqpM7
        7cmMHeInLVFe3BdX8LFAx9pAhf+DIcYAiPKndClEw1WHrfbaiiQD1KcRywFVeKvW5UJAPtGWzS2P0
        08IuOtFF/J5hCQ9iLy+hw63GVPtPfH2+AQ/YXVHdFVVI0hcw9pFXjGBoeP/yqulYElb4gx1ndiNSx
        VluP8EMBzgC4jWMv+Imo6s+oxC3f6QqfRJ7QmRdrx0M6SI69/tIIImTCPxGmj1WZworonnySqO3Ng
        GPfqyaoQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLine-003Jkd-6m; Thu, 02 Sep 2021 09:14:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF6DC3001C0;
        Thu,  2 Sep 2021 11:14:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77EF6285E1169; Thu,  2 Sep 2021 11:14:20 +0200 (CEST)
Date:   Thu, 2 Sep 2021 11:14:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 04/24] x86/entry: Expose the address of .Lgs_change to
 traps.c
Message-ID: <YTCV7HbeoaD6rJP5@hirez.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-5-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831175025.27570-5-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 01:50:05AM +0800, Lai Jiangshan wrote:

> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index e38a4cf795d9..9164e85b36b8 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -729,6 +729,7 @@ _ASM_NOKPROBE(common_interrupt_return)
>  SYM_FUNC_START(asm_load_gs_index)
>  	FRAME_BEGIN
>  	swapgs
> +SYM_INNER_LABEL(asm_load_gs_index_gs_change, SYM_L_GLOBAL)
>  .Lgs_change:

After all the patches, there's only a single .Lgs_change reference left.
Can't we convert the _ASM_EXTABLE() entry to use the new label and
totally remove it?

>  	movl	%edi, %gs
>  2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
> @@ -1011,7 +1012,7 @@ SYM_CODE_START_LOCAL(error_entry)
>  	movl	%ecx, %eax			/* zero extend */
>  	cmpq	%rax, RIP+8(%rsp)
>  	je	.Lbstep_iret
> -	cmpq	$.Lgs_change, RIP+8(%rsp)
> +	cmpq	$asm_load_gs_index_gs_change, RIP+8(%rsp)
>  	jne	.Lerror_entry_done_lfence
