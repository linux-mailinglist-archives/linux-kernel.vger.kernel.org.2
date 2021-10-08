Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E62C426FAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 19:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhJHRkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 13:40:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:49065 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhJHRkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 13:40:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="207365699"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="207365699"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 10:38:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="479056181"
Received: from jmapas-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.3.48])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 10:38:24 -0700
Subject: Re: [PATCH v8 07/11] x86/tdx: Add HLT support for TDX guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-8-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWCAeCIYovTnqvbd@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <bb0c91bf-2b10-e177-90f1-d9af506f7c74@linux.intel.com>
Date:   Fri, 8 Oct 2021 10:38:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWCAeCIYovTnqvbd@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/21 10:31 AM, Borislav Petkov wrote:
> On Mon, Oct 04, 2021 at 07:52:01PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> @@ -240,6 +243,33 @@ SYM_FUNC_START(__tdx_hypercall)
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
>> +	jne skip_sti
>> +	/* Set R15 register to 0, it is unused in EXIT_REASON_HLT case */
>> +	xor %r15, %r15
> 
> Then you don't need to clear it either, right?

Yes. As per ABI, I don't need to clear it. It will not be used by VMM.
But since that register content is shared with VMM, I tried to keep the
unused register values to '0' (consistent with other hypercall use cases).

I am fine with removing it if you think it is unnecessary.

> 
>> +	sti
>> +skip_sti:
>>   	tdcall
>>   
>>   	/* Restore output pointer to R9 */
> 
> ...
> 
>> +static __cpuidle void tdx_halt(void)
>> +{
>> +	const bool irq_disabled = irqs_disabled();
>> +	const bool do_sti = false;
>> +
>> +	/*
>> +	 * Non safe halt is mainly used in CPU off-lining
>> +	 * and the guest will stay in halt state. So,
>> +	 * STI instruction call is not required (set
>> +	 * do_sti as false).
>> +	 */
> 
> Just like you've done below, put the comment over the variable assignment:

> 
>          /*
>           * Non safe halt is mainly used in CPU offlining  and the guest will stay in halt
>           * state. So, STI instruction call is not required.
>           */
>          const bool do_sti = false;

Will move it above in next version.

> 
> 
>> +	_tdx_halt(irq_disabled, do_sti);
>> +}
>> +
>> +static __cpuidle void tdx_safe_halt(void)
>> +{
>> +	 /*
>> +	  * Since STI instruction will be called in __tdx_hypercall()
>> +	  * set irq_disabled as false.
>> +	  */
>> +	const bool irq_disabled = false;
>> +	const bool do_sti = true;
>> +
>> +	_tdx_halt(irq_disabled, do_sti);
>> +}
>> +
>>   unsigned long tdx_get_ve_info(struct ve_info *ve)
>>   {
>>   	struct tdx_module_output out = {0};
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
