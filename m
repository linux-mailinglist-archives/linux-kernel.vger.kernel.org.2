Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4DA39A3F7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhFCPId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:08:33 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41635 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhFCPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:08:31 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1FC0CE0004;
        Thu,  3 Jun 2021 15:06:39 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] riscv: Factorize xip and !xip kernel address
 conversion macros
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Anup Patel <anup@brainfault.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
References: <20210603082749.1256129-1-alex@ghiti.fr>
 <20210603082749.1256129-2-alex@ghiti.fr> <20210603202748.2775f739@xhacker>
 <64cdb4f9-06f0-59b9-acf9-6fc298db37d7@ghiti.fr>
 <CAAhSdy2kPPrBzFCA01NSvWptoftY27+PsMzLDWFzvOzNdUByhA@mail.gmail.com>
 <20210603215337.4da052e2@xhacker>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <e50b56f5-7405-2eef-f8e9-7d9fa4df7c77@ghiti.fr>
Date:   Thu, 3 Jun 2021 17:06:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603215337.4da052e2@xhacker>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 3/06/2021 à 15:53, Jisheng Zhang a écrit :
> On Thu, 3 Jun 2021 18:46:47 +0530
> Anup Patel <anup@brainfault.org> wrote:
> 
>> On Thu, Jun 3, 2021 at 6:27 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>>
>>> Hi Jisheng,
> 
> Hi,
> 
>>>
>>> Le 3/06/2021 à 14:27, Jisheng Zhang a écrit :
>>>> On Thu,  3 Jun 2021 10:27:47 +0200
>>>> Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>>   
>>>>> To simplify the kernel address conversion code, make the same definition of
>>>>> kernel_mapping_pa_to_va and kernel_mapping_va_to_pa compatible for both xip
>>>>> and !xip kernel by defining XIP_OFFSET to 0 in !xip kernel.
>>>>>
>>>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>>>>> ---
>>>>>    arch/riscv/include/asm/page.h    | 14 +++-----------
>>>>>    arch/riscv/include/asm/pgtable.h |  2 ++
>>>>>    2 files changed, 5 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
>>>>> index 6a7761c86ec2..6e004d8fda4d 100644
>>>>> --- a/arch/riscv/include/asm/page.h
>>>>> +++ b/arch/riscv/include/asm/page.h
>>>>> @@ -93,9 +93,7 @@ extern unsigned long va_pa_offset;
>>>>>    #ifdef CONFIG_64BIT
>>>>>    extern unsigned long va_kernel_pa_offset;
>>>>>    #endif
>>>>> -#ifdef CONFIG_XIP_KERNEL
>>>>>    extern unsigned long va_kernel_xip_pa_offset;
>>>>> -#endif
>>>>>    extern unsigned long pfn_base;
>>>>>    #define ARCH_PFN_OFFSET            (pfn_base)
>>>>>    #else
>>>>> @@ -103,6 +101,7 @@ extern unsigned long pfn_base;
>>>>>    #ifdef CONFIG_64BIT
>>>>>    #define va_kernel_pa_offset        0
>>>>>    #endif
>>>>> +#define va_kernel_xip_pa_offset 0
>>>>>    #define ARCH_PFN_OFFSET            (PAGE_OFFSET >> PAGE_SHIFT)
>>>>>    #endif /* CONFIG_MMU */
>>>>>
>>>>> @@ -110,29 +109,22 @@ extern unsigned long kernel_virt_addr;
>>>>>
>>>>>    #ifdef CONFIG_64BIT
>>>>>    #define linear_mapping_pa_to_va(x) ((void *)((unsigned long)(x) + va_pa_offset))
>>>>> -#ifdef CONFIG_XIP_KERNEL
>>>>>    #define kernel_mapping_pa_to_va(y) ({                                              \
>>>>>       unsigned long _y = y;                                                           \
>>>>>       (_y >= CONFIG_PHYS_RAM_BASE) ?
>>>>
>>>> This CONFIG_PHYS_RAM_BASE is only available for XIP, could result in a
>>>> compiler error for !XIP?
>>>
>>> You're right, I have this patch in my branch and forgot to squash it
>>>   
>>>>
>>>> I'm also concerned with the unecessary overhead of kernel_mapping_pa_to_va()
>>>> for !XIP case, there's a "if" condition branch, and extra symbol: va_kernel_xip_pa_offset
>>>
>>> I understand your concerns even if I don't find that the overhead is
>>> that important here, I prefer the readability improvement. I can always
> 
> For readability, we still can avoid introducing va_kernel_xip_pa_offset
> symbol by simply define va_kernel_xip_pa_offset as 0 if XIP as you did
> for XIP_OFFSET
> 
> PS: this may need a preparation patch:
> http://lists.infradead.org/pipermail/linux-riscv/2021-June/006802.html

IIUC, that won't improve readability, just avoid to allocate 
va_kernel_xip_pa_offset in !XIP kernel right?

> 
>>> add unlikely/likely builtin to improve things or completely remove this
>>> patch if others agree with you.
>>
>> I would also prefer readable code for long-term maintainability. Currently,
>> the nested "#ifdefs" are increasing causing developers to easily break
>> untested combinations.
>>
>> Regards,
>> Anup
>>
>>>
>>> Thanks,
>>>
>>> Alex
>>>   
>>>>   
>>>>>               (void *)((unsigned long)(_y) + va_kernel_pa_offset + XIP_OFFSET) :      \
>>>>>               (void *)((unsigned long)(_y) + va_kernel_xip_pa_offset);                \
>>>>>       })
>>>>> -#else
>>>>> -#define kernel_mapping_pa_to_va(x)  ((void *)((unsigned long)(x) + va_kernel_pa_offset))
>>>>> -#endif
>>>>>    #define __pa_to_va_nodebug(x)              linear_mapping_pa_to_va(x)
>>>>>
>>>>>    #define linear_mapping_va_to_pa(x) ((unsigned long)(x) - va_pa_offset)
>>>>> -#ifdef CONFIG_XIP_KERNEL
>>>>>    #define kernel_mapping_va_to_pa(y) ({                                              \
>>>>>       unsigned long _y = y;                                                   \
>>>>>       (_y < kernel_virt_addr + XIP_OFFSET) ?                                  \
>>>>>               ((unsigned long)(_y) - va_kernel_xip_pa_offset) :               \
>>>>>               ((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFSET);       \
>>>>>       })
>>>>
>>>> Similar as kernel_mapping_pa_to_va(), an overhead of "if" condition branch
>>>> for !XIP and extra va_kernel_xip_pa_offset symbol.
>>>>   
>>>>> -#else
>>>>> -#define kernel_mapping_va_to_pa(x)  ((unsigned long)(x) - va_kernel_pa_offset)
>>>>> -#endif
>>>>> +
>>>>>    #define __va_to_pa_nodebug(x)      ({                                              \
>>>>>       unsigned long _x = x;                                                   \
>>>>>       (_x < kernel_virt_addr) ?                                               \
>>>>> @@ -141,7 +133,7 @@ extern unsigned long kernel_virt_addr;
>>>>>    #else
>>>>>    #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
>>>>>    #define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
>>>>> -#endif
>>>>> +#endif /* CONFIG_64BIT */
>>>>>
>>>>>    #ifdef CONFIG_DEBUG_VIRTUAL
>>>>>    extern phys_addr_t __virt_to_phys(unsigned long x);
>>>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>>>> index bde8ce3bfe7c..d98e931a31e5 100644
>>>>> --- a/arch/riscv/include/asm/pgtable.h
>>>>> +++ b/arch/riscv/include/asm/pgtable.h
>>>>> @@ -77,6 +77,8 @@
>>>>>
>>>>>    #ifdef CONFIG_XIP_KERNEL
>>>>>    #define XIP_OFFSET         SZ_8M
>>>>> +#else
>>>>> +#define XIP_OFFSET          0
>>>>>    #endif
>>>>>
>>>>>    #ifndef __ASSEMBLY__
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>>   
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
