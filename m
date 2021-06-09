Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01823A1B5F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhFIRAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFIRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 13:00:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF41C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 09:58:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l1so39478773ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+Iz4z4AXZFpogc1y7XNcas3um0G9P+lqqs2vFYzvns=;
        b=uQAe4Qp74C/urpx55A2OIKTx8CEqWICURBpH4nSsA/vq+J5va3cimSQjvi5o28+NAn
         3g7haWHqYSN7QsIWZG7pMlZZEdFgGk1aOcPtWuGLejMomxsq/avJF/jzLJOyycnGHKZU
         FJu9BKQ1K1xaoCKcRomuVREJQxas84bHZ5iODy8W0IA2/mOfRQ1Zvsz8v3CCWdbg9fBs
         fSg2gjvj4llWzXlwT7SJdj9wioxTQkR2Znwd63DVHwEdGSpe5oYDNC4w/cPuyW2eai1W
         FzpdAPU01XTk28NQaTO6CExYFPDABWh4CI5+667061HZuuS5SfPI6pL1v46Z/sryP+Tj
         3uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+Iz4z4AXZFpogc1y7XNcas3um0G9P+lqqs2vFYzvns=;
        b=BVBCJlVujvc+9gGc93uPQkdPHRNacBepGiqZjPLDuwaRbAufE7pTFPuArhbNfhLCeB
         gwKtF0g4KV2mnb37hkdsbWT4kKaInCiPQJDH1mDKy5WlnASVJAZpm9mYKZXmXRs58CVY
         j5KaM0yK+sRJ/rrxF0EFVX0bycUtcBRaB8dp2kpr+jYHrAEGMu1aEtcUJDWof8tOZSS7
         6FB4zTFRFHLvFVtJrg4wRUTNGXdbvHAtMIrrDvvqoEbJCnxlqPALXTJCIFhZy5jLCJgB
         BDAMW02ryIYTUnjAggaKoQKSJRD6u9EfBt/jwV4kHaP1L3Nr3GrVO6DpGEb9MfhgJYZl
         ghOA==
X-Gm-Message-State: AOAM532KqXswEdKlOZ98AyqHfHxXI6D2J9JizHSDFiQYpqN+/7g+Mzxk
        L8pP7ZtKXPebMibAK5lZCr0dIHnzoR5Bc1pnPVk=
X-Google-Smtp-Source: ABdhPJw7NaYHNKcTjrCEXSSDQKq/WdTMR+eQzRAXm6v3HZoSFaW6MZ5nwGBDWkpwJjz3jiTZ/dnZCUsr7EF+Cn+leAQ=
X-Received: by 2002:a17:906:3912:: with SMTP id f18mr783301eje.161.1623257890532;
 Wed, 09 Jun 2021 09:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <6b2b6683-d9a7-b7d0-a3e5-425b96338d63@google.com>
In-Reply-To: <6b2b6683-d9a7-b7d0-a3e5-425b96338d63@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 9 Jun 2021 09:57:58 -0700
Message-ID: <CAHbLzkpCO-yN6dkM_JbCpK3FtBy_xu1Z4VCcVsSKqkV6nH5Mew@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] mm/thp: try_to_unmap() use TTU_SYNC for safe
 splitting (fwd)
To:     Hugh Dickins <hughd@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 9:12 PM Hugh Dickins <hughd@google.com> wrote:
>
>
>
> ---------- Forwarded message ----------
> Date: Tue, 8 Jun 2021 21:10:19 -0700 (PDT)
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
> Subject: [PATCH v2 03/10] mm/thp: try_to_unmap() use TTU_SYNC for safe splitting
>
> Stressing huge tmpfs often crashed on unmap_page()'s VM_BUG_ON_PAGE
> (!unmap_success): with dump_page() showing mapcount:1, but then its
> raw struct page output showing _mapcount ffffffff i.e. mapcount 0.
>
> And even if that particular VM_BUG_ON_PAGE(!unmap_success) is removed,
> it is immediately followed by a VM_BUG_ON_PAGE(compound_mapcount(head)),
> and further down an IS_ENABLED(CONFIG_DEBUG_VM) total_mapcount BUG():
> all indicative of some mapcount difficulty in development here perhaps.
> But the !CONFIG_DEBUG_VM path handles the failures correctly and silently.
>
> I believe the problem is that once a racing unmap has cleared pte or pmd,
> try_to_unmap_one() may skip taking the page table lock, and emerge from
> try_to_unmap() before the racing task has reached decrementing mapcount.
>
> Instead of abandoning the unsafe VM_BUG_ON_PAGE(), and the ones that
> follow, use PVMW_SYNC in try_to_unmap_one() in this case: adding TTU_SYNC
> to the options, and passing that from unmap_page().
>
> When CONFIG_DEBUG_VM, or for non-debug too?  Consensus is to do the same
> for both: the slight overhead added should rarely matter, except perhaps
> if splitting sparsely-populated multiply-mapped shmem.  Once confident
> that bugs are fixed, TTU_SYNC here can be removed, and the race tolerated.
>
> Fixes: fec89c109f3a ("thp: rewrite freeze_page()/unfreeze_page() with generic rmap walkers")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
> v2: moved TTU_SYNC definition up, to avoid conflict with other patchset
>     use TTU_SYNC even when non-debug, per Peter Xu and Yang Shi
>     expanded PVMW_SYNC's spin_unlock(pmd_lock()), per Kirill and Peter

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
>  include/linux/rmap.h |  1 +
>  mm/huge_memory.c     |  2 +-
>  mm/page_vma_mapped.c | 11 +++++++++++
>  mm/rmap.c            | 17 ++++++++++++++++-
>  4 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index def5c62c93b3..8d04e7deedc6 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -91,6 +91,7 @@ enum ttu_flags {
>
>         TTU_SPLIT_HUGE_PMD      = 0x4,  /* split huge PMD if any */
>         TTU_IGNORE_MLOCK        = 0x8,  /* ignore mlock */
> +       TTU_SYNC                = 0x10, /* avoid racy checks with PVMW_SYNC */
>         TTU_IGNORE_HWPOISON     = 0x20, /* corrupted page is recoverable */
>         TTU_BATCH_FLUSH         = 0x40, /* Batch TLB flushes where possible
>                                          * and caller guarantees they will
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5885c5f5836f..84ab735139dc 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2350,7 +2350,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>
>  static void unmap_page(struct page *page)
>  {
> -       enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
> +       enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK | TTU_SYNC |
>                 TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
>         bool unmap_success;
>
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 2cf01d933f13..5b559967410e 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -212,6 +212,17 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>                         pvmw->ptl = NULL;
>                 }
>         } else if (!pmd_present(pmde)) {
> +               /*
> +                * If PVMW_SYNC, take and drop THP pmd lock so that we
> +                * cannot return prematurely, while zap_huge_pmd() has
> +                * cleared *pmd but not decremented compound_mapcount().
> +                */
> +               if ((pvmw->flags & PVMW_SYNC) &&
> +                   PageTransCompound(pvmw->page)) {
> +                       spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
> +
> +                       spin_unlock(ptl);
> +               }
>                 return false;
>         }
>         if (!map_pte(pvmw))
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 693a610e181d..07811b4ae793 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1405,6 +1405,15 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>         struct mmu_notifier_range range;
>         enum ttu_flags flags = (enum ttu_flags)(long)arg;
>
> +       /*
> +        * When racing against e.g. zap_pte_range() on another cpu,
> +        * in between its ptep_get_and_clear_full() and page_remove_rmap(),
> +        * try_to_unmap() may return false when it is about to become true,
> +        * if page table locking is skipped: use TTU_SYNC to wait for that.
> +        */
> +       if (flags & TTU_SYNC)
> +               pvmw.flags = PVMW_SYNC;
> +
>         /* munlock has nothing to gain from examining un-locked vmas */
>         if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
>                 return true;
> @@ -1777,7 +1786,13 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
>         else
>                 rmap_walk(page, &rwc);
>
> -       return !page_mapcount(page) ? true : false;
> +       /*
> +        * When racing against e.g. zap_pte_range() on another cpu,
> +        * in between its ptep_get_and_clear_full() and page_remove_rmap(),
> +        * try_to_unmap() may return false when it is about to become true,
> +        * if page table locking is skipped: use TTU_SYNC to wait for that.
> +        */
> +       return !page_mapcount(page);
>  }
>
>  /**
> --
> 2.26.2
>
>
