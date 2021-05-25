Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E87A390C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 00:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhEYWfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 18:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhEYWe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 18:34:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36D4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:33:28 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w12so30362852edx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YUMO4ev2fi5whCBLny3igBaOoEj6ePRUeQXInqjVyNM=;
        b=bMJQAdgEryq0sPrbnNCe5x4cW0/jeT0J+TPAw+SA1Q5+6Ip4Sa5uFnkjbLgvhCKv12
         Qyi58CtPHjUo2xpfMWhudlnhGllCbulR19B2WMyD51nx9Q2v3/YdjGLVp3E2sTj2H/P3
         awqap4IPUFcusb6NaWIkagP62xFuXWZkYF7uYe3yGlFdMVHjXCR8hyEVbANPZgtMjUuY
         vmmSH5gQ8C7jL0doqSCz0gBnNysDbevvH+MncG8wGQkzPdcgEBhjOzA3Udn+1dZvjoXT
         NIPL1WSERKHaklDXlWC5x+k4bkR2zQF0sWZvsxiPElNx8X2oDyNQmcMZ8zYxn4HsyNpM
         X2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YUMO4ev2fi5whCBLny3igBaOoEj6ePRUeQXInqjVyNM=;
        b=QMmpE6zxvJzW0J3LGe9pyK8qo0WLak2be2zcpTd7GFQCMgrHgExpHRNKlJ4tJu7SFI
         1B02c/nY4YE2O5EHOYtaFOYeVP0J33ng8K9Y6+Wy0ySrhm1vb2omXKNLhZ8MfrOb5dSV
         1FtrbxxmpvmxqE/d8F/vnRS2SbKYvK2S7aOBH9figH5/YbUSDqBsnyDjwW5e+25Ko6sR
         ujIgp56c/Gk85YvCjJI+W+jGObSkSR6KPTlYDj/zKdCnWQWMdpmEq4HHJBwZ7Had7Bck
         EdeaAyBjfpQk0C71xA/cIM6JKbqLNjQHMEPZ5h9+iqHre9AsohnQtExSf4ULAi5ig5ma
         1BSQ==
X-Gm-Message-State: AOAM531xKVaUy4T08OE9P6rPlnP66LjDiw8tZ2vLgG4t3G+fPIV8N8g7
        nIT+ZOi0xjy0cX+XLO8d7ht994JmE/J7vsL8riA=
X-Google-Smtp-Source: ABdhPJyQoa9JICY+XRJRIYukmQB8d441BozFXAbEKiu5+PHyTIFgN1TXmc2XlOMyDEurOdMnyYqW4O29uqc1CY6CZqw=
X-Received: by 2002:a05:6402:1052:: with SMTP id e18mr35201690edu.366.1621982007211;
 Tue, 25 May 2021 15:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210525162145.3510-1-shy828301@gmail.com> <alpine.LSU.2.11.2105251317520.2003@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2105251317520.2003@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 25 May 2021 15:33:15 -0700
Message-ID: <CAHbLzkqq26tqeeP6AOTPe0MEFnyuiZnLHYvTUH0YN_d3JqKKyw@mail.gmail.com>
Subject: Re: [v3 PATCH 1/2] mm: rmap: make try_to_unmap() void function
To:     Hugh Dickins <hughd@google.com>
Cc:     Zi Yan <ziy@nvidia.com>,
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

On Tue, May 25, 2021 at 2:12 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Tue, 25 May 2021, Yang Shi wrote:
>
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
>
> Thanks for doing this, I like it, you can add
> Acked-by: Hugh Dickins <hughd@google.com>

Thank you.

>
> Let's all ignore checkpatch's complaint on "struct page *":
> that try_to_unmap() prototype is consistent with others in rmap.h,
> and changing them to "struct page *page" adds no information at all.
>
> But a nit in mm/memory-failure.c: unmap_success no longer needs
> to be initialized to true on entry to hwpoison_user_mappings().

Will fix it.

>
> More seriously, I question the ordering of the two patches:
> I think this 1/2 should be 2/2, and the other be 1/2.  The other is
> the one which replaces a BUG by a WARN, which will be wanted Cc stable;
> whereas this one is really just a cleanup - I don't think there's a
> serious consequence from the faint possibility of wrong unmap_success
> on THP, in either memory-failure.c or vmscan.c - wrong message, wrong
> stats, but more than that? And memory-failure.c on THP somewhat a
> work in progress IIUC.
>
> Unfortunately, they can't just be swapped but need rediffing.
> Or do you disagree that's a better ordering?

No, I don't. Will reorder them in the next version, anyway I need to
fix something.

>
> As it stands, I imagine my series of THP unmap fixes (most needing Cc
> stable) coming on top of your "mm: thp: check page_mapped instead of
> page_mapcount for split" (umm, that's a bad title), but before this
> cleanup.
>
> Though I'm responding before I've looked through the stable trees:
> it's not of overriding importance, but I'll want to try to minimize
> the number of patches that need redoing for older stables, which might
> affect the ordering.  (And it might end up easiest if I bring your two
> patches into my series, then ask Andrew to replace.)
>
> Further complicated by Andrew having brought in the nouveau reorg of
> mm/rmap.c (oh, and that touches mm/huge_memory.c unmap_page() too).
> I expect I'll have to send Andrew a series to go before all that,
> together with fixups to that to sit on top of it.  Sigh.  Well,
> we can only blame me for not getting those THP fixes in sooner.
>
> Hugh
>
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
