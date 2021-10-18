Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0652E4326C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 20:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhJRSoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 14:44:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:15902 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233213AbhJRSoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 14:44:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="228218391"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="228218391"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 11:42:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="443547705"
Received: from jkpeteho-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.7.230])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 11:42:08 -0700
Subject: Re: [PATCH v7 05/10] x86/tdx: Handle port I/O
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005204136.1812078-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87v91v2zkk.ffs@tglx> <eadc3025-a32d-3641-de83-e5f05728a755@linux.intel.com>
 <51511837-f712-35e2-fdb7-05a2c3f473cb@amd.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f66eec4b-fa80-fdce-9b9f-12ff6a3f4a6d@linux.intel.com>
Date:   Mon, 18 Oct 2021 11:42:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <51511837-f712-35e2-fdb7-05a2c3f473cb@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/18/21 6:52 AM, Tom Lendacky wrote:
> On 10/17/21 3:35 PM, Sathyanarayanan Kuppuswamy wrote:
>>
>> On 10/17/21 12:58 PM, Thomas Gleixner wrote:
>>> On Tue, Oct 05 2021 at 13:41, Kuppuswamy Sathyanarayanan wrote:
>>>> \
>>>>   static inline void outs##bwl(int port, const void *addr, unsigned 
>>>> long count) \
>>>>   {                                    \
>>>> -    if (sev_key_active()) {                        \
>>>> +    if (sev_key_active() ||                        \
>>>> +        cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {        \
>>> Instead of adding an extra check, can you please replace that
>>> sev_key_active() with cc_platform_has() completely?
>>
>> Yes. sev_key_active() can be removed and replaced with
>> cc_platform_has().
>>
>> Thomas Lendacky also proposed to introduce as common
>> static key which can be set by both AMD SEV and TDX code.
>>
>> @Thomas Lendacky, any comments?
>
> Either way works for me.
>
> For the cc_platform_has() path, you will need to update the 
> amd_cc_platform_has() to return true for 
> CC_ATTR_GUEST_UNROLL_STRING_IO for SEV only, i.e.:
>
>     case CC_ATTR_GUEST_UNROLL_STRING_IO:
>         return (sev_status & MSR_AMD64_SEV_ENABLED) &&
>                !(sev_status & MSR_AMD64_SEV_ES_ENABLED);

I will submit a separate cleanup patch to make SEV code use 
CC_ATTR_GUEST_UNROLL_STRING_IO
first. That way, in this patch I can just set 
CC_ATTR_GUEST_UNROLL_STRING_IO.

>
> Thanks,
> Tom

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

