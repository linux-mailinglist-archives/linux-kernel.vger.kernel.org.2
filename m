Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AB03F68E3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhHXSMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:12:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:6776 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229670AbhHXSMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:12:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="239531213"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="239531213"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 11:11:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="597670420"
Received: from ydevadig-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.137.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 11:11:45 -0700
Subject: Re: [PATCH v5 09/12] x86/tdx: Wire up KVM hypercalls
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
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-10-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUfpQPvL6wsk6Ou@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8ccbf970-fd4f-b1ea-ac85-98acfe296b00@linux.intel.com>
Date:   Tue, 24 Aug 2021 11:11:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSUfpQPvL6wsk6Ou@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/21 9:34 AM, Borislav Petkov wrote:
> On Wed, Aug 04, 2021 at 11:13:26AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> KVM hypercalls use the "vmcall" or "vmmcall" instructions.
> 
> Write instruction mnemonics in all caps pls.

Ok. I will change it in next submission.

> 
>> +# This option enables KVM specific hypercalls in TDX guest.
>> +config INTEL_TDX_GUEST_KVM
> 
> What is that config option really for? IOW, can't you use
> CONFIG_KVM_GUEST instead?
Since TDX code can be used by other hypervisor (non KVM case) we
want to have a config to differentiate the KVM related calls.

> 
>> +	def_bool y
>> +	depends on KVM_GUEST && INTEL_TDX_GUEST
>> +
>>   endif #HYPERVISOR_GUEST
>>   
>>   source "arch/x86/Kconfig.cpu"
>> diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
>> index 4cb726c71ed8..9855a9ff2924 100644
>> --- a/arch/x86/include/asm/asm-prototypes.h
>> +++ b/arch/x86/include/asm/asm-prototypes.h
>> @@ -17,6 +17,10 @@
>>   extern void cmpxchg8b_emu(void);
>>   #endif
>>   
>> +#ifdef CONFIG_INTEL_TDX_GUEST
>> +#include <asm/tdx.h>
>> +#endif
> 
> What "ASM sysmbol generation issue" forced this?

Compiler raised version generation issue for __tdx_hypercall

> 
> ...
> 
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> index 846fe58f0426..8fa33e2c98db 100644
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -6,8 +6,9 @@
>>   #include <linux/cpufeature.h>
>>   #include <linux/types.h>
>>   
>> -#define TDX_CPUID_LEAF_ID	0x21
>> -#define TDX_HYPERCALL_STANDARD  0
>> +#define TDX_CPUID_LEAF_ID			0x21
>> +#define TDX_HYPERCALL_STANDARD			0
>> +#define TDX_HYPERCALL_VENDOR_KVM		0x4d564b2e584454
> 
> 						"TDX.KVM"
> 
> Yeah, you can put it in a comment so that people don't have to do the
> CTRL-V game in vim insert mode, i.e., ":help i_CTRL-V_digit" :-)

Got it. I will add it in comment.

> 
>>   /*
>>    * Used in __tdx_module_call() helper function to gather the
>> @@ -80,4 +81,29 @@ static inline bool tdx_prot_guest_has(unsigned long flag) { return false; }
>>   
>>   #endif /* CONFIG_INTEL_TDX_GUEST */
>>   
>> +#ifdef CONFIG_INTEL_TDX_GUEST_KVM
> 
> I don't think that even needs the ifdeffery. If it is not used, the
> inline will simply get discarded so why bother?

It makes sense. I can remove it.

> 
>> +
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
>> +	BUG_ON(err);
>> +
>> +	return out.r10;
>> +}
>> +#else
>> +static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
>> +				     unsigned long p2, unsigned long p3,
>> +				     unsigned long p4)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif /* CONFIG_INTEL_TDX_GUEST_KVM */
>> +
>>   #endif /* _ASM_X86_TDX_H */
>> diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
>> index 9df94f87465d..1823bac4542d 100644
>> --- a/arch/x86/kernel/tdcall.S
>> +++ b/arch/x86/kernel/tdcall.S
>> @@ -3,6 +3,7 @@
>>   #include <asm/asm.h>
>>   #include <asm/frame.h>
>>   #include <asm/unwind_hints.h>
>> +#include <asm/export.h>
>>   
>>   #include <linux/linkage.h>
>>   #include <linux/bits.h>
>> @@ -309,3 +310,4 @@ skip_sti:
>>   
>>          retq
>>   SYM_FUNC_END(__tdx_hypercall)
>> +EXPORT_SYMBOL(__tdx_hypercall);
> 
> EXPORT_SYMBOL_GPL, of course.

Yes. I will fix this in next version.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
