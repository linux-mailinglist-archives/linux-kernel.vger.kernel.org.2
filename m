Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF13452BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 00:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhCVXEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 19:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhCVXE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 19:04:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838C5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I/Fi+CHBqKtMivDDdq6/vIEH2z4t0eGQsQY2LUIfIms=; b=r68kn1K6n888jPXvJhttLzOxFJ
        vR74kWBhN43KiWf4FYFcUD5tg6ItXUIB6HYtcLKQ6+xYHjxF74UZQbDxm4vC/MpV8JSKa2lhxU8HP
        6joA1yyGOJmxNlwkxsWIp3lQNfiMzLqcVkoC/lZOrb3P4Kfd8dO5F7AC2f4KfptYJmWyFmiFB6iT9
        Ie5BzSx1Vc+zxzF8prcIWzXviaUachc2ih6XZpxetphg+TmWJ/DILwyF98RiPABp4G7m0g0ZEP6ea
        r078cKqr4h1I9SQdrRy/UfHKERTbAhvORLf4QBOfFiE841xXowqxv6CpXeu+WHlyJ85PDOUxM4czD
        3Gcf7LKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOTZn-009Cq8-6E; Mon, 22 Mar 2021 23:03:21 +0000
Date:   Mon, 22 Mar 2021 23:03:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] mm/vmalloc: Use kvmalloc to allocate the table of
 pages
Message-ID: <20210322230311.GY1719932@casper.infradead.org>
References: <20210322193820.2140045-1-willy@infradead.org>
 <20210322193820.2140045-2-willy@infradead.org>
 <20210322223619.GA56503@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322223619.GA56503@pc638.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:36:19PM +0100, Uladzislau Rezki wrote:
> On Mon, Mar 22, 2021 at 07:38:20PM +0000, Matthew Wilcox (Oracle) wrote:
> > If we're trying to allocate 4MB of memory, the table will be 8KiB in size
> > (1024 pointers * 8 bytes per pointer), which can usually be satisfied
> > by a kmalloc (which is significantly faster).  Instead of changing this
> > open-coded implementation, just use kvmalloc().
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  mm/vmalloc.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 96444d64129a..32b640a84250 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2802,13 +2802,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  		gfp_mask |= __GFP_HIGHMEM;
> >  
> >  	/* Please note that the recursion is strictly bounded. */
> > -	if (array_size > PAGE_SIZE) {
> > -		pages = __vmalloc_node(array_size, 1, nested_gfp, node,
> > +	pages = kvmalloc_node_caller(array_size, nested_gfp, node,
> >  					area->caller);
> > -	} else {
> > -		pages = kmalloc_node(array_size, nested_gfp, node);
> > -	}
> > -
> >  	if (!pages) {
> >  		free_vm_area(area);
> >  		return NULL;
> > -- 
> > 2.30.2
> Makes sense to me. Though i expected a bigger difference:
> 
> # patch
> single CPU, 4MB allocation, loops: 1000000 avg: 85293854 usec
> 
> # default
> single CPU, 4MB allocation, loops: 1000000 avg: 89275857 usec

Well, 4.5% isn't something to leave on the table ... but yeah, I was
expecting more in the 10-20% range.  It may be more significant if
there's contention on the spinlocks (like if this crazy ksmbd is calling
vmalloc(4MB) on multiple nodes simultaneously).

I suspect the vast majority of the time is spent calling alloc_pages_node()
1024 times.  Have you looked at Mel's patch to do ... well, exactly what
vmalloc() wants?

https://lore.kernel.org/linux-mm/20210322091845.16437-1-mgorman@techsingularity.net/

> One question. Should we care much about fragmentation? I mean
> with the patch, allocations > 2MB will do request to SLAB bigger
> then PAGE_SIZE.

We're pretty good about allocating memory in larger chunks these days.
Looking at my laptop's slabinfo,
kmalloc-8k           219    232   8192    4    8 : tunables    0    0    0 : sla
bdata     58     58      0

That's using 8 pages per slab, so that's order-3 allocations.  There's a
few more of those:

$ sudo grep '8 :' /proc/slabinfo |wc
     42     672    4508

so I have confidence that kvmalloc() will manage to use kmalloc up to 16MB
vmalloc allocations, and after that it'll tend to fall back to vmalloc.

