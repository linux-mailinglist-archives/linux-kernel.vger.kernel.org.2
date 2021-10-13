Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17DF42B352
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbhJMDYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhJMDYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:24:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C082C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ViMm/859aC8dLfS6AYr0d45i12kvtwVyppaDPD+X7Jk=; b=pmfqjBvbo5YxzbM3VitRV/j/f3
        S843IlLpMWPQg7D9r15hU1uXn7qWI1pNZ2gtHaiS0hhX4DsQHwM2KizmyZJbH2aiJmSTqpOTSeDEc
        yfdpWXHobIcYQSum1lHsStErkpgueE4sJOaUUYdfzOTcQhxEU4FoierChR4uHFMzC0yi0PJre3CmH
        lfOEzOL4SPSD45uFwcpA+muLw3nXGxYNJAjoSzjSgej5DNGJkqRRzG11ppSYN7GQy8mxIFAy3tGY5
        rFp65NsTrylX8yvyd3iAYQH0LC85bm88q/2BAFsux3rynt0mpVRvk3OWZM/mxLZIFewSg5Z9kcJnZ
        x4uvoy7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maUnW-0072Hd-1q; Wed, 13 Oct 2021 03:19:51 +0000
Date:   Wed, 13 Oct 2021 04:19:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/11] PageSlab: eliminate unnecessary compound_head()
 calls
Message-ID: <YWZQNj+axlIQrD5C@casper.infradead.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
 <YWXgrhRDIxcoBhA1@casper.infradead.org>
 <YWXwXINogE0Qb0Ip@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWXwXINogE0Qb0Ip@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 04:30:20PM -0400, Johannes Weiner wrote:
> On Tue, Oct 12, 2021 at 08:23:26PM +0100, Matthew Wilcox wrote:
> > On Tue, Oct 12, 2021 at 02:01:37PM -0400, Johannes Weiner wrote:
> > > PageSlab() currently imposes a compound_head() call on all callsites
> > > even though only very few situations encounter tailpages. This short
> > > series bubbles tailpage resolution up to the few sites that need it,
> > > and eliminates it everywhere else.
> > > 
> > > This is a stand-alone improvement. However, it's inspired by Willy's
> > > patches to split struct slab from struct page. Those patches currently
> > > resolve a slab object pointer to its struct slab as follows:
> > > 
> > > 	slab = virt_to_slab(p);		/* tailpage resolution */
> > > 	if (slab_test_cache(slab)) {	/* slab or page alloc bypass? */
> > > 		do_slab_stuff(slab);
> > > 	} else {
> > > 		page = (struct page *)slab;
> > > 		do_page_stuff(page);
> > > 	}
> > > 
> > > which makes struct slab an ambiguous type that needs to self-identify
> > > with the slab_test_cache() test (which in turn relies on PG_slab in
> > > the flags field shared between page and slab).
> > > 
> > > It would be preferable to do:
> > > 
> > > 	page = virt_to_head_page(p);	/* tailpage resolution */
> > > 	if (PageSlab(page)) {		/* slab or page alloc bypass? */
> > > 		slab = page_slab(page);
> > > 		do_slab_stuff(slab);
> > > 	} else {
> > > 		do_page_stuff(page);
> > > 	}
> > > 
> > > and leave the ambiguity and the need to self-identify with struct
> > > page, so that struct slab is a strong and unambiguous type, and a
> > > non-NULL struct slab encountered in the wild is always a valid object
> > > without the need to check another dedicated flag for validity first.
> > > 
> > > However, because PageSlab() currently implies tailpage resolution,
> > > writing the virt->slab lookup in the preferred way would add yet more
> > > unnecessary compound_head() call to the hottest MM paths.
> > > 
> > > The page flag helpers should eventually all be weaned off of those
> > > compound_head() calls for their unnecessary overhead alone. But this
> > > one in particular is now getting in the way of writing code in the
> > > preferred manner, and bleeding page ambiguity into the new types that
> > > are supposed to eliminate specifically that. It's ripe for a cleanup.
> > 
> > So what I had in mind was more the patch at the end (which I now realise
> > is missing the corresponding changes to __ClearPageSlab()).  There is,
> > however, some weirdness with kfence, which appears to be abusing PageSlab
> > by setting it on pages which are not slab pages???
> > 
> > 	page = virt_to_page(p);
> > 	if (PageSlab(page)) {		/* slab or page alloc bypass? */
> > 		slab = page_slab(page);	/* tail page resolution */
> > 		do_slab_stuff(slab);
> > 	} else {
> > 		do_page_stuff(page); /* or possibly compound_head(page) */
> > 	}
> 
> Can you elaborate why you think this would be better?
> 
> If the object is sitting in a tailpage, the flag test itself could
> avoid the compound_head(), but at the end of the day it's the slab or
> the headpage that needs to be operated on in the fastpaths, and we
> need to do the compound_head() whether the flag is set or not.
> 
> I suppose it could make some debugging checks marginally cheaper?
> 
> But OTOH it comes at the cost of the flag setting and clearing loops
> in the slab allocation path, even when debugging checks are disabled.
> 
> And it would further complicate the compound page model by introducing
> another distinct flag handling scheme (would there be other users for
> it?). The open-coded loops as a means to ensure flag integrity seem
> error prone; but creating Set and Clear variants that encapsulate the
> loops sounds like a move in the wrong direction, given the pain the
> compound_head() alone in them has already created.

I see this as a move towards the dynamically allocated future.
In that future, I think we'll do something like:

static inline struct slab *alloc_slab_pages(...)
{
	struct page *page;
	struct slab *slab = kmalloc(sizeof(struct slab), gfp);
	if (!slab)
		return -ENOMEM;
	... init slab ...
	page = palloc(slab, MEM_TYPE_SLAB, node, gfp, order);
	if (!page) {
		kfree(slab);
		return -ENOMEM;
	}
	slab->virt = page_address(page);

	return slab;
}

where palloc() does something like:

	unsigned long page_desc = mem_type | (unsigned long)mem_desc;

	... allocates the struct pages ...

	for (i = 0; i < (1 << order); i++)
		page[i] = page_desc;
	
	return page;
}


For today, testing PageSlab on the tail page helps the test proceed
in parallel with the action.  Looking at slub's kfree() for an example:

        page = virt_to_head_page(x);
        if (unlikely(!PageSlab(page))) {
                free_nonslab_page(page, object);
                return;
        }
        slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);

Your proposal is certainly an improvement (since gcc doesn't know
that compound_head(compound_head(x)) == compound_head(x)), but I
think checking on the tail page is even better:

	page = virt_to_page(x);
	if (unlikely(!PageSlab(page))) {
		free_nonslab_page(compound_head(page), object);
		return;
	}
	slab = page_slab(page);
	slab_free(slab->slab_cache, slab, object, NULL, 1, _RET_IP_);

The compound_head() parts can proceed in parallel with the check of
PageSlab().

As far as the cost of setting PageSlab, those cachelines are already
dirty because we set compound_head on each of those pages already
(or in the case of freeing, we're about to clear compound_head on
each of those pages).

> > There could also be a PageTail check in there for some of the cases --
> > catch people doing something like:
> > 	kfree(kmalloc(65536, GFP_KERNEL) + 16384);
> > which happens to work today, but should probably not.
> 
> I actually wondered about that when looking at the slob code. Its
> kfree does this:
> 
> 	sp = virt_to_page(block);
> 	if (PageSlab(compound_head(sp))) {
> 		int align = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);
> 		unsigned int *m = (unsigned int *)(block - align);
> 		slob_free(m, *m + align);
> 	} else {
> 		unsigned int order = compound_order(sp);
> 		mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
> 				    -(PAGE_SIZE << order));
> 		__free_pages(sp, order);
> 
> 	}
> 
> Note the virt_to_page(), instead of virt_to_head_page(). It does test
> PG_slab correctly, but if this is a bypass page, it operates on
> whatever tail page the kfree() argument points into. If you did what
> you write above, it would leak the pages before the object.

slob doesn't have to be as careful because it falls back to the page
allocator for all allocations > PAGE_SIZE (see calls to
slob_new_pages())
