Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D49E308EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 22:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhA2VFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 16:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbhA2VFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 16:05:12 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262EC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:04:31 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id dj23so12112551edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lh5my+gT8bP2YkLQKgXj2GpUJK/R0RWpyBBjF9Hhr00=;
        b=YAciALlW0hKufzhc1KYVd7zsJNFMpsviGWt77W9m5VFWsVPAdolQlTN38+xc37h+AT
         Si+dDlBG3+1Yz3Z6mFjHqMPGat67fPQNCc5R+GgWJ+nLvB/yo0a5wRW2nHI+HxKEBcSg
         HCgYpHYtmzsrBf1M4fYLmNFtyAJbLze7rZF95HfLqve1oaMk9CdMW62slslYsojFe1tL
         oBQxStUxaCXZjPyM7dFxN5a6n5w3XP0ibWobDATWvi6nzL9oohb3Y8Jw4luk3V0pxkhz
         4XGK9asrGbuOS/sEqQDvnOvcR34qIo4lcRO73fQcRugebXjG/r2szOVGsmtsJ7v9dw1n
         iR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lh5my+gT8bP2YkLQKgXj2GpUJK/R0RWpyBBjF9Hhr00=;
        b=Y1Ss6IxlncVmibMddRc+U38iF7ObbTSQ/jQFbwfBiJOMo4csn5sgQQSnf/SF3Cuk8x
         vjfaCK+Wsh5RfqpedgxHr8bJDZH0xTAW2nzyqZb1pz3cGXnTfE003paJvst01Ufs1sKW
         oGRcPZ7CzAid1g85aZewDCafVvj80NFz+gkSnzVL73kLzM6h3+2PmR15QOcOriMwSWSV
         FkArIFKsV9QrHRw3gFyMu93yZoNcE80/lzO417Jz+r6VtNDOK36xmn/EVWWXuEuL8hsv
         HuXlqad8Xy2brWazFAn2o3rtv39wax5xoppkp4POy4I9fYaeWijSiHMGbdX/l+2Ql0b+
         WoYA==
X-Gm-Message-State: AOAM531scfy9vhR7HWo2xPvpulD33uzgDrdg7vhAodzD652hjkC4IZAL
        8zRQY4KotnL4gyMEeHgmeoH3gd9HcAvCeVS24Mc=
X-Google-Smtp-Source: ABdhPJzu7FA7nFYFn1wG8GtAXTb2JI4OxoAW85RC0SMcnAsHoRGkxP31Gh8lG8ufMTS8vCc0h+m6kgYDr4POQ/A8hpU=
X-Received: by 2002:a50:8757:: with SMTP id 23mr7359971edv.294.1611954270266;
 Fri, 29 Jan 2021 13:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20210126003411.2AC51464@viggo.jf.intel.com> <20210126003425.038B4812@viggo.jf.intel.com>
In-Reply-To: <20210126003425.038B4812@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Jan 2021 13:04:18 -0800
Message-ID: <CAHbLzkryZt1Y5C2srwFSG6DzCqPuxT483wHW_3K1wnaHgGb-Ag@mail.gmail.com>
Subject: Re: [RFC][PATCH 07/13] mm/migrate: make migrate_pages() return nr_succeeded
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 4:41 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Yang Shi <yang.shi@linux.alibaba.com>
>
> The migrate_pages() returns the number of pages that were not migrated,
> or an error code.  When returning an error code, there is no way to know
> how many pages were migrated or not migrated.
>
> In the following patch, migrate_pages() is used to demote pages to PMEM
> node, we need account how many pages are reclaimed (demoted) since page
> reclaim behavior depends on this.  Add *nr_succeeded parameter to make
> migrate_pages() return how many pages are demoted successfully for all
> cases.
>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
> ---
>
>  b/include/linux/migrate.h |    5 +++--
>  b/mm/compaction.c         |    3 ++-
>  b/mm/gup.c                |    4 +++-
>  b/mm/memory-failure.c     |    4 +++-
>  b/mm/memory_hotplug.c     |    4 +++-
>  b/mm/mempolicy.c          |    8 ++++++--
>  b/mm/migrate.c            |   17 ++++++++++-------
>  b/mm/page_alloc.c         |    9 ++++++---
>  8 files changed, 36 insertions(+), 18 deletions(-)
>
> diff -puN include/linux/migrate.h~migrate_pages-add-success-return include/linux/migrate.h
> --- a/include/linux/migrate.h~migrate_pages-add-success-return  2021-01-25 16:23:12.931866701 -0800
> +++ b/include/linux/migrate.h   2021-01-25 16:23:12.954866701 -0800
> @@ -40,7 +40,8 @@ extern int migrate_page(struct address_s
>                         struct page *newpage, struct page *page,
>                         enum migrate_mode mode);
>  extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
> -               unsigned long private, enum migrate_mode mode, int reason);
> +               unsigned long private, enum migrate_mode mode, int reason,
> +               unsigned int *nr_succeeded);
>  extern struct page *alloc_migration_target(struct page *page, unsigned long private);
>  extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
>  extern void putback_movable_page(struct page *page);
> @@ -58,7 +59,7 @@ extern int migrate_page_move_mapping(str
>  static inline void putback_movable_pages(struct list_head *l) {}
>  static inline int migrate_pages(struct list_head *l, new_page_t new,
>                 free_page_t free, unsigned long private, enum migrate_mode mode,
> -               int reason)
> +               int reason, unsigned int *nr_succeeded)
>         { return -ENOSYS; }
>  static inline struct page *alloc_migration_target(struct page *page,
>                 unsigned long private)
> diff -puN mm/compaction.c~migrate_pages-add-success-return mm/compaction.c
> --- a/mm/compaction.c~migrate_pages-add-success-return  2021-01-25 16:23:12.933866701 -0800
> +++ b/mm/compaction.c   2021-01-25 16:23:12.956866701 -0800
> @@ -2199,6 +2199,7 @@ compact_zone(struct compact_control *cc,
>         unsigned long last_migrated_pfn;
>         const bool sync = cc->mode != MIGRATE_ASYNC;
>         bool update_cached;
> +       unsigned int nr_succeeded = 0;
>
>         /*
>          * These counters track activities during zone compaction.  Initialize
> @@ -2317,7 +2318,7 @@ compact_zone(struct compact_control *cc,
>
>                 err = migrate_pages(&cc->migratepages, compaction_alloc,
>                                 compaction_free, (unsigned long)cc, cc->mode,
> -                               MR_COMPACTION);
> +                               MR_COMPACTION, &nr_succeeded);
>
>                 trace_mm_compaction_migratepages(cc->nr_migratepages, err,
>                                                         &cc->migratepages);
> diff -puN mm/gup.c~migrate_pages-add-success-return mm/gup.c
> --- a/mm/gup.c~migrate_pages-add-success-return 2021-01-25 16:23:12.935866701 -0800
> +++ b/mm/gup.c  2021-01-25 16:23:12.957866701 -0800
> @@ -1599,6 +1599,7 @@ static long check_and_migrate_cma_pages(
>         unsigned long step;
>         bool drain_allow = true;
>         bool migrate_allow = true;
> +       unsigned int nr_succeeded = 0;
>         LIST_HEAD(cma_page_list);
>         long ret = nr_pages;
>         struct migration_target_control mtc = {
> @@ -1654,7 +1655,8 @@ check_again:
>                                 put_page(pages[i]);
>
>                 if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
> -                       (unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
> +                       (unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE,
> +                                 &nr_succeeded)) {
>                         /*
>                          * some of the pages failed migration. Do get_user_pages
>                          * without migration.
> diff -puN mm/memory-failure.c~migrate_pages-add-success-return mm/memory-failure.c
> --- a/mm/memory-failure.c~migrate_pages-add-success-return      2021-01-25 16:23:12.939866701 -0800
> +++ b/mm/memory-failure.c       2021-01-25 16:23:12.959866701 -0800
> @@ -1783,6 +1783,7 @@ static int __soft_offline_page(struct pa
>         unsigned long pfn = page_to_pfn(page);
>         struct page *hpage = compound_head(page);
>         char const *msg_page[] = {"page", "hugepage"};
> +       unsigned int nr_succeeded = 0;
>         bool huge = PageHuge(page);
>         LIST_HEAD(pagelist);
>         struct migration_target_control mtc = {
> @@ -1826,7 +1827,8 @@ static int __soft_offline_page(struct pa
>
>         if (isolate_page(hpage, &pagelist)) {
>                 ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
> -                       (unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
> +                       (unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE,
> +                       &nr_succeeded);
>                 if (!ret) {
>                         bool release = !huge;
>
> diff -puN mm/memory_hotplug.c~migrate_pages-add-success-return mm/memory_hotplug.c
> --- a/mm/memory_hotplug.c~migrate_pages-add-success-return      2021-01-25 16:23:12.941866701 -0800
> +++ b/mm/memory_hotplug.c       2021-01-25 16:23:12.959866701 -0800
> @@ -1278,6 +1278,7 @@ do_migrate_range(unsigned long start_pfn
>         unsigned long pfn;
>         struct page *page, *head;
>         int ret = 0;
> +       unsigned int nr_succeeded = 0;
>         LIST_HEAD(source);
>
>         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> @@ -1352,7 +1353,8 @@ do_migrate_range(unsigned long start_pfn
>                 if (nodes_empty(nmask))
>                         node_set(mtc.nid, nmask);
>                 ret = migrate_pages(&source, alloc_migration_target, NULL,
> -                       (unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
> +                       (unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG,
> +                       &nr_succeeded);
>                 if (ret) {
>                         list_for_each_entry(page, &source, lru) {
>                                 pr_warn("migrating pfn %lx failed ret:%d ",
> diff -puN mm/mempolicy.c~migrate_pages-add-success-return mm/mempolicy.c
> --- a/mm/mempolicy.c~migrate_pages-add-success-return   2021-01-25 16:23:12.944866701 -0800
> +++ b/mm/mempolicy.c    2021-01-25 16:23:12.960866701 -0800
> @@ -1071,6 +1071,7 @@ static int migrate_page_add(struct page
>  static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>                            int flags)
>  {
> +       unsigned int nr_succeeded = 0;
>         nodemask_t nmask;
>         LIST_HEAD(pagelist);
>         int err = 0;
> @@ -1093,7 +1094,8 @@ static int migrate_to_node(struct mm_str
>
>         if (!list_empty(&pagelist)) {
>                 err = migrate_pages(&pagelist, alloc_migration_target, NULL,
> -                               (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
> +                               (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
> +                               &nr_succeeded);
>                 if (err)
>                         putback_movable_pages(&pagelist);
>         }
> @@ -1270,6 +1272,7 @@ static long do_mbind(unsigned long start
>                      nodemask_t *nmask, unsigned long flags)
>  {
>         struct mm_struct *mm = current->mm;
> +       unsigned int nr_succeeded = 0;
>         struct mempolicy *new;
>         unsigned long end;
>         int err;
> @@ -1349,7 +1352,8 @@ static long do_mbind(unsigned long start
>                 if (!list_empty(&pagelist)) {
>                         WARN_ON_ONCE(flags & MPOL_MF_LAZY);
>                         nr_failed = migrate_pages(&pagelist, new_page, NULL,
> -                               start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
> +                               start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND,
> +                               &nr_succeeded);
>                         if (nr_failed)
>                                 putback_movable_pages(&pagelist);
>                 }
> diff -puN mm/migrate.c~migrate_pages-add-success-return mm/migrate.c
> --- a/mm/migrate.c~migrate_pages-add-success-return     2021-01-25 16:23:12.947866701 -0800
> +++ b/mm/migrate.c      2021-01-25 16:23:12.964866701 -0800
> @@ -1432,6 +1432,7 @@ out:
>   * @mode:              The migration mode that specifies the constraints for
>   *                     page migration, if any.
>   * @reason:            The reason for page migration.
> + * @nr_succeeded:      The number of pages migrated successfully.
>   *
>   * The function returns after 10 attempts or if no pages are movable any more
>   * because the list has become empty or no retryable pages exist any more.
> @@ -1442,12 +1443,11 @@ out:
>   */
>  int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                 free_page_t put_new_page, unsigned long private,
> -               enum migrate_mode mode, int reason)
> +               enum migrate_mode mode, int reason, unsigned int *nr_succeeded)
>  {
>         int retry = 1;
>         int thp_retry = 1;
>         int nr_failed = 0;
> -       int nr_succeeded = 0;
>         int nr_thp_succeeded = 0;
>         int nr_thp_failed = 0;
>         int nr_thp_split = 0;
> @@ -1527,7 +1527,7 @@ retry:
>                                         nr_succeeded += nr_subpages;

It seems the above line is missed. The THP accounting change was
merged in v5.9 before I submitted this patch.

>                                         break;
>                                 }
> -                               nr_succeeded++;
> +                               (*nr_succeeded)++;
>                                 break;
>                         default:
>                                 /*
> @@ -1550,12 +1550,12 @@ retry:
>         nr_thp_failed += thp_retry;
>         rc = nr_failed;
>  out:
> -       count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> +       count_vm_events(PGMIGRATE_SUCCESS, *nr_succeeded);
>         count_vm_events(PGMIGRATE_FAIL, nr_failed);
>         count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>         count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>         count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
> -       trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
> +       trace_mm_migrate_pages(*nr_succeeded, nr_failed, nr_thp_succeeded,
>                                nr_thp_failed, nr_thp_split, mode, reason);
>
>         if (!swapwrite)
> @@ -1623,6 +1623,7 @@ static int store_status(int __user *stat
>  static int do_move_pages_to_node(struct mm_struct *mm,
>                 struct list_head *pagelist, int node)
>  {
> +       unsigned int nr_succeeded = 0;
>         int err;
>         struct migration_target_control mtc = {
>                 .nid = node,
> @@ -1630,7 +1631,8 @@ static int do_move_pages_to_node(struct
>         };
>
>         err = migrate_pages(pagelist, alloc_migration_target, NULL,
> -                       (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
> +                       (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
> +                       &nr_succeeded);
>         if (err)
>                 putback_movable_pages(pagelist);
>         return err;
> @@ -2103,6 +2105,7 @@ int migrate_misplaced_page(struct page *
>         pg_data_t *pgdat = NODE_DATA(node);
>         int isolated;
>         int nr_remaining;
> +       unsigned int nr_succeeded = 0;
>         LIST_HEAD(migratepages);
>
>         /*
> @@ -2127,7 +2130,7 @@ int migrate_misplaced_page(struct page *
>         list_add(&page->lru, &migratepages);
>         nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
>                                      NULL, node, MIGRATE_ASYNC,
> -                                    MR_NUMA_MISPLACED);
> +                                    MR_NUMA_MISPLACED, &nr_succeeded);
>         if (nr_remaining) {
>                 if (!list_empty(&migratepages)) {
>                         list_del(&page->lru);
> diff -puN mm/page_alloc.c~migrate_pages-add-success-return mm/page_alloc.c
> --- a/mm/page_alloc.c~migrate_pages-add-success-return  2021-01-25 16:23:12.950866701 -0800
> +++ b/mm/page_alloc.c   2021-01-25 16:23:12.968866701 -0800
> @@ -8401,7 +8401,8 @@ static unsigned long pfn_max_align_up(un
>
>  /* [start, end) must belong to a single zone. */
>  static int __alloc_contig_migrate_range(struct compact_control *cc,
> -                                       unsigned long start, unsigned long end)
> +                                       unsigned long start, unsigned long end,
> +                                       unsigned int *nr_succeeded)
>  {
>         /* This function is based on compact_zone() from compaction.c. */
>         unsigned int nr_reclaimed;
> @@ -8439,7 +8440,8 @@ static int __alloc_contig_migrate_range(
>                 cc->nr_migratepages -= nr_reclaimed;
>
>                 ret = migrate_pages(&cc->migratepages, alloc_migration_target,
> -                               NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> +                               NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE,
> +                               nr_succeeded);
>         }
>         if (ret < 0) {
>                 putback_movable_pages(&cc->migratepages);
> @@ -8475,6 +8477,7 @@ int alloc_contig_range(unsigned long sta
>         unsigned long outer_start, outer_end;
>         unsigned int order;
>         int ret = 0;
> +       unsigned int nr_succeeded = 0;
>
>         struct compact_control cc = {
>                 .nr_migratepages = 0,
> @@ -8527,7 +8530,7 @@ int alloc_contig_range(unsigned long sta
>          * allocated.  So, if we fall through be sure to clear ret so that
>          * -EBUSY is not accidentally used or returned to caller.
>          */
> -       ret = __alloc_contig_migrate_range(&cc, start, end);
> +       ret = __alloc_contig_migrate_range(&cc, start, end, &nr_succeeded);
>         if (ret && ret != -EBUSY)
>                 goto done;
>         ret =0;
> _
>
