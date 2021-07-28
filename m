Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA26B3D888F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbhG1HI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhG1HI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:08:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB02C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:08:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id f13so1757906edq.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 00:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JjPvEowFGL6UZrwIae4+mX8GEAM2UbRoPh6+ytUjR30=;
        b=oFr5K/fpoahCow/gRvyhTXkPSF4bv2YLwLJzZt2uu6dw5Hck0k5xUjLq6aFWIKQJPf
         53eNIV/ipD0wqKB+uf0ISBer4oVNr1BW6QBmHnApQBLKPHSJJuj1gmn8XyCOZr9ZidfW
         0oc4aD6Tox0SQJV+/fdwrIX70ohwBldvZWUdf/+jYHtPACnCBePUPtO2QQGyC8IF23dN
         Hb89hboNgrwjuanTqqNtgWME4FympMrkX8TWAi/js3ppfe7/ohslnurhLq7iKzmOsEd1
         XaqDXXnR90iVvTYBC/5AB1x7hlh8nCfDHmXSXydA9IIgXmKG7d9PorWlGgSCO1nfLOys
         jmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JjPvEowFGL6UZrwIae4+mX8GEAM2UbRoPh6+ytUjR30=;
        b=RNIJY5c8UVQIF1GkFoULZlWMgJ1u/vXhMWnd9ALnYHryUQKUIRLGokD/VorrM22XKK
         Ly9hKPACU38Ps4ihN2kd0zBFyxWHnRVJMvjBIIBIFYKxYPCES10W4aHidGVYM7v3DJCu
         TOT/rS7mxiEU/DSBumvsGfwoQyXUOro0+CMdVqI1VJHy2fxIoTZD8lCKffsBnkfLWkVp
         qWkITFEVxk6VocBPaHO87ZyKO+RNlsNBufk94jD3Kpxvqb0hPAAF9mCq3Ox3bP5N4H8b
         8NwGic2N8qnlYt+a4kPOd49SvcL+a2WdUp/LmXraX4cWzHZqj3KDiCP3D/vUsZwJU0jh
         tdmg==
X-Gm-Message-State: AOAM533SmEMKgjHgYQrqvj5QVKu/Ic9/VLldMxlT46BWYNarS9H3XJAb
        bxIK7XrcUBdqtxOGwOBko6DIj6ZG77oU8VkxI5I=
X-Google-Smtp-Source: ABdhPJxYBTroTzdxy9YKmu/HMBDj6pWRxK9c3ND7B09OSrNtoGisb4PHyGgi37KgQI4hcsT+ZiuQ2rbE2qkBENIVkZg=
X-Received: by 2002:a05:6402:524b:: with SMTP id t11mr32165551edd.361.1627456134487;
 Wed, 28 Jul 2021 00:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210728064318.375747-1-nek.in.cn@gmail.com> <YQD/Zb0EszIWr6RJ@kernel.org>
In-Reply-To: <YQD/Zb0EszIWr6RJ@kernel.org>
From:   Lee Ken <nek.in.cn@gmail.com>
Date:   Wed, 28 Jul 2021 15:08:43 +0800
Message-ID: <CA+CqrBTPT+dFJk7L1gzjuGn_6W2QJquNXtTdH3c_iHAmSodRgA@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix the global name pfn_base confliction error
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com, Zhou Wang <wangzhou1@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

indeed. I'll send a new one.

On Wed, Jul 28, 2021 at 2:55 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Wed, Jul 28, 2021 at 02:43:18PM +0800, Kenneth Lee wrote:
> > From: Kenneth Lee <liguozhu@hisilicon.com>
> >
> > RISCV use a global variable pfn_base for page/pfn translation. But this
> > is a common name and will be used elsewhere. In those case,
> > the page-pfn macro which refer this name will refer to the local/input
> > variable of those function (such as in vfio_pin_pages_remote). This make
> > everything wrong.
> >
> > This patch change the name from pfn_base to riscv_global_pfn_base to fix
>
> I think global is excessive, just riscv_pfn_base should be ok for proper
> namespacing.
>
> > this problem
> >
> > Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> > ---
> >  arch/riscv/include/asm/page.h | 4 ++--
> >  arch/riscv/mm/init.c          | 6 +++---
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > index cca8764aed83..8711e415f37c 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -79,8 +79,8 @@ typedef struct page *pgtable_t;
> >  #endif
> >
> >  #ifdef CONFIG_MMU
> > -extern unsigned long pfn_base;
> > -#define ARCH_PFN_OFFSET              (pfn_base)
> > +extern unsigned long riscv_global_pfn_base;
> > +#define ARCH_PFN_OFFSET              (riscv_global_pfn_base)
> >  #else
> >  #define ARCH_PFN_OFFSET              (PAGE_OFFSET >> PAGE_SHIFT)
> >  #endif /* CONFIG_MMU */
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index a14bf3910eec..2ce4e9a46ca0 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -228,8 +228,8 @@ static struct pt_alloc_ops _pt_ops __initdata;
> >  #define pt_ops _pt_ops
> >  #endif
> >
> > -unsigned long pfn_base __ro_after_init;
> > -EXPORT_SYMBOL(pfn_base);
> > +unsigned long riscv_global_pfn_base __ro_after_init;
> > +EXPORT_SYMBOL(riscv_global_pfn_base);
> >
> >  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> >  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> > @@ -572,7 +572,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >       kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
> >  #endif
> >
> > -     pfn_base = PFN_DOWN(kernel_map.phys_addr);
> > +     riscv_global_pfn_base = PFN_DOWN(kernel_map.phys_addr);
> >
> >       /*
> >        * Enforce boot alignment requirements of RV32 and
> > --
> > 2.25.1
> >
>
> --
> Sincerely yours,
> Mike.
