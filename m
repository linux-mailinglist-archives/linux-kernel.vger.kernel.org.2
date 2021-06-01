Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD8B397BC6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 23:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhFAVdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 17:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbhFAVdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 17:33:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99902C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N/AlK42fZ61t/CqPDnX2Zk4uh79h6uINaIjBrlZprnY=; b=Gw9cnklpUPhmKaibH4IJtO0ebo
        QpeSUNiWsYGczv1YkXUGfnL0J6XVv+z0qOG08Dk5zqrUnLxtMfuark1gTnuwXFcFuA4z+GGoyphOf
        PZqlipSHtr44vXbHEACZSiDwN+pPJyJ6GB1s4+veyBHMAEOCCghM3bKBEqADLBfQUbW2HU0h/u6wA
        tjgA7Df15JraUBvpn054S+hI4K5MvtpRPxJj0wUVYf2SbdtjjTKN11nDaro+35Wl1exZ3Z8bNU7Md
        auS3XsIiLoqX/YHIET99AIPkC5LeXj+ZO6GQbGt1QoQdMh9czUAcGRZETBhzNOfg82Ppn2ANNWZRu
        2cXWrOMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1loByP-00ASAC-A6; Tue, 01 Jun 2021 21:30:55 +0000
Date:   Tue, 1 Jun 2021 22:30:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mm/thp: fix vma_address() if virtual address below
 file offset
Message-ID: <YLanDVVbKwwPmW/0@casper.infradead.org>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011408020.2148@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106011408020.2148@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 02:09:31PM -0700, Hugh Dickins wrote:
>  static inline unsigned long
> -__vma_address(struct page *page, struct vm_area_struct *vma)
> +vma_address(struct page *page, struct vm_area_struct *vma)
>  {
> -	pgoff_t pgoff = page_to_pgoff(page);
> -	return vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> +	pgoff_t pgoff;
> +	unsigned long address;
> +
> +	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
> +	pgoff = page_to_pgoff(page);
> +	if (pgoff >= vma->vm_pgoff) {
> +		address = vma->vm_start +
> +			((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> +		/* Check for address beyond vma (or wrapped through 0?) */
> +		if (address < vma->vm_start || address >= vma->vm_end)
> +			address = -EFAULT;
> +	} else if (PageHead(page) &&
> +		   pgoff + (1UL << compound_order(page)) > vma->vm_pgoff) {

	} else if (PageHead(page) &&
		   pgoff + compound_nr(page) > vma->vm_pgoff) {

> +vma_address_end(struct page *page, struct vm_area_struct *vma)
>  {
> +	pgoff_t pgoff;
> +	unsigned long address;
> +
> +	VM_BUG_ON_PAGE(PageKsm(page), page);	/* KSM page->index unusable */
> +	pgoff = page_to_pgoff(page);
> +	if (PageHead(page))
> +		pgoff += 1UL << compound_order(page);
> +	else
> +		pgoff++;

Again, can use compound_nr here.  In fact, the whole thing can be:

	pgoff += compound_nr(page);

