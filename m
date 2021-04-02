Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C2E352ACA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhDBMsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBMsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 08:48:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF9EC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 05:48:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s21so2668156pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOs1CXRn1yYS1Rco3OfAFJqo5RsqDj/5pFAvOoF79RE=;
        b=BaloXYfmh40dWr1hz48EdBoF11M8dA98uIOcyI3NfExHdqWY0tQBW3LR4eQegyzBWv
         z/LmJGlwfQ6i9IFTzN0h4+wzGPwWT+C2BBqPQ6xP0m8AVwq2AaxiAwtpFiur1W/KKstX
         gbjHu3mRAHj5JRCkr60u3UlipytW9NTeybPJA+eekbo3Sp329GMMFEJXbD5VaKyARXgQ
         xzVhPFqI0xcgBZnSu3vcXlGMVoMmulLRvCp1btdc+zLjM6axpRfAwjCSFASoL7zMRC7K
         fPXz2pxxDw20nUwPb2zsOuua1+04lDsIKDkSTW08UitERFwaEIj3pV94yw+zvTWVBwWB
         EZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOs1CXRn1yYS1Rco3OfAFJqo5RsqDj/5pFAvOoF79RE=;
        b=jqzD5/YEFFa6qlyFAU476+CFJkjhzniuF5ak4Bi7A4K2HwPyIQN81K3EF7cpABovYH
         qRpaFgp9tQfjchlQl0xcmPDWpiVyN73zUwNedpol5Y0vYf/M37CCgqgKadY0YZ1Zx2y5
         dAJ6z3dOtz0VBFBG1BNzchfbDpHDnI2XZ9Exe0OEmYr5c6SRvEhIUWuNqbtBWBuVf4Ab
         iU4Kyyui6BcCkEh0Yz7EVDneJcmesV/hUDwpxjGPiVwhsaBXNP7tXuJAF+C86Y63seMp
         YeUvXRI/20US4+xN75HGGoV0j+9QpdSySxz6sd1SRCqjAAcZV7KXdnMe9tfFHXeBzHED
         Ti+A==
X-Gm-Message-State: AOAM530mN6sRclIU9bPLdtONdjfJrKnTZNOvcAkUaUgb9q1n72YkPYrj
        qRohO/MNazc0o66RbBJwbun0bkt9nAPUBCBWSW8QNQ==
X-Google-Smtp-Source: ABdhPJyZht1IxAGx+r/v4Dymmr2K85bMh4KTbj7wlQHNuHKNcwv1ply8TwfC8VkkFGaktsKVAXpO8NSzXnJOJPECtmo=
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr13531382pjv.229.1617367690889;
 Fri, 02 Apr 2021 05:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210331034148.112624-1-mike.kravetz@oracle.com> <20210331034148.112624-8-mike.kravetz@oracle.com>
In-Reply-To: <20210331034148.112624-8-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 2 Apr 2021 20:47:34 +0800
Message-ID: <CAMZfGtUUWD4WkTOXL3D--jfbHYXUuYQsWtiX0k3UD=_x2SC78g@mail.gmail.com>
Subject: Re: [External] [PATCH v3 7/8] hugetlb: make free_huge_page irq safe
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:42 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Commit c77c0a8ac4c5 ("mm/hugetlb: defer freeing of huge pages if in
> non-task context") was added to address the issue of free_huge_page
> being called from irq context.  That commit hands off free_huge_page
> processing to a workqueue if !in_task.  However, this doesn't cover
> all the cases as pointed out by 0day bot lockdep report [1].
>
> :  Possible interrupt unsafe locking scenario:
> :
> :        CPU0                    CPU1
> :        ----                    ----
> :   lock(hugetlb_lock);
> :                                local_irq_disable();
> :                                lock(slock-AF_INET);
> :                                lock(hugetlb_lock);
> :   <Interrupt>
> :     lock(slock-AF_INET);
>
> Shakeel has later explained that this is very likely TCP TX zerocopy
> from hugetlb pages scenario when the networking code drops a last
> reference to hugetlb page while having IRQ disabled. Hugetlb freeing
> path doesn't disable IRQ while holding hugetlb_lock so a lock dependency
> chain can lead to a deadlock.
>
> This commit addresses the issue by doing the following:
> - Make hugetlb_lock irq safe.  This is mostly a simple process of
>   changing spin_*lock calls to spin_*lock_irq* calls.
> - Make subpool lock irq safe in a similar manner.
> - Revert the !in_task check and workqueue handoff.
>
> [1] https://lore.kernel.org/linux-mm/000000000000f1c03b05bc43aadc@google.com/
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Hi Mike,

Today I pulled the newest code (next-20210401). I found that
alloc_and_dissolve_huge_page is not updated. In this function,
hugetlb_lock is still non-irq safe. Maybe you or Oscar need
to fix.

Thanks.

> ---
>  mm/hugetlb.c        | 167 ++++++++++++++++----------------------------
>  mm/hugetlb_cgroup.c |   8 +--
>  2 files changed, 66 insertions(+), 109 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5b2ca4663d7f..0bd4dc04df0f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -93,9 +93,10 @@ static inline bool subpool_is_free(struct hugepage_subpool *spool)
>         return true;
>  }
>
> -static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
> +static inline void unlock_or_release_subpool(struct hugepage_subpool *spool,
> +                                               unsigned long irq_flags)
>  {
> -       spin_unlock(&spool->lock);
> +       spin_unlock_irqrestore(&spool->lock, irq_flags);
>
>         /* If no pages are used, and no other handles to the subpool
>          * remain, give up any reservations based on minimum size and
> @@ -134,10 +135,12 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
>
>  void hugepage_put_subpool(struct hugepage_subpool *spool)
>  {
> -       spin_lock(&spool->lock);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&spool->lock, flags);
>         BUG_ON(!spool->count);
>         spool->count--;
> -       unlock_or_release_subpool(spool);
> +       unlock_or_release_subpool(spool, flags);
>  }
>
>  /*
> @@ -156,7 +159,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
>         if (!spool)
>                 return ret;
>
> -       spin_lock(&spool->lock);
> +       spin_lock_irq(&spool->lock);
>
>         if (spool->max_hpages != -1) {          /* maximum size accounting */
>                 if ((spool->used_hpages + delta) <= spool->max_hpages)
> @@ -183,7 +186,7 @@ static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
>         }
>
>  unlock_ret:
> -       spin_unlock(&spool->lock);
> +       spin_unlock_irq(&spool->lock);
>         return ret;
>  }
>
> @@ -197,11 +200,12 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
>                                        long delta)
>  {
>         long ret = delta;
> +       unsigned long flags;
>
>         if (!spool)
>                 return delta;
>
> -       spin_lock(&spool->lock);
> +       spin_lock_irqsave(&spool->lock, flags);
>
>         if (spool->max_hpages != -1)            /* maximum size accounting */
>                 spool->used_hpages -= delta;
> @@ -222,7 +226,7 @@ static long hugepage_subpool_put_pages(struct hugepage_subpool *spool,
>          * If hugetlbfs_put_super couldn't free spool due to an outstanding
>          * quota reference, free it now.
>          */
> -       unlock_or_release_subpool(spool);
> +       unlock_or_release_subpool(spool, flags);
>
>         return ret;
>  }
> @@ -1412,7 +1416,7 @@ struct hstate *size_to_hstate(unsigned long size)
>         return NULL;
>  }
>
> -static void __free_huge_page(struct page *page)
> +void free_huge_page(struct page *page)
>  {
>         /*
>          * Can't pass hstate in here because it is called from the
> @@ -1422,6 +1426,7 @@ static void __free_huge_page(struct page *page)
>         int nid = page_to_nid(page);
>         struct hugepage_subpool *spool = hugetlb_page_subpool(page);
>         bool restore_reserve;
> +       unsigned long flags;
>
>         VM_BUG_ON_PAGE(page_count(page), page);
>         VM_BUG_ON_PAGE(page_mapcount(page), page);
> @@ -1450,7 +1455,7 @@ static void __free_huge_page(struct page *page)
>                         restore_reserve = true;
>         }
>
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irqsave(&hugetlb_lock, flags);
>         ClearHPageMigratable(page);
>         hugetlb_cgroup_uncharge_page(hstate_index(h),
>                                      pages_per_huge_page(h), page);
> @@ -1461,67 +1466,19 @@ static void __free_huge_page(struct page *page)
>
>         if (HPageTemporary(page)) {
>                 remove_hugetlb_page(h, page, false);
> -               spin_unlock(&hugetlb_lock);
> +               spin_unlock_irqrestore(&hugetlb_lock, flags);
>                 update_and_free_page(h, page);
>         } else if (h->surplus_huge_pages_node[nid]) {
>                 /* remove the page from active list */
>                 remove_hugetlb_page(h, page, true);
> -               spin_unlock(&hugetlb_lock);
> +               spin_unlock_irqrestore(&hugetlb_lock, flags);
>                 update_and_free_page(h, page);
>         } else {
>                 arch_clear_hugepage_flags(page);
>                 enqueue_huge_page(h, page);
> -               spin_unlock(&hugetlb_lock);
> -       }
> -}
> -
> -/*
> - * As free_huge_page() can be called from a non-task context, we have
> - * to defer the actual freeing in a workqueue to prevent potential
> - * hugetlb_lock deadlock.
> - *
> - * free_hpage_workfn() locklessly retrieves the linked list of pages to
> - * be freed and frees them one-by-one. As the page->mapping pointer is
> - * going to be cleared in __free_huge_page() anyway, it is reused as the
> - * llist_node structure of a lockless linked list of huge pages to be freed.
> - */
> -static LLIST_HEAD(hpage_freelist);
> -
> -static void free_hpage_workfn(struct work_struct *work)
> -{
> -       struct llist_node *node;
> -       struct page *page;
> -
> -       node = llist_del_all(&hpage_freelist);
> -
> -       while (node) {
> -               page = container_of((struct address_space **)node,
> -                                    struct page, mapping);
> -               node = node->next;
> -               __free_huge_page(page);
> +               spin_unlock_irqrestore(&hugetlb_lock, flags);
>         }
>  }
> -static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
> -
> -void free_huge_page(struct page *page)
> -{
> -       /*
> -        * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
> -        */
> -       if (!in_task()) {
> -               /*
> -                * Only call schedule_work() if hpage_freelist is previously
> -                * empty. Otherwise, schedule_work() had been called but the
> -                * workfn hasn't retrieved the list yet.
> -                */
> -               if (llist_add((struct llist_node *)&page->mapping,
> -                             &hpage_freelist))
> -                       schedule_work(&free_hpage_work);
> -               return;
> -       }
> -
> -       __free_huge_page(page);
> -}
>
>  static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  {
> @@ -1530,11 +1487,11 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>         hugetlb_set_page_subpool(page, NULL);
>         set_hugetlb_cgroup(page, NULL);
>         set_hugetlb_cgroup_rsvd(page, NULL);
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         h->nr_huge_pages++;
>         h->nr_huge_pages_node[nid]++;
>         ClearHPageFreed(page);
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>  }
>
>  static void prep_compound_gigantic_page(struct page *page, unsigned int order)
> @@ -1780,7 +1737,7 @@ int dissolve_free_huge_page(struct page *page)
>         if (!PageHuge(page))
>                 return 0;
>
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         if (!PageHuge(page)) {
>                 rc = 0;
>                 goto out;
> @@ -1797,7 +1754,7 @@ int dissolve_free_huge_page(struct page *page)
>                  * when it is dissolved.
>                  */
>                 if (unlikely(!HPageFreed(head))) {
> -                       spin_unlock(&hugetlb_lock);
> +                       spin_unlock_irq(&hugetlb_lock);
>                         cond_resched();
>
>                         /*
> @@ -1821,12 +1778,12 @@ int dissolve_free_huge_page(struct page *page)
>                 }
>                 remove_hugetlb_page(h, page, false);
>                 h->max_huge_pages--;
> -               spin_unlock(&hugetlb_lock);
> +               spin_unlock_irq(&hugetlb_lock);
>                 update_and_free_page(h, head);
>                 return 0;
>         }
>  out:
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>         return rc;
>  }
>
> @@ -1868,16 +1825,16 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>         if (hstate_is_gigantic(h))
>                 return NULL;
>
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages)
>                 goto out_unlock;
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>
>         page = alloc_fresh_huge_page(h, gfp_mask, nid, nmask, NULL);
>         if (!page)
>                 return NULL;
>
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         /*
>          * We could have raced with the pool size change.
>          * Double check that and simply deallocate the new page
> @@ -1887,7 +1844,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>          */
>         if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
>                 SetHPageTemporary(page);
> -               spin_unlock(&hugetlb_lock);
> +               spin_unlock_irq(&hugetlb_lock);
>                 put_page(page);
>                 return NULL;
>         } else {
> @@ -1896,7 +1853,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>         }
>
>  out_unlock:
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>
>         return page;
>  }
> @@ -1946,17 +1903,17 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
>                 nodemask_t *nmask, gfp_t gfp_mask)
>  {
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         if (h->free_huge_pages - h->resv_huge_pages > 0) {
>                 struct page *page;
>
>                 page = dequeue_huge_page_nodemask(h, gfp_mask, preferred_nid, nmask);
>                 if (page) {
> -                       spin_unlock(&hugetlb_lock);
> +                       spin_unlock_irq(&hugetlb_lock);
>                         return page;
>                 }
>         }
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>
>         return alloc_migrate_huge_page(h, gfp_mask, preferred_nid, nmask);
>  }
> @@ -2004,7 +1961,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>
>         ret = -ENOMEM;
>  retry:
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>         for (i = 0; i < needed; i++) {
>                 page = alloc_surplus_huge_page(h, htlb_alloc_mask(h),
>                                 NUMA_NO_NODE, NULL);
> @@ -2021,7 +1978,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>          * After retaking hugetlb_lock, we need to recalculate 'needed'
>          * because either resv_huge_pages or free_huge_pages may have changed.
>          */
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         needed = (h->resv_huge_pages + delta) -
>                         (h->free_huge_pages + allocated);
>         if (needed > 0) {
> @@ -2061,12 +2018,12 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>                 enqueue_huge_page(h, page);
>         }
>  free:
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>
>         /* Free unnecessary surplus pages to the buddy allocator */
>         list_for_each_entry_safe(page, tmp, &surplus_list, lru)
>                 put_page(page);
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>
>         return ret;
>  }
> @@ -2116,9 +2073,9 @@ static void return_unused_surplus_pages(struct hstate *h,
>         }
>
>  out:
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>         update_and_free_pages_bulk(h, &page_list);
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>  }
>
>
> @@ -2463,7 +2420,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>         if (ret)
>                 goto out_uncharge_cgroup_reservation;
>
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         /*
>          * glb_chg is passed to indicate whether or not a page must be taken
>          * from the global free pool (global change).  gbl_chg == 0 indicates
> @@ -2471,7 +2428,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>          */
>         page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
>         if (!page) {
> -               spin_unlock(&hugetlb_lock);
> +               spin_unlock_irq(&hugetlb_lock);
>                 page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
>                 if (!page)
>                         goto out_uncharge_cgroup;
> @@ -2479,7 +2436,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>                         SetHPageRestoreReserve(page);
>                         h->resv_huge_pages--;
>                 }
> -               spin_lock(&hugetlb_lock);
> +               spin_lock_irq(&hugetlb_lock);
>                 list_add(&page->lru, &h->hugepage_activelist);
>                 /* Fall through */
>         }
> @@ -2492,7 +2449,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>                                                   h_cg, page);
>         }
>
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>
>         hugetlb_set_page_subpool(page, spool);
>
> @@ -2704,9 +2661,9 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>         }
>
>  out:
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>         update_and_free_pages_bulk(h, &page_list);
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>  }
>  #else
>  static inline void try_to_free_low(struct hstate *h, unsigned long count,
> @@ -2802,7 +2759,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>          */
>         if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>                 if (count > persistent_huge_pages(h)) {
> -                       spin_unlock(&hugetlb_lock);
> +                       spin_unlock_irq(&hugetlb_lock);
>                         mutex_unlock(&h->resize_lock);
>                         NODEMASK_FREE(node_alloc_noretry);
>                         return -EINVAL;
> @@ -2832,14 +2789,14 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>                  * page, free_huge_page will handle it by freeing the page
>                  * and reducing the surplus.
>                  */
> -               spin_unlock(&hugetlb_lock);
> +               spin_unlock_irq(&hugetlb_lock);
>
>                 /* yield cpu to avoid soft lockup */
>                 cond_resched();
>
>                 ret = alloc_pool_huge_page(h, nodes_allowed,
>                                                 node_alloc_noretry);
> -               spin_lock(&hugetlb_lock);
> +               spin_lock_irq(&hugetlb_lock);
>                 if (!ret)
>                         goto out;
>
> @@ -2878,9 +2835,9 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>                 list_add(&page->lru, &page_list);
>         }
>         /* free the pages after dropping lock */
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>         update_and_free_pages_bulk(h, &page_list);
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>
>         while (count < persistent_huge_pages(h)) {
>                 if (!adjust_pool_surplus(h, nodes_allowed, 1))
> @@ -2888,7 +2845,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>         }
>  out:
>         h->max_huge_pages = persistent_huge_pages(h);
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>         mutex_unlock(&h->resize_lock);
>
>         NODEMASK_FREE(node_alloc_noretry);
> @@ -3044,9 +3001,9 @@ static ssize_t nr_overcommit_hugepages_store(struct kobject *kobj,
>         if (err)
>                 return err;
>
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         h->nr_overcommit_huge_pages = input;
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>
>         return count;
>  }
> @@ -3633,9 +3590,9 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
>                 goto out;
>
>         if (write) {
> -               spin_lock(&hugetlb_lock);
> +               spin_lock_irq(&hugetlb_lock);
>                 h->nr_overcommit_huge_pages = tmp;
> -               spin_unlock(&hugetlb_lock);
> +               spin_unlock_irq(&hugetlb_lock);
>         }
>  out:
>         return ret;
> @@ -3731,7 +3688,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
>         if (!delta)
>                 return 0;
>
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         /*
>          * When cpuset is configured, it breaks the strict hugetlb page
>          * reservation as the accounting is done on a global variable. Such
> @@ -3770,7 +3727,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
>                 return_unused_surplus_pages(h, (unsigned long) -delta);
>
>  out:
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>         return ret;
>  }
>
> @@ -5834,7 +5791,7 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
>  {
>         bool ret = true;
>
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         if (!PageHeadHuge(page) ||
>             !HPageMigratable(page) ||
>             !get_page_unless_zero(page)) {
> @@ -5844,16 +5801,16 @@ bool isolate_huge_page(struct page *page, struct list_head *list)
>         ClearHPageMigratable(page);
>         list_move_tail(&page->lru, list);
>  unlock:
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>         return ret;
>  }
>
>  void putback_active_hugepage(struct page *page)
>  {
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         SetHPageMigratable(page);
>         list_move_tail(&page->lru, &(page_hstate(page))->hugepage_activelist);
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>         put_page(page);
>  }
>
> @@ -5887,12 +5844,12 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
>                  */
>                 if (new_nid == old_nid)
>                         return;
> -               spin_lock(&hugetlb_lock);
> +               spin_lock_irq(&hugetlb_lock);
>                 if (h->surplus_huge_pages_node[old_nid]) {
>                         h->surplus_huge_pages_node[old_nid]--;
>                         h->surplus_huge_pages_node[new_nid]++;
>                 }
> -               spin_unlock(&hugetlb_lock);
> +               spin_unlock_irq(&hugetlb_lock);
>         }
>  }
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 726b85f4f303..5383023d0cca 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -204,11 +204,11 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
>         do {
>                 idx = 0;
>                 for_each_hstate(h) {
> -                       spin_lock(&hugetlb_lock);
> +                       spin_lock_irq(&hugetlb_lock);
>                         list_for_each_entry(page, &h->hugepage_activelist, lru)
>                                 hugetlb_cgroup_move_parent(idx, h_cg, page);
>
> -                       spin_unlock(&hugetlb_lock);
> +                       spin_unlock_irq(&hugetlb_lock);
>                         idx++;
>                 }
>                 cond_resched();
> @@ -784,7 +784,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
>         if (hugetlb_cgroup_disabled())
>                 return;
>
> -       spin_lock(&hugetlb_lock);
> +       spin_lock_irq(&hugetlb_lock);
>         h_cg = hugetlb_cgroup_from_page(oldhpage);
>         h_cg_rsvd = hugetlb_cgroup_from_page_rsvd(oldhpage);
>         set_hugetlb_cgroup(oldhpage, NULL);
> @@ -794,7 +794,7 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
>         set_hugetlb_cgroup(newhpage, h_cg);
>         set_hugetlb_cgroup_rsvd(newhpage, h_cg_rsvd);
>         list_move(&newhpage->lru, &h->hugepage_activelist);
> -       spin_unlock(&hugetlb_lock);
> +       spin_unlock_irq(&hugetlb_lock);
>         return;
>  }
>
> --
> 2.30.2
>
