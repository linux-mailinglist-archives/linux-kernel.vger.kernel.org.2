Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99C93A2E28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhFJOaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:30:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:9167 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhFJOaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:30:20 -0400
IronPort-SDR: tkhPH+rJUjjD4LSsZY63jeEWIIguvZ4iXGISvn1dvHDaHHTBAsaSf8MsoWCddsYcMg9tJGFY7Y
 yzlwi25w7I/g==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185681550"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="185681550"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 07:28:23 -0700
IronPort-SDR: gdc1JaUk+mCc0rIKGlnNP14h0p2dIsyA9q02fnA1I17kllGCJiLAtmM73ByHbSw9KmcScjf4wu
 Yjie9lZQZmmw==
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="486191404"
Received: from miishak-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.54.237])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 07:28:22 -0700
Subject: Re: [PATCH v1 03/11] x86/cpufeatures: Add TDX Guest CPU feature
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMIFVh9WpDiUuRsa@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0e19b754-1903-45bf-0d81-470e1e656337@linux.intel.com>
Date:   Thu, 10 Jun 2021 07:28:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMIFVh9WpDiUuRsa@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/10/21 5:28 AM, Borislav Petkov wrote:
> On Tue, Jun 01, 2021 at 07:21:28PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Add CPU feature detection for Trusted Domain Extensions support.
>> TDX feature adds capabilities to keep guest register state and
>> memory isolated from hypervisor.
>>
>> For TDX guest platforms, executing CPUID(0x21, 0) will return
> 
> I'm assuming that 0 is ECX?

Correct. I will clarify it in commit log.

> 
>> following values in EAX, EBX, ECX and EDX.
>>
>> EAX:  Maximum sub-leaf number:  0
>> EBX/EDX/ECX:  Vendor string:
>>
>> EBX =  "Inte"
>> EDX =  "lTDX"
>> ECX =  "    "
>>
>> So when above condition is true, set X86_FEATURE_TDX_GUEST
>> feature cap bit
> 		 ^
> 		 Fullstop.

Will fix it in next version.

> 
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index ac37830ae941..dddc3a27cc8a 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -238,6 +238,7 @@
>>   #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
>>   #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* "" PV unlock function */
>>   #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* "" PV vcpu_is_preempted function */
>> +#define X86_FEATURE_TDX_GUEST		( 8*32+22) /* Trusted Domain Extensions Guest */
> 
> What's the name of the feature bit? "TDX guest"? Why not only
> X86_FEATURE_TDX and then you can have "tdx" in cpuinfo?

Make sense. I can change it to "TDX". I guess we will not a feature bit
for "tdx host"

> 
>>   
>>   /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
>>   #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> new file mode 100644
>> index 000000000000..679500e807f3
>> --- /dev/null
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2020 Intel Corporation */
>> +#ifndef _ASM_X86_TDX_H
>> +#define _ASM_X86_TDX_H
>> +
>> +#define TDX_CPUID_LEAF_ID	0x21
>> +
>> +#ifdef CONFIG_INTEL_TDX_GUEST
>> +
>> +#include <asm/cpufeature.h>
> 
> As before - put the include at the top.

I will change it.

> 
>> +void __init tdx_early_init(void);
>> +
>> +#else // !CONFIG_INTEL_TDX_GUEST
> 
> No need for that // - comment

I will remove it in next version.

> 
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> new file mode 100644
>> index 000000000000..5b14b72e41c5
>> --- /dev/null
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2020 Intel Corporation */
>> +
>> +#include <asm/tdx.h>
>> +
>> +static inline bool cpuid_has_tdx_guest(void)
>> +{
>> +	u32 eax, signature[3];
> 
> Shorten that array name to "sig" so that you don't have to break the
> cpuid_count() line below.

I will fix it in next version.

> 
>> +
>> +	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID)
>> +		return false;
>> +
>> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &signature[0],
>> +		    &signature[1], &signature[2]);
>> +
>> +	if (memcmp("IntelTDX    ", signature, 12))
>> +		return false;
>> +
>> +	return true;
> 
> or simply:
> 
> return !memcmp(...

Got it. I will change it in next version.

> 
>> +}
>> +
>> +void __init tdx_early_init(void)
>> +{
>> +	if (!cpuid_has_tdx_guest())
>> +		return;
>> +
>> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>> +
>> +	pr_info("TDX guest is initialized\n");
> 
> Use pr_fmt in this file:
> 
> #undef pr_fmt
> #define pr_fmt(fmt)     "x86/tdx: " fmt
> 
> and then do
> 
> 	pr_info("Guest initialized\n");

Patch titled "x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions" add
it. It makes sense to move it to this patch.

> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
