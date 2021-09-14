Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C5540BBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhINWnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbhINWnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:43:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49522C061767
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:42:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c21so1296793edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWovTyf3yVyF8vRfkGgZoVPNAy5dI3u45H87y5bM+qM=;
        b=QYLmlGLrsH/mMqSRlYoZ9PTMuCp9PCxK/mNDz9meUad+qe4/HqHMw9E0eBfD4BZgn/
         NX282XbNKV4HV/pjSjpW4iU03c6aJJKfNsC++5bKucTvw6P0h6y+lxKKE5O1Fn92QIN5
         iGx45G5gAX2/8t5KRKhydgMVUc5upCSYwO+/46s5a2BZXoFop/KTGLXAejSklpr19zLH
         qEhEpLLBND9H4/sW202fWLF0MB0Dmeau+FQ0JtY9JK0bPElMpDB1UeycuD0VEAqpsn9n
         0qpnkeMNt1QHJLqBif7XxMvHEmrZ87kbL7XKD7iaqlp7resOa+uXKWecKVm/8DgcVVHW
         Saqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWovTyf3yVyF8vRfkGgZoVPNAy5dI3u45H87y5bM+qM=;
        b=EX+BtT0I9UOFnX2XKOUd54D3wWczNpaG70VxeFPWThwr8wURLKwCGyUWYA72HxyJ6j
         /lO0Dv+IQw3Fe2637b654fD1dJM5ZoYP2FHKD1t58AJY0Y1vxtF0t1HZeR82n7HnxBpF
         WbLgbGY03vM7KYLHjQeGKREVEvKE2yykCi1iis/HyCq/0XCWxA81KI6IJk43tqQEGDUd
         6+aAT1MvMIx14Ve2qFfbDI/S1a/tnagltt6diCc5Fx3nZ/EygM/Y8QapUDheJBVS8X2h
         oyRxb+kQxysPuHeWVWTCE7sBhi/32yPAyClcmlEfmpi2OlgIvA+cTbBVBGnCRsIiEDDk
         Cu6w==
X-Gm-Message-State: AOAM532UqKXDSE4dpV5zbf/9z6E1gA4x6DWhhHdLYn2DAJmfq9KZ15fy
        n2GlC0MLFm9g23iCCXha3W8SwsmJaYWKpTqj0o0i42Pr
X-Google-Smtp-Source: ABdhPJwDEoaY5QEgbCf44Ik5CaZ+Z0LNMi4iisLqdUixGBaC4rjA7K6yFY+gggikTOparBtSQ+tYVf6PjC8Prb1QJ+I=
X-Received: by 2002:a05:6402:16c8:: with SMTP id r8mr632288edx.101.1631659320868;
 Tue, 14 Sep 2021 15:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210914013701.344956-1-ying.huang@intel.com> <20210914013701.344956-3-ying.huang@intel.com>
In-Reply-To: <20210914013701.344956-3-ying.huang@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 14 Sep 2021 15:41:49 -0700
Message-ID: <CAHbLzkqhA0YJncxYokViaAa1Eo5RuMjiRmqGYb_=QAniYBd-bA@mail.gmail.com>
Subject: Re: [PATCH -V8 2/6] memory tiering: add page promotion counter
To:     Huang Ying <ying.huang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 6:37 PM Huang Ying <ying.huang@intel.com> wrote:
>
> To distinguish the number of the memory tiering promoted pages from
> that of the originally inter-socket NUMA balancing migrated pages.
> The counter is per-node (count in the target node).  So this can be
> used to identify promotion imbalance among the NUMA nodes.

I'd like this patch be the very first one in the series. Since we need
such counters regardless of all the optimizations. And actually I
think this patch could go with the merged "migration in lieu of
discard" patchset.

>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: osalvador <osalvador@suse.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  include/linux/mmzone.h |  3 +++
>  include/linux/node.h   |  5 +++++
>  mm/migrate.c           | 11 +++++++++--
>  mm/vmstat.c            |  3 +++
>  4 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 6a1d79d84675..37ccd6158765 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -209,6 +209,9 @@ enum node_stat_item {
>         NR_PAGETABLE,           /* used for pagetables */
>  #ifdef CONFIG_SWAP
>         NR_SWAPCACHE,
> +#endif
> +#ifdef CONFIG_NUMA_BALANCING
> +       PGPROMOTE_SUCCESS,      /* promote successfully */
>  #endif
>         NR_VM_NODE_STAT_ITEMS
>  };
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 8e5a29897936..26e96fcc66af 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -181,4 +181,9 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
>
>  #define to_node(device) container_of(device, struct node, dev)
>
> +static inline bool node_is_toptier(int node)
> +{
> +       return node_state(node, N_CPU);
> +}
> +
>  #endif /* _LINUX_NODE_H_ */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a159a36dd412..6f7a6e2ef41f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2163,6 +2163,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>         pg_data_t *pgdat = NODE_DATA(node);
>         int isolated;
>         int nr_remaining;
> +       int nr_succeeded;
>         LIST_HEAD(migratepages);
>         new_page_t *new;
>         bool compound;
> @@ -2201,7 +2202,8 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>
>         list_add(&page->lru, &migratepages);
>         nr_remaining = migrate_pages(&migratepages, *new, NULL, node,
> -                                    MIGRATE_ASYNC, MR_NUMA_MISPLACED, NULL);
> +                                    MIGRATE_ASYNC, MR_NUMA_MISPLACED,
> +                                    &nr_succeeded);
>         if (nr_remaining) {
>                 if (!list_empty(&migratepages)) {
>                         list_del(&page->lru);
> @@ -2210,8 +2212,13 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>                         putback_lru_page(page);
>                 }
>                 isolated = 0;
> -       } else
> +       } else {
>                 count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_pages);
> +               if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> +                   !node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
> +                       mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS,
> +                                           nr_succeeded);
> +       }
>         BUG_ON(!list_empty(&migratepages));
>         return isolated;
>
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 8ce2620344b2..fff0ec94d795 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1236,6 +1236,9 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_SWAP
>         "nr_swapcached",
>  #endif
> +#ifdef CONFIG_NUMA_BALANCING
> +       "pgpromote_success",
> +#endif
>
>         /* enum writeback_stat_item counters */
>         "nr_dirty_threshold",
> --
> 2.30.2
>
