Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CF138BA55
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 01:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhETXP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 19:15:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:11819 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231723AbhETXP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 19:15:57 -0400
IronPort-SDR: aHcAbBc+YnjVvII32KtTyvYHJUCV0ktm5S30TXpeOG94M4X+KQGVeNVkR68RuVG7OiXETmU77A
 4BzfVgM0/bQg==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="265272089"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="265272089"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 16:14:35 -0700
IronPort-SDR: 0s/YPUC0wGoJLHUokxSnH9utBjHkoOxXO6q7PwKYyA6zVoAdtV+R9P335J+Q6qAGO7Ten5I7sf
 Gr1SKVmojsGQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440654994"
Received: from shaunnab-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.65.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 16:14:34 -0700
Subject: Re: [RFC v2 29/32] x86/tdx: Add helper to do MapGPA TDVMALL
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <7d43f57c3b178a905ef2505cef5313844c497984.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d139d180-9be7-3f7e-22db-d39fd09dfcb5@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <57690b33-e7da-e345-dfae-b2e18f9a1467@linux.intel.com>
Date:   Thu, 20 May 2021 16:14:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d139d180-9be7-3f7e-22db-d39fd09dfcb5@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/21 8:59 AM, Dave Hansen wrote:
> On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> MapGPA TDVMCALL requests the host VMM to map a GPA range as private or
>> shared memory mappings. Shared GPA mappings can be used for
>> communication beteen TD guest and host VMM, for example for
>> paravirtualized IO.
> 
> As usual, I hate the changelog.  This appears to just be regurgitating
> the spec.
> 
> Is this just for part of converting an existing mapping between private
> and shared?  If so, please say that.
> 

How about following change?

     x86/tdx: Add helper to do MapGPA hypercall

     MapGPA hypercall is used by TDX guests to request VMM convert
     the existing mapping of given GPA address range between
     private/shared.

     tdx_hcall_gpa_intent() is the wrapper used for making MapGPA
     hypercall.


>> The new helper tdx_map_gpa() provides access to the operation.
> 
> <sigh>  You got your own name wrong. It's tdg_map_gpa() in the patch.

I can use tdx_hcall_gpa_intent().

> 
> BTW, I agree with Sean on this one: "tdg" is a horrible prefix.  You
> just proved Sean's point by mistyping it.  *EVERYONE* is going to rpeat
> that mistake: tdg -> tdx.
> 
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> index dc80cf7f7d08..4789798d7737 100644
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -7,6 +7,11 @@
>>   
>>   #ifndef __ASSEMBLY__
>>   
>> +enum tdx_map_type {
>> +	TDX_MAP_PRIVATE,
>> +	TDX_MAP_SHARED,
>> +};
> 
> I like the enum, but please call out that this is a software construct,
> not a part of any hardware or VMM ABI.
> 
>>   #ifdef CONFIG_INTEL_TDX_GUEST
>>   
>>   #include <asm/cpufeature.h>
>> @@ -112,6 +117,8 @@ unsigned short tdg_inw(unsigned short port);
>>   unsigned int tdg_inl(unsigned short port);
>>   
>>   extern phys_addr_t tdg_shared_mask(void);
>> +extern int tdg_map_gpa(phys_addr_t gpa, int numpages,
>> +		       enum tdx_map_type map_type);
>>   
>>   #else // !CONFIG_INTEL_TDX_GUEST
>>   
>> @@ -155,6 +162,12 @@ static inline phys_addr_t tdg_shared_mask(void)
>>   {
>>   	return 0;
>>   }
>> +
>> +static inline int tdg_map_gpa(phys_addr_t gpa, int numpages,
>> +			      enum tdx_map_type map_type)
>> +{
>> +	return -ENODEV;
>> +}
> 
> FWIW, you could probably get away with just inlining tdg_map_gpa():
> 
> static inline int tdg_map_gpa(phys_addr_t gpa, int numpages, ...
> {
> 	u64 ret;
> 
> 	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
> 		return -ENODEV;
> 
> 	if (map_type == TDX_MAP_SHARED)
> 		gpa |= tdg_shared_mask();
> 
> 	ret = tdvmcall(TDVMCALL_MAP_GPA, gpa, ...
> 
> 	return ret ? -EIO : 0;
> }
> 
> Then you don't have three copies of the function signature that can get
> out of sync.

I agree that this simplifies the function definition. But, there are
other TDX hypercalls definitions in tdx.c. I can't move all of them to
the header file. If possible, I would like to group all hypercalls in
the same place.

Also, IMO, it is better to hide hypercall internal implementation details
in C file. For example, user of MapGPA hypercall does not care about the
TDVMCALL_MAP_GPA leaf id value. If we inline this function we have to
move such details to header file.


> 
>>   #endif /* CONFIG_INTEL_TDX_GUEST */
>>   #endif /* __ASSEMBLY__ */
>>   #endif /* _ASM_X86_TDX_H */
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> index 7e391cd7aa2b..074136473011 100644
>> --- a/arch/x86/kernel/tdx.c
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -15,6 +15,8 @@
>>   #include "tdx-kvm.c"
>>   #endif
>>   
>> +#define TDVMCALL_MAP_GPA	0x10001
>> +
>>   static struct {
>>   	unsigned int gpa_width;
>>   	unsigned long attributes;
>> @@ -98,6 +100,17 @@ static void tdg_get_info(void)
>>   	physical_mask &= ~tdg_shared_mask();
>>   }
>>   
>> +int tdg_map_gpa(phys_addr_t gpa, int numpages, enum tdx_map_type map_type)
>> +{
>> +	u64 ret;
>> +
>> +	if (map_type == TDX_MAP_SHARED)
>> +		gpa |= tdg_shared_mask();
>> +
>> +	ret = tdvmcall(TDVMCALL_MAP_GPA, gpa, PAGE_SIZE * numpages, 0, 0);
>> +	return ret ? -EIO : 0;
>> +}
> 
> The naming Intel chose here is nasty.  This doesn't "map" anything.  It
> modifies an existing mapping from what I can tell.  We could name it
> much better than the spec, perhaps:
> 
> 	tdx_hcall_gpa_intent()

I will use this function name in next version.

> 
> BTW, all of these hypercalls need a consistent prefix.

I can include _hcall in other hypercall helper functions as well.

> 
> It also needs a comment:
> 
> 	/*
> 	 * Inform the VMM of the guest's intent for this physical page:
> 	 * shared with the VMM or private to the guest.  The VMM is
> 	 * expected to change its mapping of the page in response.
> 	 *
> 	 * Note: shared->private conversions require further guest
> 	 * action to accept the page.
> 	 */
> 
> The intent here is important.  It makes it clear that this function
> really only plays a role in the conversion process.

Thanks. I will include it in next version.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
