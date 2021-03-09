Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EAD331B5E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 01:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhCIAFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 19:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhCIAFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 19:05:31 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11816C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 16:05:29 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w9so17297966edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 16:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eaklwdT7Qe1DzglUEPjuw47866r3RFdoVwUmwWeYv8=;
        b=rgfxgkA1Q5tV/pnpk/DB2RjWMjuOq7pYn5UoHfvC7rUVHvKVc2rOBsyoF0ld2WXSFx
         2z4eJGocW5ZC0tscAHbZTdAqUQIMqIYUlD7yu79iKQDAZ4rIynCUTfoKzrlFZJhFvz48
         tDMyEMmY0vGykS8T289fITNBuL98NyOEyoo8UtPrbnQeC5OxQZ59cCZlWMUah0NgXdWo
         I1LndWZSZDSt5noM/ELxsjJkFb3aA0g65B3FjsChWlqKsRx/LcSfhHlSeQWf1SGXF3xP
         2nhPmI+A389Cc0EFHADpj/71wXP55TupbmD2mm+jRaz4E4VdlaL57eOciQv7HEPUebiW
         fjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eaklwdT7Qe1DzglUEPjuw47866r3RFdoVwUmwWeYv8=;
        b=GaBGERKmrmEhY2VFlZWwD/ZzR8dUdWvytIL9bvFrzLI9IhlSgxPCmBLnnp5vBlEhmT
         1arNw5aJ7Y2R2rXRycUga+pPdupNMXkj5asvYA+wqYVP0JoG4ojcjiC43fK3HKxaO66q
         YZvW7ZQDC/YA0pCtdiLdtHPCVUmj/t5d5kV3S3Y6rUM4M1L1AehT4w/BxtWq08DElv0A
         zu59qBfOdTajEJzmE5/nnjJkcDeW2G6FqJZ9aonat7jRZ3be8wE42CPZKfpAXRtunNQD
         QJoIHpqhz7kTg9Pk5O6LXCp51EMn/QMCQIBOahMFb2hgSJAaCIE0YZRRfI9XLl2lZmEi
         lX3Q==
X-Gm-Message-State: AOAM531+9rPMLaS2rPN3jD0XBOyw10sMFzxuhNvP7d26xGG1+DY9IP7j
        9W90Ols0BOEJKEISAetqU58DTDK7ZynNUgNgbHI=
X-Google-Smtp-Source: ABdhPJzAOJW0M+La7HQ4Xo+xygPNlwlATo2xHGQ/HN5hRYV++wIHRitroNURXjg4bMRJ0mRuSQ8u+I2KzYBPU89vPsE=
X-Received: by 2002:aa7:cc03:: with SMTP id q3mr1079622edt.366.1615248327839;
 Mon, 08 Mar 2021 16:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20210304235949.7922C1C3@viggo.jf.intel.com> <20210304235957.958C59F2@viggo.jf.intel.com>
In-Reply-To: <20210304235957.958C59F2@viggo.jf.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Mar 2021 16:05:16 -0800
Message-ID: <CAHbLzkraNuVx4W4fMfasYP+CbY=YfL9aUU1ZdJRGb2AkxjmbGg@mail.gmail.com>
Subject: Re: [PATCH 04/10] mm/migrate: make migrate_pages() return nr_succeeded
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

On Thu, Mar 4, 2021 at 4:00 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
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
>
> --
>
> Changes since 20200122:
>  * Fix migrate_pages() to manipulate nr_succeeded *value*
>    rather than the pointer.

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>
>  b/include/linux/migrate.h |    7 ++++---
>  b/mm/compaction.c         |    3 ++-
>  b/mm/gup.c                |    4 +++-
>  b/mm/memory-failure.c     |    4 +++-
>  b/mm/memory_hotplug.c     |    4 +++-
>  b/mm/mempolicy.c          |    8 ++++++--
>  b/mm/migrate.c            |   19 +++++++++++--------
>  b/mm/page_alloc.c         |    9 ++++++---
>  8 files changed, 38 insertions(+), 20 deletions(-)
>
> diff -puN include/linux/migrate.h~migrate_pages-add-success-return include/linux/migrate.h
> --- a/include/linux/migrate.h~migrate_pages-add-success-return  2021-03-04 15:35:54.751806433 -0800
> +++ b/include/linux/migrate.h   2021-03-04 15:35:54.811806433 -0800
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
> @@ -57,8 +58,8 @@ extern int migrate_page_move_mapping(str
>
>  static inline void putback_movable_pages(struct list_head *l) {}
>  static inline int migrate_pages(struct list_head *l, new_page_t new,
> -               free_page_t free, unsigned long private, enum migrate_mode mode,
> -               int reason)
> +               unsigned long private, enum migrate_mode mode, int reason,
> +               unsigned int *nr_succeeded)
>         { return -ENOSYS; }
>  static inline struct page *alloc_migration_target(struct page *page,
>                 unsigned long private)
> diff -puN mm/compaction.c~migrate_pages-add-success-return mm/compaction.c
> --- a/mm/compaction.c~migrate_pages-add-success-return  2021-03-04 15:35:54.754806433 -0800
> +++ b/mm/compaction.c   2021-03-04 15:35:54.815806433 -0800
> @@ -2240,6 +2240,7 @@ compact_zone(struct compact_control *cc,
>         unsigned long last_migrated_pfn;
>         const bool sync = cc->mode != MIGRATE_ASYNC;
>         bool update_cached;
> +       unsigned int nr_succeeded = 0;
>
>         /*
>          * These counters track activities during zone compaction.  Initialize
> @@ -2357,7 +2358,7 @@ compact_zone(struct compact_control *cc,
>
>                 err = migrate_pages(&cc->migratepages, compaction_alloc,
>                                 compaction_free, (unsigned long)cc, cc->mode,
> -                               MR_COMPACTION);
> +                               MR_COMPACTION, &nr_succeeded);
>
>                 trace_mm_compaction_migratepages(cc->nr_migratepages, err,
>                                                         &cc->migratepages);
> diff -puN mm/gup.c~migrate_pages-add-success-return mm/gup.c
> --- a/mm/gup.c~migrate_pages-add-success-return 2021-03-04 15:35:54.762806433 -0800
> +++ b/mm/gup.c  2021-03-04 15:35:54.819806433 -0800
> @@ -1552,6 +1552,7 @@ static long check_and_migrate_cma_pages(
>         unsigned long step;
>         bool drain_allow = true;
>         bool migrate_allow = true;
> +       unsigned int nr_succeeded = 0;
>         LIST_HEAD(cma_page_list);
>         long ret = nr_pages;
>         struct migration_target_control mtc = {
> @@ -1607,7 +1608,8 @@ check_again:
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
> --- a/mm/memory-failure.c~migrate_pages-add-success-return      2021-03-04 15:35:54.771806433 -0800
> +++ b/mm/memory-failure.c       2021-03-04 15:35:54.823806433 -0800
> @@ -1799,6 +1799,7 @@ static int __soft_offline_page(struct pa
>         unsigned long pfn = page_to_pfn(page);
>         struct page *hpage = compound_head(page);
>         char const *msg_page[] = {"page", "hugepage"};
> +       unsigned int nr_succeeded = 0;
>         bool huge = PageHuge(page);
>         LIST_HEAD(pagelist);
>         struct migration_target_control mtc = {
> @@ -1842,7 +1843,8 @@ static int __soft_offline_page(struct pa
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
> --- a/mm/memory_hotplug.c~migrate_pages-add-success-return      2021-03-04 15:35:54.778806433 -0800
> +++ b/mm/memory_hotplug.c       2021-03-04 15:35:54.826806433 -0800
> @@ -1277,6 +1277,7 @@ do_migrate_range(unsigned long start_pfn
>         unsigned long pfn;
>         struct page *page, *head;
>         int ret = 0;
> +       unsigned int nr_succeeded = 0;
>         LIST_HEAD(source);
>
>         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> @@ -1351,7 +1352,8 @@ do_migrate_range(unsigned long start_pfn
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
> --- a/mm/mempolicy.c~migrate_pages-add-success-return   2021-03-04 15:35:54.786806433 -0800
> +++ b/mm/mempolicy.c    2021-03-04 15:35:54.831806433 -0800
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
> @@ -1268,6 +1270,7 @@ static long do_mbind(unsigned long start
>                      nodemask_t *nmask, unsigned long flags)
>  {
>         struct mm_struct *mm = current->mm;
> +       unsigned int nr_succeeded = 0;
>         struct mempolicy *new;
>         unsigned long end;
>         int err;
> @@ -1345,7 +1348,8 @@ static long do_mbind(unsigned long start
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
> --- a/mm/migrate.c~migrate_pages-add-success-return     2021-03-04 15:35:54.794806433 -0800
> +++ b/mm/migrate.c      2021-03-04 15:35:54.836806433 -0800
> @@ -1487,6 +1487,7 @@ static inline int try_split_thp(struct p
>   * @mode:              The migration mode that specifies the constraints for
>   *                     page migration, if any.
>   * @reason:            The reason for page migration.
> + * @nr_succeeded:      The number of pages migrated successfully.
>   *
>   * The function returns after 10 attempts or if no pages are movable any more
>   * because the list has become empty or no retryable pages exist any more.
> @@ -1497,12 +1498,11 @@ static inline int try_split_thp(struct p
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
> @@ -1605,10 +1605,10 @@ retry:
>                         case MIGRATEPAGE_SUCCESS:
>                                 if (is_thp) {
>                                         nr_thp_succeeded++;
> -                                       nr_succeeded += nr_subpages;
> +                                       *nr_succeeded += nr_subpages;
>                                         break;
>                                 }
> -                               nr_succeeded++;
> +                               (*nr_succeeded)++;
>                                 break;
>                         default:
>                                 /*
> @@ -1637,12 +1637,12 @@ out:
>          */
>         list_splice(&ret_pages, from);
>
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
> @@ -1710,6 +1710,7 @@ static int store_status(int __user *stat
>  static int do_move_pages_to_node(struct mm_struct *mm,
>                 struct list_head *pagelist, int node)
>  {
> +       unsigned int nr_succeeded = 0;
>         int err;
>         struct migration_target_control mtc = {
>                 .nid = node,
> @@ -1717,7 +1718,8 @@ static int do_move_pages_to_node(struct
>         };
>
>         err = migrate_pages(pagelist, alloc_migration_target, NULL,
> -                       (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
> +                       (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
> +                       &nr_succeeded);
>         if (err)
>                 putback_movable_pages(pagelist);
>         return err;
> @@ -2201,6 +2203,7 @@ int migrate_misplaced_page(struct page *
>         pg_data_t *pgdat = NODE_DATA(node);
>         int isolated;
>         int nr_remaining;
> +       unsigned int nr_succeeded = 0;
>         LIST_HEAD(migratepages);
>
>         /*
> @@ -2224,7 +2227,7 @@ int migrate_misplaced_page(struct page *
>         list_add(&page->lru, &migratepages);
>         nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
>                                      NULL, node, MIGRATE_ASYNC,
> -                                    MR_NUMA_MISPLACED);
> +                                    MR_NUMA_MISPLACED, &nr_succeeded);
>         if (nr_remaining) {
>                 if (!list_empty(&migratepages)) {
>                         list_del(&page->lru);
> diff -puN mm/page_alloc.c~migrate_pages-add-success-return mm/page_alloc.c
> --- a/mm/page_alloc.c~migrate_pages-add-success-return  2021-03-04 15:35:54.806806433 -0800
> +++ b/mm/page_alloc.c   2021-03-04 15:35:54.842806433 -0800
> @@ -8470,7 +8470,8 @@ static unsigned long pfn_max_align_up(un
>
>  /* [start, end) must belong to a single zone. */
>  static int __alloc_contig_migrate_range(struct compact_control *cc,
> -                                       unsigned long start, unsigned long end)
> +                                       unsigned long start, unsigned long end,
> +                                       unsigned int *nr_succeeded)
>  {
>         /* This function is based on compact_zone() from compaction.c. */
>         unsigned int nr_reclaimed;
> @@ -8508,7 +8509,8 @@ static int __alloc_contig_migrate_range(
>                 cc->nr_migratepages -= nr_reclaimed;
>
>                 ret = migrate_pages(&cc->migratepages, alloc_migration_target,
> -                               NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> +                               NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE,
> +                               nr_succeeded);
>         }
>         if (ret < 0) {
>                 putback_movable_pages(&cc->migratepages);
> @@ -8544,6 +8546,7 @@ int alloc_contig_range(unsigned long sta
>         unsigned long outer_start, outer_end;
>         unsigned int order;
>         int ret = 0;
> +       unsigned int nr_succeeded = 0;
>
>         struct compact_control cc = {
>                 .nr_migratepages = 0,
> @@ -8598,7 +8601,7 @@ int alloc_contig_range(unsigned long sta
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
