Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B0139CDE7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 09:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhFFHlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 03:41:01 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:40317 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFHk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 03:40:57 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 851F6240003;
        Sun,  6 Jun 2021 07:38:46 +0000 (UTC)
Subject: Re: [PATCH v4 2/4] riscv: Simplify xip and !xip kernel address
 conversion macros
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210604114950.1446390-1-alex@ghiti.fr>
 <20210604114950.1446390-3-alex@ghiti.fr> <20210604204743.7bdd4fbd@xhacker>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <5886a364-a154-d2f5-1f0c-5acac5641ed4@ghiti.fr>
Date:   Sun, 6 Jun 2021 09:38:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210604204743.7bdd4fbd@xhacker>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 4/06/2021 à 14:47, Jisheng Zhang a écrit :
> Hi Alexandre,
> 
> On Fri,  4 Jun 2021 13:49:48 +0200
> Alexandre Ghiti <alex@ghiti.fr> wrote:
> 
>> To simplify the kernel address conversion code, make the same definition of
>> kernel_mapping_pa_to_va and kernel_mapping_va_to_pa compatible for both xip
>> and !xip kernel by defining XIP_OFFSET to 0 in !xip kernel.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Reviewed-by: Anup Patel <anup@brainfault.org>
>> ---
>>   arch/riscv/include/asm/page.h    | 14 +++-----------
>>   arch/riscv/include/asm/pgtable.h |  2 ++
>>   2 files changed, 5 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
>> index 6a7761c86ec2..6e004d8fda4d 100644
>> --- a/arch/riscv/include/asm/page.h
>> +++ b/arch/riscv/include/asm/page.h
>> @@ -93,9 +93,7 @@ extern unsigned long va_pa_offset;
>>   #ifdef CONFIG_64BIT
>>   extern unsigned long va_kernel_pa_offset;
>>   #endif
>> -#ifdef CONFIG_XIP_KERNEL
>>   extern unsigned long va_kernel_xip_pa_offset;
>> -#endif
>>   extern unsigned long pfn_base;
>>   #define ARCH_PFN_OFFSET		(pfn_base)
>>   #else
>> @@ -103,6 +101,7 @@ extern unsigned long pfn_base;
>>   #ifdef CONFIG_64BIT
>>   #define va_kernel_pa_offset	0
>>   #endif
>> +#define va_kernel_xip_pa_offset 0
>>   #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
>>   #endif /* CONFIG_MMU */
>>   
>> @@ -110,29 +109,22 @@ extern unsigned long kernel_virt_addr;
>>   
>>   #ifdef CONFIG_64BIT
>>   #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_pa_offset))
>> -#ifdef CONFIG_XIP_KERNEL
>>   #define kernel_mapping_pa_to_va(y)	({						\
>>   	unsigned long _y = y;								\
>>   	(_y >= CONFIG_PHYS_RAM_BASE) ?							\
> 
> For !XIP, IIRC, one rule for riscv kernel is one unified Image for all RV64GC
> or RV32GC platforms. When CONFIG_PHYS_RAM_BASE is available for all
> riscv platforms after patch1, I'm not sure the common unified Image is still
> possible or not.
> 

I completely did not handle the 32b case and was convinced that 
0x8000_0000 was indeed the beginning of the RAM for all riscv64 plaforms.

> One possible solution would be forcing CONFIG_PHYS_RAM_BASE = 0 if !XIP in patch1
> or remove patch1 instead define CONFIG_PHY_RAM_BASE 0 for !XIP

Setting CONFIG_PHYS_RAM_BASE to 0 for !xip kernels is IMO not that great 
since it represents something that is real but wrong (unlike XIP_OFFSET 
which is 0 for !xip kernel and in that case, this is true). I will think 
to a better solution and am open to suggestions.

Thanks Jisheng again for your reviews, really appreciated!

Alex

> 
> Thanks
> 
>>   		(void *)((unsigned long)(_y) + va_kernel_pa_offset + XIP_OFFSET) :	\
>>   		(void *)((unsigned long)(_y) + va_kernel_xip_pa_offset);		\
>>   	})
>> -#else
>> -#define kernel_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_kernel_pa_offset))
>> -#endif
>>   #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
>>   
>>   #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - va_pa_offset)
>> -#ifdef CONFIG_XIP_KERNEL
>>   #define kernel_mapping_va_to_pa(y) ({						\
>>   	unsigned long _y = y;							\
>>   	(_y < kernel_virt_addr + XIP_OFFSET) ?					\
>>   		((unsigned long)(_y) - va_kernel_xip_pa_offset) :		\
>>   		((unsigned long)(_y) - va_kernel_pa_offset - XIP_OFFSET);	\
>>   	})
>> -#else
>> -#define kernel_mapping_va_to_pa(x)	((unsigned long)(x) - va_kernel_pa_offset)
>> -#endif
>> +
>>   #define __va_to_pa_nodebug(x)	({						\
>>   	unsigned long _x = x;							\
>>   	(_x < kernel_virt_addr) ?						\
>> @@ -141,7 +133,7 @@ extern unsigned long kernel_virt_addr;
>>   #else
>>   #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
>>   #define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
>> -#endif
>> +#endif /* CONFIG_64BIT */
>>   
>>   #ifdef CONFIG_DEBUG_VIRTUAL
>>   extern phys_addr_t __virt_to_phys(unsigned long x);
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index bde8ce3bfe7c..d98e931a31e5 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -77,6 +77,8 @@
>>   
>>   #ifdef CONFIG_XIP_KERNEL
>>   #define XIP_OFFSET		SZ_8M
>> +#else
>> +#define XIP_OFFSET		0
>>   #endif
>>   
>>   #ifndef __ASSEMBLY__
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
