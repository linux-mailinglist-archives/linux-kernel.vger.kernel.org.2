Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C9F3E3C15
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 19:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhHHRuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 13:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhHHRuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 13:50:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1604C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 10:49:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l14so1281511wrw.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=blFgUhoz8BsQqa/AS0G7/VKilP21EDRIfOXjjXEaSWg=;
        b=Ep351n1OHXLN0Mp3wUKytZDtzY7Gx3iF3vVL0sieJX9lIB7H0gs6xSasv9sSJAtgzL
         J6dc/Jp9gL7zPhlZykQv8xVbBIGb1RiMv42KKGYehzo1SMzU494DJgIIDFwHHnayqrbM
         fKJDQ4cvm+UfbhzxQdiA/ut+SVjf2fILSphxhlgbjIQeza6cHgOXCayQBXAg/V0+sYPB
         cyUsyU/UodF64kj4VTSkEE56An0rVhuy7dOnQ3Xfi+k8PKdKdbLuKAdyWiCQtk56P9+A
         m8yraXN9WzOg6SHZcP85xJ3kpnYJPsnpAt10CH4IOrlkb6JHEiPCWfriyq8sjgWauurK
         sHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=blFgUhoz8BsQqa/AS0G7/VKilP21EDRIfOXjjXEaSWg=;
        b=tt+Wxj5ZG8tZG81JF6IMEwW7yhtnlSKQwHVhhq5CWixp5Y5f6l4ufjC/R5WueSbsf6
         FMOkpbvyWMp4+QvLYf0SHCNNHnWIyqcCH6qEXOT2/jpRIXHQwreqUQ/zh0WkCksW4GoR
         VeXK9uPmFL6ne+hwSC27KWsTL+kE3ipQXe6i/B4d99lhipXJtP1LaAf/gyhjRzRthvcm
         9q/daGo53Zq2IUdUEYRm0o8vPgbC3mw0ilnIeKclxVTIq0CgHIdH+klkpwuQ072rjNNY
         0mG0hWHw8/0Bprtz9/ECr3EQKsCxYz48/Ojo79iGsXhOEUbqi4RbtLGw9lxEXXGS+Jvn
         yIGw==
X-Gm-Message-State: AOAM533b+gpmmSmNCz/i+31L8DsgmetovmY3YIVR5jJEzST4Zms/9CeJ
        vNxZcby163peCrr6Ie7QXG7+8nd6F97uXuOXcgPigw==
X-Google-Smtp-Source: ABdhPJxgQ5lACDemuNy/iQ1yOXYzngfASiRFCw+RkTrxdLSVWd9mTVUYnpXOSWHzuEuHRnWP2zt887iSkpTFL4417B4=
X-Received: by 2002:adf:fb8f:: with SMTP id a15mr21071505wrr.92.1628444985059;
 Sun, 08 Aug 2021 10:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210731063938.1391602-1-yuzhao@google.com> <20210731063938.1391602-3-yuzhao@google.com>
 <CAHbLzkq4Bk2U8gEOum=uspwtjh=4ikoxdh7oJmyBLNvch8uvyA@mail.gmail.com>
In-Reply-To: <CAHbLzkq4Bk2U8gEOum=uspwtjh=4ikoxdh7oJmyBLNvch8uvyA@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 8 Aug 2021 11:49:33 -0600
Message-ID: <CAOUHufZdefs-QQnKb_8M_KCrUHB4qurB6ULGOy3vc8A_R3gFPA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: free zapped tail pages when splitting isolated thp
To:     Yang Shi <shy828301@gmail.com>
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

On Wed, Aug 4, 2021 at 6:13 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Fri, Jul 30, 2021 at 11:39 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > If a tail page has only two references left, one inherited from the
> > isolation of its head and the other from lru_add_page_tail() which we
> > are about to drop, it means this tail page was concurrently zapped.
> > Then we can safely free it and save page reclaim or migration the
> > trouble of trying it.
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > Tested-by: Shuang Zhai <zhais@google.com>
> > ---
> >  include/linux/vm_event_item.h |  1 +
> >  mm/huge_memory.c              | 28 ++++++++++++++++++++++++++++
> >  mm/vmstat.c                   |  1 +
> >  3 files changed, 30 insertions(+)
> >
> > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> > index ae0dd1948c2b..829eeac84094 100644
> > --- a/include/linux/vm_event_item.h
> > +++ b/include/linux/vm_event_item.h
> > @@ -99,6 +99,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> >  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> >                 THP_SPLIT_PUD,
> >  #endif
> > +               THP_SPLIT_FREE,
> >                 THP_ZERO_PAGE_ALLOC,
> >                 THP_ZERO_PAGE_ALLOC_FAILED,
> >                 THP_SWPOUT,
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d8b655856e79..5120478bca41 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2432,6 +2432,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >         struct address_space *swap_cache = NULL;
> >         unsigned long offset = 0;
> >         unsigned int nr = thp_nr_pages(head);
> > +       LIST_HEAD(pages_to_free);
> > +       int nr_pages_to_free = 0;
> >         int i;
> >
> >         VM_BUG_ON_PAGE(list && PageLRU(head), head);
> > @@ -2506,6 +2508,25 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >                         continue;
> >                 unlock_page(subpage);
> >
> > +               /*
> > +                * If a tail page has only two references left, one inherited
> > +                * from the isolation of its head and the other from
> > +                * lru_add_page_tail() which we are about to drop, it means this
> > +                * tail page was concurrently zapped. Then we can safely free it
> > +                * and save page reclaim or migration the trouble of trying it.
> > +                */
> > +               if (list && page_ref_freeze(subpage, 2)) {
> > +                       VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
> > +                       VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
> > +                       VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
> > +
> > +                       ClearPageActive(subpage);
> > +                       ClearPageUnevictable(subpage);
> > +                       list_move(&subpage->lru, &pages_to_free);
> > +                       nr_pages_to_free++;
> > +                       continue;
> > +               }
>
> Yes, such page could be freed instead of swapping out. But I'm
> wondering if we could have some simpler implementation. Since such
> pages will be re-added to page list, so we should be able to check
> their refcount in shrink_page_list(). If the refcount is 1, the
> refcount inc'ed by lru_add_page_tail() has been put by later
> put_page(), we know it is freed under us since the only refcount comes
> from isolation, we could just jump to "keep" (the label in
> shrink_page_list()), then such page will be freed later by
> shrink_inactive_list().
>
> For MADV_PAGEOUT, I think we could add some logic to handle such page
> after shrink_page_list(), just like what shrink_inactive_list() does.
>
> Migration already handles refcount == 1 page, so should not need any change.
>
> Is this idea feasible?

Yes, but then we would have to loop over the tail pages twice, here
and in shrink_page_list(), right?

In addition, if we try to freeze the refcount of a page in
shrink_page_list(), we couldn't be certain whether this page used to
be a tail page. So we would have to test every page. If a page wasn't
a tail page, it's unlikely for its refcount to drop unless there is a
race. But this patch isn't really intended to optimize such a race.
It's mainly for the next, i.e., we know there is a good chance to drop
tail pages (~10% on our systems). Sounds reasonable? Thanks.

> > +
> >                 /*
> >                  * Subpages may be freed if there wasn't any mapping
> >                  * like if add_to_swap() is running on a lru page that
> > @@ -2515,6 +2536,13 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >                  */
> >                 put_page(subpage);
> >         }
> > +
> > +       if (!nr_pages_to_free)
> > +               return;
> > +
> > +       mem_cgroup_uncharge_list(&pages_to_free);
> > +       free_unref_page_list(&pages_to_free);
> > +       count_vm_events(THP_SPLIT_FREE, nr_pages_to_free);
> >  }
> >
> >  int total_mapcount(struct page *page)
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index b0534e068166..f486e5d98d96 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1300,6 +1300,7 @@ const char * const vmstat_text[] = {
> >  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> >         "thp_split_pud",
> >  #endif
> > +       "thp_split_free",
> >         "thp_zero_page_alloc",
> >         "thp_zero_page_alloc_failed",
> >         "thp_swpout",
> > --
> > 2.32.0.554.ge1b32706d8-goog
> >
