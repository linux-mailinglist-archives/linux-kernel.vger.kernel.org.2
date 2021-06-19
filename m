Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B840E3AD883
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 09:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhFSHrl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Jun 2021 03:47:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:64299 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhFSHri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 03:47:38 -0400
IronPort-SDR: gsIJKKwdm+phJWvuC3dRPUZOpJQ0NU7eaEzb6oXb1L+J073rUfNUuHdrBPkySfWdlyHbxdbYow
 XNdJqcc7t0fg==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193971118"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="193971118"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 00:45:27 -0700
IronPort-SDR: uB7Ea6pZ27PWmU1F1gaLBN9ZJ8wi+ATMJg5snj7JK0ozUKXHR7IWO+g+ZoldOkGcGktR6ajcGz
 QqHhFZhZTR9g==
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="485938060"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 00:45:25 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        osalvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH -V8 05/10] mm/migrate: demote pages during reclaim
References: <20210618061537.434999-1-ying.huang@intel.com>
        <20210618061537.434999-6-ying.huang@intel.com>
        <88CFDFA7-70E1-4C26-B9CF-7A0CEFEB035A@nvidia.com>
Date:   Sat, 19 Jun 2021 15:45:23 +0800
In-Reply-To: <88CFDFA7-70E1-4C26-B9CF-7A0CEFEB035A@nvidia.com> (Zi Yan's
        message of "Fri, 18 Jun 2021 11:42:41 -0400")
Message-ID: <874kdupab0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 18 Jun 2021, at 2:15, Huang Ying wrote:
>
>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>
>> This is mostly derived from a patch from Yang Shi:
>>
>> 	https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com/
>>
>> Add code to the reclaim path (shrink_page_list()) to "demote" data
>> to another NUMA node instead of discarding the data.  This always
>> avoids the cost of I/O needed to read the page back in and sometimes
>> avoids the writeout cost when the pagee is dirty.
>>
>> A second pass through shrink_page_list() will be made if any demotions
>> fail.  This essentally falls back to normal reclaim behavior in the
>> case that demotions fail.  Previous versions of this patch may have
>> simply failed to reclaim pages which were eligible for demotion but
>> were unable to be demoted in practice.
>>
>> Note: This just adds the start of infratructure for migration. It is
>> actually disabled next to the FIXME in migrate_demote_page_ok().
>>
>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: Yang Shi <yang.shi@linux.alibaba.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: osalvador <osalvador@suse.de>
>>
>> --
>> changes from 20210122:
>>  * move from GFP_HIGHUSER -> GFP_HIGHUSER_MOVABLE (Ying)
>>
>> changes from 202010:
>>  * add MR_NUMA_MISPLACED to trace MIGRATE_REASON define
>>  * make migrate_demote_page_ok() static, remove 'sc' arg until
>>    later patch
>>  * remove unnecessary alloc_demote_page() hugetlb warning
>>  * Simplify alloc_demote_page() gfp mask.  Depend on
>>    __GFP_NORETRY to make it lightweight instead of fancier
>>    stuff like leaving out __GFP_IO/FS.
>>  * Allocate migration page with alloc_migration_target()
>>    instead of allocating directly.
>> changes from 20200730:
>>  * Add another pass through shrink_page_list() when demotion
>>    fails.
>> changes from 20210302:
>>  * Use __GFP_THISNODE and revise the comment explaining the
>>    GFP mask constructionn
>> ---
>>  include/linux/migrate.h        |  9 ++++
>>  include/trace/events/migrate.h |  3 +-
>>  mm/vmscan.c                    | 83 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 94 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index 4a49bb358787..42952cbe452b 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -28,6 +28,7 @@ enum migrate_reason {
>>  	MR_NUMA_MISPLACED,
>>  	MR_CONTIG_RANGE,
>>  	MR_LONGTERM_PIN,
>> +	MR_DEMOTION,
>>  	MR_TYPES
>>  };
>>
>> @@ -191,6 +192,14 @@ struct migrate_vma {
>>  int migrate_vma_setup(struct migrate_vma *args);
>>  void migrate_vma_pages(struct migrate_vma *migrate);
>>  void migrate_vma_finalize(struct migrate_vma *migrate);
>> +int next_demotion_node(int node);
>> +
>> +#else /* CONFIG_MIGRATION disabled: */
>> +
>> +static inline int next_demotion_node(int node)
>> +{
>> +	return NUMA_NO_NODE;
>> +}
>>
>>  #endif /* CONFIG_MIGRATION */
>>
>> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
>> index 9fb2a3bbcdfb..779f3fad9ecd 100644
>> --- a/include/trace/events/migrate.h
>> +++ b/include/trace/events/migrate.h
>> @@ -21,7 +21,8 @@
>>  	EM( MR_MEMPOLICY_MBIND,	"mempolicy_mbind")		\
>>  	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
>>  	EM( MR_CONTIG_RANGE,	"contig_range")			\
>> -	EMe(MR_LONGTERM_PIN,	"longterm_pin")
>> +	EM( MR_LONGTERM_PIN,	"longterm_pin")			\
>> +	EMe(MR_DEMOTION,	"demotion")
>>
>>  /*
>>   * First define the enums in the above macros to be exported to userspace
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 5199b9696bab..ddda32031f0c 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -41,6 +41,7 @@
>>  #include <linux/kthread.h>
>>  #include <linux/freezer.h>
>>  #include <linux/memcontrol.h>
>> +#include <linux/migrate.h>
>>  #include <linux/delayacct.h>
>>  #include <linux/sysctl.h>
>>  #include <linux/oom.h>
>> @@ -1231,6 +1232,23 @@ static enum page_references page_check_references(struct page *page,
>>  	return PAGEREF_RECLAIM;
>>  }
>>
>> +static bool migrate_demote_page_ok(struct page *page)
>> +{
>> +	int next_nid = next_demotion_node(page_to_nid(page));
>> +
>> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
>> +	VM_BUG_ON_PAGE(PageHuge(page), page);
>> +	VM_BUG_ON_PAGE(PageLRU(page), page);
>> +
>> +	if (next_nid == NUMA_NO_NODE)
>> +		return false;
>> +	if (PageTransHuge(page) && !thp_migration_supported())
>> +		return false;
>> +
>> +	// FIXME: actually enable this later in the series
>> +	return false;
>> +}
>> +
>>  /* Check if a page is dirty or under writeback */
>>  static void page_check_dirty_writeback(struct page *page,
>>  				       bool *dirty, bool *writeback)
>> @@ -1261,6 +1279,47 @@ static void page_check_dirty_writeback(struct page *page,
>>  		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
>>  }
>>
>> +static struct page *alloc_demote_page(struct page *page, unsigned long node)
>> +{
>> +	struct migration_target_control mtc = {
>> +		/*
>> +		 * Allocate from 'node', or fail the quickly and quietly.
>> +		 * When this happens, 'page; will likely just be discarded
>> +		 * instead of migrated.
>> +		 */
>> +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>> +			    __GFP_THISNODE  | __GFP_NOWARN |
>> +			    __GFP_NOMEMALLOC | GFP_NOWAIT,
>> +		.nid = node
>> +	};
>> +
>> +	return alloc_migration_target(page, (unsigned long)&mtc);
>> +}
>> +
>> +/*
>> + * Take pages on @demote_list and attempt to demote them to
>> + * another node.  Pages which are not demoted are left on
>> + * @demote_pages.
>> + */
>> +static unsigned int demote_page_list(struct list_head *demote_pages,
>> +				     struct pglist_data *pgdat,
>> +				     struct scan_control *sc)
>> +{
>> +	int target_nid = next_demotion_node(pgdat->node_id);
>> +	unsigned int nr_succeeded = 0;
>> +	int err;
>> +
>> +	if (list_empty(demote_pages))
>> +		return 0;
>> +
>> +	/* Demotion ignores all cpuset and mempolicy settings */
>> +	err = migrate_pages(demote_pages, alloc_demote_page, NULL,
>> +			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
>> +			    &nr_succeeded);
>> +
>> +	return nr_succeeded;
>> +}
>> +
>>  /*
>>   * shrink_page_list() returns the number of reclaimed pages
>>   */
>> @@ -1272,12 +1331,15 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>>  {
>>  	LIST_HEAD(ret_pages);
>>  	LIST_HEAD(free_pages);
>> +	LIST_HEAD(demote_pages);
>>  	unsigned int nr_reclaimed = 0;
>>  	unsigned int pgactivate = 0;
>> +	bool do_demote_pass = true;
>>
>>  	memset(stat, 0, sizeof(*stat));
>>  	cond_resched();
>>
>> +retry:
>>  	while (!list_empty(page_list)) {
>>  		struct address_space *mapping;
>>  		struct page *page;
>> @@ -1426,6 +1488,16 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>>  			; /* try to reclaim the page below */
>>  		}
>>
>> +		/*
>> +		 * Before reclaiming the page, try to relocate
>> +		 * its contents to another node.
>> +		 */
>> +		if (do_demote_pass && migrate_demote_page_ok(page)) {
>> +			list_add(&page->lru, &demote_pages);
>> +			unlock_page(page);
>> +			continue;
>> +		}
>> +
>>  		/*
>>  		 * Anonymous process memory has backing store?
>>  		 * Try to allocate it some swap space here.
>> @@ -1676,6 +1748,17 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>>  		list_add(&page->lru, &ret_pages);
>>  		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
>>  	}
>> +	/* 'page_list' is always empty here */
>> +
>> +	/* Migrate pages selected for demotion */
>> +	nr_reclaimed += demote_page_list(&demote_pages, pgdat, sc);
>> +	/* Pages that could not be demoted are still in @demote_pages */
>> +	if (!list_empty(&demote_pages)) {
>> +		/* Pages which failed to demoted go back on @page_list for retry: */
>> +		list_splice_init(&demote_pages, page_list);
>> +		do_demote_pass = false;
>> +		goto retry;
>> +	}
>>
>>  	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
>>
>> -- 
>> 2.30.2
>
> shrink_page_list() is also used by reclaim_pages(), which is called by
> madvise(MADV_PAGEOUT). This patch changes the semantics of madvise(MADV_PAGEOUT)
> from “reclaim a given range of pages” to migrate the given pages to lower
> tier memory or reclaim them if the migration fails. You might want to check
> the caller of shrink_page_list() to avoid changing madvise(MADV_PAGEOUT)
> semantics.

Thanks for pointing this out!

Literally, PAGEOUT means writing the page to the disk instead of
migrating pages to the lower tier.  So it seems reasonable to make it
keep the original behavior instead of demoting even if in the tiered
memory system.

If nobody objects, I will change this in the next version.

Best Regards,
Huang, Ying
