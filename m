Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F00A3892AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354275AbhESPcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:32:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:54243 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241696AbhESPcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:32:41 -0400
IronPort-SDR: U0Nkv0uaQ4gzOrPo2cF6yKmcqQxwkHta7oWRLjr7fTQqjI2UD81aCFgaC0xPT8IM9NriK3l/fG
 h7QQMyUQRGWA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="199050838"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="199050838"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 08:31:21 -0700
IronPort-SDR: LjiY8rlHPVYBwQnPaFSypEvmCp3gjxuP/r2ataxaEPxnWLGI5HFBaa5QJXINBGYoQ64ySZDlM6
 Gcy3IZ1sSHjA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="474670949"
Received: from mconrado-mobl1.amr.corp.intel.com (HELO [10.209.83.57]) ([10.209.83.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 08:31:20 -0700
Subject: Re: [RFC v2-fix-v1 1/1] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <3a7c0bba-cc43-e4ba-f7fe-43c8627c2fc2@intel.com>
 <20210519055842.2048957-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <568d2929-f366-e3be-96f9-0bfa91991ef2@intel.com>
Date:   Wed, 19 May 2021 08:31:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210519055842.2048957-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/21 10:58 PM, Kuppuswamy Sathyanarayanan wrote:
> Guests communicate with VMMs with hypercalls. Historically, these
> are implemented using instructions that are known to cause VMEXITs
> like vmcall, vmlaunch, etc. However, with TDX, VMEXITs no longer
> expose guest state to the host.  This prevents the old hypercall
> mechanisms from working. So to communicate with VMM, TDX
> specification defines a new instruction called "tdcall".
> 
> In TDX based VM, since VMM is an untrusted entity, a intermediary

"In a TDX-based VM..."

> layer (TDX module) exists between host and guest to facilitate the
> secure communication. And "tdcall" instruction  is used by the guest
> to request services from TDX module. And a variant of "tdcall"
> instruction (with specific arguments as defined by GHCI) is used by
> the guest to request services from  VMM via the TDX module.

I'd just say:

	TDX guests communicate with the TDX module and with the VMM
	using a new instruction: TDCALL.

The rest of that is noise.

> Implement common helper functions to communicate with the TDX Module
> and VMM (using TDCALL instruction).
>    
> __tdx_hypercall()    - function can be used to request services from
> 		       the VMM.
> __tdx_module_call()  - function can be used to communicate with the
> 		       TDX Module.

s/function can be used to//

> Also define two additional wrappers, tdx_hypercall() and
> tdx_hypercall_out_r11() to cover common use cases of
> __tdx_hypercall() function. Since each use case of
> __tdx_module_call() is different, we don't need such wrappers for it.
> 
> Implement __tdx_module_call() and __tdx_hypercall() helper functions
> in assembly.
> 
> Rationale behind choosing to use assembly over inline assembly are,
> 
> 1. Since the number of lines of instructions (with comments) in
> __tdx_hypercall() implementation is over 70, using inline assembly
> to implement it will make it hard to read.
>    
> 2. Also, since many registers (R8-R15, R[A-D]X)) will be used in
> TDCALL operation, if all these registers are included in in-line
> assembly constraints, some of the older compilers may not
> be able to meet this requirement.

Was this "older compiler" argument really the reason?

> Also, just like syscalls, not all TDVMCALL/TDCALLs use cases need to
> use the same set of argument registers. The implementation here picks
> the current worst-case scenario for TDCALL (4 registers). For TDCALLs
> with fewer than 4 arguments, there will end up being a few superfluous
> (cheap) instructions.  But, this approach maximizes code reuse. The
> same argument applies to __tdx_hypercall() function as well.
> 
> Current implementation of __tdx_hypercall() includes error handling
> (ud2 on failure case) in assembly function instead of doing it in C
> wrapper function. The reason behind this choice is, when adding support
> for in/out instructions (refer to patch titled "x86/tdx: Handle port
> I/O" in this series), we use alternative_io() to substitute in/out
> instruction with  __tdx_hypercall() calls. So use of C wrappers is not
> trivial in this case because the input parameters will be in the wrong
> registers and it's tricky to include proper buffer code to make this
> happen.
> 
> For registers used by TDCALL instruction, please check TDX GHCI
> specification, sec 2.4 and 3.
> 
> https://software.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface.pdf
> 
> Originally-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

For what it's worth, that changelog really starts to ramble after the
"rationale" part.

> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 69af72d08d3d..211b9d66b1b1 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -8,12 +8,50 @@
>  #ifdef CONFIG_INTEL_TDX_GUEST
>  
>  #include <asm/cpufeature.h>
> +#include <linux/types.h>
> +
> +/*
> + * Used in __tdx_module_call() helper function to gather the
> + * output registers values of TDCALL instruction when requesting

There's something wrong in this sentence.  This needs to be "output
register values" or "output regisers' values".

> + * services from the TDX module. This is software only structure
> + * and not related to TDX module/VMM.
> + */
> +struct tdx_module_output {
> +	u64 rcx;
> +	u64 rdx;
> +	u64 r8;
> +	u64 r9;
> +	u64 r10;
> +	u64 r11;
> +};
> +
> +/*
> + * Used in __tdx_hypercall() helper function to gather the
> + * output registers values of TDCALL instruction when requesting
> + * services from the VMM. This is software only structure
> + * and not related to TDX module/VMM.
> + */
> +struct tdx_hypercall_output {
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
> +/* Helper function used to communicate with the TDX module */
> +u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
> +		      struct tdx_module_output *out);
> +
> +/* Helper function used to request services from VMM */
> +u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
> +		    struct tdx_hypercall_output *out);
> +
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
> index 60b9f42ce3c1..e6b3bb983992 100644
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
> +	OFFSET(TDX_MODULE_rcx, tdx_module_output, rcx);
> +	OFFSET(TDX_MODULE_rdx, tdx_module_output, rdx);
> +	OFFSET(TDX_MODULE_r8,  tdx_module_output, r8);
> +	OFFSET(TDX_MODULE_r9,  tdx_module_output, r9);
> +	OFFSET(TDX_MODULE_r10, tdx_module_output, r10);
> +	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
> +
> +	/* Offset for fields in tdvmcall_output */
> +	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_output, r11);
> +	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_output, r12);
> +	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_output, r13);
> +	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_output, r14);
> +	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_output, r15);
> +#endif
> +
>  	BLANK();
>  	OFFSET(BP_scratch, boot_params, scratch);
>  	OFFSET(BP_secure_boot, boot_params, secure_boot);
> diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
> new file mode 100644
> index 000000000000..a67c595e4169
> --- /dev/null
> +++ b/arch/x86/kernel/tdcall.S
> @@ -0,0 +1,222 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <asm/asm-offsets.h>
> +#include <asm/asm.h>
> +#include <asm/frame.h>
> +#include <asm/unwind_hints.h>
> +
> +#include <linux/linkage.h>
> +#include <linux/bits.h>
> +
> +#define TDG_R10		BIT(10)
> +#define TDG_R11		BIT(11)
> +#define TDG_R12		BIT(12)
> +#define TDG_R13		BIT(13)
> +#define TDG_R14		BIT(14)
> +#define TDG_R15		BIT(15)
> +
> +/*
> + * Expose registers R10-R15 to VMM. It is passed via RCX register
> + * to the TDX Module, which will be used by the TDX module to
> + * identify the list of registers exposed to VMM. Each bit in this
> + * mask represents a register ID. You can find the bit field details
> + * in TDX GHCI specification.
> + */
> +#define TDVMCALL_EXPOSE_REGS_MASK	( TDG_R10 | TDG_R11 | \
> +					  TDG_R12 | TDG_R13 | \
> +					  TDG_R14 | TDG_R15 )
> +
> +/*
> + * TDX guests use the TDCALL instruction to make requests to the
> + * TDX module and hypercalls to the VMM. It is supported in
> + * Binutils >= 2.36.
> + */
> +#define tdcall .byte 0x66,0x0f,0x01,0xcc
> +
> +/*
> + * __tdx_module_call()  - Helper function used by TDX guests to request
> + * services from the TDX module (does not include VMM services).
> + *
> + * This function serves as a wrapper to move user call arguments to the
> + * correct registers as specified by "tdcall" ABI and shares it with the
> + * TDX module.  And if the "tdcall" operation is successful and a valid

It's frequently taught to never start a sentence with "And" in formal
writing.  You use it fairly frequently.  Simply removing it increase
readability, IMNHO.

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
> +
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
> +	/* Check for TDCALL output struct != NULL */
> +	test %r12, %r12
> +	jz 1f
> +
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
> + * This function is created to contain common between vendor specific

This sentence seems wrong.  Common... what?

> + * and standard type tdx hypercalls. So the caller of this function had

Please capitalize "tdx" consistently.

> + * to set the TDVMCALL type in the R10 register before calling it.

> + * This function serves as a wrapper to move user call arguments to the
> + * correct registers as specified by "tdcall" ABI and shares it with VMM
> + * via the TDX module. And if the "tdcall" operation is successful and a
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
> + * If the "tdcall" operation fails, panic.
> + *
> + */

This sounds scary.  Can you try to differentate a hypercall failure from
a "tdcall" failure?

Actually, I think that's done OK below.  Just remove this mention of
panic().

> +SYM_FUNC_START_LOCAL(do_tdx_hypercall)
> +	/* Save non-volatile GPRs that are exposed to the VMM. */
> +	push %r15
> +	push %r14
> +	push %r13
> +	push %r12
> +
> +	/* Leave hypercall output pointer in R9, it's not clobbered by VMM */
> +
> +	/* Mangle function call ABI into TDCALL ABI: */
> +	xor %eax, %eax /* Move TDCALL leaf ID (TDVMCALL (0)) to RAX */
> +	mov %rdi, %r11 /* Move TDVMCALL function id to R11 */
> +	mov %rsi, %r12 /* Move input 1 to R12 */
> +	mov %rdx, %r13 /* Move input 2 to R13 */
> +	mov %rcx, %r14 /* Move input 1 to R14 */
> +	mov %r8,  %r15 /* Move input 1 to R15 */
> +	/* Caller of do_tdx_hypercall() will set TDVMCALL type in R10 */
> +
> +	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
> +
> +	tdcall
> +
> +	/*
> +	 * Check for TDCALL success: 0 - Successful, otherwise failed.
> +	 * If failed, there is an issue with TDX Module which is fatal
> +	 * for the guest. So panic. Also note that RAX is controlled
> +	 * only by the TDX module and not exposed to VMM.
> +	 */

I'd probably just say:

	/*
	 * Non-zero RAX values indicate a failure of TDCALL itself.
	 * Panic for those.  This value is unrelated to the hypercall
	 * result in R10.
	 */

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
> +	/* Check for hypercall output struct != NULL */

This is a great example of a comment that's not using its space widely.
 If you're reading this, you *KNOW* that it's checking for NULL.  But
what does that *MEAN*?

Wh not:

	/* Check if caller provided an output struct */

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
> +	 * speculative execution with VMM-controlled values.
> +	 */

You can even say:

	This needs to include all registers present in
	TDVMCALL_EXPOSE_REGS_MASK

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
> +	ret
> +2:
> +	ud2
> +SYM_FUNC_END(do_tdx_hypercall)
> +
> +/*
> + * Helper function for for standard type of TDVMCALLs. This assembly
> + * wrapper lets us reuse do_tdvmcall() for standard type of hypercalls
> + * (R10 is set as zero).
> + */

Remember, no "us", "we" in changelogs or comments.

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

The rest of it is fine.  Probably just one more rev to beef up the
comments and changelogs.
