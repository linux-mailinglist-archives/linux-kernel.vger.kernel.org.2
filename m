Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B733D42D4DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 10:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhJNIcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 04:32:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhJNIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 04:32:10 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634200205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqkCYwxzKBVxepYfKFx3Jk6eNlCWWIIqLzGc/h7dJrM=;
        b=Z39i3g9rN/h7NTCR2LWF/r+gxOgvT5dnQFAmQpt08ylqAsSvtWdKDQ0JIevDmB87T+9PKR
        PlPktGT60GpK2VyYrYjXsNLdwwFYch1oqDqm0TzF6PVr1umkAELUD7ylvQpe3UIKIiySzQ
        lHAS0pC87cRvtFd0HAvxTsCiQ/CxgcMSE/3B4WmMkDJMfLoTnOIBJ+M6+1ky6BxcSMnaso
        6HSB3TngUdRlbBazlL6nrwbcAzt9O9GTeHgY5YzRJnY8Uvbti8+ts6D2JJE8ltyriXHbkc
        69Dr+xy7wM/2drm3GsjU/JnZ+xiJ27l5L1wxzyGG2FQCiJgPZfTVHQASRHnQMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634200205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqkCYwxzKBVxepYfKFx3Jk6eNlCWWIIqLzGc/h7dJrM=;
        b=fCKI7fASXs2/QQ6VV/pKMuSI8z85WKREt/lkoxTKUN0u7El57VN+67pkFBoCVsR7nDsENN
        8gCo4HrvHeRhqPDQ==
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
Subject: Re: [PATCH v10 06/11] x86/traps: Add #VE support for TDX guest
In-Reply-To: <20211009053747.1694419-7-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Thu, 14 Oct 2021 10:30:04 +0200
Message-ID: <87o87s6mb7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
>  
> +/*
> + * Used by #VE exception handler to gather the #VE exception
> + * info from the TDX module. This is software only structure
> + * and not related to TDX module/VMM.
> + */
> +struct ve_info {
> +	u64 exit_reason;
> +	u64 exit_qual;
> +	u64 gla;	/* Guest Linear (virtual) Address */
> +	u64 gpa;	/* Guest Physical (virtual) Address */

Please do not use tail comments and with a tab between type and name
this becomes more readable:

	/* Guest Linear (virtual) Address */
	u64	gla;

        /* Guest Physical (virtual) Address */
	u64	gpa;

Hmm?

  
> +bool tdx_get_ve_info(struct ve_info *ve)
> +{
> +	struct tdx_module_output out;
> +	u64 ret;
> +
> +	if (!ve)
> +		return false;

This should be WARN_ON_ONCE() if at all.

> +	/*
> +	 * NMIs and machine checks are suppressed. Before this point any
> +	 * #VE is fatal. After this point (TDGETVEINFO call), NMIs and
> +	 * additional #VEs are permitted (but it is expected not to
> +	 * happen unless kernel panics).
> +	 */
> +	ret = __tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out);
> +	if (ret)
> +		return false;

         if (__tdx...())
         	return false;

> +	ve->exit_reason = out.rcx;
> +	ve->exit_qual   = out.rdx;
> +	ve->gla         = out.r8;
> +	ve->gpa         = out.r9;
> +	ve->instr_len   = out.r10 & UINT_MAX;
> +	ve->instr_info  = out.r10 >> 32;
> +
> +	return true;
> +}
> +
> +bool tdx_handle_virtualization_exception(struct pt_regs *regs,
> +					 struct ve_info *ve)
> +{
> +	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> +	return false;
> +}
> +
>  void __init tdx_early_init(void)
>  {
>  	if (!is_tdx_guest())
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..70d76c3a548f 100644
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
> @@ -1140,6 +1141,82 @@ DEFINE_IDTENTRY(exc_device_not_available)
>  	}
>  }
>  
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +#define VE_FAULT_STR "VE fault"
> +static void ve_raise_fault(struct pt_regs *regs, long error_code)

Please do not glue the #define and the function definition
together. Newlines exist for a reaon.

> +{
> +	struct task_struct *tsk = current;
> +
> +	if (user_mode(regs)) {
> +		tsk->thread.error_code = error_code;
> +		tsk->thread.trap_nr = X86_TRAP_VE;
> +
> +		/*
> +		 * Not fixing up VDSO exceptions similar to #GP handler
> +		 * because it is expected that VDSO doesn't trigger #VE.

Expected?

> +		 */
> +		show_signal(tsk, SIGSEGV, "", VE_FAULT_STR, regs, error_code);
> +		force_sig(SIGSEGV);
> +		return;
> +	}
> +
> +	/*
> +	 * Attempt to recover from #VE exception failure without
> +	 * triggering OOPS (useful for MSR read/write failures)
> +	 */
> +	if (fixup_exception(regs, X86_TRAP_VE, error_code, 0))
> +		return;
> +
> +	tsk->thread.error_code = error_code;
> +	tsk->thread.trap_nr = X86_TRAP_VE;
> +
> +	/*
> +	 * To be potentially processing a kprobe fault and to trust the result
> +	 * from kprobe_running(), it should be non-preemptible.
> +	 */
> +	if (!preemptible() &&
> +	    kprobe_running() &&

	if (!preemptible() && kprobe_running() &&
> +	    kprobe_fault_handler(regs, X86_TRAP_VE))

perhaps? 

> +
> +DEFINE_IDTENTRY(exc_virtualization_exception)
> +{
> +	struct ve_info ve;
> +	bool ret;
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");

Please remove that. The idtentry code is already taking care of that.

> +	/*
> +	 * NMIs/Machine-checks/Interrupts will be in a disabled state
> +	 * till TDGETVEINFO TDCALL is executed. This prevents #VE
> +	 * nesting issue.

s/This prevents.../This ensures that VE info cannot be overwritten by a
nested #VE/

Or something like that perhaps?

Also a some comment about #VE in general above the DEFINE_IDTENTRY()
would be appreciated.

Thanks,

        tglx
