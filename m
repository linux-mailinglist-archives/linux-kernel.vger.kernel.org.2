Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5F3DCEC1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 04:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhHBCrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 22:47:19 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12436 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhHBCrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 22:47:18 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GdMkw0WYZzcjk4;
        Mon,  2 Aug 2021 10:43:36 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 10:47:05 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 10:47:04 +0800
Subject: Re: [PATCH v2 2/3] arm64: Support page mapping percpu first chunk
 allocator
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210720025105.103680-1-wangkefeng.wang@huawei.com>
 <20210720025105.103680-3-wangkefeng.wang@huawei.com>
 <20210801155302.GA29188@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <c98e372c-be3e-0440-f37c-0dd0bf8f79c3@huawei.com>
Date:   Mon, 2 Aug 2021 10:47:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210801155302.GA29188@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/1 23:53, Catalin Marinas wrote:
> On Tue, Jul 20, 2021 at 10:51:04AM +0800, Kefeng Wang wrote:
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
> It looks like x86, powerpc and sparc implement their own
> setup_per_cpu_areas(). I had a quick look on finding some commonalities
> but I think it's a lot more hassle to make a generic version out of them
> (powerpc looks the simplest though). I think we could add a generic
> variant with the arm64 support and later migrate other architectures to
> it if possible.
Ok, let's do it later, I could try to make some cleanup after the 
patchset is merged ;)
> The patch looks ok to me otherwise but I'd need an ack from Greg as it
> touches drivers/.

the arch_numa is only used ARM64 and riscv, the 
NEED_PER_CPU_PAGE_FIRST_CHUNK

is not enabled on RISCV, so it's no bad effect.

>
> BTW, do we need something similar for the non-NUMA
> setup_per_cpu_areas()? I can see this patch only enables
> NEED_PER_CPU_PAGE_FIRST_CHUNK if NUMA.
>
> Leaving the rest of the patch below for Greg.
>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   arch/arm64/Kconfig       |  4 ++
>>   drivers/base/arch_numa.c | 82 +++++++++++++++++++++++++++++++++++-----
>>   2 files changed, 76 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b5b13a932561..eacb5873ded1 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -1045,6 +1045,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>>   	def_bool y
>>   	depends on NUMA
>>   
>> +config NEED_PER_CPU_PAGE_FIRST_CHUNK
>> +	def_bool y
>> +	depends on NUMA
>> +
>>   source "kernel/Kconfig.hz"
>>   
>>   config ARCH_SPARSEMEM_ENABLE
>> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
>> index 4cc4e117727d..563b2013b75a 100644
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
>> +	}
>>   
>> -	/*
>> -	 * Always reserve area for module percpu variables.  That's
>> -	 * what the legacy allocator did.
>> -	 */
>> -	rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
>> -				    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
>> -				    pcpu_cpu_distance,
>> -				    pcpu_fc_alloc, pcpu_fc_free);
>> +#ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
>> +	if (rc < 0)
>> +		rc = pcpu_page_first_chunk(PERCPU_MODULE_RESERVE,
>> +					   pcpu_fc_alloc,
>> +					   pcpu_fc_free,
>> +					   pcpu_populate_pte);
>> +#endif
>>   	if (rc < 0)
>> -		panic("Failed to initialize percpu areas.");
>> +		panic("Failed to initialize percpu areas (err=%d).", rc);
>>   
>>   	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
>>   	for_each_possible_cpu(cpu)
>> -- 
>> 2.26.2
> .
>
