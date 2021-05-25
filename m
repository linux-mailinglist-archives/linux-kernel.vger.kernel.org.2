Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631CA39071F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhEYRI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhEYRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:08:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18EAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:07:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k14so45040331eji.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shX5o7fX3QC1vBrjY1MAQkvRCh6xIuYlJU65dj3inTo=;
        b=EZx5bOBS1D3lFTJnRSsg224irnopnZIFuU9EIi23AcWgi3puLB8NM/RhYBvXIcyv3T
         5w+Z/FOTRJX1ibduGD4k2I0l0xDoYtM2NgWwpFwBo2XMsIQeBrS3NDlzHgF0/aXSpXt8
         1cTPMTfNJc9SAr2oN/cE1Ndhc6EUrLQIVcVYoN4ofOU402PhFMQY1PHgnt6Cgp4gBdqM
         pZgLZbznGnOEYHvN1s21/soP/HcdRNp6jsOpP3AH9mDdJVjBOhz5k4e5zp8HtWYljhFK
         Ip3h4YvpqZfTh8HATErqgSa9gaabPyTeKjmZTBbU5D9JNQLHiPFGBJPZhu+orzVn8tjh
         dgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shX5o7fX3QC1vBrjY1MAQkvRCh6xIuYlJU65dj3inTo=;
        b=bcyqtFpXT/+a8bpoNEYqfs0kmJvSkg80QPu9nEeyh69vjV1AdsH8UnPL6Je88d/+qJ
         P5h+3JI00a6nocRTuLM1F13iUMfYZtfjMnByOCLUdQWVTeia/DzDUyW7SP+4AIAX8oSy
         HvQlj4RZr+j4U4MVjql8alYIvL1fEhMf7B5b/cro3+0mDUGU6D0bkIKBRkKYplrsaMIS
         mRGgTqPYD2ugRNfLjsGXlnryu3mWr5QX/4pJePRwaSsePRh6qoztGbnSyjAWcWGqhpWD
         z9R/oJTRkN+n9IiWff0yN7StW21nqaFGI3W0K/Vuak7Mhsr/EM0H/CQJfmrVa/FbDtr3
         8bxA==
X-Gm-Message-State: AOAM531rXffz72Nw23yyvkE3f8VwpA10ZLcSBZXV29rJ82QRstY0c691
        QHK30AeqPGBXU/w3qgLc/uHaZvyouA9oz9o/9G8=
X-Google-Smtp-Source: ABdhPJwf9CiiGaJWdMqwlVDs9Mk0UOGu6dNQmIVUXJqjoqUuy4s3sORqO7ENhE2AE8f8SG0F1GFLXf9GvPoXDEmUphM=
X-Received: by 2002:a17:906:1699:: with SMTP id s25mr29258812ejd.238.1621962437398;
 Tue, 25 May 2021 10:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210525162145.3510-1-shy828301@gmail.com> <YK0p4fSXk1vhsmKt@google.com>
In-Reply-To: <YK0p4fSXk1vhsmKt@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 25 May 2021 10:07:05 -0700
Message-ID: <CAHbLzkqLjB8V0s4S==qv-KFgXcBaCrLuSM4XAsKuj+95WDQhfw@mail.gmail.com>
Subject: Re: [v3 PATCH 1/2] mm: rmap: make try_to_unmap() void function
To:     Minchan Kim <minchan@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Wang Yugui <wangyugui@e16-tech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 9:46 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Tue, May 25, 2021 at 09:21:44AM -0700, Yang Shi wrote:
> > Currently try_to_unmap() return bool value by checking page_mapcount(),
> > however this may return false positive since page_mapcount() doesn't
> > check all subpages of compound page.  The total_mapcount() could be used
> > instead, but its cost is higher since it traverses all subpages.
> >
> > Actually the most callers of try_to_unmap() don't care about the
> > return value at all.  So just need check if page is still mapped by
> > page_mapped() when necessary.  And page_mapped() does bail out early
> > when it finds mapped subpage.
> >
> > Suggested-by: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/rmap.h |  2 +-
> >  mm/huge_memory.c     |  4 +---
> >  mm/memory-failure.c  | 13 ++++++-------
> >  mm/rmap.c            |  6 +-----
> >  mm/vmscan.c          |  3 ++-
> >  5 files changed, 11 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index def5c62c93b3..116cb193110a 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -194,7 +194,7 @@ static inline void page_dup_rmap(struct page *page, bool compound)
> >  int page_referenced(struct page *, int is_locked,
> >                       struct mem_cgroup *memcg, unsigned long *vm_flags);
> >
> > -bool try_to_unmap(struct page *, enum ttu_flags flags);
> > +void try_to_unmap(struct page *, enum ttu_flags flags);
> >
> >  /* Avoid racy checks */
> >  #define PVMW_SYNC            (1 << 0)
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 19195fca1aee..80fe642d742d 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2336,15 +2336,13 @@ static void unmap_page(struct page *page)
> >  {
> >       enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
> >               TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> > -     bool unmap_success;
> >
> >       VM_BUG_ON_PAGE(!PageHead(page), page);
> >
> >       if (PageAnon(page))
> >               ttu_flags |= TTU_SPLIT_FREEZE;
> >
> > -     unmap_success = try_to_unmap(page, ttu_flags);
> > -     VM_BUG_ON_PAGE(!unmap_success, page);
> > +     try_to_unmap(page, ttu_flags);
> >  }
> >
> >  static void remap_page(struct page *page, unsigned int nr)
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 9dcc9bcea731..6dd53ff34825 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1126,7 +1126,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
> >               collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
> >
> >       if (!PageHuge(hpage)) {
> > -             unmap_success = try_to_unmap(hpage, ttu);
> > +             try_to_unmap(hpage, ttu);
> >       } else {
> >               if (!PageAnon(hpage)) {
> >                       /*
> > @@ -1138,17 +1138,16 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
> >                        */
> >                       mapping = hugetlb_page_mapping_lock_write(hpage);
> >                       if (mapping) {
> > -                             unmap_success = try_to_unmap(hpage,
> > -                                                  ttu|TTU_RMAP_LOCKED);
> > +                             try_to_unmap(hpage, ttu|TTU_RMAP_LOCKED);
> >                               i_mmap_unlock_write(mapping);
> > -                     } else {
> > +                     } else
> >                               pr_info("Memory failure: %#lx: could not lock mapping for mapped huge page\n", pfn);
> > -                             unmap_success = false;
> > -                     }
> >               } else {
> > -                     unmap_success = try_to_unmap(hpage, ttu);
> > +                     try_to_unmap(hpage, ttu);
> >               }
> >       }
> > +
> > +     unmap_success = !page_mapped(hpage);
> >       if (!unmap_success)
> >               pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
> >                      pfn, page_mapcount(hpage));
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index a35cbbbded0d..728de421e43a 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1748,10 +1748,8 @@ static int page_not_mapped(struct page *page)
> >   *
> >   * Tries to remove all the page table entries which are mapping this
> >   * page, used in the pageout path.  Caller must hold the page lock.
> > - *
> > - * If unmap is successful, return true. Otherwise, false.
> >   */
> > -bool try_to_unmap(struct page *page, enum ttu_flags flags)
> > +void try_to_unmap(struct page *page, enum ttu_flags flags)
> >  {
> >       struct rmap_walk_control rwc = {
> >               .rmap_one = try_to_unmap_one,
> > @@ -1776,8 +1774,6 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
> >               rmap_walk_locked(page, &rwc);
> >       else
> >               rmap_walk(page, &rwc);
> > -
> > -     return !page_mapcount(page) ? true : false;
>
> Couldn't we use page_mapped instead of page_mapcount here?

Yes, of course. Actually this has been discussed in v2 review. Most
(or half) callers actually don't check the return value of
try_to_unmap() except hwpoison, vmscan and THP split. It sounds
suboptimal to have everyone pay the cost. So I thought Hugh's
suggestion made sense to me.

Quoted the discussion below:

> @@ -1777,7 +1779,7 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
>   else
>   rmap_walk(page, &rwc);
>
> - return !page_mapcount(page) ? true : false;
> + return !total_mapcount(page) ? true : false;

That always made me wince: "return !total_mapcount(page);" surely.

Or slightly better, "return !page_mapped(page);", since at least that
one breaks out as soon as it sees a mapcount.  Though I guess I'm
being silly there, since that case should never occur, so both
total_mapcount() and page_mapped() scan through all pages.

Or better, change try_to_unmap() to void: most callers ignore its
return value anyway, and make their own decisions; the remaining
few could be changed to do the same.  Though again, I may be
being silly, since the expensive THP case is not the common case.


> With boolean return of try sematic looks reasonable to me
> rather than void.
>
> >  }
> >
> >  /**
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index f96d62159720..fa5052ace415 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1499,7 +1499,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
> >                       if (unlikely(PageTransHuge(page)))
> >                               flags |= TTU_SPLIT_HUGE_PMD;
> >
> > -                     if (!try_to_unmap(page, flags)) {
> > +                     try_to_unmap(page, flags);
> > +                     if (page_mapped(page)) {
> >                               stat->nr_unmap_fail += nr_pages;
> >                               if (!was_swapbacked && PageSwapBacked(page))
> >                                       stat->nr_lazyfree_fail += nr_pages;
> > --
> > 2.26.2
> >
> >
