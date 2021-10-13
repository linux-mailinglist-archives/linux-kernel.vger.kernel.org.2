Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101F842C829
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhJMR7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 13:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 13:59:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD78CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9PscKTgwema1CV/ObUGT9iiJi3NgNOjPZpZfckZDhw4=; b=DjiL4hwFLfNH2TSKj9qCCUziRr
        sJAQmyZOK6wZgoOO47bdfa7TlqFwe7//KKCDk7ArR+vemIcoZEplslecn+/I9cu9/uh5HXIqYBvuj
        GRNq5QZXum+iyzf2fKCL63aFm+vUIng7nhVAEA8cIo5iOK+7BRoxlvFMRRVdLFROPs+0fBobqhbGd
        Ubal0wGlPZQlSk5W4qMf4Kx8bdCDrUeo2IaHYwgDjobOktxgL5X9fIr1IntLCSh78zP3uSX7M4tje
        ixt2cew3EQtksAnK1TF1w7ME6G0It/xRNo3gpcEcsbogeMO0FR0uZd9IwgeH2V9Kk4w/x4og2yegY
        ZyP3Piig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maiTi-007gC2-Fm; Wed, 13 Oct 2021 17:55:58 +0000
Date:   Wed, 13 Oct 2021 18:55:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/11] PageSlab: eliminate unnecessary compound_head()
 calls
Message-ID: <YWcdoktn30ofnsPO@casper.infradead.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
 <YWXgrhRDIxcoBhA1@casper.infradead.org>
 <YWXwXINogE0Qb0Ip@cmpxchg.org>
 <YWZQNj+axlIQrD5C@casper.infradead.org>
 <YWbj6+myCposUKk1@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWbj6+myCposUKk1@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 09:49:31AM -0400, Johannes Weiner wrote:
> On Wed, Oct 13, 2021 at 04:19:18AM +0100, Matthew Wilcox wrote:
> > For today, testing PageSlab on the tail page helps the test proceed
> > in parallel with the action.  Looking at slub's kfree() for an example:
> > 
> >         page = virt_to_head_page(x);
> >         if (unlikely(!PageSlab(page))) {
> >                 free_nonslab_page(page, object);
> >                 return;
> >         }
> >         slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
> > 
> > Your proposal is certainly an improvement (since gcc doesn't know
> > that compound_head(compound_head(x)) == compound_head(x)), but I
> > think checking on the tail page is even better:
> > 
> > 	page = virt_to_page(x);
> > 	if (unlikely(!PageSlab(page))) {
> > 		free_nonslab_page(compound_head(page), object);
> > 		return;
> > 	}
> > 	slab = page_slab(page);
> > 	slab_free(slab->slab_cache, slab, object, NULL, 1, _RET_IP_);
> > 
> > The compound_head() parts can proceed in parallel with the check of
> > PageSlab().
> >
> > As far as the cost of setting PageSlab, those cachelines are already
> > dirty because we set compound_head on each of those pages already
> > (or in the case of freeing, we're about to clear compound_head on
> > each of those pages).
> 
> ... but this is not. I think the performance gains from this would
> have to be significant to justify complicating page flags further.

My argument isn't really "this is more efficient", because I think
the performance gains are pretty minimal.  More that I would like to
be able to write code in the style which we'll want to use when we're
using dynamically allocated memory descriptors.  It's all just code,
and we can change it at any time, but better to change it to something
that continues to work well in the future.

I don't think we end up with "virt_to_head_page()" in a dynamically
allocated memory descriptor world.  The head page contains no different
information from the tail pages, and indeed the tail pages don't know
that they're tail pages, or where the head page is.  Or maybe they're
all tail pages.

I could see a world where we had a virt_to_memdesc() which returned
a generic memory descriptor that could be cast to a struct slab if
the flags within that memdesc said it was a slab.  But I think it works
out better to tag the memory descriptor pointer with a discriminator
that defines what the pointer is.  Plus it saves a page flag.

Maybe that's the best way to approach it -- how would you want to write
this part of kfree() when memory descriptors are dynamically allocated?
