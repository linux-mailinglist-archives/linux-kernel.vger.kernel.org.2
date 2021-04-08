Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD97358063
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 12:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhDHKO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 06:14:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:54218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhDHKOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:14:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67F82AF9E;
        Thu,  8 Apr 2021 10:14:40 +0000 (UTC)
Date:   Thu, 8 Apr 2021 12:14:37 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.shi@linux.alibaba.com, shy828301@gmail.com,
        weixugc@google.com, ying.huang@intel.com, dan.j.williams@intel.com,
        david@redhat.com
Subject: Re: [PATCH 04/10] mm/migrate: make migrate_pages() return
 nr_succeeded
Message-ID: <YG7XjTG9tiK29y1j@localhost.localdomain>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183223.80F1E291@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401183223.80F1E291@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:32:23AM -0700, Dave Hansen wrote:
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

...
>  int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  		free_page_t put_new_page, unsigned long private,
> -		enum migrate_mode mode, int reason)
> +		enum migrate_mode mode, int reason, unsigned int *nr_succeeded)
>  {
>  	int retry = 1;
>  	int thp_retry = 1;
>  	int nr_failed = 0;
> -	int nr_succeeded = 0;
>  	int nr_thp_succeeded = 0;
>  	int nr_thp_failed = 0;
>  	int nr_thp_split = 0;
> @@ -1611,10 +1611,10 @@ retry:
>  			case MIGRATEPAGE_SUCCESS:
>  				if (is_thp) {
>  					nr_thp_succeeded++;
> -					nr_succeeded += nr_subpages;
> +					*nr_succeeded += nr_subpages;
>  					break;
>  				}
> -				nr_succeeded++;
> +				(*nr_succeeded)++;
>  				break;
>  			default:
>  				/*
> @@ -1643,12 +1643,12 @@ out:
>  	 */
>  	list_splice(&ret_pages, from);
>  
> -	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> +	count_vm_events(PGMIGRATE_SUCCESS, *nr_succeeded);
>  	count_vm_events(PGMIGRATE_FAIL, nr_failed);
>  	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>  	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>  	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
> +	trace_mm_migrate_pages(*nr_succeeded, nr_failed, nr_thp_succeeded,
>  			       nr_thp_failed, nr_thp_split, mode, reason);

It seems that reclaiming is the only user who cared about how many pages
could we migrated, could not do the following instead:

diff --git a/mm/migrate.c b/mm/migrate.c
index 695a594e5860..d4170b7ea2fe 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1503,7 +1503,7 @@ static inline int try_split_thp(struct page *page, struct page **page2,
  */
 int migrate_pages(struct list_head *from, new_page_t get_new_page,
                free_page_t put_new_page, unsigned long private,
-               enum migrate_mode mode, int reason)
+               enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
 {
        int retry = 1;
        int thp_retry = 1;
@@ -1654,6 +1654,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
        if (!swapwrite)
                current->flags &= ~PF_SWAPWRITE;

+       if (ret_succedded)
+               *ret_succedded = nr_succedded;
+
        return rc;
 }

 And pass only a valid pointer from demote_page_list() and NULL from all
 the others?
 I was just wondered after all those "unsigned int nr_succedded" in all
 other functions.
 This would also solve the "be careful to initialize nr_succedded"
 problem?


-- 
Oscar Salvador
SUSE L3
