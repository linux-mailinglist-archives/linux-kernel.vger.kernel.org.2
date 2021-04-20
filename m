Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054D4366023
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 21:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhDTTU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 15:20:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:49538 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233518AbhDTTUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 15:20:53 -0400
IronPort-SDR: pVn7I2NgoAe+hCMEYiPIDjEsnDl+mCW6J1UlvTCzKXczLyHqYPaVVLhuFZGLJXUx+SofV37XJB
 yI/X92w9MCIw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="256887776"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="256887776"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 12:20:21 -0700
IronPort-SDR: LylJ/+impEnRGnwevMDXgM6QEnHLkQLqv6HbIotmxm5Xq2C155OWCL5EFL9qm7z9/ZxhqHT2d0
 cALxufnNjF/g==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="427116442"
Received: from jjagger-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.197.239])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 12:20:20 -0700
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <8723950c-e07c-9a03-503a-ab232701d1e9@linux.intel.com>
 <c015093fdbc8e6a5aa9fc43f78fec8d9c38295c7.1616801167.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
Date:   Tue, 20 Apr 2021 12:20:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/21 10:36 AM, Dave Hansen wrote:
> On 3/26/21 4:38 PM, Kuppuswamy Sathyanarayanan wrote:
>> Implement common helper functions to communicate with
>> the TDX Module and VMM (using TDCALL instruction).
> 
> This is missing any kind of background.  I'd say:
> 
> Guests communicate with VMMs with hypercalls. Historically, these are
> implemented using instructions that are known to cause VMEXITs like
> <examples here>.  However, with TDX, VMEXITs no longer expose guest
> state from the host.  This prevents the old hypercall mechanisms from
> working....
> 
> ... and then go on to talk about what you are introducing, why there are
> two of them and so forth.
Ok. I will add it.
> 
>> __tdvmcall() function can be used to request services
>> from VMM.
> 
> 	^ "from a VMM" or "from the VMM", please
> 
will use "from the VMM".
>> __tdcall() function can be used to communicate with the
>> TDX Module.
>>
>> Using common helper functions makes the code more readable
>> and less error prone compared to distributed and use case
>> specific inline assembly code. Only downside in using this
> 
> 				 ^ "The only downside..."
will fix it.
> 
>> approach is, it adds a few extra instructions for every
>> TDCALL use case when compared to distributed checks. Although
>> it's a bit less efficient, it's worth it to make the code more
>> readable.
> 
> What's a "distributed check"?

It should be "distributed TDVMCALL/TDCALL inline assembly calls"
> 
> This also doesn't talk at all about why this approach was chosen versus
> inline assembly.  You're going to be asked "why not use inline asm?"
"To make the core more readable and less error prone." I have added this info
in above paragraph. Do you think we need more argument to justify our approach?
> 
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -8,12 +8,35 @@
>>   #ifdef CONFIG_INTEL_TDX_GUEST
>>   
>>   #include <asm/cpufeature.h>
>> +#include <linux/types.h>
>> +
>> +struct tdcall_output {
>> +	u64 rcx;
>> +	u64 rdx;
>> +	u64 r8;
>> +	u64 r9;
>> +	u64 r10;
>> +	u64 r11;
>> +};
>> +
>> +struct tdvmcall_output {
>> +	u64 r11;
>> +	u64 r12;
>> +	u64 r13;
>> +	u64 r14;
>> +	u64 r15;
>> +};
>>   
>>   /* Common API to check TDX support in decompression and common kernel code. */
>>   bool is_tdx_guest(void);
>>   
>>   void __init tdx_early_init(void);
>>   
>> +u64 __tdcall(u64 fn, u64 rcx, u64 rdx, struct tdcall_output *out);
>> +
>> +u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
>> +	       struct tdvmcall_output *out);
> 
> Some one-liner comments about what these do would be nice.
will do.
> 
>>   #else // !CONFIG_INTEL_TDX_GUEST
>>   
>>   static inline bool is_tdx_guest(void)
>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>> index ea111bf50691..7966c10ea8d1 100644
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -127,7 +127,7 @@ obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
>>   obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
>>   
>>   obj-$(CONFIG_JAILHOUSE_GUEST)	+= jailhouse.o
>> -obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o
>> +obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdcall.o tdx.o
>>   
>>   obj-$(CONFIG_EISA)		+= eisa.o
>>   obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
>> diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
>> index 60b9f42ce3c1..72de0b49467e 100644
>> --- a/arch/x86/kernel/asm-offsets.c
>> +++ b/arch/x86/kernel/asm-offsets.c
>> @@ -23,6 +23,10 @@
>>   #include <xen/interface/xen.h>
>>   #endif
>>   
>> +#ifdef CONFIG_INTEL_TDX_GUEST
>> +#include <asm/tdx.h>
>> +#endif
>> +
>>   #ifdef CONFIG_X86_32
>>   # include "asm-offsets_32.c"
>>   #else
>> @@ -75,6 +79,24 @@ static void __used common(void)
>>   	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
>>   #endif
>>   
>> +#ifdef CONFIG_INTEL_TDX_GUEST
>> +	BLANK();
>> +	/* Offset for fields in tdcall_output */
>> +	OFFSET(TDCALL_rcx, tdcall_output, rcx);
>> +	OFFSET(TDCALL_rdx, tdcall_output, rdx);
>> +	OFFSET(TDCALL_r8, tdcall_output, r8);
>> +	OFFSET(TDCALL_r9, tdcall_output, r9);
>> +	OFFSET(TDCALL_r10, tdcall_output, r10);
>> +	OFFSET(TDCALL_r11, tdcall_output, r11);
> 
> 			 ^ vertically align this
> 
will fix it.
>> +	/* Offset for fields in tdvmcall_output */
>> +	OFFSET(TDVMCALL_r11, tdvmcall_output, r11);
>> +	OFFSET(TDVMCALL_r12, tdvmcall_output, r12);
>> +	OFFSET(TDVMCALL_r13, tdvmcall_output, r13);
>> +	OFFSET(TDVMCALL_r14, tdvmcall_output, r14);
>> +	OFFSET(TDVMCALL_r15, tdvmcall_output, r15);
>> +#endif
>> +
>>   	BLANK();
>>   	OFFSET(BP_scratch, boot_params, scratch);
>>   	OFFSET(BP_secure_boot, boot_params, secure_boot);
>> diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
>> new file mode 100644
>> index 000000000000..a73b67c0b407
>> --- /dev/null
>> +++ b/arch/x86/kernel/tdcall.S
>> @@ -0,0 +1,163 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#include <asm/asm-offsets.h>
>> +#include <asm/asm.h>
>> +#include <asm/frame.h>
>> +#include <asm/unwind_hints.h>
>> +
>> +#include <linux/linkage.h>
>> +
>> +#define TDVMCALL_EXPOSE_REGS_MASK	0xfc00
> 
> This looks like an undocumented magic number.
> 
>> +/*
>> + * TDCALL instruction is newly added in TDX architecture,
>> + * used by TD for requesting the host VMM to provide
>> + * (untrusted) services. Supported in Binutils >= 2.36
>> + */
> 
> Host VMM *AND* TD-module, right?
Yes, you are correct. I will fix it.
> 
>> +#define tdcall .byte 0x66,0x0f,0x01,0xcc
> 
> How well will the "newly added" comment age?
> 
> "host VMM" is redundant.
> 
> /*
>   * TDX guests use the TDCALL instruction to make
>   * hypercalls to the VMM.  ...
will use it.
> 
> 
>> +/* Only for non TDVMCALL use cases */
>> +SYM_FUNC_START(__tdcall)
>> +	FRAME_BEGIN
>> +
>> +	/* Save/restore non-volatile GPRs that are exposed to the VMM. */
>> +	push %r15
>> +	push %r14
>> +	push %r13
>> +	push %r12
> 
> How is this restoring GPRs?
I have used the same comment for both push/pop combinations. Will remove
restore from above comment.
> 
>> +	/*
>> +	 * RDI  => RAX = TDCALL leaf
>> +	 * RSI  => RCX = input param 1
>> +	 * RDX  => RDX = input param 2
>> +	 * RCX  => N/A = output struct
>> +	 */
> 
> I don't like this block comment.  These should be interspersed with the
> instructions.  It's actually redundant with what's below.
I just want to show register mapping details in one place (similar to C
function comments). But I am fine with instruction specific comments.
I will fix it in next version.
> 
>> +	/* Save output pointer to R12 */
>> +	mov %rcx, %r12
> 
> Is this a "save" or a "move"?  Isn't this moving the function argument
> "%rcx" to the TDCALL register argument "%r12"?
> 
>> +	/* Move TDCALL Leaf ID to RAX */
>> +	mov %rdi, %rax
>> +	/* Move input param 1 to rcx*/
>> +	mov %rsi, %rcx
> 
> This needs a comment:
> 
> 	/* Leave the third function argument (%RDX) in place */
> 
Ok.
>> +	tdcall
>> +
>> +	/*
>> +	 * On success, propagate TDCALL outputs values to the output struct,
>> +	 * if an output struct is provided.
>> +	 */
> 
> Again, I don't like the comment separated from the instructions.  This
> should be:
will use instruction specific comments.
> 
> 	
> 	/* Check for TDCALL success: */
>> +	test %rax, %rax
>> +	jnz 1f
> 
> 	/* Check for a TDCALL output struct */
>> +	test %r12, %r12
>> +	jz 1f
> 
> 	/* Copy TDCALL result registers to output struct: */
>> +	movq %rcx, TDCALL_rcx(%r12)
>> +	movq %rdx, TDCALL_rdx(%r12)
>> +	movq %r8, TDCALL_r8(%r12)
>> +	movq %r9, TDCALL_r9(%r12)
>> +	movq %r10, TDCALL_r10(%r12)
>> +	movq %r11, TDCALL_r11(%r12)
> 
> 		 ^ Vertically align this
will do.
> 
>> +1:
>> +	/*
>> +	 * Zero out registers exposed to the VMM to avoid speculative execution
>> +	 * with VMM-controlled values.
>> +	 */
>> +        xor %rcx, %rcx
>> +        xor %rdx, %rdx
>> +        xor %r8d, %r8d
>> +        xor %r9d, %r9d
>> +        xor %r10d, %r10d
>> +        xor %r11d, %r11d
> 
> This has tabs-versus-space problems.
> 
> Also, is this the architectural list of *POSSIBLE* registers to which
> the VMM can write?
> 
>> +	pop %r12
>> +	pop %r13
>> +	pop %r14
>> +	pop %r15
>> +
>> +	FRAME_END
>> +	ret
>> +SYM_FUNC_END(__tdcall)
>> +
>> +.macro tdvmcall_core
>> +	FRAME_BEGIN
>> +
>> +	/* Save/restore non-volatile GPRs that are exposed to the VMM. */
> 
> Again, where's the "restore"?
I have used the same comment for both push/pop combinations. Will remove
restore from above comment.
> 
>> +	push %r15
>> +	push %r14
>> +	push %r13
>> +	push %r12
>> +
>> +	/*
>> +	 * 0    => RAX = TDCALL leaf
>> +	 * RDI  => R11 = TDVMCALL function, e.g. exit reason
>> +	 * RSI  => R12 = input param 0
>> +	 * RDX  => R13 = input param 1
>> +	 * RCX  => R14 = input param 2
>> +	 * R8   => R15 = input param 3
>> +	 * MASK => RCX = TDVMCALL register behavior
>> +	 * R9   => R9  = output struct
>> +	 */
>> +
>> +	xor %eax, %eax
>> +	mov %rdi, %r11
>> +	mov %rsi, %r12
>> +	mov %rdx, %r13
>> +	mov %rcx, %r14
>> +	mov %r8,  %r15
>> +
>> +	/*
>> +	 * Expose R10 - R15, i.e. all GPRs that may be used by TDVMCALLs
>> +	 * defined in the GHCI.  Note, RAX and RCX are consumed, but only by
>> +	 * TDX-Module and so don't need to be listed in the mask.
>> +	 */
> 
> "GCHI" is out of the blue here.  So is "TDX-Module".  There needs to be
> more context.
ok. will add it. Do you want GHCI spec reference with section id here?
> 
>> +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>> +
>> +	tdcall
>> +
>> +	/* Panic if TDCALL reports failure. */
>> +	test %rax, %rax
>> +	jnz 2f
> 
> Why panic?
As per spec, TDCALL should never fail. Note that it has nothing to do
with TDVMCALL function specific failure (which is reported via R10).
> 
> Also, do you *REALLY* need to do this from assembly?  Can't it be done
> in the C wrapper?
Its common for all use cases of TDVMCALL (vendor specific, in/out, etc). so added
it here.
> 
>> +	/* Propagate TDVMCALL success/failure to return value. */
>> +	mov %r10, %rax
> 
> You just said it panic's on failure.  How can this propagate failure?
we use panic for TDCALL failure. But, R10 content used to identify whether given
TDVMCALL function operation is successful or not.
> 
>> +	/*
>> +	 * On success, propagate TDVMCALL outputs values to the output struct,
>> +	 * if an output struct is provided.
>> +	 */
>> +	test %rax, %rax
>> +	jnz 1f
>> +	test %r9, %r9
>> +	jz 1f
>> +
>> +	movq %r11, TDVMCALL_r11(%r9)
>> +	movq %r12, TDVMCALL_r12(%r9)
>> +	movq %r13, TDVMCALL_r13(%r9)
>> +	movq %r14, TDVMCALL_r14(%r9)
>> +	movq %r15, TDVMCALL_r15(%r9)
>> +1:
>> +	/*
>> +	 * Zero out registers exposed to the VMM to avoid speculative execution
>> +	 * with VMM-controlled values.
>> +	 */
> 
> Please evenly split the comment across those two lines.  (Do this
> everywhere in the series).
ok.
> 
>> +	xor %r10d, %r10d
>> +	xor %r11d, %r11d
>> +	xor %r12d, %r12d
>> +	xor %r13d, %r13d
>> +	xor %r14d, %r14d
>> +	xor %r15d, %r15d
>> +
>> +	pop %r12
>> +	pop %r13
>> +	pop %r14
>> +	pop %r15
>> +
>> +	FRAME_END
>> +	ret
>> +2:
>> +	ud2
>> +.endm
>> +
>> +SYM_FUNC_START(__tdvmcall)
>> +	xor %r10, %r10
>> +	tdvmcall_core
>> +SYM_FUNC_END(__tdvmcall)
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> index 0d00dd50a6ff..1147e7e765d6 100644
>> --- a/arch/x86/kernel/tdx.c
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -3,6 +3,36 @@
>>   
>>   #include <asm/tdx.h>
>>   
>> +/*
>> + * Wrapper for the common case with standard output value (R10).
>> + */
> 
> ... and oddly enough there is no explicit mention of R10 anywhere.  Why?
For Guest to Host call -> R10 holds TDCALL function id (which is 0 for TDVMCALL). so
we don't need special argument.
After TDVMCALL execution, R10 value is returned via RAX.
> 
>> +static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
>> +{
>> +	u64 err;
>> +
>> +	err = __tdvmcall(fn, r12, r13, r14, r15, NULL);
>> +
>> +	WARN_ON(err);
>> +
>> +	return err;
>> +}
> 
> Are there really *ZERO* reasons for a TDVMCALL to return an error?
No. Its useful for debugging TDVMCALL failures.
> Won't this let a malicious VMM spew endless warnings into the guest console?
As per GHCI spec, R10 will hold error code details which can be used to determine
the type of TDVMCALL failure. More warnings at-least show that we are working
with malicious VMM.
> 
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
>> +	WARN_ON(err);
>> +
>> +	return out.r11;
>> +}
>> +
> 
> But you introduced __tdvmcall and __tdcall assembly functions.  Why
> aren't both of them used?
This patch just adds helper functions. Its used by other patches in the
series. __tdvmcall is used in this patch because we need to add more
wrappers for it.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
