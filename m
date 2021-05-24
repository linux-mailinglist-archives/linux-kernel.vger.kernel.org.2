Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E31238DF05
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 03:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhEXB56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 21:57:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5742 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhEXB5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 21:57:54 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpKwg3wLFzncSx;
        Mon, 24 May 2021 09:52:51 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 09:56:26 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 09:56:25 +0800
Subject: Re: [PATCH RFC v2] riscv: Enable KFENCE for riscv64
To:     Palmer Dabbelt <palmer@dabbelt.com>, <elver@google.com>
References: <mhng-f2825fd1-15e0-403d-b972-d327494525e6@palmerdabbelt-glaptop>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <glider@google.com>, <dvyukov@google.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kasan-dev@googlegroups.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <0b584a85-79e2-fcdd-2adf-5b63f56cc591@huawei.com>
Date:   Mon, 24 May 2021 09:56:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <mhng-f2825fd1-15e0-403d-b972-d327494525e6@palmerdabbelt-glaptop>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/23 10:38, Palmer Dabbelt wrote:
> On Fri, 14 May 2021 08:20:10 PDT (-0700), elver@google.com wrote:
>> On Fri, 14 May 2021 at 05:11, Liu Shixin <liushixin2@huawei.com> wrote:
>>> Add architecture specific implementation details for KFENCE and enable
>>> KFENCE for the riscv64 architecture. In particular, this implements the
>>> required interface in <asm/kfence.h>.
>>>
>>> KFENCE requires that attributes for pages from its memory pool can
>>> individually be set. Therefore, force the kfence pool to be mapped at
>>> page granularity.
>>>
>>> I tested this patch using the testcases in kfence_test.c and all passed.
>>>
>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>
>> Acked-by: Marco Elver <elver@google.com>
>>
>>
>>> ---
>>> v1->v2: Change kmalloc() to pte_alloc_one_kernel() for allocating pte.
>>>
>>>  arch/riscv/Kconfig              |  1 +
>>>  arch/riscv/include/asm/kfence.h | 51 +++++++++++++++++++++++++++++++++
>>>  arch/riscv/mm/fault.c           | 11 ++++++-
>>>  3 files changed, 62 insertions(+), 1 deletion(-)
>>>  create mode 100644 arch/riscv/include/asm/kfence.h
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index c426e7d20907..000d8aba1030 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -64,6 +64,7 @@ config RISCV
>>>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
>>>         select HAVE_ARCH_KASAN if MMU && 64BIT
>>>         select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
>>> +       select HAVE_ARCH_KFENCE if MMU && 64BIT
>>>         select HAVE_ARCH_KGDB
>>>         select HAVE_ARCH_KGDB_QXFER_PKT
>>>         select HAVE_ARCH_MMAP_RND_BITS if MMU
>>> diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
>>> new file mode 100644
>>> index 000000000000..c25d67e0b8ba
>>> --- /dev/null
>>> +++ b/arch/riscv/include/asm/kfence.h
>>> @@ -0,0 +1,51 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +#ifndef _ASM_RISCV_KFENCE_H
>>> +#define _ASM_RISCV_KFENCE_H
>>> +
>>> +#include <linux/kfence.h>
>>> +#include <linux/pfn.h>
>>> +#include <asm-generic/pgalloc.h>
>>> +#include <asm/pgtable.h>
>>> +
>>> +static inline bool arch_kfence_init_pool(void)
>>> +{
>>> +       int i;
>>> +       unsigned long addr;
>>> +       pte_t *pte;
>>> +       pmd_t *pmd;
>>> +
>>> +       for (addr = (unsigned long)__kfence_pool; is_kfence_address((void *)addr);
>>> +            addr += PAGE_SIZE) {
>>> +               pte = virt_to_kpte(addr);
>>> +               pmd = pmd_off_k(addr);
>>> +
>>> +               if (!pmd_leaf(*pmd) && pte_present(*pte))
>>> +                       continue;
>>> +
>>> +               pte = pte_alloc_one_kernel(&init_mm);
>>> +               for (i = 0; i < PTRS_PER_PTE; i++)
>>> +                       set_pte(pte + i, pfn_pte(PFN_DOWN(__pa((addr & PMD_MASK) + i * PAGE_SIZE)), PAGE_KERNEL));
>>> +
>>> +               set_pmd(pmd, pfn_pmd(PFN_DOWN(__pa(pte)), PAGE_TABLE));
>>> +               flush_tlb_kernel_range(addr, addr + PMD_SIZE);
>>> +       }
>>> +
>>> +       return true;
>>> +}
>
> I'm not fundamentally opposed to this, but the arm64 approach where pages are split at runtime when they have mis-matched permissions seems cleaner to me.  I'm not sure why x86 is doing it during init, though, as IIUC set_memory_4k() will work for both.
>
> Upgrading our __set_memory() with the ability to split pages (like arm64 has) seems generally useful, and would let us trivially implement the dynamic version of this.  We'll probably end up with the ability to split pages anyway, so that would be the least code in the long run.
>
> If there's some reason to prefer statically allocating the pages I'm fine with this, though.
>
As I understand，the arm64 approach does not implement dynamic splitting.
If kfence is enabled in arch arm64, the linear map need to be forcibly mapped
at page granularity. But x86 does not have such constraints as it only split pages
in the kfence pool, so I think the x86 approach is better as it has less influence
on the whole.
>>> +
>>> +static inline bool kfence_protect_page(unsigned long addr, bool protect)
>>> +{
>>> +       pte_t *pte = virt_to_kpte(addr);
>>> +
>>> +       if (protect)
>>> +               set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
>>> +       else
>>> +               set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
>>> +
>>> +       flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>> +
>>> +       return true;
>>> +}
>>> +
>>> +#endif /* _ASM_RISCV_KFENCE_H */
>>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
>>> index 096463cc6fff..aa08dd2f8fae 100644
>>> --- a/arch/riscv/mm/fault.c
>>> +++ b/arch/riscv/mm/fault.c
>>> @@ -14,6 +14,7 @@
>>>  #include <linux/signal.h>
>>>  #include <linux/uaccess.h>
>>>  #include <linux/kprobes.h>
>>> +#include <linux/kfence.h>
>>>
>>>  #include <asm/ptrace.h>
>>>  #include <asm/tlbflush.h>
>>> @@ -45,7 +46,15 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
>>>          * Oops. The kernel tried to access some bad page. We'll have to
>>>          * terminate things with extreme prejudice.
>>>          */
>>> -       msg = (addr < PAGE_SIZE) ? "NULL pointer dereference" : "paging request";
>>> +       if (addr < PAGE_SIZE)
>>> +               msg = "NULL pointer dereference";
>>> +       else {
>>> +               if (kfence_handle_page_fault(addr, regs->cause == EXC_STORE_PAGE_FAULT, regs))
>>> +                       return;
>>> +
>>> +               msg = "paging request";
>>> +       }
>>> +
>>>         die_kernel_fault(msg, addr, regs);
>>>  }
>>>
>>> -- 
>>> 2.18.0.huawei.25
>>>
>
> .
>

