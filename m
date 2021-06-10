Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74A33A355C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFJVEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:04:11 -0400
Received: from mga18.intel.com ([134.134.136.126]:6315 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhFJVEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:04:10 -0400
IronPort-SDR: vKLP2Ow0fAX9d62SqnnOqLbHeAmWmyfZYm83UXLTOIBC0KD19FtZAruyP+/ymhKdLNM8crV3XA
 s8kYpBgQHN4w==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="192716663"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="192716663"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 14:02:06 -0700
IronPort-SDR: lbmup0cC6XTkT/KNzijKds2JjYsdvUR6XV1oUqeJ9V4O88iqYA8L5gAaNl/0vIpStGqDc+qqMe
 TXjbdrESLk+g==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="486332906"
Received: from miishak-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.54.237])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 14:02:04 -0700
Subject: Re: [PATCH v1 04/11] x86/x86: Add is_tdx_guest() interface
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMJvNGyIaBItV9c6@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <3437ff11-4656-2c2a-ae58-04b77b6ff663@linux.intel.com>
Date:   Thu, 10 Jun 2021 14:01:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMJvNGyIaBItV9c6@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/21 12:59 PM, Borislav Petkov wrote:
> On Tue, Jun 01, 2021 at 07:21:29PM -0700, Kuppuswamy Sathyanarayanan wrote:

>> +	if (memcmp("IntelTDX    ", signature, 12))
>> +		return false;
>> +
>> +	return true;
> 
> As before,
> 
>   return !memcmp(...
> 
> and then that function can return simply an int.

I will make the above change in next version.

> 
> 
>> +}
>> +
>> +bool is_tdx_guest(void)
> 
> If anything, this should be early_is_tdx_guest().

If this is the recommendation, I am fine with it. It is
only used by __in/__out macros in decompression code.

> 
>> +{
>> +	if (tdx_guest < 0)
>> +		tdx_guest = native_cpuid_has_tdx_guest();
>> +
>> +	return !!tdx_guest;
>> +}
>> +
> 
> Applying: x86/x86: Add is_tdx_guest() interface
> .git/rebase-apply/patch:58: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.

I will fix it in next version.

> 
> 
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> index 5b14b72e41c5..5e70617e9877 100644
>> --- a/arch/x86/kernel/tdx.c
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -19,6 +19,12 @@ static inline bool cpuid_has_tdx_guest(void)
>>   	return true;
>>   }
>>   
>> +bool is_tdx_guest(void)
>> +{
>> +	return static_cpu_has(X86_FEATURE_TDX_GUEST);
>> +}
>> +EXPORT_SYMBOL_GPL(is_tdx_guest);
> 
> I don't like this is_tdx_guest() thing in kernel proper - what's wrong
> with
> 
>    prot_guest_has(PR_GUEST_TDX)

Is it alright to use vendor name in prot_guest_has() flag? I thought
we want to keep them generic. If this is acceptable, we can replace
is_tdx_guest() with prot_guest_has() calls. Currently it is not used
in many places.

> 
> ?
> 
> Also, why is it exported, for kvm?

Yes. It is used in exported KVM functions.

> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
