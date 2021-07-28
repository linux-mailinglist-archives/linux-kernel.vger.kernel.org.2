Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A193D8A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhG1JIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:08:16 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:54205 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhG1JIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:08:14 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BBB541BF20A;
        Wed, 28 Jul 2021 09:08:04 +0000 (UTC)
Subject: Re: [PATCH] riscv: fix the global name pfn_base confliction error
To:     Lee Ken <nek.in.cn@gmail.com>
References: <20210728064318.375747-1-nek.in.cn@gmail.com>
 <0e81c8d2-468a-9afd-bce3-0e8211baa065@ghiti.fr>
 <CA+CqrBQPou5QuYfHUYzbe7j2AUPpmBQs1HQJgjJo5QtF51LmXw@mail.gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, moi <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <4da4adaf-9bd8-6463-9230-5a3a73f323ba@ghiti.fr>
Date:   Wed, 28 Jul 2021 11:08:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CA+CqrBQPou5QuYfHUYzbe7j2AUPpmBQs1HQJgjJo5QtF51LmXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 28/07/2021 à 09:33, Lee Ken a écrit :
> On Wed, Jul 28, 2021 at 3:19 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>
>> Hi Kenneth,
>>
>> Le 28/07/2021 à 08:43, Kenneth Lee a écrit :
>>> From: Kenneth Lee <liguozhu@hisilicon.com>
>>>
>>> RISCV use a global variable pfn_base for page/pfn translation. But this
>>> is a common name and will be used elsewhere. In those case,
>>> the page-pfn macro which refer this name will refer to the local/input
>>> variable of those function (such as in vfio_pin_pages_remote). This make
>>> everything wrong.
>>>
>>> This patch change the name from pfn_base to riscv_global_pfn_base to fix
>>> this problem
>>
>> What about removing this variable entirely and using
>> PFN_DOWN(kernel_map.phys_addr) directly in ARCH_PFN_OFFSET definition?
>> That would remove code from mm/init.c, which is nice :)
>>
>> Thanks,
>>
>> Alex
>>
>>>
>>> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
>>> ---
>>>    arch/riscv/include/asm/page.h | 4 ++--
>>>    arch/riscv/mm/init.c          | 6 +++---
>>>    2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
>>> index cca8764aed83..8711e415f37c 100644
>>> --- a/arch/riscv/include/asm/page.h
>>> +++ b/arch/riscv/include/asm/page.h
>>> @@ -79,8 +79,8 @@ typedef struct page *pgtable_t;
>>>    #endif
>>>
>>>    #ifdef CONFIG_MMU
>>> -extern unsigned long pfn_base;
>>> -#define ARCH_PFN_OFFSET              (pfn_base)
>>> +extern unsigned long riscv_global_pfn_base;
>>> +#define ARCH_PFN_OFFSET              (riscv_global_pfn_base)
>>>    #else
>>>    #define ARCH_PFN_OFFSET             (PAGE_OFFSET >> PAGE_SHIFT)
>>>    #endif /* CONFIG_MMU */
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index a14bf3910eec..2ce4e9a46ca0 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -228,8 +228,8 @@ static struct pt_alloc_ops _pt_ops __initdata;
>>>    #define pt_ops _pt_ops
>>>    #endif
>>>
>>> -unsigned long pfn_base __ro_after_init;
>>> -EXPORT_SYMBOL(pfn_base);
>>> +unsigned long riscv_global_pfn_base __ro_after_init;
>>> +EXPORT_SYMBOL(riscv_global_pfn_base);
>>>
>>>    pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>>>    pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>>> @@ -572,7 +572,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>>>        kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
>>>    #endif
>>>
>>> -     pfn_base = PFN_DOWN(kernel_map.phys_addr);
>>> +     riscv_global_pfn_base = PFN_DOWN(kernel_map.phys_addr);
>>>
>>>        /*
>>>         * Enforce boot alignment requirements of RV32 and
>>>
> 
> Yes. It is a choice. But I think it is the choice of the maintainer of
> the module. He should have a full consideration on how to expose the
> interface. I'm now just working for VFIO enablement in RISCV. It is
> not wise to be trapped into this;)
> 

I think there is a misunderstanding, I suggested to do the following to 
get rid of pfn_base entirely:

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index adf5b4671684..8afb3db61eb0 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -79,8 +79,7 @@ typedef struct page *pgtable_t;
  #endif

  #ifdef CONFIG_MMU
-extern unsigned long pfn_base;
-#define ARCH_PFN_OFFSET                (pfn_base)
+#define ARCH_PFN_OFFSET                (PFN_DOWN(kernel_map.phys_addr))
  #else
  #define ARCH_PFN_OFFSET                (PAGE_OFFSET >> PAGE_SHIFT)
  #endif /* CONFIG_MMU */
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c9a6362d8c7f..c51f0da03a62 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -211,9 +211,6 @@ static void __init setup_bootmem(void)
  #ifdef CONFIG_MMU
  static struct pt_alloc_ops pt_ops __initdata;

-unsigned long pfn_base __ro_after_init;
-EXPORT_SYMBOL(pfn_base);
-
  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
  extern pte_t fixmap_pte[PTRS_PER_PTE];// __page_aligned_bss;
@@ -608,8 +605,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
         kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
         kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - 
kernel_map.phys_addr;

-       pfn_base = PFN_DOWN(kernel_map.phys_addr);
-
         /* Sanity check alignment and size */
         BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
         BUG_ON((kernel_map.phys_addr % PMD_SIZE) != 0);
