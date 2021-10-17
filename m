Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94D2430664
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 05:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbhJQDvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 23:51:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:48420 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhJQDvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 23:51:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10139"; a="227971757"
X-IronPort-AV: E=Sophos;i="5.85,379,1624345200"; 
   d="scan'208";a="227971757"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2021 20:49:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,379,1624345200"; 
   d="scan'208";a="443010955"
Received: from bberndt-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.12.149])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2021 20:49:36 -0700
Subject: Re: [PATCH v10 06/11] x86/traps: Add #VE support for TDX guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Cc:     Peter H Anvin <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009053747.1694419-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87o87s6mb7.ffs@tglx> <58ed8d10-f95e-b8d6-da42-94cf23c552eb@linux.intel.com>
 <33203617-eeea-1fc6-0f05-c216eeaf427d@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <a0f64809-d85f-e67f-4938-760db1946b68@linux.intel.com>
Date:   Sat, 16 Oct 2021 20:49:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <33203617-eeea-1fc6-0f05-c216eeaf427d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/16/21 8:18 PM, Dave Hansen wrote:
> On 10/16/21 7:45 PM, Sathyanarayanan Kuppuswamy wrote:
>>>> +bool tdx_get_ve_info(struct ve_info *ve)
>>>> +{
>>>> +    struct tdx_module_output out;
>>>> +    u64 ret;
>>>> +
>>>> +    if (!ve)
>>>> +        return false;
>>> This should be WARN_ON_ONCE() if at all.
>> This is an input validation. Since we need to de-reference "ve" in
>> the following code, we want to validate it to avoid NULL pointer
>> exception. As per current usage of this function, "ve" will not be
>> NULL. But we have added this check as a extra precaution against
>> future use cases.
> Input validation, eh?
>
> It's one thing if this argument comes from userspace, or is even open
> for modules to call.  You *might* have an argument that it should be
> checked in case something in the kernel goes insane.
>
> But, there's a single call site.  It looks like this:


As per current use cases (exc_virtualization_exception() &
tdx_early_handle_ve()), it will never happen. As I have mentioned,
it was added as a precaution against the future use case or any
misuse of this function in kernel. We did not have this check
initially. But was added later due to review suggestion.

But I am fine with removing it if it is required.

>
>> +DEFINE_IDTENTRY(exc_virtualization_exception)
>> +{
>> +	struct ve_info ve;
> ...
>> +	ret = tdx_get_ve_info(&ve);
> Could you please explain, given the existing kernel code, how !ve could
> ever possibly happen?  Or, how tdx_get_ve_info() might conceivably ever
> be called from another path which is not extremely well controlled?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

