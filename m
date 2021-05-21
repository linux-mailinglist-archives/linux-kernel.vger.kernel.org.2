Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE6938C777
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhEUNIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhEUNIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:08:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376FAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:07:23 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v5so23842497ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XR01GIQvJskVOVw5IqfA2lCJ3o70uuemnirl8BXtsUM=;
        b=plf+BbYAfzrs7YDrXURCX0WGuEVkGgwzqE9Y/jcLL1y0X/cc+y9YZ3bfWBOqrVxO7L
         PfYoCxKChfa8SmUiws+wxkZdpqelXtWWXdbGcIcrlyeoQiJUPkYvzeHFIgo+vEHGZm0f
         qZ/aj34x/8iuOxWIwydutXpeQwxm/D64HOqb4pglgybjxaYV3K3m62bOWus08o3ec13Y
         3YMIzYA0QC+QQysYz3NDWJ5a/uPu5Je7t51mJ5wiCMmA6z/5v5vzRYuUR55R616ftGOJ
         mVPlqqh+lpl+/FbqLU22pWThOUgDwni+ObBxRJdg/rwgyUFRN5qBbffDYEsYB8sIhiTt
         u57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XR01GIQvJskVOVw5IqfA2lCJ3o70uuemnirl8BXtsUM=;
        b=sxFL7Qt0+O6MQkYJ7EczwPdvFnxxxh/nPa/zgUXZIvCNcU0CjK5yOSTTnI9AoQ2YMC
         ZkU7M1Mo0v75S6m6aaDBpqKhXDvIr24ZLdyaj31YIXO8k5Cmid7dC8RnS1G2xSb4IClj
         oxzT16D8tSYM1fYYWmKJ+w292rlfmHGtSRVvDkplEMz8CXYypTehorbpnawGuvQ7NQJy
         Nmc/wvqBhE0aEeQcpJ5cxz2ZckQR65UaYJgT95KscCSVBKCA4okY0ec46Qvn/KPOnaKM
         ksofT5SE4VrfV6D5uwG9DcaAZupPUOslYp5qd/J4un+l+B5APxWMFDhrAge5PW16yals
         yjlg==
X-Gm-Message-State: AOAM531M1KzcDoLukV13tnc14miYUHbngPvUHwb8rCxCXJTBMVQy44QW
        1kDHNA4TMmPNTBpy5eaS9ik=
X-Google-Smtp-Source: ABdhPJwwOBXRIuQOu0kr5gK2Cb5i5ajWMWZBL/dvDgw4g+II6O1pUtAic6AhWpf70aNBPKRTkVM45g==
X-Received: by 2002:a2e:805a:: with SMTP id p26mr6538651ljg.495.1621602441472;
        Fri, 21 May 2021 06:07:21 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id x24sm660924lfe.230.2021.05.21.06.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 06:07:21 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 21 May 2021 15:07:18 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm/vmalloc: Fallback to a single page allocator
Message-ID: <20210521130718.GA17882@pc638.lan>
References: <20210521111033.2243-1-urezki@gmail.com>
 <YKecydxDtWLTDuKg@casper.infradead.org>
 <20210521125509.GA2442@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521125509.GA2442@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 02:55:09PM +0200, Uladzislau Rezki wrote:
> > On Fri, May 21, 2021 at 01:10:33PM +0200, Uladzislau Rezki (Sony) wrote:
> > > +static inline unsigned int
> > > +vm_area_alloc_pages(gfp_t gfp, int nid, unsigned int page_order,
> > > +	unsigned long nr_small_pages, struct page **pages)
> > 
> > (at least) two tabs here, please, otherwise the argument list is at
> > the same indentation as the code which trips up my parser.  some people
> > like to match the opening bracket, but that always feels like more work
> > than it's worth.  fwiw, i'd format it like this:
> > 
> > static inline unsigned int vm_area_alloc_pages(gfp_t gfp, int nid,
> > 		unsigned int order, unsigned long nr_pages, struct page **pages)
> > {
> > ...
> >
> No problem. Will fix it.
> 
> > 
> > (yes, i renamed some of the variables there; overly long variable names
> > are painful)
> > 
> > The rest of the patch looks good.
> > 
> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Thank you!
> 
> I will re-spin the patch and send a v2.
> 

From 6537bc97b5550f17b0813caf02ce0ec1865fa94e Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Thu, 20 May 2021 14:13:23 +0200
Subject: [PATCH v2] mm/vmalloc: Fallback to a single page allocator

Currently for order-0 pages we use a bulk-page allocator to get
set of pages. From the other hand not allocating all pages is
something that might occur. In that case we should fallbak to
the single-page allocator trying to get missing pages, because
it is more permissive(direct reclaim, etc).

Introduce a vm_area_alloc_pages() function where the described
logic is implemented.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 81 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 29 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b2a0cbfa37c1..7765af7b1e9c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2756,6 +2756,54 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 EXPORT_SYMBOL_GPL(vmap_pfn);
 #endif /* CONFIG_VMAP_PFN */
 
+static inline unsigned int
+vm_area_alloc_pages(gfp_t gfp, int nid,
+		unsigned int order, unsigned long nr_pages, struct page **pages)
+{
+	unsigned int nr_allocated = 0;
+
+	/*
+	 * For order-0 pages we make use of bulk allocator, if
+	 * the page array is partly or not at all populated due
+	 * to fails, fallback to a single page allocator that is
+	 * more permissive.
+	 */
+	if (!order)
+		nr_allocated = alloc_pages_bulk_array_node(
+			gfp, nid, nr_pages, pages);
+	else
+		/*
+		 * Compound pages required for remap_vmalloc_page if
+		 * high-order pages.
+		 */
+		gfp |= __GFP_COMP;
+
+	/* High-order pages or fallback path if "bulk" fails. */
+	while (nr_allocated < nr_pages) {
+		struct page *page;
+		int i;
+
+		page = alloc_pages_node(nid, gfp, order);
+		if (unlikely(!page))
+			break;
+
+		/*
+		 * Careful, we allocate and map page-order pages, but
+		 * tracking is done per PAGE_SIZE page so as to keep the
+		 * vm_struct APIs independent of the physical/mapped size.
+		 */
+		for (i = 0; i < (1U << order); i++)
+			pages[nr_allocated + i] = page + i;
+
+		if (gfpflags_allow_blocking(gfp))
+			cond_resched();
+
+		nr_allocated += 1U << order;
+	}
+
+	return nr_allocated;
+}
+
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				 pgprot_t prot, unsigned int page_shift,
 				 int node)
@@ -2789,37 +2837,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		return NULL;
 	}
 
-	area->nr_pages = 0;
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
 	page_order = vm_area_page_order(area);
 
-	if (!page_order) {
-		area->nr_pages = alloc_pages_bulk_array_node(
-			gfp_mask, node, nr_small_pages, area->pages);
-	} else {
-		/*
-		 * Careful, we allocate and map page_order pages, but tracking is done
-		 * per PAGE_SIZE page so as to keep the vm_struct APIs independent of
-		 * the physical/mapped size.
-		 */
-		while (area->nr_pages < nr_small_pages) {
-			struct page *page;
-			int i;
-
-			/* Compound pages required for remap_vmalloc_page */
-			page = alloc_pages_node(node, gfp_mask | __GFP_COMP, page_order);
-			if (unlikely(!page))
-				break;
-
-			for (i = 0; i < (1U << page_order); i++)
-				area->pages[area->nr_pages + i] = page + i;
-
-			if (gfpflags_allow_blocking(gfp_mask))
-				cond_resched();
-
-			area->nr_pages += 1U << page_order;
-		}
-	}
+	area->nr_pages = vm_area_alloc_pages(gfp_mask, node,
+		page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
@@ -2835,7 +2857,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		goto fail;
 	}
 
-	if (vmap_pages_range(addr, addr + size, prot, area->pages, page_shift) < 0) {
+	if (vmap_pages_range(addr, addr + size, prot, area->pages,
+			page_shift) < 0) {
 		warn_alloc(gfp_mask, NULL,
 			   "vmalloc size %lu allocation failure: "
 			   "failed to map pages",
-- 
2.20.1

--
Vlad Rezki
