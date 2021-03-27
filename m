Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9962834B4A6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 07:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhC0Ghg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 02:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhC0GhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 02:37:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC8C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 23:37:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c17so6334130pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwQqp/hFmpQ8FvYYk0Qausemeu6GykiOlynYCYbnNjM=;
        b=tZD+Yn6Pt45RtuplRxEeh2IxAQBJ0FW7mqnkuv7uYhIqHcL+eEVWJJxU6YEiOVV55I
         nbL2JQrxNZyEfuNgDVOJ/Wu0Jx/k9qwHln5GHLzRHJ63KDAvQkfFqRTijjTDj4p1k99r
         dEru9CJABtWsxMvbsxs6M53Bm3SOIFtBB57B6bmnHj00OqznTj01DRE6/WlWJLMwv3XX
         sLB+HLRZyReBdQ9Z9oVKHtG3EUWKbXy0Bdu6+LLDRmDiN9umQmUO1Xcj5PRV5VlTe4hY
         FP+nawVnSX5bcYgjTKn/S8KzBGShx6QDh1SmeDEgns2CnBNTiaijwYaAtQ+GXo4hAque
         /kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwQqp/hFmpQ8FvYYk0Qausemeu6GykiOlynYCYbnNjM=;
        b=PbN7k4Vb5mC/bkvA9RMPCYVBHrSqo7uBb9XRUSkgGhUKvUw7UI1uLe42AhslixHG18
         ZnbKJPKr+m/i05KG3QPxwnpL7AXcwgGNHPosb6croWzosO9iYyXRS326xl6wGbswTfcR
         eJW938W60q6xpFQnJwwRmTPw4Q/Eof92xp1Md4J1GVohgZgsSLv5ekpWiTucCnhe3teO
         6a48D9nU+o65xfgcHa8Qsg5wlUfpbfOmufTUPWUIxep0hCtzYvAB7J/r4x/x9hDFbrTZ
         37MjXeRaiQVAhiJsuVl/o5RmvgUlJu5ZXRJeXpmu0hPzxgqPfimR2oo9m/J/iwOSBwV/
         6Xeg==
X-Gm-Message-State: AOAM531cX3ObQpG5bJvZKbDGGJBD8BSNxdebFiYglckTX682U7904zTg
        uxKSvOyik0cGGOy8l63bhzF9yWnXHY21WVUge8hDDA==
X-Google-Smtp-Source: ABdhPJydbnzq8ohROlyDGf7Pn4/Y4kJFfypc+2bTmGovTec6aMM8XzNAg98d02wNGQbcQp0PrcgwDdR27N2oW5wn8z4=
X-Received: by 2002:a63:161c:: with SMTP id w28mr15618359pgl.341.1616827039107;
 Fri, 26 Mar 2021 23:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210325002835.216118-1-mike.kravetz@oracle.com> <20210325002835.216118-5-mike.kravetz@oracle.com>
In-Reply-To: <20210325002835.216118-5-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 27 Mar 2021 14:36:42 +0800
Message-ID: <CAMZfGtVP4OxHzOvDY+cm8_yH5LD8oggaVY1zU7nm0zY9n6pk7A@mail.gmail.com>
Subject: Re: [External] [PATCH 4/8] hugetlb: create remove_hugetlb_page() to
 separate functionality
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 8:29 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> The new remove_hugetlb_page() routine is designed to remove a hugetlb
> page from hugetlbfs processing.  It will remove the page from the active
> or free list, update global counters and set the compound page
> destructor to NULL so that PageHuge() will return false for the 'page'.
> After this call, the 'page' can be treated as a normal compound page or
> a collection of base size pages.
>
> remove_hugetlb_page is to be called with the hugetlb_lock held.
>
> Creating this routine and separating functionality is in preparation for
> restructuring code to reduce lock hold times.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks for your effort on this.

> ---
>  mm/hugetlb.c | 70 +++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 45 insertions(+), 25 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 404b0b1c5258..3938ec086b5c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1327,6 +1327,46 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>                                                 unsigned int order) { }
>  #endif
>
> +/*
> + * Remove hugetlb page from lists, and update dtor so that page appears
> + * as just a compound page.  A reference is held on the page.
> + * NOTE: hugetlb specific page flags stored in page->private are not
> + *      automatically cleared.  These flags may be used in routines
> + *      which operate on the resulting compound page.
> + *
> + * Must be called with hugetlb lock held.
> + */
> +static void remove_hugetlb_page(struct hstate *h, struct page *page,
> +                                                       bool adjust_surplus)
> +{
> +       int nid = page_to_nid(page);
> +
> +       if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +               return;
> +
> +       list_del(&page->lru);
> +
> +       if (HPageFreed(page)) {
> +               h->free_huge_pages--;
> +               h->free_huge_pages_node[nid]--;
> +               ClearHPageFreed(page);
> +       }
> +       if (adjust_surplus) {
> +               h->surplus_huge_pages--;
> +               h->surplus_huge_pages_node[nid]--;
> +       }
> +
> +       VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> +       VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> +
> +       ClearHPageTemporary(page);
> +       set_page_refcounted(page);
> +       set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> +
> +       h->nr_huge_pages--;
> +       h->nr_huge_pages_node[nid]--;
> +}
> +
>  static void update_and_free_page(struct hstate *h, struct page *page)
>  {
>         int i;
> @@ -1335,8 +1375,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>         if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>                 return;
>
> -       h->nr_huge_pages--;
> -       h->nr_huge_pages_node[page_to_nid(page)]--;
>         for (i = 0; i < pages_per_huge_page(h);
>              i++, subpage = mem_map_next(subpage, page, i)) {
>                 subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> @@ -1344,10 +1382,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>                                 1 << PG_active | 1 << PG_private |
>                                 1 << PG_writeback);
>         }
> -       VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> -       VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> -       set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> -       set_page_refcounted(page);
>         if (hstate_is_gigantic(h)) {
>                 destroy_compound_gigantic_page(page, huge_page_order(h));
>                 free_gigantic_page(page, huge_page_order(h));
> @@ -1415,15 +1449,12 @@ static void __free_huge_page(struct page *page)
>                 h->resv_huge_pages++;
>
>         if (HPageTemporary(page)) {
> -               list_del(&page->lru);
> -               ClearHPageTemporary(page);
> +               remove_hugetlb_page(h, page, false);
>                 update_and_free_page(h, page);
>         } else if (h->surplus_huge_pages_node[nid]) {
>                 /* remove the page from active list */
> -               list_del(&page->lru);
> +               remove_hugetlb_page(h, page, true);
>                 update_and_free_page(h, page);
> -               h->surplus_huge_pages--;
> -               h->surplus_huge_pages_node[nid]--;
>         } else {
>                 arch_clear_hugepage_flags(page);
>                 enqueue_huge_page(h, page);
> @@ -1708,13 +1739,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>                         struct page *page =
>                                 list_entry(h->hugepage_freelists[node].next,
>                                           struct page, lru);
> -                       list_del(&page->lru);
> -                       h->free_huge_pages--;
> -                       h->free_huge_pages_node[node]--;
> -                       if (acct_surplus) {
> -                               h->surplus_huge_pages--;
> -                               h->surplus_huge_pages_node[node]--;
> -                       }
> +                       remove_hugetlb_page(h, page, acct_surplus);
>                         update_and_free_page(h, page);
>                         ret = 1;
>                         break;
> @@ -1752,7 +1777,6 @@ int dissolve_free_huge_page(struct page *page)
>         if (!page_count(page)) {
>                 struct page *head = compound_head(page);
>                 struct hstate *h = page_hstate(head);
> -               int nid = page_to_nid(head);
>                 if (h->free_huge_pages - h->resv_huge_pages == 0)
>                         goto out;
>
> @@ -1783,9 +1807,7 @@ int dissolve_free_huge_page(struct page *page)
>                         SetPageHWPoison(page);
>                         ClearPageHWPoison(head);
>                 }
> -               list_del(&head->lru);
> -               h->free_huge_pages--;
> -               h->free_huge_pages_node[nid]--;
> +               remove_hugetlb_page(h, page, false);
>                 h->max_huge_pages--;
>                 update_and_free_page(h, head);
>                 rc = 0;
> @@ -2553,10 +2575,8 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>                                 return;
>                         if (PageHighMem(page))
>                                 continue;
> -                       list_del(&page->lru);
> +                       remove_hugetlb_page(h, page, false);
>                         update_and_free_page(h, page);
> -                       h->free_huge_pages--;
> -                       h->free_huge_pages_node[page_to_nid(page)]--;
>                 }
>         }
>  }
> --
> 2.30.2
>
