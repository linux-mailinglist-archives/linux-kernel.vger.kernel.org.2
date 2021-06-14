Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F06C3A6F58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 21:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhFNTsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 15:48:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:47411 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhFNTsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 15:48:11 -0400
IronPort-SDR: M1s29i1te2ahMgWZzoEPZVSysSoWYCQvY1U6sUAVDPK23EJQuvwvZxEL9/TBn0TO7hNuaATC0r
 s8B8+jHSr1rQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="227326714"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="227326714"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 12:45:48 -0700
IronPort-SDR: 2ynFm7Pex2jXycuZ9OJfRy9VgE1kU+/I2JX7mPlLLUHpA1+CFtc38ECY8cqy9bJ8mZSnm7Y63U
 NJYrgzsFVWXA==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="621131984"
Received: from unknown (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.156.97])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 12:45:47 -0700
Subject: Re: [PATCH v1 05/11] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
To:     Borislav Petkov <bp@alien8.de>
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
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMcXvzD2o7rWsl0W@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b0dff409-d084-bfc1-c260-e1732b5e8ee5@linux.intel.com>
Date:   Mon, 14 Jun 2021 12:45:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMcXvzD2o7rWsl0W@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/21 1:47 AM, Borislav Petkov wrote:
> On Tue, Jun 01, 2021 at 07:21:30PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +/*
>> + * __tdx_module_call()  - Helper function used by TDX guests to request
>> + * services from the TDX module (does not include VMM services).
>> + *
>> + * This function serves as a wrapper to move user call arguments to the
>> + * correct registers as specified by "tdcall" ABI
> 
> Please state here explicitly what the TDCALL ABI is. I see below "moved
> to" which translates the x86_64 ABI into your ABI but please state it
> here explicitly what it is (which register is what in a tabellary form)
> so that it is crystal clear and the code can be followed easily.

Ok. I will include the TDCALL ABI details here.

> 
>> and shares it with the
>> + * TDX module. If the "tdcall" operation is successful and a valid
> 
> Use TDCALL everywhere here in the comments to refer to the
> insn/operation.

Ok. I will fix it in next version.

> 
>> + * "struct tdx_module_output" pointer is available (in "out" argument),
>> + * output from the TDX module is saved to the memory specified in the
>> + * "out" pointer. Also the status of the "tdcall" operation is returned
>> + * back to the user as a function return value.
>> + *
>> + * @fn  (RDI)		- TDCALL Leaf ID,    moved to RAX
>> + * @rcx (RSI)		- Input parameter 1, moved to RCX
>> + * @rdx (RDX)		- Input parameter 2, moved to RDX
>> + * @r8  (RCX)		- Input parameter 3, moved to R8
>> + * @r9  (R8)		- Input parameter 4, moved to R9
>> + *
>> + * @out (R9)		- struct tdx_module_output pointer
>> + *			  stored temporarily in R12 (not
>> + * 			  shared with the TDX module)
>> + *
>> + * Return status of tdcall via RAX.
>> + *
>> + * NOTE: This function should not be used for TDX hypercall
>> + *       use cases.
> 
> What does that mean? I think you wanna say here that this function calls
> the *module* and not the hypervisor...

Yes, you are right. But I can remove that comment. It does not add much
value.


>> +	 */
>> +	push %r12	/* Callee saved, so preserve it */
>> +	mov %r9,  %r12 	/* Move output pointer to R12 */
> 
> Please make all those side comments, top comments by moving them over
> the line they refer to.

Ok. I will move it up.

> 

>> +
>> +	/* Check if caller provided an output struct */
>> +	test %r12, %r12
>> +	jz 1f
> 
> Why is that check done *after* the TDCALL and not before?
> 
> You can have TDCALL leaf functions without output?

Yes. It is possible to call tdx_module_call() without output
pointer.

Examples are TDREPORT and TDACCEPTPAGE.

> 
> If so, just say so.

I will include comment about it.


>> + * do_tdx_hypercall()  - Helper function used by TDX guests to request
>> + * services from the VMM. All requests are made via the TDX module
>> + * using "TDCALL" instruction.
>> + *
>> + * This function is created to contain common code between vendor
>> + * specific and standard type TDX hypercalls. So the caller of this
>> + * function had to set the TDVMCALL type in the R10 register before
>> + * calling it.
>> + *
>> + * This function serves as a wrapper to move user call arguments to the
>> + * correct registers as specified by "tdcall" ABI and shares it with VMM
> 
> As above - document the ABI explicitly here pls.

Ok. I will add the ABI details in next version.

> 

> 
> ^ Superfluous line.

will remove it.

> 
>> + */
>> +SYM_FUNC_START_LOCAL(do_tdx_hypercall)
>> +	/* Save non-volatile GPRs that are exposed to the VMM. */
> 
> "Save callee-s ved GPRs as mandated by the x86_64 ABI"
> 
> because you're callee and you have to save them. :)
> 
>> +	push %r15
>> +	push %r14
>> +	push %r13
>> +	push %r12
>> +
>> +	/* Leave hypercall output pointer in R9, it's not clobbered by VMM */
> 
> Guaranteed by what, exactly?
> 
> I'm sure you have enough stack to push another u64 value and then
> restore it after the TDCALL so that you don't have to care what the VMM
> does wrt R9.

Since we don't mark R9 as shared in RCX register, we don't expect VMM to
use it. But I am not sure whether TDX module will guarantee it. So, for our
use case, I can use stack for it.

> 
>> +
>> +	/* Mangle function call ABI into TDCALL ABI: */
>> +	xor %eax, %eax /* Move TDCALL leaf ID (TDVMCALL (0)) to RAX */
> 
> If leaf function 0 is calling the HV, then says so instead of writing
> "Move" but having an XOR there.

May be I should define a macro for it and use Mov to keep it uniform
with other register updates.

> 
>> +	mov %rdi, %r11 /* Move TDVMCALL function id to R11 */
> 
> If I'm reading that pdf correctly, it says:
> 
> "R11	TDG.VP.VMCALL sub-function if R10 is 0 (see enumeration below)"

Yes, it is the sub function id. I will fix the comment in next version.

> 
>> +	mov %rsi, %r12 /* Move input 1 to R12 */
>> +	mov %rdx, %r13 /* Move input 2 to R13 */
>> +	mov %rcx, %r14 /* Move input 1 to R14 */
>> +	mov %r8,  %r15 /* Move input 1 to R15 */
>> +	/* Caller of do_tdx_hypercall() will set TDVMCALL type in R10 */
> 
> Ah, there it is. Yuck.
> 
> How about passing that vendor-specific leaf set on the stack like all
> the other sane ABIs do when they need more than 6 input params passed
> through regs?
> 
> I don't like a caller function prepping registers for the callee.

do_tdx_hypercall() is defined and used only in this assembly file.
It is the helper function for __tdx_hypercall() and
__tdx_hypercall_vendor_kvm() functions which needs different values in
R10 register.

But, I am fine with passing it via stack, if this is recommended.

Please let me know.

> 
>> +
>> +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>> +
>> +	tdcall
>> +
>> +	/*
>> +	 * Non-zero RAX values indicate a failure of TDCALL itself.
>> +	 * Panic for those.  This value is unrelated to the hypercall
>> +	 * result in R10.
>> +	 */
>> +	test %rax, %rax
>> +	jnz 2f
>> +
>> +	/* Move hypercall error code to RAX to return to user */
>> +	mov %r10, %rax
>> +
>> +	/* Check for hypercall success: 0 - Successful, otherwise failed */
>> +	test %rax, %rax
>> +	jnz 1f
>> +
>> +	/* Check if caller provided an output struct */
> 
> Same as for __tdx_module_call

It is possible to call it without output pointer. I will include comments
about it.

> 
>> +	test %r9, %r9
>> +	jz 1f
>> +
>> +	/* Copy hypercall result registers to output struct: */
>> +	movq %r11, TDX_HYPERCALL_r11(%r9)
>> +	movq %r12, TDX_HYPERCALL_r12(%r9)
>> +	movq %r13, TDX_HYPERCALL_r13(%r9)
>> +	movq %r14, TDX_HYPERCALL_r14(%r9)
>> +	movq %r15, TDX_HYPERCALL_r15(%r9)
>> +1:
>> +	/*
>> +	 * Zero out registers exposed to the VMM to avoid
> 
> Why if you...
> 
>> +	 * speculative execution with VMM-controlled values.
>> +	 * This needs to include all registers present in
>> +	 * TDVMCALL_EXPOSE_REGS_MASK.
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
> 
> ... are going to overwrite most of them here?
> 
> I.e., you can clear only R10 and R11 and the rest will be overwritten by
> the callee-saved values.

Yes. You are correct. I can clear only R10-R11.

> 
>> +
>> +	ret
>> +2:
>> +	/*
>> +	 * Reaching here means failure in TDCALL execution. This is
>> +	 * not supposed to happen in hypercalls. It means the TDX
>> +	 * module is in buggy state. So panic.
>> +	 */
>> +	ud2
> 
> How is the user going to know that the module has a bug? Are we issuing
> an error message somewhere before that panic or the guest screen will
> remain black/freeze and the poor luser won't have a clue what happened?

With the trace support, they should be able to see the flow before making
the tdx_*_call(). That should be enough clue for debug right?


> 
>> +	if (err)
>> +		pr_warn_ratelimited("TDVMCALL fn:%llx failed with err:%llx\n",
> 
> Prefix those hex values with "0x" so that it is clear what the number
> format is. Ditto below.
> 
>> +				    fn, err);
> 
> You can leave those to stick out and not break the line. Ditto below.

Ok. I will follow your recommendation. I have done it this way to fix
checkpatch reports.

> 
>> +
>> +	return err;
>> +}
>> +
>> +/*
>> + * Wrapper for the semi-common case where user need single output
>> + * value (R11). Callers of this function does not care about the
>> + * hypercall error code (mainly for IN or MMIO usecase).
>> + */
>> +static inline u64 tdx_hypercall_out_r11(u64 fn, u64 r12, u64 r13,
> 
> No need to hardcode the register which has the retval in the function
> name - just call it tdx_hypercall_out() or so.

If we need helper functions for other output registers in future, we might
have to add the suffix.



>> -- 
>> 2.25.1
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
