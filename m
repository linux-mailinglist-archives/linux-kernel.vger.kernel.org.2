Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E20446B1F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 00:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhKEXLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 19:11:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:19004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230331AbhKEXLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 19:11:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="212047712"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="212047712"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:09:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="502161907"
Received: from jdbuch-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.52.151])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:09:01 -0700
Subject: Re: [PATCH v7 04/10] x86/tdx: Handle early IO operations
To:     Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005204136.1812078-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YYWeWlmYvotKrX+p@google.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c1d5d5b4-5767-c85b-9b04-5a818e8ba160@linux.intel.com>
Date:   Fri, 5 Nov 2021 16:08:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYWeWlmYvotKrX+p@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/21 2:12 PM, Sean Christopherson wrote:
> On Tue, Oct 05, 2021, Kuppuswamy Sathyanarayanan wrote:
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> Heh, is Andi double-dipping to pad his stats?  :-D

Sorry, it was my mistake. I will remove it.

> 
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
> 
> ...
> 
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> index 11e367228e96..4cbffcb737d9 100644
>> --- a/arch/x86/kernel/tdx.c
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -10,6 +10,11 @@
>>   /* TDX Module call Leaf IDs */
>>   #define TDGETVEINFO			3
>>   
>> +#define VE_IS_IO_OUT(exit_qual)		(((exit_qual) & 8) ? 0 : 1)
>> +#define VE_GET_IO_SIZE(exit_qual)	(((exit_qual) & 7) + 1)
>> +#define VE_GET_PORT_NUM(exit_qual)	((exit_qual) >> 16)
>> +#define VE_IS_IO_STRING(exit_qual)	((exit_qual) & 16 ? 1 : 0)
>> +
>>   /*
>>    * Allocate it in the data region to avoid zeroing it during
>>    * BSS initialization. It is mainly used in cc_platform_has()
>> @@ -228,6 +233,61 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
>>   	return ret;
>>   }
>>   
>> +/*
>> + * Handle early IO, mainly for early printks serial output.
>> + * This avoids anything that doesn't work early on, like tracing
>> + * or printks, by calling the low level functions directly. Any
>> + * problems are handled by falling back to a standard early exception.
>> + *
>> + * Assumes the IO instruction was using ax, which is enforced
>> + * by the standard io.h macros.
>> + */
>> +static __init bool tdx_early_io(struct pt_regs *regs, u32 exit_qual)
>> +{
>> +	struct tdx_hypercall_output outh;
> 
> "outh" looks like a typo.  Maybe "result" or something alongs those lines?

I have fixed it (will be part of next submission). We are going to use
out here and change

out = VE_IS_IO_OUT(exit_qual);

to

in = VE_IS_IO_IN(exit_qual);

> 
>> +	int out, size, port, ret;
>> +	bool string;
>> +	u64 mask;
>> +
>> +	string = VE_IS_IO_STRING(exit_qual);
>> +
>> +	/* I/O strings ops are unrolled at build time. */
>> +	if (string)
> 
> Why bother with "string"?
> 
> 	if (VE_IS_IO_STRING(exit_qual))
> 		return false;
> 
>> +		return 0;
> 
> Ugh.  This needs to be "return false".  "return 0" in the kernel usually means
> success, but this horror returns a bool where "false" is failure.

It will be fixed in next version.

> 
>> +
>> +	out = VE_IS_IO_OUT(exit_qual);
>> +	size = VE_GET_IO_SIZE(exit_qual);
>> +	port = VE_GET_PORT_NUM(exit_qual);
>> +	mask = GENMASK(8 * size, 0);
> 
> size * BITS_PER_BYTE

Ok. I will fix this in next version.

> 
>> +
>> +	ret = _tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, out, port,
>> +			     regs->ax, &outh);
> 
> This unnecessarily exposes RAX to the untrusted VMM for IN.

Yes. I will remove it.

> 
>> +	if (!out && !ret) {
>> +		regs->ax &= ~mask;
>> +		regs->ax |= outh.r11 & mask;
>> +	}
>> +
>> +	return !ret;
>> +}

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
