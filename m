Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCADC42C333
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbhJMOcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:32:23 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43809 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbhJMOcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:32:12 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 61BD660002;
        Wed, 13 Oct 2021 14:30:04 +0000 (UTC)
Subject: Re: [PATCH v1 1/1] Add support for mm->mmap_legacy_base in legacy
 layout
To:     "zhengdbu@gmail.com" <zhengdbu@gmail.com>,
        "paul.walmsley" <paul.walmsley@sifive.com>
Cc:     palmer <palmer@dabbelt.com>, aou <aou@eecs.berkeley.edu>,
        "anup.patel" <anup.patel@wdc.com>,
        sunnanyong <sunnanyong@huawei.com>, jszhang <jszhang@kernel.org>,
        penberg <penberg@kernel.org>, guoren <guoren@linux.alibaba.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210927111150.3518-1-zhengdbu@gmail.com>
 <ca177872-8ce8-0cb7-4dbf-2debcb1ce76f@ghiti.fr>
 <2021101300034741790513@gmail.com>
From:   Alexandre ghiti <alex@ghiti.fr>
Message-ID: <3261b5c4-c5bf-211d-d5f2-c875bcf6b5f5@ghiti.fr>
Date:   Wed, 13 Oct 2021 16:30:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2021101300034741790513@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinli,

On 10/12/21 6:03 PM, zhengdbu@gmail.com wrote:
> Hi Alex,
>
> Do you think map_legacy_base should not be used? Or is 
> the kernel about to delete it? I think it's weird not to use it 
> because it's already defined.


I remember at the time I proposed the removal of the mmap_legacy_base
that it did not seem necessary at all, but I should dive back into this
patchset to make sure we really don't need this field anymore.
Regarding your patchset, can you tell a bit more what value does it
bring and why we should consider it? Because at first sight, it seems
like there is a lot of copy from the generic code that I put there to
avoid having to copy it in riscv :)

Thanks,

Alex


> Thanks,
>
> Jinli Zheng
>
>
>
> --------------
>
>
>
> zhengdbu@gmail.com
>
>
>
>> Hi Jinli,
>
>
>
>
>> Le 27/09/2021 à 13:11, Jinli Zheng a écrit :
>
>
>>> Add support for mm->mmap_legacy_base in the legacy layout
>
>
>>> of the process memory space for the riscv architecture
>
>
>
>
>
>
>> Can you elaborate a bit more? What value does it bring? I remember I had 
>
>
>> spent some time to factorize this code with arm64 to offer 
>
>
>> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT config and I had another patchset 
>
>
>> to get rid of mmap_legacy_base entirely at 
>
>
>> https://lkml.org/lkml/2019/6/19/18 (which never got merged though).
>
>
>
>
>> Thanks,
>
>
>
>
>> Alex
>
>
>
>
>>> Signed-off-by: Jinli Zheng <zhengdbu@gmail.com>
>
>
>>> ---
>
>
>>>    arch/riscv/Kconfig                 |   2 +-
>
>
>>>    arch/riscv/include/asm/pgtable.h   |   3 +
>
>
>>>    arch/riscv/include/asm/processor.h |   1 +
>
>
>>>    arch/riscv/mm/Makefile             |   2 +-
>
>
>>>    arch/riscv/mm/mmap.c               | 165 +++++++++++++++++++++++++++++
>
>
>>>    5 files changed, 171 insertions(+), 2 deletions(-)
>
>
>>>    create mode 100644 arch/riscv/mm/mmap.c
>
>
>
>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>
>
>>> index 301a54233c7e..e64231592227 100644
>
>
>>> --- a/arch/riscv/Kconfig
>
>
>>> +++ b/arch/riscv/Kconfig
>
>
>>> @@ -37,7 +37,7 @@ config RISCV
>
>
>>>    	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
>
>
>>>    	select ARCH_SUPPORTS_HUGETLBFS if MMU
>
>
>>>    	select ARCH_USE_MEMTEST
>
>
>>> -	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>
>
>>> +	select ARCH_HAS_ELF_RANDOMIZE
>
>
>>>    	select ARCH_WANT_FRAME_POINTERS
>
>
>>>    	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>
>
>>>    	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>
>
>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>
>
>>> index 39b550310ec6..107d61371272 100644
>
>
>>> --- a/arch/riscv/include/asm/pgtable.h
>
>
>>> +++ b/arch/riscv/include/asm/pgtable.h
>
>
>>> @@ -700,6 +700,9 @@ void misc_mem_init(void);
>
>
>>>    extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>
>
>>>    #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
>
>
>>>    
>
>
>>> +#define HAVE_ARCH_UNMAPPED_AREA
>
>
>>> +#define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
>
>
>>> +
>
>
>>>    #endif /* !__ASSEMBLY__ */
>
>
>>>    
>
>
>>>    #endif /* _ASM_RISCV_PGTABLE_H */
>
>
>>> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
>
>
>>> index 46b492c78cbb..e7dc7c1f820a 100644
>
>
>>> --- a/arch/riscv/include/asm/processor.h
>
>
>>> +++ b/arch/riscv/include/asm/processor.h
>
>
>>> @@ -56,6 +56,7 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
>
>
>>>    #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->epc)
>
>
>>>    #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->sp)
>
>
>>>    
>
>
>>> +#define HAVE_ARCH_PICK_MMAP_LAYOUT	1
>
>
>>>    
>
>
>>>    /* Do necessary setup to start up a newly executed thread. */
>
>
>>>    extern void start_thread(struct pt_regs *regs,
>
>
>>> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
>
>
>>> index 7ebaef10ea1b..123c67a2c24a 100644
>
>
>>> --- a/arch/riscv/mm/Makefile
>
>
>>> +++ b/arch/riscv/mm/Makefile
>
>
>>> @@ -10,7 +10,7 @@ KCOV_INSTRUMENT_init.o := n
>
>
>>>    
>
>
>>>    obj-y += init.o
>
>
>>>    obj-y += extable.o
>
>
>>> -obj-$(CONFIG_MMU) += fault.o pageattr.o
>
>
>>> +obj-$(CONFIG_MMU) += fault.o pageattr.o mmap.o
>
>
>>>    obj-y += cacheflush.o
>
>
>>>    obj-y += context.o
>
>
>>>    
>
>
>>> diff --git a/arch/riscv/mm/mmap.c b/arch/riscv/mm/mmap.c
>
>
>>> new file mode 100644
>
>
>>> index 000000000000..6c5818db5a65
>
>
>>> --- /dev/null
>
>
>>> +++ b/arch/riscv/mm/mmap.c
>
>
>>> @@ -0,0 +1,165 @@
>
>
>>> +// SPDX-License-Identifier: GPL-2.0
>
>
>>> +/*
>
>
>>> + * Legacy and flexible mmap layout support
>
>
>>> + *
>
>
>>> + * Copyright (C) 2021 Jinli Zheng <zhengdbu@gmail.com>
>
>
>>> + */
>
>
>>> +
>
>
>>> +#include <linux/personality.h>
>
>
>>> +#include <linux/mm.h>
>
>
>>> +#include <linux/mman.h>
>
>
>>> +#include <linux/random.h>
>
>
>>> +#include <linux/limits.h>
>
>
>>> +#include <linux/security.h>
>
>
>>> +#include <linux/compat.h>
>
>
>>> +#include <linux/sched/mm.h>
>
>
>>> +#include <linux/sched.h>
>
>
>>> +#include <linux/elf-randomize.h>
>
>
>>> +#include <asm/pgtable.h>
>
>
>>> +#include <asm/processor.h>
>
>
>>> +
>
>
>>> +#define SIZE_128M	(128*1024*1024UL)
>
>
>>> +
>
>
>>> +/*gap between MMAP and STACK*/
>
>
>>> +#define GAP_MIN		SIZE_128M
>
>
>>> +#define GAP_MAX		(((TASK_SIZE)/6)*5)
>
>
>>> +
>
>
>>> +static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>
>
>>> +{
>
>
>>> +	unsigned long gap = rlim_stack->rlim_cur;
>
>
>>> +
>
>
>>> +	if (gap < GAP_MIN)
>
>
>>> +		gap = GAP_MIN;
>
>
>>> +	else if (gap > GAP_MAX)
>
>
>>> +		gap = GAP_MAX;
>
>
>>> +
>
>
>>> +	return PAGE_ALIGN(TASK_SIZE - gap - rnd);
>
>
>>> +}
>
>
>>> +
>
>
>>> +unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
>
>
>>> +		unsigned long len, unsigned long pgoff, unsigned long flags)
>
>
>>> +{
>
>
>>> +	struct mm_struct *mm = current->mm;
>
>
>>> +	struct vm_area_struct *vma, *prev;
>
>
>>> +	struct vm_unmapped_area_info info;
>
>
>>> +
>
>
>>> +	if (len > TASK_SIZE)
>
>
>>> +		return -ENOMEM;
>
>
>>> +
>
>
>>> +	if (flags & MAP_FIXED)
>
>
>>> +		return addr;
>
>
>>> +
>
>
>>> +	if (addr) {
>
>
>>> +		addr = PAGE_ALIGN(addr);
>
>
>>> +		vma = find_vma_prev(mm, addr, &prev);
>
>
>>> +		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
>
>
>>> +		     (!vma || addr + len <= vm_start_gap(vma)) &&
>
>
>>> +		     (!prev || addr >= vm_end_gap(prev)))
>
>
>>> +			return addr;
>
>
>>> +	}
>
>
>>> +
>
>
>>> +	info.flags = 0;
>
>
>>> +	info.length = len;
>
>
>>> +	info.low_limit = mm->mmap_legacy_base;
>
>
>>> +	info.high_limit = TASK_SIZE;
>
>
>>> +	info.align_mask = 0;
>
>
>>> +	info.align_offset = 0;
>
>
>>> +	return vm_unmapped_area(&info);
>
>
>>> +}
>
>
>>> +
>
>
>>> +unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
>
>
>>> +		unsigned long len, unsigned long pgoff, unsigned long flags)
>
>
>>> +{
>
>
>>> +	struct mm_struct *mm = current->mm;
>
>
>>> +	struct vm_area_struct *vma, *prev;
>
>
>>> +	struct vm_unmapped_area_info info;
>
>
>>> +
>
>
>>> +	if (len > TASK_SIZE)
>
>
>>> +		return -ENOMEM;
>
>
>>> +
>
>
>>> +	if (flags & MAP_FIXED)
>
>
>>> +		return addr;
>
>
>>> +
>
>
>>> +	if (addr) {
>
>
>>> +		addr = PAGE_ALIGN(addr);
>
>
>>> +		vma = find_vma_prev(mm, addr, &prev);
>
>
>>> +		if (TASK_SIZE - len >= addr && addr >= mmap_min_addr &&
>
>
>>> +		     (!vma || addr + len <= vm_start_gap(vma)) &&
>
>
>>> +		     (!prev || addr >= vm_end_gap(prev)))
>
>
>>> +			return addr;
>
>
>>> +	}
>
>
>>> +
>
>
>>> +	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>
>
>>> +	info.length = len;
>
>
>>> +	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
>
>
>>> +	info.high_limit = mm->mmap_base;
>
>
>>> +	info.align_mask = 0;
>
>
>>> +	info.align_offset = 0;
>
>
>>> +	addr = vm_unmapped_area(&info);
>
>
>>> +
>
>
>>> +	if (offset_in_page(addr)) {
>
>
>>> +		VM_BUG_ON(addr != -ENOMEM);
>
>
>>> +		info.flags = 0;
>
>
>>> +		info.low_limit = TASK_UNMAPPED_BASE;
>
>
>>> +		info.high_limit = TASK_SIZE;
>
>
>>> +		addr = vm_unmapped_area(&info);
>
>
>>> +	}
>
>
>>> +
>
>
>>> +	return addr;
>
>
>>> +}
>
>
>>> +
>
>
>>> +unsigned long arch_mmap_rnd(void)
>
>
>>> +{
>
>
>>> +	unsigned long rnd;
>
>
>>> +
>
>
>>> +#ifdef CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS
>
>
>>> +	if (is_compat_task())
>
>
>>> +		rnd = get_random_int() & ((1UL << mmap_rnd_compat_bits) - 1);
>
>
>>> +	else
>
>
>>> +#endif /*CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS*/
>
>
>>> +		rnd = get_random_int() & ((1UL << mmap_rnd_bits) - 1);
>
>
>>> +
>
>
>>> +	return rnd << PAGE_SHIFT;
>
>
>>> +}
>
>
>>> +
>
>
>>> +static int mmap_is_legacy(struct rlimit *rlim_stack)
>
>
>>> +{
>
>
>>> +	if (current->personality & ADDR_COMPAT_LAYOUT)
>
>
>>> +		return 1;
>
>
>>> +
>
>
>>> +	if (rlim_stack->rlim_cur == RLIM_INFINITY)
>
>
>>> +		return 1;
>
>
>>> +
>
>
>>> +	return sysctl_legacy_va_layout;
>
>
>>> +}
>
>
>>> +
>
>
>>> +static void arch_pick_mmap_base(struct mm_struct *mm, struct rlimit *rlim_stack)
>
>
>>> +{
>
>
>>> +	unsigned long random;
>
>
>>> +
>
>
>>> +	random = (current->flags & PF_RANDOMIZE) ?
>
>
>>> +		arch_mmap_rnd() : 0UL;
>
>
>>> +
>
>
>>> +	if (mmap_is_legacy(rlim_stack))
>
>
>>> +		mm->mmap_legacy_base = TASK_UNMAPPED_BASE + random;
>
>
>>> +	else
>
>
>>> +		mm->mmap_base = mmap_base(random, rlim_stack);
>
>
>>> +}
>
>
>>> +
>
>
>>> +void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
>
>
>>> +{
>
>
>>> +	if (mmap_is_legacy(rlim_stack))
>
>
>>> +		mm->get_unmapped_area = arch_get_unmapped_area;
>
>
>>> +	else
>
>
>>> +		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
>
>
>>> +
>
>
>>> +	arch_pick_mmap_base(mm, rlim_stack);
>
>
>>> +}
>
>
>>> +
>
>
>>> +unsigned long arch_randomize_brk(struct mm_struct *mm)
>
>
>>> +{
>
>
>>> +	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
>
>
>>> +		return randomize_page(mm->brk, SZ_32M);
>
>
>>> +
>
>
>>> +	return randomize_page(mm->brk, SZ_1G);
>
>
>>> +}
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
