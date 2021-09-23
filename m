Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEDF416455
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbhIWR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:26:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:14424 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242288AbhIWRZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:25:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="223933241"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="223933241"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 10:24:26 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="551231224"
Received: from tbirrer-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.101.82])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 10:24:25 -0700
Subject: Re: [PATCH v6 05/10] x86/tdx: Handle port I/O
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210922225239.3501262-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <c2fa7839-49d5-3e1c-97c4-c1b77e11ef93@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <6cb4efa4-6f40-37f4-8807-e44b2c069021@linux.intel.com>
Date:   Thu, 23 Sep 2021 10:24:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c2fa7839-49d5-3e1c-97c4-c1b77e11ef93@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/21 9:32 AM, Tom Lendacky wrote:
> On 9/22/21 5:52 PM, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> TDX hypervisors cannot emulate instructions directly. This includes
>> port IO which is normally emulated in the hypervisor. All port IO
>> instructions inside TDX trigger the #VE exception in the guest and
>> would be normally emulated there.
>>
>> Also string I/O is not supported in TDX guest. So, unroll the string
>> I/O operation into a loop operating on one element at a time. This
>> method is similar to AMD SEV, so just extend the support for TDX guest
>> platform.
>>
>> Add a new confidential guest flag CC_ATTR_GUEST_UNROLL_STRING_IO to
>> add string unroll support in asm/io.h
>>
>> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>
>> Changes since v5:
>>   * Changed prot_guest_has() to cc_platform_has().
>>
>> Changes since v4:
>>   * Changed order of variable declaration in tdx_handle_io().
>>   * Changed tdg_* prefix with tdx_*.
>>
>> Changes since v3:
>>   * Included PATTR_GUEST_UNROLL_STRING_IO protected guest flag
>>     addition change in this patch.
>>   * Rebased on top of Tom Lendacks protected guest change.
>>
>> Changes since v2:
>>   * None
>>
>> Changes since v1:
>>   * Fixed comments for tdg_handle_io().
>>   * Used _tdx_hypercall() instead of __tdx_hypercall() in tdg_handle_io().
>>
>>   arch/x86/include/asm/io.h   |  7 +++++--
>>   arch/x86/kernel/cpu/intel.c |  1 +
>>   arch/x86/kernel/tdx.c       | 35 +++++++++++++++++++++++++++++++++++
>>   include/linux/cc_platform.h | 11 +++++++++++
>>   4 files changed, 52 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
>> index fa6aa43e5dc3..67e0c4a0a0f4 100644
>> --- a/arch/x86/include/asm/io.h
>> +++ b/arch/x86/include/asm/io.h
>> @@ -40,6 +40,7 @@
>>   #include <linux/string.h>
>>   #include <linux/compiler.h>
>> +#include <linux/cc_platform.h>
>>   #include <asm/page.h>
>>   #include <asm/tdx.h>
>>   #include <asm/early_ioremap.h>
>> @@ -310,7 +311,8 @@ static inline unsigned type in##bwl##_p(int port)            \
>>                                       \
>>   static inline void outs##bwl(int port, const void *addr, unsigned long count) \
>>   {                                    \
>> -    if (sev_key_active()) {                        \ > +    if (sev_key_active() 
>> ||                        \
>> +        cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {        \
> 
> Would it make sense to make sev_key_active() and sev_enable_key generic and just re-use those 
> instead of adding CC_ATTR_GUEST_UNROLL_STRING_IO and having multiple conditions here?
> 
> You can set the key in the TDX init routine just like SEV does.

Any reason for using sev_enable_key over CC attribute? IMO, CC attribute exist
to generalize the common feature code. My impression is SEV is specific to AMD
code.

> 
> Thanks,
> Tom
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
