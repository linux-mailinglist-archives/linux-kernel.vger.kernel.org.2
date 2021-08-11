Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD70C3E9AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhHKWZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhHKWZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:25:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87205C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:25:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id bo19so6160666edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJpBS5OoiDFTcbVpGQiUJVnQBK3el7kqkKuLN5erzD4=;
        b=S5kxUee+y9SPPTHZlc8G3oed6PBjSOCQWPy0ktkl5FU0uFo2hlHwfM+FgM6fyYXTwW
         0Et3JmqKvuLtXtazTkxCKshH4jf4Rpx8ygVPjCtpRAhr+5rt9HXDKSAh6d3SznjWVQiY
         E9ubEWX2uNubRFsGkty1uoCG2Z518FcQ/lrhUnH2upulPek42sFw9vOoPhZ597KLljvh
         piNYCCr7FHCXZfvMWosbXmRw8pjo6yfV5ys37OW2Evovf0ukAM2oALYCOnASzPO/xeO4
         JD/8CJI4t6l3IvHAI5NJDnHWlhUIS0HsZ1dyfBRGBOdx9kCuOsWkcYojURsojWTOeHB6
         8NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJpBS5OoiDFTcbVpGQiUJVnQBK3el7kqkKuLN5erzD4=;
        b=T5I0t6E8cnoRz4XO96PO4VzeR1uY4rdKHf98DzxIpmiP0JRN8kIf2MPr2YDtDF4UV7
         G0pUpwFEtwgGukZhqC1qC/XZzLM9E2mcOqE4XHcf6r91pKuPcPokSlS7+PGToc64YnHd
         gz6KKa0jexSyy5Q1kjy5okhfI5IZoENB0iWJy8CuOdyG+ToeWrkPR1WbZiBizapTGlQh
         ulxZb+KvMpftOWMSxBpCH5yXzbVc203F9RoI6rkSkVv3i4k1V2bpAEjuLH4FrZgVXB+z
         9wUg2GTHEyHtnKYPoonNg5JBu2yofmUfygAU1OkKBjgrDBej8BIodrofnQ5D7Vaj7hSh
         D5nA==
X-Gm-Message-State: AOAM533D8/8DCmOzN+9sbk56zloafhmaA9RMC21/uhvg4YjTVXj62PiV
        lzYV6tvZEA/E/0iAK0+dLNiYxgNdIC8S51lzvD4=
X-Google-Smtp-Source: ABdhPJxCt0+TpHxvY37MRuA4EXyyS8X4JdVh9eV3T7FFVW0IJdg4EYKpXgdP2pTDIfNutmH0nIbJ5XxrPj/EIs/G6F8=
X-Received: by 2002:aa7:d896:: with SMTP id u22mr1488054edq.290.1628720732183;
 Wed, 11 Aug 2021 15:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210731063938.1391602-1-yuzhao@google.com> <20210731063938.1391602-3-yuzhao@google.com>
 <CAHbLzkq4Bk2U8gEOum=uspwtjh=4ikoxdh7oJmyBLNvch8uvyA@mail.gmail.com> <CAOUHufZdefs-QQnKb_8M_KCrUHB4qurB6ULGOy3vc8A_R3gFPA@mail.gmail.com>
In-Reply-To: <CAOUHufZdefs-QQnKb_8M_KCrUHB4qurB6ULGOy3vc8A_R3gFPA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 11 Aug 2021 15:25:19 -0700
Message-ID: <CAHbLzkqasAZ3UWcKQCAqd4OJX58_DMyxKnyvqBaNc8xekpP8-w@mail.gmail.com>
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

On Sun, Aug 8, 2021 at 10:49 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Aug 4, 2021 at 6:13 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Fri, Jul 30, 2021 at 11:39 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > If a tail page has only two references left, one inherited from the
> > > isolation of its head and the other from lru_add_page_tail() which we
> > > are about to drop, it means this tail page was concurrently zapped.
> > > Then we can safely free it and save page reclaim or migration the
> > > trouble of trying it.
> > >
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > Tested-by: Shuang Zhai <zhais@google.com>
> > > ---
> > >  include/linux/vm_event_item.h |  1 +
> > >  mm/huge_memory.c              | 28 ++++++++++++++++++++++++++++
> > >  mm/vmstat.c                   |  1 +
> > >  3 files changed, 30 insertions(+)
> > >
> > > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> > > index ae0dd1948c2b..829eeac84094 100644
> > > --- a/include/linux/vm_event_item.h
> > > +++ b/include/linux/vm_event_item.h
> > > @@ -99,6 +99,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> > >  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> > >                 THP_SPLIT_PUD,
> > >  #endif
> > > +               THP_SPLIT_FREE,
> > >                 THP_ZERO_PAGE_ALLOC,
> > >                 THP_ZERO_PAGE_ALLOC_FAILED,
> > >                 THP_SWPOUT,
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index d8b655856e79..5120478bca41 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -2432,6 +2432,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > >         struct address_space *swap_cache = NULL;
> > >         unsigned long offset = 0;
> > >         unsigned int nr = thp_nr_pages(head);
> > > +       LIST_HEAD(pages_to_free);
> > > +       int nr_pages_to_free = 0;
> > >         int i;
> > >
> > >         VM_BUG_ON_PAGE(list && PageLRU(head), head);
> > > @@ -2506,6 +2508,25 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > >                         continue;
> > >                 unlock_page(subpage);
> > >
> > > +               /*
> > > +                * If a tail page has only two references left, one inherited
> > > +                * from the isolation of its head and the other from
> > > +                * lru_add_page_tail() which we are about to drop, it means this
> > > +                * tail page was concurrently zapped. Then we can safely free it
> > > +                * and save page reclaim or migration the trouble of trying it.
> > > +                */
> > > +               if (list && page_ref_freeze(subpage, 2)) {
> > > +                       VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
> > > +                       VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
> > > +                       VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
> > > +
> > > +                       ClearPageActive(subpage);
> > > +                       ClearPageUnevictable(subpage);
> > > +                       list_move(&subpage->lru, &pages_to_free);
> > > +                       nr_pages_to_free++;
> > > +                       continue;
> > > +               }
> >
> > Yes, such page could be freed instead of swapping out. But I'm
> > wondering if we could have some simpler implementation. Since such
> > pages will be re-added to page list, so we should be able to check
> > their refcount in shrink_page_list(). If the refcount is 1, the
> > refcount inc'ed by lru_add_page_tail() has been put by later
> > put_page(), we know it is freed under us since the only refcount comes
> > from isolation, we could just jump to "keep" (the label in
> > shrink_page_list()), then such page will be freed later by
> > shrink_inactive_list().
> >
> > For MADV_PAGEOUT, I think we could add some logic to handle such page
> > after shrink_page_list(), just like what shrink_inactive_list() does.
> >
> > Migration already handles refcount == 1 page, so should not need any change.
> >
> > Is this idea feasible?
>
> Yes, but then we would have to loop over the tail pages twice, here
> and in shrink_page_list(), right?

I don't quite get what you mean "loop over the tail pages twice". Once
THP is isolated then get split, all the tail pages will be put on the
list (local list for isolated pages), then the reclaimer would deal
with the head page, then continue to iterate the list to deal with
tail pages. Your patch could free the tail pages earlier. But it
should not make too much difference to free the tail pages a little
bit later IMHO.

>
> In addition, if we try to freeze the refcount of a page in
> shrink_page_list(), we couldn't be certain whether this page used to
> be a tail page. So we would have to test every page. If a page wasn't
> a tail page, it's unlikely for its refcount to drop unless there is a
> race. But this patch isn't really intended to optimize such a race.
> It's mainly for the next, i.e., we know there is a good chance to drop
> tail pages (~10% on our systems). Sounds reasonable? Thanks.

I'm not sure what is the main source of the partial mapped THPs from
your fleets. But if most of them are generated by MADV_DONTNEED (this
is used by some userspace memory allocator libs), they should be on
deferred split list too. Currently deferred split shrinker just
shrinks those THPs (simply split them and free unmapped sub pages)
proportionally, we definitely could shrink them more aggressively, for
example, by setting shrinker->seeks to 0. I'm wondering if this will
achieve a similar effect or not.

I really don't have any objection to free such pages, but just
wondering if we could have something simpler or not.

>
> > > +
> > >                 /*
> > >                  * Subpages may be freed if there wasn't any mapping
> > >                  * like if add_to_swap() is running on a lru page that
> > > @@ -2515,6 +2536,13 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > >                  */
> > >                 put_page(subpage);
> > >         }
> > > +
> > > +       if (!nr_pages_to_free)
> > > +               return;
> > > +
> > > +       mem_cgroup_uncharge_list(&pages_to_free);
> > > +       free_unref_page_list(&pages_to_free);
> > > +       count_vm_events(THP_SPLIT_FREE, nr_pages_to_free);
> > >  }
> > >
> > >  int total_mapcount(struct page *page)
> > > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > > index b0534e068166..f486e5d98d96 100644
> > > --- a/mm/vmstat.c
> > > +++ b/mm/vmstat.c
> > > @@ -1300,6 +1300,7 @@ const char * const vmstat_text[] = {
> > >  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> > >         "thp_split_pud",
> > >  #endif
> > > +       "thp_split_free",
> > >         "thp_zero_page_alloc",
> > >         "thp_zero_page_alloc_failed",
> > >         "thp_swpout",
> > > --
> > > 2.32.0.554.ge1b32706d8-goog
> > >
