Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C03445B63F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbhKXIMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241104AbhKXIME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:12:04 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716F7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:08:54 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id v2so1195586qve.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CatI3/UOs7Nbmin1JBPpQh0cr4tyNKobEZGQHQA+RwU=;
        b=Pa3qVeweJM2sSAdUAbzkzH7n63yKR3hW4LgVP5Hnc2hrSKghxBUv6VrkJTyZ5rnnMR
         YBRhoqQeMT4kfTyXzVHUYd4r9nYM3flAt8mwDZmHUijVPZP712xiueG4Y6jp/qU+bif0
         PD9s/4MtvSB5TfxqJ4YTOouWINTD+gpF2YiOQi8N153rh9fE54ZLY26cXDyfV0N1rzds
         qXGIuZMvptEmM8/jtYDQl9JnWQgmzwTfxVjvlVVGdbPM/K0S3b9ktK0KBpy/QH/V/h/W
         q52PLSHA+/2qSEmcI6avBOW6SBNdnQmMkA/FjhoABLS8Yrq0K/305GJMuiR4JyapcpwA
         YYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CatI3/UOs7Nbmin1JBPpQh0cr4tyNKobEZGQHQA+RwU=;
        b=meCBna+tWiQ7AGx7FMTh62e6h1JEj6meuEXcVg/1gtz9ey/9boE12+7CEML5eCToZs
         ziRMEs8eyFPDwep/ilsZfYMwYhitu3cNOzRJ7kojpihu1UfffeAkRqksJcuySD/1H1GM
         Eq5MHkpJsEMbabdxheoU0aoVxyKnpuiAUtiAoAHueKOvazGUJHEeK4nccP0w0HNzM1HU
         xWrdhnWcU6OdAX35CXVgmXIPX6qJGPQ4IexcxNNijgOZCVX1lXU5E5a0oOpzdAX6Qv1m
         VlBz9i/MX+lNpbIw7Zk4ATPGTjIdhQajL8RXQu3N/L1lxV/m8r2ssHrhTZQAHoPUj/X8
         jN1Q==
X-Gm-Message-State: AOAM531EFPOzDJkb58lSvc+sP7CqAXGhw6rtIPC084fc1sCfVZ+eKl0v
        tEKGZ+MHRCLh7nz0ovEfvYWzRvNrWBV5BOchjFE=
X-Google-Smtp-Source: ABdhPJw3ITeVcApQYJjWiPng2yoZje3wvPGkve+3pDdyxUpyY0olX1OfG5FlNwKIb1SxAfgUO6MVuS7R5xoonr00xws=
X-Received: by 2002:ad4:4e49:: with SMTP id eb9mr4966977qvb.22.1637741333652;
 Wed, 24 Nov 2021 00:08:53 -0800 (PST)
MIME-Version: 1.0
References: <1637658760-5813-1-git-send-email-huangzhaoyang@gmail.com> <CAMj1kXGLRr8bnhLPseW=gSj6kA1TKqAC0Bs0Loj8gkpgaMB8MA@mail.gmail.com>
In-Reply-To: <CAMj1kXGLRr8bnhLPseW=gSj6kA1TKqAC0Bs0Loj8gkpgaMB8MA@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 24 Nov 2021 16:08:32 +0800
Message-ID: <CAGWkznGsus77QT4r5X3qDzP3wHsY+=j8m-7DYfm_s_nd5bWQbQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: introduce alloc hook to apply PTE_CONT
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Marek <jonathan@marek.ca>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 5:58 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 23 Nov 2021 at 10:13, Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Since there is no PTE_CONT when rodata_full in ARM64, introducing a
> > hook function to apply PTE_CONT on the proper page blocks.
> >
>
> Given the discussion around your previous patch, I would expect a
> meticulous explanation here why it is guaranteed to be safe to
> manipulate the PTE_CONT attribute like this, and how the proposed
> logic is correct for all supported page sizes.
>
> Without using an intermediate invalid mapping for the entire range,
> this is never going to work reliably (this is the break-before-make
> requirement). And given that marking the entire block invalid will
> create intermediate states that are not permitted (a valid PTE_CONT
> mapping and an invalid ~PTE_CONT mapping covering the same VA), the
> only way to apply changes like these is to temporarily switch all CPUs
> to a different translation via TTBR1. And this is not going to happen.
As there is no safe way to modify PTE_CONT on a live mapping, please
forget all previous patches except current one.
>
> Also, you never replied to my question regarding the use case and the
> performance gain.
In our android based system, the multimedia related cases suffers from
small pte granularity mostly which use high order page blocks quite a
lot. The performance gap even be visible.
>
> In summary, NAK to this patch or any of the previous ones regarding
> PTE_CONT. If you do insist on pursuing this further, please provide an
> elaborate and rock solid explanation why your approach is 100% valid
> and correct (for all page sizes). And make sure you include an
> explanation how your changes comply with the architectural
> break-before-make requirements around PTE_CONT attributes.
IMHO, It is safe to modify the page block's pte undering
*arch_alloc/free_pages* as there is no one else aware of it.
Furthermore, I do think tlbflush and barriers are needed for
synchronization. With regards to page sizes issue, I think replacing
the hard code const value to CONT_PTE_XXX could wrap the difference
and make it correct.

- if ((order >= 4) && (addr & ~CONT_PTE_MASK) == 0) {
-     order -= 4;
+ if ((order >= CONT_PTE_SHIFT) && (addr & ~CONT_PTE_MASK) == 0) {
+    order -= CONT_PTE_SHIFT;
    do {
        cont_pte_low_bound = addr & CONT_PTE_MASK;
    __change_memory_common(cont_pte_low_bound,
    (~CONT_PTE_MASK + 1), __pgprot(PTE_CONT), __pgprot(0));
    addr = (u64)page_address(page);
-     page += 4;
+
    page += CONT_PTES;
    order--;
}while (order >= 0);
>
>
>
> > ---
> >  arch/arm64/include/asm/page.h |  5 +++++
> >  arch/arm64/mm/pageattr.c      | 45 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> > index f98c91b..53cdd09 100644
> > --- a/arch/arm64/include/asm/page.h
> > +++ b/arch/arm64/include/asm/page.h
> > @@ -46,6 +46,11 @@ struct page *alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
> >
> >  #include <asm/memory.h>
> >
> > +#define HAVE_ARCH_ALLOC_PAGE
> > +#define HAVE_ARCH_FREE_PAGE
> > +
> > +extern void arch_alloc_page(struct page *page, int order);
> > +extern void arch_free_page(struct page *page, int order);
> >  #endif /* !__ASSEMBLY__ */
> >
> >  #define VM_DATA_DEFAULT_FLAGS  (VM_DATA_FLAGS_TSK_EXEC | VM_MTE_ALLOWED)
> > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > index a3bacd7..815a06d 100644
> > --- a/arch/arm64/mm/pageattr.c
> > +++ b/arch/arm64/mm/pageattr.c
> > @@ -239,3 +239,48 @@ bool kernel_page_present(struct page *page)
> >         ptep = pte_offset_kernel(pmdp, addr);
> >         return pte_valid(READ_ONCE(*ptep));
> >  }
> > +
> > +void arch_alloc_page(struct page *page, int order)
> > +{
> > +       unsigned long addr;
> > +       unsigned long cont_pte_low_bound;
> > +
> > +       if (!rodata_full)
> > +               return;
> > +
> > +       addr = (u64)page_address(page);
> > +       if ((order >= 4) && (addr & ~CONT_PTE_MASK) == 0) {
> > +               order -= 4;
> > +               do {
> > +                       cont_pte_low_bound = addr & CONT_PTE_MASK;
> > +                       __change_memory_common(cont_pte_low_bound,
> > +                                       (~CONT_PTE_MASK + 1), __pgprot(PTE_CONT), __pgprot(0));
> > +                       addr = (u64)page_address(page);
> > +                       page += 4;
> > +                       order--;
> > +               }while (order >= 0);
> > +       }
> > +}
> > +
> > +void arch_free_page(struct page *page, int order)
> > +{
> > +       unsigned long addr;
> > +       unsigned long cont_pte_low_bound;
> > +
> > +       if (!rodata_full)
> > +               return;
> > +
> > +       addr = (u64)page_address(page);
> > +       if ((order >= 4) && (addr & ~CONT_PTE_MASK) == 0) {
> > +               order -= 4;
> > +               do {
> > +                       cont_pte_low_bound = addr & CONT_PTE_MASK;
> > +                       __change_memory_common(cont_pte_low_bound,
> > +                                       (~CONT_PTE_MASK + 1), __pgprot(0), __pgprot(PTE_CONT));
> > +                       addr = (u64)page_address(page);
> > +                       page += 4;
> > +                       order--;
> > +               }while (order >= 0);
> > +       }
> > +}
> > +
> > --
> > 1.9.1
> >
