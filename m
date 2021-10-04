Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E2C420B31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhJDMwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhJDMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:52:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB21C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w06njsaoptfGFZhduTTmP+jVNtUqi6f3nj+AGSbnhxc=; b=eTROU0Y4/l0j7/eY9ZOmYm4kJW
        ckvlKG0vk21fEP1C2Mw61p4eFJ+1RPM645gR/FGNrAr/OGZMRH6DCaUayUyHFKhyl4i6D8zHBIsot
        klKzYMe+HOLp9izRyZR+7Ev96RkpMs2YKOvdiuRDfN4QROKamHhY4hGMx+zrXY2YdnraFyg22/D9C
        ZconhXr47ls2jWJW+7a9HMtuupBBQIP1gsHXPNs6tNA0QmDSw6lsiJ7zYYZ8I8oUIHb81Gz7lOnH0
        rVYPmyfrP89DjSw63zfFK8WyHcFKRaGRkdAaXiT5CJDpnubHzJPGuyHNce2w5TBAcM3c9U9kNb2KV
        YiH2H6aQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXNPV-00GqoP-Ir; Mon, 04 Oct 2021 12:49:57 +0000
Date:   Mon, 4 Oct 2021 13:49:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: Optimise put_pages_list()
Message-ID: <YVr4YXpsPZtoxDtO@casper.infradead.org>
References: <20210930163258.3114404-1-willy@infradead.org>
 <20211004091037.GM3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004091037.GM3959@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 10:10:37AM +0100, Mel Gorman wrote:
> On Thu, Sep 30, 2021 at 05:32:58PM +0100, Matthew Wilcox (Oracle) wrote:
> > Instead of calling put_page() one page at a time, pop pages off
> > the list if there are other refcounts and pass the remainder
> > to free_unref_page_list().  This should be a speed improvement,
> > but I have no measurements to support that.  It's also not very
> > widely used today, so I can't say I've really tested it.  I'm only
> > bothering with this patch because I'd like the IOMMU code to use it
> > https://lore.kernel.org/lkml/20210930162043.3111119-1-willy@infradead.org/
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> I see your motivation but you need to check that all users of
> put_pages_list (current and future) handle destroy_compound_page properly
> or handle it within put_pages_list. For example, the release_pages()
> user of free_unref_page_list calls __put_compound_page directly before
> freeing. put_pages_list as it stands will call dstroy_compound_page but
> free_unref_page_list does not destroy compound pages in free_pages_prepare

Quite right.  I was really only thinking about order-zero pages because
there aren't any users of compound pages that call this.  But of course,
we should be robust against future callers.  So the obvious thing to do
is to copy what release_pages() does:

+++ b/mm/swap.c
@@ -144,6 +144,10 @@ void put_pages_list(struct list_head *pages)
        list_for_each_entry_safe(page, next, pages, lru) {
                if (!put_page_testzero(page))
                        list_del(&page->lru);
+               if (PageCompound(page)) {
+                       list_del(&page->lru);
+                       __put_compound_page(page);
+               }
        }

        free_unref_page_list(pages);

But would it be better to have free_unref_page_list() handle compound
pages itself?

+++ b/mm/page_alloc.c
@@ -3427,6 +3427,11 @@ void free_unref_page_list(struct list_head *list)

        /* Prepare pages for freeing */
        list_for_each_entry_safe(page, next, list, lru) {
+               if (PageCompound(page)) {
+                       __put_compound_page(page);
+                       list_del(&page->lru);
+                       continue;
+               }
                pfn = page_to_pfn(page);
                if (!free_unref_page_prepare(page, pfn, 0)) {
                        list_del(&page->lru);

(and delete the special handling from release_pages() in the same patch)
