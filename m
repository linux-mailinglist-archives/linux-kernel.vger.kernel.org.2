Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E1358E9D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhDHUlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhDHUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:40:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50561C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 13:40:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ba6so3998030edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuHZdD7ba2vn8HmWL2Ad4u0PIfJhwz/LRbU8Br5Cd4Y=;
        b=cCXn0zqKSOpVgRYJ3XJlNr8lx9IAzegCvc4d/bPX/Fujp2Iybj3oPA3FmINZ9rlA7x
         DYK5+Jv3cM3cHSspynyVpEtWQ1t1rH73KQXL//msiwGVrCHrHIktZgVsOnlc6JPf6r5D
         pdsjZc32Ws8UxWf+yCWTc/3IjzoVGvAW0+vfsfCM8GfTJCHUprYCA2Vk6Jn+q2htc6+g
         JDHdQxb651EGbRcCv1orXSWp3C8UU2K1liUb/4f8ECHVFl7uP1+lTdN9rGB2ShMeNkiq
         hJHoCHUNotWexO1jwHy3fXMWphyJyD1EDZYZN1CBO3TFUVTiZkKqrpEtSh9k7aIqcUE+
         8wpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuHZdD7ba2vn8HmWL2Ad4u0PIfJhwz/LRbU8Br5Cd4Y=;
        b=r6ugY1bZwuydZuJETRxZ4TKF+S1CdU1+UODVk4qGRqaISgwbDiX5fMOZXgKCI1PkOO
         nONGdEd9eIa+0YsRl4hir9qXoer7JgWFIjZMGpDSmTjXO1OUlPJa4lHnJOtLg8EVk+RD
         24vZzQw+woqunb+wMtGxcWu2Zsp6XFRSpmI9uF9Wz6vTFhjuLd9/iusHtH/vCRVcgyA4
         o/V6CMl/h/Z8vMfWKeq4ryH+AvEgl61kX5R9Grz1/lz39ZA38CjBfgmdeJVS4ZluydPh
         R/6XxjnNu1PFgdlJStNNTHQ9RGbqEUeoAN3asUPBYMXu04AdY5/5mMA4CXZmhk7uKVyG
         ck0Q==
X-Gm-Message-State: AOAM530kiApK5rHnqerLFpJ+PKBy4aLaLgPG4PPfBGxhJngHaYxdhp4U
        xsd6RBtTmUmxmLGVFr7wn51HDuFxTeqqeaCeMdQ=
X-Google-Smtp-Source: ABdhPJxdivUOIJ2uwgYXFazMxR8kki/0dQfvhaHaEwAHC223FX0u4xcEF3KbPbAF3KCSVWYKbWut2jf9KqpyaYqzeyw=
X-Received: by 2002:a50:d0d8:: with SMTP id g24mr1259641edf.290.1617914445893;
 Thu, 08 Apr 2021 13:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210401183216.443C4443@viggo.jf.intel.com> <20210401183223.80F1E291@viggo.jf.intel.com>
 <YG7XjTG9tiK29y1j@localhost.localdomain> <CAHbLzkqoaSnuBJMAe_heQt01FuPWODYQHJ955gaJNNojwbUjrw@mail.gmail.com>
 <YG9IthpDC/lri4Qh@localhost.localdomain>
In-Reply-To: <YG9IthpDC/lri4Qh@localhost.localdomain>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 8 Apr 2021 13:40:33 -0700
Message-ID: <CAHbLzkqt0_xM=rAaNiSwKn=kY=wmWiFe3N+CEuqH_ryU-o1ysQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] mm/migrate: make migrate_pages() return nr_succeeded
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, weixugc@google.com,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 11:17 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Apr 08, 2021 at 10:26:54AM -0700, Yang Shi wrote:
>
> > Thanks, Oscar. Yes, kind of. But we have to remember to initialize
> > "nr_succedded" pointer properly for every migrate_pages() callsite,
> > right? And it doesn't prevent from returning wrong value if
> > migrate_pages() is called multiple times by one caller although there
> > might be not such case (calls migrate_pages() multiple times and care
> > about nr_succeded) for now.
>
> Hi Yang,
>
> I might be missing something but AFAICS you only need to initialize
> nr_succeded pointer where it matters.
> The local nr_succeeded in migrate_pages() doesn't go, and so it gets
> initialized every time you call in it to 0.
> And if you pass a valid pointer, *ret_succeeded == nr_succedeed.
>
> I am talking about this (not even compile-tested):
>
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 3a389633b68f..fd661cb2ce13 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -40,7 +40,8 @@ extern int migrate_page(struct address_space *mapping,
>                         struct page *newpage, struct page *page,
>                         enum migrate_mode mode);
>  extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
> -               unsigned long private, enum migrate_mode mode, int reason);
> +               unsigned long private, enum migrate_mode mode, int reason,
> +               unsigned int *ret_succeeded);
>  extern struct page *alloc_migration_target(struct page *page, unsigned long private);
>  extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
>  extern void putback_movable_page(struct page *page);
> @@ -58,7 +59,7 @@ extern int migrate_page_move_mapping(struct address_space *mapping,
>  static inline void putback_movable_pages(struct list_head *l) {}
>  static inline int migrate_pages(struct list_head *l, new_page_t new,
>                 free_page_t free, unsigned long private, enum migrate_mode mode,
> -               int reason)
> +               int reason, unsigned int *ret_succeeded)
>         { return -ENOSYS; }
>  static inline struct page *alloc_migration_target(struct page *page,
>                 unsigned long private)
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e04f4476e68e..7238e8faff04 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2364,7 +2364,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>
>                 err = migrate_pages(&cc->migratepages, compaction_alloc,
>                                 compaction_free, (unsigned long)cc, cc->mode,
> -                               MR_COMPACTION);
> +                               MR_COMPACTION, NULL);
>
>                 trace_mm_compaction_migratepages(cc->nr_migratepages, err,
>                                                         &cc->migratepages);
> diff --git a/mm/gup.c b/mm/gup.c
> index e40579624f10..b70d463aa1fc 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1606,7 +1606,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>                                 put_page(pages[i]);
>
>                 if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
> -                       (unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
> +                       (unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE, NULL)) {
>                         /*
>                          * some of the pages failed migration. Do get_user_pages
>                          * without migration.
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 24210c9bd843..a17e0f039076 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1852,7 +1852,8 @@ static int __soft_offline_page(struct page *page)
>
>         if (isolate_page(hpage, &pagelist)) {
>                 ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
> -                       (unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
> +                       (unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE,
> +                       NULL);
>                 if (!ret) {
>                         bool release = !huge;
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0cdbbfbc5757..28496376de94 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1466,7 +1466,8 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>                 if (nodes_empty(nmask))
>                         node_set(mtc.nid, nmask);
>                 ret = migrate_pages(&source, alloc_migration_target, NULL,
> -                       (unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
> +                       (unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG,
> +                       NULL);
>                 if (ret) {
>                         list_for_each_entry(page, &source, lru) {
>                                 pr_warn("migrating pfn %lx failed ret:%d ",
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index ab51132547b8..df260ed12102 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1103,7 +1103,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>
>         if (!list_empty(&pagelist)) {
>                 err = migrate_pages(&pagelist, alloc_migration_target, NULL,
> -                               (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
> +                               (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
> +                               NULL);
>                 if (err)
>                         putback_movable_pages(&pagelist);
>         }
> @@ -1355,7 +1356,8 @@ static long do_mbind(unsigned long start, unsigned long len,
>                 if (!list_empty(&pagelist)) {
>                         WARN_ON_ONCE(flags & MPOL_MF_LAZY);
>                         nr_failed = migrate_pages(&pagelist, new_page, NULL,
> -                               start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
> +                               start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND,
> +                               NULL);
>                         if (nr_failed)
>                                 putback_movable_pages(&pagelist);
>                 }
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 695a594e5860..087ed407b3ce 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1493,6 +1493,9 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>   * @mode:              The migration mode that specifies the constraints for
>   *                     page migration, if any.
>   * @reason:            The reason for page migration.
> + * @ret_succeeded:     A pointer to place the value of the number of pages
> + *                      migrated successfully. The caller must pass a valid pointer
> + *                      if they care about it.
>   *
>   * The function returns after 10 attempts or if no pages are movable any more
>   * because the list has become empty or no retryable pages exist any more.
> @@ -1503,7 +1506,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>   */
>  int migrate_pages(struct list_head *from, new_page_t get_new_page,
>                 free_page_t put_new_page, unsigned long private,
> -               enum migrate_mode mode, int reason)
> +               enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
>  {
>         int retry = 1;
>         int thp_retry = 1;
> @@ -1654,6 +1657,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>         if (!swapwrite)
>                 current->flags &= ~PF_SWAPWRITE;
>
> +       if (ret_succeeded)
> +               *ret_succeeded = nr_succeeded;
> +

Thanks a lot for the example code. You didn't miss anything. At first
glance, I thought your suggestion seemed neater. Actually I
misunderstood what Dave said about "That could really have caused some
interesting problems." with multiple calls to migrate_pages(). I was
thinking about:

unsigned long foo()
{
    unsigned long *ret_succeeded;

    migrate_pages(..., ret_succeeded);

    migrate_pages(..., ret_succeeded);

    return *ret_succeeded;
}

Of course, this is a hypothetical case now. We don't have to care
about it at all.

>         return rc;
>  }
>
> @@ -1723,7 +1729,8 @@ static int do_move_pages_to_node(struct mm_struct *mm,
>         };
>
>         err = migrate_pages(pagelist, alloc_migration_target, NULL,
> -                       (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
> +                       (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
> +                       NULL);
>         if (err)
>                 putback_movable_pages(pagelist);
>         return err;
> @@ -2230,7 +2237,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>         list_add(&page->lru, &migratepages);
>         nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
>                                      NULL, node, MIGRATE_ASYNC,
> -                                    MR_NUMA_MISPLACED);
> +                                    MR_NUMA_MISPLACED, NULL);
>         if (nr_remaining) {
>                 if (!list_empty(&migratepages)) {
>                         list_del(&page->lru);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 46f3d594369d..0c1bbadd5ca3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8490,7 +8490,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>                 cc->nr_migratepages -= nr_reclaimed;
>
>                 ret = migrate_pages(&cc->migratepages, alloc_migration_target,
> -                               NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> +                               NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE,
> +                               NULL);
>         }
>         if (ret < 0) {
>                 putback_movable_pages(&cc->migratepages);
>
>
> As I said I might be missing a point here, but I cannot see the problem
> you describe here.
>
>
> --
> Oscar Salvador
> SUSE L3
