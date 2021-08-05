Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2CB3E0B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 02:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbhHEANk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 20:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhHEANi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 20:13:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A03C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 17:13:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gs8so6339899ejc.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 17:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94iHnb+/irUo9Hib68Z88vXnda7LIvHLlcB+6a3kJg0=;
        b=fXytiDtQb8tuZ8wXEhe+dfUtI7/iEsklS0EH8jNn9Y8LDfUTdSb72m5g2opH81hxzB
         e9jvgl6fdMGLGo87fDbY+mm0/BEfnpRNsLy1cPmuNp3kVWHn/HzKWswZC31oVGU/Gdfj
         S41xL+hwFTWz/vdAABO+Ypp8S6S8N9MQA5ZHFBjl+1LYRTp86ONCKD/7GsyUQs91aqX5
         OPkeuesPW8FQuan0SNTvxsgp4bV4I6sDixj+hIcXdCiYYGH69XOycpEK/Y4gIvtWSXwi
         FNZRvCpf1eLQ9Syxb9asQfDc9ZvrArR1VjEEiTubMklqzuQRbMxuOB+Cx4ZFv2nExTWn
         HzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94iHnb+/irUo9Hib68Z88vXnda7LIvHLlcB+6a3kJg0=;
        b=YU2xcIw6SpJV3xARmo/3eJPyHf075CZSOF5v2bneX2n3pHOWBVGtINs5S9QRD6EapJ
         4UDALrt2cbeheUh8lfpq1ILdan9nkjQkrW1R4nNjSgh8mDfJJVcjFqLKlaY7ZzyMujSh
         srkSYQ/5s0AZQUHyuSRO6KSbwE08efZt+92iVRehuoJeuIASbE+TUr67T+g3TAVIv8hL
         V+R3eaKgEwJbMvXuDv+7l5WcFHgp7Ebx2WCGGHVcYjS2/NXd1Ou480Dg2hojro2r0Tz/
         Oupem1K4lMkDcaRGrrbBNHpLfcFwTYIyF7moFvlIWUzHeqmjlOukr5kZLnacQLO/CHcy
         PHyg==
X-Gm-Message-State: AOAM5335jk4zQsB0qL9JRuLNgi7YWvXrmor5jetpojh/R/5W6Mrdu84+
        ic7hI+mzP8z37PKdXQX610wOeU906wkBivOj4Og=
X-Google-Smtp-Source: ABdhPJzXmARv9nSKtRpxrlJR7zsnMR8RG1pXHF4sHrQIjOfA2n9ltWiom4vrjxdPxNNI14ih1KaB+vU3mWHrB0/MfSk=
X-Received: by 2002:a17:906:1919:: with SMTP id a25mr1670121eje.161.1628122402854;
 Wed, 04 Aug 2021 17:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210731063938.1391602-1-yuzhao@google.com> <20210731063938.1391602-3-yuzhao@google.com>
In-Reply-To: <20210731063938.1391602-3-yuzhao@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 4 Aug 2021 17:13:11 -0700
Message-ID: <CAHbLzkq4Bk2U8gEOum=uspwtjh=4ikoxdh7oJmyBLNvch8uvyA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: free zapped tail pages when splitting isolated thp
To:     Yu Zhao <yuzhao@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuang Zhai <zhais@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 11:39 PM Yu Zhao <yuzhao@google.com> wrote:
>
> If a tail page has only two references left, one inherited from the
> isolation of its head and the other from lru_add_page_tail() which we
> are about to drop, it means this tail page was concurrently zapped.
> Then we can safely free it and save page reclaim or migration the
> trouble of trying it.
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Shuang Zhai <zhais@google.com>
> ---
>  include/linux/vm_event_item.h |  1 +
>  mm/huge_memory.c              | 28 ++++++++++++++++++++++++++++
>  mm/vmstat.c                   |  1 +
>  3 files changed, 30 insertions(+)
>
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index ae0dd1948c2b..829eeac84094 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -99,6 +99,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>                 THP_SPLIT_PUD,
>  #endif
> +               THP_SPLIT_FREE,
>                 THP_ZERO_PAGE_ALLOC,
>                 THP_ZERO_PAGE_ALLOC_FAILED,
>                 THP_SWPOUT,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d8b655856e79..5120478bca41 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2432,6 +2432,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>         struct address_space *swap_cache = NULL;
>         unsigned long offset = 0;
>         unsigned int nr = thp_nr_pages(head);
> +       LIST_HEAD(pages_to_free);
> +       int nr_pages_to_free = 0;
>         int i;
>
>         VM_BUG_ON_PAGE(list && PageLRU(head), head);
> @@ -2506,6 +2508,25 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>                         continue;
>                 unlock_page(subpage);
>
> +               /*
> +                * If a tail page has only two references left, one inherited
> +                * from the isolation of its head and the other from
> +                * lru_add_page_tail() which we are about to drop, it means this
> +                * tail page was concurrently zapped. Then we can safely free it
> +                * and save page reclaim or migration the trouble of trying it.
> +                */
> +               if (list && page_ref_freeze(subpage, 2)) {
> +                       VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
> +                       VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
> +                       VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
> +
> +                       ClearPageActive(subpage);
> +                       ClearPageUnevictable(subpage);
> +                       list_move(&subpage->lru, &pages_to_free);
> +                       nr_pages_to_free++;
> +                       continue;
> +               }

Yes, such page could be freed instead of swapping out. But I'm
wondering if we could have some simpler implementation. Since such
pages will be re-added to page list, so we should be able to check
their refcount in shrink_page_list(). If the refcount is 1, the
refcount inc'ed by lru_add_page_tail() has been put by later
put_page(), we know it is freed under us since the only refcount comes
from isolation, we could just jump to "keep" (the label in
shrink_page_list()), then such page will be freed later by
shrink_inactive_list().

For MADV_PAGEOUT, I think we could add some logic to handle such page
after shrink_page_list(), just like what shrink_inactive_list() does.

Migration already handles refcount == 1 page, so should not need any change.

Is this idea feasible?

> +
>                 /*
>                  * Subpages may be freed if there wasn't any mapping
>                  * like if add_to_swap() is running on a lru page that
> @@ -2515,6 +2536,13 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>                  */
>                 put_page(subpage);
>         }
> +
> +       if (!nr_pages_to_free)
> +               return;
> +
> +       mem_cgroup_uncharge_list(&pages_to_free);
> +       free_unref_page_list(&pages_to_free);
> +       count_vm_events(THP_SPLIT_FREE, nr_pages_to_free);
>  }
>
>  int total_mapcount(struct page *page)
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index b0534e068166..f486e5d98d96 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1300,6 +1300,7 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>         "thp_split_pud",
>  #endif
> +       "thp_split_free",
>         "thp_zero_page_alloc",
>         "thp_zero_page_alloc_failed",
>         "thp_swpout",
> --
> 2.32.0.554.ge1b32706d8-goog
>
