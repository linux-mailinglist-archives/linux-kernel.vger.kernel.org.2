Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C05842625F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 04:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhJHCSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 22:18:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:4307 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhJHCSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 22:18:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="223826884"
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="223826884"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 19:16:13 -0700
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="624552839"
Received: from mlazarux-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.19.27])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 19:16:11 -0700
Subject: Re: [PATCH v8 09/11] x86/tdx: Add MSR support for TDX guest
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
 <20211005025205.1784480-10-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211006194910.cdbqzn5enpueg7iw@treble>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <1830c3cc-635a-ab59-e217-f48fca8d9cf5@linux.intel.com>
Date:   Thu, 7 Oct 2021 19:16:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006194910.cdbqzn5enpueg7iw@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 12:49 PM, Josh Poimboeuf wrote:
> On Mon, Oct 04, 2021 at 07:52:03PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> index 3d0416515506..062ac4720434 100644
>> --- a/arch/x86/kernel/tdx.c
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -110,6 +110,41 @@ static __cpuidle void tdx_safe_halt(void)
>>   	_tdx_halt(irq_disabled, do_sti);
>>   }
>>   
>> +static u64 tdx_read_msr_safe(unsigned int msr, int *err)
> 
> Here the kernel convention would probably be to return the error and
> make 'val' an argument:
> 
> static int tdx_read_msr_safe(unsigned int msr, u64 *val)

Agree. I will fix this in next version.

> 
> 
>> +{
>> +	struct tdx_hypercall_output out = {0};
>> +	u64 ret;
>> +
>> +	/*
>> +	 * Emulate the MSR read via hypercall. More info about ABI
>> +	 * can be found in TDX Guest-Host-Communication Interface
>> +	 * (GHCI), sec titled "TDG.VP.VMCALL<Instruction.RDMSR>".
>> +	 */
>> +	ret = _tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out);
>> +
>> +	*err = ret ? -EIO : 0;
>> +
>> +	return out.r11;
>> +}
>> +
>> +static int tdx_write_msr_safe(unsigned int msr, unsigned int low,
>> +			      unsigned int high)
>> +{
>> +	u64 ret;
>> +
>> +	WARN_ON_ONCE(tdx_is_context_switched_msr(msr));
> 
> This fails to build, tdx_is_context_switched_msr() is missing.
> 
>> @@ -136,19 +171,33 @@ unsigned long tdx_get_ve_info(struct ve_info *ve)
>>   int tdx_handle_virtualization_exception(struct pt_regs *regs,
>>   					struct ve_info *ve)
>>   {
>> +	unsigned long val;
>> +	int ret = 0;
>> +
>>   	switch (ve->exit_reason) {
>>   	case EXIT_REASON_HLT:
>>   		tdx_halt();
>>   		break;
>> +	case EXIT_REASON_MSR_READ:
>> +		val = tdx_read_msr_safe(regs->cx, (unsigned int *)&ret);
> 
> Why the 'unsigned int *' cast?
> 
> Also, 'val' should have the same type as the one returned by
> tdx_read_msr_safe().  (Though it technically doesn't matter here.)

I will change val type to u64. It will not need any casting.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
