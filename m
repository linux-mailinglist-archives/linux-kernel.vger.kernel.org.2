Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F0530BD82
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhBBL4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:56:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:58910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229976AbhBBL4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:56:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3564FAD2E;
        Tue,  2 Feb 2021 11:55:19 +0000 (UTC)
Date:   Tue, 2 Feb 2021 12:55:16 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
Subject: Re: [RFC][PATCH 08/13] mm/migrate: demote pages during reclaim
Message-ID: <20210202115516.GC12139@linux>
References: <20210126003411.2AC51464@viggo.jf.intel.com>
 <20210126003427.73DFDD34@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126003427.73DFDD34@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 04:34:27PM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This is mostly derived from a patch from Yang Shi:
> 
> 	https://lore.kernel.org/linux-mm/1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com/
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

[...]
  
> +static struct page *alloc_demote_page(struct page *page, unsigned long node)
> +{
> +        struct migration_target_control mtc = {
> +		/*
> +		 * Fail quickly and quietly.  Page will likely
> +		 * just be discarded instead of migrated.
> +		 */
> +		.gfp_mask = GFP_HIGHUSER | __GFP_NORETRY | __GFP_NOWARN,
> +		.nid = node
> +	};
> +
> +        return alloc_migration_target(page, (unsigned long)&mtc);
> +}

Migration for THP pages will set direct reclaim. I guess that is fine right?
AFAIK, direct reclaim will only be tried once with GFP_NORETRY.

> +
> +/*
> + * Take pages on @demote_list and attempt to demote them to
> + * another node.  Pages which are not demoted are left on
> + * @demote_pages.
> + */
> +static unsigned int demote_page_list(struct list_head *demote_pages,
> +				     struct pglist_data *pgdat,
> +				     struct scan_control *sc)
> +{
> +	int target_nid = next_demotion_node(pgdat->node_id);
> +	unsigned int nr_succeeded = 0;
> +	int err;
> +
> +	if (list_empty(demote_pages))
> +		return 0;
> +
> +	/* Demotion ignores all cpuset and mempolicy settings */
> +	err = migrate_pages(demote_pages, alloc_demote_page, NULL,
> +			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
> +			    &nr_succeeded);
> +
> +	return nr_succeeded;
> +}
> +
>  /*
>   * shrink_page_list() returns the number of reclaimed pages
>   */
> @@ -1078,12 +1135,15 @@ static unsigned int shrink_page_list(str
>  {
>  	LIST_HEAD(ret_pages);
>  	LIST_HEAD(free_pages);
> +	LIST_HEAD(demote_pages);
>  	unsigned int nr_reclaimed = 0;
>  	unsigned int pgactivate = 0;
> +	bool do_demote_pass = true;
>  
>  	memset(stat, 0, sizeof(*stat));
>  	cond_resched();
>  
> +retry:
>  	while (!list_empty(page_list)) {
>  		struct address_space *mapping;
>  		struct page *page;
> @@ -1233,6 +1293,16 @@ static unsigned int shrink_page_list(str
>  		}
>  
>  		/*
> +		 * Before reclaiming the page, try to relocate
> +		 * its contents to another node.
> +		 */
> +		if (do_demote_pass && migrate_demote_page_ok(page)) {
> +			list_add(&page->lru, &demote_pages);
> +			unlock_page(page);
> +			continue;
> +		}

Should we keep it simple for now and only try to demote those pages that are
free of cpusets and memory policies?
Actually, demoting those pages to a CPU or a NUMA node that does not fall into
their set, would violate those constraints right?
So I think we should leave those pages alone for now.

> +
> +		/*
>  		 * Anonymous process memory has backing store?
>  		 * Try to allocate it some swap space here.
>  		 * Lazyfree page could be freed directly
> @@ -1479,6 +1549,17 @@ keep:
>  		list_add(&page->lru, &ret_pages);
>  		VM_BUG_ON_PAGE(PageLRU(page) || PageUnevictable(page), page);
>  	}
> +	/* 'page_list' is always empty here */
> +
> +	/* Migrate pages selected for demotion */
> +	nr_reclaimed += demote_page_list(&demote_pages, pgdat, sc);
> +	/* Pages that could not be demoted are still in @demote_pages */
> +	if (!list_empty(&demote_pages)) {
> +		/* Pages which failed to demoted go back on on @page_list for retry: */
> +		list_splice_init(&demote_pages, page_list);
> +		do_demote_pass = false;
> +		goto retry;
> +	}
>  
>  	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
>  
> _
> 

-- 
Oscar Salvador
SUSE L3
