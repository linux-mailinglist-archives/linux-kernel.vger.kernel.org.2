Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A44421150
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhJDObp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:31:45 -0400
Received: from outbound-smtp03.blacknight.com ([81.17.249.16]:34025 "EHLO
        outbound-smtp03.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233767AbhJDObo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:31:44 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id 3ACDAC0BB2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 15:29:54 +0100 (IST)
Received: (qmail 26052 invoked from network); 4 Oct 2021 14:29:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Oct 2021 14:29:54 -0000
Date:   Mon, 4 Oct 2021 15:29:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: Optimise put_pages_list()
Message-ID: <20211004142952.GN3959@techsingularity.net>
References: <20210930163258.3114404-1-willy@infradead.org>
 <20211004091037.GM3959@techsingularity.net>
 <YVr4YXpsPZtoxDtO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YVr4YXpsPZtoxDtO@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 01:49:37PM +0100, Matthew Wilcox wrote:
> On Mon, Oct 04, 2021 at 10:10:37AM +0100, Mel Gorman wrote:
> > On Thu, Sep 30, 2021 at 05:32:58PM +0100, Matthew Wilcox (Oracle) wrote:
> > > Instead of calling put_page() one page at a time, pop pages off
> > > the list if there are other refcounts and pass the remainder
> > > to free_unref_page_list().  This should be a speed improvement,
> > > but I have no measurements to support that.  It's also not very
> > > widely used today, so I can't say I've really tested it.  I'm only
> > > bothering with this patch because I'd like the IOMMU code to use it
> > > https://lore.kernel.org/lkml/20210930162043.3111119-1-willy@infradead.org/
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > I see your motivation but you need to check that all users of
> > put_pages_list (current and future) handle destroy_compound_page properly
> > or handle it within put_pages_list. For example, the release_pages()
> > user of free_unref_page_list calls __put_compound_page directly before
> > freeing. put_pages_list as it stands will call dstroy_compound_page but
> > free_unref_page_list does not destroy compound pages in free_pages_prepare
> 
> Quite right.  I was really only thinking about order-zero pages because
> there aren't any users of compound pages that call this.  But of course,
> we should be robust against future callers.  So the obvious thing to do
> is to copy what release_pages() does:
> 
> +++ b/mm/swap.c
> @@ -144,6 +144,10 @@ void put_pages_list(struct list_head *pages)
>         list_for_each_entry_safe(page, next, pages, lru) {
>                 if (!put_page_testzero(page))
>                         list_del(&page->lru);
> +               if (PageCompound(page)) {
> +                       list_del(&page->lru);
> +                       __put_compound_page(page);
> +               }
>         }
> 
>         free_unref_page_list(pages);

That would be the most straight-forward

> 
> But would it be better to have free_unref_page_list() handle compound
> pages itself?
> 
> +++ b/mm/page_alloc.c
> @@ -3427,6 +3427,11 @@ void free_unref_page_list(struct list_head *list)
> 
>         /* Prepare pages for freeing */
>         list_for_each_entry_safe(page, next, list, lru) {
> +               if (PageCompound(page)) {
> +                       __put_compound_page(page);
> +                       list_del(&page->lru);
> +                       continue;
> +               }
>                 pfn = page_to_pfn(page);
>                 if (!free_unref_page_prepare(page, pfn, 0)) {
>                         list_del(&page->lru);
> 
> (and delete the special handling from release_pages() in the same patch)

It's surprisingly tricky.

Minimally, that list_del should be before __put_compound_page or you'll
clobber whatever list the compound page destructor placed the free page on.
Take care with how you remove the special handling and leave a comment
explaining why __put_compound_page is not called and that PageLRU will be
cleared when it falls through to add the page to pages_to_free.  The tricky
part is memcg uncharging because if mem_cgroup_uncharge_list() is called
then the uncharging happens twice -- once in the destructor and again in
mem_cgroup_uncharge_list. I guess you could use two lists and splice them
after mem_cgroup_uncharge_list() and before free_unref_page_list.

-- 
Mel Gorman
SUSE Labs
