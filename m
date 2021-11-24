Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9263B45B9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 13:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbhKXMFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 07:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242114AbhKXME2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:04:28 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F62C06175E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:01:18 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id a2so2304201qtx.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aABovFi56zCkRlZ7e4yBjRSrPvVOkng5hwOSFi7rkXQ=;
        b=R5MQdxTIa+8dq0M4bbO+wrvxjZOGIFvZCNl+Q9upTslFP6pMnbaU9X1U6wOOukY4lE
         O5zNdJhqYhNugxfYQkKETNtml8p18b/AEQHo8f2TJ/y4mmGMnI7cXBmwveZlwOw7TOOj
         KxIYm27pgClcTFnJq3dLX3c6+VkF44mRIQGZIZ1pBY72K3WQ3qf+7ihIDYMlWZTSm8Mz
         VCHj+1PJ+N5rYty640k9aRoyok8kMLYPY3RywNsw7hh9G2Gtu6NOJDIRPG5Ul2dtQ9yW
         seF89NL1OWwQRz/G8aMMnY4mpuxaInrbQrDQiTAzpYGeFC5YdybtLC7JZ60cbferJZM0
         t1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aABovFi56zCkRlZ7e4yBjRSrPvVOkng5hwOSFi7rkXQ=;
        b=8BcjCm07tML4QRSn5wPetK1/mLfDY/4wjPs13Xwfc937luuhuv2W+ZaH+XpYwp2M1A
         YAb0hUV15UlhyBvKxJXx4jT5bJxnyZffRb/NlEa/ONfCZfi/pbQUmZA8bY2j3j0p7dNy
         UkJZ/Wk2FFmxTXYHMdNykedHavPEJKQ+8bvLSNQFRTvwXWHwxIEW55sMoS6Z2UOJlLqj
         4bUgbUMTcJ6D9nTeghlYldQSzRWPnY40PABO7fJika1kfT7Dni5PRV6sb4laIUfvZtWe
         qsYYefi6sFBRwIfz0+4osY/TrmJveA59vfZWnNlD7qQGfFfJnCHbofw4tSzVNBNFcYn8
         yVUw==
X-Gm-Message-State: AOAM5339LBSI+YQHKOS/+J8m9r8NiBSHB/4al0xlPzvL11rJy5PhmtJ9
        pd6zM+sfT55QjFxKLGimVeTTXXjLaXWqJEj0mPQ=
X-Google-Smtp-Source: ABdhPJy+tBRb0Z2cfrz5n1blNXpTPIQPfXu8YtW/v9rgZxVBikuw8mwNuv3cpI+xydhjieeoPy1LZrz0peL3fInt+d0=
X-Received: by 2002:a05:622a:178c:: with SMTP id s12mr6389338qtk.156.1637755277596;
 Wed, 24 Nov 2021 04:01:17 -0800 (PST)
MIME-Version: 1.0
References: <1637658760-5813-1-git-send-email-huangzhaoyang@gmail.com>
 <CAMj1kXGLRr8bnhLPseW=gSj6kA1TKqAC0Bs0Loj8gkpgaMB8MA@mail.gmail.com>
 <CAGWkznGsus77QT4r5X3qDzP3wHsY+=j8m-7DYfm_s_nd5bWQbQ@mail.gmail.com> <CAMj1kXHdOn66wrFs78-g0PXnXZjioSPPwZ1TNsFhWAHeRje+sg@mail.gmail.com>
In-Reply-To: <CAMj1kXHdOn66wrFs78-g0PXnXZjioSPPwZ1TNsFhWAHeRje+sg@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 24 Nov 2021 20:00:56 +0800
Message-ID: <CAGWkznF1-E8bPcZT59SZy3dvmqf=FmBYbAGGE5J7mrL9UGC=VA@mail.gmail.com>
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

On Wed, Nov 24, 2021 at 5:23 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 24 Nov 2021 at 09:08, Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > On Tue, Nov 23, 2021 at 5:58 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Tue, 23 Nov 2021 at 10:13, Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> > > >
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Since there is no PTE_CONT when rodata_full in ARM64, introducing a
> > > > hook function to apply PTE_CONT on the proper page blocks.
> > > >
> > >
> > > Given the discussion around your previous patch, I would expect a
> > > meticulous explanation here why it is guaranteed to be safe to
> > > manipulate the PTE_CONT attribute like this, and how the proposed
> > > logic is correct for all supported page sizes.
> > >
> > > Without using an intermediate invalid mapping for the entire range,
> > > this is never going to work reliably (this is the break-before-make
> > > requirement). And given that marking the entire block invalid will
> > > create intermediate states that are not permitted (a valid PTE_CONT
> > > mapping and an invalid ~PTE_CONT mapping covering the same VA), the
> > > only way to apply changes like these is to temporarily switch all CPUs
> > > to a different translation via TTBR1. And this is not going to happen.
> > As there is no safe way to modify PTE_CONT on a live mapping, please
> > forget all previous patches except current one.
>
> OK
>
> > >
> > > Also, you never replied to my question regarding the use case and the
> > > performance gain.
> > In our android based system, the multimedia related cases suffers from
> > small pte granularity mostly which use high order page blocks quite a
> > lot. The performance gap even be visible.
>
> OK, good to know.
>
> > >
> > > In summary, NAK to this patch or any of the previous ones regarding
> > > PTE_CONT. If you do insist on pursuing this further, please provide an
> > > elaborate and rock solid explanation why your approach is 100% valid
> > > and correct (for all page sizes). And make sure you include an
> > > explanation how your changes comply with the architectural
> > > break-before-make requirements around PTE_CONT attributes.
> > IMHO, It is safe to modify the page block's pte undering
> > *arch_alloc/free_pages* as there is no one else aware of it.
>
> Whether the software is 'aware' or not is irrelevant. Speculative
> accesses could be made at any time, and these will trigger a page
> table walk if no cached TLB entries exist for the region. If more than
> one cached TLB entry exists (which would be the case if an adjacent
> entry has the PTE_CONT attribute but not the entry itself), you will
> hit a TLB conflict abort.
Could it be a risk that a speculative load racing with setting pte
from VALID to INVALID?
>
> I guess the behavior under invalid mappings might be subtly different,
> since those should not be cached in a TLB, but the fundamental problem
> remains: no conflicting entries should exist at any time, and PTE_CONT
> must be either set or cleared on all entries in the same contiguous
> group. These are contradictory requirements for live translations, so
> the only way around it is to uninstall the translation from all CPUs,
> perform the update, and reinstall it.
>
> > Furthermore, I do think tlbflush and barriers are needed for
> > synchronization.
>
> Careful [repeated] TLB maintenance may reduce the size of the window
> where the TLB conflicts may occur, but it does not solve the issue.
>
> > With regards to page sizes issue, I think replacing
> > the hard code const value to CONT_PTE_XXX could wrap the difference
> > and make it correct.
> >
> > - if ((order >= 4) && (addr & ~CONT_PTE_MASK) == 0) {
> > -     order -= 4;
> > + if ((order >= CONT_PTE_SHIFT) && (addr & ~CONT_PTE_MASK) == 0) {
> > +    order -= CONT_PTE_SHIFT;
> >     do {
> >         cont_pte_low_bound = addr & CONT_PTE_MASK;
> >     __change_memory_common(cont_pte_low_bound,
> >     (~CONT_PTE_MASK + 1), __pgprot(PTE_CONT), __pgprot(0));
> >     addr = (u64)page_address(page);
> > -     page += 4;
> > +
> >     page += CONT_PTES;
> >     order--;
> > }while (order >= 0);
> > >
> > >
> > >
> > > > ---
> > > >  arch/arm64/include/asm/page.h |  5 +++++
> > > >  arch/arm64/mm/pageattr.c      | 45 +++++++++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 50 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> > > > index f98c91b..53cdd09 100644
> > > > --- a/arch/arm64/include/asm/page.h
> > > > +++ b/arch/arm64/include/asm/page.h
> > > > @@ -46,6 +46,11 @@ struct page *alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
> > > >
> > > >  #include <asm/memory.h>
> > > >
> > > > +#define HAVE_ARCH_ALLOC_PAGE
> > > > +#define HAVE_ARCH_FREE_PAGE
> > > > +
> > > > +extern void arch_alloc_page(struct page *page, int order);
> > > > +extern void arch_free_page(struct page *page, int order);
> > > >  #endif /* !__ASSEMBLY__ */
> > > >
> > > >  #define VM_DATA_DEFAULT_FLAGS  (VM_DATA_FLAGS_TSK_EXEC | VM_MTE_ALLOWED)
> > > > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > > > index a3bacd7..815a06d 100644
> > > > --- a/arch/arm64/mm/pageattr.c
> > > > +++ b/arch/arm64/mm/pageattr.c
> > > > @@ -239,3 +239,48 @@ bool kernel_page_present(struct page *page)
> > > >         ptep = pte_offset_kernel(pmdp, addr);
> > > >         return pte_valid(READ_ONCE(*ptep));
> > > >  }
> > > > +
> > > > +void arch_alloc_page(struct page *page, int order)
> > > > +{
> > > > +       unsigned long addr;
> > > > +       unsigned long cont_pte_low_bound;
> > > > +
> > > > +       if (!rodata_full)
> > > > +               return;
> > > > +
> > > > +       addr = (u64)page_address(page);
> > > > +       if ((order >= 4) && (addr & ~CONT_PTE_MASK) == 0) {
> > > > +               order -= 4;
> > > > +               do {
> > > > +                       cont_pte_low_bound = addr & CONT_PTE_MASK;
> > > > +                       __change_memory_common(cont_pte_low_bound,
> > > > +                                       (~CONT_PTE_MASK + 1), __pgprot(PTE_CONT), __pgprot(0));
> > > > +                       addr = (u64)page_address(page);
> > > > +                       page += 4;
> > > > +                       order--;
> > > > +               }while (order >= 0);
> > > > +       }
> > > > +}
> > > > +
> > > > +void arch_free_page(struct page *page, int order)
> > > > +{
> > > > +       unsigned long addr;
> > > > +       unsigned long cont_pte_low_bound;
> > > > +
> > > > +       if (!rodata_full)
> > > > +               return;
> > > > +
> > > > +       addr = (u64)page_address(page);
> > > > +       if ((order >= 4) && (addr & ~CONT_PTE_MASK) == 0) {
> > > > +               order -= 4;
> > > > +               do {
> > > > +                       cont_pte_low_bound = addr & CONT_PTE_MASK;
> > > > +                       __change_memory_common(cont_pte_low_bound,
> > > > +                                       (~CONT_PTE_MASK + 1), __pgprot(0), __pgprot(PTE_CONT));
> > > > +                       addr = (u64)page_address(page);
> > > > +                       page += 4;
> > > > +                       order--;
> > > > +               }while (order >= 0);
> > > > +       }
> > > > +}
> > > > +
> > > > --
> > > > 1.9.1
> > > >
