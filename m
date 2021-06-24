Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42293B3515
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 19:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhFXSBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:01:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:6394 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhFXSBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:01:13 -0400
IronPort-SDR: p49exp2brmX0Du/kH35v1JzfwUVzNkV8QZr+jQ8ePMCyaswD/BSL3lDJi4n036Y6Rxi+bkYO4U
 whvlWNXzrCEA==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="204520654"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="204520654"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 10:58:53 -0700
IronPort-SDR: kr5zBp9niZ2W2eP6TwnJa/lvwFr4KebFIGQgTnMM41AeBeS+p81QllHKR/8OV/QJ0LfKypEvZ1
 7zpxfSc7yyZA==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="487861512"
Received: from llvujovi-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.255.82.142])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 10:58:51 -0700
Subject: Re: [PATCH v3 04/11] x86: Introduce generic protected guest
 abstraction
To:     Borislav Petkov <bp@alien8.de>
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
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YNSeZv/U6QKK8sBo@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <a7096a91-f052-7e06-cd10-79dfeb600d0f@linux.intel.com>
Date:   Thu, 24 Jun 2021 10:58:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNSeZv/U6QKK8sBo@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/21 8:01 AM, Borislav Petkov wrote:
> On Fri, Jun 18, 2021 at 03:57:48PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Add a generic way to check if we run with an encrypted guest,
> 
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
> 
> Also, pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst for more details.
> 
> Bottom line is: personal pronouns are ambiguous in text, especially with
> so many parties/companies/etc developing the kernel so let's avoid them
> please.

I will fix this in next version. I will make sure to follow it in future
submissions.

> 
>> without requiring x86 specific ifdefs. This can then be used in
>> non architecture specific code.
> 
> "... in arch-independent code." or so.

I will fix this in next version.

> 
>> prot_guest_has() is used to check for protected guest feature
>> flags.
>>
>> Originally-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Change since v1:
>>   * Introduced PR_GUEST_TDX and PR_GUEST_SEV vendor flags as per
>>     Boris suggestion.
>>   * Replaced is_tdx_guest() with if (boot_cpu_data.x86_vendor ==
>>     X86_VENDOR_INTEL) in prot_guest_has().
>>   * Modified tdx_protected_guest_has() and sev_protected_guest_has()
>>     to support vendor flags.
> 
> ...
> 
>> diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
>> new file mode 100644
>> index 000000000000..d47668dee6c2
>> --- /dev/null
>> +++ b/arch/x86/include/asm/protected_guest.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright (C) 2020 Intel Corporation */
>> +#ifndef _ASM_PROTECTED_GUEST_H
>> +#define _ASM_PROTECTED_GUEST_H 1
> 
> #define _ASM_X86_PROTECTED_GUEST_H
> 
>> +
>> +#include <asm/processor.h>
>> +#include <asm/tdx.h>
>> +#include <asm/sev.h>
>> +
>> +static inline bool prot_guest_has(unsigned long flag)
>> +{
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>> +		return tdx_protected_guest_has(flag);
>> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> +		return sev_protected_guest_has(flag);
> 
> s/protected/prot/
> 
> tdx_prot_guest_has
> sev_prot_guest_has

Ok. I will make this change in next version.

> 
> ...
> 
>> @@ -18,6 +20,21 @@ static inline bool cpuid_has_tdx_guest(void)
>>   	return !memcmp("IntelTDX    ", sig, 12);
>>   }
>>   
>> +bool tdx_protected_guest_has(unsigned long flag)
>> +{
>> +	switch (flag) {
>> +	case PR_GUEST_MEM_ENCRYPT:
>> +	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
>> +	case PR_GUEST_UNROLL_STRING_IO:
>> +	case PR_GUEST_SHARED_MAPPING_INIT:
>> +	case PR_GUEST_TDX:
>> +		return static_cpu_has(X86_FEATURE_TDX_GUEST);
> 
> 		return cpu_feature_enabled(...)

I will use it in next version.

> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
