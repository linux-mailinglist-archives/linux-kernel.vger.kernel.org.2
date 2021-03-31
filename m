Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60443509C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCaVuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:50:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:42835 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhCaVt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:49:57 -0400
IronPort-SDR: gCGFUi/PvMcWm2ArXO4EtixyiEB7mgmR2QhWJRJV1+XAyCZGvCy9tWGCl3uPDCTOy/9aBavQui
 oU6ofTeTe0UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="212344031"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="212344031"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:49:56 -0700
IronPort-SDR: wKdcba4+RyFYBInO/sjVcjCFUtfKgDtquJqEgQ2GYgat8CnVJBBvmOYH8VMWgZWjRQpibbJ/yr
 9IOPF+ghnzwg==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="418870589"
Received: from algolden-mobl1.amr.corp.intel.com (HELO [10.209.172.7]) ([10.209.172.7])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:49:55 -0700
Subject: Re: [PATCH v4 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
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
References: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
 <e62cfd0ae90de435e6819979d9027f76d835a22a.1617224710.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <7882ef34-416f-9627-dcbe-7bf88c866dc8@intel.com>
Date:   Wed, 31 Mar 2021 14:49:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e62cfd0ae90de435e6819979d9027f76d835a22a.1617224710.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/21 2:09 PM, Kuppuswamy Sathyanarayanan wrote:
> As per Guest-Host Communication Interface (GHCI) Specification
> for Intel TDX, sec 2.4.1, TDX architecture does not support
> MWAIT, MONITOR and WBINVD instructions. So in non-root TDX mode,
> if MWAIT/MONITOR instructions are executed with CPL != 0 it will
> trigger #UD, and for CPL = 0 case, virtual exception (#VE) is
> triggered. WBINVD instruction behavior is also similar to
> MWAIT/MONITOR, but for CPL != 0 case, it will trigger #GP instead
> of #UD.

Could we give it a go to try this in plain English before jumping in and
quoting the exact spec section?  Also, the CPL language is nice and
precise for talking inside Intel, but it's generally easier for me to
read kernel descriptions when we just talk about the kernel.

	When running as a TDX guest, there are a number of existing,
	privileged instructions that do not work.  If the guest kernel
	uses these instructions, the hardware generates a #VE.

Which reminds me...  The SDM says: MWAIT will "#UD ... If
CPUID.01H:ECX.MONITOR[bit 3] = 0".  So, is this an architectural change?
 The guest is *supposed* to see that CPUID bit as 0, so shouldn't it
also get a #UD?  Or is this all so that if SEAM *forgets* to clear the
CPUID bit, the guest gets #VE?

What are we *actually* mitigating here?

Also, FWIW, MWAIT/MONITOR and WBINVD are pretty different beasts.  I
think this would all have been a lot more clear if this would have been
two patches instead of shoehorning them into one.

> To prevent TD guest from using these unsupported instructions,
> following measures are adapted:
> 
> 1. For MWAIT/MONITOR instructions, support for these instructions
> are already disabled by TDX module (SEAM). So CPUID flags for
> these instructions should be in disabled state. Also, just to be
> sure that these instructions are disabled, forcefully unset
> X86_FEATURE_MWAIT CPU cap in OS.
> 
> 2. For WBINVD instruction, we use audit to find the code that uses
> this instruction and disable them for TD.

Really?  Where are those patches?

> +static inline bool cpuid_has_mwait(void)
> +{
> +	if (cpuid_ecx(1) & (1 << (X86_FEATURE_MWAIT % 32)))
> +		return true;
> +
> +	return false;
> +}
> +
>  bool is_tdx_guest(void)
>  {
>  	return static_cpu_has(X86_FEATURE_TDX_GUEST);
> @@ -301,12 +309,25 @@ static int tdg_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  	return insn.length;
>  }
>  
> +/* Initialize TDX specific CPU capabilities */
> +static void __init tdx_cpu_cap_init(void)
> +{
> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> +
> +	if (cpuid_has_mwait()) {
> +		WARN(1, "TDX Module failed to disable MWAIT\n");

WARN(1, "TDX guest enumerated support for MWAIT, disabling it").

> +		/* MWAIT is not supported in TDX platform, so suppress it */
> +		setup_clear_cpu_cap(X86_FEATURE_MWAIT);
> +	}
> +
> +}

Extra newline.

>  void __init tdx_early_init(void)
>  {
>  	if (!cpuid_has_tdx_guest())
>  		return;
>  
> -	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> +	tdx_cpu_cap_init();
>  
>  	tdg_get_info();
>  
> @@ -362,6 +383,27 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
>  	case EXIT_REASON_EPT_VIOLATION:
>  		ve->instr_len = tdg_handle_mmio(regs, ve);
>  		break;
> +	case EXIT_REASON_WBINVD:
> +		/*
> +		 * TDX architecture does not support WBINVD instruction.
> +		 * Currently, usage of this instruction is prevented by
> +		 * disabling the drivers which uses it. So if we still
> +		 * reach here, it needs user attention.
> +		 */

This comment is awfully vague.  "TDX architecture..." what?  Any CPUs
supporting the TDX architecture?  TDX VMM's?  TDX Guests?

Let's also not waste byte on stating the obvious.  If it didn't need
attention we wouldn't be warning about it, eh?

So, let's halve the size of the comment and say:

		/*
		 * WBINVD is not supported inside TDX guests.  All in-
		 * kernel uses should have been disabled.
		 */

> +		pr_err("TD Guest used unsupported WBINVD instruction\n");
> +		BUG();
> +		break;
> +	case EXIT_REASON_MONITOR_INSTRUCTION:
> +	case EXIT_REASON_MWAIT_INSTRUCTION:
> +		/*
> +		 * MWAIT/MONITOR features are disabled by TDX Module (SEAM)
> +		 * and also re-suppressed in kernel by clearing
> +		 * X86_FEATURE_MWAIT CPU feature flag in tdx_early_init(). So
> +		 * if TD guest still executes MWAIT/MONITOR instruction with
> +		 * above suppression, it needs user attention.
> +		 */

Again, let's trim this down:

		/*
		 * Something in the kernel used MONITOR or MWAIT despite
		 * X86_FEATURE_MWAIT being cleared for TDX guests.
		 */

Rather than naming the function, this makes it quite greppable to find
where it could have *possibly* been cleared.

> +		WARN(1, "TD Guest used unsupported MWAIT/MONITOR instruction\n");
> +		break;
>  	default:
>  		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
>  		return -EFAULT;
> 

