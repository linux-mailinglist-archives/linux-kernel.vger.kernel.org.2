Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4076039AD18
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 23:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhFCVsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 17:48:40 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:44843 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhFCVsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 17:48:40 -0400
Received: by mail-ed1-f51.google.com with SMTP id u24so8757153edy.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 14:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTck8/ilnhv5uosSgtyLA6WlrsI6tA0jlP/FNz1nlLE=;
        b=RU4tsvAiCEG9n48XtIb1Gv/w3rPoj14le7poY7v9k9CD4M7LCahnANnGGZUanILPGp
         STH/x0z5xbm4XgMmasA0Y6irr9xLPTagEzAmAYOmuk9wb2nTD5vCI9Q4E/+bMP3v+nIk
         tfAH6hqwXYy5z22C8jdMKtC39LUFpHGQ9Vj4lN4L4+IOlzph0kWFt90FhqChvSkBgcol
         X40T97ZOp5lvNgAJnvBWN9iV8HoZEam2iuJTsf0qnosfJcV2J6DL7REmv4UVSpsQBm3c
         NHR4zDk0K4NE+9JEobJHaxmGKLv350gRSeyrBDTCnbVzkObVrKxhpaSzMZbNwbkG3+A1
         3WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTck8/ilnhv5uosSgtyLA6WlrsI6tA0jlP/FNz1nlLE=;
        b=hz6KpToK/yw1TbFuolCJCwrEzNDe4BQKfHTa0Xk5OutR1WuYbyZQfYUf2b9fvItwK+
         CKSGGelbQyAKEXfLatbuiQlqQdj5rBfbr4UKdaf2JdFlqt3Ns5G7wiDwuIesqK8c7cva
         5NToFLL3vD4x5R4hZTkMtGVoh0EJT7TeWvFpnvEo9gUc1/+IAY8WL6oiGYWyXgU4JTHR
         F2yUuC8CZRLf7ecw9sAWVfB35gFjYWsdA7aTqASIgv+CnaZ/HJ61eQk1JXjilrYWaRCR
         qs6mQbh66RMpb/bmBSqDARAco8npIE5NbM73G0S+AjR8cxJOfHUtwySjziDZQTFB6CTQ
         CazA==
X-Gm-Message-State: AOAM530KKeXCCRLRXvFuxniewW4iLVZx0/vKPuRAeVZiRwZIUT77RuNv
        WFKqTL25Ou70a4Uag4C3OjrGILsLIdlBZ/riBlA=
X-Google-Smtp-Source: ABdhPJzQJL90TQNcgBQMcqpqPol3eYE9HPSoLZagYF3rowl7DsCWHiJc6mow3nzJZjntUGLujOSKxLXttVxIpWQRfPo=
X-Received: by 2002:a05:6402:1052:: with SMTP id e18mr1437985edu.366.1622756741709;
 Thu, 03 Jun 2021 14:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils> <alpine.LSU.2.11.2106011405510.2148@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2106011405510.2148@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Jun 2021 14:45:30 -0700
Message-ID: <CAHbLzkrUcNhGDmPstSNHhwbdoo3z2B=v-zb7__M3RqHL-Ct-EA@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm/thp: try_to_unmap() use TTU_SYNC for safe DEBUG_VM splitting
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

On Tue, Jun 1, 2021 at 2:07 PM Hugh Dickins <hughd@google.com> wrote:
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
> to the options, and passing that from unmap_page() when CONFIG_DEBUG_VM=y.
> It could be passed in the non-debug case too, but that would sometimes add
> a little overhead, whereas it's rare for this race to result in failure.

The above statement makes me feel this patch is just to relieve the
VM_BUG_ON, but my patch already changed it to VM_WARN, the race sounds
acceptable (at least not fatal) and the splitting code can handle the
failure case as well. So I'm wondering if we still need this patch or
not if it is just used to close the race when CONFIG_DEBUG_VM=y.

>
> mm/memory-failure.c:hwpoison_user_mappings() should probably use the new
> TTU_SYNC option too, just in case this race coincides with its attempts to
> unmap a failing page (THP or not); but this commit does not add that.
>
> Fixes: fec89c109f3a ("thp: rewrite freeze_page()/unfreeze_page() with generic rmap walkers")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  include/linux/rmap.h |  3 ++-
>  mm/huge_memory.c     |  4 ++++
>  mm/page_vma_mapped.c |  8 ++++++++
>  mm/rmap.c            | 17 ++++++++++++++++-
>  4 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index def5c62c93b3..891599a4cb8d 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -97,7 +97,8 @@ enum ttu_flags {
>                                          * do a final flush if necessary */
>         TTU_RMAP_LOCKED         = 0x80, /* do not grab rmap lock:
>                                          * caller holds it */
> -       TTU_SPLIT_FREEZE        = 0x100,                /* freeze pte under splitting thp */
> +       TTU_SPLIT_FREEZE        = 0x100, /* freeze pte under splitting thp */
> +       TTU_SYNC                = 0x200, /* avoid racy checks with PVMW_SYNC */
>  };
>
>  #ifdef CONFIG_MMU
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9fb7b47da87e..305f709a7aca 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2357,6 +2357,10 @@ static void unmap_page(struct page *page)
>         if (PageAnon(page))
>                 ttu_flags |= TTU_SPLIT_FREEZE;
>
> +       /* Make sure that the BUGs will not bite */
> +       if (IS_ENABLED(CONFIG_DEBUG_VM))
> +               ttu_flags |= TTU_SYNC;
> +
>         unmap_success = try_to_unmap(page, ttu_flags);
>         VM_BUG_ON_PAGE(!unmap_success, page);
>  }
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index 2cf01d933f13..b45d22738b45 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -212,6 +212,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>                         pvmw->ptl = NULL;
>                 }
>         } else if (!pmd_present(pmde)) {
> +               /*
> +                * If PVMW_SYNC, take and drop THP pmd lock so that we
> +                * cannot return prematurely, while zap_huge_pmd() has
> +                * cleared *pmd but not decremented compound_mapcount().
> +                */
> +               if ((pvmw->flags & PVMW_SYNC) &&
> +                   PageTransCompound(pvmw->page))
> +                       spin_unlock(pmd_lock(mm, pvmw->pmd));
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
> 2.32.0.rc0.204.g9fa02ecfa5-goog
>
