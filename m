Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942683B68EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhF1TRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:17:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:58859 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236223AbhF1TRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:17:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="271875263"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="271875263"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 12:14:52 -0700
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="419284453"
Received: from maryafar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.184.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 12:14:51 -0700
Subject: Re: [PATCH v3 04/11] x86: Introduce generic protected guest
 abstraction
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9e188172-772c-8a33-46c0-e1e4bbf2668d@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4853f140-9406-6d94-1546-6545472f86da@linux.intel.com>
Date:   Mon, 28 Jun 2021 12:14:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9e188172-772c-8a33-46c0-e1e4bbf2668d@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/21 10:52 AM, Tom Lendacky wrote:
> On 6/18/21 5:57 PM, Kuppuswamy Sathyanarayanan wrote:
>> Add a generic way to check if we run with an encrypted guest,
>> without requiring x86 specific ifdefs. This can then be used in
>> non architecture specific code.
>>
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
>>
>>   arch/Kconfig                           |  3 +++
>>   arch/x86/Kconfig                       |  2 ++
>>   arch/x86/include/asm/protected_guest.h | 20 +++++++++++++++++
>>   arch/x86/include/asm/sev.h             |  3 +++
>>   arch/x86/include/asm/tdx.h             |  4 ++++
>>   arch/x86/kernel/sev.c                  | 17 +++++++++++++++
>>   arch/x86/kernel/tdx.c                  | 17 +++++++++++++++
>>   include/linux/protected_guest.h        | 30 ++++++++++++++++++++++++++
>>   8 files changed, 96 insertions(+)
>>   create mode 100644 arch/x86/include/asm/protected_guest.h
>>   create mode 100644 include/linux/protected_guest.h
>>

>> +static inline bool prot_guest_has(unsigned long flag)
>> +{
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>> +		return tdx_protected_guest_has(flag);
>> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> +		return sev_protected_guest_has(flag);
> 
> So as I think about this, I don't think this will work if the hypervisor
> decides to change the vendor name, right?

For TDX guest, vendor name cannot be changed. It is set by TDX module and
it is fixed as per TDX module spec.

> 
> And doesn't TDX supply "IntelTDX    " as a signature. I don't see where
> the signature is used to set the CPU vendor to X86_VENDOR_INTEL.

We don't need to specially handle it for TDX. Generic early_identify_cpu() will
set boot_cpu_data.x86_vendor as X86_VENDOR_INTEL for TDX guest. I think it is
based on Intel in vendor string.

> 
> The current SEV checks to set sev_status, which is used by sme_active(),
> sev_active, etc.) are based on the max leaf and CPUID bits, but not a
> CPUID vendor check.
> 

You also set x86_vendor id as AMD based on SEV checks?

> So maybe we can keep the prot_guest_has() but I think it will have to be a
> common routine, with a "switch" statement that has supporting case element
> that check for "sev_active() || static_cpu_has(X86_FEATURE_TDX_GUEST)", etc.

>>   }
>> +
>> +bool sev_protected_guest_has(unsigned long flag)
>> +{
>> +	switch (flag) {
>> +	case PR_GUEST_MEM_ENCRYPT:
>> +	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
>> +	case PR_GUEST_UNROLL_STRING_IO:
>> +	case PR_GUEST_HOST_MEM_ENCRYPT:
>> +		return true;
> 
> This will need to be fixed up because this function will be called for
> baremetal and legacy guests and those properties aren't true for those
> situations. Something like (although I'm unsure of the difference between
> PR_GUEST_MEM_ENCRYPT and PR_GUEST_MEM_ENCRYPT_ACTIVE):

MEM_ENCRYPT_ACTIVE is suggested for mem_encrypt_active() case (I think it
means some sort of encryption is active).

PR_GUEST_MEM_ENCRYPT means guest supports memory encryption (sev_active()
case).

Yes, I can include following changes in next version.

> 
> 	case PR_GUEST_MEM_ENCRYPT:
> 	case PR_GUEST_MEM_ENCRYPT_ACTIVE:
> 		return sev_active();
> 	case PR_GUEST_UNROLL_STRING_IO:
> 		return sev_active() && !sev_es_active();
> 	case PR_GUEST_HOST_MEM_ENCRYPT:
> 		return sme_active();
> 
> But you (or I) would have to audit all of the locations where
> mem_encrypt_active(), sme_active(), sev_active() and sev_es_active() are
> used, to be sure the right thing is being done. And for bisectability,
> that should probably be the first patch if you will be invoking
> prot_guest_has() in the same location as any of the identified functions.
> 
> Create the new helper and fixup the locations should be one (or more)
> patches. Then add the TDX support to the helper function as a follow-on patch.

Can you submit a patch to replace all existing uses cases of mem_encrypt_active()
,sme_active(), sev_active() and sev_es_active() with prot_guest_has() calls? Since
I cannot test any of these changes for AMD, it would be better if you could do it.

Once you submit a tested version, I can enable these features for TDX and test
and submit it separately.

This patch can be split as below:

1. x86: Introduce generic protected guest abstraction patch (with below changes).
    - Remove all PR_GUEST flags in sev_protected_guest_has() and
      tdx_protected_guest_has().
2. Patch from you to use prot_guest_has() for AMD code and enable relevant
    PR_GUEST flags in sev_protected_guest_has().
3. Patch from me to us prot_guest_has() for TDX cases and enable relevant
    PR_GUEST flags in tdx_protected_guest_has().

Agree?


>> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
>> new file mode 100644
>> index 000000000000..c5b7547e5a68
>> --- /dev/null
>> +++ b/include/linux/protected_guest.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef _LINUX_PROTECTED_GUEST_H
>> +#define _LINUX_PROTECTED_GUEST_H 1
>> +
>> +/* Protected Guest Feature Flags (leave 0-0xfff for vendor specific flags) */
>> +
>> +/* 0-ff is reserved for Intel specific flags */
>> +#define PR_GUEST_TDX				0x0000
>> +
>> +/* 100-1ff is reserved for AMD specific flags */
>> +#define PR_GUEST_SEV				0x0100
>> +
>> +/* Support for guest encryption */
>> +#define PR_GUEST_MEM_ENCRYPT			0x1000
> 
> I'm not sure I follow the difference between this and
> PR_GUEST_MEM_ENCRYPT_ACTIVE. Is this saying that the host has support for
> starting guests that support memory encryption or the guest has support
> for memory encryption but it hasn't been activated yet (which doesn't seem
> possible)?

Explained it above.

> 
> Thanks,
> Tom
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
