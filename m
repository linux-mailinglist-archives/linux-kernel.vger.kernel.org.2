Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841863EBEB1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 01:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbhHMXZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 19:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbhHMXZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 19:25:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93748C0617AE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:24:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id q3so13596952edt.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+/0ZHNqK7I8h7CvYkTI/ycEQ9BdzEEzZoBehrFQBDA=;
        b=YXFOJ2gI0x/RXrHrLG1hOza+akxKdQut2kC0ER8hh6SePxZg9vLQP9QD2seGfvunPr
         C66xb7lcT8boSUxozlRDUXNdwLLkghmVGoJ0AvupFannUJOQSe/50FqaH+ELqH+emXS3
         JKCrSSrkjtkINB5H2F/LV+xIsjjpW42PusZoZPazDjX9KFQLkpT/Oo3DfsGy9KH6KKl9
         /nfLVMYM4xhCWOWxnjGZ3GNh5F2tsHdWHwEx2YwppTP88Max5mqMxWgqy3R4Lb4Rrw60
         xeqjhMOMgqMYq5oex+iMKOFjsRyP5RjVWjHEhu27aQKceAEU6a/h0vYdcRWgASmiayHH
         2Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+/0ZHNqK7I8h7CvYkTI/ycEQ9BdzEEzZoBehrFQBDA=;
        b=IeiKUP+SUg68e8xF4Rducl1mUg4D1aYUhltFIZBpHIJNY14zpsBzwykvgj67vRsLwm
         4LUK1wZGlo5HbYzXiRPB53/Hyu+3poABNT9Z4je2vXxqSIsIobooqfZ6XDx3jBcAuVx/
         X1JsKpAmC8pHYllborPGUn6eLDYlSBL4CkKChyJ9uzJKieixk5H+MzYB6HF++9XebjZA
         W3ATV+ivhvfunqdiQ0xPjTvtrdvuhHrnQDz18Et1R42NbSBfoP2R7G7ADfbOdcNZqg82
         AG9bdPqmwYXQbIhYmYBy0/Q4Ni1YkySV2vnlxekf7/dT3A/7APzWfkkIVjf2WsXptun3
         6Rhg==
X-Gm-Message-State: AOAM532wzpJTzB+RnQIvggHYvCyV0lAApzo0IBH3m3idMgb1Xarf+2qU
        eFJcLU/OoP9yBHeugWEIsJskqQezFacORYjsz3Y=
X-Google-Smtp-Source: ABdhPJwP4J51d2s0LOGUrfohQE/DGyOGjzX/o3/VZ7/Wp8Ui0WJ+cvPIoL1TCyGnBvjqUcUqr+CPIE/wNEDvOBK2qNk=
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr6055529edw.137.1628897082533;
 Fri, 13 Aug 2021 16:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210731063938.1391602-1-yuzhao@google.com> <20210731063938.1391602-3-yuzhao@google.com>
 <CAHbLzkq4Bk2U8gEOum=uspwtjh=4ikoxdh7oJmyBLNvch8uvyA@mail.gmail.com>
 <CAOUHufZdefs-QQnKb_8M_KCrUHB4qurB6ULGOy3vc8A_R3gFPA@mail.gmail.com>
 <CAHbLzkqasAZ3UWcKQCAqd4OJX58_DMyxKnyvqBaNc8xekpP8-w@mail.gmail.com> <CAOUHufb0fK9nBzMn-hx9uybGGWyWFE3bB0MRF1+Vwse8vPth7g@mail.gmail.com>
In-Reply-To: <CAOUHufb0fK9nBzMn-hx9uybGGWyWFE3bB0MRF1+Vwse8vPth7g@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 13 Aug 2021 16:24:30 -0700
Message-ID: <CAHbLzkpJ5gB7dsRMDspx5+_v+OMQkQ3D_c5n1tqP0o0hthvSQA@mail.gmail.com>
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

On Wed, Aug 11, 2021 at 4:12 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Aug 11, 2021 at 4:25 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Sun, Aug 8, 2021 at 10:49 AM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > On Wed, Aug 4, 2021 at 6:13 PM Yang Shi <shy828301@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 30, 2021 at 11:39 PM Yu Zhao <yuzhao@google.com> wrote:
> > > > >
> > > > > If a tail page has only two references left, one inherited from the
> > > > > isolation of its head and the other from lru_add_page_tail() which we
> > > > > are about to drop, it means this tail page was concurrently zapped.
> > > > > Then we can safely free it and save page reclaim or migration the
> > > > > trouble of trying it.
> > > > >
> > > > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > > > Tested-by: Shuang Zhai <zhais@google.com>
> > > > > ---
> > > > >  include/linux/vm_event_item.h |  1 +
> > > > >  mm/huge_memory.c              | 28 ++++++++++++++++++++++++++++
> > > > >  mm/vmstat.c                   |  1 +
> > > > >  3 files changed, 30 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> > > > > index ae0dd1948c2b..829eeac84094 100644
> > > > > --- a/include/linux/vm_event_item.h
> > > > > +++ b/include/linux/vm_event_item.h
> > > > > @@ -99,6 +99,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
> > > > >  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> > > > >                 THP_SPLIT_PUD,
> > > > >  #endif
> > > > > +               THP_SPLIT_FREE,
> > > > >                 THP_ZERO_PAGE_ALLOC,
> > > > >                 THP_ZERO_PAGE_ALLOC_FAILED,
> > > > >                 THP_SWPOUT,
> > > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > > index d8b655856e79..5120478bca41 100644
> > > > > --- a/mm/huge_memory.c
> > > > > +++ b/mm/huge_memory.c
> > > > > @@ -2432,6 +2432,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > >         struct address_space *swap_cache = NULL;
> > > > >         unsigned long offset = 0;
> > > > >         unsigned int nr = thp_nr_pages(head);
> > > > > +       LIST_HEAD(pages_to_free);
> > > > > +       int nr_pages_to_free = 0;
> > > > >         int i;
> > > > >
> > > > >         VM_BUG_ON_PAGE(list && PageLRU(head), head);
> > > > > @@ -2506,6 +2508,25 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > >                         continue;
> > > > >                 unlock_page(subpage);
> > > > >
> > > > > +               /*
> > > > > +                * If a tail page has only two references left, one inherited
> > > > > +                * from the isolation of its head and the other from
> > > > > +                * lru_add_page_tail() which we are about to drop, it means this
> > > > > +                * tail page was concurrently zapped. Then we can safely free it
> > > > > +                * and save page reclaim or migration the trouble of trying it.
> > > > > +                */
> > > > > +               if (list && page_ref_freeze(subpage, 2)) {
> > > > > +                       VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
> > > > > +                       VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
> > > > > +                       VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
> > > > > +
> > > > > +                       ClearPageActive(subpage);
> > > > > +                       ClearPageUnevictable(subpage);
> > > > > +                       list_move(&subpage->lru, &pages_to_free);
> > > > > +                       nr_pages_to_free++;
> > > > > +                       continue;
> > > > > +               }
> > > >
> > > > Yes, such page could be freed instead of swapping out. But I'm
> > > > wondering if we could have some simpler implementation. Since such
> > > > pages will be re-added to page list, so we should be able to check
> > > > their refcount in shrink_page_list(). If the refcount is 1, the
> > > > refcount inc'ed by lru_add_page_tail() has been put by later
> > > > put_page(), we know it is freed under us since the only refcount comes
> > > > from isolation, we could just jump to "keep" (the label in
> > > > shrink_page_list()), then such page will be freed later by
> > > > shrink_inactive_list().
> > > >
> > > > For MADV_PAGEOUT, I think we could add some logic to handle such page
> > > > after shrink_page_list(), just like what shrink_inactive_list() does.
> > > >
> > > > Migration already handles refcount == 1 page, so should not need any change.
> > > >
> > > > Is this idea feasible?
> > >
> > > Yes, but then we would have to loop over the tail pages twice, here
> > > and in shrink_page_list(), right?
> >
> > I don't quite get what you mean "loop over the tail pages twice". Once
> > THP is isolated then get split, all the tail pages will be put on the
> > list (local list for isolated pages), then the reclaimer would deal
> > with the head page, then continue to iterate the list to deal with
> > tail pages. Your patch could free the tail pages earlier. But it
> > should not make too much difference to free the tail pages a little
> > bit later IMHO.
>
> We are in a (the first) loop here. If we free the tail pages later,
> then we will need to loop over them again (the second).
>
> IOW,
> 1) __split_huge_page(): for each of the 511 tail pages (first loop).
> 2) shrink_page_list(): for each of the 511 tail pages (second loop).
>
> > > In addition, if we try to freeze the refcount of a page in
> > > shrink_page_list(), we couldn't be certain whether this page used to
> > > be a tail page. So we would have to test every page. If a page wasn't
> > > a tail page, it's unlikely for its refcount to drop unless there is a
> > > race. But this patch isn't really intended to optimize such a race.
> > > It's mainly for the next, i.e., we know there is a good chance to drop
> > > tail pages (~10% on our systems). Sounds reasonable? Thanks.
> >
> > I'm not sure what is the main source of the partial mapped THPs from
> > your fleets. But if most of them are generated by MADV_DONTNEED (this
> > is used by some userspace memory allocator libs), they should be on
> > deferred split list too. Currently deferred split shrinker just
> > shrinks those THPs (simply split them and free unmapped sub pages)
> > proportionally, we definitely could shrink them more aggressively, for
> > example, by setting shrinker->seeks to 0. I'm wondering if this will
> > achieve a similar effect or not.
>
> Not partially mapped but internal fragmentation.
>
> IOW, some of the 4KB pages within a THP were never written into, which
> can be common depending on the implementations of userspace memory
> allocators.

OK, this is actually what the patch #3 does. The patch #3 just doesn't
remap the "all zero" page when splitting the THP IIUC. But the page
has refcount from isolation so it can't be simply freed by put_page().

Actually this makes me think my suggestion is better. It doesn't make
too much sense to me to have page free logic (manipulate flags,
uncharge memcg, etc) in THP split.

There have been a couple of places to handle such cases:
- deferred split shrinker: the unmapped subpage is just freed by
put_page() since there is no extra refcount
- migration: check page refcount then free the refcount == 1 one

Here you add the third case in the page reclaim path, so why not just
let the page reclaim handle all the work for freeing page?

>
> > I really don't have any objection to free such pages, but just
> > wondering if we could have something simpler or not.
>
> Thanks.
>
> > > > > +
> > > > >                 /*
> > > > >                  * Subpages may be freed if there wasn't any mapping
> > > > >                  * like if add_to_swap() is running on a lru page that
> > > > > @@ -2515,6 +2536,13 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> > > > >                  */
> > > > >                 put_page(subpage);
> > > > >         }
> > > > > +
> > > > > +       if (!nr_pages_to_free)
> > > > > +               return;
> > > > > +
> > > > > +       mem_cgroup_uncharge_list(&pages_to_free);
> > > > > +       free_unref_page_list(&pages_to_free);
> > > > > +       count_vm_events(THP_SPLIT_FREE, nr_pages_to_free);
> > > > >  }
> > > > >
> > > > >  int total_mapcount(struct page *page)
> > > > > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > > > > index b0534e068166..f486e5d98d96 100644
> > > > > --- a/mm/vmstat.c
> > > > > +++ b/mm/vmstat.c
> > > > > @@ -1300,6 +1300,7 @@ const char * const vmstat_text[] = {
> > > > >  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> > > > >         "thp_split_pud",
> > > > >  #endif
> > > > > +       "thp_split_free",
> > > > >         "thp_zero_page_alloc",
> > > > >         "thp_zero_page_alloc_failed",
> > > > >         "thp_swpout",
> > > > > --
> > > > > 2.32.0.554.ge1b32706d8-goog
> > > > >
