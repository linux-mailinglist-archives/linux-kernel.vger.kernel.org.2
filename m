Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430D8350A41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhCaW34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:29:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:15098 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232491AbhCaW3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:29:44 -0400
IronPort-SDR: XZ/UUiHMYtjDtenA32Am9GUKklWqen+NzTMAEc1gqxZb1iqXpIrXTIhTO+D4FmfH8TizCPkOKp
 1vzfsKHOYHxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192205906"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="192205906"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 15:29:44 -0700
IronPort-SDR: ogpceCYiYbJvyJBxi3DpVPACATYMqjGVMoLWE14Yt8/3xbuv4sVX4AhpieGWTfNE8uEXNFLm86
 ODfvGAEt1yIw==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="394233987"
Received: from sjard-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.174.17])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 15:29:43 -0700
Subject: Re: [PATCH v4 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
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
References: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
 <e62cfd0ae90de435e6819979d9027f76d835a22a.1617224710.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <7882ef34-416f-9627-dcbe-7bf88c866dc8@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <097b4cad-8f01-40cf-203e-1a9228450c80@linux.intel.com>
Date:   Wed, 31 Mar 2021 15:29:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7882ef34-416f-9627-dcbe-7bf88c866dc8@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/21 2:49 PM, Dave Hansen wrote:
> On 3/31/21 2:09 PM, Kuppuswamy Sathyanarayanan wrote:
>> As per Guest-Host Communication Interface (GHCI) Specification
>> for Intel TDX, sec 2.4.1, TDX architecture does not support
>> MWAIT, MONITOR and WBINVD instructions. So in non-root TDX mode,
>> if MWAIT/MONITOR instructions are executed with CPL != 0 it will
>> trigger #UD, and for CPL = 0 case, virtual exception (#VE) is
>> triggered. WBINVD instruction behavior is also similar to
>> MWAIT/MONITOR, but for CPL != 0 case, it will trigger #GP instead
>> of #UD.
> 
> Could we give it a go to try this in plain English before jumping in and
> quoting the exact spec section?  Also, the CPL language is nice and
> precise for talking inside Intel, but it's generally easier for me to
> read kernel descriptions when we just talk about the kernel.
> 
> 	When running as a TDX guest, there are a number of existing,
> 	privileged instructions that do not work.  If the guest kernel
> 	uses these instructions, the hardware generates a #VE.
I will fix it in next version.
> 
> Which reminds me...  The SDM says: MWAIT will "#UD ... If
> CPUID.01H:ECX.MONITOR[bit 3] = 0".  So, is this an architectural change?
>   The guest is *supposed* to see that CPUID bit as 0, so shouldn't it
> also get a #UD?  Or is this all so that if SEAM *forgets* to clear the
> CPUID bit, the guest gets #VE?
AFAIK, we are only concerned about the case where the instruction support
is not disabled by SEAM. For disabled case, it should get #UD.
Sean, can you confirm it?
> 
> What are we *actually* mitigating here?
we add support for #VE, when executing un-supported instruction in TD guest
kernel.
> 
> Also, FWIW, MWAIT/MONITOR and WBINVD are pretty different beasts.  I
> think this would all have been a lot more clear if this would have been
> two patches instead of shoehorning them into one.
Since all of them are unsupported instructions, I have grouped them
together. Even if we split it, there should be some duplication in commit
log (since handling is similar). But let me know if this is a desired
approach. I can split it in two patches.
> 
>> To prevent TD guest from using these unsupported instructions,
>> following measures are adapted:
>>
>> 1. For MWAIT/MONITOR instructions, support for these instructions
>> are already disabled by TDX module (SEAM). So CPUID flags for
>> these instructions should be in disabled state. Also, just to be
>> sure that these instructions are disabled, forcefully unset
>> X86_FEATURE_MWAIT CPU cap in OS.
>>
>> 2. For WBINVD instruction, we use audit to find the code that uses
>> this instruction and disable them for TD.
> 
> Really?  Where are those patches?
For MWAIT/MONITOR, the change is included in the same patch.
For WBINVD, we have will have some patches included in next
series.
> 
>> +static inline bool cpuid_has_mwait(void)
>> +{
>> +	if (cpuid_ecx(1) & (1 << (X86_FEATURE_MWAIT % 32)))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>>   bool is_tdx_guest(void)
>>   {
>>   	return static_cpu_has(X86_FEATURE_TDX_GUEST);
>> @@ -301,12 +309,25 @@ static int tdg_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>>   	return insn.length;
>>   }
>>   
>> +/* Initialize TDX specific CPU capabilities */
>> +static void __init tdx_cpu_cap_init(void)
>> +{
>> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>> +
>> +	if (cpuid_has_mwait()) {
>> +		WARN(1, "TDX Module failed to disable MWAIT\n");
> 
> WARN(1, "TDX guest enumerated support for MWAIT, disabling it").
will fix it in next version.
> 
>> +		/* MWAIT is not supported in TDX platform, so suppress it */
>> +		setup_clear_cpu_cap(X86_FEATURE_MWAIT);
>> +	}
>> +
>> +}
> 
> Extra newline.
> 
>>   void __init tdx_early_init(void)
>>   {
>>   	if (!cpuid_has_tdx_guest())
>>   		return;
>>   
>> -	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>> +	tdx_cpu_cap_init();
>>   
>>   	tdg_get_info();
>>   
>> @@ -362,6 +383,27 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
>>   	case EXIT_REASON_EPT_VIOLATION:
>>   		ve->instr_len = tdg_handle_mmio(regs, ve);
>>   		break;
>> +	case EXIT_REASON_WBINVD:
>> +		/*
>> +		 * TDX architecture does not support WBINVD instruction.
>> +		 * Currently, usage of this instruction is prevented by
>> +		 * disabling the drivers which uses it. So if we still
>> +		 * reach here, it needs user attention.
>> +		 */
> 
> This comment is awfully vague.  "TDX architecture..." what?  Any CPUs
> supporting the TDX architecture?  TDX VMM's?  TDX Guests?
> 
> Let's also not waste byte on stating the obvious.  If it didn't need
> attention we wouldn't be warning about it, eh?
> 
> So, let's halve the size of the comment and say:
> 
> 		/*
> 		 * WBINVD is not supported inside TDX guests.  All in-
> 		 * kernel uses should have been disabled.
> 		 */
ok. will fix it next version.
> 
>> +		pr_err("TD Guest used unsupported WBINVD instruction\n");
>> +		BUG();
>> +		break;
>> +	case EXIT_REASON_MONITOR_INSTRUCTION:
>> +	case EXIT_REASON_MWAIT_INSTRUCTION:
>> +		/*
>> +		 * MWAIT/MONITOR features are disabled by TDX Module (SEAM)
>> +		 * and also re-suppressed in kernel by clearing
>> +		 * X86_FEATURE_MWAIT CPU feature flag in tdx_early_init(). So
>> +		 * if TD guest still executes MWAIT/MONITOR instruction with
>> +		 * above suppression, it needs user attention.
>> +		 */
> 
> Again, let's trim this down:
> 
> 		/*
> 		 * Something in the kernel used MONITOR or MWAIT despite
> 		 * X86_FEATURE_MWAIT being cleared for TDX guests.
> 		 */
will fix it next version.
> 
> Rather than naming the function, this makes it quite greppable to find
> where it could have *possibly* been cleared.
> 
>> +		WARN(1, "TD Guest used unsupported MWAIT/MONITOR instruction\n");
I think WARN_ONCE is good enough for this exception. Do you agree?
>> +		break;
>>   	default:
>>   		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
>>   		return -EFAULT;
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
