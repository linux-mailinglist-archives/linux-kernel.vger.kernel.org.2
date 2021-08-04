Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81CB3E0A51
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 00:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhHDW0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 18:26:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:15091 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhHDW0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 18:26:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="214054940"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="214054940"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 15:26:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="512253267"
Received: from bguvendi-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.99.93])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 15:26:15 -0700
Subject: Re: [PATCH v5 04/12] x86/tdx: Add protected guest support for TDX
 guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQsNpG55v7dhFqIb@google.com>
 <9c576f24-e6de-f816-623d-408a4a2ae747@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4f28fe6e-a8ce-e444-51db-d0eb564eca8f@linux.intel.com>
Date:   Wed, 4 Aug 2021 15:26:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9c576f24-e6de-f816-623d-408a4a2ae747@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/21 3:03 PM, Dave Hansen wrote:
>>> +#include <asm/processor.h>
>>> +#include <asm/tdx.h>
>>> +
>>>   #ifndef __ASSEMBLY__
>>>   
>>>   static inline bool prot_guest_has(unsigned int attr)
>>>   {
>>>   	if (sme_me_mask)
>>>   		return amd_prot_guest_has(attr);
>>> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>> Why not "boot_cpu_has(X86_FEATURE_TDX_GUEST)"?
> Even better: cpu_feature_enabled(X86_FEATURE_TDX_GUEST).  That gets you
> both static patching*and*  compile-time optimization if you hook
> X86_FEATURE_TDX_GUEST into disabled-features.h.

This is how Borislav preferred it. tdx_prot_guest_has() internally uses
cpu_feature_enabled(X86_FEATURE_TDX_GUEST) to return the status.

I think the intention is to keep the first call generic (non TDX
specific). So that it can be extended for other use cases.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
