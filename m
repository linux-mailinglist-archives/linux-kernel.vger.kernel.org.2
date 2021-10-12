Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8336742AD48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 21:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhJLT1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 15:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJLT13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 15:27:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC586C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 12:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Io97xWCIAvhe+Q9IKSft7X2dCSmZRv6fmuAMd3ittU=; b=iaxMuyrlfJD+ROAL3kySF6k/hU
        FTklnjA5ekaLB9Qm7xsCFLWvYfEXqRtAbjZvC3a1juvWqLbyDSOjy4fq1L9oaPhmCzGasrWsbATVJ
        r4qwz/SeNol5SEF8vfzWbs1Iaclro0AY7+khNzfjxlgZhIvOa26BXb4gZg1/OxGy79DBDRa/zspTH
        ObivPVdPCuLo2moHmdBHaliOv+k3LnLY1Vkj7E0iuPOITteEF696W9dmP4zdas7zeqmNYu4JAEd+4
        fea1w+W+M82ALPjS0RrjT6wrcMS6Ebxf8Qq4VWG+JagMYmW83I72RbLCStaD0Q0w8wvEcv6Gw0hLO
        tYW7QWfw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maNN0-006mCo-6N; Tue, 12 Oct 2021 19:23:37 +0000
Date:   Tue, 12 Oct 2021 20:23:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/11] PageSlab: eliminate unnecessary compound_head()
 calls
Message-ID: <YWXgrhRDIxcoBhA1@casper.infradead.org>
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 02:01:37PM -0400, Johannes Weiner wrote:
> PageSlab() currently imposes a compound_head() call on all callsites
> even though only very few situations encounter tailpages. This short
> series bubbles tailpage resolution up to the few sites that need it,
> and eliminates it everywhere else.
> 
> This is a stand-alone improvement. However, it's inspired by Willy's
> patches to split struct slab from struct page. Those patches currently
> resolve a slab object pointer to its struct slab as follows:
> 
> 	slab = virt_to_slab(p);		/* tailpage resolution */
> 	if (slab_test_cache(slab)) {	/* slab or page alloc bypass? */
> 		do_slab_stuff(slab);
> 	} else {
> 		page = (struct page *)slab;
> 		do_page_stuff(page);
> 	}
> 
> which makes struct slab an ambiguous type that needs to self-identify
> with the slab_test_cache() test (which in turn relies on PG_slab in
> the flags field shared between page and slab).
> 
> It would be preferable to do:
> 
> 	page = virt_to_head_page(p);	/* tailpage resolution */
> 	if (PageSlab(page)) {		/* slab or page alloc bypass? */
> 		slab = page_slab(page);
> 		do_slab_stuff(slab);
> 	} else {
> 		do_page_stuff(page);
> 	}
> 
> and leave the ambiguity and the need to self-identify with struct
> page, so that struct slab is a strong and unambiguous type, and a
> non-NULL struct slab encountered in the wild is always a valid object
> without the need to check another dedicated flag for validity first.
> 
> However, because PageSlab() currently implies tailpage resolution,
> writing the virt->slab lookup in the preferred way would add yet more
> unnecessary compound_head() call to the hottest MM paths.
> 
> The page flag helpers should eventually all be weaned off of those
> compound_head() calls for their unnecessary overhead alone. But this
> one in particular is now getting in the way of writing code in the
> preferred manner, and bleeding page ambiguity into the new types that
> are supposed to eliminate specifically that. It's ripe for a cleanup.

So what I had in mind was more the patch at the end (which I now realise
is missing the corresponding changes to __ClearPageSlab()).  There is,
however, some weirdness with kfence, which appears to be abusing PageSlab
by setting it on pages which are not slab pages???

	page = virt_to_page(p);
	if (PageSlab(page)) {		/* slab or page alloc bypass? */
		slab = page_slab(page);	/* tail page resolution */
		do_slab_stuff(slab);
	} else {
		do_page_stuff(page); /* or possibly compound_head(page) */
	}

There could also be a PageTail check in there for some of the cases --
catch people doing something like:
	kfree(kmalloc(65536, GFP_KERNEL) + 16384);
which happens to work today, but should probably not.

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8951da34aa51..b4b62fa100eb 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -344,7 +344,7 @@ PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
 	TESTCLEARFLAG(Active, active, PF_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
 	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
-__PAGEFLAG(Slab, slab, PF_NO_TAIL)
+__PAGEFLAG(Slab, slab, PF_ANY)
 __PAGEFLAG(SlobFree, slob_free, PF_NO_TAIL)
 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
 
diff --git a/mm/slab.c b/mm/slab.c
index d0f725637663..c8c6e8576936 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1371,6 +1371,7 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
 								int nodeid)
 {
 	struct page *page;
+	int i;
 
 	flags |= cachep->allocflags;
 
@@ -1381,7 +1382,8 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
 	}
 
 	account_slab_page(page, cachep->gfporder, cachep, flags);
-	__SetPageSlab(page);
+	for (i = 0; i < compound_nr(page); i++)
+		__SetPageSlab(page + i);
 	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
 	if (sk_memalloc_socks() && page_is_pfmemalloc(page))
 		SetPageSlabPfmemalloc(page);
diff --git a/mm/slub.c b/mm/slub.c
index f7ac28646580..e442cebda4ef 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1916,7 +1916,8 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	account_slab_page(page, oo_order(oo), s, flags);
 
 	page->slab_cache = s;
-	__SetPageSlab(page);
+	for (idx = 0; idx < compound_nr(page); idx++)
+		__SetPageSlab(page + idx);
 	if (page_is_pfmemalloc(page))
 		SetPageSlabPfmemalloc(page);
 

