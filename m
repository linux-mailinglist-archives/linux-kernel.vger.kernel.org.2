Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C705C42CC80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhJMVHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:07:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:45239 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhJMVHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:07:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="224987347"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="224987347"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 14:05:44 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="487055366"
Received: from dravindr-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.11.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 14:05:42 -0700
Subject: Re: [PATCH v10 03/11] x86/cpufeatures: Add TDX Guest CPU feature
To:     Thomas Gleixner <tglx@linutronix.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
 <20211009053747.1694419-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87ee8o8xje.ffs@tglx>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuwamy@linux.intel.com>
Message-ID: <47e707a2-9737-c518-9140-e495d60aed37@linux.intel.com>
Date:   Wed, 13 Oct 2021 14:05:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87ee8o8xje.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/21 1:44 PM, Thomas Gleixner wrote:
> On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
>> +
>> +bool is_tdx_guest(void)
>> +{
>> +	static int tdx_guest = -1;
>> +	u32 eax, sig[3];
>> +
>> +	if (tdx_guest >= 0)
>> +		goto done;
>> +
>> +	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID) {
>> +		tdx_guest = 0;
>> +		goto done;
>> +	}
>> +
>> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2], &sig[1]);
>> +
>> +	tdx_guest = !memcmp("IntelTDX    ", sig, 12);
>> +
>> +done:
>> +	return !!tdx_guest;
>> +}
> No. This is tasteless garbage, really.
>
> tdx_early_init() is invoked from x86_64_start_kernel() very early in the
> boot process __before__ is_tdx_guest() is invoked.
>
> So why on earth is it requried to keep those conditionals and cpuid()
> muck around after init?

is_tdx_guest() is also used by cc_platform_has() API. Please check
the following patch [1]. cc_platform_has() will be called much earlier
than x86_64_start_kernel() (like __startup_64() [2]).

[1] - 
https://lore.kernel.org/lkml/20211009053747.1694419-5-sathyanarayanan.kuppuswamy@linux.intel.com/
[2] - 
https://lore.kernel.org/lkml/46a18427dc4e9dda985b10e472965e3e4c769f1d.1631141919.git.thomas.lendacky@amd.com/

>
>> +void __init tdx_early_init(void)
>> +{
>> +	if (!is_tdx_guest())
>> +		return;
>> +
>> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>> +
>> +	pr_info("Guest initialized\n");
>> +}
> What's wrong with:
>
> static bool tdx_guest_detected __ro_after_init;
>
> void __init tdx_early_init(void)
> {
> 	u32 eax, sig[3];
>
> 	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID)
>          	return;
>
>          cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
>
>          if (memcmp("IntelTDX    ", sig, 12))
>          	return;
>
>          tdx_guest_detected = true;
> 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>
> 	pr_info("Guest initialized\n");
> }
>
> bool is_tdx_guest(void)
> {
>          return tdx_guest_detected;
> }
>
> That's simple and obvious and discards all the detection gunk completely
> after init and uses the proper data type, right?
>
> Thanks,
>
>          tglx

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

