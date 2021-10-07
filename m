Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7873A42609F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242820AbhJGXiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241497AbhJGXht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:37:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A45D661381;
        Thu,  7 Oct 2021 23:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633649754;
        bh=bVw76LSm8d1+ywKjsFtNWQZs2s9sQ+LZlQ9anViHYT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B+8G1WgXzgfwoaESBkKS7k7JTnDSuSB1JkYMfxlUS5hgfItE/d564svZFEhVaMTTI
         yxRtiINNQVv63wYsdYsQ4v6TFnOOC9pI4beAIr1AjqTUslg2Q4Ri4kBwogiVIRi6SO
         uQA3+uuW1nd7wIfgK1TuSfK/QCEvk4DfjHjdes20=
Date:   Thu, 7 Oct 2021 16:35:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Optimise put_pages_list()
Message-Id: <20211007163554.d9088a65f0e293e2bd906a56@linux-foundation.org>
In-Reply-To: <YV9eueky+lBfSWA3@casper.infradead.org>
References: <20211007192138.561673-1-willy@infradead.org>
        <20211007123109.6a49c7c625e414acf7546c89@linux-foundation.org>
        <YV9eueky+lBfSWA3@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 21:55:21 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Thu, Oct 07, 2021 at 12:31:09PM -0700, Andrew Morton wrote:
> > On Thu,  7 Oct 2021 20:21:37 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > 
> > > Instead of calling put_page() one page at a time, pop pages off
> > > the list if their refcount was too high and pass the remainder to
> > > put_unref_page_list().  This should be a speed improvement, but I have
> > > no measurements to support that.  Current callers do not care about
> > > performance, but I hope to add some which do.
> > 
> > Don't you think it would actually be slower to take an additional pass
> > across the list?  If the list is long enough to cause cache thrashing. 
> > Maybe it's faster for small lists.
> 
> My first response is an appeal to authority -- release_pages() does
> this same thing.  Only it takes an array, constructs a list and passes
> that to put_unref_page_list().  So if that's slower (and lists _are_
> slower than arrays), we should have a put_unref_page_array().

And put_unref_page_list() does two passes across the list!

<quietly sobs>

Here is my beautiful release_pages(), as disrtibuted in linux-2.5.33:

void release_pages(struct page **pages, int nr)
{
	int i;
	struct pagevec pages_to_free;
	struct zone *zone = NULL;

	pagevec_init(&pages_to_free);
	for (i = 0; i < nr; i++) {
		struct page *page = pages[i];
		struct zone *pagezone;

		if (PageReserved(page) || !put_page_testzero(page))
			continue;

		pagezone = page_zone(page);
		if (pagezone != zone) {
			if (zone)
				spin_unlock_irq(&zone->lru_lock);
			zone = pagezone;
			spin_lock_irq(&zone->lru_lock);
		}
		if (TestClearPageLRU(page))
			del_page_from_lru(zone, page);
		if (page_count(page) == 0) {
			if (!pagevec_add(&pages_to_free, page)) {
				spin_unlock_irq(&zone->lru_lock);
				pagevec_free(&pages_to_free);
				pagevec_init(&pages_to_free);
				spin_lock_irq(&zone->lru_lock);
			}
		}
	}
	if (zone)
		spin_unlock_irq(&zone->lru_lock);

	pagevec_free(&pages_to_free);
}

I guess the current version is some commentary on the aging process?


> Second, we can follow through the code paths and reason about it.
> 
> Before:
> 
> while (!list_empty(pages)) {
> 	put_page(victim);
> 		page = compound_head(page);
> 		if (put_page_testzero(page))
> 			__put_page(page);
> 				__put_single_page(page)
> 					__page_cache_release(page);
> 					mem_cgroup_uncharge(page);
> 					<---
> free_unref_page(page, 0);
> 	free_unref_page_prepare()
>         local_lock_irqsave(&pagesets.lock, flags);
>         free_unref_page_commit(page, pfn, migratetype, order);
>         local_unlock_irqrestore(&pagesets.lock, flags);
> 
> After:
> 
> free_unref_page_list(pages);
>         list_for_each_entry_safe(page, next, list, lru) {
>                 if (!free_unref_page_prepare(page, pfn, 0)) {
>         }
> 
>         local_lock_irqsave(&pagesets.lock, flags);
>         list_for_each_entry_safe(page, next, list, lru) {
> 		free_unref_page_commit()
> 	}
>         local_unlock_irqrestore(&pagesets.lock, flags);
> 
> So the major win here is that we disable/enable interrupts once per
> batch rather than once per page.

Perhaps that's faster if the list is fully cached.

Any feelings for how often release_pages() will be passed a huge enough
list for this to occur?
