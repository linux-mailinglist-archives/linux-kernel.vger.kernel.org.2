Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A0F42E70A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 05:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhJODFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 23:05:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:8262 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhJODFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 23:05:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="288705308"
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="288705308"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 20:03:08 -0700
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="571624023"
Received: from anmone-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.15.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 20:03:06 -0700
Subject: Re: [PATCH v10 08/11] x86/tdx: Wire up KVM hypercalls
To:     Thomas Gleixner <tglx@linutronix.de>,
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
 <20211009053747.1694419-9-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87ilxz7vq6.ffs@tglx>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <dd9ceec3-2ae4-c468-0a6a-de14965b65a2@linux.intel.com>
Date:   Thu, 14 Oct 2021 20:03:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87ilxz7vq6.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/14/21 3:21 AM, Thomas Gleixner wrote:
> On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>   
>>   #ifdef CONFIG_KVM_GUEST
>> @@ -32,6 +34,10 @@ static inline bool kvm_check_and_clear_guest_paused(void)
>>   static inline long kvm_hypercall0(unsigned int nr)
>>   {
>>   	long ret;
>> +
>> +	if (cc_platform_has(CC_ATTR_GUEST_TDX))
>> +		return tdx_kvm_hypercall(nr, 0, 0, 0, 0);
> So if TDX is not enabled in Kconfig this cannot be optimized out unless
> CC_PLATFORM is disabled as well. But what's worse is that every
> hypercall needs to call into cc_platform_has().
>
> None of the hypercalls is used before the early TDX detection. So we can
> simply use
>
>         if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>
> here, right? Then you add X86_FEATURE_TDX_GUEST to the disabled feature
> bits correctly and all of the above is solved.
>
> Hmm?


Make sense. Since this will only be used after tdx_early_init() call,
and X86_FEATURE_TDX_GUEST is also set in that call, we can just use
cpu_feature_enabled(X86_FEATURE_TDX_GUEST) as you have mentioned.

I will fix this in next version.

>   
>> +#if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
>> +static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
>> +				     unsigned long p2, unsigned long p3,
>> +				     unsigned long p4)
>> +{
>> +	struct tdx_hypercall_output out;
>> +	u64 err;
>> +
>> +	err = __tdx_hypercall(TDX_HYPERCALL_VENDOR_KVM, nr, p1, p2,
>> +			      p3, p4, &out);
>> +
>> +	/*
>> +	 * Non zero return value means buggy TDX module (which is fatal).
>> +	 * So use BUG_ON() to panic.
>> +	 */
>> +	BUG_ON(err);
>> +
>> +	return out.r10;
>> +}
> Can we make that a proper exported function (instead of
> tdx_kvm_hypercall) so we don't end up with the very same code inlined
> all over the place?


Initially it was an exported function. But we made it inline in tdx.h
to simplify the implementation. But if exported function is preferred,
I will fix it in next version.

>
> Thanks,
>
>          tglx
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

