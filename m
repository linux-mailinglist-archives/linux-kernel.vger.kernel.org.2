Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15B139ACD8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFCV3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:29:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FFDC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 14:27:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b9so11283637ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWF0LmSUjm4yC2lK4bG3Fr4kMBCczV/fZvv9HdaYnZ4=;
        b=PrJbwPsGj1DMvzYWsww4J8+y80Fal2f70tt0bje+OTzNRrw2K/4++7uol694AwFzTO
         dXgGhJOaKjsWKab118zE4BwIu7/HlNCvtaJc25BBP+RhjUT3y93jkcERUNiZXLN4hgmK
         G+kTT9XwIm+4fgfW0r7hxN9xTmkXLcAjCAxg5SzaF91StpyTkYwVDa1ib3cRG3hwLblr
         2IoF2naBKZHmhH/YcWgboy8vSCF4g4rIN02gWQHSe9aRXB3XZ+xhJdLdtTqt1cWfULvT
         deImbIwq8t/suqyXkLEs7JwSMX4QsW/+eqLMgb3ZXRhXktaMbs3PU6TXcU18pQ0w1AxI
         cDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWF0LmSUjm4yC2lK4bG3Fr4kMBCczV/fZvv9HdaYnZ4=;
        b=j/WryTEPBOxWPAehSQd1GgO/3qMhSt0wacV003md0CAEs3zFpElxXBe0RDwDYXFPhJ
         IKWpby6wTuoOzvd8A8gHHOpDjbqoNzRtIlVDk+/8jArC847ReCu/AnwTy7fo3IgFRHus
         DaOFCMQT0ukikbG6rln8Mh+BCcCxrLkjEN59yaSoU3vmObVMExeM0p2PPNmbnYzh0pnw
         OUTQyCCmZBjWAa/VRq3AIOEFmQzPAEFxnnmAI4e0B0xrMsdjiUAZ1u8pdvOB/PnukUs7
         yVqV3ynsdEkEER9j2oihvpm3OtJTDbGT6nG7pdwwxrQw3IWo8c6Di4ZX10phJexczvWb
         PN6g==
X-Gm-Message-State: AOAM532FIUyKZCahpXcFK4VQ3qqDQ0Rt7/G8n6ixcQGerObuDs41bGLG
        05UfTmLlbblZzpW+x4w00+d8P224B7eEQlaWUKg=
X-Google-Smtp-Source: ABdhPJyXeGiJtG4uW7GXIXAQabp0Quew9wW7zcB7/rCiirnP+e15B4xm56R4wQs9EyyEodENRKvHJ3t16/6nQBXB4Ic=
X-Received: by 2002:a17:906:af95:: with SMTP id mj21mr1157992ejb.25.1622755628871;
 Thu, 03 Jun 2021 14:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011403540.2148@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2106011403540.2148@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Jun 2021 14:26:57 -0700
Message-ID: <CAHbLzkobMaW15iN6y8Zot3kmpA1c4z2r6rSR7B9Pqwg5YY+hcA@mail.gmail.com>
Subject: Re: [PATCH 1/7] mm/thp: fix __split_huge_pmd_locked() on shmem
 migration entry
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 2:05 PM Hugh Dickins <hughd@google.com> wrote:
>
> Stressing huge tmpfs page migration racing hole punch often crashed on the
> VM_BUG_ON(!pmd_present) in pmdp_huge_clear_flush(), with DEBUG_VM=y kernel;
> or shortly afterwards, on a bad dereference in __split_huge_pmd_locked()
> when DEBUG_VM=n.  They forgot to allow for pmd migration entries in the
> non-anonymous case.
>
> Full disclosure: those particular experiments were on a kernel with more
> relaxed mmap_lock and i_mmap_rwsem locking, and were not repeated on the
> vanilla kernel: it is conceivable that stricter locking happens to avoid
> those cases, or makes them less likely; but __split_huge_pmd_locked()
> already allowed for pmd migration entries when handling anonymous THPs,
> so this commit brings the shmem and file THP handling into line.
>
> Are there more places that need to be careful about pmd migration entries?
> None hit in practice, but several of those is_huge_zero_pmd() tests were
> done without checking pmd_present() first: I believe a pmd migration entry
> could end up satisfying that test.  Ah, the inversion of swap offset, to
> protect against L1TF, makes that impossible on x86; but other arches need
> the pmd_present() check, and even x86 ought not to apply pmd_page() to a
> swap-like pmd.  Fix those instances; __split_huge_pmd_locked() was not
> wrong to be checking with pmd_trans_huge() instead, but I think it's
> clearer to use pmd_present() in each instance.
>
> And while there: make it clearer to the eye that the !vma_is_anonymous()
> and is_huge_zero_pmd() blocks make early returns (and don't return void).
>
> Fixes: e71769ae5260 ("mm: enable thp migration for shmem thp")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/huge_memory.c     | 38 ++++++++++++++++++++++++--------------
>  mm/pgtable-generic.c |  5 ++---
>  2 files changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..9fb7b47da87e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1587,9 +1587,6 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>                 goto out_unlocked;
>
>         orig_pmd = *pmd;
> -       if (is_huge_zero_pmd(orig_pmd))
> -               goto out;
> -
>         if (unlikely(!pmd_present(orig_pmd))) {
>                 VM_BUG_ON(thp_migration_supported() &&
>                                   !is_pmd_migration_entry(orig_pmd));
> @@ -1597,6 +1594,9 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>         }
>
>         page = pmd_page(orig_pmd);
> +       if (is_huge_zero_page(page))
> +               goto out;
> +
>         /*
>          * If other processes are mapping this page, we couldn't discard
>          * the page unless they all do MADV_FREE so let's skip the page.
> @@ -1676,7 +1676,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>                 spin_unlock(ptl);
>                 if (is_huge_zero_pmd(orig_pmd))
>                         tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
> -       } else if (is_huge_zero_pmd(orig_pmd)) {
> +       } else if (pmd_present(orig_pmd) && is_huge_zero_pmd(orig_pmd)) {

If it is a huge zero migration entry, the code would fallback to the
"else". But IIUC the "else" case doesn't handle the huge zero page
correctly. It may mess up the rss counter.

>                 zap_deposited_table(tlb->mm, pmd);
>                 spin_unlock(ptl);
>                 tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
> @@ -2044,7 +2044,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>         count_vm_event(THP_SPLIT_PMD);
>
>         if (!vma_is_anonymous(vma)) {
> -               _pmd = pmdp_huge_clear_flush_notify(vma, haddr, pmd);
> +               old_pmd = pmdp_huge_clear_flush_notify(vma, haddr, pmd);
>                 /*
>                  * We are going to unmap this huge page. So
>                  * just go ahead and zap it
> @@ -2053,16 +2053,25 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>                         zap_deposited_table(mm, pmd);
>                 if (vma_is_special_huge(vma))
>                         return;
> -               page = pmd_page(_pmd);
> -               if (!PageDirty(page) && pmd_dirty(_pmd))
> -                       set_page_dirty(page);
> -               if (!PageReferenced(page) && pmd_young(_pmd))
> -                       SetPageReferenced(page);
> -               page_remove_rmap(page, true);
> -               put_page(page);
> +               if (unlikely(is_pmd_migration_entry(old_pmd))) {
> +                       swp_entry_t entry;
> +
> +                       entry = pmd_to_swp_entry(old_pmd);
> +                       page = migration_entry_to_page(entry);
> +               } else {
> +                       page = pmd_page(old_pmd);
> +                       if (!PageDirty(page) && pmd_dirty(old_pmd))
> +                               set_page_dirty(page);
> +                       if (!PageReferenced(page) && pmd_young(old_pmd))
> +                               SetPageReferenced(page);
> +                       page_remove_rmap(page, true);
> +                       put_page(page);
> +               }
>                 add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
>                 return;
> -       } else if (pmd_trans_huge(*pmd) && is_huge_zero_pmd(*pmd)) {
> +       }
> +
> +       if (pmd_present(*pmd) && is_huge_zero_pmd(*pmd)) {
>                 /*
>                  * FIXME: Do we want to invalidate secondary mmu by calling
>                  * mmu_notifier_invalidate_range() see comments below inside
> @@ -2072,7 +2081,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>                  * small page also write protected so it does not seems useful
>                  * to invalidate secondary mmu at this time.
>                  */
> -               return __split_huge_zero_page_pmd(vma, haddr, pmd);
> +               __split_huge_zero_page_pmd(vma, haddr, pmd);
> +               return;
>         }
>
>         /*
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index c2210e1cdb51..4e640baf9794 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -135,9 +135,8 @@ pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma, unsigned long address,
>  {
>         pmd_t pmd;
>         VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> -       VM_BUG_ON(!pmd_present(*pmdp));
> -       /* Below assumes pmd_present() is true */
> -       VM_BUG_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
> +       VM_BUG_ON(pmd_present(*pmdp) && !pmd_trans_huge(*pmdp) &&
> +                          !pmd_devmap(*pmdp));
>         pmd = pmdp_huge_get_and_clear(vma->vm_mm, address, pmdp);
>         flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>         return pmd;
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog
>
