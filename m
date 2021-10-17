Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8387D430649
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 04:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244896AbhJQCr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 22:47:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:2356 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244886AbhJQCr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 22:47:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10139"; a="208881425"
X-IronPort-AV: E=Sophos;i="5.85,379,1624345200"; 
   d="scan'208";a="208881425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2021 19:45:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,379,1624345200"; 
   d="scan'208";a="443003592"
Received: from bberndt-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.12.149])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2021 19:45:16 -0700
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v10 06/11] x86/traps: Add #VE support for TDX guest
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
 <20211009053747.1694419-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87o87s6mb7.ffs@tglx>
Message-ID: <58ed8d10-f95e-b8d6-da42-94cf23c552eb@linux.intel.com>
Date:   Sat, 16 Oct 2021 19:45:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87o87s6mb7.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/14/21 1:30 AM, Thomas Gleixner wrote:
> On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
>>   
>> +/*
>> + * Used by #VE exception handler to gather the #VE exception
>> + * info from the TDX module. This is software only structure
>> + * and not related to TDX module/VMM.
>> + */
>> +struct ve_info {
>> +	u64 exit_reason;
>> +	u64 exit_qual;
>> +	u64 gla;	/* Guest Linear (virtual) Address */
>> +	u64 gpa;	/* Guest Physical (virtual) Address */
> Please do not use tail comments and with a tab between type and name
> this becomes more readable:
>
> 	/* Guest Linear (virtual) Address */
> 	u64	gla;
>
>          /* Guest Physical (virtual) Address */
> 	u64	gpa;
>
> Hmm?

Agree. I will fix this in next version. I will make sure to fix similar 
issues
in other TDX patch series as well.

>    
>> +bool tdx_get_ve_info(struct ve_info *ve)
>> +{
>> +	struct tdx_module_output out;
>> +	u64 ret;
>> +
>> +	if (!ve)
>> +		return false;
> This should be WARN_ON_ONCE() if at all.

This is an input validation. Since we need to de-reference "ve" in the 
following code,
we want to validate it to avoid NULL pointer exception. As per current 
usage of this
function, "ve" will not be NULL. But we have added this check as a extra 
precaution
against future use cases.

If you think this check is not required now, I can remove it. Please let 
me know.

>> +	/*
>> +	 * NMIs and machine checks are suppressed. Before this point any
>> +	 * #VE is fatal. After this point (TDGETVEINFO call), NMIs and
>> +	 * additional #VEs are permitted (but it is expected not to
>> +	 * happen unless kernel panics).
>> +	 */
>> +	ret = __tdx_module_call(TDX_GET_VEINFO, 0, 0, 0, 0, &out);
>> +	if (ret)
>> +		return false;
>           if (__tdx...())
>           	return false;

Agree. I will simplify it as you have mentioned in next version.

>> +	ve->exit_reason = out.rcx;
>> +	ve->exit_qual   = out.rdx;
>> +	ve->gla         = out.r8;
>> +	ve->gpa         = out.r9;
>> +	ve->instr_len   = out.r10 & UINT_MAX;
>> +	ve->instr_info  = out.r10 >> 32;
>> +
>> +	return true;
>> +}
>> +
>> +bool tdx_handle_virtualization_exception(struct pt_regs *regs,
>> +					 struct ve_info *ve)
>> +{
>> +	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
>> +	return false;
>> +}
>> +
>>   void __init tdx_early_init(void)
>>   {
>>   	if (!is_tdx_guest())
>> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
>> index a58800973aed..70d76c3a548f 100644
>> --- a/arch/x86/kernel/traps.c
>> +++ b/arch/x86/kernel/traps.c
>> @@ -61,6 +61,7 @@
>>   #include <asm/insn.h>
>>   #include <asm/insn-eval.h>
>>   #include <asm/vdso.h>
>> +#include <asm/tdx.h>
>>   
>>   #ifdef CONFIG_X86_64
>>   #include <asm/x86_init.h>
>> @@ -1140,6 +1141,82 @@ DEFINE_IDTENTRY(exc_device_not_available)
>>   	}
>>   }
>>   
>> +#ifdef CONFIG_INTEL_TDX_GUEST
>> +#define VE_FAULT_STR "VE fault"
>> +static void ve_raise_fault(struct pt_regs *regs, long error_code)
> Please do not glue the #define and the function definition
> together. Newlines exist for a reaon.

Got it. I will fix this issue in next version.

>> +{
>> +	struct task_struct *tsk = current;
>> +
>> +	if (user_mode(regs)) {
>> +		tsk->thread.error_code = error_code;
>> +		tsk->thread.trap_nr = X86_TRAP_VE;
>> +
>> +		/*
>> +		 * Not fixing up VDSO exceptions similar to #GP handler
>> +		 * because it is expected that VDSO doesn't trigger #VE.
> Expected?


It will never happen for TDX. Since this handler is a trimmed out version
of  #GP handler, I want to add some comments about why we don't have
VDSO related handling code. Since this is irrelevant for #VE handler, may
be I remove this comment completely, any comment?

>> +		 */
>> +		show_signal(tsk, SIGSEGV, "", VE_FAULT_STR, regs, error_code);
>> +		force_sig(SIGSEGV);
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Attempt to recover from #VE exception failure without
>> +	 * triggering OOPS (useful for MSR read/write failures)
>> +	 */
>> +	if (fixup_exception(regs, X86_TRAP_VE, error_code, 0))
>> +		return;
>> +
>> +	tsk->thread.error_code = error_code;
>> +	tsk->thread.trap_nr = X86_TRAP_VE;
>> +
>> +	/*
>> +	 * To be potentially processing a kprobe fault and to trust the result
>> +	 * from kprobe_running(), it should be non-preemptible.
>> +	 */
>> +	if (!preemptible() &&
>> +	    kprobe_running() &&
> 	if (!preemptible() && kprobe_running() &&
>> +	    kprobe_fault_handler(regs, X86_TRAP_VE))
> perhaps?

Agree. I will fix it in next version.

>> +
>> +DEFINE_IDTENTRY(exc_virtualization_exception)
>> +{
>> +	struct ve_info ve;
>> +	bool ret;
>> +
>> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> Please remove that. The idtentry code is already taking care of that.

Ok. I will remove it in next version.

>> +	/*
>> +	 * NMIs/Machine-checks/Interrupts will be in a disabled state
>> +	 * till TDGETVEINFO TDCALL is executed. This prevents #VE
>> +	 * nesting issue.
> s/This prevents.../This ensures that VE info cannot be overwritten by a
> nested #VE/
>
> Or something like that perhaps?


It is a better way to put it. I will use your version.

> Also a some comment about #VE in general above the DEFINE_IDTENTRY()
> would be appreciated.

I will add more info in next version.

> Thanks,
>
>          tglx

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

