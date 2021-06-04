Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5015539BEED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFDRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:38:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225EAC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ScPrT6dq7UFJNtAcHi3Kbb1lZ9AVwXDNeiWLjZz5Hno=; b=IFknYVnj7BNmGV8UkYrFPHR9go
        /U25Wt3qA+aBjWwinMkr5ZcaL1blgrRaaHgmmrJyaI9Mq3Hw49qyfEmiX4BsHyjMiAf9sHDi/UoiM
        1IYGGWy+hKDlGkUOAKIZQbSaMtX0jPuT9EIfvlVsMZ/qi/Z4owJpy4ssubuG8GC+36l07hoqB4wRD
        QSgHGtOGMwJ8pcdWyABdGQW4aostYqvZdGiDPnWrk/KVAq3SBiJF/myIXMevkQJjhmHx1w+5z/ReN
        lnbtmUQsWFoBe4dNhvF6D5PL3/vdFk/RojcdILzRK8qP9t05CwrAfOWO/+Cmpf/ebqVnPLWhuCMIU
        6iZBFu6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lpDju-00DQyc-GU; Fri, 04 Jun 2021 17:36:13 +0000
Date:   Fri, 4 Jun 2021 18:36:10 +0100
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
Subject: Re: [PATCH v2 3/7] mm/thp: fix vma_address() if virtual address
 below file offset
Message-ID: <YLpkirfozSeH4F8N@casper.infradead.org>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011408020.2148@eggly.anvils>
 <YLanDVVbKwwPmW/0@casper.infradead.org>
 <alpine.LSU.2.11.2106031427200.11704@eggly.anvils>
 <alpine.LSU.2.11.2106031436390.11704@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106031436390.11704@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 02:40:30PM -0700, Hugh Dickins wrote:
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
> +		   pgoff + compound_nr(page) > vma->vm_pgoff) {

I think on 32-bit, you need ...

		   pgoff + compound_nr(page) - 1 >= vma->vm_pgoff

... right?

> +		address = vma->vm_start;
> +	} else {
> +		address = -EFAULT;
> +	}
> +	return address;
>  }
