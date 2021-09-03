Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFED400575
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350606AbhICTFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:05:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:60244 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231300AbhICTE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:04:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="280506307"
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="280506307"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 12:03:59 -0700
X-IronPort-AV: E=Sophos;i="5.85,266,1624345200"; 
   d="scan'208";a="462502843"
Received: from nadeshpa-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.188.116])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 12:03:58 -0700
Subject: Re: [PATCH v6 01/11] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YTJn0HOkMd0thT+3@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <256d0f5b-3a6d-0912-2edc-44b4a0889c73@linux.intel.com>
Date:   Fri, 3 Sep 2021 12:03:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTJn0HOkMd0thT+3@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/21 11:22 AM, Borislav Petkov wrote:
> On Fri, Sep 03, 2021 at 10:28:02AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
>> index c5ce9845c999..ddc77c95adc6 100644
>> --- a/arch/x86/include/asm/irqflags.h
>> +++ b/arch/x86/include/asm/irqflags.h
>> @@ -59,27 +59,8 @@ static inline __cpuidle void native_halt(void)
>>   
>>   #endif
>>   
>> -#ifdef CONFIG_PARAVIRT_XXL
>> -#include <asm/paravirt.h>
>> -#else
>> +#ifndef CONFIG_PARAVIRT
>>   #ifndef __ASSEMBLY__
>> -#include <linux/types.h>
>> -
>> -static __always_inline unsigned long arch_local_save_flags(void)
>> -{
>> -	return native_save_fl();
>> -}
>> -
>> -static __always_inline void arch_local_irq_disable(void)
>> -{
>> -	native_irq_disable();
>> -}
>> -
>> -static __always_inline void arch_local_irq_enable(void)
>> -{
>> -	native_irq_enable();
>> -}
>> -
>>   /*
>>    * Used in the idle loop; sti takes one instruction cycle
>>    * to complete:
>> @@ -97,6 +78,33 @@ static inline __cpuidle void halt(void)
>>   {
>>   	native_halt();
>>   }
>> +#endif /* __ASSEMBLY__ */
>> +#endif /* CONFIG_PARAVIRT */
>> +
>> +#ifdef CONFIG_PARAVIRT
>> +#ifndef __ASSEMBLY__
>> +#include <asm/paravirt.h>
>> +#endif /* __ASSEMBLY__ */
>> +#endif /* CONFIG_PARAVIRT */
> 
> I think the way we write those is like this:
> 
> #ifdef CONFIG_PARAVIRT
> 
> # ifndef __ASSEMBLY__
> # include <asm/paravirt.h>
> # endif
> 
> #else /* ! CONFIG_PARAVIRT */
> 
> # ifndef __ASSEMBLY__
> /*
>   * Used in the idle loop; sti takes one instruction cycle
>   * to complete:
>   */
> static inline __cpuidle void arch_safe_halt(void)
> {
> 	native_safe_halt();
> }
> 
> /*
>   * Used when interrupts are already enabled or to
>   * shutdown the processor:
>   */
> static inline __cpuidle void halt(void)
> {
> 	native_halt();
> }
> # endif /* __ASSEMBLY__ */
> 
> #endif /* CONFIG_PARAVIRT */

Yes, I can combine the #ifdef as you have mentioned. I can fix this
in next version.

> 
> Note the empty space after the '#' of the inner ifdef to show that it is
> an inner one.

Is this new convention? #ifdefs used in this file does not follow this
format.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
