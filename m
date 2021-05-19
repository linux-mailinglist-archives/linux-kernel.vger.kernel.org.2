Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E047A389866
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 23:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhESVJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 17:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhESVJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 17:09:14 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A144C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:07:54 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e11so17158431ljn.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 14:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NFt4peP5a9v4K1JmAAyrsBRgaYdCy3khs+BCQz4WLw0=;
        b=f58gMVCvxUF2JbQUMoGWV0TYuRGMgJdOiJj+pYFpJjtAZvuYbH7qRrO7SWeScKuogl
         5R78WEn+unYWtpuuEaSCWShbVbCZ+JcIlne7UstwJcU4UioQ0MMrK9BOg/hoA7jiMNiM
         /i1/isM1C57b+XWpO+QiE2KlOFdrMARJILpDjB4aOB72Mm/OAiUoaOGFN7CcZYZXz6Ma
         M2rOplmtexRJDG8w8riZvJLXTWoyjDPo4Ynhp7MpWlNQ1+sa7+EredVhD/kXPe7X0A6p
         4Zqu9PRO22AZQ2XcC1oVx+Ax7PkZlzKsUKQZIDaV7QSTx/S+jkQX3UYpr8/+SnTButKd
         h+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NFt4peP5a9v4K1JmAAyrsBRgaYdCy3khs+BCQz4WLw0=;
        b=GgbPA6cyw+rTEx2jD5bD5Dg24/DhY8II2jN075vWsRwZoXHL6pmIwf2I0xlazl6WPU
         SZzOVvg0d+pBPzhY15oTgrcnFz1SnDfLcZoEZ9sQxW8bCKBkYyUja4uMJlaxT7BSdlQD
         sKlyw9wcrUtIIFpN4ekb/AShqxdRKV+Cw754a+yFU1AiekhBtjz+9ak8Ndsk2nrR2OYZ
         fRwt+OTl1KWzADj+i7f++rYKyio7RsCXo5KKgIv5DpIgO0EWtEO9/eiOSrmF02TNvTLJ
         AEY6Mcw2lKYKQDsYKGxUfvUo1GtQ0c5iIy+v5QYmI1sLyLDzwHDM1KVUXBRPeRcphbuZ
         Xu6w==
X-Gm-Message-State: AOAM531gEVOiyC0vR06i0O8+j9UcvmFj5+mPPL5GmReDi1JjzG33H0JO
        U7XLuDfUvWTe9fESSeHDRzA=
X-Google-Smtp-Source: ABdhPJw87gQt482Q5Y2JDCGppPavUlbg4cyOiJUignx3IoY630mvh9sN+1SwJ9EFcmNpxd1ww2gzSQ==
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr817265ljq.220.1621458472523;
        Wed, 19 May 2021 14:07:52 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id b11sm41344ljr.108.2021.05.19.14.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 14:07:52 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 19 May 2021 23:07:50 +0200
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] mm/vmalloc: Switch to bulk allocator in
 __vmalloc_area_node()
Message-ID: <20210519210750.GA5615@pc638.lan>
References: <20210516202056.2120-1-urezki@gmail.com>
 <20210516202056.2120-3-urezki@gmail.com>
 <YKUWKFyLdqTYliwu@infradead.org>
 <20210519143900.GA2262@pc638.lan>
 <20210519155630.GD3672@suse.de>
 <20210519195214.GA2343@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519195214.GA2343@pc638.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 09:52:14PM +0200, Uladzislau Rezki wrote:
> > On Wed, May 19, 2021 at 04:39:00PM +0200, Uladzislau Rezki wrote:
> > > > > +	/*
> > > > > +	 * If not enough pages were obtained to accomplish an
> > > > > +	 * allocation request, free them via __vfree() if any.
> > > > > +	 */
> > > > > +	if (area->nr_pages != nr_small_pages) {
> > > > > +		warn_alloc(gfp_mask, NULL,
> > > > > +			"vmalloc size %lu allocation failure: "
> > > > > +			"page order %u allocation failed",
> > > > > +			area->nr_pages * PAGE_SIZE, page_order);
> > > > > +		goto fail;
> > > > > +	}
> > > > 
> > > > From reading __alloc_pages_bulk not allocating all pages is something
> > > > that cn happen fairly easily.  Shouldn't we try to allocate the missing
> > > > pages manually and/ore retry here?
> > > > 
> > >
> > > It is a good point. The bulk-allocator, as i see, only tries to access
> > > to pcp-list and falls-back to a single allocator once it fails, so the
> > > array may not be fully populated.
> > > 
> > 
> > Partially correct. It does allocate via the pcp-list but the pcp-list will
> > be refilled if it's empty so if the bulk allocator returns fewer pages
> > than requested, it may be due to hitting watermarks or the local zone is
> > depleted. It does not take any special action to correct the situation
> > or stall e.g.  wake kswapd, enter direct reclaim, allocate from a remote
> > node etc.
> > 
> > If no pages were allocated, it'll try allocate at least one page via a
> > single allocation request in case the bulk failure would push the zone
> > over the watermark but 1 page does not. That path as a side-effect would
> > also wake kswapd.
> > 
> OK. A single page allocator can enter a slow path i mean direct reclaim,
> etc to adjust watermarks.
> 
> > > In that case probably it makes sense to manually populate it using
> > > single page allocator.
> > > 
> > > Mel, could you please also comment on it?
> > > 
> > 
> > It is by design because it's unknown if callers can recover or if so,
> > how they want to recover and the primary intent behind the bulk allocator
> > was speed. In the case of network, it only wants some pages quickly so as
> > long as it gets 1, it makes progress. For the sunrpc user, it's willing
> > to wait and retry. For vmalloc, I'm unsure what a suitable recovery path
> > should be as I do not have a good handle on workloads that are sensitive
> > to vmalloc performance. The obvious option would be to loop and allocate
> > single pages with alloc_pages_node understanding that the additional
> > pages may take longer to allocate.
> > 
> I got it. At least we should fall-back for a single allocator, that is how
> we used to allocate before(now it is for high-order pages). If it also fails
> to obtain a page we are done.
> 
> Basically a single-page allocator is more permissive so it is a higher
> chance to success. Therefore a fallback to it makes sense.
> 
Hello, Christoph.

See below the patch. Does it sound good for you? It is about moving
page allocation part into separate function:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b2a0cbfa37c1..18773a4ad5fa 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2756,6 +2756,53 @@ void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot)
 EXPORT_SYMBOL_GPL(vmap_pfn);
 #endif /* CONFIG_VMAP_PFN */
 
+static inline unsigned int
+__vmalloc_area_node_get_pages(gfp_t gfp, int nid, unsigned int page_order,
+	unsigned long nr_small_pages, struct page **pages)
+{
+	unsigned int nr_allocated = 0;
+
+	/*
+	 * For order-0 pages we make use of bulk allocator, if
+	 * the page array is partly or not at all populated due
+	 * to fails, fallback to a single page allocator that is
+	 * more permissive.
+	 */
+	if (!page_order)
+		nr_allocated = alloc_pages_bulk_array_node(
+			gfp, nid, nr_small_pages, pages);
+
+	/* High-order pages or fallback path if "bulk" fails. */
+	while (nr_allocated < nr_small_pages) {
+		struct page *page;
+		int i;
+
+		/*
+		 * Compound pages required for remap_vmalloc_page if
+		 * high-order pages. For the order-0 the __GFP_COMP
+		 * is ignored.
+		 */
+		page = alloc_pages_node(nid, gfp | __GFP_COMP, page_order);
+		if (unlikely(!page))
+			break;
+
+		/*
+		 * Careful, we allocate and map page_order pages, but
+		 * tracking is done per PAGE_SIZE page so as to keep the
+		 * vm_struct APIs independent of the physical/mapped size.
+		 */
+		for (i = 0; i < (1U << page_order); i++)
+			pages[nr_allocated + i] = page + i;
+
+		if (gfpflags_allow_blocking(gfp))
+			cond_resched();
+
+		nr_allocated += 1U << page_order;
+	}
+
+	return nr_allocated;
+}
+
 static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 				 pgprot_t prot, unsigned int page_shift,
 				 int node)
@@ -2789,37 +2836,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
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
+	area->nr_pages = __vmalloc_area_node_get_pages(gfp_mask,
+		node, page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
<snip>

--
Vlad Rezki
