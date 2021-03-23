Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA216345E57
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhCWMkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhCWMk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:40:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D9AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rgG/bpt1t2GFpWSgbm4RR7F1V5UU5WpTGRoAtt36yEY=; b=v4vmw1hndGkuJds3H4wsnsxyd6
        i+cP2BQuXuVF6Y3wkHbxK9KNVSAb+VRyDvrGqiLJGFfidmqvWq8zFSgZ2sPmNLCH0mCk5xJ5wjB2e
        Pjj0N0RQHKdXIZWiwHnGVtYB3+y2av0300rroUbIU3uGO5GHF708d06k4fAgMVckdeLocAR05QXF0
        uUAXH0oUHyQRe7QWn7bUntWY+5BXlovDaiMUizQ7wTevF5n69k3YWyV7EZHZLjY5B45J62hTRX54d
        JqbjKnO8xEd76tHG92trmyU5TGGyJKwA9qK7kceqKudLFOi9fFHpLqSq4y0vEFsSjIHaqFY6yysHH
        VMVWPdLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOgJV-00A3Ge-Ah; Tue, 23 Mar 2021 12:39:28 +0000
Date:   Tue, 23 Mar 2021 12:39:13 +0000
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
Message-ID: <20210323123913.GD1719932@casper.infradead.org>
References: <20210322193820.2140045-1-willy@infradead.org>
 <20210322193820.2140045-2-willy@infradead.org>
 <20210322223619.GA56503@pc638.lan>
 <20210322230311.GY1719932@casper.infradead.org>
 <20210323120436.GA1949@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323120436.GA1949@pc638.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 01:04:36PM +0100, Uladzislau Rezki wrote:
> On Mon, Mar 22, 2021 at 11:03:11PM +0000, Matthew Wilcox wrote:
> > I suspect the vast majority of the time is spent calling alloc_pages_node()
> > 1024 times.  Have you looked at Mel's patch to do ... well, exactly what
> > vmalloc() wants?
> > 
> <snip>
>          - __vmalloc_node_range
>             - 45.25% __alloc_pages_nodemask
>                - 37.59% get_page_from_freelist
[...]
>       - 44.61% 0xffffffffc047348d
>          - __vunmap
>             - 35.56% free_unref_page

Hmm!  I hadn't been thinking about the free side of things.
Does this make a difference?

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4f5f8c907897..61d5b769fea0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2277,16 +2277,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	vm_remove_mappings(area, deallocate_pages);
 
 	if (deallocate_pages) {
-		int i;
-
-		for (i = 0; i < area->nr_pages; i++) {
-			struct page *page = area->pages[i];
-
-			BUG_ON(!page);
-			__free_pages(page, 0);
-		}
+		release_pages(area->pages, area->nr_pages);
 		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
-
 		kvfree(area->pages);
 	}

release_pages does a bunch of checks that are unnecessary ... we could
probably just do:

		LIST_HEAD(pages_to_free);

		for (i = 0; i < area->nr_pages; i++) {
			struct page *page = area->pages[i];
			if (put_page_testzero(page))
				list_add(&page->lru, &pages_to_free);
		}
		free_unref_page_list(&pages_to_free);

but let's see if the provided interface gets us the performance we want.
 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Thanks!

Thank you!
