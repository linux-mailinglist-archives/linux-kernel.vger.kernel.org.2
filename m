Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3D31690D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhBJOZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:25:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:56672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhBJOZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:25:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8297BB152;
        Wed, 10 Feb 2021 14:24:26 +0000 (UTC)
Date:   Wed, 10 Feb 2021 15:24:24 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] mm,page_alloc: Make alloc_contig_range handle
 free hugetlb pages
Message-ID: <20210210142424.GC3636@localhost.localdomain>
References: <20210208103812.32056-1-osalvador@suse.de>
 <20210208103812.32056-3-osalvador@suse.de>
 <9ed946df-9c6c-9a4d-4be9-2f32809974f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ed946df-9c6c-9a4d-4be9-2f32809974f7@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:23:59AM +0100, David Hildenbrand wrote:
> On 08.02.21 11:38, Oscar Salvador wrote:
> > Free hugetlb pages are trickier to handle as to in order to guarantee
> > no userspace appplication disruption, we need to replace the
> > current free hugepage with a new one.
> > 
> > In order to do that, a new function called alloc_and_dissolve_huge_page
> > in introduced.
> > This function will first try to get a new fresh hugetlb page, and if it
> > succeeds, it will dissolve the old one.
> > 
> 
> Thanks for looking into this! Can we move this patch to #1 in the series? It
> is the easier case.
> 
> I also wonder if we should at least try on the memory unplug path to keep
> nr_pages by at least trying to allocate at new one if required, and printing
> a warning if that fails (after all, we're messing with something configured
> by the admin - "nr_pages"). Note that gigantic pages are special (below).

So, do you mean to allocate a new fresh hugepage in case we have a free
hugetlb page within the range we are trying to offline? That makes some
sense I guess.

I can have a look at that, and make hotplug code use the new
alloc_and_dissolve().

Thanks for bringing this up, it is somsething I did not think about.

> > +				/*
> > +				 * Free hugetlb page. Allocate a new one and
> > +				 * dissolve this is if succeed.
> > +				 */
> > +				if (alloc_and_dissolve_huge_page(page)) {
> > +					unsigned long order = buddy_order_unsafe(page);
> > +
> > +					low_pfn += (1UL << order) - 1;
> > +					continue;
> > +				}
> 
> 
> 
> Note that there is a very ugly corner case we will have to handle gracefully
> (I think also in patch #1):
> 
> Assume you allocated a gigantic page (and assume that we are not using CMA
> for gigantic pages for simplicity). Assume you want to allocate another one.
> alloc_pool_huge_page()->...->alloc_contig_pages() will stumble over the
> first allocated page. It will try to alloc_and_dissolve_huge_page() the
> existing gigantic page. To do that, it will
> alloc_pool_huge_page()->...->alloc_contig_pages() ... and so on. Bad.

Heh, I was too naive. I have to confess I completely forgot about
gigantic pages and this cyclic dependency.

> We really don't want to mess with gigantic pages (migrate, dissolve) while
> allocating a gigantic page. I think the easiest (and cleanest) way forward
> is to not mess (isolate, migrate, dissolve) with gigantic pages at all.
> 
> Gigantic pages are not movable, so they won't be placed on random CMA /
> ZONE_MOVABLE.
> 
> Some hstate_is_gigantic(h) calls (maybe inside
> alloc_and_dissolve_huge_page() ? ) along with a nice comment might be good
> enough to avoid having to pass down some kind of alloc_contig context. I
> even think that should be handled inside
> 
> (the main issue is that in contrast to CMA, plain alloc_contig_pages() has
> no memory about which parts were allocated and will simply try re-allocating
> what it previously allocated and never freed - which is usually fine, unless
> we're dealing with such special cases)
> 
> Apart from that, not messing with gigantic pages feels like the right
> approach (allocating/migrating gigantic pages is just horribly slow and most
> probably not worth it anyway).

Yes, I also agree that we should leave out gigantic pages, at least for
now.
We might make it work in the future but I cannot come up with a fancy
way to work around that right now, so it makes sense to cut down the
complexity here.

Thanks David for the insight!

-- 
Oscar Salvador
SUSE L3
