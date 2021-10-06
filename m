Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FC642418A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbhJFPpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:45:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:23453 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhJFPpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:45:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="206833843"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="206833843"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 08:43:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="589806021"
Received: from ptcotton-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.211.164])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 08:43:50 -0700
Subject: Re: [PATCH v8 03/11] x86/cpufeatures: Add TDX Guest CPU feature
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
 <YV3AKekdJU0vsbaN@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <328cc0e7-89e7-a1b2-f798-fe758c2c1f4e@linux.intel.com>
Date:   Wed, 6 Oct 2021 08:43:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YV3AKekdJU0vsbaN@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 8:26 AM, Borislav Petkov wrote:
> On Mon, Oct 04, 2021 at 07:51:57PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> new file mode 100644
>> index 000000000000..ad3ff5925153
>> --- /dev/null
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -0,0 +1,40 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2020 Intel Corporation */
>> +
>> +#undef pr_fmt
>> +#define pr_fmt(fmt)     "tdx: " fmt
>> +
>> +#include <asm/tdx.h>
>> +
>> +/*
>> + * Allocate it in the data region to avoid zeroing it during
>> + * BSS initialization. It is mainly used in cc_platform_has()
>> + * call during early boot call.
>> + */
>> +u64 __section(".data") is_tdx_guest = 0;
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
>> -- 
> 
> What I meant was this (untested of course).
> 
> is_tdx_guest() is the accessor external code queries and you cache the
> detected value in tdx_guest so that the one after the first one is
> cheap.

Yes. But, Joerg Roedel in his review recommended using variable
similar to sme_me_mask to avoid function call in Intel platform in
cc_platform_has().

"
This causes a function call on every Intel machine this code runs. is
there an easier to check whether TDX is enabled, like the sme_me_mask
check on AMD?
"

That's why I have introduced is_tdx_guest global variable in this
version.


> 
> /*
>   * Allocate it in the data region to avoid zeroing it during
>   * BSS initialization. It is mainly used in cc_platform_has()
>   * call during early boot call.
>   *
>   * States whether the kernel is running as a TDX guest.
>   */
> static int tdx_guest __ro_after_init = -1;
> 
> bool is_tdx_guest(void)
> {
> 	u32 eax, sig[3];
> 
> 	if (tdx_guest >= 0)
> 		return tdx_guest;
> 
> 	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID) {
> 		tdx_guest = 0;
> 		return false;
> 	}
> 
> 	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2], &sig[1]);
> 
> 	tdx_guest = !memcmp("IntelTDX    ", sig, 12);
> 
> 	return tdx_guest;
> }
> 
> void __init tdx_early_init(void)
> {
> 	if (!is_tdx_guest())
> 		return;
> 
> 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> 
> 	pr_info("Guest initialized\n");
> }
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
