Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7C542CD21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhJMV4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhJMV4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:56:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A920BC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:54:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z20so16032147edc.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NR5UsFP3dYqPNqjHTBBDDTVrGmVsspEdSRSWs3/jlLw=;
        b=BfNHxSB8hxObjp1bMQsBmrGB9gJ7uInlW5FrzpgmA/m7zJl9PFcPC37W4psmH79eGK
         gSLAud7DlfrAL1n4Ol2KAmBkZghWwQczH30prCvWsAPQGNk0wbDkG7bVnFQtO6QbXDtK
         nGktlLcBigmWDUO6TDBynu4ONl/OBYAQGfk7IRqv1sCHl9locvaMAgQhxflAcPJlFEjB
         d/q+j/qdRZheDTAegWYsLf8YVJkw2IT0vibeRG1EaEBFqgB9e5GazN8eUUz/YO8DHF5O
         qDkrTZ6wm3dSKO2iS3IcNf46f8ADO6WGqioM0eWdwKjluOqNTWjyL2KeywjbBRArY6Yu
         UMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NR5UsFP3dYqPNqjHTBBDDTVrGmVsspEdSRSWs3/jlLw=;
        b=UPkGYa2OcxWQCno0duKkIgJ8+ZueO0JGSc4eS6hzFBTeop8uki6djGUy20BsO4SJOh
         aWxVDAMDXblsGQS/A3eE8gDSRW9ISmeKO8X5H9Sg/lnBbQkhopCMRaU5JhZW3tzy5CcB
         BWDWrjaeogfgK9TG6tNIsoYdgA3I+wQXlaUBzDBB/5w1RDurfCl48Vpl66CZXTuSnPjL
         4j8it0eZZoza3oNw/1OQCElF5jBaV1PBl1GtfS/duX0Dd+RZ+pmzDX0DWLcSTwlPIDt3
         KRbQK7C/RaAAI/qvBM0QoI5xdMffu0XuR5dGhstYYeTocHCmmwyIovC/PDPOGJMx5eZy
         JEOg==
X-Gm-Message-State: AOAM530Gvc04BwJ6hhtln1OjEtg26t8TEh5sFQXvABYAqrQh3EYaT/JR
        7OPQhYE/PWsJ9odGWdkiU43l/2rP/wYg0ktBNSw=
X-Google-Smtp-Source: ABdhPJxLKr3XQdGM0E1jJ29PHetPNXpbY/Po16bUBCZNXQ/lC/+9js9YegWX28iqKLeO4yHUOgXXcYjkvzZLRmSyxUs=
X-Received: by 2002:a17:906:a94b:: with SMTP id hh11mr2133127ejb.85.1634162067267;
 Wed, 13 Oct 2021 14:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211008083938.1702663-1-ying.huang@intel.com> <20211008083938.1702663-2-ying.huang@intel.com>
In-Reply-To: <20211008083938.1702663-2-ying.huang@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 13 Oct 2021 14:54:15 -0700
Message-ID: <CAHbLzkpJfO185G-Ac0wURkz2=4b+n2Tvnh4BLZeS=X11LpWnwg@mail.gmail.com>
Subject: Re: [PATCH -V9 1/6] NUMA Balancing: add page promotion counter
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

On Fri, Oct 8, 2021 at 1:40 AM Huang Ying <ying.huang@intel.com> wrote:
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
>  include/linux/vmstat.h |  2 ++
>  mm/migrate.c           | 10 ++++++++--
>  mm/vmstat.c            |  3 +++
>  5 files changed, 21 insertions(+), 2 deletions(-)
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
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index d6a6cf53b127..75c53b7d1539 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -112,9 +112,11 @@ static inline void vm_events_fold_cpu(int cpu)
>  #ifdef CONFIG_NUMA_BALANCING
>  #define count_vm_numa_event(x)     count_vm_event(x)
>  #define count_vm_numa_events(x, y) count_vm_events(x, y)
> +#define mod_node_balancing_page_state(n, i, v) mod_node_page_state(n, i, v)

I don't quite get why we need this new API. Doesn't __count_vm_events() work?

>  #else
>  #define count_vm_numa_event(x) do {} while (0)
>  #define count_vm_numa_events(x, y) do { (void)(y); } while (0)
> +#define mod_node_balancing_page_state(n, i, v) do {} while (0)
>  #endif /* CONFIG_NUMA_BALANCING */
>
>  #ifdef CONFIG_DEBUG_TLBFLUSH
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a6a7743ee98f..c3affc587902 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2148,6 +2148,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>         pg_data_t *pgdat = NODE_DATA(node);
>         int isolated;
>         int nr_remaining;
> +       int nr_succeeded;
>         LIST_HEAD(migratepages);
>         new_page_t *new;
>         bool compound;
> @@ -2186,7 +2187,8 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>
>         list_add(&page->lru, &migratepages);
>         nr_remaining = migrate_pages(&migratepages, *new, NULL, node,
> -                                    MIGRATE_ASYNC, MR_NUMA_MISPLACED, NULL);
> +                                    MIGRATE_ASYNC, MR_NUMA_MISPLACED,
> +                                    &nr_succeeded);
>         if (nr_remaining) {
>                 if (!list_empty(&migratepages)) {
>                         list_del(&page->lru);
> @@ -2195,8 +2197,12 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>                         putback_lru_page(page);
>                 }
>                 isolated = 0;
> -       } else
> +       } else {
>                 count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_pages);
> +               if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
> +                       mod_node_balancing_page_state(
> +                               NODE_DATA(node), PGPROMOTE_SUCCESS, nr_succeeded);
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
