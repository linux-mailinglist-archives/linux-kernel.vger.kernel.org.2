Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0193F5BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhHXKRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbhHXKRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:17:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D553C061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 03:16:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f114400a468d03b56e922c9.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:4400:a468:d03b:56e9:22c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB1921EC053B;
        Tue, 24 Aug 2021 12:16:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629800204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0drvYrfSEqMvwzLpULLtu5kdtKx1lSkTY/DaCIsiFhw=;
        b=N+8Hqf5pX2aBuCCt3680jtBdvpvg5hOjDw19I8N6zMIr9QhMMHOVfR9VqWUIEr7jOVnFCf
        TZrynm/a3GVnCRuqv4uFPed6quIMm3sJJaRl+oONixz59UuVfLYUoA1ahBRJmQCP9xyf0B
        hH2XFS+ieNuo6zBFlZf5lgOkPbR6fDM=
Date:   Tue, 24 Aug 2021 12:17:20 +0200
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
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/12] x86/traps: Add #VE support for TDX guest
Message-ID: <YSTHMAUA1LjjOQPe@zn.tnic>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-8-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210804181329.2899708-8-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 11:13:24AM -0700, Kuppuswamy Sathyanarayanan wrote:
> If a guest kernel action which would normally cause a #VE occurs in the
> interrupt-disabled region before TDGETVEINFO, a #DF is delivered to the
> guest which will result in an oops (and should eventually be a panic, as
> we would like to set panic_on_oops to 1 for TDX guests).

Who's "we"?

Please use passive voice in your commit message and comments: no "we"
or "I", etc. Personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them.

Audit all your patchsets pls.

> Add basic infrastructure to handle any #VE which occurs in the kernel or
> userspace.  Later patches will add handling for specific #VE scenarios.
> 
> Convert unhandled #VE's (everything, until later in this series) so that
> they appear just like a #GP by calling ve_raise_fault() directly.
> ve_raise_fault() is similar to #GP handler and is responsible for
> sending SIGSEGV to userspace and cpu die and notifying debuggers and

In all your text:

s/cpu/CPU/g

Audit all your patchsets pls.

> @@ -53,6 +67,11 @@ u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>  u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
>  		    u64 r15, struct tdx_hypercall_output *out);
>  
> +unsigned long tdg_get_ve_info(struct ve_info *ve);
> +
> +int tdg_handle_virtualization_exception(struct pt_regs *regs,

There's that "tdg" prefix again. Please fix all your patchsets.

> +					struct ve_info *ve);
> +
>  #else
>  
>  static inline void tdx_early_init(void) { };
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index df0fa695bb09..a5eaae8e6c44 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -68,6 +68,9 @@ static const __initconst struct idt_data early_idts[] = {
>  	 */
>  	INTG(X86_TRAP_PF,		asm_exc_page_fault),
>  #endif
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	INTG(X86_TRAP_VE,		asm_exc_virtualization_exception),
> +#endif
>  };
>  
>  /*
> @@ -91,6 +94,9 @@ static const __initconst struct idt_data def_idts[] = {
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
> index 3973e81751ba..6169f9c740b2 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -10,6 +10,7 @@
>  
>  /* TDX Module call Leaf IDs */
>  #define TDINFO				1
> +#define TDGETVEINFO			3
>  
>  static struct {
>  	unsigned int gpa_width;
> @@ -75,6 +76,41 @@ static void tdg_get_info(void)
>  	td_info.attributes = out.rdx;
>  }
>  
> +unsigned long tdg_get_ve_info(struct ve_info *ve)
> +{
> +	u64 ret;
> +	struct tdx_module_output out = {0};

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

> +
> +	/*
> +	 * NMIs and machine checks are suppressed. Before this point any
> +	 * #VE is fatal. After this point (TDGETVEINFO call), NMIs and
> +	 * additional #VEs are permitted (but we don't expect them to
> +	 * happen unless you panic).
> +	 */
> +	ret = __tdx_module_call(TDGETVEINFO, 0, 0, 0, 0, &out);
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
> +					struct ve_info *ve)
> +{
> +	/*
> +	 * TODO: Add handler support for various #VE exit
> +	 * reasons. It will be added by other patches in
> +	 * the series.
> +	 */

That comment needs to go.

> +	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> +	return -EFAULT;
> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	if (!cpuid_has_tdx_guest())
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..be56f0281cb5 100644
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
> @@ -1140,6 +1141,74 @@ DEFINE_IDTENTRY(exc_device_not_available)
>  	}
>  }
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +#define VEFSTR "VE fault"
> +static void ve_raise_fault(struct pt_regs *regs, long error_code)
> +{
> +	struct task_struct *tsk = current;
> +
> +	if (user_mode(regs)) {
> +		tsk->thread.error_code = error_code;
> +		tsk->thread.trap_nr = X86_TRAP_VE;
> +
> +		/*
> +		 * Not fixing up VDSO exceptions similar to #GP handler
> +		 * because we don't expect the VDSO to trigger #VE.
> +		 */
> +		show_signal(tsk, SIGSEGV, "", VEFSTR, regs, error_code);
> +		force_sig(SIGSEGV);
> +		return;
> +	}
> +
> +	if (fixup_exception(regs, X86_TRAP_VE, error_code, 0))

There are exception table entries which can trigger a #VE?

> +		return;
> +
> +	tsk->thread.error_code = error_code;
> +	tsk->thread.trap_nr = X86_TRAP_VE;
> +
> +	/*
> +	 * To be potentially processing a kprobe fault and to trust the result
> +	 * from kprobe_running(), we have to be non-preemptible.
> +	 */
> +	if (!preemptible() &&
> +	    kprobe_running() &&
> +	    kprobe_fault_handler(regs, X86_TRAP_VE))
> +		return;
> +
> +	notify_die(DIE_GPF, VEFSTR, regs, error_code, X86_TRAP_VE, SIGSEGV);

Other handlers check that retval.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
