Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214E93B1544
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFWID0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFWIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:03:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAE8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 01:01:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bb20so1043309pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMsYuaM3nH7e159sVsjJbL/e/CSfhEAN2lUWZWgqe74=;
        b=SJAc4RGs1UFAbrnSwYLiAjpnKJrkOkNCFAc5YUvXHGnzqnlMyfZaAlrnv9WKe4OkfN
         4iXNTEFXsH8xSceVNKHYk7cN5UhoJx6SYtQCyrhrglr+0FKEJD3BSWCXcOXR7dy3whQH
         HYG884V4magHiayZXZjJNMvr5hqTl7i8PoU56fXq5LyLOBSzpm5D46oTwQ4DEFs7rJe1
         n5x5NJvyZOwuk/Qk+6ZQ2EsxTUM/ZGmp8jH0hfTEDuo8tgGBsDg9OtfusH4YmQkH7pNG
         1Ry99uwPf5KKZgVuAnSMj7t4j4E09E6Zv9QavTZRyxgjdk4dXo2RUxDUOR5uFY6O/PaR
         WaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMsYuaM3nH7e159sVsjJbL/e/CSfhEAN2lUWZWgqe74=;
        b=GN84pkyPMEnzntaX+R+3/+cjo5dtVkqWuHEWcwsG6H8vtVQnoQoHwXRqQWkJ5unP1o
         ZC03rSW0Bfy88aCE6mcKJHFLmWe2ieMIjAAIZGBo9wvUo+WKadyiLpkYFbOjLz1mcy8C
         QXvvFZwCdFrWgfaMHbuSrxh7lD/u+rnXCQXQJXnfvj0SGGqSdZZjwsvbGvvJh3tiadtq
         wcHlIHLTVzaAQYa3H6e137V4ZpYvVWI9gymdhp0GG7N3Cc+smpSkjT+KJpaNCNWf8fmO
         YWYb967rDnEkiatG7pzhb1yggPCdn0Iv8fuTNV1WAqgBeJ8bV9Y3/mlIbBdN5oPNF0uQ
         N0hA==
X-Gm-Message-State: AOAM530XBf2t3kyIYJH7Lk8s3LXBXd6zXryT/laprGrJjClPU79QhXOQ
        Vl+ahzlFcrDkx3KYz41UflxvQEsydh2hhr1YOGXd4Q==
X-Google-Smtp-Source: ABdhPJzTVT7dLW8nuMboAALbaCRBpy7oQDgnQWhpnE/E38Ju3Bx2j6dALDy7T+dQIWDcGjidvL2rM/4j5y33eB/E5+o=
X-Received: by 2002:a17:90a:10c8:: with SMTP id b8mr8374161pje.147.1624435267162;
 Wed, 23 Jun 2021 01:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210622021423.154662-1-mike.kravetz@oracle.com> <20210622021423.154662-3-mike.kravetz@oracle.com>
In-Reply-To: <20210622021423.154662-3-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 23 Jun 2021 16:00:28 +0800
Message-ID: <CAMZfGtVMn3daKrJwZMaVOGOaJU+B4dS--x_oPmGQMD=c=QNGEg@mail.gmail.com>
Subject: Re: [External] [PATCH 2/2] hugetlb: address ref count racing in prep_compound_gigantic_page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:15 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> In [1], Jann Horn points out a possible race between
> prep_compound_gigantic_page and __page_cache_add_speculative.  The
> root cause of the possible race is prep_compound_gigantic_page
> uncondittionally setting the ref count of pages to zero.  It does this
> because prep_compound_gigantic_page is handed a 'group' of pages from an
> allocator and needs to convert that group of pages to a compound page.
> The ref count of each page in this 'group' is one as set by the
> allocator.  However, the ref count of compound page tail pages must be
> zero.
>
> The potential race comes about when ref counted pages are returned from
> the allocator.  When this happens, other mm code could also take a
> reference on the page.  __page_cache_add_speculative is one such
> example.  Therefore, prep_compound_gigantic_page can not just set the
> ref count of pages to zero as it does today.  Doing so would lose the
> reference taken by any other code.  This would lead to BUGs in code
> checking ref counts and could possibly even lead to memory corruption.

Hi Mike,

Well. It takes me some time to get the race. It also makes me think more
about this. See the below code snippet in gather_surplus_pages().

        zeroed = put_page_testzero(page);
       VM_BUG_ON_PAGE(!zeroed, page);
        enqueue_huge_page(h, page);

The VM_BUG_ON_PAGE() can be triggered because of the similar
race, right? IIUC, we also should fix this.

Thanks.

>
> There are two possible ways to address this issue.
> 1) Make all allocators of gigantic groups of pages be able to return a
>    properly constructed compound page.
> 2) Make prep_compound_gigantic_page be more careful when constructing a
>    compound page.
> This patch takes approach 2.
>
> In prep_compound_gigantic_page, use cmpxchg to only set ref count to
> zero if it is one.  If the cmpxchg fails, call synchronize_rcu() in the
> hope that the extra ref count will be driopped during a rcu grace
> period.  This is not a performance critical code path and the wait
> should be accceptable.  If the ref count is still inflated after the
> grace period, then undo any modifications made and return an error.
>
> Currently prep_compound_gigantic_page is type void and does not return
> errors.  Modify the two callers to check for and handle error returns.
> On error, the caller must free the 'group' of pages as they can not be
> used to form a gigantic page.  After freeing pages, the runtime caller
> (alloc_fresh_huge_page) will retry the allocation once.  Boot time
> allocations can not be retried.
>
> The routine prep_compound_page also unconditionally sets the ref count
> of compound page tail pages to zero.  However, in this case the buddy
> allocator is constructing a compound page from freshly allocated pages.
> The ref count on those freshly allocated pages is already zero, so the
> set_page_count(p, 0) is unnecessary and could lead to confusion.
> Just remove it.
>
> [1] https://lore.kernel.org/linux-mm/CAG48ez23q0Jy9cuVnwAe7t_fdhMk2S7N5Hdi-GLcCeq5bsfLxw@mail.gmail.com/
> Fixes: 58a84aa92723 ("thp: set compound tail page _count to zero")
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c    | 72 +++++++++++++++++++++++++++++++++++++++++++------
>  mm/page_alloc.c |  1 -
>  2 files changed, 64 insertions(+), 9 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 50596b7d6da9..924553aa8f78 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1623,9 +1623,9 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>         spin_unlock_irq(&hugetlb_lock);
>  }
>
> -static void prep_compound_gigantic_page(struct page *page, unsigned int order)
> +static bool prep_compound_gigantic_page(struct page *page, unsigned int order)
>  {
> -       int i;
> +       int i, j;
>         int nr_pages = 1 << order;
>         struct page *p = page + 1;
>
> @@ -1647,11 +1647,48 @@ static void prep_compound_gigantic_page(struct page *page, unsigned int order)
>                  * after get_user_pages().
>                  */
>                 __ClearPageReserved(p);
> +               /*
> +                * Subtle and very unlikely
> +                *
> +                * Gigantic 'page allocators' such as memblock or cma will
> +                * return a set of pages with each page ref counted.  We need
> +                * to turn this set of pages into a compound page with tail
> +                * page ref counts set to zero.  Code such as speculative page
> +                * cache adding could take a ref on a 'to be' tail page.
> +                * We need to respect any increased ref count, and only set
> +                * the ref count to zero if count is currently 1.  If count
> +                * is not 1, we call synchronize_rcu in the hope that a rcu
> +                * grace period will cause ref count to drop and then retry.
> +                * If count is still inflated on retry we return an error and
> +                * must discard the pages.
> +                */
> +               if (!page_ref_freeze(p, 1)) {
> +                       pr_info("HugeTLB unexpected inflated ref count on freshly allocated page\n");
> +                       synchronize_rcu();
> +                       if (!page_ref_freeze(p, 1))
> +                               goto out_error;
> +               }
>                 set_page_count(p, 0);
>                 set_compound_head(p, page);
>         }
>         atomic_set(compound_mapcount_ptr(page), -1);
>         atomic_set(compound_pincount_ptr(page), 0);
> +       return true;
> +
> +out_error:
> +       /* undo tail page modifications made above */
> +       p = page + 1;
> +       for (j = 1; j < i; j++, p = mem_map_next(p, page, j)) {
> +               clear_compound_head(p);
> +               set_page_refcounted(p);
> +       }
> +       /* need to clear PG_reserved on remaining tail pages  */
> +       for (; j < nr_pages; j++, p = mem_map_next(p, page, j))
> +               __ClearPageReserved(p);
> +       set_compound_order(page, 0);
> +       page[1].compound_nr = 0;
> +       __ClearPageHead(page);
> +       return false;
>  }
>
>  /*
> @@ -1771,7 +1808,9 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
>                 nodemask_t *node_alloc_noretry)
>  {
>         struct page *page;
> +       bool retry = false;
>
> +retry:
>         if (hstate_is_gigantic(h))
>                 page = alloc_gigantic_page(h, gfp_mask, nid, nmask);
>         else
> @@ -1780,8 +1819,21 @@ static struct page *alloc_fresh_huge_page(struct hstate *h,
>         if (!page)
>                 return NULL;
>
> -       if (hstate_is_gigantic(h))
> -               prep_compound_gigantic_page(page, huge_page_order(h));
> +       if (hstate_is_gigantic(h)) {
> +               if (!prep_compound_gigantic_page(page, huge_page_order(h))) {
> +                       /*
> +                        * Rare failure to convert pages to compound page.
> +                        * Free pages and try again - ONCE!
> +                        */
> +                       free_gigantic_page(page, huge_page_order(h));
> +                       if (!retry) {
> +                               retry = true;
> +                               goto retry;
> +                       }
> +                       pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
> +                       return NULL;
> +               }
> +       }
>         prep_new_huge_page(h, page, page_to_nid(page));
>
>         return page;
> @@ -2771,10 +2823,14 @@ static void __init gather_bootmem_prealloc(void)
>
>                 VM_BUG_ON(!hstate_is_gigantic(h));
>                 WARN_ON(page_count(page) != 1);
> -               prep_compound_gigantic_page(page, huge_page_order(h));
> -               WARN_ON(PageReserved(page));
> -               prep_new_huge_page(h, page, page_to_nid(page));
> -               put_page(page); /* free it into the hugepage allocator */
> +               if (prep_compound_gigantic_page(page, huge_page_order(h))) {
> +                       WARN_ON(PageReserved(page));
> +                       prep_new_huge_page(h, page, page_to_nid(page));
> +                       put_page(page); /* add to the hugepage allocator */
> +               } else {
> +                       free_gigantic_page(page, huge_page_order(h));
> +                       pr_warn("HugeTLB page can not be used due to unexpected inflated ref count\n");
> +               }
>
>                 /*
>                  * We need to restore the 'stolen' pages to totalram_pages
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8836e54721ae..a672d9c85118 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -749,7 +749,6 @@ void prep_compound_page(struct page *page, unsigned int order)
>         __SetPageHead(page);
>         for (i = 1; i < nr_pages; i++) {
>                 struct page *p = page + i;
> -               set_page_count(p, 0);
>                 p->mapping = TAIL_MAPPING;
>                 set_compound_head(p, page);
>         }
> --
> 2.31.1
>
