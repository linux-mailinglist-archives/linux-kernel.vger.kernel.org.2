Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49AB30C9B0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbhBBSZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbhBBSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:23:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42233C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 10:23:07 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id df22so8070465edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 10:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c22PgLZFbY4qGktGzr/nGZ2GejV48wZf+CIJ8/Deskw=;
        b=dQg2l4G2jTK1mnKF3sFcBvXqkAF1gn/ndYtTfSeGp/TtMpLQ67Az/CMzydUs34TNOn
         wcPnbzTneNDYCuQ0KXTLPamuGebKbZSVWRAQbT1sGJLq1ahfBmYxaQx6MOEjhX0XcvZT
         hEMwrspFgxrsIOAhnZfqYYuT3zR5jq2EdmnpSTkb+uN34u786YGRDQbCCji/46qki+0w
         aG6SGeDoyEKJO+IoniRani9rU5TdEY2YKuC1pnpUmokcoOoxwMZ56v1mJ/ZdlYOmeGfd
         wNke2YrbjDXcOj87JleGK5ieP24QnVt9YoAFsPNJG/2+ksv8uytOzHZ3VvEGlJ3y7Cx7
         +cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c22PgLZFbY4qGktGzr/nGZ2GejV48wZf+CIJ8/Deskw=;
        b=RpWJszWOfCgKm0pwQWZBvx1tvWG0Zq0CiOIdN8nYyddcLPokX3mwPZQKIw7TcUaOby
         AXM0sCS8k6jpFI1DLWSOyfsO5/Fq9csoejlXgpUmzm5V6qTLN+QFYgUCC3SWCP1bd+yv
         JnX4kYTDstShW0uhr4oa5UX+dY0ZpM6Vg8D4KHZCklmll1QB+sbJHPjq9346zKTNomSU
         /McvWUJow03i8s9PH7bpAarob8WGZs1gwkb6H4D+b/I4SSVfaS+s2RnF9+WRGwq1Dehv
         8IzXoCDC66JZjcMel2hwlAqRXOygLOY0wFogCfecZUPeqLqp1ahjFJPvvAawtAVNgcAX
         a7Jw==
X-Gm-Message-State: AOAM5338BuxGv5EfebxVz+uHc/1SKnW1Z4RnPQ84k1AUbVbu5Q651OAT
        AxKTVAjs95D4QMzfQRXo6y83KT+vG/D6/hW8+6I=
X-Google-Smtp-Source: ABdhPJzMSvtPevXyhMdbLX7xDi3yA7nnJrvoElRq08dU5LagKHZuBbxyan+G9Uq53Lb5GcqvL/+FvioVioB/0PNMDsQ=
X-Received: by 2002:aa7:c7c8:: with SMTP id o8mr226408eds.137.1612290185867;
 Tue, 02 Feb 2021 10:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20210126003411.2AC51464@viggo.jf.intel.com> <20210126003427.73DFDD34@viggo.jf.intel.com>
In-Reply-To: <20210126003427.73DFDD34@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 2 Feb 2021 10:22:54 -0800
Message-ID: <CAHbLzkrU0MFSHruHw4Noho39DJrB2pDhzd8aJrBnDsVjyDmLGg@mail.gmail.com>
Subject: Re: [RFC][PATCH 08/13] mm/migrate: demote pages during reclaim
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 4:41 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
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
> avoids the writeout cost when the pagee is dirty.
>
> A second pass through shrink_page_list() will be made if any demotions
> fail.  This essentally falls back to normal reclaim behavior in the
> case that demotions fail.  Previous versions of this patch may have
> simply failed to reclaim pages which were eligible for demotion but
> were unable to be demoted in practice.
>
> Note: This just adds the start of infratructure for migration. It is
> actually disabled next to the FIXME in migrate_demote_page_ok().
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: osalvador <osalvador@suse.de>
>
> --
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
> ---
>
>  b/include/linux/migrate.h        |    9 ++++
>  b/include/trace/events/migrate.h |    3 -
>  b/mm/vmscan.c                    |   81 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+), 1 deletion(-)
>
> diff -puN include/linux/migrate.h~demote-with-migrate_pages include/linux/migrate.h
> --- a/include/linux/migrate.h~demote-with-migrate_pages 2021-01-25 16:23:14.591866696 -0800
> +++ b/include/linux/migrate.h   2021-01-25 16:23:14.599866696 -0800
> @@ -27,6 +27,7 @@ enum migrate_reason {
>         MR_MEMPOLICY_MBIND,
>         MR_NUMA_MISPLACED,
>         MR_CONTIG_RANGE,
> +       MR_DEMOTION,
>         MR_TYPES
>  };
>
> @@ -196,6 +197,14 @@ struct migrate_vma {
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
> diff -puN include/trace/events/migrate.h~demote-with-migrate_pages include/trace/events/migrate.h
> --- a/include/trace/events/migrate.h~demote-with-migrate_pages  2021-01-25 16:23:14.593866696 -0800
> +++ b/include/trace/events/migrate.h    2021-01-25 16:23:14.599866696 -0800
> @@ -20,7 +20,8 @@
>         EM( MR_SYSCALL,         "syscall_or_cpuset")            \
>         EM( MR_MEMPOLICY_MBIND, "mempolicy_mbind")              \
>         EM( MR_NUMA_MISPLACED,  "numa_misplaced")               \
> -       EMe(MR_CONTIG_RANGE,    "contig_range")
> +       EM( MR_CONTIG_RANGE,    "contig_range")                 \
> +       EMe(MR_DEMOTION,        "demotion")
>
>  /*
>   * First define the enums in the above macros to be exported to userspace
> diff -puN mm/vmscan.c~demote-with-migrate_pages mm/vmscan.c
> --- a/mm/vmscan.c~demote-with-migrate_pages     2021-01-25 16:23:14.595866696 -0800
> +++ b/mm/vmscan.c       2021-01-25 16:23:14.601866696 -0800
> @@ -43,6 +43,7 @@
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
>  #include <linux/memcontrol.h>
> +#include <linux/migrate.h>
>  #include <linux/delayacct.h>
>  #include <linux/sysctl.h>
>  #include <linux/oom.h>
> @@ -1036,6 +1037,24 @@ static enum page_references page_check_r
>         return PAGEREF_RECLAIM;
>  }
>
> +static bool migrate_demote_page_ok(struct page *page)
> +{
> +       int next_nid = next_demotion_node(page_to_nid(page));
> +
> +       VM_BUG_ON_PAGE(!PageLocked(page), page);
> +       VM_BUG_ON_PAGE(PageHuge(page), page);
> +       VM_BUG_ON_PAGE(PageLRU(page), page);
> +
> +       if (next_nid == NUMA_NO_NODE)
> +               return false;
> +       if (PageTransHuge(page) && !thp_migration_supported())
> +               return false;
> +
> +       // FIXME: actually enable this later in the series
> +       return false;
> +}
> +
> +
>  /* Check if a page is dirty or under writeback */
>  static void page_check_dirty_writeback(struct page *page,
>                                        bool *dirty, bool *writeback)
> @@ -1066,6 +1085,44 @@ static void page_check_dirty_writeback(s
>                 mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
>  }
>
> +static struct page *alloc_demote_page(struct page *page, unsigned long node)
> +{
> +        struct migration_target_control mtc = {
> +               /*
> +                * Fail quickly and quietly.  Page will likely
> +                * just be discarded instead of migrated.
> +                */
> +               .gfp_mask = GFP_HIGHUSER | __GFP_NORETRY | __GFP_NOWARN,
> +               .nid = node
> +       };
> +
> +        return alloc_migration_target(page, (unsigned long)&mtc);

Other than the gfp flag question raised by Oscar, I'm wondering how we
guarantee the demotion allocation happens on the designated node. In
the previous version __GFP_THISNODE is set to guarantee this. In this
version you switched to use alloc_migration_target() API but without
having nodemask or __GFP_THISNODE. If nodemask is NULL the allocation
may fall back to an unexpected node.

And GFP_HIGHUSER does respect cpuset, so if the demotion target node
is excluded by the cpuset which the task belongs to, the migration
would fail. This might be a way to respect cpuset, but it should just
work for direct reclaimer. So, is this change really expected?

> +}
> +
> +/*
> + * Take pages on @demote_list and attempt to demote them to
> + * another node.  Pages which are not demoted are left on
> + * @demote_pages.
> + */
> +static unsigned int demote_page_list(struct list_head *demote_pages,
> +                                    struct pglist_data *pgdat,
> +                                    struct scan_control *sc)
> +{
> +       int target_nid = next_demotion_node(pgdat->node_id);
> +       unsigned int nr_succeeded = 0;
> +       int err;
> +
> +       if (list_empty(demote_pages))
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
> @@ -1078,12 +1135,15 @@ static unsigned int shrink_page_list(str
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
> @@ -1233,6 +1293,16 @@ static unsigned int shrink_page_list(str
>                 }
>
>                 /*
> +                * Before reclaiming the page, try to relocate
> +                * its contents to another node.
> +                */
> +               if (do_demote_pass && migrate_demote_page_ok(page)) {
> +                       list_add(&page->lru, &demote_pages);
> +                       unlock_page(page);
> +                       continue;
> +               }
> +
> +               /*
>                  * Anonymous process memory has backing store?
>                  * Try to allocate it some swap space here.
>                  * Lazyfree page could be freed directly
> @@ -1479,6 +1549,17 @@ keep:
>                 list_add(&page->lru, &ret_pages);
>                 VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
>         }
> +       /* 'page_list' is always empty here */
> +
> +       /* Migrate pages selected for demotion */
> +       nr_reclaimed += demote_page_list(&demote_pages, pgdat, sc);
> +       /* Pages that could not be demoted are still in @demote_pages */
> +       if (!list_empty(&demote_pages)) {
> +               /* Pages which failed to demoted go back on on @page_list for retry: */
> +               list_splice_init(&demote_pages, page_list);
> +               do_demote_pass = false;
> +               goto retry;
> +       }
>
>         pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
>
> _
>
