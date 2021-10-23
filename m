Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65DC43813F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 03:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhJWBRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 21:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhJWBRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 21:17:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AD7C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 18:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0aWo7cdjf8VAjVdLovc3QcMEUO0D9bv9Ns1nWcTyQ4M=; b=lR94lvpYLjehSTpOek+ZG7nYnb
        13UXuiNnKBggx+mZlLPp4Aj5sQD8549TImK7puBgKxmO+IbfsoLrpLfncA23hd/diiYe6b/Wgbj/J
        QLgVLpXtV9NEuvMjqqHNmqhpDZq5cNHa4yUUy9Ij2pY+EK1IlwAku9bkce7TxNVNN0K+4NJe+L2ti
        UYWF6oikPzsey7BYUX0vy23yeGbE2hf06R96O0MrAvvss7YxP6jt4rLb/KF1MWY7ZA4Nn1cjbHzg1
        O82T1aptVHpKPflA6mHyuehpJXH0hJ5wYlFDqEydbYVyCAr08acZd0idYDEhvkLV6P8wCi5C9Wnkj
        kO4epW7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1me5bT-00EIw3-3Y; Sat, 23 Oct 2021 01:13:58 +0000
Date:   Sat, 23 Oct 2021 02:13:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Optimise put_pages_list()
Message-ID: <YXNhx/IYJGVR1ZOH@casper.infradead.org>
References: <20211007192138.561673-1-willy@infradead.org>
 <cb85b8a6-b82f-3054-5d76-57af018d6b2a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb85b8a6-b82f-3054-5d76-57af018d6b2a@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 04:26:59PM -0700, Anthony Yznaga wrote:
> 
> On 10/7/21 12:21 PM, Matthew Wilcox (Oracle) wrote:
> > Instead of calling put_page() one page at a time, pop pages off
> > the list if their refcount was too high and pass the remainder to
> > put_unref_page_list().  This should be a speed improvement, but I have
> > no measurements to support that.  Current callers do not care about
> > performance, but I hope to add some which do.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> > v2:
> >   - Handle compound pages (Mel)
> >   - Comment why we don't need to handle PageLRU
> >   - Added call to __ClearPageWaiters(), matching that in release_pages()
> > 
> >   mm/swap.c | 23 ++++++++++++++++-------
> >   1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/swap.c b/mm/swap.c
> > index af3cad4e5378..9f334d503fd2 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -134,18 +134,27 @@ EXPORT_SYMBOL(__put_page);
> >    * put_pages_list() - release a list of pages
> >    * @pages: list of pages threaded on page->lru
> >    *
> > - * Release a list of pages which are strung together on page.lru.  Currently
> > - * used by read_cache_pages() and related error recovery code.
> > + * Release a list of pages which are strung together on page.lru.
> >    */
> >   void put_pages_list(struct list_head *pages)
> >   {
> > -	while (!list_empty(pages)) {
> > -		struct page *victim;
> > +	struct page *page, *next;
> > -		victim = lru_to_page(pages);
> > -		list_del(&victim->lru);
> > -		put_page(victim);
> > +	list_for_each_entry_safe(page, next, pages, lru) {
> > +		if (!put_page_testzero(page)) {
> > +			list_del(&page->lru);
> > +			continue;
> > +		}
> 
> 
> I know that compound pages are not currently passed to put_pages_list(),
> but I assume the put_page_testzero() should only be done on the head
> page similar to release_pages()?

Fun fact about pages: You can't put a tail page on an LRU list.  Why?

struct page {
...
        union {
                struct {        /* Page cache and anonymous pages */
                        struct list_head lru;
...
                struct {        /* Tail pages of compound page */
                        unsigned long compound_head;    /* Bit zero is set */

so if you try to put a tail page on the LRU list, it becomes no longer
a tail page.
