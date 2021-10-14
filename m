Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25B742E08A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhJNRxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:53:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:23445 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232773AbhJNRxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:53:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="291233274"
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="291233274"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 10:31:52 -0700
X-IronPort-AV: E=Sophos;i="5.85,373,1624345200"; 
   d="scan'208";a="660072334"
Received: from gmbaker-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.17.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 10:31:50 -0700
Subject: Re: [PATCH v10 04/11] x86/tdx: Add TDX support to
 intel_cc_platform_has()
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
 <20211009053747.1694419-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87tuhk6pvr.ffs@tglx>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuwamy@linux.intel.com>
Message-ID: <9dcfed93-1bf3-a60a-85e4-df5626189b76@linux.intel.com>
Date:   Thu, 14 Oct 2021 10:31:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87tuhk6pvr.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/14/21 12:12 AM, Thomas Gleixner wrote:
> On Fri, Oct 08 2021 at 22:37, Kuppuswamy Sathyanarayanan wrote:
>>   
>> -static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
>> +static bool intel_cc_platform_has(enum cc_attr attr)
>>   {
>>   #ifdef CONFIG_INTEL_TDX_GUEST
>> -	return false;
>> +	switch (attr) {
>> +	case CC_ATTR_GUEST_TDX:
>> +		return is_tdx_guest();
> This function is only called when is_tdx_guest() is true. So
> is_tdx_guest() has to be called again to make sure?


Agree. In future, if intel_cc_platform_has() is used in non-tdx case then
we can add is_tdx_guest() back there. For now it is redundant
as you have mentioned. I will remove it in next version.

>
> Also the ifdeffery can just go away simply because the compiler will
> discard this function when CONFIG_INTEL_TDX_GUEST=n due to:
Agree. I will remove it.
>
>> +#ifdef CONFIG_INTEL_TDX_GUEST
>> +
>> +bool is_tdx_guest(void);
>> +void __init tdx_early_init(void);
>> +
>> +#else
>> +
>> +static inline bool is_tdx_guest(void) { return false; }
>> +static inline void tdx_early_init(void) { };
>> +
>> +#endif /* CONFIG_INTEL_TDX_GUEST */
> Thanks,
>
>          tglx

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

