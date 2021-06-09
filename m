Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D9A3A1B51
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 18:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhFIQzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 12:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFIQzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 12:55:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AD6C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 09:53:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ce15so39429513ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjuPCxkHMajDm0LJZ6HojP9067gxaOE35kQ09vyuTbY=;
        b=fsZc6cAAlB0htjqxdXE0wo5PNRQysfgWur6+bR1Zo6eVJrQNOtXwHgNg791zHZexAT
         ylFxAKIlMjIKiqqfcAN8r11+yZ1HlVaMOyIyFrjXC6wAD5L2rmPmS/NuQZKP2Lj1ug1z
         3MDWYvTABFF2uy2lhTgAYXCQkK7lBdK7zsHdkMN9i2lwd69QKUFYAS3F1n+MnJTWpWVH
         Db/EbKaa6BxRRF87mMa9XCRZGVCIfYNn6Dj6bnCxmXCxGRF7LRF3TgxTwEAMtSR5P+gm
         gA6YcLiwHJ7USXf8qYwYm735BOV7s/f0kA2ehkABwbq0ymzEYl1+IM2/YVOncfWyuFfZ
         adhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjuPCxkHMajDm0LJZ6HojP9067gxaOE35kQ09vyuTbY=;
        b=qiILomHSpG1A8AX2/qbI3w6XOY+SsvLfddbzSlO/fApOxfqVOWzHeXe0922scMi9la
         eyQlZ8Z6NTJGxZ7Fx+25bMjrPFV8wynFVRf/yp06ddEkSwAvfhvqj7rsU6lFlqgA1Xx2
         Z10aJ7Xa7APV3EaXAi2c/rY3c5V7IUbeMj12P+HN8AIVxEzp7FMiPS9q6G0kXFx4I6S5
         nyxVoxmJ49gFg3miMltWG3J9evI9l+62/uCgYRj+Fk8okLnkMrlH3x+UFRFyXQbjL3Xc
         PCkEhhaciW7HajiCfys/avbuTCV4qoGS0AqU+IutTkmDoxgI03fI/2X8StWFcFV0lfU4
         mesg==
X-Gm-Message-State: AOAM530NNzY5JQWQ4N88QY3UrMqLvsJlx5LCAiY5abudGFkWXru/pKDE
        EPn3KUeefpWMeY9CHceUkaPAtSIr2dAk4aL3Oa/EQPlTME8=
X-Google-Smtp-Source: ABdhPJyxNnJY1mRKbOQyd8Piy7wEoYiZWAgvyt3+9ySh0YfpyREn2j0vfzXc12Y6SXpgpcQ7xRjRhax25zHTWa1V36E=
X-Received: by 2002:a17:906:488a:: with SMTP id v10mr755069ejq.383.1623257638180;
 Wed, 09 Jun 2021 09:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <59d94b4-c0dd-310-894-be99416f3c92@google.com>
In-Reply-To: <59d94b4-c0dd-310-894-be99416f3c92@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 9 Jun 2021 09:53:46 -0700
Message-ID: <CAHbLzkrUvvhQRYQDEOYi66sWL5HSQCyAU0McgdYT8=59g=szXg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mm/thp: fix __split_huge_pmd_locked() on shmem
 migration entry (fwd)
To:     Hugh Dickins <hughd@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 9:05 PM Hugh Dickins <hughd@google.com> wrote:
>
>
>
> ---------- Forwarded message ----------
> Date: Tue, 8 Jun 2021 21:00:12 -0700 (PDT)
> From: Hugh Dickins <hughd@google.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hughd@google.com>,
>     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>,
>     Yang Shi <shy828301@gmail.com>, Wang Yugui <wangyugui@e16-tech.com>,
>     Matthew Wilcox <willy@infradead.org>,
>     Naoya Horiguchi <naoya.horiguchi@nec.com>,
>     Alistair Popple <apopple@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>,
>     Zi Yan <ziy@nvidia.com>, Miaohe Lin <linmiaohe@huawei.com>,
>     Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
>     Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
>     Shakeel Butt <shakeelb@google.com>, Oscar Salvador <osalvador@suse.de>
> Subject: [PATCH v2 01/10] mm/thp: fix __split_huge_pmd_locked() on shmem
>     migration entry
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
> And while there: use old_pmd rather than _pmd, as in the following blocks;
> and make it clearer to the eye that the !vma_is_anonymous() block is
> self-contained, making an early return after accounting for unmapping.
>
> Fixes: e71769ae5260 ("mm: enable thp migration for shmem thp")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
> v2: omit is_huge_zero_pmd() mods (done differently in next), per Kirill
>
>  mm/huge_memory.c     | 27 ++++++++++++++++++---------
>  mm/pgtable-generic.c |  5 ++---
>  2 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..42cfefc6e66e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
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
> +       if (pmd_trans_huge(*pmd) && is_huge_zero_pmd(*pmd)) {
>                 /*
>                  * FIXME: Do we want to invalidate secondary mmu by calling
>                  * mmu_notifier_invalidate_range() see comments below inside
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
> 2.26.2
>
>
