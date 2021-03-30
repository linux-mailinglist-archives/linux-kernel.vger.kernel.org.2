Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E3D34E4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhC3JsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:48:06 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:40870 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhC3Jrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:47:42 -0400
Received: by mail-ua1-f53.google.com with SMTP id 97so4849984uav.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8y7oZIw1YMOjEvsLWyQcxtUBXg+Hq4822w/iibJY5oM=;
        b=s+9dja1FC5zWNvQH/0jnWYwVnQjAIGwpymBv28qiEbSbihnqg6TGH0zMyYmwgpfnKk
         dt+z9FWS6KK2SYEfyVmPy0NiZmO9DhL7DwpqOdxuH6XR0j0OJnPobwaEHXR3ELduLIUS
         yRuTMgP9kBWjF3WQkm0Qo15RWL7ovZE0l5xv3JLJ6LoCv7Y0VLl5mO22D6ZthazhiA2J
         pabof9+vtJVBBU5hj3x3X6V7sIoGmvqN6igmWcV1apBz9la//CH79qLOHEr9+NI7DwYa
         tp3quQB07FraNa2WjoB/tznhkLOrSd+01gZ7esKQ00qTT9K4N+d84d3wm8txJoo0scl1
         DYew==
X-Gm-Message-State: AOAM530qj7va1FgwFY348Sw8VXHgRG3fwvfFvvCJ1GJlWV//kM7QTA9f
        E6d+mvM+jvqm5o32pnSA9QhikKA3hbgVxowU+0E=
X-Google-Smtp-Source: ABdhPJzhkj5xFc0mAROAfsnz9Aq+SS+wFmH/dfyW1W97iN/d1kjGziAqceJxycurA2IJG2AoR+JIsPKmioeY7xoYW60=
X-Received: by 2002:ab0:3393:: with SMTP id y19mr16748273uap.2.1617097661466;
 Tue, 30 Mar 2021 02:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210313084505.16132-3-alex@ghiti.fr> <mhng-1a492a0c-049e-495e-8258-7513a4fa967a@palmerdabbelt-glaptop>
In-Reply-To: <mhng-1a492a0c-049e-495e-8258-7513a4fa967a@palmerdabbelt-glaptop>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Mar 2021 11:47:30 +0200
Message-ID: <CAMuHMdXdhTUKuvJkJGUm=ESpwA6R06eKV5q6wFOJftJ1p3R7nw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: Cleanup KASAN_VMALLOC support
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, nylon7@andestech.com,
        Nick Hu <nickhu@andestech.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Tue, Mar 30, 2021 at 7:08 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> On Sat, 13 Mar 2021 00:45:05 PST (-0800), alex@ghiti.fr wrote:
> > When KASAN vmalloc region is populated, there is no userspace process and
> > the page table in use is swapper_pg_dir, so there is no need to read
> > SATP. Then we can use the same scheme used by kasan_populate_p*d
> > functions to go through the page table, which harmonizes the code.
> >
> > In addition, make use of set_pgd that goes through all unused page table
> > levels, contrary to p*d_populate functions, which makes this function work
> > whatever the number of page table levels.
> >
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > ---
> >  arch/riscv/mm/kasan_init.c | 59 ++++++++++++--------------------------
> >  1 file changed, 18 insertions(+), 41 deletions(-)
> >
> > diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> > index 57bf4ae09361..c16178918239 100644
> > --- a/arch/riscv/mm/kasan_init.c
> > +++ b/arch/riscv/mm/kasan_init.c
> > @@ -11,18 +11,6 @@
> >  #include <asm/fixmap.h>
> >  #include <asm/pgalloc.h>
> >
> > -static __init void *early_alloc(size_t size, int node)
> > -{
> > -     void *ptr = memblock_alloc_try_nid(size, size,
> > -             __pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, node);
> > -
> > -     if (!ptr)
> > -             panic("%pS: Failed to allocate %zu bytes align=%zx nid=%d from=%llx\n",
> > -                     __func__, size, size, node, (u64)__pa(MAX_DMA_ADDRESS));
> > -
> > -     return ptr;
> > -}
> > -
> >  extern pgd_t early_pg_dir[PTRS_PER_PGD];
> >  asmlinkage void __init kasan_early_init(void)
> >  {
> > @@ -155,38 +143,27 @@ static void __init kasan_populate(void *start, void *end)
> >       memset(start, KASAN_SHADOW_INIT, end - start);
> >  }
> >
> > -void __init kasan_shallow_populate(void *start, void *end)
> > +static void __init kasan_shallow_populate_pgd(unsigned long vaddr, unsigned long end)
> >  {
> > -     unsigned long vaddr = (unsigned long)start & PAGE_MASK;
> > -     unsigned long vend = PAGE_ALIGN((unsigned long)end);
> > -     unsigned long pfn;
> > -     int index;
> > +     unsigned long next;
> >       void *p;
> > -     pud_t *pud_dir, *pud_k;
> > -     pgd_t *pgd_dir, *pgd_k;
> > -     p4d_t *p4d_dir, *p4d_k;
> > -
> > -     while (vaddr < vend) {
> > -             index = pgd_index(vaddr);
> > -             pfn = csr_read(CSR_SATP) & SATP_PPN;
> > -             pgd_dir = (pgd_t *)pfn_to_virt(pfn) + index;
> > -             pgd_k = init_mm.pgd + index;
> > -             pgd_dir = pgd_offset_k(vaddr);
> > -             set_pgd(pgd_dir, *pgd_k);
> > -
> > -             p4d_dir = p4d_offset(pgd_dir, vaddr);
> > -             p4d_k  = p4d_offset(pgd_k, vaddr);
> > -
> > -             vaddr = (vaddr + PUD_SIZE) & PUD_MASK;
> > -             pud_dir = pud_offset(p4d_dir, vaddr);
> > -             pud_k = pud_offset(p4d_k, vaddr);
> > -
> > -             if (pud_present(*pud_dir)) {
> > -                     p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> > -                     pud_populate(&init_mm, pud_dir, p);
> > +     pgd_t *pgd_k = pgd_offset_k(vaddr);
> > +
> > +     do {
> > +             next = pgd_addr_end(vaddr, end);
> > +             if (pgd_page_vaddr(*pgd_k) == (unsigned long)lm_alias(kasan_early_shadow_pmd)) {
> > +                     p = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> > +                     set_pgd(pgd_k, pfn_pgd(PFN_DOWN(__pa(p)), PAGE_TABLE));
> >               }
> > -             vaddr += PAGE_SIZE;
> > -     }
> > +     } while (pgd_k++, vaddr = next, vaddr != end);
> > +}
> > +
> > +static void __init kasan_shallow_populate(void *start, void *end)
> > +{
> > +     unsigned long vaddr = (unsigned long)start & PAGE_MASK;
> > +     unsigned long vend = PAGE_ALIGN((unsigned long)end);
> > +
> > +     kasan_shallow_populate_pgd(vaddr, vend);
> >
> >       local_flush_tlb_all();
> >  }
>
> Thanks, this is on for-next.

Your for-next does not include your fixes branch, hence they now conflict,
and for-next lacks the local_flush_tlb_all().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
