Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FAB3B4B79
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 02:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFZAYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 20:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFZAYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 20:24:13 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0159C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 17:21:51 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a11so11322749ilf.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FexPTJAXmVOLFTUUDErwm13SfJ4gYBZiX3PTNyQHySA=;
        b=ZjlrepTBA5dF0/huE1OtVBc8xjl84O+dHOupI5JRw74PUcMZvliaKjtMMNCa2aIZDC
         UA0rH2bJD9fEp+E03T/aBykZUy+pRNSGmXH9JqSiM2CHIudaItoKlbY7KGqYWfoEs8n9
         iNmOSWqXwzoSbrXrly53luyOe/s70XSp/ZjzbT1MJZXbeCg49xxcot4A1Dw959cpSZGe
         zMeIhWDO9ljW2xh13UgGAIYolNQ+SQtnRvg9Xwk2zwMMmUw4ejOs8rTLLyvSnqOgPy0c
         fDv0vNFwfW+EMGiPEnDu/RpRzNkTDLp4evJ9Bq6T7NFJwfat0Y7RELlOPn6z7iRWlh6b
         HZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FexPTJAXmVOLFTUUDErwm13SfJ4gYBZiX3PTNyQHySA=;
        b=JbjJs43c+OkRigg/FoeExMmlCT4Sd2wYJ6A9fa6WBy5FDeUojSHiIGY6SFNwvM6+W3
         l6UqA5XVTlnVxP9azHXrBuV6QTLOnTNDcrKtjxHBWygtm4+g70GQBiTqaQa+9QkU3yM3
         WguZLcpQVrJ6Wld4qZHp1i/HmtUq0lFiL30Z/oxTV7nSkwabbY/0tuZEPcOvnz09IJap
         IWk61eLZi21j/ckw2JpaqYwzL3KrnBWPn4Sgh7730nP6oseyTPxmJ1BtQYLaFXtcuq2b
         dTvZDEiXvwilGyXcbFWX3bnbh68FvYNMBuCyH4yy/Q78S08yE1LEJIp8dx5eIApoS2u9
         3fOA==
X-Gm-Message-State: AOAM532knWslxfin3TmOpDmhaXVBF6JPKHT1LGyZDN8eYTKerr5NhcFn
        TBG5YJ3KgSMf9QW4DqlJsCAsvGvr9MBPwoqzWbZPeQ==
X-Google-Smtp-Source: ABdhPJy+5BXiSrdIt1yeun2S1r5wlZ7iB/7NF6TDYn41n9012gVHaEtv8/9tGUyjX8eQpQ+otS1Y4PBH2i9CbVLo4sE=
X-Received: by 2002:a92:290f:: with SMTP id l15mr9328392ilg.220.1624666910978;
 Fri, 25 Jun 2021 17:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210625073204.1005986-1-ying.huang@intel.com> <20210625073204.1005986-5-ying.huang@intel.com>
In-Reply-To: <20210625073204.1005986-5-ying.huang@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 25 Jun 2021 17:21:40 -0700
Message-ID: <CAAPL-u_wnxWTedy7hZe0mtkHXo2jWihnZ_z+MD_XvLHQ+84w2w@mail.gmail.com>
Subject: Re: [PATCH -V9 4/9] mm/migrate: demote pages during reclaim
To:     Huang Ying <ying.huang@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 12:33 AM Huang Ying <ying.huang@intel.com> wrote:
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> This is mostly derived from a patch from Yang Shi:
>
>         https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com/
>
> Add code to the reclaim path (shrink_page_list()) to "demote" data
> to another NUMA node instead of discarding the data.  This always
> avoids the cost of I/O needed to read the page back in and sometimes
> avoids the writeout cost when the page is dirty.
>
> A second pass through shrink_page_list() will be made if any demotions
> fail.  This essentially falls back to normal reclaim behavior in the
> case that demotions fail.  Previous versions of this patch may have
> simply failed to reclaim pages which were eligible for demotion but
> were unable to be demoted in practice.
>
> For some cases, for example, MADV_PAGEOUT, the pages are always
> discarded instead of demoted to follow the kernel API definition.
> Because MADV_PAGEOUT is defined as freeing specified pages regardless
> in which tier they are.
>
> Note: This just adds the start of infrastructure for migration. It is
> actually disabled next to the FIXME in migrate_demote_page_ok().
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Reviewed-by: Wei Xu <weixugc@google.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
>
> --
> changes from 20210618:
>  * Fix some typos in comments and patch description.
>  * Fix MADV_PAGEOUT behavior per Zi's comments.
>
> changes from 20210122:
>  * move from GFP_HIGHUSER -> GFP_HIGHUSER_MOVABLE (Ying)
>
> changes from 202010:
>  * add MR_NUMA_MISPLACED to trace MIGRATE_REASON define
>  * make migrate_demote_page_ok() static, remove 'sc' arg until
>    later patch
>  * remove unnecessary alloc_demote_page() hugetlb warning
>  * Simplify alloc_demote_page() gfp mask.  Depend on
>    __GFP_NORETRY to make it lightweight instead of fancier
>    stuff like leaving out __GFP_IO/FS.
>  * Allocate migration page with alloc_migration_target()
>    instead of allocating directly.
> changes from 20200730:
>  * Add another pass through shrink_page_list() when demotion
>    fails.
> changes from 20210302:
>  * Use __GFP_THISNODE and revise the comment explaining the
>    GFP mask constructionn
> ---
>  include/linux/migrate.h        |  9 ++++
>  include/trace/events/migrate.h |  3 +-
>  mm/vmscan.c                    | 93 ++++++++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 166dc1fe4eee..d678e02a27ff 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -28,6 +28,7 @@ enum migrate_reason {
>         MR_NUMA_MISPLACED,
>         MR_CONTIG_RANGE,
>         MR_LONGTERM_PIN,
> +       MR_DEMOTION,
>         MR_TYPES
>  };
>
> @@ -191,6 +192,14 @@ struct migrate_vma {
>  int migrate_vma_setup(struct migrate_vma *args);
>  void migrate_vma_pages(struct migrate_vma *migrate);
>  void migrate_vma_finalize(struct migrate_vma *migrate);
> +int next_demotion_node(int node);
> +
> +#else /* CONFIG_MIGRATION disabled: */
> +
> +static inline int next_demotion_node(int node)
> +{
> +       return NUMA_NO_NODE;
> +}
>
>  #endif /* CONFIG_MIGRATION */
>
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 9fb2a3bbcdfb..779f3fad9ecd 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -21,7 +21,8 @@
>         EM( MR_MEMPOLICY_MBIND, "mempolicy_mbind")              \
>         EM( MR_NUMA_MISPLACED,  "numa_misplaced")               \
>         EM( MR_CONTIG_RANGE,    "contig_range")                 \
> -       EMe(MR_LONGTERM_PIN,    "longterm_pin")
> +       EM( MR_LONGTERM_PIN,    "longterm_pin")                 \
> +       EMe(MR_DEMOTION,        "demotion")
>
>  /*
>   * First define the enums in the above macros to be exported to userspace
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5199b9696bab..badaf3d4360d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -41,6 +41,7 @@
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
>  #include <linux/memcontrol.h>
> +#include <linux/migrate.h>
>  #include <linux/delayacct.h>
>  #include <linux/sysctl.h>
>  #include <linux/oom.h>
> @@ -118,6 +119,9 @@ struct scan_control {
>         /* The file pages on the current node are dangerously low */
>         unsigned int file_is_tiny:1;
>
> +       /* Always discard instead of demoting to lower tier memory */
> +       unsigned int no_demotion:1;
> +
>         /* Allocation order */
>         s8 order;
>
> @@ -1231,6 +1235,27 @@ static enum page_references page_check_references(struct page *page,
>         return PAGEREF_RECLAIM;
>  }
>
> +static bool migrate_demote_page_ok(struct page *page,
> +                                  struct scan_control *sc)
> +{
> +       int next_nid;
> +
> +       VM_BUG_ON_PAGE(!PageLocked(page), page);
> +       VM_BUG_ON_PAGE(PageHuge(page), page);
> +       VM_BUG_ON_PAGE(PageLRU(page), page);
> +
> +       if (sc->no_demotion)
> +               return false;
> +       next_nid = next_demotion_node(page_to_nid(page));
> +       if (next_nid == NUMA_NO_NODE)
> +               return false;

The above sc and node checks are not specific to the page.  They can
be moved into shrink_page_list() to set do_demote_pass accordingly.
We then don't need to repeat these checks for every page.

> +       if (PageTransHuge(page) && !thp_migration_supported())
> +               return false;
> +
> +       // FIXME: actually enable this later in the series
> +       return false;
> +}
> +
>  /* Check if a page is dirty or under writeback */
>  static void page_check_dirty_writeback(struct page *page,
>                                        bool *dirty, bool *writeback)
> @@ -1261,6 +1286,49 @@ static void page_check_dirty_writeback(struct page *page,
>                 mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
>  }
>
> +static struct page *alloc_demote_page(struct page *page, unsigned long node)
> +{
> +       struct migration_target_control mtc = {
> +               /*
> +                * Allocate from 'node', or fail quickly and quietly.
> +                * When this happens, 'page' will likely just be discarded
> +                * instead of migrated.
> +                */
> +               .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> +                           __GFP_THISNODE  | __GFP_NOWARN |
> +                           __GFP_NOMEMALLOC | GFP_NOWAIT,
> +               .nid = node
> +       };
> +
> +       return alloc_migration_target(page, (unsigned long)&mtc);
> +}
> +
> +/*
> + * Take pages on @demote_list and attempt to demote them to
> + * another node.  Pages which are not demoted are left on
> + * @demote_pages.
> + */
> +static unsigned int demote_page_list(struct list_head *demote_pages,
> +                                    struct pglist_data *pgdat)
> +{
> +       int target_nid = next_demotion_node(pgdat->node_id);
> +       unsigned int nr_succeeded;
> +       int err;
> +
> +       if (list_empty(demote_pages))
> +               return 0;
> +
> +       if (target_nid == NUMA_NO_NODE)
> +               return 0;
> +
> +       /* Demotion ignores all cpuset and mempolicy settings */
> +       err = migrate_pages(demote_pages, alloc_demote_page, NULL,
> +                           target_nid, MIGRATE_ASYNC, MR_DEMOTION,
> +                           &nr_succeeded);
> +
> +       return nr_succeeded;
> +}
> +
>  /*
>   * shrink_page_list() returns the number of reclaimed pages
>   */
> @@ -1272,12 +1340,15 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  {
>         LIST_HEAD(ret_pages);
>         LIST_HEAD(free_pages);
> +       LIST_HEAD(demote_pages);
>         unsigned int nr_reclaimed = 0;
>         unsigned int pgactivate = 0;
> +       bool do_demote_pass = true;
>
>         memset(stat, 0, sizeof(*stat));
>         cond_resched();
>
> +retry:
>         while (!list_empty(page_list)) {
>                 struct address_space *mapping;
>                 struct page *page;
> @@ -1426,6 +1497,16 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>                         ; /* try to reclaim the page below */
>                 }
>
> +               /*
> +                * Before reclaiming the page, try to relocate
> +                * its contents to another node.
> +                */
> +               if (do_demote_pass && migrate_demote_page_ok(page, sc)) {
> +                       list_add(&page->lru, &demote_pages);
> +                       unlock_page(page);
> +                       continue;
> +               }
> +
>                 /*
>                  * Anonymous process memory has backing store?
>                  * Try to allocate it some swap space here.
> @@ -1676,6 +1757,17 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>                 list_add(&page->lru, &ret_pages);
>                 VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
>         }
> +       /* 'page_list' is always empty here */
> +
> +       /* Migrate pages selected for demotion */
> +       nr_reclaimed += demote_page_list(&demote_pages, pgdat);
> +       /* Pages that could not be demoted are still in @demote_pages */
> +       if (!list_empty(&demote_pages)) {
> +               /* Pages which failed to demoted go back on @page_list for retry: */
> +               list_splice_init(&demote_pages, page_list);
> +               do_demote_pass = false;
> +               goto retry;
> +       }
>
>         pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
>
> @@ -2312,6 +2404,7 @@ unsigned long reclaim_pages(struct list_head *page_list)
>                 .may_writepage = 1,
>                 .may_unmap = 1,
>                 .may_swap = 1,
> +               .no_demotion = 1,
>         };
>
>         while (!list_empty(page_list)) {
> --
> 2.30.2
>
