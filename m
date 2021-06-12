Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F8F3A4FBB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhFLQSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 12:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhFLQSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 12:18:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AF9C061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=53tO8p11whzwQRzfUP/thFEN7SV4qqVV48LGg1lsp/c=; b=MUYUHWqS6VqZY1nT3jcgwZIsQz
        W4mpQ3Ge1gE85Y3GalrWVDT/yFjEm5674k8+5qYgw09qeQZfdWr1b2DUo3U+/ju+8HWt7TzPd/KLh
        Vet0QiEAQYiM7glZ3UC18+/KL9kHPEmY6VpH0K4httYhNEneJKbCO995IUkJBl3tNt9JB0ChzFtk+
        gHwTzM9rlktg2E2fZr9FgUA3cmiEMov5GUftKjApuo0MmzFAJ/+mXQuUxD4Lg9QJSDOLCFgAQSlEs
        qSpEGILXon4i7riaMVA8vuK/y1uclgUpNjKtGJXqDbUc5KehcpSPXMp/3rBBE0TeT3VXn65NGCS78
        cJ+lfaSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ls6IX-003qN7-7p; Sat, 12 Jun 2021 16:15:56 +0000
Date:   Sat, 12 Jun 2021 17:15:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhang Yi <wetpzy@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Neel Natu <neelnatu@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, futex: Fix shared futex pgoff on shmem huge page
Message-ID: <YMTdtRZG+7q8OtkK@casper.infradead.org>
References: <45e8fd67-51fd-7828-fe43-d261d6c33727@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45e8fd67-51fd-7828-fe43-d261d6c33727@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 09:31:16PM -0700, Hugh Dickins wrote:
> +++ linux/include/linux/pagemap.h	2021-06-11 17:30:28.726720252 -0700
> @@ -516,8 +516,7 @@ static inline struct page *read_mapping_
>  }
>  
>  /*
> - * Get index of the page with in radix-tree
> - * (TODO: remove once hugetlb pages will have ->index in PAGE_SIZE)
> + * Get index of the page within radix-tree (but not for hugetlb pages).
>   */

I think the TODO should be retained.  It's still something that I
intend to do.

>  static inline pgoff_t page_to_pgoff(struct page *page)
>  {
> -	if (unlikely(PageHeadHuge(page)))
> -		return page->index << compound_order(page);
> -
> +	if (unlikely(PageHuge(page))) {
> +		extern pgoff_t hugetlb_basepage_index(struct page *page);
> +		return hugetlb_basepage_index(page);
> +	}
>  	return page_to_index(page);
>  }

Yes, this change absolutely makes sense.  It's just a landmine if it
returns the right answer for some tail pages but garbage for other
kinds of tail pages.

> --- 5.13-rc5/mm/hugetlb.c	2021-06-06 16:57:26.263006733 -0700
> +++ linux/mm/hugetlb.c	2021-06-11 17:30:28.730720276 -0700
> @@ -1588,15 +1588,12 @@ struct address_space *hugetlb_page_mappi
>  	return NULL;
>  }
>  
> -pgoff_t __basepage_index(struct page *page)
> +pgoff_t hugetlb_basepage_index(struct page *page)
>  {
>  	struct page *page_head = compound_head(page);
>  	pgoff_t index = page_index(page_head);
>  	unsigned long compound_idx;
>  
> -	if (!PageHuge(page_head))
> -		return page_index(page);
> -
>  	if (compound_order(page_head) >= MAX_ORDER)
>  		compound_idx = page_to_pfn(page) - page_to_pfn(page_head);
>  	else
> 

urgh.  this trailing bit should be:

#if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
	compound_idx = page_to_pfn(page) - page_to_pfn(page_head);
#else
	compound_idx = page - page_head;
#endif
