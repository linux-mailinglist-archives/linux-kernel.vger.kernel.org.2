Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D7455192
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 01:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbhKRASv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbhKRASp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:18:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D78C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:15:45 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so18725690edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPzDrm8hw/ujJmiUKHH7CMVzIaJ4uv6KjA6rPPfDBlA=;
        b=MYjaC48HJMlTwAZ5qRLVZREpdOvi98kfTgr63YfwurOcOCrjl9nJYQY/icYELIUxrA
         JckcwZRrBPvvLA2osY4mkl4IFR21i3IrIi93OetLdhRQbXGnvSiOw0KBlPyPlGLcm62M
         EF+WyaDrV6hZhmnG5QRvaGd0Ez6fk8j7gaZrvhrKDlD8+q3sNaNBDklXm1S/qD2ZO9Zr
         ZXDEyEn4vI7w2sN/7X0GF6fZEHK9VXv0kxNv/4/F7efW5JAVBadzz1tbCr4uKZHiIjza
         jouvD+XsEWjw9sis7M/LW7FUAAxRuIlEozUxeVWxxGqQ8bvvV0SH9eCibsIX/M2z3Xvk
         Kz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPzDrm8hw/ujJmiUKHH7CMVzIaJ4uv6KjA6rPPfDBlA=;
        b=l6e8uSDecDra2ArFusZ2j509usvZakYthW/kNg70KYWd7N3frk2+AjUs+lJBcP205q
         bjTW1whtMh1qNxNWKH2X20WwjEq64Vy9A+wCPggWU0AFtHDLUMaQl/jzzqxsPvAoda0P
         cdpIC75OCbW965XDvoOiVrcPzrMFK85BEVAPxK2DJmq8DH77KkKilnSyg3Pz2HNugMes
         A6LwixG0sL9zpZPUCE0aDrxpTPxpRibuZjUl/hw2lZYgykFeFmKz87zy3MCYgC20OIQ9
         oIPpD5hW2Vu8eTZe1b+CWhhUXt9VliTKkPTVYh8HgInhJmZ1InKxkcs2XX8GZhGmBI4j
         CdUA==
X-Gm-Message-State: AOAM5317NWtYDztLBaCrMy0kN7fYclDNDUwWTvdW/OyYP64LlH9Cw/U7
        0qDMlx71zpXrMoZv1QPwuDbnpUGk2NBvsSvuv91cyBlBf4s=
X-Google-Smtp-Source: ABdhPJzX2jweD0mYj8O2e9J4t8sqUX9NjEWWi4n12PZ/vxHqcZkNTop10a1J0vwbn/VBUOa6nTaTtK26vO6eZr3EstY=
X-Received: by 2002:a05:6402:2926:: with SMTP id ee38mr4415019edb.71.1637194544403;
 Wed, 17 Nov 2021 16:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20211116013522.140575-1-ying.huang@intel.com> <20211116013522.140575-2-ying.huang@intel.com>
In-Reply-To: <20211116013522.140575-2-ying.huang@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 17 Nov 2021 16:15:32 -0800
Message-ID: <CAHbLzkoa_YoNUFHoEd41eXDi57XdcKJFT9zH1KJGSMPE7OB5yw@mail.gmail.com>
Subject: Re: [PATCH -V10 1/6] NUMA Balancing: add page promotion counter
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 5:36 PM Huang Ying <ying.huang@intel.com> wrote:
>
> In a system with multiple memory types, e.g. DRAM and PMEM, the CPU
> and DRAM in one socket will be put in one NUMA node as before, while
> the PMEM will be put in another NUMA node as described in the
> description of the commit c221c0b0308f ("device-dax: "Hotplug"
> persistent memory for use like normal RAM").  So, the NUMA balancing
> mechanism will identify all PMEM accesses as remote access and try to
> promote the PMEM pages to DRAM.
>
> To distinguish the number of the inter-type promoted pages from that
> of the inter-socket migrated pages.  A new vmstat count is added.  The
> counter is per-node (count in the target node).  So this can be used
> to identify promotion imbalance among the NUMA nodes.

Reviewed-by: Yang Shi <shy828301@gmail.com>

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
>  mm/migrate.c           | 13 ++++++++++---
>  mm/vmstat.c            |  3 +++
>  4 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 58e744b78c2c..eda6d2f09d77 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -210,6 +210,9 @@ enum node_stat_item {
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
> index bb21fd631b16..81bbf1c0afd3 100644
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
> index cf25b00f03c8..b7c27abb0e5c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2141,6 +2141,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>         pg_data_t *pgdat = NODE_DATA(node);
>         int isolated;
>         int nr_remaining;
> +       int nr_succeeded;
>         LIST_HEAD(migratepages);
>         new_page_t *new;
>         bool compound;
> @@ -2179,7 +2180,8 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>
>         list_add(&page->lru, &migratepages);
>         nr_remaining = migrate_pages(&migratepages, *new, NULL, node,
> -                                    MIGRATE_ASYNC, MR_NUMA_MISPLACED, NULL);
> +                                    MIGRATE_ASYNC, MR_NUMA_MISPLACED,
> +                                    &nr_succeeded);
>         if (nr_remaining) {
>                 if (!list_empty(&migratepages)) {
>                         list_del(&page->lru);
> @@ -2188,8 +2190,13 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>                         putback_lru_page(page);
>                 }
>                 isolated = 0;
> -       } else
> -               count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_pages);
> +       }
> +       if (nr_succeeded) {
> +               count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> +               if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
> +                       mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS,
> +                                           nr_succeeded);
> +       }
>         BUG_ON(!list_empty(&migratepages));
>         return isolated;
>
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index d701c335628c..53a6e92b1efb 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1242,6 +1242,9 @@ const char * const vmstat_text[] = {
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
