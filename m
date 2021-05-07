Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0763A376BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhEGVhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:37:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:15481 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGVhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:37:36 -0400
IronPort-SDR: CcrYVDGgPUJ+vcAzTG4sGqtDo/Ps3fmGqvWzmokCFPvbjJZJlt9wQ2vAqUEGsSisEOP2HSVRKj
 cO5Xgakpl1QA==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="186271182"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="186271182"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 14:36:34 -0700
IronPort-SDR: ErWaAtH1tOhxtc0GAH4hrpHzPMBjBmij7NxB6d2/So/2wERRiPQ/oAy3dEqLjbXK8tcTAfu7Ms
 3qOr7d4CZHjA==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="431675842"
Received: from msandrid-mobl.amr.corp.intel.com (HELO [10.212.134.124]) ([10.212.134.124])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 14:36:33 -0700
Subject: Re: [RFC v2 08/32] x86/traps: Add #VE support for TDX guest
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
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <8a1d6930f784cb57c957cf20cea870947db91e05.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <afd85e8f-ab26-aa3b-e4e9-a0b3bfd472c8@intel.com>
Date:   Fri, 7 May 2021 14:36:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8a1d6930f784cb57c957cf20cea870947db91e05.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
...
> The #VE cannot be nested before TDGETVEINFO is called, if there is any
> reason for it to nest the TD would shut down. The TDX module guarantees
> that no NMIs (or #MC or similar) can happen in this window. After
> TDGETVEINFO the #VE handler can nest if needed, although we don’t expect
> it to happen normally.

I think this description really needs some work.  Does "The #VE cannot
be nested" mean that "hardware guarantees that #VE will not be
generated", or "the #VE must not be nested"?

What does "the TD would shut down" mean?  I think you mean that instead
of delivering a nested #VE the hardware would actually exit to the host
and TDX would prevent the guest from being reentered.  Right?

> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 5eb3bdf36a41..41a0732d5f68 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -619,6 +619,10 @@ DECLARE_IDTENTRY_XENCB(X86_TRAP_OTHER,	exc_xen_hypervisor_callback);
>  DECLARE_IDTENTRY_RAW(X86_TRAP_OTHER,	exc_xen_unknown_trap);
>  #endif
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +DECLARE_IDTENTRY(X86_TRAP_VE,		exc_virtualization_exception);
> +#endif
> +
>  /* Device interrupts common/spurious */
>  DECLARE_IDTENTRY_IRQ(X86_TRAP_OTHER,	common_interrupt);
>  #ifdef CONFIG_X86_LOCAL_APIC
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index c5a870cef0ae..1ca55d8e9963 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -11,6 +11,7 @@
>  #include <linux/types.h>
>  
>  #define TDINFO			1
> +#define TDGETVEINFO		3
>  
>  struct tdcall_output {
>  	u64 rcx;
> @@ -29,6 +30,20 @@ struct tdvmcall_output {
>  	u64 r15;
>  };
>  
> +struct ve_info {
> +	u64 exit_reason;
> +	u64 exit_qual;
> +	u64 gla;
> +	u64 gpa;
> +	u32 instr_len;
> +	u32 instr_info;
> +};

Is this an architectural structure or some software construct?

> +unsigned long tdg_get_ve_info(struct ve_info *ve);
> +
> +int tdg_handle_virtualization_exception(struct pt_regs *regs,
> +		struct ve_info *ve);
> +
>  /* Common API to check TDX support in decompression and common kernel code. */
>  bool is_tdx_guest(void);
>  
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index ee1a283f8e96..546b6b636c7d 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -64,6 +64,9 @@ static const __initconst struct idt_data early_idts[] = {
>  	 */
>  	INTG(X86_TRAP_PF,		asm_exc_page_fault),
>  #endif
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
> +#endif
>  };
>  
>  /*
> @@ -87,6 +90,9 @@ static const __initconst struct idt_data def_idts[] = {
>  	INTG(X86_TRAP_MF,		asm_exc_coprocessor_error),
>  	INTG(X86_TRAP_AC,		asm_exc_alignment_check),
>  	INTG(X86_TRAP_XF,		asm_exc_simd_coprocessor_error),
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
> +#endif
>  
>  #ifdef CONFIG_X86_32
>  	TSKG(X86_TRAP_DF,		GDT_ENTRY_DOUBLEFAULT_TSS),
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index b63275db1db9..ccfcb07bfb2c 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -82,6 +82,44 @@ static void tdg_get_info(void)
>  	td_info.attributes = out.rdx;
>  }
>  
> +unsigned long tdg_get_ve_info(struct ve_info *ve)
> +{
> +	u64 ret;
> +	struct tdcall_output out = {0};
> +
> +	/*
> +	 * The #VE cannot be nested before TDGETVEINFO is called,
> +	 * if there is any reason for it to nest the TD would shut
> +	 * down. The TDX module guarantees that no NMIs (or #MC or
> +	 * similar) can happen in this window. After TDGETVEINFO
> +	 * the #VE handler can nest if needed, although we don’t
> +	 * expect it to happen normally.
> +	 */

I find that description a bit unsatisfying.  Could we make this a bit
more concrete?  By the way, what about *normal* interrupts?

Maybe we should talk about this in terms of *rules* that folks need to
follow.  Maybe:

	NMIs and machine checks are suppressed.  Before this point any
	#VE is fatal.  After this point, NMIs and additional #VEs are
	permitted.

> +	ret = __tdcall(TDGETVEINFO, 0, 0, 0, 0, &out);
> +
> +	ve->exit_reason = out.rcx;
> +	ve->exit_qual   = out.rdx;
> +	ve->gla         = out.r8;
> +	ve->gpa         = out.r9;
> +	ve->instr_len   = out.r10 & UINT_MAX;
> +	ve->instr_info  = out.r10 >> 32;
> +
> +	return ret;
> +}
> +
> +int tdg_handle_virtualization_exception(struct pt_regs *regs,
> +		struct ve_info *ve)
> +{
> +	/*
> +	 * TODO: Add handler support for various #VE exit
> +	 * reasons. It will be added by other patches in
> +	 * the series.
> +	 */
> +	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> +	return -EFAULT;
> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	if (!cpuid_has_tdx_guest())
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 213d4aa8e337..64869aa88a5a 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -61,6 +61,7 @@
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/vdso.h>
> +#include <asm/tdx.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <asm/x86_init.h>
> @@ -1140,6 +1141,35 @@ DEFINE_IDTENTRY(exc_device_not_available)
>  	}
>  }
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +DEFINE_IDTENTRY(exc_virtualization_exception)
> +{
> +	struct ve_info ve;
> +	int ret;
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	/*
> +	 * Consume #VE info before re-enabling interrupts. It will be
> +	 * re-enabled after executing the TDGETVEINFO TDCALL.
> +	 */

"It" is nebulous here.  Is this talking about NMIs, or the
cond_local_irq_enable() that is "after" TDGETVEINFO?

> +	ret = tdg_get_ve_info(&ve);
> +
> +	cond_local_irq_enable(regs);
> +
> +	if (!ret)
> +		ret = tdg_handle_virtualization_exception(regs, &ve);
> +	/*
> +	 * If tdg_handle_virtualization_exception() could not process
> +	 * it successfully, treat it as #GP(0) and handle it.
> +	 */
> +	if (ret)
> +		do_general_protection(regs, 0);
> +
> +	cond_local_irq_disable(regs);
> +}
> +#endif
> +
>  #ifdef CONFIG_X86_32
>  DEFINE_IDTENTRY_SW(iret_error)
>  {
> 

