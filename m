Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1287B36EB61
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhD2Ncl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:32:41 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:50939 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhD2Nck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:32:40 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 34F5E240004;
        Thu, 29 Apr 2021 13:31:48 +0000 (UTC)
Subject: Re: [PATCH] RISC-V: Always define XIP_FIXUP
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, wangkefeng.wang@huawei.com,
        rppt@kernel.org, vitaly.wool@konsulko.com, greentime.hu@sifive.com,
        0x7f454c46@gmail.com, chenhuang5@huawei.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux@roeck-us.net
References: <mhng-2e1a7543-84bc-4954-843a-b577fc132157@palmerdabbelt-glaptop>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <890b2709-a317-9437-2d05-a94a64a03a3e@ghiti.fr>
Date:   Thu, 29 Apr 2021 09:31:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <mhng-2e1a7543-84bc-4954-843a-b577fc132157@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 4/29/21 à 12:43 AM, Palmer Dabbelt a écrit :
> On Wed, 28 Apr 2021 01:25:55 PDT (-0700), alex@ghiti.fr wrote:
>> Le 4/27/21 à 11:34 PM, Palmer Dabbelt a écrit :
>>> From: Palmer Dabbelt <palmerdabbelt@google.com>
>>>
>>> XIP depends on MMU, but XIP_FIXUP is defined throughout the kernel in
>>> order to avoid excessive ifdefs.  This just makes sure to always define
>>> XIP_FIXIP, which will fix MMU=n builds.
>>
>> A small typo here.
> 
> Actually two: "defined" should have been "used".  Both are fixed.
> 
>>
>>>
>>> Fixes: 44c922572952 ("RISC-V: enable XIP")
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>> ---
>>>   arch/riscv/include/asm/pgtable.h | 24 ++++++++++++------------
>>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/pgtable.h 
>>> b/arch/riscv/include/asm/pgtable.h
>>> index 2f1384e14e31..fd749351f432 100644
>>> --- a/arch/riscv/include/asm/pgtable.h
>>> +++ b/arch/riscv/include/asm/pgtable.h
>>> @@ -73,18 +73,6 @@
>>>   #endif
>>>   #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>>>
>>> -#ifdef CONFIG_XIP_KERNEL
>>> -#define XIP_OFFSET        SZ_8M
>>> -#define XIP_FIXUP(addr) ({                            \
>>> -    uintptr_t __a = (uintptr_t)(addr);                    \
>>> -    (__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + 
>>> SZ_16M) ?    \
>>> -        __a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - 
>>> XIP_OFFSET :\
>>> -        __a;                                \
>>> -    })
>>> -#else
>>> -#define XIP_FIXUP(addr)        (addr)
>>> -#endif /* CONFIG_XIP_KERNEL */
>>> -
>>>   #endif
>>>
>>>   #ifndef __ASSEMBLY__
>>> @@ -101,6 +89,18 @@
>>>   #include <asm/pgtable-32.h>
>>>   #endif /* CONFIG_64BIT */
>>>
>>> +#ifdef CONFIG_XIP_KERNEL
>>> +#define XIP_OFFSET        SZ_8M
>>
>>
>> XIP_OFFSET is used in head.S and then this breaks XIP_KERNEL. XIP_OFFSET
>> must live outside the ifndef __ASSEMBLY__.
> 
> Thanks, I hadn't even seen XIP_OFFSET.  This is fixed in the v2.
> 
> Do you have an XIP config that will run on QEMU, and a way to run it? If 
> so, can you post a defconfig and some instructions?  That'll make it 
> easier to test on my end.
> 

Yes, I'll do that later today or tomorrow.

>>> +#define XIP_FIXUP(addr) ({                            \
>>> +    uintptr_t __a = (uintptr_t)(addr);                    \
>>> +    (__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + 
>>> SZ_16M) ?    \
>>> +        __a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - 
>>> XIP_OFFSET :\
>>> +        __a;                                \
>>> +    })
>>> +#else
>>> +#define XIP_FIXUP(addr)        (addr)
>>> +#endif /* CONFIG_XIP_KERNEL */
>>> +
>>>   #ifdef CONFIG_MMU
>>>   /* Number of entries in the page global directory */
>>>   #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
>>>
>>
>> Thank you for doing that!
>>
>> Alex
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
