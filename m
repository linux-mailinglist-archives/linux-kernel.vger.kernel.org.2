Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684F33A5E89
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 10:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhFNIuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 04:50:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48198 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232528AbhFNIuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 04:50:15 -0400
Received: from zn.tnic (p200300ec2f09b900cf4721bcce7169d6.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b900:cf47:21bc:ce71:69d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9DBB1EC036C;
        Mon, 14 Jun 2021 10:48:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1623660491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kbLqJJn+1Cb9Nze6CmGXwI38IIvb4kbNqEbQ95z2nzM=;
        b=j4ySaJL8AWZcm0+1QG2BLMR16bFXOnjgqcMksJ3Xr1KxZU4aO/xo4lRbpExAZcg1CiPzR9
        T/O8/EIoXbILTRGQpgE8J2rwJjiql3+4Jlw4OcKw4zWy5voMQLKHcWYxOzXIDQj4KH/khn
        Ase8IXSjWD8ayqP16lFZf4Cy91bq+r8=
Date:   Mon, 14 Jun 2021 10:47:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 05/11] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <YMcXvzD2o7rWsl0W@zn.tnic>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-6-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210602022136.2186759-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 07:21:30PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +/*
> + * __tdx_module_call()  - Helper function used by TDX guests to request
> + * services from the TDX module (does not include VMM services).
> + *
> + * This function serves as a wrapper to move user call arguments to the
> + * correct registers as specified by "tdcall" ABI

Please state here explicitly what the TDCALL ABI is. I see below "moved
to" which translates the x86_64 ABI into your ABI but please state it
here explicitly what it is (which register is what in a tabellary form)
so that it is crystal clear and the code can be followed easily.

> and shares it with the
> + * TDX module. If the "tdcall" operation is successful and a valid

Use TDCALL everywhere here in the comments to refer to the
insn/operation.

> + * "struct tdx_module_output" pointer is available (in "out" argument),
> + * output from the TDX module is saved to the memory specified in the
> + * "out" pointer. Also the status of the "tdcall" operation is returned
> + * back to the user as a function return value.
> + *
> + * @fn  (RDI)		- TDCALL Leaf ID,    moved to RAX
> + * @rcx (RSI)		- Input parameter 1, moved to RCX
> + * @rdx (RDX)		- Input parameter 2, moved to RDX
> + * @r8  (RCX)		- Input parameter 3, moved to R8
> + * @r9  (R8)		- Input parameter 4, moved to R9
> + *
> + * @out (R9)		- struct tdx_module_output pointer
> + *			  stored temporarily in R12 (not
> + * 			  shared with the TDX module)
> + *
> + * Return status of tdcall via RAX.
> + *
> + * NOTE: This function should not be used for TDX hypercall
> + *       use cases.

What does that mean? I think you wanna say here that this function calls
the *module* and not the hypervisor...

> + */
> +SYM_FUNC_START(__tdx_module_call)
> +	FRAME_BEGIN
> +
> +	/*
> +	 * R12 will be used as temporary storage for
> +	 * struct tdx_module_output pointer. You can
> +	 * find struct tdx_module_output details in
> +	 * arch/x86/include/asm/tdx.h. Also note that
> +	 * registers R12-R15 are not used by TDCALL
> +	 * services supported by this helper function.
> +	 */
> +	push %r12	/* Callee saved, so preserve it */
> +	mov %r9,  %r12 	/* Move output pointer to R12 */

Please make all those side comments, top comments by moving them over
the line they refer to.

> +	/* Mangle function call ABI into TDCALL ABI: */
> +	mov %rdi, %rax	/* Move TDCALL Leaf ID to RAX */
> +	mov %r8,  %r9	/* Move input 4 to R9 */
> +	mov %rcx, %r8	/* Move input 3 to R8 */
> +	mov %rsi, %rcx	/* Move input 1 to RCX */
> +	/* Leave input param 2 in RDX */
> +
> +	tdcall
> +
> +	/* Check for TDCALL success: 0 - Successful, otherwise failed */
> +	test %rax, %rax
> +	jnz 1f
> +
> +	/* Check if caller provided an output struct */
> +	test %r12, %r12
> +	jz 1f

Why is that check done *after* the TDCALL and not before?

You can have TDCALL leaf functions without output?

If so, just say so.

> +	/* Copy TDCALL result registers to output struct: */
> +	movq %rcx, TDX_MODULE_rcx(%r12)
> +	movq %rdx, TDX_MODULE_rdx(%r12)
> +	movq %r8,  TDX_MODULE_r8(%r12)
> +	movq %r9,  TDX_MODULE_r9(%r12)
> +	movq %r10, TDX_MODULE_r10(%r12)
> +	movq %r11, TDX_MODULE_r11(%r12)
> +1:
> +	pop %r12 /* Restore the state of R12 register */
> +
> +	FRAME_END
> +	ret
> +SYM_FUNC_END(__tdx_module_call)
> +
> +/*
> + * do_tdx_hypercall()  - Helper function used by TDX guests to request
> + * services from the VMM. All requests are made via the TDX module
> + * using "TDCALL" instruction.
> + *
> + * This function is created to contain common code between vendor
> + * specific and standard type TDX hypercalls. So the caller of this
> + * function had to set the TDVMCALL type in the R10 register before
> + * calling it.
> + *
> + * This function serves as a wrapper to move user call arguments to the
> + * correct registers as specified by "tdcall" ABI and shares it with VMM

As above - document the ABI explicitly here pls.

> + * via the TDX module. If the "tdcall" operation is successful and a
> + * valid "struct tdx_hypercall_output" pointer is available (in "out"
> + * argument), output from the VMM is saved to the memory specified in the
> + * "out" pointer. 
> + *
> + * @fn  (RDI)		- TDVMCALL function, moved to R11
> + * @r12 (RSI)		- Input parameter 1, moved to R12
> + * @r13 (RDX)		- Input parameter 2, moved to R13
> + * @r14 (RCX)		- Input parameter 3, moved to R14
> + * @r15 (R8)		- Input parameter 4, moved to R15
> + *
> + * @out (R9)		- struct tdx_hypercall_output pointer
> + *
> + * On successful completion, return TDX hypercall error code.
> + *

^ Superfluous line.

> + */
> +SYM_FUNC_START_LOCAL(do_tdx_hypercall)
> +	/* Save non-volatile GPRs that are exposed to the VMM. */

"Save callee-s ved GPRs as mandated by the x86_64 ABI"

because you're callee and you have to save them. :)

> +	push %r15
> +	push %r14
> +	push %r13
> +	push %r12
> +
> +	/* Leave hypercall output pointer in R9, it's not clobbered by VMM */

Guaranteed by what, exactly?

I'm sure you have enough stack to push another u64 value and then
restore it after the TDCALL so that you don't have to care what the VMM
does wrt R9.

> +
> +	/* Mangle function call ABI into TDCALL ABI: */
> +	xor %eax, %eax /* Move TDCALL leaf ID (TDVMCALL (0)) to RAX */

If leaf function 0 is calling the HV, then says so instead of writing
"Move" but having an XOR there.

> +	mov %rdi, %r11 /* Move TDVMCALL function id to R11 */

If I'm reading that pdf correctly, it says:

"R11	TDG.VP.VMCALL sub-function if R10 is 0 (see enumeration below)"

> +	mov %rsi, %r12 /* Move input 1 to R12 */
> +	mov %rdx, %r13 /* Move input 2 to R13 */
> +	mov %rcx, %r14 /* Move input 1 to R14 */
> +	mov %r8,  %r15 /* Move input 1 to R15 */
> +	/* Caller of do_tdx_hypercall() will set TDVMCALL type in R10 */

Ah, there it is. Yuck.

How about passing that vendor-specific leaf set on the stack like all
the other sane ABIs do when they need more than 6 input params passed
through regs?

I don't like a caller function prepping registers for the callee.

> +
> +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
> +
> +	tdcall
> +
> +	/*
> +	 * Non-zero RAX values indicate a failure of TDCALL itself.
> +	 * Panic for those.  This value is unrelated to the hypercall
> +	 * result in R10.
> +	 */
> +	test %rax, %rax
> +	jnz 2f
> +
> +	/* Move hypercall error code to RAX to return to user */
> +	mov %r10, %rax
> +
> +	/* Check for hypercall success: 0 - Successful, otherwise failed */
> +	test %rax, %rax
> +	jnz 1f
> +
> +	/* Check if caller provided an output struct */

Same as for __tdx_module_call

> +	test %r9, %r9
> +	jz 1f
> +
> +	/* Copy hypercall result registers to output struct: */
> +	movq %r11, TDX_HYPERCALL_r11(%r9)
> +	movq %r12, TDX_HYPERCALL_r12(%r9)
> +	movq %r13, TDX_HYPERCALL_r13(%r9)
> +	movq %r14, TDX_HYPERCALL_r14(%r9)
> +	movq %r15, TDX_HYPERCALL_r15(%r9)
> +1:
> +	/*
> +	 * Zero out registers exposed to the VMM to avoid

Why if you...

> +	 * speculative execution with VMM-controlled values.
> +	 * This needs to include all registers present in
> +	 * TDVMCALL_EXPOSE_REGS_MASK.
> +	 */
> +	xor %r10d, %r10d
> +	xor %r11d, %r11d
> +	xor %r12d, %r12d
> +	xor %r13d, %r13d
> +	xor %r14d, %r14d
> +	xor %r15d, %r15d
> +
> +	/* Restore non-volatile GPRs that are exposed to the VMM. */
> +	pop %r12
> +	pop %r13
> +	pop %r14
> +	pop %r15

... are going to overwrite most of them here?

I.e., you can clear only R10 and R11 and the rest will be overwritten by
the callee-saved values.

> +
> +	ret
> +2:
> +	/*
> +	 * Reaching here means failure in TDCALL execution. This is
> +	 * not supposed to happen in hypercalls. It means the TDX
> +	 * module is in buggy state. So panic.
> +	 */
> +	ud2

How is the user going to know that the module has a bug? Are we issuing
an error message somewhere before that panic or the guest screen will
remain black/freeze and the poor luser won't have a clue what happened?

> +SYM_FUNC_END(do_tdx_hypercall)
> +
> +/*
> + * Helper function for standard type of TDVMCALLs. This assembly
> + * wrapper reuses do_tdvmcall() for standard type of hypercalls
> + * (R10 is set as zero).
> + */
> +SYM_FUNC_START(__tdx_hypercall)
> +	FRAME_BEGIN
> +	/*
> +	 * R10 is not part of the function call ABI, but it is a part
> +	 * of the TDVMCALL ABI. So set it 0 for standard type TDVMCALL
> +	 * before making call to the do_tdx_hypercall().
> +	 */
> +	xor %r10, %r10
> +	call do_tdx_hypercall
> +	FRAME_END
> +	retq
> +SYM_FUNC_END(__tdx_hypercall)
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 5e70617e9877..97b54317f799 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -1,8 +1,46 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (C) 2020 Intel Corporation */
>  
> +#define pr_fmt(fmt) "TDX: " fmt
> +
>  #include <asm/tdx.h>
>  
> +/*
> + * Wrapper for simple hypercalls that only return a success/error code.
> + */
> +static inline u64 tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
> +{
> +	u64 err;
> +
> +	err = __tdx_hypercall(fn, r12, r13, r14, r15, NULL);
> +


^ Superfluous newline. Ditto below.

> +	if (err)
> +		pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",

Prefix those hex values with "0x" so that it is clear what the number
format is. Ditto below.

> +				    fn, err);

You can leave those to stick out and not break the line. Ditto below.

> +
> +	return err;
> +}
> +
> +/*
> + * Wrapper for the semi-common case where user need single output
> + * value (R11). Callers of this function does not care about the
> + * hypercall error code (mainly for IN or MMIO usecase).
> + */
> +static inline u64 tdx_hypercall_out_r11(u64 fn, u64 r12, u64 r13,

No need to hardcode the register which has the retval in the function
name - just call it tdx_hypercall_out() or so.

> +					u64 r14, u64 r15)
> +{
> +	struct tdx_hypercall_output out = {0};
> +	u64 err;
> +
> +	err = __tdx_hypercall(fn, r12, r13, r14, r15, &out);
> +
> +	if (err)
> +		pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
> +				    fn, err);
> +
> +	return out.r11;
> +}
> +
>  static inline bool cpuid_has_tdx_guest(void)
>  {
>  	u32 eax, signature[3];
> -- 
> 2.25.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
