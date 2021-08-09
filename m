Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A34E3E4492
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhHILWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 07:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbhHILWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 07:22:16 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84295C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 04:21:56 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x15so22954759oic.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkFYGolSn2w76q7qvE9Vgn56UKUzs1q54gLC/lVyUL0=;
        b=nTtfeLWmlog6HIdLAdJWj+U2ll9LsyOAiDIU37OqlU+wNkW06mzFthb3f13iLu2sko
         gCngmmCfLVZI/cwANabGrtvm4GOBAwyG+imZLE+Ge0iHRC4QPDlSW2XzKAfUPk6Fe+vr
         FZY6qy0YCXNPKlpJSxL+XWQYJrzbH59GPQEwNnaATrI16KEUvKYEnHB1DYx+PkrSSIq+
         lxofn9poMXLJyZZY9yYKKolURLjvFzQ62TjO9AWNwhY+/oO1k2tm/iX8VFCx3yoMU1Lh
         DId6g6IzFAYitx5J5OzdurL+dE7DnMmuzL6jNtmXnOMopmnhC8EtcVjFnF82s74ha0zM
         cYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkFYGolSn2w76q7qvE9Vgn56UKUzs1q54gLC/lVyUL0=;
        b=OHsPb9VFxpcrwzQ/ugk7ZC3FJUsPK8WnkQuZiB11Sbc5a+qCoHckfsyQPkKEbGp4uY
         1oXYC16C7h9CmHHD9QI4YhntI0yCzFlbbLXeSIYIcdgSrHjHrXo1bhXBXWVAyk64tkis
         gcuy1pAcuIGRZ4VHfzB3wgUqW1LpBBIUKNEIJF/4ZA85kFhKVrlnngHNalfHef0hJg2H
         6IEyfLaE8Wj4InD5FpdWk5k8f0rb+VAmftwbDAKt0ILqxITBEKLLsar3um+g7JIgKUEi
         8AL2FjT4x3OF3x9YwVCQIO04YPV+GyjfarXJZgzqakBFbHM8ovVdOO4jHwZro7XTzCUY
         LGVw==
X-Gm-Message-State: AOAM532I8dz7IenjVlJFHINSuH48SMy/QrzVyCfPs7wNqFFJ/sy5m441
        6PiFA9LbnSz1JSONU6IxYuQf/6TcNFCc7P2LZrDOKA==
X-Google-Smtp-Source: ABdhPJw2dAx0xwZwf7oFVAglW4Mx/VmIQLu0Vm32HDbc5/1HQi39uzQswpjxiizzKhJAa4SszTrlfB8qBvg9IZhyb4I=
X-Received: by 2002:aca:2316:: with SMTP id e22mr9967822oie.172.1628508115719;
 Mon, 09 Aug 2021 04:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210809093750.131091-1-wangkefeng.wang@huawei.com>
 <20210809093750.131091-4-wangkefeng.wang@huawei.com> <ae15c02e-d825-dbef-1419-5b5220f826c1@huawei.com>
In-Reply-To: <ae15c02e-d825-dbef-1419-5b5220f826c1@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 9 Aug 2021 13:21:44 +0200
Message-ID: <CANpmjNOM-fzk2_q9LNLgM1wSReHWj42MxHBeDBLg8Ga5vv8HhQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash with KASAN_VMALLOC
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, ryabinin.a.a@gmail.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021 at 13:10, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
> On 2021/8/9 17:37, Kefeng Wang wrote:
> > With KASAN_VMALLOC and NEED_PER_CPU_PAGE_FIRST_CHUNK, it crashs,
> >
> > Unable to handle kernel paging request at virtual address ffff7000028f2000
> > ...
> > swapper pgtable: 64k pages, 48-bit VAs, pgdp=0000000042440000
> > [ffff7000028f2000] pgd=000000063e7c0003, p4d=000000063e7c0003, pud=000000063e7c0003, pmd=000000063e7b0003, pte=0000000000000000
> > Internal error: Oops: 96000007 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.0-rc4-00003-gc6e6e28f3f30-dirty #62
> > Hardware name: linux,dummy-virt (DT)
> > pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO BTYPE=--)
> > pc : kasan_check_range+0x90/0x1a0
> > lr : memcpy+0x88/0xf4
> > sp : ffff80001378fe20
> > ...
> > Call trace:
> >   kasan_check_range+0x90/0x1a0
> >   pcpu_page_first_chunk+0x3f0/0x568
> >   setup_per_cpu_areas+0xb8/0x184
> >   start_kernel+0x8c/0x328
> >
> > The vm area used in vm_area_register_early() has no kasan shadow memory,
> > Let's add a new kasan_populate_early_vm_area_shadow() function to populate
> > the vm area shadow memory to fix the issue.
>
> Should add Acked-by: Marco Elver <elver@google.com> [for KASAN parts] ,

My Ack is still valid, thanks for noting.

> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >   arch/arm64/mm/kasan_init.c | 16 ++++++++++++++++
> >   include/linux/kasan.h      |  6 ++++++
> >   mm/kasan/init.c            |  5 +++++
> >   mm/vmalloc.c               |  1 +
> >   4 files changed, 28 insertions(+)
> >
> > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > index 61b52a92b8b6..5b996ca4d996 100644
> > --- a/arch/arm64/mm/kasan_init.c
> > +++ b/arch/arm64/mm/kasan_init.c
> > @@ -287,6 +287,22 @@ static void __init kasan_init_depth(void)
> >       init_task.kasan_depth = 0;
> >   }
> >
> > +#ifdef CONFIG_KASAN_VMALLOC
> > +void __init kasan_populate_early_vm_area_shadow(void *start, unsigned long size)
> > +{
> > +     unsigned long shadow_start, shadow_end;
> > +
> > +     if (!is_vmalloc_or_module_addr(start))
> > +             return;
> > +
> > +     shadow_start = (unsigned long)kasan_mem_to_shadow(start);
> > +     shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
> > +     shadow_end = (unsigned long)kasan_mem_to_shadow(start + size);
> > +     shadow_end = ALIGN(shadow_end, PAGE_SIZE);
> > +     kasan_map_populate(shadow_start, shadow_end, NUMA_NO_NODE);
> > +}
> > +#endif
> > +
> >   void __init kasan_init(void)
> >   {
> >       kasan_init_shadow();
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index dd874a1ee862..3f8c26d9ef82 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -133,6 +133,8 @@ struct kasan_cache {
> >       bool is_kmalloc;
> >   };
> >
> > +void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
> > +
> >   slab_flags_t __kasan_never_merge(void);
> >   static __always_inline slab_flags_t kasan_never_merge(void)
> >   {
> > @@ -303,6 +305,10 @@ void kasan_restore_multi_shot(bool enabled);
> >
> >   #else /* CONFIG_KASAN */
> >
> > +static inline void kasan_populate_early_vm_area_shadow(void *start,
> > +                                                    unsigned long size)
> > +{ }
> > +
> >   static inline slab_flags_t kasan_never_merge(void)
> >   {
> >       return 0;
> > diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> > index cc64ed6858c6..d39577d088a1 100644
> > --- a/mm/kasan/init.c
> > +++ b/mm/kasan/init.c
> > @@ -279,6 +279,11 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
> >       return 0;
> >   }
> >
> > +void __init __weak kasan_populate_early_vm_area_shadow(void *start,
> > +                                                    unsigned long size)
> > +{
> > +}
> > +
> >   static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
> >   {
> >       pte_t *pte;
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 1e8fe08725b8..66a7e1ea2561 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2253,6 +2253,7 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
> >       vm->addr = (void *)addr;
> >
> >       vm_area_add_early(vm);
> > +     kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
> >   }
> >
> >   static void vmap_init_free_space(void)
