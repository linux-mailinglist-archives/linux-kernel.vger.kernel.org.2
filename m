Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B613E446D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhHILKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:10:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16998 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhHILKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:10:34 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GjtZ11gHqzb06D;
        Mon,  9 Aug 2021 19:06:33 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 19:10:10 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 19:10:10 +0800
Subject: Re: [PATCH v3 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash with
 KASAN_VMALLOC
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <ryabinin.a.a@gmail.com>, <andreyknvl@gmail.com>,
        <dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <elver@google.com>
References: <20210809093750.131091-1-wangkefeng.wang@huawei.com>
 <20210809093750.131091-4-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <ae15c02e-d825-dbef-1419-5b5220f826c1@huawei.com>
Date:   Mon, 9 Aug 2021 19:10:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210809093750.131091-4-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/9 17:37, Kefeng Wang wrote:
> With KASAN_VMALLOC and NEED_PER_CPU_PAGE_FIRST_CHUNK, it crashs,
>
> Unable to handle kernel paging request at virtual address ffff7000028f2000
> ...
> swapper pgtable: 64k pages, 48-bit VAs, pgdp=0000000042440000
> [ffff7000028f2000] pgd=000000063e7c0003, p4d=000000063e7c0003, pud=000000063e7c0003, pmd=000000063e7b0003, pte=0000000000000000
> Internal error: Oops: 96000007 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.0-rc4-00003-gc6e6e28f3f30-dirty #62
> Hardware name: linux,dummy-virt (DT)
> pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO BTYPE=--)
> pc : kasan_check_range+0x90/0x1a0
> lr : memcpy+0x88/0xf4
> sp : ffff80001378fe20
> ...
> Call trace:
>   kasan_check_range+0x90/0x1a0
>   pcpu_page_first_chunk+0x3f0/0x568
>   setup_per_cpu_areas+0xb8/0x184
>   start_kernel+0x8c/0x328
>
> The vm area used in vm_area_register_early() has no kasan shadow memory,
> Let's add a new kasan_populate_early_vm_area_shadow() function to populate
> the vm area shadow memory to fix the issue.

Should add Acked-by: Marco Elver <elver@google.com> [for KASAN parts] ,

missed here :(

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   arch/arm64/mm/kasan_init.c | 16 ++++++++++++++++
>   include/linux/kasan.h      |  6 ++++++
>   mm/kasan/init.c            |  5 +++++
>   mm/vmalloc.c               |  1 +
>   4 files changed, 28 insertions(+)
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 61b52a92b8b6..5b996ca4d996 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -287,6 +287,22 @@ static void __init kasan_init_depth(void)
>   	init_task.kasan_depth = 0;
>   }
>   
> +#ifdef CONFIG_KASAN_VMALLOC
> +void __init kasan_populate_early_vm_area_shadow(void *start, unsigned long size)
> +{
> +	unsigned long shadow_start, shadow_end;
> +
> +	if (!is_vmalloc_or_module_addr(start))
> +		return;
> +
> +	shadow_start = (unsigned long)kasan_mem_to_shadow(start);
> +	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
> +	shadow_end = (unsigned long)kasan_mem_to_shadow(start + size);
> +	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
> +	kasan_map_populate(shadow_start, shadow_end, NUMA_NO_NODE);
> +}
> +#endif
> +
>   void __init kasan_init(void)
>   {
>   	kasan_init_shadow();
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index dd874a1ee862..3f8c26d9ef82 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -133,6 +133,8 @@ struct kasan_cache {
>   	bool is_kmalloc;
>   };
>   
> +void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
> +
>   slab_flags_t __kasan_never_merge(void);
>   static __always_inline slab_flags_t kasan_never_merge(void)
>   {
> @@ -303,6 +305,10 @@ void kasan_restore_multi_shot(bool enabled);
>   
>   #else /* CONFIG_KASAN */
>   
> +static inline void kasan_populate_early_vm_area_shadow(void *start,
> +						       unsigned long size)
> +{ }
> +
>   static inline slab_flags_t kasan_never_merge(void)
>   {
>   	return 0;
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index cc64ed6858c6..d39577d088a1 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -279,6 +279,11 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>   	return 0;
>   }
>   
> +void __init __weak kasan_populate_early_vm_area_shadow(void *start,
> +						       unsigned long size)
> +{
> +}
> +
>   static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
>   {
>   	pte_t *pte;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 1e8fe08725b8..66a7e1ea2561 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2253,6 +2253,7 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
>   	vm->addr = (void *)addr;
>   
>   	vm_area_add_early(vm);
> +	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
>   }
>   
>   static void vmap_init_free_space(void)
