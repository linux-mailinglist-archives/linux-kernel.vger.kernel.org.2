Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B77D42E644
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 03:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhJOBuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:50:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:58010 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234738AbhJOBup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:50:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="291313980"
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="291313980"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 18:48:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="481513488"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 18:48:35 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>
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
Subject: Re: [PATCH -V9 1/6] NUMA Balancing: add page promotion counter
References: <20211008083938.1702663-1-ying.huang@intel.com>
        <20211008083938.1702663-2-ying.huang@intel.com>
        <CAHbLzkpJfO185G-Ac0wURkz2=4b+n2Tvnh4BLZeS=X11LpWnwg@mail.gmail.com>
        <87a6jco2f9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAHbLzkpkP1McCqzLuJ8uFbZfB3DNj7EBis6Q+0oS-mg1xYUfHQ@mail.gmail.com>
Date:   Fri, 15 Oct 2021 09:48:33 +0800
In-Reply-To: <CAHbLzkpkP1McCqzLuJ8uFbZfB3DNj7EBis6Q+0oS-mg1xYUfHQ@mail.gmail.com>
        (Yang Shi's message of "Thu, 14 Oct 2021 15:52:10 -0700")
Message-ID: <871r4nnjm6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> On Wed, Oct 13, 2021 at 5:50 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Yang Shi <shy828301@gmail.com> writes:
>>
>> > On Fri, Oct 8, 2021 at 1:40 AM Huang Ying <ying.huang@intel.com> wrote:
>> >>
>> >> In a system with multiple memory types, e.g. DRAM and PMEM, the CPU
>> >> and DRAM in one socket will be put in one NUMA node as before, while
>> >> the PMEM will be put in another NUMA node as described in the
>> >> description of the commit c221c0b0308f ("device-dax: "Hotplug"
>> >> persistent memory for use like normal RAM").  So, the NUMA balancing
>> >> mechanism will identify all PMEM accesses as remote access and try to
>> >> promote the PMEM pages to DRAM.
>> >>
>> >> To distinguish the number of the inter-type promoted pages from that
>> >> of the inter-socket migrated pages.  A new vmstat count is added.  The
>> >> counter is per-node (count in the target node).  So this can be used
>> >> to identify promotion imbalance among the NUMA nodes.
>> >>
>> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> >> Cc: Andrew Morton <akpm@linux-foundation.org>
>> >> Cc: Michal Hocko <mhocko@suse.com>
>> >> Cc: Rik van Riel <riel@surriel.com>
>> >> Cc: Mel Gorman <mgorman@suse.de>
>> >> Cc: Peter Zijlstra <peterz@infradead.org>
>> >> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> >> Cc: Yang Shi <shy828301@gmail.com>
>> >> Cc: Zi Yan <ziy@nvidia.com>
>> >> Cc: Wei Xu <weixugc@google.com>
>> >> Cc: osalvador <osalvador@suse.de>
>> >> Cc: Shakeel Butt <shakeelb@google.com>
>> >> Cc: linux-kernel@vger.kernel.org
>> >> Cc: linux-mm@kvack.org
>> >> ---
>> >>  include/linux/mmzone.h |  3 +++
>> >>  include/linux/node.h   |  5 +++++
>> >>  include/linux/vmstat.h |  2 ++
>> >>  mm/migrate.c           | 10 ++++++++--
>> >>  mm/vmstat.c            |  3 +++
>> >>  5 files changed, 21 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> >> index 6a1d79d84675..37ccd6158765 100644
>> >> --- a/include/linux/mmzone.h
>> >> +++ b/include/linux/mmzone.h
>> >> @@ -209,6 +209,9 @@ enum node_stat_item {
>> >>         NR_PAGETABLE,           /* used for pagetables */
>> >>  #ifdef CONFIG_SWAP
>> >>         NR_SWAPCACHE,
>> >> +#endif
>> >> +#ifdef CONFIG_NUMA_BALANCING
>> >> +       PGPROMOTE_SUCCESS,      /* promote successfully */
>> >>  #endif
>> >>         NR_VM_NODE_STAT_ITEMS
>> >>  };
>> >> diff --git a/include/linux/node.h b/include/linux/node.h
>> >> index 8e5a29897936..26e96fcc66af 100644
>> >> --- a/include/linux/node.h
>> >> +++ b/include/linux/node.h
>> >> @@ -181,4 +181,9 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
>> >>
>> >>  #define to_node(device) container_of(device, struct node, dev)
>> >>
>> >> +static inline bool node_is_toptier(int node)
>> >> +{
>> >> +       return node_state(node, N_CPU);
>> >> +}
>> >> +
>> >>  #endif /* _LINUX_NODE_H_ */
>> >> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
>> >> index d6a6cf53b127..75c53b7d1539 100644
>> >> --- a/include/linux/vmstat.h
>> >> +++ b/include/linux/vmstat.h
>> >> @@ -112,9 +112,11 @@ static inline void vm_events_fold_cpu(int cpu)
>> >>  #ifdef CONFIG_NUMA_BALANCING
>> >>  #define count_vm_numa_event(x)     count_vm_event(x)
>> >>  #define count_vm_numa_events(x, y) count_vm_events(x, y)
>> >> +#define mod_node_balancing_page_state(n, i, v) mod_node_page_state(n, i, v)
>> >
>> > I don't quite get why we need this new API. Doesn't __count_vm_events() work?
>>
>> PGPROMOTE_SUCCESS is a per-node counter. That is, its type is enum
>> node_stat_item instead of enum vm_event_item.  So we need to use
>> mod_node_page_state() instead of count_vm_events().  The new API is to
>> avoid #ifdef CONFIG_NUMA_BALANCING/#endif in caller.
>
> Aha, I see, sorry for overlooking this. But I think you could just
> call mod_node_page_state() since migrate_misplaced_page() has been
> protected by #ifdef CONFIG_NUMA_BALANCING. The !CONFIG_NUMA_BALANCING
> version just returns -EFAULT. Other than this, another nit below.
>

Yes.  You are right.  I will use mod_node_page_state() directly!

>>
>> >>  #else
>> >>  #define count_vm_numa_event(x) do {} while (0)
>> >>  #define count_vm_numa_events(x, y) do { (void)(y); } while (0)
>> >> +#define mod_node_balancing_page_state(n, i, v) do {} while (0)
>> >>  #endif /* CONFIG_NUMA_BALANCING */
>> >>
>> >>  #ifdef CONFIG_DEBUG_TLBFLUSH
>> >> diff --git a/mm/migrate.c b/mm/migrate.c
>> >> index a6a7743ee98f..c3affc587902 100644
>> >> --- a/mm/migrate.c
>> >> +++ b/mm/migrate.c
>> >> @@ -2148,6 +2148,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>> >>         pg_data_t *pgdat = NODE_DATA(node);
>> >>         int isolated;
>> >>         int nr_remaining;
>> >> +       int nr_succeeded;
>> >>         LIST_HEAD(migratepages);
>> >>         new_page_t *new;
>> >>         bool compound;
>> >> @@ -2186,7 +2187,8 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>> >>
>> >>         list_add(&page->lru, &migratepages);
>> >>         nr_remaining = migrate_pages(&migratepages, *new, NULL, node,
>> >> -                                    MIGRATE_ASYNC, MR_NUMA_MISPLACED, NULL);
>> >> +                                    MIGRATE_ASYNC, MR_NUMA_MISPLACED,
>> >> +                                    &nr_succeeded);
>> >>         if (nr_remaining) {
>> >>                 if (!list_empty(&migratepages)) {
>> >>                         list_del(&page->lru);
>> >> @@ -2195,8 +2197,12 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>> >>                         putback_lru_page(page);
>> >>                 }
>> >>                 isolated = 0;
>> >> -       } else
>> >> +       } else {
>> >>                 count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_pages);
>> >> +               if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
>> >> +                       mod_node_balancing_page_state(
>> >> +                               NODE_DATA(node), PGPROMOTE_SUCCESS, nr_succeeded);
>> >> +       }
>
> It looks the original code is already problematic. It just updates the
> counter when *all* pages are migrated successfully. But since we
> already has "nr_succeeded", so I think we could do:
>
> if (nr_remaining) {
>     do_something();
> }
>
> count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
>     mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS, nr_succeeded);

Looks good to me.  Will update this in the next version.

Best Regards,
Huang, Ying


>> >>         BUG_ON(!list_empty(&migratepages));
>> >>         return isolated;
>> >>
>> >> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> >> index 8ce2620344b2..fff0ec94d795 100644
>> >> --- a/mm/vmstat.c
>> >> +++ b/mm/vmstat.c
>> >> @@ -1236,6 +1236,9 @@ const char * const vmstat_text[] = {
>> >>  #ifdef CONFIG_SWAP
>> >>         "nr_swapcached",
>> >>  #endif
>> >> +#ifdef CONFIG_NUMA_BALANCING
>> >> +       "pgpromote_success",
>> >> +#endif
>> >>
>> >>         /* enum writeback_stat_item counters */
>> >>         "nr_dirty_threshold",
>> >> --
>> >> 2.30.2
>> >>
