Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713824165F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 21:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242904AbhIWTeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 15:34:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:31925 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242796AbhIWTen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:34:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="203424231"
X-IronPort-AV: E=Sophos;i="5.85,317,1624345200"; 
   d="scan'208";a="203424231"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 12:33:06 -0700
X-IronPort-AV: E=Sophos;i="5.85,317,1624345200"; 
   d="scan'208";a="551271593"
Received: from tbirrer-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.101.82])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 12:33:05 -0700
Subject: Re: [PATCH v7 08/12] x86/tdx: Add HLT support for TDX guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210916183550.15349-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YUzC7N8/MHI++y/G@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <5b728681-39e3-1399-2b01-53c950f9c6a5@linux.intel.com>
Date:   Thu, 23 Sep 2021 12:33:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUzC7N8/MHI++y/G@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/21 11:09 AM, Borislav Petkov wrote:
> On Thu, Sep 16, 2021 at 11:35:46AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +static __cpuidle void _tdx_halt(const bool irq_disabled, const bool do_sti)
>> +{
>> +	u64 ret;
>> +
>> +	/*
>> +	 * Emulate HLT operation via hypercall. More info about ABI
>> +	 * can be found in TDX Guest-Host-Communication Interface
>> +	 * (GHCI), sec 3.8.
> 
> 	"3.8 TDG.VP.VMCALL<Instruction.HLT>"
> 
> write that section name because those numbers do change.

Sorry, I fixed it in commit log, but missed it here. I will fix it in next
submission.

> 
>> +	 *
>> +	 * The VMM uses the "IRQ disabled" param to understand IRQ
>> +	 * enabled status (RFLAGS.IF) of TD guest and determine
>> +	 * whether or not it should schedule the halted vCPU if an
>> +	 * IRQ becomes pending. E.g. if IRQs are disabled the VMM
>> +	 * can keep the vCPU in virtual HLT, even if an IRQ is
>> +	 * pending, without hanging/breaking the guest.
>> +	 *
>> +	 * do_sti parameter is used by __tdx_hypercall() to decide
>> +	 * whether to call STI instruction before executing TDCALL
>> +	 * instruction.
>> +	 */
>> +	ret = _tdx_hypercall(EXIT_REASON_HLT, irq_disabled, 0, 0, do_sti, NULL);
> 
> So that irq_disabled goes into r12. Nothing in that section 3.8 above
> talks about r12. The doc version I'm looking at is:
> 
> 344426-001US
> SEPTEMBER 2020
> 
> Where is that "the IRQs in the guest were disabled/enabled" bit
> documented?

IRQ parameter specification update is not yet released for public. I think it will
be released in 2-3 weeks.

> 
>> +
>> +	/*
>> +	 * Use WARN_ONCE() to report the failure. Since tdx_*halt() calls
>> +	 * are also used in pv_ops, #VE handler error handler cannot be
> 
> one "handler"'s enough.

Ok. I will fix this in next version.

> 
>> +	 * used to report the failure.
>> +	 */
>> +	WARN_ONCE(ret, "HLT instruction emulation failed\n");
>> +}
>> +
>> +static __cpuidle void tdx_halt(void)
>> +{
>> +	const bool irq_disabled = irqs_disabled();
>> +	const bool do_sti = false;
> 
> What is the logic here?
> 
> This is not a safe halt so it doesn't matter to the TDX module whether
> irqs are disabled or not?
> 
> That comment above is again keeping it to itself:
> 
> "But this change is not required for all HLT cases."
> 
> So for which cases is it required?

It's only needed for the safe hlt case because the non safe hlt case doesn't
change anything about the interrupt.

> 
> Is that explained in the comment in _tdx_halt() where irqs_disabled
> tells the VMM what to do with the guest - to wake it up or to keep it in
> virtual halt?

I think it is left in halt state. Sean, any comment?

> 
>> +
>> +	_tdx_halt(irq_disabled, do_sti);
>> +}
>> +
>> +static __cpuidle void tdx_safe_halt(void)
>> +{
>> +	const bool irq_disabled = false; /* since sti will be called */
> 
> Comments usually go ontop not on the side.

I will fix this in next version.

> 
>> +	const bool do_sti = true;
>> +
>> +	_tdx_halt(irq_disabled, do_sti);
>> +}
>> +
>>   unsigned long tdx_get_ve_info(struct ve_info *ve)
>>   {
>>   	struct tdx_module_output out = {0};
> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
