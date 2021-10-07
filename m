Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CAB425E3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 22:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhJGU6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 16:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhJGU6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:58:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE538C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 13:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RABX8J2srv3C6osF1FF6BJqf6QLlRmQ/+dUCynHymZs=; b=l//gb6pP1+4/TOdVyem3gQfS8g
        6vpf+7I7xyfdnQpRyUKORxZxwQc9Xlv1pSsmyVxcQNZwmIHKEhR3FLPaEQ+QH7p2dzVZ3OMFW7C4K
        sXKn1qIs3U/LqBCTzVhJVCvSbFvHmhM9KWJxH2fAS22efMubNDmWyz/MZqWzWlbkhh/e2JJ5G9huV
        t2JUJ1BClJ+TS6OsJv/w/oGwRmchSTOcgisW3HYBB5h1TbtBjZ6dr1DpGgRLRIB+TkhQldRv6ElcR
        UTw2bRuPdLbS+oo0y/O8Xzze8byfl9japz7MGYpwfjGcNnhZKXm50CLiZfNq+Ey3A+ekLCBo4dfLq
        zFjIaDog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYaQD-002SIQ-3z; Thu, 07 Oct 2021 20:55:27 +0000
Date:   Thu, 7 Oct 2021 21:55:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Optimise put_pages_list()
Message-ID: <YV9eueky+lBfSWA3@casper.infradead.org>
References: <20211007192138.561673-1-willy@infradead.org>
 <20211007123109.6a49c7c625e414acf7546c89@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007123109.6a49c7c625e414acf7546c89@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 12:31:09PM -0700, Andrew Morton wrote:
> On Thu,  7 Oct 2021 20:21:37 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Instead of calling put_page() one page at a time, pop pages off
> > the list if their refcount was too high and pass the remainder to
> > put_unref_page_list().  This should be a speed improvement, but I have
> > no measurements to support that.  Current callers do not care about
> > performance, but I hope to add some which do.
> 
> Don't you think it would actually be slower to take an additional pass
> across the list?  If the list is long enough to cause cache thrashing. 
> Maybe it's faster for small lists.

My first response is an appeal to authority -- release_pages() does
this same thing.  Only it takes an array, constructs a list and passes
that to put_unref_page_list().  So if that's slower (and lists _are_
slower than arrays), we should have a put_unref_page_array().

Second, we can follow through the code paths and reason about it.

Before:

while (!list_empty(pages)) {
	put_page(victim);
		page = compound_head(page);
		if (put_page_testzero(page))
			__put_page(page);
				__put_single_page(page)
					__page_cache_release(page);
					mem_cgroup_uncharge(page);
					<---
free_unref_page(page, 0);
	free_unref_page_prepare()
        local_lock_irqsave(&pagesets.lock, flags);
        free_unref_page_commit(page, pfn, migratetype, order);
        local_unlock_irqrestore(&pagesets.lock, flags);

After:

free_unref_page_list(pages);
        list_for_each_entry_safe(page, next, list, lru) {
                if (!free_unref_page_prepare(page, pfn, 0)) {
        }

        local_lock_irqsave(&pagesets.lock, flags);
        list_for_each_entry_safe(page, next, list, lru) {
		free_unref_page_commit()
	}
        local_unlock_irqrestore(&pagesets.lock, flags);

So the major win here is that we disable/enable interrupts once per
batch rather than once per page.
