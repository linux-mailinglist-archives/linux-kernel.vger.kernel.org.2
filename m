Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED17337610
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhCKOq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhCKOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:46:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39534C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hy7ALj/J1rQvdVOF3M7n1V5Y6apOBeWxycg4H+4BgN8=; b=AMi9vEiEpzJPWphuoI+85+T4jJ
        3AN9UFMe0jBLbFWhITE8FkUztRnENJPSua5SCtlfz1DPF3QHo4pQxLS0PWZsczMDPJy1LAAE0EQQC
        sPIlLGT8RlD0nXRUb7Z3Q+Es1ExiEAdnA29XA7Kc9489NzgL5Py4yfMmESkX5iXFBWqjvabQ6RtP5
        XJz1soF6vsHpaWSfKV/yPhPWZKzX2frUOip251ypWJNavaGUjWldvxK/EvcKsY9rnUl6bYqNndABV
        k+5IqtzAAEJY6s9PwyyMDkcy99SgGkenkPZnBItZo6dmQ7+oIvrgiLkHxY9ViiVlPb/OTH5X4Uk1k
        qYRM7upA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKMZZ-007RGO-3p; Thu, 11 Mar 2021 14:46:00 +0000
Date:   Thu, 11 Mar 2021 14:45:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1] mm, hwpoison: enable error handling on shmem thp
Message-ID: <20210311144557.GV3479805@casper.infradead.org>
References: <20210209062128.453814-1-nao.horiguchi@gmail.com>
 <alpine.LSU.2.11.2103102214170.7159@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103102214170.7159@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 11:22:18PM -0800, Hugh Dickins wrote:
> But something we found on the way,
> we do have a patch for: add_to_kill() uses page_address_in_vma(), but
> that has not been used on file THP tails before - fix appended at the
> end below, so as not to waste your time on that bit.

> [PATCH] mm: fix page_address_in_vma() on file THP tails
> From: Jue Wang <juew@google.com>
> 
> Anon THP tails were already supported, but memory-failure now needs to use
> page_address_in_vma() on file THP tails, which its page->mapping check did
> not permit: fix it.
> 
> Signed-off-by: Jue Wang <juew@google.com>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> 
>  mm/rmap.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- 5.12-rc2/mm/rmap.c	2021-02-28 16:58:57.950450151 -0800
> +++ linux/mm/rmap.c	2021-03-10 20:29:21.591475177 -0800
> @@ -717,11 +717,11 @@ unsigned long page_address_in_vma(struct
>  		if (!vma->anon_vma || !page__anon_vma ||
>  		    vma->anon_vma->root != page__anon_vma->root)
>  			return -EFAULT;
> -	} else if (page->mapping) {
> -		if (!vma->vm_file || vma->vm_file->f_mapping != page->mapping)
> -			return -EFAULT;
> -	} else
> +	} else if (!vma->vm_file) {
> +		return -EFAULT;
> +	} else if (vma->vm_file->f_mapping != compound_head(page)->mapping) {
>  		return -EFAULT;
> +	}

This is a common bug I'm seeing; people just assume they can dereference
page->mapping.  Below is how I would convert this patch into folios, but
it doesn't remove the problem that people just use page->mapping.

Do we want to set ourselves the goal of making this bug impossible?  That
is, eventually, do something like this ...

struct folio {
	union {
		struct page page;
		struct {
			unsigned long flags;
			struct list_head lru;
			struct address_space *mapping;
			pgoff_t index;
			unsigned long private;
		};
	};
};

... and remove the names 'mapping' & 'index' from struct page.
If so, now would be a good time to prepare for that, so we write
folio->mapping instead of folio->page.mapping.

diff --git a/mm/rmap.c b/mm/rmap.c
index 3142ea1dd071..fcad8c6a417a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -707,9 +707,11 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
  */
 unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
 {
+	struct folio *folio = page_folio(page);
 	unsigned long address;
-	if (PageAnon(page)) {
-		struct anon_vma *page__anon_vma = page_anon_vma(page);
+
+	if (FolioAnon(folio)) {
+		struct anon_vma *page__anon_vma = folio_anon_vma(folio);
 		/*
 		 * Note: swapoff's unuse_vma() is more efficient with this
 		 * check, and needs it to match anon_vma when KSM is active.
@@ -717,9 +719,10 @@ unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
 		if (!vma->anon_vma || !page__anon_vma ||
 		    vma->anon_vma->root != page__anon_vma->root)
 			return -EFAULT;
-	} else if (page->mapping) {
-		if (!vma->vm_file || vma->vm_file->f_mapping != page->mapping)
-			return -EFAULT;
+	} else if (!vma->vm_file) {
+		return -EFAULT;
+	} else if (vma->vm_file->f_mapping != folio->page.mapping) {
+		return -EFAULT;
 	} else
 		return -EFAULT;
 	address = __vma_address(page, vma);
diff --git a/mm/util.c b/mm/util.c
index 9ab72cfa4aa1..91ac4fc90a07 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -635,11 +635,11 @@ void kvfree_sensitive(const void *addr, size_t len)
 }
 EXPORT_SYMBOL(kvfree_sensitive);
 
-static inline void *__page_rmapping(struct page *page)
+static inline void *folio_rmapping(struct folio *folio)
 {
 	unsigned long mapping;
 
-	mapping = (unsigned long)page->mapping;
+	mapping = (unsigned long)folio->page.mapping;
 	mapping &= ~PAGE_MAPPING_FLAGS;
 
 	return (void *)mapping;
@@ -648,8 +648,7 @@ static inline void *__page_rmapping(struct page *page)
 /* Neutral page->mapping pointer to address_space or anon_vma or other */
 void *page_rmapping(struct page *page)
 {
-	page = compound_head(page);
-	return __page_rmapping(page);
+	return folio_rmapping(page_folio(page));
 }
 
 /*
@@ -675,15 +674,12 @@ bool page_mapped(struct page *page)
 }
 EXPORT_SYMBOL(page_mapped);
 
-struct anon_vma *page_anon_vma(struct page *page)
+struct anon_vma *folio_anon_vma(struct folio *folio)
 {
-	unsigned long mapping;
-
-	page = compound_head(page);
-	mapping = (unsigned long)page->mapping;
+	unsigned long mapping = (unsigned long)folio->page.mapping;
 	if ((mapping & PAGE_MAPPING_FLAGS) != PAGE_MAPPING_ANON)
 		return NULL;
-	return __page_rmapping(page);
+	return folio_rmapping(folio);
 }
 
 struct address_space *folio_mapping(struct folio *folio)
