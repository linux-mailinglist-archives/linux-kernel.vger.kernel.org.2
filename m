Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9CF36BABA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbhDZUda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:33:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:57695 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235996AbhDZUd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:33:29 -0400
IronPort-SDR: WN7SLqJDlYatMVNfXn2UeLt1teKSQGAr3Np8or7y1lUES/3nLVf6TkxgffoabVsOQRgUGYqlCD
 mOabsKZwUoKQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="183882839"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="183882839"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 13:32:46 -0700
IronPort-SDR: NfCJjESRjKa4nXkoNrOqP4OhMAq8ylnlcPmofpj+r1/W3pQzzCj1PHxaVhJsrv2GEiy1z+GgAM
 dkKRiUPWZYHg==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="422785751"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO [10.254.34.181]) ([10.254.34.181])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 13:32:43 -0700
Subject: Re: [RFC v2 05/32] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <2f81f67efdf8c68838cdfbb2314e98747cf70120.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <c2edea0c-8de7-3bd3-1dbe-66b585d78e03@intel.com>
Date:   Mon, 26 Apr 2021 13:32:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2f81f67efdf8c68838cdfbb2314e98747cf70120.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Expose registers R10-R15 to VMM (for bitfield info
> + * refer to TDX GHCI specification).
> + */
> +#define TDVMCALL_EXPOSE_REGS_MASK	0xfc00

Why can't we do:

#define TDC_R10	BIT(18)
#define TDC_R11	BIT(19)

and:

#define TDVMCALL_EXPOSE_REGS_MASK	(TDX_R10 | TDX_R11 | TDX_R12 ...

or at least:

#define TDVMCALL_EXPOSE_REGS_MASK	BIT(18) | BIT(19) ...

?

> +/*
> + * TDX guests use the TDCALL instruction to make
> + * hypercalls to the VMM. It is supported in
> + * Binutils >= 2.36.
> + */
> +#define tdcall .byte 0x66,0x0f,0x01,0xcc
> +
> +/*
> + * __tdcall()  - Used to communicate with the TDX module

Why is this function here?  What does it do?  Why do we need it?

I'd like this to actually talk about doing impedance matching between
the function call and TDCALL ABIs.

> + * @arg1 (RDI) - TDCALL Leaf ID
> + * @arg2 (RSI) - Input parameter 1 passed to TDX module
> + *               via register RCX
> + * @arg2 (RDX) - Input parameter 2 passed to TDX module
> + *               via register RDX
> + * @arg3 (RCX) - Input parameter 3 passed to TDX module
> + *               via register R8
> + * @arg4 (R8)  - Input parameter 4 passed to TDX module
> + *               via register R9

The unnecessary repitition and verbosity actually make this harder to
read.  This looks like it was easy to write, but not much effort is
being made to make it easy to consume.  Could you please apply some
consideration to making it more readable?


> + * @arg5 (R9)  - struct tdcall_output pointer
> + *
> + * @out        - Return status of tdcall via RAX.

Don't comments usually just say "returns ... foo"?  Also, the @params
usually refer to *REAL* variable names.  Where the heck does "out" come
from?  Why are you even putting argX?  Shouldn't these be @'s be their
literal function argument names?

	@rdi - Input parameter, moved to RCX

> + * NOTE: This function should only used for non TDVMCALL
> + *       use cases
> + */
> +SYM_FUNC_START(__tdcall)
> +	FRAME_BEGIN
> +
> +	/* Save non-volatile GPRs that are exposed to the VMM. */
> +	push %r15
> +	push %r14
> +	push %r13
> +	push %r12

Why do we have to save these?  Because they might be clobbered?  If so,
let's say *THAT* instead of just "exposed".  "Exposed" could mean "VMM
can read".

Also, this just told me that this function can't be used to talk to the
VMM.  Why is this talking about exposure to the VMM?

> +	/* Move TDCALL Leaf ID to RAX */
> +	mov %rdi, %rax
> +	/* Move output pointer to R12 */
> +	mov %r9, %r12

I thought 'struct tdcall_output' was a purely software construct.  Why
are we passing a pointer to it into TDCALL?

> +	/* Move input param 4 to R9 */
> +	mov %r8, %r9
> +	/* Move input param 3 to R8 */
> +	mov %rcx, %r8
> +	/* Leave input param 2 in RDX */
> +	/* Move input param 1 to RCX */
> +	mov %rsi, %rcx

With a little work, this can be made a *LOT* more readable:

	/* Mangle function call ABI into TDCALL ABI: */
	mov %rdi, %rax	/* Move TDCALL Leaf ID to RAX */
	mov %r9,  %r12 	/* Move output pointer to R12 */
	mov %r8,  %r9	/* Move input 4 to R9 */
	mov %rcx, %r8	/* Move input 3 to R8 */
	mov %rsi, %rcx	/* Move input 1 to RCX */
	/* Leave input param 2 in RDX */


> +	tdcall
> +
> +	/* Check for TDCALL success: 0 - Successful, otherwise failed */
> +	test %rax, %rax
> +	jnz 1f
> +
> +	/* Check for a TDCALL output struct */
> +	test %r12, %r12
> +	jz 1f

Does some universal status come back in r12?  Aren't we dealing with a
VMM/SEAM-controlled register here?  Isn't this dangerous?

> +	/* Copy TDCALL result registers to output struct: */
> +	movq %rcx, TDCALL_rcx(%r12)
> +	movq %rdx, TDCALL_rdx(%r12)
> +	movq %r8,  TDCALL_r8(%r12)
> +	movq %r9,  TDCALL_r9(%r12)
> +	movq %r10, TDCALL_r10(%r12)
> +	movq %r11, TDCALL_r11(%r12)
> +1:
> +	/* Zero out registers exposed to the TDX Module. */
> +	xor %rcx,  %rcx
> +	xor %rdx,  %rdx
> +	xor %r8d,  %r8d
> +	xor %r9d,  %r9d
> +	xor %r10d, %r10d
> +	xor %r11d, %r11d

... why?

> +	/* Restore non-volatile GPRs that are exposed to the VMM. */
> +	pop %r12
> +	pop %r13
> +	pop %r14
> +	pop %r15
> +
> +	FRAME_END
> +	ret
> +SYM_FUNC_END(__tdcall)
> +
> +/*
> + * do_tdvmcall()  - Used to communicate with the VMM.
> + *
> + * @arg1 (RDI)    - TDVMCALL function, e.g. exit reason
> + * @arg2 (RSI)    - Input parameter 1 passed to VMM
> + *                  via register R12
> + * @arg3 (RDX)    - Input parameter 2 passed to VMM
> + *                  via register R13
> + * @arg4 (RCX)    - Input parameter 3 passed to VMM
> + *                  via register R14
> + * @arg5 (R8)     - Input parameter 4 passed to VMM
> + *                  via register R15
> + * @arg6 (R9)     - struct tdvmcall_output pointer
> + *
> + * @out           - Return status of tdvmcall(R10) via RAX.
> + *
> + */

Same comments on the sparse comment style.

> +SYM_CODE_START_LOCAL(do_tdvmcall)
> +	FRAME_BEGIN
> +
> +	/* Save non-volatile GPRs that are exposed to the VMM. */
> +	push %r15
> +	push %r14
> +	push %r13
> +	push %r12
> +
> +	/* Set TDCALL leaf ID to TDVMCALL (0) in RAX */

I think there needs to be some discussion of what TDCALL and TDVMCALL
are.  They are named too similarly not to do so.

> +	xor %eax, %eax
> +	/* Move TDVMCALL function id (1st argument) to R11 */
> +	mov %rdi, %r11> +	/* Move Input parameter 1-4 to R12-R15 */
> +	mov %rsi, %r12
> +	mov %rdx, %r13
> +	mov %rcx, %r14
> +	mov %r8,  %r15
> +	/* Leave tdvmcall output pointer in R9 */
> +
> +	/*
> +	 * Value of RCX is used by the TDX Module to determine which
> +	 * registers are exposed to VMM. Each bit in RCX represents a
> +	 * register id. You can find the bitmap details from TDX GHCI
> +	 * spec.
> +	 */

This doesn't belong here.  Put it along with the
TDVMCALL_EXPOSE_REGS_MASK, please.

> +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
> +
> +	tdcall
> +
> +	/*
> +	 * Check for TDCALL success: 0 - Successful, otherwise failed.
> +	 * If failed, there is an issue with TDX Module which is fatal
> +	 * for the guest. So panic.
> +	 */
> +	test %rax, %rax
> +	jnz 2f

So, just to be clear: %RAX is under the control of the SEAM module.  The
VMM has no control over it.  Right?

Shouldn't we say that explicitly?

> +	/* Move TDVMCALL success/failure to RAX to return to user */
> +	mov %r10, %rax
> +
> +	/* Check for TDVMCALL success: 0 - Successful, otherwise failed */
> +	test %rax, %rax
> +	jnz 1f
> +
> +	/* Check for a TDVMCALL output struct */
> +	test %r9, %r9
> +	jz 1f

I'd also include a note that %r9 was neither writable nor its value
exposed to the VMM.

> +	/* Copy TDVMCALL result registers to output struct: */
> +	movq %r11, TDVMCALL_r11(%r9)
> +	movq %r12, TDVMCALL_r12(%r9)
> +	movq %r13, TDVMCALL_r13(%r9)
> +	movq %r14, TDVMCALL_r14(%r9)
> +	movq %r15, TDVMCALL_r15(%r9)
> +1:
> +	/*
> +	 * Zero out registers exposed to the VMM to avoid
> +	 * speculative execution with VMM-controlled values.
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
> +
> +	FRAME_END
> +	ret
> +2:
> +	ud2
> +SYM_CODE_END(do_tdvmcall)
> +
> +/* Helper function for standard type of TDVMCALL */
> +SYM_FUNC_START(__tdvmcall)
> +	/* Set TDVMCALL type info (0 - Standard, > 0 - vendor) in R10 */
> +	xor %r10, %r10
> +	call do_tdvmcall
> +	retq
> +SYM_FUNC_END(__tdvmcall)

Why do we need this helper?  Why does it need to be in assembly?

> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 6a7193fead08..29c52128b9c0 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -1,8 +1,44 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (C) 2020 Intel Corporation */
>  
> +#define pr_fmt(fmt) "TDX: " fmt
> +
>  #include <asm/tdx.h>
>  
> +/*
> + * Wrapper for use case that checks for error code and print warning message.
> + */

This comment isn't very useful.  I can see the error check and warning
by reading the code.

> +static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
> +{
> +	u64 err;
> +
> +	err = __tdvmcall(fn, r12, r13, r14, r15, NULL);
> +
> +	if (err)
> +		pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
> +				    fn, err);
> +
> +	return err;
> +}
> +
> +/*
> + * Wrapper for the semi-common case where we need single output value (R11).
> + */
> +static inline u64 tdvmcall_out_r11(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
> +{
> +
> +	struct tdvmcall_output out = {0};
> +	u64 err;
> +
> +	err = __tdvmcall(fn, r12, r13, r14, r15, &out);
> +
> +	if (err)
> +		pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
> +				    fn, err);
> +
> +	return out.r11;
> +}

How do callers check for errors?  Is the error value superfluously
returned in r11 and another output register?
