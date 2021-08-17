Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4553EED28
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbhHQNR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:17:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:5872 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237156AbhHQNRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:17:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="195666339"
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="195666339"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 06:16:26 -0700
X-IronPort-AV: E=Sophos;i="5.84,328,1620716400"; 
   d="scan'208";a="510467254"
Received: from favalosr-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.164.120])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 06:16:26 -0700
Subject: Re: [PATCH v5 01/12] x86/paravirt: Move halt paravirt calls under
 CONFIG_PARAVIRT
To:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@alien8.de>
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
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YRTLO0eQOEChETId@zn.tnic> <057170db-9382-eb40-7bcb-4ec1de4aae62@suse.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <fd603d12-1897-1f5f-17fa-b5ac643bc334@linux.intel.com>
Date:   Tue, 17 Aug 2021 06:16:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <057170db-9382-eb40-7bcb-4ec1de4aae62@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/21 5:50 AM, Juergen Gross wrote:
> On 12.08.21 09:18, Borislav Petkov wrote:
>> On Wed, Aug 04, 2021 at 11:13:18AM -0700, Kuppuswamy Sathyanarayanan wrote:
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>
>>> CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
>>> other VM guest types, features supported under CONFIG_PARAVIRT
>>> are self sufficient. CONFIG_PARAVIRT mainly provides support for
>>> TLB flush operations and time related operations.
>>>
>>> For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
>>> most of its requirement except the need of HLT and SAFE_HLT
>>> paravirt calls, which is currently defined under
>>> COFNIG_PARAVIRT_XXL.
>>>
>>> Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
>>> like platforms, move HLT and SAFE_HLT paravirt calls under
>>> CONFIG_PARAVIRT.
>>>
>>> Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
>>> break any functionality for current users of CONFIG_PARAVIRT.
>>>
>>> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>>> ---
>>
>> You need to do this before sending your patches:
>>
>> ./scripts/get_maintainer.pl /tmp/tdx.01
>> Thomas Gleixner <tglx@linutronix.de> (maintainer:X86 ARCHITECTURE (32-BIT AND 
>> 64-BIT),commit_signer:1/6=17%)
>> Ingo Molnar <mingo@redhat.com> (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
>> Borislav Petkov <bp@alien8.de> (maintainer:X86 ARCHITECTURE (32-BIT AND 
>> 64-BIT),commit_signer:6/6=100%)
>> x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
>> "H. Peter Anvin" <hpa@zytor.com> (reviewer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
>> Juergen Gross <jgross@suse.com> (supporter:PARAVIRT_OPS 
>> INTERFACE,commit_signer:5/6=83%,authored:5/6=83%,added_lines:15/16=94%,removed_lines:38/39=97%)
>> Deep Shah <sdeep@vmware.com> (supporter:PARAVIRT_OPS INTERFACE)
>> "VMware, Inc." <pv-drivers@vmware.com> (supporter:PARAVIRT_OPS INTERFACE)
>> ...
>>
>> and CC also the supporters - I'm pretty sure at least Juergen would like
>> to be kept up-to-date on pv changes. I'll CC him and the others now and
>> leave in the whole diff but make sure you do that in the future please.
>>
>>>   arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
>>>   arch/x86/include/asm/paravirt.h       | 20 +++++++-------
>>>   arch/x86/include/asm/paravirt_types.h |  3 +-
>>>   arch/x86/kernel/paravirt.c            |  4 ++-
>>>   4 files changed, 36 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
>>> index c5ce9845c999..f3bb33b1715d 100644
>>> --- a/arch/x86/include/asm/irqflags.h
>>> +++ b/arch/x86/include/asm/irqflags.h
>>> @@ -59,6 +59,28 @@ static inline __cpuidle void native_halt(void)
>>>   #endif
>>> +#ifndef CONFIG_PARAVIRT
>>> +#ifndef __ASSEMBLY__
>>> +/*
>>> + * Used in the idle loop; sti takes one instruction cycle
>>> + * to complete:
>>> + */
>>> +static inline __cpuidle void arch_safe_halt(void)
>>> +{
>>> +    native_safe_halt();
>>> +}
>>> +
>>> +/*
>>> + * Used when interrupts are already enabled or to
>>> + * shutdown the processor:
>>> + */
>>> +static inline __cpuidle void halt(void)
>>> +{
>>> +    native_halt();
>>> +}
>>> +#endif /* __ASSEMBLY__ */
>>> +#endif /* CONFIG_PARAVIRT */
>>> +
>>>   #ifdef CONFIG_PARAVIRT_XXL
>>>   #include <asm/paravirt.h>
> 
> Did you test this with CONFIG_PARAVIRT enabled and CONFIG_PARAVIRT_XXL
> disabled?
> 
> I'm asking because in this case I don't see where halt() and
> arch_safe_halt() would be defined in case someone is including
> asm/irqflags.h and not asm/paravirt.h.

We have tested both cases and did not hit any issues.

1. CONFIG_PARAVIRT=y and  CONFIG_PARAVIRT_XXL=y
2. CONFIG_PARAVIRT=y and  CONFIG_PARAVIRT_XXL=n


>>> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
>>> index 04cafc057bed..124e0f6c5d1c 100644
>>> --- a/arch/x86/kernel/paravirt.c
>>> +++ b/arch/x86/kernel/paravirt.c
>>> @@ -283,9 +283,11 @@ struct paravirt_patch_template pv_ops = {
>>>       .irq.save_fl        = __PV_IS_CALLEE_SAVE(native_save_fl),
>>>       .irq.irq_disable    = __PV_IS_CALLEE_SAVE(native_irq_disable),
>>>       .irq.irq_enable        = __PV_IS_CALLEE_SAVE(native_irq_enable),
>>> +#endif /* CONFIG_PARAVIRT_XXL */
>>> +
>>> +    /* Irq HLT ops. */
>>
>> What's that comment for?
> 
> I agree, please drop it.

Yes. I will drop it.

> 
> 
> Juergen

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
