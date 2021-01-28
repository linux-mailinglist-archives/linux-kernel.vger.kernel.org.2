Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1613073A9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhA1KYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:24:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:49358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232311AbhA1KXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:23:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0515ACC6;
        Thu, 28 Jan 2021 10:22:38 +0000 (UTC)
Date:   Thu, 28 Jan 2021 11:22:34 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 2/2] mm/page_alloc: count CMA pages per zone and print
 them in /proc/zoneinfo
Message-ID: <20210128102234.GB5250@localhost.localdomain>
References: <20210127101813.6370-1-david@redhat.com>
 <20210127101813.6370-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127101813.6370-3-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:18:13AM +0100, David Hildenbrand wrote:
> Let's count the number of CMA pages per zone and print them in
> /proc/zoneinfo.
> 
> Having access to the total number of CMA pages per zone is helpful for
> debugging purposes to know where exactly the CMA pages ended up, and to
> figure out how many pages of a zone might behave differently (e.g., like
> ZONE_MOVABLE) - even after some of these pages might already have been
> allocated.

My knowledge of CMA tends to be quite low, actually I though that CMA
was somehow tied to ZONE_MOVABLE.

I see how tracking CMA pages per zona might give you a clue, but what do
you mean by "might behave differently - even after some of these pages might
already have been allocated"

> For now, we are only able to get the global nr+free cma pages from
> /proc/meminfo and the free cma pages per zone from /proc/zoneinfo.
> 
> Note: Track/print that information even without CONFIG_CMA, similar to
> "nr_free_cma" in /proc/zoneinfo. This is different to /proc/meminfo -
> maybe we want to make that consistent in the future (however, changing
> /proc/zoneinfo output might uglify the code a bit).
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/mmzone.h | 4 ++++
>  mm/page_alloc.c        | 1 +
>  mm/vmstat.c            | 6 ++++--
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index ae588b2f87ef..3bc18c9976fd 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -503,6 +503,9 @@ struct zone {
>  	 * bootmem allocator):
>  	 *	managed_pages = present_pages - reserved_pages;
>  	 *
> +	 * cma pages is present pages that are assigned for CMA use
> +	 * (MIGRATE_CMA).
> +	 *
>  	 * So present_pages may be used by memory hotplug or memory power
>  	 * management logic to figure out unmanaged pages by checking
>  	 * (present_pages - managed_pages). And managed_pages should be used
> @@ -527,6 +530,7 @@ struct zone {
>  	atomic_long_t		managed_pages;
>  	unsigned long		spanned_pages;
>  	unsigned long		present_pages;
> +	unsigned long		cma_pages;

I see that NR_FREE_CMA_PAGES is there even without CONFIG_CMA, as you
said, but I am not sure about adding size to a zone unconditionally.
I mean, it is not terrible as IIRC, the maximum MAX_NUMNODES can get
is 1024, and on x86_64 that would be (1024 * 4 zones) * 8 = 32K.
So not a big deal, but still.

Besides following NR_FREE_CMA_PAGES, is there any reason for not doing:

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1e22d96734e0..2d8a830d168d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -436,6 +436,9 @@ struct zone {
        unsigned long           managed_pages;
        unsigned long           spanned_pages;
        unsigned long           present_pages;
+#ifdef CONFIG_CMA
+       unsigned long           cma_pages;
+#endif
 
        const char              *name;
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8ba0870ecddd..5757df4bfd45 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1559,13 +1559,15 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
                   "\n        spanned  %lu"
                   "\n        present  %lu"
                   "\n        managed  %lu",
+                  "\n        cma      %lu",
                   zone_page_state(zone, NR_FREE_PAGES),
                   min_wmark_pages(zone),
                   low_wmark_pages(zone),
                   high_wmark_pages(zone),
                   zone->spanned_pages,
                   zone->present_pages,
-                  zone->managed_pages);
+                  zone->managed_pages,
+                  IS_ENABLED(CONFIG_CMA) ? zone->cma_pages : 0);
 
        seq_printf(m,
                   "\n        protection: (%ld",


I do not see it that ugly, but just my taste.


-- 
Oscar Salvador
SUSE L3
