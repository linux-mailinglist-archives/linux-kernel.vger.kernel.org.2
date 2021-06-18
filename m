Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E83AD29E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 21:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbhFRTQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 15:16:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:56334 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234373AbhFRTQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 15:16:30 -0400
IronPort-SDR: lHar69czcFMeiP9jkBKeEu3a5gF4nagOIjuX2eXfNUnbztRu256lzRMaxsRqSi6ufB1RhqM69v
 GaMVXbU+mDuA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="186300890"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="186300890"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 12:14:19 -0700
IronPort-SDR: PwujYWixwF0gYHwXquNyDtZah+9gdAcwgYWQdqQO0UwRZKMtulYf/G8xtjS3zo6KHK3WMwM0Cv
 UjklOXyePiUQ==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="451496009"
Received: from msayeed-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.172.5])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 12:14:18 -0700
Subject: Re: [PATCH v2 04/12] x86/x86: Add early_is_tdx_guest() interface
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
References: <YMJ/IrBZiCsNMtvO@zn.tnic>
 <20210612210445.2164948-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMuAvP7bqwHVSCw8@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <76e177b6-7666-bc8f-a00a-c6206578d566@linux.intel.com>
Date:   Fri, 18 Jun 2021 12:14:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMuAvP7bqwHVSCw8@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/21 10:05 AM, Borislav Petkov wrote:
> On Sat, Jun 12, 2021 at 02:04:45PM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
>> Subject: Re: [PATCH v2 04/12] x86/x86: Add early_is_tdx_guest() interface
> 
> Subject prefix should be "x86/tdx:" ofc.

I will fix this in next version.

> 
>> diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
>> new file mode 100644
>> index 000000000000..ddfa4a6d1939
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/tdx.c
>> @@ -0,0 +1,28 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * tdx.c - Early boot code for TDX
>> + */
>> +
>> +#include <asm/tdx.h>
> 
> Please no kernel proper includes in the decompressor stage - that thing
> is an include hell mess and needs cleaning up. Use cpuid_count() from
> arch/x86/boot/cpuflags.c by exporting it properly and add the other
> defines here instead of using kernel proper facilities.
> 
> I know, I know, there is other misuse but it has to stop.

I will re-use cpuid_count() from cpuflags.c. But it is missing definition
for cpuid_eax(0). So, I will have to define a new function to handle it.
Hope its alright with you.

> 
>> +static int __ro_after_init tdx_guest = -1;
>> +
>> +static inline bool native_cpuid_has_tdx_guest(void)
> 
> Why is this function prefixed with "native_"?
> 
>> +{
>> +	u32 eax = TDX_CPUID_LEAF_ID, sig[3] = {0};
>> +
>> +	if (native_cpuid_eax(0) < TDX_CPUID_LEAF_ID)
>> +		return false;
>> +
>> +	native_cpuid(&eax, &sig[0], &sig[1], &sig[2]);
>> +
>> +	return !memcmp("IntelTDX    ", sig, 12);
>> +}
>> +
>> +bool early_is_tdx_guest(void)
> 
> So I guess this is going to be used somewhere, because I don't see it.
> Or is it going away in favor of prot_guest_has(PR_GUEST_TDX) ?

It is used for handling TDX specific I/O support in decompressor code.

You can find its usage in https://lore.kernel.org/patchwork/patch/1444186/

May be I should move this patch next to that patch for easy reading.

> 
> This is the problem with sending new versions of patches as a reply to
> the old ones in the patchset: I get confused. Why don't you wait until
> the whole thing has been reviewed and then send a new revision which has
> all the changes and I can find my way in the context?
> 
> And with the amount of changes so far, you should probably send a new
> revision of the initial support set now-ish instead of me reviewing this
> one 'til the end.

I will send the new series with review fixes. Also, since this patch is only
used by I/O support code, I will move this patch to another TDX series which
adds TDX I/O support.

> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
