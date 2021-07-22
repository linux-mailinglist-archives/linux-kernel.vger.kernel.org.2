Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20E13D225E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 13:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhGVKUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 06:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhGVKUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 06:20:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 04:01:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f9so5446411wrq.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 04:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yw+1MR2KgBc9luUx0cAPZIkqUAmN57bRrzE4rXs4RXE=;
        b=YrvoAqcZ3pjMit8K5uQ4lV8aD+UMAEVxI3bIcq7wcK9y8r35qoGTVmstJBHJ/vxZbs
         updxXU7rJi3zDrcY13xc56g7QZHX9wAWhbnG1KRap7i+MTL41YVBKaBrWryi0PYS5sPE
         hAuYUeFYuGJdwBB24WWKytx98ts3a8kZWEFTkm6sV3XGQZxqagWUrawvKuuRKJzqDojg
         SQyuXzqLVp5fSbIRsvhmsED5D7/Ob4DP0gWTcerwadDyiItBj42QelSlm2bIRZcGfuLV
         mkXsREeOs11h3Lkh2OB0hyp6UCd/58iBubIC6ZSwvl6TKYxlJOs8U5x0XYkm27DF4JXz
         zLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yw+1MR2KgBc9luUx0cAPZIkqUAmN57bRrzE4rXs4RXE=;
        b=uA6r+hANzRqRjOtFhwn1g2jlHulkTMAQA4BeZuF7SzSVxmA4kz9k30J8c/uq436Em+
         79KIBFjEIOU71she63alS9PBtChJkoW/2yyi4MJWiuevgJWAB1ObA9xauFuw0DhAMGx1
         /a7gNFZkicQZwNlPAzmrs0JiUHRZHGZGljfmndMlxKlFQU0MTEa6HJ0yFRaytxcRZ8mF
         1PSQXM4jgw3VDqwoSU4km6wy7P0LcWuZYTvR34ZiZ6yfVtlqSsx6NUmmanQy5rht0FsS
         9w0sBiJDyfi8CCpcvKHNcWqwhKbzhUrxbNzH6Vc3GLn7fsa/a9ErDxG28Wr9GJycRzs/
         Z7Kg==
X-Gm-Message-State: AOAM532+JeoV8rIQLwV/WEi/WXWoG2nDFy9N+w0llwMp0kBasYk1pxXS
        39cns9IJ8W7BDZxsA0tJNyLWvw==
X-Google-Smtp-Source: ABdhPJxoe+m7SpT35NQc2fTiiRalGqem0yhndVZ3OAcEmw8Um36eLeMOFTpgLyePBa7OHXZwgmNSBw==
X-Received: by 2002:adf:ffd1:: with SMTP id x17mr26958377wrs.411.1626951665168;
        Thu, 22 Jul 2021 04:01:05 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:f1d2:f5fd:de90:c735])
        by smtp.gmail.com with ESMTPSA id a8sm29702579wrt.61.2021.07.22.04.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 04:01:04 -0700 (PDT)
Date:   Thu, 22 Jul 2021 13:00:58 +0200
From:   Marco Elver <elver@google.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash
 with KASAN_VMALLOC
Message-ID: <YPlP6h4O1WA0NVDs@elver.google.com>
References: <20210720025105.103680-1-wangkefeng.wang@huawei.com>
 <20210720025105.103680-4-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720025105.103680-4-wangkefeng.wang@huawei.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:51AM +0800, Kefeng Wang wrote:
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
>  kasan_check_range+0x90/0x1a0
>  pcpu_page_first_chunk+0x3f0/0x568
>  setup_per_cpu_areas+0xb8/0x184
>  start_kernel+0x8c/0x328
> 
> The vm area used in vm_area_register_early() has no kasan shadow memory,
> Let's add a new kasan_populate_early_vm_area_shadow() function to populate
> the vm area shadow memory to fix the issue.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Marco Elver <elver@google.com>

for the kasan bits.

> ---
>  arch/arm64/mm/kasan_init.c | 17 +++++++++++++++++
>  include/linux/kasan.h      |  6 ++++++
>  mm/kasan/init.c            |  5 +++++
>  mm/vmalloc.c               |  1 +
>  4 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 61b52a92b8b6..46c1b3722901 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -287,6 +287,23 @@ static void __init kasan_init_depth(void)
>  	init_task.kasan_depth = 0;
>  }
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
> +	kasan_map_populate(shadow_start, shadow_end,
> +			   early_pfn_to_nid(virt_to_pfn(start)));
> +}
> +#endif
> +
>  void __init kasan_init(void)
>  {
>  	kasan_init_shadow();
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index dd874a1ee862..3f8c26d9ef82 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -133,6 +133,8 @@ struct kasan_cache {
>  	bool is_kmalloc;
>  };
>  
> +void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
> +
>  slab_flags_t __kasan_never_merge(void);
>  static __always_inline slab_flags_t kasan_never_merge(void)
>  {
> @@ -303,6 +305,10 @@ void kasan_restore_multi_shot(bool enabled);
>  
>  #else /* CONFIG_KASAN */
>  
> +static inline void kasan_populate_early_vm_area_shadow(void *start,
> +						       unsigned long size)
> +{ }
> +
>  static inline slab_flags_t kasan_never_merge(void)
>  {
>  	return 0;
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index cc64ed6858c6..d39577d088a1 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -279,6 +279,11 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>  	return 0;
>  }
>  
> +void __init __weak kasan_populate_early_vm_area_shadow(void *start,
> +						       unsigned long size)
> +{
> +}
> +
>  static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
>  {
>  	pte_t *pte;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index a98cf97f032f..f19e07314ee5 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2249,6 +2249,7 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
>  	vm->addr = (void *)addr;
>  
>  	vm_area_add_early(vm);
> +	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
>  }
>  
>  static void vmap_init_free_space(void)
> -- 
> 2.26.2
