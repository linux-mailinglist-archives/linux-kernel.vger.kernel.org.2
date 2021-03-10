Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DDD333B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhCJLUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCJLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:19:44 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CA8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 03:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QWdKU/s0/le4J4R64M2CitQHFtjef5LFPXGhL33eeLQ=; b=YgiJC2NqwRPYFyfpxceIfnP1AH
        qxtA4Vc9oOIMXFqtP8/d7htL4I4ZeS5WdzbWxFTI8uznkwNONxghdufk6nv7GrZR4aceyDMLpv74W
        iL7nd1Ib7WGqMprAhUEu56276SOK8GfcAiD7YVvKmH8g1u+IJ7APM6OwmFDIdCgZ+9Wv4zA52A6R3
        G4aUM9c1YdrgiYaT9F/u3/jPX7WxeYpoevRZ6TFNFATGElhogcW54UPeuF4BcqR/1QjdYg02FplaJ
        AMGNGSLB6y1w67wBvzTITXI8RTmBA1Oh1n0Pth83SyobRl8sK5rPQT40INN5g3Qidi0EEkNkyKAm1
        GGzbEXSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJwsN-006hk0-AH; Wed, 10 Mar 2021 11:19:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F1B63011F0;
        Wed, 10 Mar 2021 12:19:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6218C2115BC7C; Wed, 10 Mar 2021 12:19:38 +0100 (CET)
Date:   Wed, 10 Mar 2021 12:19:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     jgross@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool,x86: Fix uaccess PUSHF/POPF validation
Message-ID: <YEirSryc3X3Lpf44@hirez.programming.kicks-ass.net>
References: <YEY4rIbQYa5fnnEp@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEY4rIbQYa5fnnEp@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Seems like I forgot LKML (again!)...

On Mon, Mar 08, 2021 at 03:46:04PM +0100, Peter Zijlstra wrote:
> 
> Commit ab234a260b1f ("x86/pv: Rework arch_local_irq_restore() to not
> use popf") replaced "push %reg; popf" with something like: "test
> $0x200, %reg; jz 1f; sti; 1:", which breaks the pushf/popf symmetry
> that commit ea24213d8088 ("objtool: Add UACCESS validation") relies
> on.
> 
> The result is:
> 
>   drivers/gpu/drm/amd/amdgpu/si.o: warning: objtool: si_common_hw_init()+0xf36: PUSHF stack exhausted
> 
> Meanwhile, commit c9c324dc22aa ("objtool: Support stack layout changes
> in alternatives") makes that we can actually use stack-ops in
> alternatives, which means we can revert 1ff865e343c2 ("x86,smap: Fix
> smap_{save,restore}() alternatives").
> 
> That in turn means we can limit the PUSHF/POPF handling of
> ea24213d8088 to those instructions that are in alternatives.
> 
> Fixes: ab234a260b1f ("x86/pv: Rework arch_local_irq_restore() to not use popf")
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/smap.h |   10 ++++------
>  tools/objtool/check.c       |    3 +++
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> --- a/arch/x86/include/asm/smap.h
> +++ b/arch/x86/include/asm/smap.h
> @@ -58,9 +58,8 @@ static __always_inline unsigned long sma
>  	unsigned long flags;
>  
>  	asm volatile ("# smap_save\n\t"
> -		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
> -		      "pushf; pop %0; " __ASM_CLAC "\n\t"
> -		      "1:"
> +		      ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC "\n\t",
> +				  X86_FEATURE_SMAP)
>  		      : "=rm" (flags) : : "memory", "cc");
>  
>  	return flags;
> @@ -69,9 +68,8 @@ static __always_inline unsigned long sma
>  static __always_inline void smap_restore(unsigned long flags)
>  {
>  	asm volatile ("# smap_restore\n\t"
> -		      ALTERNATIVE("jmp 1f", "", X86_FEATURE_SMAP)
> -		      "push %0; popf\n\t"
> -		      "1:"
> +		      ALTERNATIVE("", "push %0; popf\n\t",
> +				  X86_FEATURE_SMAP)
>  		      : : "g" (flags) : "memory", "cc");
>  }
>  
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2425,6 +2425,9 @@ static int handle_insn_ops(struct instru
>  		if (update_cfi_state(insn, next_insn, &state->cfi, op))
>  			return 1;
>  
> +		if (!insn->alt_group)
> +			continue;
> +
>  		if (op->dest.type == OP_DEST_PUSHF) {
>  			if (!state->uaccess_stack) {
>  				state->uaccess_stack = 1;
