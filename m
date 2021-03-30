Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9534DE7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhC3CbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhC3CbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:31:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBF7C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:31:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h8so5364615plt.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pq8TcA4YAU5ZaN/2nrokcBlI0CBTR6ha5l31+m4VknY=;
        b=Dn3XtyT45lk551P2DOj8aHJR1tdd7QdLAee+hM025Wp0EVeCqp7pItsWwBdhLUOWJQ
         H5crwowY8etoxODk8JABXMjgmRdIniqwxAt1di+t+/ES3Gat3zwwbSdtqadjcSkL3VH6
         vTT+/trBRM2dhjefW3Oeq685zjY2MvlUFIACvChnza+HPjBS1ZJkC06crO94VjbAQ+tF
         683d6Gh51v7r8HQzG8+8t7GjjWDYkIxmh4h2VvSOlV7gAXOPdf2OMFHUo24+u38ENNyp
         zfwRrKyCDY5msXwlQilg3v7maBFT52uCrOyeufeVlI0h67huc0iqVoEpQK3d1yQufsVX
         tAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pq8TcA4YAU5ZaN/2nrokcBlI0CBTR6ha5l31+m4VknY=;
        b=gYGJjzLL0s5YzGT8P8c64EsTJVkoOopcSUlbdOT9x19Ry+iB66ZQCFLBpz+BFBydBn
         LqfNfUJShJprNaUL9MEleFyWE+yC3iK6yGjFtEPKhUtffzbNSqnMf6UKmr7n00EiZXru
         hb4XXoFBE1sRR9nT+OEe2pvMVdezELzWN39P5IvONEodfLUShuNtyawSW4Bqlx0gKQBW
         lzpG+1QobnGRgJij9i5VyZI8kDPbxe1O7g8XZXA+kGpNW/NrpUC5OsYgFdmcn02KuESh
         SRphKQVsTpkrHthymguf3XEc64+IC455Qad+XdflqP5J9Y+DlxwBOgPFMG2aM7jBvnAg
         E9jA==
X-Gm-Message-State: AOAM530gawFp7EVqR1KMScvvWsO9W9DCo0ZLG1Z5HC4L3cEtDhibeaFd
        HKcPThX3vblccYSdRVWdFuQev6KfyW0zGS9EN4FbhQ==
X-Google-Smtp-Source: ABdhPJyZDL9FbvoN2sLtEmmR0TCi3/EXYgvDk3A4os/m/HAKddS2fMnaAjK5bw4DFovpVjbxIFjQpIWVjj+1F2Skn+g=
X-Received: by 2002:a17:902:da91:b029:e5:e7cf:d737 with SMTP id
 j17-20020a170902da91b02900e5e7cfd737mr31067522plx.24.1617071466602; Mon, 29
 Mar 2021 19:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210329232402.575396-1-mike.kravetz@oracle.com> <20210329232402.575396-7-mike.kravetz@oracle.com>
In-Reply-To: <20210329232402.575396-7-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 30 Mar 2021 10:30:30 +0800
Message-ID: <CAMZfGtWx3+3xsVNg2Z5CQqH2dUWgLk0HG2KEHi_qiGpwBsL6vQ@mail.gmail.com>
Subject: Re: [External] [PATCH v2 6/8] hugetlb: change free_pool_huge_page to remove_pool_huge_page
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 7:24 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> free_pool_huge_page was called with hugetlb_lock held.  It would remove
> a hugetlb page, and then free the corresponding pages to the lower level
> allocators such as buddy.  free_pool_huge_page was called in a loop to
> remove hugetlb pages and these loops could hold the hugetlb_lock for a
> considerable time.
>
> Create new routine remove_pool_huge_page to replace free_pool_huge_page.
> remove_pool_huge_page will remove the hugetlb page, and it must be
> called with the hugetlb_lock held.  It will return the removed page and
> it is the responsibility of the caller to free the page to the lower
> level allocators.  The hugetlb_lock is dropped before freeing to these
> allocators which results in shorter lock hold times.
>
> Add new helper routine to call update_and_free_page for a list of pages.
>
> Note: Some changes to the routine return_unused_surplus_pages are in
> need of explanation.  Commit e5bbc8a6c992 ("mm/hugetlb.c: fix reservation
> race when freeing surplus pages") modified this routine to address a
> race which could occur when dropping the hugetlb_lock in the loop that
> removes pool pages.  Accounting changes introduced in that commit were
> subtle and took some thought to understand.  This commit removes the
> cond_resched_lock() and the potential race.  Therefore, remove the
> subtle code and restore the more straight forward accounting effectively
> reverting the commit.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Some nits below.

> ---
>  mm/hugetlb.c | 95 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 42 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dec7bd0dc63d..d3f3cb8766b8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1209,7 +1209,7 @@ static int hstate_next_node_to_alloc(struct hstate *h,
>  }
>
>  /*
> - * helper for free_pool_huge_page() - return the previously saved
> + * helper for remove_pool_huge_page() - return the previously saved
>   * node ["this node"] from which to free a huge page.  Advance the
>   * next node id whether or not we find a free huge page to free so
>   * that the next attempt to free addresses the next node.
> @@ -1391,6 +1391,16 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>         }
>  }
>
> +static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> +{
> +       struct page *page, *t_page;
> +
> +       list_for_each_entry_safe(page, t_page, list, lru) {
> +               update_and_free_page(h, page);
> +               cond_resched();
> +       }
> +}
> +
>  struct hstate *size_to_hstate(unsigned long size)
>  {
>         struct hstate *h;
> @@ -1721,16 +1731,18 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  }
>
>  /*
> - * Free huge page from pool from next node to free.
> - * Attempt to keep persistent huge pages more or less
> - * balanced over allowed nodes.
> + * Remove huge page from pool from next node to free.  Attempt to keep
> + * persistent huge pages more or less balanced over allowed nodes.
> + * This routine only 'removes' the hugetlb page.  The caller must make
> + * an additional call to free the page to low level allocators.
>   * Called with hugetlb_lock locked.
>   */
> -static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
> -                                                        bool acct_surplus)
> +static struct page *remove_pool_huge_page(struct hstate *h,
> +                                               nodemask_t *nodes_allowed,
> +                                                bool acct_surplus)
>  {
>         int nr_nodes, node;
> -       int ret = 0;
> +       struct page *page = NULL;
>
>         for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
>                 /*
> @@ -1739,23 +1751,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>                  */
>                 if ((!acct_surplus || h->surplus_huge_pages_node[node]) &&
>                     !list_empty(&h->hugepage_freelists[node])) {
> -                       struct page *page =
> -                               list_entry(h->hugepage_freelists[node].next,
> +                       page = list_entry(h->hugepage_freelists[node].next,
>                                           struct page, lru);
>                         remove_hugetlb_page(h, page, acct_surplus);
> -                       /*
> -                        * unlock/lock around update_and_free_page is temporary
> -                        * and will be removed with subsequent patch.
> -                        */
> -                       spin_unlock(&hugetlb_lock);
> -                       update_and_free_page(h, page);
> -                       spin_lock(&hugetlb_lock);
> -                       ret = 1;
>                         break;
>                 }
>         }
>
> -       return ret;
> +       return page;
>  }
>
>  /*
> @@ -2075,17 +2078,16 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>   *    to the associated reservation map.
>   * 2) Free any unused surplus pages that may have been allocated to satisfy
>   *    the reservation.  As many as unused_resv_pages may be freed.
> - *
> - * Called with hugetlb_lock held.  However, the lock could be dropped (and
> - * reacquired) during calls to cond_resched_lock.  Whenever dropping the lock,
> - * we must make sure nobody else can claim pages we are in the process of
> - * freeing.  Do this by ensuring resv_huge_page always is greater than the
> - * number of huge pages we plan to free when dropping the lock.
>   */
>  static void return_unused_surplus_pages(struct hstate *h,
>                                         unsigned long unused_resv_pages)
>  {
>         unsigned long nr_pages;
> +       struct page *page;
> +       LIST_HEAD(page_list);
> +
> +       /* Uncommit the reservation */
> +       h->resv_huge_pages -= unused_resv_pages;
>
>         /* Cannot return gigantic pages currently */
>         if (hstate_is_gigantic(h))
> @@ -2102,24 +2104,22 @@ static void return_unused_surplus_pages(struct hstate *h,
>          * evenly across all nodes with memory. Iterate across these nodes
>          * until we can no longer free unreserved surplus pages. This occurs
>          * when the nodes with surplus pages have no free pages.
> -        * free_pool_huge_page() will balance the freed pages across the
> +        * remove_pool_huge_page() will balance the freed pages across the
>          * on-line nodes with memory and will handle the hstate accounting.
> -        *
> -        * Note that we decrement resv_huge_pages as we free the pages.  If
> -        * we drop the lock, resv_huge_pages will still be sufficiently large
> -        * to cover subsequent pages we may free.
>          */
> +       INIT_LIST_HEAD(&page_list);

INIT_LIST_HEAD is unnecessary. LIST_HEAD is enough.

>         while (nr_pages--) {
> -               h->resv_huge_pages--;
> -               unused_resv_pages--;
> -               if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
> +               page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
> +               if (!page)
>                         goto out;
> -               cond_resched_lock(&hugetlb_lock);
> +
> +               list_add(&page->lru, &page_list);
>         }
>
>  out:
> -       /* Fully uncommit the reservation */
> -       h->resv_huge_pages -= unused_resv_pages;
> +       spin_unlock(&hugetlb_lock);
> +       update_and_free_pages_bulk(h, &page_list);
> +       spin_lock(&hugetlb_lock);
>  }
>
>
> @@ -2683,7 +2683,6 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>                                                 nodemask_t *nodes_allowed)
>  {
>         int i;
> -       struct page *page, *next;
>         LIST_HEAD(page_list);
>
>         if (hstate_is_gigantic(h))
> @@ -2694,6 +2693,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>          */
>         INIT_LIST_HEAD(&page_list);
>         for_each_node_mask(i, *nodes_allowed) {
> +               struct page *page, *next;
>                 struct list_head *freel = &h->hugepage_freelists[i];
>                 list_for_each_entry_safe(page, next, freel, lru) {
>                         if (count >= h->nr_huge_pages)
> @@ -2707,10 +2707,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>
>  out:
>         spin_unlock(&hugetlb_lock);
> -       list_for_each_entry_safe(page, next, &page_list, lru) {
> -               update_and_free_page(h, page);
> -               cond_resched();
> -       }
> +       update_and_free_pages_bulk(h, &page_list);
>         spin_lock(&hugetlb_lock);
>  }
>  #else
> @@ -2757,6 +2754,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>                               nodemask_t *nodes_allowed)
>  {
>         unsigned long min_count, ret;
> +       struct page *page;
> +       LIST_HEAD(page_list);
>         NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
>
>         /*
> @@ -2869,11 +2868,23 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>         min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
>         min_count = max(count, min_count);
>         try_to_free_low(h, min_count, nodes_allowed);
> +
> +       /*
> +        * Collect pages to be removed on list without dropping lock
> +        */
> +       INIT_LIST_HEAD(&page_list);

Same here.

>         while (min_count < persistent_huge_pages(h)) {
> -               if (!free_pool_huge_page(h, nodes_allowed, 0))
> +               page = remove_pool_huge_page(h, nodes_allowed, 0);
> +               if (!page)
>                         break;
> -               cond_resched_lock(&hugetlb_lock);
> +
> +               list_add(&page->lru, &page_list);
>         }
> +       /* free the pages after dropping lock */
> +       spin_unlock(&hugetlb_lock);
> +       update_and_free_pages_bulk(h, &page_list);
> +       spin_lock(&hugetlb_lock);
> +
>         while (count < persistent_huge_pages(h)) {
>                 if (!adjust_pool_surplus(h, nodes_allowed, 1))
>                         break;
> --
> 2.30.2
>
