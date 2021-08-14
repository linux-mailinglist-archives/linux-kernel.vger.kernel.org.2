Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A9A3EBFC9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 04:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhHNCe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 22:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhHNCez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 22:34:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C553C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 19:34:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id go31so21671604ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 19:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qODIiEti5imuSw+9kq6rlDXiyQLkImYMdyw2bfnUpHA=;
        b=RVZ2BDN75L8KZ9DmZ3Ko++Inj4JU78OZ/5FQT/ba9LrW+Y2TJlJvUjXnSw/XqvnAWT
         Elyext+rePmrum/udJm8YmssfVmZTEpO4j44de89w19im9AQUow4jJok+YYAMoWG26KO
         ArQcCZkXmVIjPk9WAep4UTDGADHtrYjwifC/4B2/WPwL2rHBVbwQaRvs+9Lj0rI0gA21
         huCO4+jRp/9aPUlermKG47B8uSJSsLnzoN4XgTgRnDW7N96Al/LfmwB/XRnIy4gipkSz
         Jn9D3K0Ygcg0ZReMKiA5Tv2zwIe4bkUymLzd2BRVtWKwaSuiIsiZ9hRVPbkSKSnooKXV
         PVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qODIiEti5imuSw+9kq6rlDXiyQLkImYMdyw2bfnUpHA=;
        b=dLyDD4QDMekTxQEE/BX4ZOqJfrAS6ztFtoiBf0pvaJ3jIAZ4Xd366SxvESoltTHBKl
         cQGNacvoUx4jalzzdnAkuVP6RkfhP9LBDoWgHmidU8EPNz5hcxYU25wJAYwz3GUastQq
         /v14zDqO1bQuFazKMnSST7dBwrL1crx90dvo6jr2dDMKrndtevJhbsPNes7JRJlro6Ss
         FOpTMnXJjwPk8wMK3ais1QUKQBw80irKrqXGv/ZzfqRxsT5vfDQK9+5WGXHcDUiEmvn2
         NsKcjtPtbeIUtSo6d7lYFL8N4icYfBaGayFw6OcVq5WOSv0axQ0iqyU8E8Sb7xEdkoQN
         OIuA==
X-Gm-Message-State: AOAM530rymMS8ivuP/6/CpmdJWjHU+kBrYKcyv+PIFq/wge09dQTs17Z
        +97q0C2an3mFb53LGT+bra4nR1/oa+buvw/4xsg=
X-Google-Smtp-Source: ABdhPJzWFA2PR7TJvoveo2RPb3Xm6SLDvZravxhyoAJKus2nnXStlZc+mPyTuAfSMI7VyKRKhPLAtNmu4L0OQlT7t1I=
X-Received: by 2002:a17:906:b890:: with SMTP id hb16mr5311161ejb.383.1628908464093;
 Fri, 13 Aug 2021 19:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210731063938.1391602-1-yuzhao@google.com> <20210731063938.1391602-3-yuzhao@google.com>
 <CAHbLzkq4Bk2U8gEOum=uspwtjh=4ikoxdh7oJmyBLNvch8uvyA@mail.gmail.com>
 <CAOUHufZdefs-QQnKb_8M_KCrUHB4qurB6ULGOy3vc8A_R3gFPA@mail.gmail.com>
 <CAHbLzkqasAZ3UWcKQCAqd4OJX58_DMyxKnyvqBaNc8xekpP8-w@mail.gmail.com>
 <CAOUHufb0fK9nBzMn-hx9uybGGWyWFE3bB0MRF1+Vwse8vPth7g@mail.gmail.com>
 <CAHbLzkpJ5gB7dsRMDspx5+_v+OMQkQ3D_c5n1tqP0o0hthvSQA@mail.gmail.com>
 <CAOUHufYJ91cBKk38b5H9X6vobBQm29gNiZ5arTc9Civtf0y3WA@mail.gmail.com>
 <CAHbLzkrPSFGTn+DYo4m90=8=u+36c98yzZaHCgYOZF1mYz+L=Q@mail.gmail.com> <CAOUHufZiWuvHPUBji_4OT0eP6C_tdQxGiQLipV=ApKo8ua=jjQ@mail.gmail.com>
In-Reply-To: <CAOUHufZiWuvHPUBji_4OT0eP6C_tdQxGiQLipV=ApKo8ua=jjQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 13 Aug 2021 19:34:11 -0700
Message-ID: <CAHbLzkpsp51=zKTrw=P=1YbFq7MtcdgTvZ_ds4SwVMLRKqQtVQ@mail.gmail.com>
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

On Fri, Aug 13, 2021 at 6:49 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Fri, Aug 13, 2021 at 6:30 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Fri, Aug 13, 2021 at 4:56 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > ()
> > > On Fri, Aug 13, 2021 at 5:24 PM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > On Wed, Aug 11, 2021 at 4:12 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > >
> > > > > On Wed, Aug 11, 2021 at 4:25 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > > >
> > > > > > On Sun, Aug 8, 2021 at 10:49 AM Yu Zhao <yuzhao@google.com> wrote:
> > > > > > >
> > > > > > > On Wed, Aug 4, 2021 at 6:13 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Jul 30, 2021 at 11:39 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > > > > > >
> > > > > > > > > If a tail page has only two references left, one inherited from the
> > > > > > > > > isolation of its head and the other from lru_add_page_tail() which we
> > > > > > > > > are about to drop, it means this tail page was concurrently zapped.
> > > > > > > > > Then we can safely free it and save page reclaim or migration the
> > > > > > > > > trouble of trying it.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > > > > > > > Tested-by: Shuang Zhai <zhais@google.com>
> > > > > > > > > ---
> > > > > > > > >  include/linux/vm_event_item.h |  1 +
> > > > > > > > >  mm/huge_memory.c              | 28 ++++++++++++++++++++++++++++
> > > > > > > > >  mm/vmstat.c                   |  1 +
> > > > > > > > >  3 files changed, 30 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> > > > > > > > > index ae0dd1948c2b..829eeac84094 100644
> > > > > > > > > --- a/include/linux/vm_event_item.h
> > > > > > > > > +++ b/include/linux/vm_event_item.h
> > > > > > > > > @@ -99,6 +99,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> > > > > > > > >  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> > > > > > > > >                 THP_SPLIT_PUD,
> > > > > > > > >  #endif
> > > > > > > > > +               THP_SPLIT_FREE,
> > > > > > > > >                 THP_ZERO_PAGE_ALLOC,
> > > > > > > > >                 THP_ZERO_PAGE_ALLOC_FAILED,
> > > > > > > > >                 THP_SWPOUT,
> > > > > > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > > > > > index d8b655856e79..5120478bca41 100644
> > > > > > > > > --- a/mm/huge_memory.c
> > > > > > > > > +++ b/mm/huge_memory.c
> > > > > > > > > @@ -2432,6 +2432,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > > > > > >         struct address_space *swap_cache = NULL;
> > > > > > > > >         unsigned long offset = 0;
> > > > > > > > >         unsigned int nr = thp_nr_pages(head);
> > > > > > > > > +       LIST_HEAD(pages_to_free);
> > > > > > > > > +       int nr_pages_to_free = 0;
> > > > > > > > >         int i;
> > > > > > > > >
> > > > > > > > >         VM_BUG_ON_PAGE(list && PageLRU(head), head);
> > > > > > > > > @@ -2506,6 +2508,25 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > > > > > >                         continue;
> > > > > > > > >                 unlock_page(subpage);
> > > > > > > > >
> > > > > > > > > +               /*
> > > > > > > > > +                * If a tail page has only two references left, one inherited
> > > > > > > > > +                * from the isolation of its head and the other from
> > > > > > > > > +                * lru_add_page_tail() which we are about to drop, it means this
> > > > > > > > > +                * tail page was concurrently zapped. Then we can safely free it
> > > > > > > > > +                * and save page reclaim or migration the trouble of trying it.
> > > > > > > > > +                */
> > > > > > > > > +               if (list && page_ref_freeze(subpage, 2)) {
> > > > > > > > > +                       VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
> > > > > > > > > +                       VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
> > > > > > > > > +                       VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
> > > > > > > > > +
> > > > > > > > > +                       ClearPageActive(subpage);
> > > > > > > > > +                       ClearPageUnevictable(subpage);
> > > > > > > > > +                       list_move(&subpage->lru, &pages_to_free);
> > > > > > > > > +                       nr_pages_to_free++;
> > > > > > > > > +                       continue;
> > > > > > > > > +               }
> > > > > > > >
> > > > > > > > Yes, such page could be freed instead of swapping out. But I'm
> > > > > > > > wondering if we could have some simpler implementation. Since such
> > > > > > > > pages will be re-added to page list, so we should be able to check
> > > > > > > > their refcount in shrink_page_list(). If the refcount is 1, the
> > > > > > > > refcount inc'ed by lru_add_page_tail() has been put by later
> > > > > > > > put_page(), we know it is freed under us since the only refcount comes
> > > > > > > > from isolation, we could just jump to "keep" (the label in
> > > > > > > > shrink_page_list()), then such page will be freed later by
> > > > > > > > shrink_inactive_list().
> > > > > > > >
> > > > > > > > For MADV_PAGEOUT, I think we could add some logic to handle such page
> > > > > > > > after shrink_page_list(), just like what shrink_inactive_list() does.
> > > > > > > >
> > > > > > > > Migration already handles refcount == 1 page, so should not need any change.
> > > > > > > >
> > > > > > > > Is this idea feasible?
> > > > > > >
> > > > > > > Yes, but then we would have to loop over the tail pages twice, here
> > > > > > > and in shrink_page_list(), right?
> > > > > >
> > > > > > I don't quite get what you mean "loop over the tail pages twice". Once
> > > > > > THP is isolated then get split, all the tail pages will be put on the
> > > > > > list (local list for isolated pages), then the reclaimer would deal
> > > > > > with the head page, then continue to iterate the list to deal with
> > > > > > tail pages. Your patch could free the tail pages earlier. But it
> > > > > > should not make too much difference to free the tail pages a little
> > > > > > bit later IMHO.
> > > > >
> > > > > We are in a (the first) loop here. If we free the tail pages later,
> > > > > then we will need to loop over them again (the second).
> > > > >
> > > > > IOW,
> > > > > 1) __split_huge_page(): for each of the 511 tail pages (first loop).
> > > > > 2) shrink_page_list(): for each of the 511 tail pages (second loop).
> > > > >
> > > > > > > In addition, if we try to freeze the refcount of a page in
> > > > > > > shrink_page_list(), we couldn't be certain whether this page used to
> > > > > > > be a tail page. So we would have to test every page. If a page wasn't
> > > > > > > a tail page, it's unlikely for its refcount to drop unless there is a
> > > > > > > race. But this patch isn't really intended to optimize such a race.
> > > > > > > It's mainly for the next, i.e., we know there is a good chance to drop
> > > > > > > tail pages (~10% on our systems). Sounds reasonable? Thanks.
> > > > > >
> > > > > > I'm not sure what is the main source of the partial mapped THPs from
> > > > > > your fleets. But if most of them are generated by MADV_DONTNEED (this
> > > > > > is used by some userspace memory allocator libs), they should be on
> > > > > > deferred split list too. Currently deferred split shrinker just
> > > > > > shrinks those THPs (simply split them and free unmapped sub pages)
> > > > > > proportionally, we definitely could shrink them more aggressively, for
> > > > > > example, by setting shrinker->seeks to 0. I'm wondering if this will
> > > > > > achieve a similar effect or not.
> > > > >
> > > > > Not partially mapped but internal fragmentation.
> > > > >
> > > > > IOW, some of the 4KB pages within a THP were never written into, which
> > > > > can be common depending on the implementations of userspace memory
> > > > > allocators.
> > > >
> > > > OK, this is actually what the patch #3 does. The patch #3 just doesn't
> > > > remap the "all zero" page when splitting the THP IIUC. But the page
> > > > has refcount from isolation so it can't be simply freed by put_page().
> > > >
> > > > Actually this makes me think my suggestion is better. It doesn't make
> > > > too much sense to me to have page free logic (manipulate flags,
> > > > uncharge memcg, etc) in THP split.
> > > >
> > > > There have been a couple of places to handle such cases:
> > > > - deferred split shrinker: the unmapped subpage is just freed by
> > > > put_page() since there is no extra refcount
> > > > - migration: check page refcount then free the refcount == 1 one
> > > >
> > > > Here you add the third case in the page reclaim path, so why not just
> > > > let the page reclaim handle all the work for freeing page?
> > >
> > > As I have explained previously:
> > >
> > > 1) We would have to loop over tail pages twice. Not much overhead but
> > > unnecessary.
> > > 2) We would have to try to freeze the refcount on _every_ page in
> > > shrink_page_list() -- shrink_page_list() takes all pages, not just
> > > relevant ones (previously being tail). Attempting to freeze refcount
> > > on an irrelevant page will likely fail. Again, not a significant
> > > overhead but better to avoid.
> >
> > IIUC you don't need to freeze the refcount, such page is not in swap
> > cache, they don't have mapping. I'm supposed you just need simply do:
>
> Well, not really. There are speculatively page refcount increments and
> decrements. Specifically for what you just mentioned, those pages
> don't have owners anymore but GUP can't reach them. But those who use
> PFN to get pages can always reach them, e.g., compaction. And another
> similar but simpler example:

Yes, all the paths which traverse page via PFN could reach the page
and may inc/dec refcount, some require the page on LRU (e.g.
compaction), some don't (e.g. hwpoison). The page is off LRU and such
refcount race should be harmless.

>
> static struct page *page_idle_get_page(unsigned long pfn)
> {
>         struct page *page = pfn_to_online_page(pfn);
>
>         if (!page || !PageLRU(page) ||
>             !get_page_unless_zero(page))
>                 return NULL;
>
>         if (unlikely(!PageLRU(page))) {
>                 put_page(page);
>                 page = NULL;
>         }
>         return page;
> }
>
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 403a175a720f..031b98627a02 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1547,6 +1547,9 @@ static unsigned int shrink_page_list(struct
> > list_head *page_list,
> >                  * Lazyfree page could be freed directly
> >                  */
> >                 if (PageAnon(page) && PageSwapBacked(page)) {
> > +                       if (page_count(page) == 1)
> > +                               goto locked;
> > +
> >                         if (!PageSwapCache(page)) {
> >                                 if (!(sc->gfp_mask & __GFP_IO))
> >                                         goto keep_locked;
> >
> > It is an unmapped anonymous page, nobody could see it other than
> > hwpoison handler AFAICT.
>
> This claim is false but the code works (if we change locked to keep_locked).

Yeah, keep_locked. I thought keep_locked, but typed locked.

>
> When we are here, we have called
> 1) trylock_page()
> 2) page_check_references() -- _costly_
>
> We have to call
> 1) unlock_page()
> 2) lock lru -- _costly_
> 3) put_page_testzero() in move_pages_to_lru()
> 4) unlock lru
> before we reach mem_cgroup_uncharge_list() and free_unref_page_list().
>
> These 6 extra steps are unnecessary. If we want to do it properly in
> shrink_page_list(), we should try to freeze the refcount of each page
> before step 1, and if successful, add this page to the free_pages
> list. But again, the two points I mentioned earlier are still valid.
> We do save a few lines of code though.

You definitely could move the check earlier or freeze the refcount.
There are a couple of different ways, that example code is just for
illustration.

>
> > > I'm not against your idea. But I'd like to hear some clarifications
> > > about the points above. That is whether you think it's still a good
> > > idea to do what you suggested after taking these into account.
> >
> > I personally don't feel very comfortable to have the extra freeing
> > page logic in THP split when we could leverage page reclaim code with
> > acceptable overhead. And migration code already did so.
>
> I understand. And I agree that what you suggested is better for
> readability. I'm just listing things we may want to consider while
> deciding which option is more favorable.
>
> > > > > > I really don't have any objection to free such pages, but just
> > > > > > wondering if we could have something simpler or not.
> > > > >
> > > > > Thanks.
> > > > >
> > > > > > > > > +
> > > > > > > > >                 /*
> > > > > > > > >                  * Subpages may be freed if there wasn't any mapping
> > > > > > > > >                  * like if add_to_swap() is running on a lru page that
> > > > > > > > > @@ -2515,6 +2536,13 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > > > > > >                  */
> > > > > > > > >                 put_page(subpage);
> > > > > > > > >         }
> > > > > > > > > +
> > > > > > > > > +       if (!nr_pages_to_free)
> > > > > > > > > +               return;
> > > > > > > > > +
> > > > > > > > > +       mem_cgroup_uncharge_list(&pages_to_free);
> > > > > > > > > +       free_unref_page_list(&pages_to_free);
> > > > > > > > > +       count_vm_events(THP_SPLIT_FREE, nr_pages_to_free);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  int total_mapcount(struct page *page)
> > > > > > > > > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > > > > > > > > index b0534e068166..f486e5d98d96 100644
> > > > > > > > > --- a/mm/vmstat.c
> > > > > > > > > +++ b/mm/vmstat.c
> > > > > > > > > @@ -1300,6 +1300,7 @@ const char * const vmstat_text[] = {
> > > > > > > > >  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> > > > > > > > >         "thp_split_pud",
> > > > > > > > >  #endif
> > > > > > > > > +       "thp_split_free",
> > > > > > > > >         "thp_zero_page_alloc",
> > > > > > > > >         "thp_zero_page_alloc_failed",
> > > > > > > > >         "thp_swpout",
> > > > > > > > > --
> > > > > > > > > 2.32.0.554.ge1b32706d8-goog
> > > > > > > > >
