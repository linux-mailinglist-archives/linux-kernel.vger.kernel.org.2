Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC283EBF00
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 02:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhHNAa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 20:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbhHNAa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 20:30:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8F2C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 17:30:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h9so21348871ejs.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 17:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XD3q2NKwbL739X2g7ZvQouvCOyaE90I8b7ogiId1Oc=;
        b=o558usqyyC5X/NfifhUW+PfcatGf8trIFkMwU3cWuvcsFnlzgCbSixL8UzpmxJgzK1
         jdUYGXuDIO6dTLswKi+LZ4Ij2RoCzwPH3g67S5316e2gy2X59skPEVuk3lUqGWvowCct
         9M4m+Dg7JjZnrFNtQlXzpwkw+gTynCGFdADGJ2BhAVv2wr87L3trTL4c10DLJeqbm89A
         g6BPeARNKww5uV89DiBb2lWSOxl5I7xFW0wFNgIoEAGmoChpt/T2Gp7jE71Ark7T04r7
         qO2YNNXzEkDw0z6Ne4KOiFo6VcGFOl1qcYDfGcZh34IDsN0hzQp1Ty1VmnEyBFaR2m3b
         qiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XD3q2NKwbL739X2g7ZvQouvCOyaE90I8b7ogiId1Oc=;
        b=Zh/ZDThK5pxG0K6r64OwA3hj84eJczqJNR+ruKPWGkJx1QBDadxq8t/p547nKHwv4L
         W/+RKP8TsFlCsS7fh49YQdkFUdKzfw1LkKgHbmzPmv6l/IhXEmY45slk2uvwdDPZgriV
         +WfCSUnGcgLKqWDpJKDePx3zbUr+JqCYj42VLm29NZF3OFMRF3ooZL8AWx0+G2FVD+zD
         jlc7ol/21t+dWWV/PZRpk+anVsBJOuAGFc6bSxf0nK8WPveYvJDRxOdbs482tBEZRVwl
         hC4o5f9poQ354rofZsnkCkeiDtEwPOf8IacTNdmZcscxT/nIRo6PP6JHetKwu3sFnDDl
         3jAw==
X-Gm-Message-State: AOAM530ViBOOpDaNE8sPErcH8U4csuRgrqY+WDXa6YB/gjNG2Q6/piLM
        yuB1T6+npFZ22dCi6e3vqPqe7sqlCX++ZjqlmLk=
X-Google-Smtp-Source: ABdhPJxfRWXxS4eiXa7UsArkQWIzwSXFJ+cR9IPUDfcVqL1LoCgr3/rOrCmEvpR0OJxP75LgzwJQ5p4Qqq8cXKsRylw=
X-Received: by 2002:a17:906:491a:: with SMTP id b26mr5164292ejq.25.1628901028456;
 Fri, 13 Aug 2021 17:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210731063938.1391602-1-yuzhao@google.com> <20210731063938.1391602-3-yuzhao@google.com>
 <CAHbLzkq4Bk2U8gEOum=uspwtjh=4ikoxdh7oJmyBLNvch8uvyA@mail.gmail.com>
 <CAOUHufZdefs-QQnKb_8M_KCrUHB4qurB6ULGOy3vc8A_R3gFPA@mail.gmail.com>
 <CAHbLzkqasAZ3UWcKQCAqd4OJX58_DMyxKnyvqBaNc8xekpP8-w@mail.gmail.com>
 <CAOUHufb0fK9nBzMn-hx9uybGGWyWFE3bB0MRF1+Vwse8vPth7g@mail.gmail.com>
 <CAHbLzkpJ5gB7dsRMDspx5+_v+OMQkQ3D_c5n1tqP0o0hthvSQA@mail.gmail.com> <CAOUHufYJ91cBKk38b5H9X6vobBQm29gNiZ5arTc9Civtf0y3WA@mail.gmail.com>
In-Reply-To: <CAOUHufYJ91cBKk38b5H9X6vobBQm29gNiZ5arTc9Civtf0y3WA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 13 Aug 2021 17:30:16 -0700
Message-ID: <CAHbLzkrPSFGTn+DYo4m90=8=u+36c98yzZaHCgYOZF1mYz+L=Q@mail.gmail.com>
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

On Fri, Aug 13, 2021 at 4:56 PM Yu Zhao <yuzhao@google.com> wrote:
>
> ()
> On Fri, Aug 13, 2021 at 5:24 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Wed, Aug 11, 2021 at 4:12 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Wed, Aug 11, 2021 at 4:25 PM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > On Sun, Aug 8, 2021 at 10:49 AM Yu Zhao <yuzhao@google.com> wrote:
> > > > >
> > > > > On Wed, Aug 4, 2021 at 6:13 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Jul 30, 2021 at 11:39 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > > > >
> > > > > > > If a tail page has only two references left, one inherited from the
> > > > > > > isolation of its head and the other from lru_add_page_tail() which we
> > > > > > > are about to drop, it means this tail page was concurrently zapped.
> > > > > > > Then we can safely free it and save page reclaim or migration the
> > > > > > > trouble of trying it.
> > > > > > >
> > > > > > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > > > > > Tested-by: Shuang Zhai <zhais@google.com>
> > > > > > > ---
> > > > > > >  include/linux/vm_event_item.h |  1 +
> > > > > > >  mm/huge_memory.c              | 28 ++++++++++++++++++++++++++++
> > > > > > >  mm/vmstat.c                   |  1 +
> > > > > > >  3 files changed, 30 insertions(+)
> > > > > > >
> > > > > > > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> > > > > > > index ae0dd1948c2b..829eeac84094 100644
> > > > > > > --- a/include/linux/vm_event_item.h
> > > > > > > +++ b/include/linux/vm_event_item.h
> > > > > > > @@ -99,6 +99,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> > > > > > >  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> > > > > > >                 THP_SPLIT_PUD,
> > > > > > >  #endif
> > > > > > > +               THP_SPLIT_FREE,
> > > > > > >                 THP_ZERO_PAGE_ALLOC,
> > > > > > >                 THP_ZERO_PAGE_ALLOC_FAILED,
> > > > > > >                 THP_SWPOUT,
> > > > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > > > index d8b655856e79..5120478bca41 100644
> > > > > > > --- a/mm/huge_memory.c
> > > > > > > +++ b/mm/huge_memory.c
> > > > > > > @@ -2432,6 +2432,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > > > >         struct address_space *swap_cache = NULL;
> > > > > > >         unsigned long offset = 0;
> > > > > > >         unsigned int nr = thp_nr_pages(head);
> > > > > > > +       LIST_HEAD(pages_to_free);
> > > > > > > +       int nr_pages_to_free = 0;
> > > > > > >         int i;
> > > > > > >
> > > > > > >         VM_BUG_ON_PAGE(list && PageLRU(head), head);
> > > > > > > @@ -2506,6 +2508,25 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > > > >                         continue;
> > > > > > >                 unlock_page(subpage);
> > > > > > >
> > > > > > > +               /*
> > > > > > > +                * If a tail page has only two references left, one inherited
> > > > > > > +                * from the isolation of its head and the other from
> > > > > > > +                * lru_add_page_tail() which we are about to drop, it means this
> > > > > > > +                * tail page was concurrently zapped. Then we can safely free it
> > > > > > > +                * and save page reclaim or migration the trouble of trying it.
> > > > > > > +                */
> > > > > > > +               if (list && page_ref_freeze(subpage, 2)) {
> > > > > > > +                       VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
> > > > > > > +                       VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
> > > > > > > +                       VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
> > > > > > > +
> > > > > > > +                       ClearPageActive(subpage);
> > > > > > > +                       ClearPageUnevictable(subpage);
> > > > > > > +                       list_move(&subpage->lru, &pages_to_free);
> > > > > > > +                       nr_pages_to_free++;
> > > > > > > +                       continue;
> > > > > > > +               }
> > > > > >
> > > > > > Yes, such page could be freed instead of swapping out. But I'm
> > > > > > wondering if we could have some simpler implementation. Since such
> > > > > > pages will be re-added to page list, so we should be able to check
> > > > > > their refcount in shrink_page_list(). If the refcount is 1, the
> > > > > > refcount inc'ed by lru_add_page_tail() has been put by later
> > > > > > put_page(), we know it is freed under us since the only refcount comes
> > > > > > from isolation, we could just jump to "keep" (the label in
> > > > > > shrink_page_list()), then such page will be freed later by
> > > > > > shrink_inactive_list().
> > > > > >
> > > > > > For MADV_PAGEOUT, I think we could add some logic to handle such page
> > > > > > after shrink_page_list(), just like what shrink_inactive_list() does.
> > > > > >
> > > > > > Migration already handles refcount == 1 page, so should not need any change.
> > > > > >
> > > > > > Is this idea feasible?
> > > > >
> > > > > Yes, but then we would have to loop over the tail pages twice, here
> > > > > and in shrink_page_list(), right?
> > > >
> > > > I don't quite get what you mean "loop over the tail pages twice". Once
> > > > THP is isolated then get split, all the tail pages will be put on the
> > > > list (local list for isolated pages), then the reclaimer would deal
> > > > with the head page, then continue to iterate the list to deal with
> > > > tail pages. Your patch could free the tail pages earlier. But it
> > > > should not make too much difference to free the tail pages a little
> > > > bit later IMHO.
> > >
> > > We are in a (the first) loop here. If we free the tail pages later,
> > > then we will need to loop over them again (the second).
> > >
> > > IOW,
> > > 1) __split_huge_page(): for each of the 511 tail pages (first loop).
> > > 2) shrink_page_list(): for each of the 511 tail pages (second loop).
> > >
> > > > > In addition, if we try to freeze the refcount of a page in
> > > > > shrink_page_list(), we couldn't be certain whether this page used to
> > > > > be a tail page. So we would have to test every page. If a page wasn't
> > > > > a tail page, it's unlikely for its refcount to drop unless there is a
> > > > > race. But this patch isn't really intended to optimize such a race.
> > > > > It's mainly for the next, i.e., we know there is a good chance to drop
> > > > > tail pages (~10% on our systems). Sounds reasonable? Thanks.
> > > >
> > > > I'm not sure what is the main source of the partial mapped THPs from
> > > > your fleets. But if most of them are generated by MADV_DONTNEED (this
> > > > is used by some userspace memory allocator libs), they should be on
> > > > deferred split list too. Currently deferred split shrinker just
> > > > shrinks those THPs (simply split them and free unmapped sub pages)
> > > > proportionally, we definitely could shrink them more aggressively, for
> > > > example, by setting shrinker->seeks to 0. I'm wondering if this will
> > > > achieve a similar effect or not.
> > >
> > > Not partially mapped but internal fragmentation.
> > >
> > > IOW, some of the 4KB pages within a THP were never written into, which
> > > can be common depending on the implementations of userspace memory
> > > allocators.
> >
> > OK, this is actually what the patch #3 does. The patch #3 just doesn't
> > remap the "all zero" page when splitting the THP IIUC. But the page
> > has refcount from isolation so it can't be simply freed by put_page().
> >
> > Actually this makes me think my suggestion is better. It doesn't make
> > too much sense to me to have page free logic (manipulate flags,
> > uncharge memcg, etc) in THP split.
> >
> > There have been a couple of places to handle such cases:
> > - deferred split shrinker: the unmapped subpage is just freed by
> > put_page() since there is no extra refcount
> > - migration: check page refcount then free the refcount == 1 one
> >
> > Here you add the third case in the page reclaim path, so why not just
> > let the page reclaim handle all the work for freeing page?
>
> As I have explained previously:
>
> 1) We would have to loop over tail pages twice. Not much overhead but
> unnecessary.
> 2) We would have to try to freeze the refcount on _every_ page in
> shrink_page_list() -- shrink_page_list() takes all pages, not just
> relevant ones (previously being tail). Attempting to freeze refcount
> on an irrelevant page will likely fail. Again, not a significant
> overhead but better to avoid.

IIUC you don't need to freeze the refcount, such page is not in swap
cache, they don't have mapping. I'm supposed you just need simply do:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 403a175a720f..031b98627a02 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1547,6 +1547,9 @@ static unsigned int shrink_page_list(struct
list_head *page_list,
                 * Lazyfree page could be freed directly
                 */
                if (PageAnon(page) && PageSwapBacked(page)) {
+                       if (page_count(page) == 1)
+                               goto locked;
+
                        if (!PageSwapCache(page)) {
                                if (!(sc->gfp_mask & __GFP_IO))
                                        goto keep_locked;

It is an unmapped anonymous page, nobody could see it other than
hwpoison handler AFAICT.

>
> I'm not against your idea. But I'd like to hear some clarifications
> about the points above. That is whether you think it's still a good
> idea to do what you suggested after taking these into account.

I personally don't feel very comfortable to have the extra freeing
page logic in THP split when we could leverage page reclaim code with
acceptable overhead. And migration code already did so.

>
> > > > I really don't have any objection to free such pages, but just
> > > > wondering if we could have something simpler or not.
> > >
> > > Thanks.
> > >
> > > > > > > +
> > > > > > >                 /*
> > > > > > >                  * Subpages may be freed if there wasn't any mapping
> > > > > > >                  * like if add_to_swap() is running on a lru page that
> > > > > > > @@ -2515,6 +2536,13 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > > > >                  */
> > > > > > >                 put_page(subpage);
> > > > > > >         }
> > > > > > > +
> > > > > > > +       if (!nr_pages_to_free)
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       mem_cgroup_uncharge_list(&pages_to_free);
> > > > > > > +       free_unref_page_list(&pages_to_free);
> > > > > > > +       count_vm_events(THP_SPLIT_FREE, nr_pages_to_free);
> > > > > > >  }
> > > > > > >
> > > > > > >  int total_mapcount(struct page *page)
> > > > > > > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > > > > > > index b0534e068166..f486e5d98d96 100644
> > > > > > > --- a/mm/vmstat.c
> > > > > > > +++ b/mm/vmstat.c
> > > > > > > @@ -1300,6 +1300,7 @@ const char * const vmstat_text[] = {
> > > > > > >  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> > > > > > >         "thp_split_pud",
> > > > > > >  #endif
> > > > > > > +       "thp_split_free",
> > > > > > >         "thp_zero_page_alloc",
> > > > > > >         "thp_zero_page_alloc_failed",
> > > > > > >         "thp_swpout",
> > > > > > > --
> > > > > > > 2.32.0.554.ge1b32706d8-goog
> > > > > > >
