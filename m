Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF7307760
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhA1Npt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:45:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:34124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhA1Npo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:45:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F976ACB7;
        Thu, 28 Jan 2021 13:45:02 +0000 (UTC)
Date:   Thu, 28 Jan 2021 14:44:58 +0100
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
Message-ID: <20210128134458.GA8136@localhost.localdomain>
References: <20210127101813.6370-1-david@redhat.com>
 <20210127101813.6370-3-david@redhat.com>
 <20210128102234.GB5250@localhost.localdomain>
 <2246d657-4f6d-c27d-4ae2-853a8437cda9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2246d657-4f6d-c27d-4ae2-853a8437cda9@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:43:41AM +0100, David Hildenbrand wrote:
> > My knowledge of CMA tends to be quite low, actually I though that CMA
> > was somehow tied to ZONE_MOVABLE.
> 
> CMA is often placed into one of the kernel zones, but can also end up in the movable zone.

Ok good to know.

> > I see how tracking CMA pages per zona might give you a clue, but what do
> > you mean by "might behave differently - even after some of these pages might
> > already have been allocated"
> 
> Assume you have 4GB in ZONE_NORMAL but 1GB is assigned for CMA. You actually only have 3GB available for random kernel allocations, not 4GB.
> 
> Currently, you can only observe the free CMA pages, excluding any pages that are already allocated. Having that information how many CMA pages we have can be helpful - similar to what we already have in /proc/meminfo.

I see, I agree that it can provide some guidance. 

> > I see that NR_FREE_CMA_PAGES is there even without CONFIG_CMA, as you
> > said, but I am not sure about adding size to a zone unconditionally.
> > I mean, it is not terrible as IIRC, the maximum MAX_NUMNODES can get
> > is 1024, and on x86_64 that would be (1024 * 4 zones) * 8 = 32K.
> > So not a big deal, but still.
> 
> I'm asking myself how many such systems will run without
> CONFIG_CMA in the future.

I am not sure, my comment was just to point out that even the added size might
not be that large, hiding it under CONFIG_CMA seemed the right thing to
do.

> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 8ba0870ecddd..5757df4bfd45 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1559,13 +1559,15 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
> >                     "\n        spanned  %lu"
> >                     "\n        present  %lu"
> >                     "\n        managed  %lu",
> > +                  "\n        cma      %lu",
> >                     zone_page_state(zone, NR_FREE_PAGES),
> >                     min_wmark_pages(zone),
> >                     low_wmark_pages(zone),
> >                     high_wmark_pages(zone),
> >                     zone->spanned_pages,
> >                     zone->present_pages,
> > -                  zone->managed_pages);
> > +                  zone->managed_pages,
> > +                  IS_ENABLED(CONFIG_CMA) ? zone->cma_pages : 0);
> >          seq_printf(m,
> >                     "\n        protection: (%ld",
> > 
> > 
> > I do not see it that ugly, but just my taste.
> 
> IIRC, that does not work. The compiler will still complain
> about a missing struct members. We would have to provide a
> zone_cma_pages() helper with some ifdefery.

Of course, it seems I switched off my brain.

> We could do something like this on top
> 
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -530,7 +530,9 @@ struct zone {
>         atomic_long_t           managed_pages;
>         unsigned long           spanned_pages;
>         unsigned long           present_pages;
> +#ifdef CONFIG_CMA
>         unsigned long           cma_pages;
> +#endif
>         const char              *name;
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 97fc32a53320..b753a64f099f 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1643,7 +1643,10 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>                    "\n        spanned  %lu"
>                    "\n        present  %lu"
>                    "\n        managed  %lu"
> -                  "\n        cma      %lu",
> +#ifdef CONFIG_CMA
> +                  "\n        cma      %lu"
> +#endif
> +                  "%s",
>                    zone_page_state(zone, NR_FREE_PAGES),
>                    min_wmark_pages(zone),
>                    low_wmark_pages(zone),
> @@ -1651,7 +1654,10 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>                    zone->spanned_pages,
>                    zone->present_pages,
>                    zone_managed_pages(zone),
> -                  zone->cma_pages);
> +#ifdef CONFIG_CMA
> +                  zone->cma_pages,
> +#endif
> +                  "");
>         seq_printf(m,
>                    "\n        protection: (%ld",

Looks good to me, but I can see how those #ifdef can raise some
eyebrows.
Let us see what other thinks as well.

Btw, should linux-uapi be CCed, as /proc/vmstat layout will change?

-- 
Oscar Salvador
SUSE L3
