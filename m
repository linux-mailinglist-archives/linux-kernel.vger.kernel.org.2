Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A373907D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhEYRg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbhEYRgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:36:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D37C06138C
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:34:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e15so10097327plh.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gCqc7YMazcCz158C6V/S5fH3hyG5HHvNm1QpwNxvdxE=;
        b=YxdyPz99w7/Esg1lysN56IfxcB3h5pM/IaxDv0oMQ+08aYRBOQarMt9LjkwHzoUg5D
         UUQgKvq09axzkMhoMWdnQQjwNCB9lXGnkPTBVnQQIOUcDrsKNu9RxkG068KKtaleTF7c
         0vpTeLqiScac4bbE649GA+BNp8KCn5yZHz/SMizJuIBgMHaV7X8VFyR2m2BhhcI/3jz4
         oT1x9BD5Fd3CBrBlKPeArX0Wwe2ls72Uy+dx3Zh4jwGIRmUd16JY2V4v2LN1sa30N2YQ
         934drS1n4ScIhKWCs73+MBfEo7HfPMK5L582hndb33slp877CIinfQALH6WI2oLeTqOJ
         0SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gCqc7YMazcCz158C6V/S5fH3hyG5HHvNm1QpwNxvdxE=;
        b=prpYePiRyppZU5b2mS5yZu4Id7hjuOJpoVWGpyhvti0MfrMS/wSstNLey8IvSpi+/v
         CxCCoq4hyqRZ/Tu7wtHuG7PMhKw4QH/+0K+WpIzMEwMEfzxOpzvdQkHOOgqfcTboKJdt
         GhuBJcQPjHoKo9SbJ24YSTwyJo20AcbfZkFSiGD819IahLcR4XuOb1NRHsWp5DYBAJB5
         X69z0mjMF+oNJGGWMbnEZldtMat41NowFl6WcH/fP6FjfKwvI8s2iaNegGFv6CL7zoi3
         DfeeHV2y6pOVtAcHtPhfuTY6y6rqA4VNBS71MUXpivo5o/ksUMCMvSFOwe4eoWigimEP
         ZPwA==
X-Gm-Message-State: AOAM532i/QtS5LTJoxz3IkQmmJ6fxSdfNi+LnCQaogwWrW5Ss4WcyZjs
        QpsVShFhaAMMl1jKXJGowRs=
X-Google-Smtp-Source: ABdhPJy0XDu9Bo7IRqG97W6GrH5BGjEdcAA84Nyngt/3RV7kqpfv2Cd1UAdYwsI9XXvtjGytuRWEYw==
X-Received: by 2002:a17:902:6b4a:b029:fb:7b8e:56f8 with SMTP id g10-20020a1709026b4ab02900fb7b8e56f8mr6850122plt.46.1621964075113;
        Tue, 25 May 2021 10:34:35 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:37cd:d6b4:7992:c290])
        by smtp.gmail.com with ESMTPSA id h18sm14015980pfr.49.2021.05.25.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 10:34:34 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 25 May 2021 10:34:32 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Wang Yugui <wangyugui@e16-tech.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 1/2] mm: rmap: make try_to_unmap() void function
Message-ID: <YK01KGRtfgOuX7OS@google.com>
References: <20210525162145.3510-1-shy828301@gmail.com>
 <YK0p4fSXk1vhsmKt@google.com>
 <CAHbLzkqLjB8V0s4S==qv-KFgXcBaCrLuSM4XAsKuj+95WDQhfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkqLjB8V0s4S==qv-KFgXcBaCrLuSM4XAsKuj+95WDQhfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 10:07:05AM -0700, Yang Shi wrote:
> On Tue, May 25, 2021 at 9:46 AM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Tue, May 25, 2021 at 09:21:44AM -0700, Yang Shi wrote:
> > > Currently try_to_unmap() return bool value by checking page_mapcount(),
> > > however this may return false positive since page_mapcount() doesn't
> > > check all subpages of compound page.  The total_mapcount() could be used
> > > instead, but its cost is higher since it traverses all subpages.
> > >
> > > Actually the most callers of try_to_unmap() don't care about the
> > > return value at all.  So just need check if page is still mapped by
> > > page_mapped() when necessary.  And page_mapped() does bail out early
> > > when it finds mapped subpage.
> > >
> > > Suggested-by: Hugh Dickins <hughd@google.com>
> > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > ---
> > >  include/linux/rmap.h |  2 +-
> > >  mm/huge_memory.c     |  4 +---
> > >  mm/memory-failure.c  | 13 ++++++-------
> > >  mm/rmap.c            |  6 +-----
> > >  mm/vmscan.c          |  3 ++-
> > >  5 files changed, 11 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > > index def5c62c93b3..116cb193110a 100644
> > > --- a/include/linux/rmap.h
> > > +++ b/include/linux/rmap.h
> > > @@ -194,7 +194,7 @@ static inline void page_dup_rmap(struct page *page, bool compound)
> > >  int page_referenced(struct page *, int is_locked,
> > >                       struct mem_cgroup *memcg, unsigned long *vm_flags);
> > >
> > > -bool try_to_unmap(struct page *, enum ttu_flags flags);
> > > +void try_to_unmap(struct page *, enum ttu_flags flags);
> > >
> > >  /* Avoid racy checks */
> > >  #define PVMW_SYNC            (1 << 0)
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 19195fca1aee..80fe642d742d 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -2336,15 +2336,13 @@ static void unmap_page(struct page *page)
> > >  {
> > >       enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
> > >               TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> > > -     bool unmap_success;
> > >
> > >       VM_BUG_ON_PAGE(!PageHead(page), page);
> > >
> > >       if (PageAnon(page))
> > >               ttu_flags |= TTU_SPLIT_FREEZE;
> > >
> > > -     unmap_success = try_to_unmap(page, ttu_flags);
> > > -     VM_BUG_ON_PAGE(!unmap_success, page);
> > > +     try_to_unmap(page, ttu_flags);
> > >  }
> > >
> > >  static void remap_page(struct page *page, unsigned int nr)
> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index 9dcc9bcea731..6dd53ff34825 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -1126,7 +1126,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
> > >               collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
> > >
> > >       if (!PageHuge(hpage)) {
> > > -             unmap_success = try_to_unmap(hpage, ttu);
> > > +             try_to_unmap(hpage, ttu);
> > >       } else {
> > >               if (!PageAnon(hpage)) {
> > >                       /*
> > > @@ -1138,17 +1138,16 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
> > >                        */
> > >                       mapping = hugetlb_page_mapping_lock_write(hpage);
> > >                       if (mapping) {
> > > -                             unmap_success = try_to_unmap(hpage,
> > > -                                                  ttu|TTU_RMAP_LOCKED);
> > > +                             try_to_unmap(hpage, ttu|TTU_RMAP_LOCKED);
> > >                               i_mmap_unlock_write(mapping);
> > > -                     } else {
> > > +                     } else
> > >                               pr_info("Memory failure: %#lx: could not lock mapping for mapped huge page\n", pfn);
> > > -                             unmap_success = false;
> > > -                     }
> > >               } else {
> > > -                     unmap_success = try_to_unmap(hpage, ttu);
> > > +                     try_to_unmap(hpage, ttu);
> > >               }
> > >       }
> > > +
> > > +     unmap_success = !page_mapped(hpage);
> > >       if (!unmap_success)
> > >               pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
> > >                      pfn, page_mapcount(hpage));
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index a35cbbbded0d..728de421e43a 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -1748,10 +1748,8 @@ static int page_not_mapped(struct page *page)
> > >   *
> > >   * Tries to remove all the page table entries which are mapping this
> > >   * page, used in the pageout path.  Caller must hold the page lock.
> > > - *
> > > - * If unmap is successful, return true. Otherwise, false.
> > >   */
> > > -bool try_to_unmap(struct page *page, enum ttu_flags flags)
> > > +void try_to_unmap(struct page *page, enum ttu_flags flags)
> > >  {
> > >       struct rmap_walk_control rwc = {
> > >               .rmap_one = try_to_unmap_one,
> > > @@ -1776,8 +1774,6 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
> > >               rmap_walk_locked(page, &rwc);
> > >       else
> > >               rmap_walk(page, &rwc);
> > > -
> > > -     return !page_mapcount(page) ? true : false;
> >
> > Couldn't we use page_mapped instead of page_mapcount here?
> 
> Yes, of course. Actually this has been discussed in v2 review. Most
> (or half) callers actually don't check the return value of
> try_to_unmap() except hwpoison, vmscan and THP split. It sounds
> suboptimal to have everyone pay the cost. So I thought Hugh's
> suggestion made sense to me.

Not sure most callers ignore the ret. I am seeing only do_migrate_range
ignores it. Other than that, they checked the success with page_mapped
in the end. 

With returning void, I feel like it's not try sematic function
any longer. If you still want to go with it, I suggest adding
some comment how to check the function's successness in the
comment place you removed above.

> 
> Quoted the discussion below:
> 
> > @@ -1777,7 +1779,7 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
> >   else
> >   rmap_walk(page, &rwc);
> >
> > - return !page_mapcount(page) ? true : false;
> > + return !total_mapcount(page) ? true : false;
> 
> That always made me wince: "return !total_mapcount(page);" surely.
> 
> Or slightly better, "return !page_mapped(page);", since at least that
> one breaks out as soon as it sees a mapcount.  Though I guess I'm
> being silly there, since that case should never occur, so both
> total_mapcount() and page_mapped() scan through all pages.
> 
> Or better, change try_to_unmap() to void: most callers ignore its
> return value anyway, and make their own decisions; the remaining
> few could be changed to do the same.  Though again, I may be
> being silly, since the expensive THP case is not the common case.
> 
> 
> > With boolean return of try sematic looks reasonable to me
> > rather than void.
> >
> > >  }
> > >
> > >  /**
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index f96d62159720..fa5052ace415 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -1499,7 +1499,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
> > >                       if (unlikely(PageTransHuge(page)))
> > >                               flags |= TTU_SPLIT_HUGE_PMD;
> > >
> > > -                     if (!try_to_unmap(page, flags)) {
> > > +                     try_to_unmap(page, flags);
> > > +                     if (page_mapped(page)) {
> > >                               stat->nr_unmap_fail += nr_pages;
> > >                               if (!was_swapbacked && PageSwapBacked(page))
> > >                                       stat->nr_lazyfree_fail += nr_pages;
> > > --
> > > 2.26.2
> > >
> > >
