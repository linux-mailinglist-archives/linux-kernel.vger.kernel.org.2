Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6F3522D7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhDAWj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhDAWjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:39:25 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94416C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 15:39:25 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id t14so3375800ilu.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OV28zMVWpGI2jOdTdC8eEcBDHwVbufzqW+Fl/lbBW9E=;
        b=n0EfqSuPWdvztgZbaJ6eigqJR0Ui3sW8O6DayfnhYBeF0CVKAOc1UzEUSjwQ9T+/n1
         6Y/DhP6Wyz2QmICCnSTDYuDrgxAXL0mpqxc5s2HFgsIGiUyL7saXMWCoQu9WI1fN7Vxd
         yY/47xPYg33/tC1lvhuMI6hP4PaAk35J4GsB7XqUagGMDAr1xZmQIx+x03i3n38s8ChX
         c8vXzkd31RE5Bbx9xBXT+q5RZ2CFXs768/+iZeiW8Tkb2tpTEHxbus7z4MjrewNq6wHv
         AWfsdiqydBlM0frbOygClMdAt/gHuFyuca7avTOjDVlFMwQ/xFil7aTBDFxkQBCrcExM
         U6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OV28zMVWpGI2jOdTdC8eEcBDHwVbufzqW+Fl/lbBW9E=;
        b=AhTfBpChGKreuOw1QH6/wRHfQLphDTCJ66NBC40ZPKwjt71hPtUgNuczsWh9rFNNUN
         VFZO7r1HeyxTt2BYTKMh2afEHyhv6PIwHd86wi04teF7THwBFyalfmMI0re5pPQJYk4r
         V3/0xl14cFo8O5X91w4dV+diOD0gOxEb4DftLp4Bt8GTFTu9xzc+qSqZRJOHCkda/dUz
         dGB1hq5usJ+6Kz6uQRwREhUINUKhq9gFKQV9h9sdK/nZ6fiJEqzlx6/8jnYNOM7FYxNb
         1trKDGSmIb+As2YSDShGQCIsru4BL1ddGKBGCpeHNBgSK1T5Vr1JcjX9dXJWe8v0ho0I
         H/aw==
X-Gm-Message-State: AOAM532vOr6Rk8wEz/2w5NQfiiSN9b0YSvG6OodWTSTZmj18seJoi9Jq
        19y5zHtT4d6Q2GiVV2vRa7AthNyNMvQETMubh3b6WgO+MzYK2w==
X-Google-Smtp-Source: ABdhPJxnKLce2DW+DbKgYe7AMBghtst7BeDKk3oRz3t7vqOm3aRKWw7rcV1sWS+s8/1qacbx0sm00Brw1Gp2CRbWcPw=
X-Received: by 2002:a92:6e0e:: with SMTP id j14mr8406720ilc.90.1617316764752;
 Thu, 01 Apr 2021 15:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183223.80F1E291@viggo.jf.intel.com>
In-Reply-To: <20210401183223.80F1E291@viggo.jf.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 1 Apr 2021 15:39:12 -0700
Message-ID: <CAAPL-u-5rAeo7v8gGUWvyQJg=n_APdhpP1HWw8cz5j=a+ayBrg@mail.gmail.com>
Subject: Re: [PATCH 04/10] mm/migrate: make migrate_pages() return nr_succeeded
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.shi@linux.alibaba.com, shy828301@gmail.com,
        ying.huang@intel.com, Dan Williams <dan.j.williams@intel.com>,
        david@redhat.com, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small suggestion: Given that migrate_pages() requires that
*nr_succeeded should be initialized to 0 when it is called due to its
use of *nr_succeeded in count_vm_events() and trace_mm_migrate_pages(),
it would be less error-prone if migrate_pages() initializes
*nr_succeeded itself.

On Thu, Apr 1, 2021 at 11:35 AM Dave Hansen <dave.hansen@linux.intel.com> wrote:
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
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: osalvador <osalvador@suse.de>
>
> --
>
> Note: Yang Shi originally wrote the patch, thus the SoB.  There was
> also a Reviewed-by provided since there were some modifications made
> to this after the original work.
>
> Changes since 20210302:
>  * Fix definition of CONFIG_MIGRATION=n stub migrate_pages().  Its
>    parameters were wrong, but oddly enough did not generate any
>    compile errors.
>
> Changes since 20200122:
>  * Fix migrate_pages() to manipulate nr_succeeded *value*
>    rather than the pointer.
> ---
>
>  b/include/linux/migrate.h |    5 +++--
>  b/mm/compaction.c         |    3 ++-
>  b/mm/gup.c                |    3 ++-
>  b/mm/memory-failure.c     |    4 +++-
>  b/mm/memory_hotplug.c     |    4 +++-
>  b/mm/mempolicy.c          |    8 ++++++--
>  b/mm/migrate.c            |   19 +++++++++++--------
>  b/mm/page_alloc.c         |    9 ++++++---
>  8 files changed, 36 insertions(+), 19 deletions(-)
>
> diff -puN include/linux/migrate.h~migrate_pages-add-success-return include/linux/migrate.h
> --- a/include/linux/migrate.h~migrate_pages-add-success-return  2021-03-31 15:17:14.144000255 -0700
> +++ b/include/linux/migrate.h   2021-03-31 15:17:14.182000255 -0700
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
> --- a/mm/compaction.c~migrate_pages-add-success-return  2021-03-31 15:17:14.146000255 -0700
> +++ b/mm/compaction.c   2021-03-31 15:17:14.186000255 -0700
> @@ -2247,6 +2247,7 @@ compact_zone(struct compact_control *cc,
>         unsigned long last_migrated_pfn;
>         const bool sync = cc->mode != MIGRATE_ASYNC;
>         bool update_cached;
> +       unsigned int nr_succeeded = 0;
>
>         /*
>          * These counters track activities during zone compaction.  Initialize
> @@ -2364,7 +2365,7 @@ compact_zone(struct compact_control *cc,
>
>                 err = migrate_pages(&cc->migratepages, compaction_alloc,
>                                 compaction_free, (unsigned long)cc, cc->mode,
> -                               MR_COMPACTION);
> +                               MR_COMPACTION, &nr_succeeded);
>
>                 trace_mm_compaction_migratepages(cc->nr_migratepages, err,
>                                                         &cc->migratepages);
> diff -puN mm/gup.c~migrate_pages-add-success-return mm/gup.c
> --- a/mm/gup.c~migrate_pages-add-success-return 2021-03-31 15:17:14.150000255 -0700
> +++ b/mm/gup.c  2021-03-31 15:17:14.190000255 -0700
> @@ -1550,6 +1550,7 @@ static long check_and_migrate_cma_pages(
>         unsigned long i;
>         unsigned long step;
>         bool drain_allow = true;
> +       unsigned int nr_succeeded = 0;
>         bool migrate_allow = true;
>         LIST_HEAD(cma_page_list);
>         long ret = nr_pages;
> @@ -1606,7 +1607,7 @@ check_again:
>                                 put_page(pages[i]);
>
>                 if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
> -                       (unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
> +                       (unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE, &nr_succeeded)) {
>                         /*
>                          * some of the pages failed migration. Do get_user_pages
>                          * without migration.
> diff -puN mm/memory-failure.c~migrate_pages-add-success-return mm/memory-failure.c
> --- a/mm/memory-failure.c~migrate_pages-add-success-return      2021-03-31 15:17:14.155000255 -0700
> +++ b/mm/memory-failure.c       2021-03-31 15:17:14.194000255 -0700
> @@ -1809,6 +1809,7 @@ static int __soft_offline_page(struct pa
>         unsigned long pfn = page_to_pfn(page);
>         struct page *hpage = compound_head(page);
>         char const *msg_page[] = {"page", "hugepage"};
> +       unsigned int nr_succeeded = 0;
>         bool huge = PageHuge(page);
>         LIST_HEAD(pagelist);
>         struct migration_target_control mtc = {
> @@ -1852,7 +1853,8 @@ static int __soft_offline_page(struct pa
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
> --- a/mm/memory_hotplug.c~migrate_pages-add-success-return      2021-03-31 15:17:14.160000255 -0700
> +++ b/mm/memory_hotplug.c       2021-03-31 15:17:14.197000255 -0700
> @@ -1392,6 +1392,7 @@ do_migrate_range(unsigned long start_pfn
>         unsigned long pfn;
>         struct page *page, *head;
>         int ret = 0;
> +       unsigned int nr_succeeded = 0;
>         LIST_HEAD(source);
>
>         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> @@ -1466,7 +1467,8 @@ do_migrate_range(unsigned long start_pfn
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
> --- a/mm/mempolicy.c~migrate_pages-add-success-return   2021-03-31 15:17:14.163000255 -0700
> +++ b/mm/mempolicy.c    2021-03-31 15:17:14.203000255 -0700
> @@ -1081,6 +1081,7 @@ static int migrate_page_add(struct page
>  static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>                            int flags)
>  {
> +       unsigned int nr_succeeded = 0;
>         nodemask_t nmask;
>         LIST_HEAD(pagelist);
>         int err = 0;
> @@ -1103,7 +1104,8 @@ static int migrate_to_node(struct mm_str
>
>         if (!list_empty(&pagelist)) {
>                 err = migrate_pages(&pagelist, alloc_migration_target, NULL,
> -                               (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
> +                               (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
> +                               &nr_succeeded);
>                 if (err)
>                         putback_movable_pages(&pagelist);
>         }
> @@ -1278,6 +1280,7 @@ static long do_mbind(unsigned long start
>                      nodemask_t *nmask, unsigned long flags)
>  {
>         struct mm_struct *mm = current->mm;
> +       unsigned int nr_succeeded = 0;
>         struct mempolicy *new;
>         unsigned long end;
>         int err;
> @@ -1355,7 +1358,8 @@ static long do_mbind(unsigned long start
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
> --- a/mm/migrate.c~migrate_pages-add-success-return     2021-03-31 15:17:14.168000255 -0700
> +++ b/mm/migrate.c      2021-03-31 15:17:14.207000255 -0700
> @@ -1493,6 +1493,7 @@ static inline int try_split_thp(struct p
>   * @mode:              The migration mode that specifies the constraints for
>   *                     page migration, if any.
>   * @reason:            The reason for page migration.
> + * @nr_succeeded:      The number of pages migrated successfully.
>   *
>   * The function returns after 10 attempts or if no pages are movable any more
>   * because the list has become empty or no retryable pages exist any more.
> @@ -1503,12 +1504,11 @@ static inline int try_split_thp(struct p
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
> @@ -1611,10 +1611,10 @@ retry:
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
> @@ -1643,12 +1643,12 @@ out:
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
> @@ -1716,6 +1716,7 @@ static int store_status(int __user *stat
>  static int do_move_pages_to_node(struct mm_struct *mm,
>                 struct list_head *pagelist, int node)
>  {
> +       unsigned int nr_succeeded = 0;
>         int err;
>         struct migration_target_control mtc = {
>                 .nid = node,
> @@ -1723,7 +1724,8 @@ static int do_move_pages_to_node(struct
>         };
>
>         err = migrate_pages(pagelist, alloc_migration_target, NULL,
> -                       (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
> +                       (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
> +                       &nr_succeeded);
>         if (err)
>                 putback_movable_pages(pagelist);
>         return err;
> @@ -2207,6 +2209,7 @@ int migrate_misplaced_page(struct page *
>         pg_data_t *pgdat = NODE_DATA(node);
>         int isolated;
>         int nr_remaining;
> +       unsigned int nr_succeeded = 0;
>         LIST_HEAD(migratepages);
>
>         /*
> @@ -2230,7 +2233,7 @@ int migrate_misplaced_page(struct page *
>         list_add(&page->lru, &migratepages);
>         nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
>                                      NULL, node, MIGRATE_ASYNC,
> -                                    MR_NUMA_MISPLACED);
> +                                    MR_NUMA_MISPLACED, &nr_succeeded);
>         if (nr_remaining) {
>                 if (!list_empty(&migratepages)) {
>                         list_del(&page->lru);
> diff -puN mm/page_alloc.c~migrate_pages-add-success-return mm/page_alloc.c
> --- a/mm/page_alloc.c~migrate_pages-add-success-return  2021-03-31 15:17:14.178000255 -0700
> +++ b/mm/page_alloc.c   2021-03-31 15:17:14.213000255 -0700
> @@ -8452,7 +8452,8 @@ static unsigned long pfn_max_align_up(un
>
>  /* [start, end) must belong to a single zone. */
>  static int __alloc_contig_migrate_range(struct compact_control *cc,
> -                                       unsigned long start, unsigned long end)
> +                                       unsigned long start, unsigned long end,
> +                                       unsigned int *nr_succeeded)
>  {
>         /* This function is based on compact_zone() from compaction.c. */
>         unsigned int nr_reclaimed;
> @@ -8490,7 +8491,8 @@ static int __alloc_contig_migrate_range(
>                 cc->nr_migratepages -= nr_reclaimed;
>
>                 ret = migrate_pages(&cc->migratepages, alloc_migration_target,
> -                               NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> +                               NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE,
> +                               nr_succeeded);
>         }
>         if (ret < 0) {
>                 putback_movable_pages(&cc->migratepages);
> @@ -8526,6 +8528,7 @@ int alloc_contig_range(unsigned long sta
>         unsigned long outer_start, outer_end;
>         unsigned int order;
>         int ret = 0;
> +       unsigned int nr_succeeded = 0;
>
>         struct compact_control cc = {
>                 .nr_migratepages = 0,
> @@ -8580,7 +8583,7 @@ int alloc_contig_range(unsigned long sta
>          * allocated.  So, if we fall through be sure to clear ret so that
>          * -EBUSY is not accidentally used or returned to caller.
>          */
> -       ret = __alloc_contig_migrate_range(&cc, start, end);
> +       ret = __alloc_contig_migrate_range(&cc, start, end, &nr_succeeded);
>         if (ret && ret != -EBUSY)
>                 goto done;
>         ret =0;
> _
