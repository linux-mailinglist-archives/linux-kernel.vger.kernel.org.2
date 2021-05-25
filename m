Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792B1390B00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 23:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhEYVGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 17:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhEYVGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 17:06:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A915AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 14:04:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a25so37897106edr.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 14:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i9kx39sVA8yVl5qA+W6bsFE5EnOKOdXnhFAEvPkP0eA=;
        b=Lr4oQetMkNUJiBSMYEFBoMiJG4F3K4XVC1yDcEDvt6usXP7iAZ59im37v7mU8G5KZp
         V91uexUQgZRRElEKsYy1UVMN50/ZseWTl+XxDCeii1vvk6JUBQv+x14xMzeKpluRt3SN
         uz/QTz0DGeCd5cVW5pUhd24tpAKDc2PrL9QZ9HnLTLgkv4XHavmBvl7fxKNvUqxkJ04T
         OXBw9Oea/Qbn0QRLdg/+E0pT28GgH+CQWyd/N2LfJwZKQEQqWlWmzjlLR13GTN1Fa11g
         cRKXMWqQWwhuBV8V/Bkr5PzxpEJcIChzYrA2eGEpwFFygISFvNzI/vF984Ct/8dmS9VW
         oSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9kx39sVA8yVl5qA+W6bsFE5EnOKOdXnhFAEvPkP0eA=;
        b=hNBwlCWW8bk+hHSe8q+qqT1hPnXjRBEJ+M/zODAINTXFSdD4PxyaJelqXW28dN8bLL
         RUksLp6YF307tg7s6g4Iduc4EXN/M1LilxCwNxxOpDqq/44KT5CutA/PT+MrBDx7U6r9
         aHkk5WRWqlBlf7zdg+axmLqctDpfKM8DpLqoI6c+7zEvy3kOIT71pu/RwvVdg+r1sys/
         W8EOrNe0HE5/XwI97EYHiixLGujMNse1FwxrHDJrPvyg70kblz8ITF+AZLu35zgIMiEo
         5LGB45O/muvYO0aOWpH8D+sG6+88r4eMvZT3Tp/AzsC+pS9v+RGhTaw+9mSlZUbMHPF7
         IV1Q==
X-Gm-Message-State: AOAM531b7tHUwvyR5YhHiQto3E6PWxICgQJJqi3KaqYSEg5zeHdY24me
        7eMJBO/8QewJQW4o21jznNC4rF68mw70ZOkkkFE=
X-Google-Smtp-Source: ABdhPJyd+yNMQrO9NmB/LNacKL2b71jamKDRDtQBCDFKqs8BhcYO2Xbli3ldFjiRToVw1eVTS3fernMjaJZDna32Vlk=
X-Received: by 2002:aa7:c0c4:: with SMTP id j4mr33544185edp.168.1621976670161;
 Tue, 25 May 2021 14:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210525162145.3510-1-shy828301@gmail.com> <YK0p4fSXk1vhsmKt@google.com>
 <CAHbLzkqLjB8V0s4S==qv-KFgXcBaCrLuSM4XAsKuj+95WDQhfw@mail.gmail.com> <YK01KGRtfgOuX7OS@google.com>
In-Reply-To: <YK01KGRtfgOuX7OS@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 25 May 2021 14:04:17 -0700
Message-ID: <CAHbLzkpk-hngWBfDO7cN4r581bzzDFMbL6aeXVi1K0H_zdFr2A@mail.gmail.com>
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

On Tue, May 25, 2021 at 10:34 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Tue, May 25, 2021 at 10:07:05AM -0700, Yang Shi wrote:
> > On Tue, May 25, 2021 at 9:46 AM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > On Tue, May 25, 2021 at 09:21:44AM -0700, Yang Shi wrote:
> > > > Currently try_to_unmap() return bool value by checking page_mapcount(),
> > > > however this may return false positive since page_mapcount() doesn't
> > > > check all subpages of compound page.  The total_mapcount() could be used
> > > > instead, but its cost is higher since it traverses all subpages.
> > > >
> > > > Actually the most callers of try_to_unmap() don't care about the
> > > > return value at all.  So just need check if page is still mapped by
> > > > page_mapped() when necessary.  And page_mapped() does bail out early
> > > > when it finds mapped subpage.
> > > >
> > > > Suggested-by: Hugh Dickins <hughd@google.com>
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > >  include/linux/rmap.h |  2 +-
> > > >  mm/huge_memory.c     |  4 +---
> > > >  mm/memory-failure.c  | 13 ++++++-------
> > > >  mm/rmap.c            |  6 +-----
> > > >  mm/vmscan.c          |  3 ++-
> > > >  5 files changed, 11 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > > > index def5c62c93b3..116cb193110a 100644
> > > > --- a/include/linux/rmap.h
> > > > +++ b/include/linux/rmap.h
> > > > @@ -194,7 +194,7 @@ static inline void page_dup_rmap(struct page *page, bool compound)
> > > >  int page_referenced(struct page *, int is_locked,
> > > >                       struct mem_cgroup *memcg, unsigned long *vm_flags);
> > > >
> > > > -bool try_to_unmap(struct page *, enum ttu_flags flags);
> > > > +void try_to_unmap(struct page *, enum ttu_flags flags);
> > > >
> > > >  /* Avoid racy checks */
> > > >  #define PVMW_SYNC            (1 << 0)
> > > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > > index 19195fca1aee..80fe642d742d 100644
> > > > --- a/mm/huge_memory.c
> > > > +++ b/mm/huge_memory.c
> > > > @@ -2336,15 +2336,13 @@ static void unmap_page(struct page *page)
> > > >  {
> > > >       enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
> > > >               TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> > > > -     bool unmap_success;
> > > >
> > > >       VM_BUG_ON_PAGE(!PageHead(page), page);
> > > >
> > > >       if (PageAnon(page))
> > > >               ttu_flags |= TTU_SPLIT_FREEZE;
> > > >
> > > > -     unmap_success = try_to_unmap(page, ttu_flags);
> > > > -     VM_BUG_ON_PAGE(!unmap_success, page);
> > > > +     try_to_unmap(page, ttu_flags);
> > > >  }
> > > >
> > > >  static void remap_page(struct page *page, unsigned int nr)
> > > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > > index 9dcc9bcea731..6dd53ff34825 100644
> > > > --- a/mm/memory-failure.c
> > > > +++ b/mm/memory-failure.c
> > > > @@ -1126,7 +1126,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
> > > >               collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
> > > >
> > > >       if (!PageHuge(hpage)) {
> > > > -             unmap_success = try_to_unmap(hpage, ttu);
> > > > +             try_to_unmap(hpage, ttu);
> > > >       } else {
> > > >               if (!PageAnon(hpage)) {
> > > >                       /*
> > > > @@ -1138,17 +1138,16 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
> > > >                        */
> > > >                       mapping = hugetlb_page_mapping_lock_write(hpage);
> > > >                       if (mapping) {
> > > > -                             unmap_success = try_to_unmap(hpage,
> > > > -                                                  ttu|TTU_RMAP_LOCKED);
> > > > +                             try_to_unmap(hpage, ttu|TTU_RMAP_LOCKED);
> > > >                               i_mmap_unlock_write(mapping);
> > > > -                     } else {
> > > > +                     } else
> > > >                               pr_info("Memory failure: %#lx: could not lock mapping for mapped huge page\n", pfn);
> > > > -                             unmap_success = false;
> > > > -                     }
> > > >               } else {
> > > > -                     unmap_success = try_to_unmap(hpage, ttu);
> > > > +                     try_to_unmap(hpage, ttu);
> > > >               }
> > > >       }
> > > > +
> > > > +     unmap_success = !page_mapped(hpage);
> > > >       if (!unmap_success)
> > > >               pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
> > > >                      pfn, page_mapcount(hpage));
> > > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > > index a35cbbbded0d..728de421e43a 100644
> > > > --- a/mm/rmap.c
> > > > +++ b/mm/rmap.c
> > > > @@ -1748,10 +1748,8 @@ static int page_not_mapped(struct page *page)
> > > >   *
> > > >   * Tries to remove all the page table entries which are mapping this
> > > >   * page, used in the pageout path.  Caller must hold the page lock.
> > > > - *
> > > > - * If unmap is successful, return true. Otherwise, false.
> > > >   */
> > > > -bool try_to_unmap(struct page *page, enum ttu_flags flags)
> > > > +void try_to_unmap(struct page *page, enum ttu_flags flags)
> > > >  {
> > > >       struct rmap_walk_control rwc = {
> > > >               .rmap_one = try_to_unmap_one,
> > > > @@ -1776,8 +1774,6 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
> > > >               rmap_walk_locked(page, &rwc);
> > > >       else
> > > >               rmap_walk(page, &rwc);
> > > > -
> > > > -     return !page_mapcount(page) ? true : false;
> > >
> > > Couldn't we use page_mapped instead of page_mapcount here?
> >
> > Yes, of course. Actually this has been discussed in v2 review. Most
> > (or half) callers actually don't check the return value of
> > try_to_unmap() except hwpoison, vmscan and THP split. It sounds
> > suboptimal to have everyone pay the cost. So I thought Hugh's
> > suggestion made sense to me.
>
> Not sure most callers ignore the ret. I am seeing only do_migrate_range
> ignores it. Other than that, they checked the success with page_mapped
> in the end.

I'd think this falls into the "ignore" category as well since the code
doesn't check the return value of try_to_unmap() :-). The patch does
convert the return value check to page_mapped() check right after
try_to_unmap().

>
> With returning void, I feel like it's not try sematic function
> any longer. If you still want to go with it, I suggest adding
> some comment how to check the function's successness in the
> comment place you removed above.

Thanks for the suggestion. Will add some notes about how to do the check.

>
> >
> > Quoted the discussion below:
> >
> > > @@ -1777,7 +1779,7 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
> > >   else
> > >   rmap_walk(page, &rwc);
> > >
> > > - return !page_mapcount(page) ? true : false;
> > > + return !total_mapcount(page) ? true : false;
> >
> > That always made me wince: "return !total_mapcount(page);" surely.
> >
> > Or slightly better, "return !page_mapped(page);", since at least that
> > one breaks out as soon as it sees a mapcount.  Though I guess I'm
> > being silly there, since that case should never occur, so both
> > total_mapcount() and page_mapped() scan through all pages.
> >
> > Or better, change try_to_unmap() to void: most callers ignore its
> > return value anyway, and make their own decisions; the remaining
> > few could be changed to do the same.  Though again, I may be
> > being silly, since the expensive THP case is not the common case.
> >
> >
> > > With boolean return of try sematic looks reasonable to me
> > > rather than void.
> > >
> > > >  }
> > > >
> > > >  /**
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index f96d62159720..fa5052ace415 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -1499,7 +1499,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
> > > >                       if (unlikely(PageTransHuge(page)))
> > > >                               flags |= TTU_SPLIT_HUGE_PMD;
> > > >
> > > > -                     if (!try_to_unmap(page, flags)) {
> > > > +                     try_to_unmap(page, flags);
> > > > +                     if (page_mapped(page)) {
> > > >                               stat->nr_unmap_fail += nr_pages;
> > > >                               if (!was_swapbacked && PageSwapBacked(page))
> > > >                                       stat->nr_lazyfree_fail += nr_pages;
> > > > --
> > > > 2.26.2
> > > >
> > > >
