Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4559F331B7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhCIALc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhCIALL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:11:11 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395CC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 16:11:10 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lr13so24020524ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 16:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mndPuJJOYqbozYSxcIORzE9wZL/Ih//MLSsvGIaSkU=;
        b=fmflyKWNkZUfjNiu08Zp155Mzk9RE6vWgmjT6fHoHXrnZgpACUYwtzepI5PxaUzXwQ
         itF3fg6QmkYQdqOmgIwk4hwGOKylLuEY/J4/+fmJ3bGzalwjFaxkk8XpS5GuPE1pM3T5
         Ffwr7eyuec+Bx8AVY4HVwQtqKy6SiZjBYQ0M5bvkME5BTvifHNq+MCmeYWTS9y6Llt2G
         sGflXE/lJWBVILOtvrTPWZqNcr+6mPO4hUVYDqqz8i0u9bqtkfAeAggcEbhERY+EVys/
         gr/wsdESmjAwyY1RsRe0VJgA+mmsHId7cyJKuAhQ5TeUCBlk5pbG1Dry2jAnNc5OvWS1
         2WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mndPuJJOYqbozYSxcIORzE9wZL/Ih//MLSsvGIaSkU=;
        b=XnzNIgztHXRTATVXSiEh7WQGU8lRFkPbltgssp9DohQxzeJd2lzKxGUqOysQ46+W2p
         a1TwE1L/OBSKY3u0ab0r5XC1lRvnlOa+Iq63JVBWJvXsb8Ssqca22HlTg4tEJ0TdhciO
         rthZ9eQO2+prePAoMnMhxFG7DfI1F7uYT9Zm1hGI6DaJXkk6oAWjvhygKJJZe/WS2YzD
         qQO2f+TuggFwH67c9H+wG3d9erlvNCbYE/WEzwGi5PqE+BHlGy4AGEupwkA0yNTrXgIS
         0Zav3Vdc3UMhvuhPIYlRCIdJ8tuiSyy94bqwhOhycEvr/N9MlToeAJjSrFzbI1LrF+Fb
         2pQw==
X-Gm-Message-State: AOAM532vCX46ujEmlD8aWxKhVknZt4B6gwigLwm1Yb27Ji2HUBO6LjuY
        FNDerFPB9AOuqy1wdx4GJHHzDrT+dOFH28Gs95E=
X-Google-Smtp-Source: ABdhPJygiHqiYAN5VVVYBYjCzAuwwomg63/h3aN5RwFrVh72IGn81UdzGu6Ydx924MMlbLaDRlExOGfB4vy63/iT+O8=
X-Received: by 2002:a17:906:a147:: with SMTP id bu7mr17007122ejb.383.1615248668829;
 Mon, 08 Mar 2021 16:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20210304235949.7922C1C3@viggo.jf.intel.com> <20210304235958.ECFA81E5@viggo.jf.intel.com>
In-Reply-To: <20210304235958.ECFA81E5@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 16:10:57 -0800
Message-ID: <CAHbLzko4_6AW=-5zp1iPKKQ5ts3r51+4Atdu0WCkeEe3vCzLpQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] mm/migrate: demote pages during reclaim
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

On Thu, Mar 4, 2021 at 4:01 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
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
> ---
>
>  b/include/linux/migrate.h        |   13 +++++-
>  b/include/trace/events/migrate.h |    3 -
>  b/mm/vmscan.c                    |   81 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+), 3 deletions(-)
>
> diff -puN include/linux/migrate.h~demote-with-migrate_pages include/linux/migrate.h
> --- a/include/linux/migrate.h~demote-with-migrate_pages 2021-03-04 15:35:56.471806429 -0800
> +++ b/include/linux/migrate.h   2021-03-04 15:35:56.479806429 -0800
> @@ -27,6 +27,7 @@ enum migrate_reason {
>         MR_MEMPOLICY_MBIND,
>         MR_NUMA_MISPLACED,
>         MR_CONTIG_RANGE,
> +       MR_DEMOTION,
>         MR_TYPES
>  };
>
> @@ -58,8 +59,8 @@ extern int migrate_page_move_mapping(str
>
>  static inline void putback_movable_pages(struct list_head *l) {}
>  static inline int migrate_pages(struct list_head *l, new_page_t new,
> -               unsigned long private, enum migrate_mode mode, int reason,
> -               unsigned int *nr_succeeded)
> +               free_page_t free, unsigned long private, enum migrate_mode mode,
> +               int reason, unsigned int *nr_succeeded)
>         { return -ENOSYS; }
>  static inline struct page *alloc_migration_target(struct page *page,
>                 unsigned long private)
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
> --- a/include/trace/events/migrate.h~demote-with-migrate_pages  2021-03-04 15:35:56.473806429 -0800
> +++ b/include/trace/events/migrate.h    2021-03-04 15:35:56.479806429 -0800
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
> --- a/mm/vmscan.c~demote-with-migrate_pages     2021-03-04 15:35:56.475806429 -0800
> +++ b/mm/vmscan.c       2021-03-04 15:35:56.482806429 -0800
> @@ -41,6 +41,7 @@
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
>  #include <linux/memcontrol.h>
> +#include <linux/migrate.h>
>  #include <linux/delayacct.h>
>  #include <linux/sysctl.h>
>  #include <linux/oom.h>
> @@ -1034,6 +1035,23 @@ static enum page_references page_check_r
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
>  /* Check if a page is dirty or under writeback */
>  static void page_check_dirty_writeback(struct page *page,
>                                        bool *dirty, bool *writeback)
> @@ -1064,6 +1082,45 @@ static void page_check_dirty_writeback(s
>                 mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
>  }
>
> +static struct page *alloc_demote_page(struct page *page, unsigned long node)
> +{
> +       struct migration_target_control mtc = {
> +               /*
> +                * Fail the allocation quickly and quietly.  When this
> +                * happens, 'page; will likely just be discarded instead
> +                * of migrated.
> +                */
> +               .gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_NORETRY | __GFP_NOWARN,
> +               .nid = node

I recall I pointed out __GFP_THISNODE should be needed to guarantee
the allocation doesn't fallback. But it seems it is not solved yet or
it is guaranteed by the other way?

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
> @@ -1075,12 +1132,15 @@ static unsigned int shrink_page_list(str
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
> @@ -1230,6 +1290,16 @@ static unsigned int shrink_page_list(str
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
> +               /* Pages which failed to demoted go back on @page_list for retry: */
> +               list_splice_init(&demote_pages, page_list);
> +               do_demote_pass = false;
> +               goto retry;
> +       }
>
>         pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
>
> _
>
