Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAEC3E4C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhHISWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhHISWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:22:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC7C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 11:21:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i6so26044155edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftVuG4BqRClWmA3Iio5cpbFgJTgza3Lrv72uDZY9cX8=;
        b=e2p4CwB/Sdak06YFwWS7xB4log0ZLI12SaQRtv3oOwJk9Y1m/p2aHkWA9SXpiWB7db
         4qiHOYULfYTOdeHxYQWEx/5VwB1xajImW+W4fWHq0g5fR/Y7vIRkQU8F27QD4CU9hlUN
         ydC+Uo2y6YkPDQ4tSfINsRT31ruCMsn68e90LnpsA1dW44msW/vq3sr2NPuZGK6byQkt
         pEE276iAeBaGZ2f0SF+9nYjxp08s5Ye3fq3rlH15G+NMZ96E7/dHkBDUmO6kRjrN23Zj
         z61c6PTYtueLYPvUjNE9Hi0SE09dxAbGbTxMWVqE1SvfAhDwuEqFildI9CS9X5AkxglC
         C3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftVuG4BqRClWmA3Iio5cpbFgJTgza3Lrv72uDZY9cX8=;
        b=HyBIgd6/wudnWF1Vkvytdg7jH5k6HGLnPSNcWeZloRrr6wBjiw/n6P1p3nAAgQNPrx
         DEZUYqdfDMUl59DbILORDEoiMel9T+diM2n3UO4DY1LPjcBuvBhBQk1GFei5gCLeYkgZ
         jjJtmXQLPrwiPlFDGc11DYY1jG7qJQ7tucV0kA3zF4udZA9r8LJIRHZl0AQIoZzERtFV
         2UrbaF7g27VUaAmXeGNRKhadOaPfaQScX2z3dzbDJeircd1Opbm9Fo1+lVE7J0obBDUN
         uLT5ZTBhms1n8ZgmPmTmMjFE7zvNv+pnxrk28FIW4+BRDAZRy0X4aiEdyVCbwlqEzvdX
         izFQ==
X-Gm-Message-State: AOAM5316rqmquIPOgZ7KjVb5A7yMycm29X1dKHRRN/AkwFB1Jx+Y1M/z
        Mun0GlsSsLw20sCaMjb/bFFWDcKBs1m+JTG52kbe0bO/
X-Google-Smtp-Source: ABdhPJwEhGwSIXgli6nG4803LQR6iq+nzIISsQgAN1rnQR35jYEBmUSgZ3LvSYtmKRVnui1444iQUzixdY6Mjkto+o4=
X-Received: by 2002:a05:6402:430b:: with SMTP id m11mr31667971edc.55.1628533317269;
 Mon, 09 Aug 2021 11:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210809093750.131091-1-wangkefeng.wang@huawei.com> <20210809093750.131091-4-wangkefeng.wang@huawei.com>
In-Reply-To: <20210809093750.131091-4-wangkefeng.wang@huawei.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 9 Aug 2021 20:21:46 +0200
Message-ID: <CA+fCnZcL7tv=HsXJjXMayjASeAriy6N0HJwCoH7iPZZ6hqZGQw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash with KASAN_VMALLOC
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 11:32 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
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
> ---
>  arch/arm64/mm/kasan_init.c | 16 ++++++++++++++++
>  include/linux/kasan.h      |  6 ++++++
>  mm/kasan/init.c            |  5 +++++
>  mm/vmalloc.c               |  1 +
>  4 files changed, 28 insertions(+)
>
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 61b52a92b8b6..5b996ca4d996 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -287,6 +287,22 @@ static void __init kasan_init_depth(void)
>         init_task.kasan_depth = 0;
>  }
>
> +#ifdef CONFIG_KASAN_VMALLOC
> +void __init kasan_populate_early_vm_area_shadow(void *start, unsigned long size)
> +{
> +       unsigned long shadow_start, shadow_end;
> +
> +       if (!is_vmalloc_or_module_addr(start))
> +               return;
> +
> +       shadow_start = (unsigned long)kasan_mem_to_shadow(start);
> +       shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
> +       shadow_end = (unsigned long)kasan_mem_to_shadow(start + size);
> +       shadow_end = ALIGN(shadow_end, PAGE_SIZE);
> +       kasan_map_populate(shadow_start, shadow_end, NUMA_NO_NODE);
> +}
> +#endif
> +
>  void __init kasan_init(void)
>  {
>         kasan_init_shadow();
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index dd874a1ee862..3f8c26d9ef82 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -133,6 +133,8 @@ struct kasan_cache {
>         bool is_kmalloc;
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
> +                                                      unsigned long size)
> +{ }
> +
>  static inline slab_flags_t kasan_never_merge(void)
>  {
>         return 0;
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index cc64ed6858c6..d39577d088a1 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -279,6 +279,11 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>         return 0;
>  }
>
> +void __init __weak kasan_populate_early_vm_area_shadow(void *start,
> +                                                      unsigned long size)
> +{
> +}
> +
>  static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
>  {
>         pte_t *pte;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 1e8fe08725b8..66a7e1ea2561 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2253,6 +2253,7 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
>         vm->addr = (void *)addr;
>
>         vm_area_add_early(vm);
> +       kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
>  }
>
>  static void vmap_init_free_space(void)
> --
> 2.26.2
>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

for KASAN parts.

Thanks!
