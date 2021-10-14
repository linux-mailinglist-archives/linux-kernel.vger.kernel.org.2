Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB142D614
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJNJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 05:32:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhJNJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 05:32:51 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634203845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlvY5xutl56r8lNR5Nw4YuOpp5AkAHw7IOSt4WW267Y=;
        b=EKtdI0by24rR1HZCt0lNjaadOhsI15skAFz7NyqC+QTg6o0Mm/V/91NGP04bpqpwxKQZEW
        iCkYEUfw1HHvjqfxXBhMGsE1LGMXwHxZ08Fb+LwokdSE8krhoNZe9FnEbGaJUa1j0x54hP
        tLWNylU2BAuwo7FNzPwVjFXBmAhLlhtAH+rIgK1N4mBMLu/sdT4SKUJ0o62Ys6VkeJ7Rzc
        AxN8bKczcAryU2QAhwkRHpv/19GpxjcQ7KdR60L2y1IK5At8wjhz+S205QL6z1VMW3V/Dl
        o0PZ5KvcR4OY9Tu+qNsWQW/0N/Iu7fSuLlvjBMDZ7Q0TIdkOxVevoD9cknstnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634203845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlvY5xutl56r8lNR5Nw4YuOpp5AkAHw7IOSt4WW267Y=;
        b=c5iRX3r/WYehxTM6/v9uUomZCo7M31b0ExedzPEsQLO2Ze65VbLe1wUIxMAr++SvM3wUFG
        pBkUM8LBjhcNyIBQ==
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 07/11] x86/tdx: Add HLT support for TDX guest
In-Reply-To: <20211009053747.1694419-8-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-8-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 14 Oct 2021 11:30:45 +0200
Message-ID: <87lf2w6ji2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
> +/* HLT TDVMCALL sub-function ID */
> +#define EXIT_REASON_HLT			12

arch/x86/include/uapi/asm/vmx.h:#define EXIT_REASON_HLT                 12

Is there a _good_ reason why this can't be reused?

>  /*
>   * __tdx_module_call()  - Helper function used by TDX guests to request
>   * services from the TDX module (does not include VMM services).
> @@ -235,6 +238,33 @@ SYM_FUNC_START(__tdx_hypercall)
>  
>  	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>  
> +	/*
> +	 * For the idle loop STI needs to be called directly before
> +	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
> +	 * enables interrupts only one instruction later. If there
> +	 * are any instructions between the STI and the TDCALL for
> +	 * HLT then an interrupt could happen in that time, but the
> +	 * code would go back to sleep afterwards, which can cause
> +	 * longer delays.
> +	 *
> +	 * This leads to significant difference in network performance
> +	 * benchmarks. So add a special case for EXIT_REASON_HLT to
> +	 * trigger STI before TDCALL. But this change is not required
> +	 * for all HLT cases. So use R15 register value to identify the
> +	 * case which needs STI. So, if R11 is EXIT_REASON_HLT and R15
> +	 * is 1, then call STI before TDCALL instruction. Note that R15
> +	 * register is not required by TDCALL ABI when triggering the
> +	 * hypercall for EXIT_REASON_HLT case. So use it in software to
> +	 * select the STI case.
> +	 */
> +	cmpl $EXIT_REASON_HLT, %r11d
> +	jne skip_sti
> +	cmpl $1, %r15d

You already have a nice define for EXIT_REASON_HLT. Please add one for this
constant as well.

> +	jne skip_sti
> +	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
> +	xor %r15, %r15
> +	sti
> +skip_sti:
>  	tdcall

>  bool tdx_get_ve_info(struct ve_info *ve)
>  {
>  	struct tdx_module_output out;
> @@ -84,8 +141,19 @@ bool tdx_get_ve_info(struct ve_info *ve)
>  bool tdx_handle_virtualization_exception(struct pt_regs *regs,
>  					 struct ve_info *ve)
>  {
> -	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> -	return false;
> +	switch (ve->exit_reason) {
> +	case EXIT_REASON_HLT:
> +		tdx_halt();
> +		break;
> +	default:
> +		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> +		return false;
> +	}
> +
> +	/* After successful #VE handling, move the IP */
> +	regs->ip += ve->instr_len;
> +
> +	return true;
>  }
>  
>  void __init tdx_early_init(void)
> @@ -95,5 +163,8 @@ void __init tdx_early_init(void)
>  
>  	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>  
> +	pv_ops.irq.safe_halt = tdx_safe_halt;
> +	pv_ops.irq.halt = tdx_halt;

Colour me confused, but why do we end up in #VE with EXIT_REASON_HLT
when halt/safe_halt is paravirtualized?

There may be a valid reason. If so then this lacks a comment.

Thanks,

        tglx
