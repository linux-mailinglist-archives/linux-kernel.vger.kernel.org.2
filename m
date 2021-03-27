Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B334B4DE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 07:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhC0GzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 02:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhC0Gyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 02:54:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9709EC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 23:54:49 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w8so3595689pjf.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHhxYzKxSZK7e1pTvFSaSY+himIOm/SDf+mnW3D31k8=;
        b=YRNmiHIA6YRSp9KCax5lTcZH1dWYiQMLqlJyd+TIWrNH8b4w8IONyj7C+k2WvL7pX2
         l5+D6T52yMOW3fSSmfw/nXiNhluCxgNvma9KTvvTDIvBQ0X+iLwVhhqgi0a3rJziHjr6
         00PlZbv4u6nUh0LZiGALlT2pzrXwsdmc6ciE/bRHsNpPaFRx80FXjAQQY4OZHvSJdp5P
         uR5Lha6yRNskjfv1sS4c5dAAYYVgC7zo3yK5+m5yiR9UiEQAwnuPtofdSHxNpnhggbv5
         U7XrY9EcCkQ+GTldIOksYHqctaDAAiGf7mfsph/tWay9r6g1WmM6ZJBwKU3Z8ZZKyXw2
         0ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHhxYzKxSZK7e1pTvFSaSY+himIOm/SDf+mnW3D31k8=;
        b=UlkykmhCcj2JVDH4bSXctTkZINaU9jyl34pFwgvwliAKF0QeiUXN7y18AUhZ66kn+S
         opmRU97Lpr/33Guo/9zXYp+O1PRt0QOm24GksI99imasGbEq8oJ8NV8VQwCyEIXhDB/q
         xrcHILC0X8TtqVV3q1DInVfii0phvDuFt/LpL5kRMaeVXv0WE+BifUCIUtzWyT4qpmpU
         x4HMHKlP9QWpmDRv8d9GryRJA+7Mwy7IMsmcgRFuKjfuwVGyfwoPHHohCrpAFJh13JcV
         yo2dHalU8HjV02x7YbSpvZsvJzMs4HOel/ObBKyHmP+lj2sJvzFqGlvfZK0SE1OBMuBi
         1Kuw==
X-Gm-Message-State: AOAM530BVCgfEub70irLFUjtWvkG6GofpG0z5NkbOC6wDA2AOJNnQWAf
        26HFbjci+HRtQN68RiexrRBbq5OpgXYpf+yJy5D12Q==
X-Google-Smtp-Source: ABdhPJxRD75z5ix5RMtTYqxS/AMhK2yQpgljLHut/GHQ6lyB7w5a0hQeKSj0687N2pji1r4DdfX+XbNVJI3vvwHCp6E=
X-Received: by 2002:a17:902:d4cb:b029:e5:f608:6d5e with SMTP id
 o11-20020a170902d4cbb02900e5f6086d5emr18827042plg.20.1616828089060; Fri, 26
 Mar 2021 23:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210325002835.216118-1-mike.kravetz@oracle.com> <20210325002835.216118-6-mike.kravetz@oracle.com>
In-Reply-To: <20210325002835.216118-6-mike.kravetz@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 27 Mar 2021 14:54:12 +0800
Message-ID: <CAMZfGtVMMBEFQAS=ch9fJFhCk+gBGV_frXBFnJLZR2Q22U4q2g@mail.gmail.com>
Subject: Re: [External] [PATCH 5/8] hugetlb: call update_and_free_page without hugetlb_lock
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

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Some nits below.

> ---
>  mm/hugetlb.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3938ec086b5c..fae7f034d1eb 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1450,16 +1450,18 @@ static void __free_huge_page(struct page *page)
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
> @@ -1740,7 +1742,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
> @@ -1809,8 +1817,9 @@ int dissolve_free_huge_page(struct page *page)
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
> @@ -2563,22 +2572,37 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>                                                 nodemask_t *nodes_allowed)
>  {
>         int i;
> +       struct list_head page_list;

I prefer to use LIST_HEAD(page_list) directly.

> +       struct page *page, *next;
>
>         if (hstate_is_gigantic(h))
>                 return;
>
> +       /*
> +        * Collect pages to be freed on a list, and free after dropping lock
> +        */
> +       INIT_LIST_HEAD(&page_list);
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
> +                       INIT_LIST_HEAD(&page->lru);

As Michal pointed out that this is superfluous.

> +                       list_add(&page->lru, &page_list);
>                 }
>         }
> +
> +out:
> +       spin_unlock(&hugetlb_lock);
> +       list_for_each_entry_safe(page, next, &page_list, lru) {
> +               list_del(&page->lru);

It looks like list_del() is also superfluous. Should we remove it?

Thanks.

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
