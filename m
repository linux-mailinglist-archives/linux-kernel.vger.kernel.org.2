Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8EE36BBAE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhDZWbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:31:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:37486 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232161AbhDZWbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:31:49 -0400
IronPort-SDR: J/Clzl4hhABbPTIqlTdzDg2t3Wp7wPs8peB2i6RIwbvw1hia3x/3sTBx5PSk7lrUjom5TTLvtJ
 3Nhn6W/n42/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175896953"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="175896953"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 15:31:06 -0700
IronPort-SDR: zb0md/Q1HMsA1aX+IPSuILwhcW/LQneg/JaKh+AQzTtI+qnwjmm2KYKxSUXqAtTQ+A9w3lauK5
 p7JZxoXvinQg==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="465271932"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 15:31:05 -0700
Subject: Re: [RFC v2 05/32] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
To:     Dave Hansen <dave.hansen@intel.com>,
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
 <c2edea0c-8de7-3bd3-1dbe-66b585d78e03@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f310c626-5fd9-7fd3-23fa-e319c0f2aa98@linux.intel.com>
Date:   Mon, 26 Apr 2021 15:31:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c2edea0c-8de7-3bd3-1dbe-66b585d78e03@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/21 1:32 PM, Dave Hansen wrote:
>> +/*
>> + * Expose registers R10-R15 to VMM (for bitfield info
>> + * refer to TDX GHCI specification).
>> + */
>> +#define TDVMCALL_EXPOSE_REGS_MASK	0xfc00
> 
> Why can't we do:
> 
> #define TDC_R10	BIT(18)
> #define TDC_R11	BIT(19)
> 
> and:
> 
> #define TDVMCALL_EXPOSE_REGS_MASK	(TDX_R10 | TDX_R11 | TDX_R12 ...
> 
> or at least:
> 
> #define TDVMCALL_EXPOSE_REGS_MASK	BIT(18) | BIT(19) ...

If this is the preferred way, I will change it use macros (TDX_Rxx).

> 
> ?
> 
>> +/*
>> + * TDX guests use the TDCALL instruction to make
>> + * hypercalls to the VMM. It is supported in
>> + * Binutils >= 2.36.
>> + */
>> +#define tdcall .byte 0x66,0x0f,0x01,0xcc
>> +
>> +/*
>> + * __tdcall()  - Used to communicate with the TDX module
> 
> Why is this function here?  What does it do?  Why do we need it?

__tdcall() function is used to request services from the TDX Module.
Example use cases are, TDREPORT, VEINFO, TDINFO, etc.

> 
> I'd like this to actually talk about doing impedance matching between
> the function call and TDCALL ABIs.
> 
>> + * @arg1 (RDI) - TDCALL Leaf ID
>> + * @arg2 (RSI) - Input parameter 1 passed to TDX module
>> + *               via register RCX
>> + * @arg2 (RDX) - Input parameter 2 passed to TDX module
>> + *               via register RDX
>> + * @arg3 (RCX) - Input parameter 3 passed to TDX module
>> + *               via register R8
>> + * @arg4 (R8)  - Input parameter 4 passed to TDX module
>> + *               via register R9
> 
> The unnecessary repitition and verbosity actually make this harder to
> read.  This looks like it was easy to write, but not much effort is
> being made to make it easy to consume.  Could you please apply some
> consideration to making it more readable?
> 
> 
>> + * @arg5 (R9)  - struct tdcall_output pointer
>> + *
>> + * @out        - Return status of tdcall via RAX.
> 
> Don't comments usually just say "returns ... foo"?  Also, the @params
> usually refer to *REAL* variable names.  Where the heck does "out" come
> from?  Why are you even putting argX?  Shouldn't these be @'s be their
> literal function argument names?

I have added this comment block to make it easier for us to understand
the register mapping between function arguments and TDCALL ABI. But I got
your point. Usage of @arg1 or @out does not comply the function comment
standards. I will fix this in next version.

> 
> 	@rdi - Input parameter, moved to RCX

I will use the above format to document function arguments.

> 
>> + * NOTE: This function should only used for non TDVMCALL
>> + *       use cases
>> + */
>> +SYM_FUNC_START(__tdcall)
>> +	FRAME_BEGIN
>> +
>> +	/* Save non-volatile GPRs that are exposed to the VMM. */
>> +	push %r15
>> +	push %r14
>> +	push %r13
>> +	push %r12
> 
> Why do we have to save these?  Because they might be clobbered?  If so,
> let's say *THAT* instead of just "exposed".  "Exposed" could mean "VMM
> can read".
> 
> Also, this just told me that this function can't be used to talk to the
> VMM.  Why is this talking about exposure to the VMM?

Although __tdcall() is only used to communicate with the TDX module and the
TDX module is not supposed to touch these registers, just to be on the safe
side, I have tried to save the context of registers R12-R15. Anyway cycles
used by instructions are less compared to tdcall.


> 
>> +	/* Move TDCALL Leaf ID to RAX */
>> +	mov %rdi, %rax
>> +	/* Move output pointer to R12 */
>> +	mov %r9, %r12
> 
> I thought 'struct tdcall_output' was a purely software construct.  Why
> are we passing a pointer to it into TDCALL?

Its used to store the TDCALL result (RCX, RDX, R8-R11). As far as this
function is concerned, its just a block of memory (accessed using
base address + TDCALL_r* offsets).

> 
>> +	/* Move input param 4 to R9 */
>> +	mov %r8, %r9
>> +	/* Move input param 3 to R8 */
>> +	mov %rcx, %r8
>> +	/* Leave input param 2 in RDX */
>> +	/* Move input param 1 to RCX */
>> +	mov %rsi, %rcx
> 
> With a little work, this can be made a *LOT* more readable:
> 
> 	/* Mangle function call ABI into TDCALL ABI: */
> 	mov %rdi, %rax	/* Move TDCALL Leaf ID to RAX */
> 	mov %r9,  %r12 	/* Move output pointer to R12 */
> 	mov %r8,  %r9	/* Move input 4 to R9 */
> 	mov %rcx, %r8	/* Move input 3 to R8 */
> 	mov %rsi, %rcx	/* Move input 1 to RCX */
> 	/* Leave input param 2 in RDX */

Ok. I will use your version.

> 
> 
>> +	tdcall
>> +
>> +	/* Check for TDCALL success: 0 - Successful, otherwise failed */
>> +	test %rax, %rax
>> +	jnz 1f
>> +
>> +	/* Check for a TDCALL output struct */
>> +	test %r12, %r12
>> +	jz 1f
> 
> Does some universal status come back in r12?  Aren't we dealing with a
> VMM/SEAM-controlled register here?  Isn't this dangerous?

R12 is the temporary register we have used to store the address of user
passed output pointer. We just check for NULL condition here. R12 will
not be used by the TDX module.

If you prefer, we can just push the output pointer to stack and get it
after we make the tdcall.

> 
>> +	/* Copy TDCALL result registers to output struct: */
>> +	movq %rcx, TDCALL_rcx(%r12)
>> +	movq %rdx, TDCALL_rdx(%r12)
>> +	movq %r8,  TDCALL_r8(%r12)
>> +	movq %r9,  TDCALL_r9(%r12)
>> +	movq %r10, TDCALL_r10(%r12)
>> +	movq %r11, TDCALL_r11(%r12)
>> +1:
>> +	/* Zero out registers exposed to the TDX Module. */
>> +	xor %rcx,  %rcx
>> +	xor %rdx,  %rdx
>> +	xor %r8d,  %r8d
>> +	xor %r9d,  %r9d
>> +	xor %r10d, %r10d
>> +	xor %r11d, %r11d
> 
> ... why?

These registers are used by the TDX Module. Why pass the stale values
back to the user? So we clear them here.

> 
>> +	/* Restore non-volatile GPRs that are exposed to the VMM. */
>> +	pop %r12
>> +	pop %r13
>> +	pop %r14
>> +	pop %r15
>> +
>> +	FRAME_END
>> +	ret
>> +SYM_FUNC_END(__tdcall)
>> +
>> +/*
>> + * do_tdvmcall()  - Used to communicate with the VMM.
>> + *
>> + * @arg1 (RDI)    - TDVMCALL function, e.g. exit reason
>> + * @arg2 (RSI)    - Input parameter 1 passed to VMM
>> + *                  via register R12
>> + * @arg3 (RDX)    - Input parameter 2 passed to VMM
>> + *                  via register R13
>> + * @arg4 (RCX)    - Input parameter 3 passed to VMM
>> + *                  via register R14
>> + * @arg5 (R8)     - Input parameter 4 passed to VMM
>> + *                  via register R15
>> + * @arg6 (R9)     - struct tdvmcall_output pointer
>> + *
>> + * @out           - Return status of tdvmcall(R10) via RAX.
>> + *
>> + */
> 
> Same comments on the sparse comment style.

will fix it similar to __tdcall().

> 
>> +SYM_CODE_START_LOCAL(do_tdvmcall)
>> +	FRAME_BEGIN
>> +
>> +	/* Save non-volatile GPRs that are exposed to the VMM. */
>> +	push %r15
>> +	push %r14
>> +	push %r13
>> +	push %r12
>> +
>> +	/* Set TDCALL leaf ID to TDVMCALL (0) in RAX */
> 
> I think there needs to be some discussion of what TDCALL and TDVMCALL
> are.  They are named too similarly not to do so.

TDVMCALL is the sub function of TDCALL (selected by setting RAX register
to 0). TDVMCALL is used to request services from VMM.

> 
>> +	xor %eax, %eax
>> +	/* Move TDVMCALL function id (1st argument) to R11 */
>> +	mov %rdi, %r11> +	/* Move Input parameter 1-4 to R12-R15 */
>> +	mov %rsi, %r12
>> +	mov %rdx, %r13
>> +	mov %rcx, %r14
>> +	mov %r8,  %r15
>> +	/* Leave tdvmcall output pointer in R9 */
>> +
>> +	/*
>> +	 * Value of RCX is used by the TDX Module to determine which
>> +	 * registers are exposed to VMM. Each bit in RCX represents a
>> +	 * register id. You can find the bitmap details from TDX GHCI
>> +	 * spec.
>> +	 */
> 
> This doesn't belong here.  Put it along with the
> TDVMCALL_EXPOSE_REGS_MASK, please.

Ok. I will do it.

> 
>> +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>> +
>> +	tdcall
>> +
>> +	/*
>> +	 * Check for TDCALL success: 0 - Successful, otherwise failed.
>> +	 * If failed, there is an issue with TDX Module which is fatal
>> +	 * for the guest. So panic.
>> +	 */
>> +	test %rax, %rax
>> +	jnz 2f
> 
> So, just to be clear: %RAX is under the control of the SEAM module.  The
> VMM has no control over it.  Right?

AFAIK, VMM will not touch it.

Sean, please confirm it.

> 
> Shouldn't we say that explicitly?

I can add it to above comment.

> 
>> +	/* Move TDVMCALL success/failure to RAX to return to user */
>> +	mov %r10, %rax
>> +
>> +	/* Check for TDVMCALL success: 0 - Successful, otherwise failed */
>> +	test %rax, %rax
>> +	jnz 1f
>> +
>> +	/* Check for a TDVMCALL output struct */
>> +	test %r9, %r9
>> +	jz 1f
> 
> I'd also include a note that %r9 was neither writable nor its value
> exposed to the VMM.

will do it.

> 
>> +	/* Copy TDVMCALL result registers to output struct: */
>> +	movq %r11, TDVMCALL_r11(%r9)
>> +	movq %r12, TDVMCALL_r12(%r9)
>> +	movq %r13, TDVMCALL_r13(%r9)
>> +	movq %r14, TDVMCALL_r14(%r9)
>> +	movq %r15, TDVMCALL_r15(%r9)
>> +1:
>> +	/*
>> +	 * Zero out registers exposed to the VMM to avoid
>> +	 * speculative execution with VMM-controlled values.
>> +	 */
>> +	xor %r10d, %r10d
>> +	xor %r11d, %r11d
>> +	xor %r12d, %r12d
>> +	xor %r13d, %r13d
>> +	xor %r14d, %r14d
>> +	xor %r15d, %r15d
>> +
>> +	/* Restore non-volatile GPRs that are exposed to the VMM. */
>> +	pop %r12
>> +	pop %r13
>> +	pop %r14
>> +	pop %r15
>> +
>> +	FRAME_END
>> +	ret
>> +2:
>> +	ud2
>> +SYM_CODE_END(do_tdvmcall)
>> +
>> +/* Helper function for standard type of TDVMCALL */
>> +SYM_FUNC_START(__tdvmcall)
>> +	/* Set TDVMCALL type info (0 - Standard, > 0 - vendor) in R10 */
>> +	xor %r10, %r10
>> +	call do_tdvmcall
>> +	retq
>> +SYM_FUNC_END(__tdvmcall)
> 
> Why do we need this helper?  Why does it need to be in assembly?

Its simpler to do it in assembly. Also, grouping all register updates
in the same file will make it easier for us to read or debug issues. Another
reason is, we also call do_tdvmcall() from in/out instruction use case.

> 
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> index 6a7193fead08..29c52128b9c0 100644
>> --- a/arch/x86/kernel/tdx.c
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -1,8 +1,44 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /* Copyright (C) 2020 Intel Corporation */
>>   
>> +#define pr_fmt(fmt) "TDX: " fmt
>> +
>>   #include <asm/tdx.h>
>>   
>> +/*
>> + * Wrapper for use case that checks for error code and print warning message.
>> + */
> 
> This comment isn't very useful.  I can see the error check and warning
> by reading the code.

Its just a helper function that covers common case of checking for error
and print the warning message. If this comment is superfluous, I can remove
it.

> 
>> +static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
>> +{
>> +	u64 err;
>> +
>> +	err = __tdvmcall(fn, r12, r13, r14, r15, NULL);
>> +
>> +	if (err)
>> +		pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
>> +				    fn, err);
>> +
>> +	return err;
>> +}
>> +
>> +/*
>> + * Wrapper for the semi-common case where we need single output value (R11).
>> + */
>> +static inline u64 tdvmcall_out_r11(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
>> +{
>> +
>> +	struct tdvmcall_output out = {0};
>> +	u64 err;
>> +
>> +	err = __tdvmcall(fn, r12, r13, r14, r15, &out);
>> +
>> +	if (err)
>> +		pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
>> +				    fn, err);
>> +
>> +	return out.r11;
>> +}
> 
> How do callers check for errors?  Is the error value superfluously
> returned in r11 and another output register?

We already check for error in this helper function. User of this function
only cares about output value (R11). Mainly for in/out use case.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
