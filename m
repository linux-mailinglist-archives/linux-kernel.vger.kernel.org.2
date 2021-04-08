Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054A8358C18
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhDHSWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:22:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:38870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhDHSWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:22:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64BBAB17A;
        Thu,  8 Apr 2021 18:21:53 +0000 (UTC)
Date:   Thu, 8 Apr 2021 20:21:51 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, weixugc@google.com,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 04/10] mm/migrate: make migrate_pages() return
 nr_succeeded
Message-ID: <YG9Jv7TVkB3Qt4il@localhost.localdomain>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183223.80F1E291@viggo.jf.intel.com>
 <YG7XjTG9tiK29y1j@localhost.localdomain>
 <CAHbLzkqoaSnuBJMAe_heQt01FuPWODYQHJ955gaJNNojwbUjrw@mail.gmail.com>
 <YG9IthpDC/lri4Qh@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG9IthpDC/lri4Qh@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 08:17:26PM +0200, Oscar Salvador wrote:
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 3a389633b68f..fd661cb2ce13 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -40,7 +40,8 @@ extern int migrate_page(struct address_space *mapping,
>  			struct page *newpage, struct page *page,
>  			enum migrate_mode mode);
>  extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
> -		unsigned long private, enum migrate_mode mode, int reason);
> +		unsigned long private, enum migrate_mode mode, int reason,
> +		unsigned int *ret_succeeded);
>  extern struct page *alloc_migration_target(struct page *page, unsigned long private);
>  extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
>  extern void putback_movable_page(struct page *page);
> @@ -58,7 +59,7 @@ extern int migrate_page_move_mapping(struct address_space *mapping,
>  static inline void putback_movable_pages(struct list_head *l) {}
>  static inline int migrate_pages(struct list_head *l, new_page_t new,
>  		free_page_t free, unsigned long private, enum migrate_mode mode,
> -		int reason)
> +		int reason, unsigned int *ret_succeeded)
>  	{ return -ENOSYS; }
>  static inline struct page *alloc_migration_target(struct page *page,
>  		unsigned long private)
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e04f4476e68e..7238e8faff04 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2364,7 +2364,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
> 
>  		err = migrate_pages(&cc->migratepages, compaction_alloc,
>  				compaction_free, (unsigned long)cc, cc->mode,
> -				MR_COMPACTION);
> +				MR_COMPACTION, NULL);
> 
>  		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
>  							&cc->migratepages);
> diff --git a/mm/gup.c b/mm/gup.c
> index e40579624f10..b70d463aa1fc 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1606,7 +1606,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
>  				put_page(pages[i]);
> 
>  		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
> -			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE, NULL)) {
>  			/*
>  			 * some of the pages failed migration. Do get_user_pages
>  			 * without migration.
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 24210c9bd843..a17e0f039076 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1852,7 +1852,8 @@ static int __soft_offline_page(struct page *page)
> 
>  	if (isolate_page(hpage, &pagelist)) {
>  		ret = migrate_pages(&pagelist, alloc_migration_target, NULL,
> -			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE);
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_FAILURE,
> +			NULL);
>  		if (!ret) {
>  			bool release = !huge;
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 0cdbbfbc5757..28496376de94 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1466,7 +1466,8 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  		if (nodes_empty(nmask))
>  			node_set(mtc.nid, nmask);
>  		ret = migrate_pages(&source, alloc_migration_target, NULL,
> -			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG,
> +			NULL);
>  		if (ret) {
>  			list_for_each_entry(page, &source, lru) {
>  				pr_warn("migrating pfn %lx failed ret:%d ",
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index ab51132547b8..df260ed12102 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1103,7 +1103,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
> 
>  	if (!list_empty(&pagelist)) {
>  		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
> -				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
> +				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
> +				NULL);
>  		if (err)
>  			putback_movable_pages(&pagelist);
>  	}
> @@ -1355,7 +1356,8 @@ static long do_mbind(unsigned long start, unsigned long len,
>  		if (!list_empty(&pagelist)) {
>  			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
>  			nr_failed = migrate_pages(&pagelist, new_page, NULL,
> -				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
> +				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND,
> +				NULL);
>  			if (nr_failed)
>  				putback_movable_pages(&pagelist);
>  		}
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 695a594e5860..087ed407b3ce 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1493,6 +1493,9 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>   * @mode:		The migration mode that specifies the constraints for
>   *			page migration, if any.
>   * @reason:		The reason for page migration.
> + * @ret_succeeded:	A pointer to place the value of the number of pages
> + *                      migrated successfully. The caller must pass a valid pointer
> + *                      if they care about it.
>   *
>   * The function returns after 10 attempts or if no pages are movable any more
>   * because the list has become empty or no retryable pages exist any more.
> @@ -1503,7 +1506,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
>   */
>  int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		free_page_t put_new_page, unsigned long private,
> -		enum migrate_mode mode, int reason)
> +		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
>  {
>  	int retry = 1;
>  	int thp_retry = 1;
> @@ -1654,6 +1657,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	if (!swapwrite)
>  		current->flags &= ~PF_SWAPWRITE;
> 
> +	if (ret_succeeded)
> +		*ret_succeeded = nr_succeeded;
> +
>  	return rc;
>  }
> 
> @@ -1723,7 +1729,8 @@ static int do_move_pages_to_node(struct mm_struct *mm,
>  	};
> 
>  	err = migrate_pages(pagelist, alloc_migration_target, NULL,
> -			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL,
> +			NULL);
>  	if (err)
>  		putback_movable_pages(pagelist);
>  	return err;
> @@ -2230,7 +2237,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>  	list_add(&page->lru, &migratepages);
>  	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_page,
>  				     NULL, node, MIGRATE_ASYNC,
> -				     MR_NUMA_MISPLACED);
> +				     MR_NUMA_MISPLACED, NULL);
>  	if (nr_remaining) {
>  		if (!list_empty(&migratepages)) {
>  			list_del(&page->lru);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 46f3d594369d..0c1bbadd5ca3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8490,7 +8490,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  		cc->nr_migratepages -= nr_reclaimed;
> 
>  		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
> -				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> +				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE,
> +				NULL);
>  	}
>  	if (ret < 0) {
>  		putback_movable_pages(&cc->migratepages);

Of course, to give a full context:

+static unsigned int demote_page_list(struct list_head *demote_pages,
+				     struct pglist_data *pgdat,
+				     struct scan_control *sc)
+{
+	int target_nid = next_demotion_node(pgdat->node_id);
+	unsigned int nr_succeeded = 0;
+	int err;
+
+	if (list_empty(demote_pages))
+		return 0;
+
+	/* Demotion ignores all cpuset and mempolicy settings */
+	err = migrate_pages(demote_pages, alloc_demote_page, NULL,
+			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
+			    &nr_succeeded);
+
+	return nr_succeeded;
+}

So, demote_page_list() would be the only function that passes a valid
pointer, instead of NULL, because it cares about the nr_succeeded.


-- 
Oscar Salvador
SUSE L3
