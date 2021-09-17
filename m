Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9640F2A5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 08:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbhIQG4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 02:56:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19991 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIQG4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 02:56:47 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H9l3N2yCXzbmb8;
        Fri, 17 Sep 2021 14:51:12 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 17 Sep 2021 14:55:20 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 17 Sep 2021 14:55:19 +0800
Subject: Re: [PATCH v4 2/3] arm64: Support page mapping percpu first chunk
 allocator
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <ryabinin.a.a@gmail.com>, <andreyknvl@gmail.com>,
        <dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <elver@google.com>, <akpm@linux-foundation.org>,
        <kasan-dev@googlegroups.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
 <20210910053354.26721-3-wangkefeng.wang@huawei.com>
 <YUQ0lvldA+wGpr0G@kroah.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <9b2e89c4-a821-8657-0ffb-d822aa51936c@huawei.com>
Date:   Fri, 17 Sep 2021 14:55:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YUQ0lvldA+wGpr0G@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/17 14:24, Greg KH wrote:
> On Fri, Sep 10, 2021 at 01:33:53PM +0800, Kefeng Wang wrote:
>> Percpu embedded first chunk allocator is the firstly option, but it
>> could fails on ARM64, eg,
>>    "percpu: max_distance=0x5fcfdc640000 too large for vmalloc space 0x781fefff0000"
>>    "percpu: max_distance=0x600000540000 too large for vmalloc space 0x7dffb7ff0000"
>>    "percpu: max_distance=0x5fff9adb0000 too large for vmalloc space 0x5dffb7ff0000"
>>   
>> then we could meet "WARNING: CPU: 15 PID: 461 at vmalloc.c:3087 pcpu_get_vm_areas+0x488/0x838",
>> even the system could not boot successfully.
>>
>> Let's implement page mapping percpu first chunk allocator as a fallback
>> to the embedding allocator to increase the robustness of the system.
>>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   arch/arm64/Kconfig       |  4 ++
>>   drivers/base/arch_numa.c | 82 +++++++++++++++++++++++++++++++++++-----
>>   2 files changed, 76 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 077f2ec4eeb2..04cfe1b4e98b 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1042,6 +1042,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>>   	def_bool y
>>   	depends on NUMA
>>   
>> +config NEED_PER_CPU_PAGE_FIRST_CHUNK
>> +	def_bool y
>> +	depends on NUMA
> Why is this a config option at all?

The config is introduced from

commit 08fc45806103e59a37418e84719b878f9bb32540
Author: Tejun Heo <tj@kernel.org>
Date:   Fri Aug 14 15:00:49 2009 +0900

     percpu: build first chunk allocators selectively

     There's no need to build unused first chunk allocators in. Define
     CONFIG_NEED_PER_CPU_*_FIRST_CHUNK and let archs enable them
     selectively.

For now, there are three ARCHs support both PER_CPU_EMBED_FIRST_CHUNK

and PER_CPU_PAGE_FIRST_CHUNK.

   arch/powerpc/Kconfig:config NEED_PER_CPU_PAGE_FIRST_CHUNK
   arch/sparc/Kconfig:config NEED_PER_CPU_PAGE_FIRST_CHUNK
   arch/x86/Kconfig:config NEED_PER_CPU_PAGE_FIRST_CHUNK

and we have a cmdline to choose a alloctor.

    percpu_alloc=   Select which percpu first chunk allocator to use.
                    Currently supported values are "embed" and "page".
                    Archs may support subset or none of the selections.
                    See comments in mm/percpu.c for details on each
                    allocator.  This parameter is primarily for debugging
                    and performance comparison.

embed percpu first chunk allocator is the first choice, but it could 
fails due to some

memory layout(it does occurs on ARM64 too.), so page mapping percpu 
first chunk

allocator is as a fallback, that is what this patch does.

>
>> +
>>   source "kernel/Kconfig.hz"
>>   
>>   config ARCH_SPARSEMEM_ENABLE
>> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
>> index 46c503486e96..995dca9f3254 100644
>> --- a/drivers/base/arch_numa.c
>> +++ b/drivers/base/arch_numa.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/of.h>
>>   
>>   #include <asm/sections.h>
>> +#include <asm/pgalloc.h>
>>   
>>   struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
>>   EXPORT_SYMBOL(node_data);
>> @@ -168,22 +169,83 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
>>   	memblock_free_early(__pa(ptr), size);
>>   }
>>   
>> +#ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
> Ick, no #ifdef in .c files if at all possible please.

The drivers/base/arch_numa.c is shared by RISCV/ARM64, so I add this 
config to

no need to build this part on RISCV.

>
>> +static void __init pcpu_populate_pte(unsigned long addr)
>> +{
>> +	pgd_t *pgd = pgd_offset_k(addr);
>> +	p4d_t *p4d;
>> +	pud_t *pud;
>> +	pmd_t *pmd;
>> +
>> +	p4d = p4d_offset(pgd, addr);
>> +	if (p4d_none(*p4d)) {
>> +		pud_t *new;
>> +
>> +		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> +		if (!new)
>> +			goto err_alloc;
>> +		p4d_populate(&init_mm, p4d, new);
>> +	}
>> +
>> +	pud = pud_offset(p4d, addr);
>> +	if (pud_none(*pud)) {
>> +		pmd_t *new;
>> +
>> +		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> +		if (!new)
>> +			goto err_alloc;
>> +		pud_populate(&init_mm, pud, new);
>> +	}
>> +
>> +	pmd = pmd_offset(pud, addr);
>> +	if (!pmd_present(*pmd)) {
>> +		pte_t *new;
>> +
>> +		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>> +		if (!new)
>> +			goto err_alloc;
>> +		pmd_populate_kernel(&init_mm, pmd, new);
>> +	}
>> +
>> +	return;
>> +
>> +err_alloc:
>> +	panic("%s: Failed to allocate %lu bytes align=%lx from=%lx\n",
>> +	      __func__, PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
> That feels harsh, are you sure you want to crash?  There's no way to
> recover from this?  If not, how can this fail in real life?
Yes,  if no memory, the system won't work, panic is the only choose.
>
>> +}
>> +#endif
>> +
>>   void __init setup_per_cpu_areas(void)
>>   {
>>   	unsigned long delta;
>>   	unsigned int cpu;
>> -	int rc;
>> +	int rc = -EINVAL;
>> +
>> +	if (pcpu_chosen_fc != PCPU_FC_PAGE) {
>> +		/*
>> +		 * Always reserve area for module percpu variables.  That's
>> +		 * what the legacy allocator did.
>> +		 */
>> +		rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
>> +					    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
>> +					    pcpu_cpu_distance,
>> +					    pcpu_fc_alloc, pcpu_fc_free);
>> +#ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
>> +		if (rc < 0)
>> +			pr_warn("PERCPU: %s allocator failed (%d), falling back to page size\n",
>> +				   pcpu_fc_names[pcpu_chosen_fc], rc);
>> +#endif
> Why only print out a message for a config option?  Again, no #ifdef in
> .c files if at all possible.

Same reason as above.

Thanks for your review.

>
> thanks,
>
> greg k-h
> .
>
