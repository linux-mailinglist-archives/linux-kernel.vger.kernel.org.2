Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8989F42E62B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 03:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhJOBgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:36:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:38159 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhJOBf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:35:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="251271023"
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="251271023"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 18:33:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="571605054"
Received: from anmone-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.15.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 18:33:52 -0700
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v10 07/11] x86/tdx: Add HLT support for TDX guest
To:     Thomas Gleixner <tglx@linutronix.de>,
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
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-8-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87lf2w6ji2.ffs@tglx>
Message-ID: <43de3c58-5a55-7dcf-48d4-1474bb1c61e5@linux.intel.com>
Date:   Thu, 14 Oct 2021 18:33:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87lf2w6ji2.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/14/21 2:30 AM, Thomas Gleixner wrote:
> On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
>> +/* HLT TDVMCALL sub-function ID */
>> +#define EXIT_REASON_HLT			12
> arch/x86/include/uapi/asm/vmx.h:#define EXIT_REASON_HLT                 12
>
> Is there a _good_ reason why this can't be reused?

As per current use case we can re-use it. Out of all TDX hypercall sub 
function
IDs, only Instruction.PCONFIG (65) exit reason id is missing in vmx.h. 
But currently
we are not handling it. So we can ignore it for now.

I will fix this in next version.

>>   /*
>>    * __tdx_module_call()  - Helper function used by TDX guests to request
>>    * services from the TDX module (does not include VMM services).
>> @@ -235,6 +238,33 @@ SYM_FUNC_START(__tdx_hypercall)
>>   
>>   	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>>   
>> +	/*
>> +	 * For the idle loop STI needs to be called directly before
>> +	 * the TDCALL that enters idle (EXIT_REASON_HLT case). STI
>> +	 * enables interrupts only one instruction later. If there
>> +	 * are any instructions between the STI and the TDCALL for
>> +	 * HLT then an interrupt could happen in that time, but the
>> +	 * code would go back to sleep afterwards, which can cause
>> +	 * longer delays.
>> +	 *
>> +	 * This leads to significant difference in network performance
>> +	 * benchmarks. So add a special case for EXIT_REASON_HLT to
>> +	 * trigger STI before TDCALL. But this change is not required
>> +	 * for all HLT cases. So use R15 register value to identify the
>> +	 * case which needs STI. So, if R11 is EXIT_REASON_HLT and R15
>> +	 * is 1, then call STI before TDCALL instruction. Note that R15
>> +	 * register is not required by TDCALL ABI when triggering the
>> +	 * hypercall for EXIT_REASON_HLT case. So use it in software to
>> +	 * select the STI case.
>> +	 */
>> +	cmpl $EXIT_REASON_HLT, %r11d
>> +	jne skip_sti
>> +	cmpl $1, %r15d
> You already have a nice define for EXIT_REASON_HLT. Please add one for this
> constant as well.

Ok. I will add it.

>> +	jne skip_sti
>> +	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
>> +	xor %r15, %r15
>> +	sti
>> +skip_sti:
>>   	tdcall
>>   bool tdx_get_ve_info(struct ve_info *ve)
>>   {
>>   	struct tdx_module_output out;
>> @@ -84,8 +141,19 @@ bool tdx_get_ve_info(struct ve_info *ve)
>>   bool tdx_handle_virtualization_exception(struct pt_regs *regs,
>>   					 struct ve_info *ve)
>>   {
>> -	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>> -	return false;
>> +	switch (ve->exit_reason) {
>> +	case EXIT_REASON_HLT:
>> +		tdx_halt();
>> +		break;
>> +	default:
>> +		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>> +		return false;
>> +	}
>> +
>> +	/* After successful #VE handling, move the IP */
>> +	regs->ip += ve->instr_len;
>> +
>> +	return true;
>>   }
>>   
>>   void __init tdx_early_init(void)
>> @@ -95,5 +163,8 @@ void __init tdx_early_init(void)
>>   
>>   	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>>   
>> +	pv_ops.irq.safe_halt = tdx_safe_halt;
>> +	pv_ops.irq.halt = tdx_halt;
> Colour me confused, but why do we end up in #VE with EXIT_REASON_HLT
> when halt/safe_halt is paravirtualized?
>
> There may be a valid reason. If so then this lacks a comment.

No, with halt/safe_halt para-virtualized, we should never get
#VE for it. I think this is a redundant handler code. This was
added before we have added the pv_ops support. I will remove
it in next version.

>
> Thanks,
>
>          tglx

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

