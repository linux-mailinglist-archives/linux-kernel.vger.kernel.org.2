Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FBE365EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhDTRhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:37:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:8337 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232473AbhDTRhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:37:07 -0400
IronPort-SDR: w+MpJs2/g6PSfb7JBfM4EJsPPyARH4XhWidGAg5Z6SeJuDZwhMuKXlHMJGb8vvPMbS+ElvwyHF
 eqTi88p8kEcA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="259509207"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="259509207"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 10:36:35 -0700
IronPort-SDR: j7yIuzZhGdgxoQA3kyCiic/2PAfdie3krKntsoCO/kr207G+dIKUQM07ePK+7sb6oovH+x0y6X
 KdT9ARYvzE3w==
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="427083145"
Received: from plrogers-mobl1.amr.corp.intel.com (HELO [10.209.80.254]) ([10.209.80.254])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 10:36:34 -0700
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com>
Date:   Tue, 20 Apr 2021 10:36:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c015093fdbc8e6a5aa9fc43f78fec8d9c38295c7.1616801167.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 4:38 PM, Kuppuswamy Sathyanarayanan wrote:
> Implement common helper functions to communicate with
> the TDX Module and VMM (using TDCALL instruction).

This is missing any kind of background.  I'd say:

Guests communicate with VMMs with hypercalls. Historically, these are
implemented using instructions that are known to cause VMEXITs like
<examples here>.  However, with TDX, VMEXITs no longer expose guest
state from the host.  This prevents the old hypercall mechanisms from
working....

... and then go on to talk about what you are introducing, why there are
two of them and so forth.

> __tdvmcall() function can be used to request services
> from VMM.

	^ "from a VMM" or "from the VMM", please

> __tdcall() function can be used to communicate with the
> TDX Module.
> 
> Using common helper functions makes the code more readable
> and less error prone compared to distributed and use case
> specific inline assembly code. Only downside in using this

				 ^ "The only downside..."

> approach is, it adds a few extra instructions for every
> TDCALL use case when compared to distributed checks. Although
> it's a bit less efficient, it's worth it to make the code more
> readable.

What's a "distributed check"?

This also doesn't talk at all about why this approach was chosen versus
inline assembly.  You're going to be asked "why not use inline asm?"

> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -8,12 +8,35 @@
>  #ifdef CONFIG_INTEL_TDX_GUEST
>  
>  #include <asm/cpufeature.h>
> +#include <linux/types.h>
> +
> +struct tdcall_output {
> +	u64 rcx;
> +	u64 rdx;
> +	u64 r8;
> +	u64 r9;
> +	u64 r10;
> +	u64 r11;
> +};
> +
> +struct tdvmcall_output {
> +	u64 r11;
> +	u64 r12;
> +	u64 r13;
> +	u64 r14;
> +	u64 r15;
> +};
>  
>  /* Common API to check TDX support in decompression and common kernel code. */
>  bool is_tdx_guest(void);
>  
>  void __init tdx_early_init(void);
>  
> +u64 __tdcall(u64 fn, u64 rcx, u64 rdx, struct tdcall_output *out);
> +
> +u64 __tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
> +	       struct tdvmcall_output *out);

Some one-liner comments about what these do would be nice.

>  #else // !CONFIG_INTEL_TDX_GUEST
>  
>  static inline bool is_tdx_guest(void)
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index ea111bf50691..7966c10ea8d1 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -127,7 +127,7 @@ obj-$(CONFIG_PARAVIRT_CLOCK)	+= pvclock.o
>  obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
>  
>  obj-$(CONFIG_JAILHOUSE_GUEST)	+= jailhouse.o
> -obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx.o
> +obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdcall.o tdx.o
>  
>  obj-$(CONFIG_EISA)		+= eisa.o
>  obj-$(CONFIG_PCSPKR_PLATFORM)	+= pcspeaker.o
> diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
> index 60b9f42ce3c1..72de0b49467e 100644
> --- a/arch/x86/kernel/asm-offsets.c
> +++ b/arch/x86/kernel/asm-offsets.c
> @@ -23,6 +23,10 @@
>  #include <xen/interface/xen.h>
>  #endif
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +#include <asm/tdx.h>
> +#endif
> +
>  #ifdef CONFIG_X86_32
>  # include "asm-offsets_32.c"
>  #else
> @@ -75,6 +79,24 @@ static void __used common(void)
>  	OFFSET(XEN_vcpu_info_arch_cr2, vcpu_info, arch.cr2);
>  #endif
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	BLANK();
> +	/* Offset for fields in tdcall_output */
> +	OFFSET(TDCALL_rcx, tdcall_output, rcx);
> +	OFFSET(TDCALL_rdx, tdcall_output, rdx);
> +	OFFSET(TDCALL_r8, tdcall_output, r8);
> +	OFFSET(TDCALL_r9, tdcall_output, r9);
> +	OFFSET(TDCALL_r10, tdcall_output, r10);
> +	OFFSET(TDCALL_r11, tdcall_output, r11);

			 ^ vertically align this

> +	/* Offset for fields in tdvmcall_output */
> +	OFFSET(TDVMCALL_r11, tdvmcall_output, r11);
> +	OFFSET(TDVMCALL_r12, tdvmcall_output, r12);
> +	OFFSET(TDVMCALL_r13, tdvmcall_output, r13);
> +	OFFSET(TDVMCALL_r14, tdvmcall_output, r14);
> +	OFFSET(TDVMCALL_r15, tdvmcall_output, r15);
> +#endif
> +
>  	BLANK();
>  	OFFSET(BP_scratch, boot_params, scratch);
>  	OFFSET(BP_secure_boot, boot_params, secure_boot);
> diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
> new file mode 100644
> index 000000000000..a73b67c0b407
> --- /dev/null
> +++ b/arch/x86/kernel/tdcall.S
> @@ -0,0 +1,163 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <asm/asm-offsets.h>
> +#include <asm/asm.h>
> +#include <asm/frame.h>
> +#include <asm/unwind_hints.h>
> +
> +#include <linux/linkage.h>
> +
> +#define TDVMCALL_EXPOSE_REGS_MASK	0xfc00

This looks like an undocumented magic number.

> +/*
> + * TDCALL instruction is newly added in TDX architecture,
> + * used by TD for requesting the host VMM to provide
> + * (untrusted) services. Supported in Binutils >= 2.36
> + */

Host VMM *AND* TD-module, right?

> +#define tdcall .byte 0x66,0x0f,0x01,0xcc

How well will the "newly added" comment age?

"host VMM" is redundant.

/*
 * TDX guests use the TDCALL instruction to make
 * hypercalls to the VMM.  ...


> +/* Only for non TDVMCALL use cases */
> +SYM_FUNC_START(__tdcall)
> +	FRAME_BEGIN
> +
> +	/* Save/restore non-volatile GPRs that are exposed to the VMM. */
> +	push %r15
> +	push %r14
> +	push %r13
> +	push %r12

How is this restoring GPRs?

> +	/*
> +	 * RDI  => RAX = TDCALL leaf
> +	 * RSI  => RCX = input param 1
> +	 * RDX  => RDX = input param 2
> +	 * RCX  => N/A = output struct
> +	 */

I don't like this block comment.  These should be interspersed with the
instructions.  It's actually redundant with what's below.

> +	/* Save output pointer to R12 */
> +	mov %rcx, %r12

Is this a "save" or a "move"?  Isn't this moving the function argument
"%rcx" to the TDCALL register argument "%r12"?

> +	/* Move TDCALL Leaf ID to RAX */
> +	mov %rdi, %rax
> +	/* Move input param 1 to rcx*/
> +	mov %rsi, %rcx

This needs a comment:

	/* Leave the third function argument (%RDX) in place */

> +	tdcall
> +
> +	/*
> +	 * On success, propagate TDCALL outputs values to the output struct,
> +	 * if an output struct is provided.
> +	 */

Again, I don't like the comment separated from the instructions.  This
should be:

	
	/* Check for TDCALL success: */
> +	test %rax, %rax
> +	jnz 1f

	/* Check for a TDCALL output struct */
> +	test %r12, %r12
> +	jz 1f

	/* Copy TDCALL result registers to output struct: */
> +	movq %rcx, TDCALL_rcx(%r12)
> +	movq %rdx, TDCALL_rdx(%r12)
> +	movq %r8, TDCALL_r8(%r12)
> +	movq %r9, TDCALL_r9(%r12)
> +	movq %r10, TDCALL_r10(%r12)
> +	movq %r11, TDCALL_r11(%r12)

		 ^ Vertically align this

> +1:
> +	/*
> +	 * Zero out registers exposed to the VMM to avoid speculative execution
> +	 * with VMM-controlled values.
> +	 */
> +        xor %rcx, %rcx
> +        xor %rdx, %rdx
> +        xor %r8d, %r8d
> +        xor %r9d, %r9d
> +        xor %r10d, %r10d
> +        xor %r11d, %r11d

This has tabs-versus-space problems.

Also, is this the architectural list of *POSSIBLE* registers to which
the VMM can write?

> +	pop %r12
> +	pop %r13
> +	pop %r14
> +	pop %r15
> +
> +	FRAME_END
> +	ret
> +SYM_FUNC_END(__tdcall)
> +
> +.macro tdvmcall_core
> +	FRAME_BEGIN
> +
> +	/* Save/restore non-volatile GPRs that are exposed to the VMM. */

Again, where's the "restore"?

> +	push %r15
> +	push %r14
> +	push %r13
> +	push %r12
> +
> +	/*
> +	 * 0    => RAX = TDCALL leaf
> +	 * RDI  => R11 = TDVMCALL function, e.g. exit reason
> +	 * RSI  => R12 = input param 0
> +	 * RDX  => R13 = input param 1
> +	 * RCX  => R14 = input param 2
> +	 * R8   => R15 = input param 3
> +	 * MASK => RCX = TDVMCALL register behavior
> +	 * R9   => R9  = output struct
> +	 */
> +
> +	xor %eax, %eax
> +	mov %rdi, %r11
> +	mov %rsi, %r12
> +	mov %rdx, %r13
> +	mov %rcx, %r14
> +	mov %r8,  %r15
> +
> +	/*
> +	 * Expose R10 - R15, i.e. all GPRs that may be used by TDVMCALLs
> +	 * defined in the GHCI.  Note, RAX and RCX are consumed, but only by
> +	 * TDX-Module and so don't need to be listed in the mask.
> +	 */

"GCHI" is out of the blue here.  So is "TDX-Module".  There needs to be
more context.

> +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
> +
> +	tdcall
> +
> +	/* Panic if TDCALL reports failure. */
> +	test %rax, %rax
> +	jnz 2f

Why panic?

Also, do you *REALLY* need to do this from assembly?  Can't it be done
in the C wrapper?

> +	/* Propagate TDVMCALL success/failure to return value. */
> +	mov %r10, %rax

You just said it panic's on failure.  How can this propagate failure?

> +	/*
> +	 * On success, propagate TDVMCALL outputs values to the output struct,
> +	 * if an output struct is provided.
> +	 */
> +	test %rax, %rax
> +	jnz 1f
> +	test %r9, %r9
> +	jz 1f
> +
> +	movq %r11, TDVMCALL_r11(%r9)
> +	movq %r12, TDVMCALL_r12(%r9)
> +	movq %r13, TDVMCALL_r13(%r9)
> +	movq %r14, TDVMCALL_r14(%r9)
> +	movq %r15, TDVMCALL_r15(%r9)
> +1:
> +	/*
> +	 * Zero out registers exposed to the VMM to avoid speculative execution
> +	 * with VMM-controlled values.
> +	 */

Please evenly split the comment across those two lines.  (Do this
everywhere in the series).

> +	xor %r10d, %r10d
> +	xor %r11d, %r11d
> +	xor %r12d, %r12d
> +	xor %r13d, %r13d
> +	xor %r14d, %r14d
> +	xor %r15d, %r15d
> +
> +	pop %r12
> +	pop %r13
> +	pop %r14
> +	pop %r15
> +
> +	FRAME_END
> +	ret
> +2:
> +	ud2
> +.endm
> +
> +SYM_FUNC_START(__tdvmcall)
> +	xor %r10, %r10
> +	tdvmcall_core
> +SYM_FUNC_END(__tdvmcall)
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 0d00dd50a6ff..1147e7e765d6 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -3,6 +3,36 @@
>  
>  #include <asm/tdx.h>
>  
> +/*
> + * Wrapper for the common case with standard output value (R10).
> + */

... and oddly enough there is no explicit mention of R10 anywhere.  Why?

> +static inline u64 tdvmcall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
> +{
> +	u64 err;
> +
> +	err = __tdvmcall(fn, r12, r13, r14, r15, NULL);
> +
> +	WARN_ON(err);
> +
> +	return err;
> +}

Are there really *ZERO* reasons for a TDVMCALL to return an error?
Won't this let a malicious VMM spew endless warnings into the guest console?

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
> +	WARN_ON(err);
> +
> +	return out.r11;
> +}
> +

But you introduced __tdvmcall and __tdcall assembly functions.  Why
aren't both of them used?
