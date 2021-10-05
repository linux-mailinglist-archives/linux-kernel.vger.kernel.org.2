Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEF04232F2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhJEVna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:43:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:40342 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235957AbhJEVn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:43:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="225806202"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="225806202"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 14:41:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="477861491"
Received: from rriesen-ivm.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.35.74])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 14:41:37 -0700
Subject: Re: [PATCH v8 03/11] x86/cpufeatures: Add TDX Guest CPU feature
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
 <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005210423.yfftpxxmj3cjprtv@treble>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <15a07997-2659-6be1-b8a3-da57e72562b5@linux.intel.com>
Date:   Tue, 5 Oct 2021 14:41:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005210423.yfftpxxmj3cjprtv@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/21 2:04 PM, Josh Poimboeuf wrote:
> On Mon, Oct 04, 2021 at 07:51:57PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> @@ -495,6 +496,13 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
>>   
>>   	copy_bootdata(__va(real_mode_data));
>>   
>> +	/*
>> +	 * tdx_early_init() has dependency on command line parameters.
>> +	 * So the order of calling it should be after copy_bootdata()
>> +	 * (in which command line parameter is initialized).
>> +	 */
>> +	tdx_early_init();
> 
> Which cmdline parameters are those?

We have few debug command line options like tdx_forced (force TDX
initialization) and tdx_disable_filter (Disables TDX device filter
support). Support for these options have not been posted out (waiting
to merge the initial support patches first). Since we need to access
command line options, we want to follow the above calling order.

> 
>> +/*
>> + * Allocate it in the data region to avoid zeroing it during
>> + * BSS initialization. It is mainly used in cc_platform_has()
>> + * call during early boot call.
>> + */
>> +u64 __section(".data") is_tdx_guest = 0;
> 
> Or you could just give it a -1 value here to avoid the section
> annotation.  Not sure why it needs 64 bits, any reason it can't just be
> bool?

It can be bool. I can fix this in next version.

> 
>> +
>> +static void __init is_tdx_guest_init(void)
>> +{
>> +	u32 eax, sig[3];
>> +
>> +	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID) {
>> +		is_tdx_guest = 0;
>> +		return;
>> +	}
>> +
>> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2], &sig[1]);
>> +
>> +	is_tdx_guest = !memcmp("IntelTDX    ", sig, 12);
>> +}
>> +
>> +void __init tdx_early_init(void)
>> +{
>> +	is_tdx_guest_init();
>> +
>> +	if (!is_tdx_guest)
>> +		return;
>> +
>> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>> +
>> +	pr_info("Guest initialized\n");
>> +}
> 
> What's the point of having both 'is_tdx_guest' and
> X86_FEATURE_TDX_GUEST?  Are they not redundant?

is_tdx_guest was mainly introduced to support cc_platform_has()
API in early boot calls (similar to sme_me_mask in AMD code).
Regarding FEATURE flag it will be useful for userspace tools to
check the TDX feature support.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
