Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E227D389314
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354997AbhESP5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:57:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:39266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354986AbhESP5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:57:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3F46ABB1;
        Wed, 19 May 2021 15:56:32 +0000 (UTC)
Date:   Wed, 19 May 2021 16:56:30 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] mm/vmalloc: Switch to bulk allocator in
 __vmalloc_area_node()
Message-ID: <20210519155630.GD3672@suse.de>
References: <20210516202056.2120-1-urezki@gmail.com>
 <20210516202056.2120-3-urezki@gmail.com>
 <YKUWKFyLdqTYliwu@infradead.org>
 <20210519143900.GA2262@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210519143900.GA2262@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 04:39:00PM +0200, Uladzislau Rezki wrote:
> > > +	/*
> > > +	 * If not enough pages were obtained to accomplish an
> > > +	 * allocation request, free them via __vfree() if any.
> > > +	 */
> > > +	if (area->nr_pages != nr_small_pages) {
> > > +		warn_alloc(gfp_mask, NULL,
> > > +			"vmalloc size %lu allocation failure: "
> > > +			"page order %u allocation failed",
> > > +			area->nr_pages * PAGE_SIZE, page_order);
> > > +		goto fail;
> > > +	}
> > 
> > From reading __alloc_pages_bulk not allocating all pages is something
> > that cn happen fairly easily.  Shouldn't we try to allocate the missing
> > pages manually and/ore retry here?
> > 
>
> It is a good point. The bulk-allocator, as i see, only tries to access
> to pcp-list and falls-back to a single allocator once it fails, so the
> array may not be fully populated.
> 

Partially correct. It does allocate via the pcp-list but the pcp-list will
be refilled if it's empty so if the bulk allocator returns fewer pages
than requested, it may be due to hitting watermarks or the local zone is
depleted. It does not take any special action to correct the situation
or stall e.g.  wake kswapd, enter direct reclaim, allocate from a remote
node etc.

If no pages were allocated, it'll try allocate at least one page via a
single allocation request in case the bulk failure would push the zone
over the watermark but 1 page does not. That path as a side-effect would
also wake kswapd.

> In that case probably it makes sense to manually populate it using
> single page allocator.
> 
> Mel, could you please also comment on it?
> 

It is by design because it's unknown if callers can recover or if so,
how they want to recover and the primary intent behind the bulk allocator
was speed. In the case of network, it only wants some pages quickly so as
long as it gets 1, it makes progress. For the sunrpc user, it's willing
to wait and retry. For vmalloc, I'm unsure what a suitable recovery path
should be as I do not have a good handle on workloads that are sensitive
to vmalloc performance. The obvious option would be to loop and allocate
single pages with alloc_pages_node understanding that the additional
pages may take longer to allocate.

An alternative option would be to define either __GFP_RETRY_MAYFAIL or
__GFP_NORETRY semantics for the bulk allocator to handle it in the failure
path. It's a bit more complex because the existing __GFP_RETRY_MAYFAIL
semantics deal with costly high-order allocations. __GFP_NORETRY would
be slightly trickier although it makes more sense. The failure path would
retry the failure path unless __GFP_NORETRY was specified. For that option,
the network path would need to be updated to add the __GFP_NORETRY flag
as it almost certainly does not want looping behaviour.

-- 
Mel Gorman
SUSE Labs
