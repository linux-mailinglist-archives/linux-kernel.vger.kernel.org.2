Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABCC34DE40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhC3CWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhC3CVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:21:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131FCC061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:21:46 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id i6so3469926pgs.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caQmmigyxXXISWWwsGxMmB0flUc52vEzXTkZIC8p6T4=;
        b=SOzQb7ET7uixttuKAA9BYVio52twLatgpJgijM7tPgYkMDxwSD71wRGrGoU6P6rNyA
         kwXVjWkqbnRneC4x5qiFr9qCxs3gHi0r5HWo6KfX4ZPnrGJIctCLdCV0Ym+m14ZK52Yq
         BW5ChN0AE7+amA7MwtW1NsqSAL6P3vz7HDfwbZuqxnOko0rE+rlU7uy1ceffz8HgTS48
         opgUwmHxM7AQELe8aOMirMWMs+lGtEzc7hoh9aRv2btFxzuz43pZMThogb1lcG7c8dhK
         F2ubVN3gMIf6GjNVhScN63by4UiUYsCiQqDS55owx6s3y+UQUwcmRSih3dXCepSe7zwv
         rzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caQmmigyxXXISWWwsGxMmB0flUc52vEzXTkZIC8p6T4=;
        b=r3eHQ0sg5WPqEWfkWvO/u5RyCWwnqX58Tlyu3X0kBUlDJIBO+Ha/p76zQ/IYSubE88
         omuXozygXVvdGIH0cNsYP5v/ZYtxqXcJK0m2+PBt9vmPEvCtOjLzA6BVkNolNYpxhxIP
         gHp5DAiO1XlTx0Zl17wV4cLJTbpGhvIqj6uRc9gTd6I04v/batOPupXFs2c2M5WFsP0/
         vT6LwXhaj3A3NhHkjUmepaFpTp8HAQ9pM5RYszh1k2nSZusBxYGKSEhhr/B4Fq2+mHl9
         QsdDn40MjHIaCOj91cuUCJWznTi+EB1Ja325bwrI8CYHwEtWpbTlnc7xuCKMhw7wmP/P
         pBvw==
X-Gm-Message-State: AOAM533rnCkyD8fyqxtX4fGMUZ7Wfpzlqy77zPC1UjFyKjYBtMmHM2JP
        bi/JAsu9foZdIacM0jpVOmyYH1ZQS8h2qJizzPatO4DtntF0XiGW
X-Google-Smtp-Source: ABdhPJzek3HXSsP8L2qWkSKOzj4RowMhyO9Ltw1QAzb0LZ6XX+X9Xd8JGJOOM8PzqEBy1VHPqJWmvv3wIq6kT8NS4Fc=
X-Received: by 2002:a63:161c:: with SMTP id w28mr26789330pgl.341.1617070905572;
 Mon, 29 Mar 2021 19:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210329232402.575396-1-mike.kravetz@oracle.com> <20210329232402.575396-6-mike.kravetz@oracle.com>
In-Reply-To: <20210329232402.575396-6-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 30 Mar 2021 10:21:08 +0800
Message-ID: <CAMZfGtUPgurtQt5u5gw-XsUWdv9bwPQdsZd=c5uNpbi80+-zDw@mail.gmail.com>
Subject: Re: [External] [PATCH v2 5/8] hugetlb: call update_and_free_page
 without hugetlb_lock
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
> With the introduction of remove_hugetlb_page(), there is no need for
> update_and_free_page to hold the hugetlb lock.  Change all callers to
> drop the lock before calling.
>
> With additional code modifications, this will allow loops which decrease
> the huge page pool to drop the hugetlb_lock with each page to reduce
> long hold times.
>
> The ugly unlock/lock cycle in free_pool_huge_page will be removed in
> a subsequent patch which restructures free_pool_huge_page.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 16beabbbbe49..dec7bd0dc63d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1451,16 +1451,18 @@ static void __free_huge_page(struct page *page)
>
>         if (HPageTemporary(page)) {
>                 remove_hugetlb_page(h, page, false);
> +               spin_unlock(&hugetlb_lock);
>                 update_and_free_page(h, page);
>         } else if (h->surplus_huge_pages_node[nid]) {
>                 /* remove the page from active list */
>                 remove_hugetlb_page(h, page, true);
> +               spin_unlock(&hugetlb_lock);
>                 update_and_free_page(h, page);
>         } else {
>                 arch_clear_hugepage_flags(page);
>                 enqueue_huge_page(h, page);
> +               spin_unlock(&hugetlb_lock);
>         }
> -       spin_unlock(&hugetlb_lock);
>  }
>
>  /*
> @@ -1741,7 +1743,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>                                 list_entry(h->hugepage_freelists[node].next,
>                                           struct page, lru);
>                         remove_hugetlb_page(h, page, acct_surplus);
> +                       /*
> +                        * unlock/lock around update_and_free_page is temporary
> +                        * and will be removed with subsequent patch.
> +                        */
> +                       spin_unlock(&hugetlb_lock);
>                         update_and_free_page(h, page);
> +                       spin_lock(&hugetlb_lock);
>                         ret = 1;
>                         break;
>                 }
> @@ -1810,8 +1818,9 @@ int dissolve_free_huge_page(struct page *page)
>                 }
>                 remove_hugetlb_page(h, page, false);
>                 h->max_huge_pages--;
> +               spin_unlock(&hugetlb_lock);
>                 update_and_free_page(h, head);
> -               rc = 0;
> +               return 0;
>         }
>  out:
>         spin_unlock(&hugetlb_lock);
> @@ -2674,22 +2683,35 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>                                                 nodemask_t *nodes_allowed)
>  {
>         int i;
> +       struct page *page, *next;
> +       LIST_HEAD(page_list);
>
>         if (hstate_is_gigantic(h))
>                 return;
>
> +       /*
> +        * Collect pages to be freed on a list, and free after dropping lock
> +        */
> +       INIT_LIST_HEAD(&page_list);

INIT_LIST_HEAD is unnecessary. Because the macro of
LIST_HEAD already initializes the list_head structure.

>         for_each_node_mask(i, *nodes_allowed) {
> -               struct page *page, *next;
>                 struct list_head *freel = &h->hugepage_freelists[i];
>                 list_for_each_entry_safe(page, next, freel, lru) {
>                         if (count >= h->nr_huge_pages)
> -                               return;
> +                               goto out;
>                         if (PageHighMem(page))
>                                 continue;
>                         remove_hugetlb_page(h, page, false);
> -                       update_and_free_page(h, page);
> +                       list_add(&page->lru, &page_list);
>                 }
>         }
> +
> +out:
> +       spin_unlock(&hugetlb_lock);
> +       list_for_each_entry_safe(page, next, &page_list, lru) {
> +               update_and_free_page(h, page);
> +               cond_resched();
> +       }
> +       spin_lock(&hugetlb_lock);
>  }
>  #else
>  static inline void try_to_free_low(struct hstate *h, unsigned long count,
> --
> 2.30.2
>
