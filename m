Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CEC38B64F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhETSuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:50:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:46211 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234105AbhETSuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:50:11 -0400
IronPort-SDR: mmMPOtKRPD8Wm/k1a7eoh7kIjwQpvPB/6T/z/51uNnkAefpdYY8Lp0kLvy7Ci/GXSMPQjAtVdg
 EWS0WJXBcGYA==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="286838282"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286838282"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 11:48:49 -0700
IronPort-SDR: WbWaU5TLD3FyL+CJqSeN5WhaP1OMBVIiu91o5KOwMiq/1izBNJ4ow/UpN5u/2pBaw3ZQklTQLw
 7o51VdIfEvSw==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="440576557"
Received: from shaunnab-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.65.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 11:48:47 -0700
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
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
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0df80c0f-e0da-e86e-0ab8-abc58f0da559@linux.intel.com>
Date:   Thu, 20 May 2021 11:48:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 5/19/21 9:14 AM, Dave Hansen wrote:
> On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> tdx_shared_mask() returns the mask that has to be set in a page
>> table entry to make page shared with VMM.
> 
> Here's a rewrite:
> 
> Just like MKTME, TDX reassigns bits of the physical address for
> metadata.  MKTME used several bits for an encryption KeyID.  TDX uses a
> single bit in guests to communicate whether a physical page should be
> protected by TDX as private memory (bit set to 0) or unprotected and
> shared with the VMM (bit set to 1).
> 
> Add a helper, tdg_shared_mask() (bad name please fix it) to generate the

Initially we have used tdx_* prefix for the guest code. But when the code from
host side got merged together, we came across many name conflicts. So to
avoid such issues in future, we were asked not to use the "tdx_" prefix and
our alternative choice was "tdg_".

Also, IMO, "tdg" prefix is more meaningful for guest code (Trusted Domain Guest)
compared to "tdx" (Trusted Domain eXtensions). I know that it gets confusing
when grepping for TDX related changes. But since these functions are only used
inside arch/x86 it should not be too confusing.

Even if rename is requested, IMO, it is easier to do it in one patch over
making changes in all the patches. So if it is required, we can do it later
once these initial patches were merged.

> mask.  The processor enumerates its physical address width to include
> the shared bit, which means it gets included in __PHYSICAL_MASK by default.
> 
> Remove the shared mask from 'physical_mask' since any bits in
> tdg_shared_mask() are not used for physical addresses in page table entries.
> 
> --

Thanks. I will include it in next version.

> 
> BTW, do you find it confusing that the subject says: '__PHYSICAL_MASK'
> and yet the code only modifies 'physical_mask'?
> 
>> Also, note that we cannot club shared mapping configuration between
>> AMD SME and Intel TDX Guest platforms in common function. SME has
>> to do it very early in __startup_64() as it sets the bit on all
>> memory, except what is used for communication. TDX can postpone as
>> we don't need any shared mapping in very early boot.
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   arch/x86/Kconfig           | 1 +
>>   arch/x86/include/asm/tdx.h | 6 ++++++
>>   arch/x86/kernel/tdx.c      | 9 +++++++++
>>   3 files changed, 16 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 67f99bf27729..5f92e8205de2 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -882,6 +882,7 @@ config INTEL_TDX_GUEST
>>   	select PARAVIRT_XL
>>   	select X86_X2APIC
>>   	select SECURITY_LOCKDOWN_LSM
>> +	select X86_MEM_ENCRYPT_COMMON
>>   	help
>>   	  Provide support for running in a trusted domain on Intel processors
>>   	  equipped with Trusted Domain eXtenstions. TDX is an new Intel
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> index b972c6531a53..dc80cf7f7d08 100644
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -111,6 +111,8 @@ unsigned char tdg_inb(unsigned short port);
>>   unsigned short tdg_inw(unsigned short port);
>>   unsigned int tdg_inl(unsigned short port);
>>   
>> +extern phys_addr_t tdg_shared_mask(void);
>> +
>>   #else // !CONFIG_INTEL_TDX_GUEST
>>   
>>   static inline bool is_tdx_guest(void)
>> @@ -149,6 +151,10 @@ static inline long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1,
>>   	return -ENODEV;
>>   }
>>   
>> +static inline phys_addr_t tdg_shared_mask(void)
>> +{
>> +	return 0;
>> +}
>>   #endif /* CONFIG_INTEL_TDX_GUEST */
>>   #endif /* __ASSEMBLY__ */
>>   #endif /* _ASM_X86_TDX_H */
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> index 1f1bb98e1d38..7e391cd7aa2b 100644
>> --- a/arch/x86/kernel/tdx.c
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -76,6 +76,12 @@ bool is_tdx_guest(void)
>>   }
>>   EXPORT_SYMBOL_GPL(is_tdx_guest);
>>   
>> +/* The highest bit of a guest physical address is the "sharing" bit */
>> +phys_addr_t tdg_shared_mask(void)
>> +{
>> +	return 1ULL << (td_info.gpa_width - 1);
>> +}
> 
> Why not just inline this thing?  Functions don't get any smaller than
> that.  Or does it not get used anywhere else?  Or are you concerned
> about exporting td_info?

We don't want to export td_info. It has more information additional to shared
mask details. Any reason for suggesting to use inline?

This function is only used in following files.

arch/x86/include/asm/pgtable.h:25:#define pgprot_tdg_shared(prot) __pgprot(pgprot_val(prot) | 
tdg_shared_mask())
arch/x86/mm/pat/set_memory.c:1997:		mem_plain_bits = __pgprot(tdg_shared_mask());
arch/x86/kernel/tdx.c:134:phys_addr_t tdg_shared_mask(void)
arch/x86/kernel/tdx.c:274:	physical_mask &= ~tdg_shared_mask();


> 
>>   static void tdg_get_info(void)
>>   {
>>   	u64 ret;
>> @@ -87,6 +93,9 @@ static void tdg_get_info(void)
>>   
>>   	td_info.gpa_width = out.rcx & GENMASK(5, 0);
>>   	td_info.attributes = out.rdx;
>> +
>> +	/* Exclude Shared bit from the __PHYSICAL_MASK */
>> +	physical_mask &= ~tdg_shared_mask();
>>   }
>>   
>>   static __cpuidle void tdg_halt(void)
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
