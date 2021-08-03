Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375363DEBB5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbhHCL1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhHCL06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB81CC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 04:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BuLiq12RG7B36khxihK0IUw3DFZDJm8AYh2kdikH7as=; b=DU79JUdwPuDo5xJJBlBqhuRymq
        XSd0/JsKh9QWGkXc1vaPCOSm46mlm3MD1Wt+9J6UY/zxsY9Ys73QosNfI4V3UQVhFBrKCAPPSW7hh
        ouStu9WkOMaYpoGz+Wwcv4MPY+9nzZsKk+UUsw7zJPpyXjpxiPdwxtIatl5P0V7xIKpXEoAgG+w8o
        fAEUhurdlgp29ocMYODX8vhV4kuKYqHYhBCz1aIr0WEak5/g/l/SnrZBoIdOsh7xzodsuIt5G6lAV
        nL7yPtI8QRZyNhBDCLl+5ELB1WsBYiwhS6+fVSNLKPghvRqcBr4MI+zmJ4HBYIdRAbkOk9hgQOMwM
        PA5oHOsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mAsYB-004ZRc-AN; Tue, 03 Aug 2021 11:25:40 +0000
Date:   Tue, 3 Aug 2021 12:25:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, Shuang Zhai <zhais@google.com>
Subject: Re: [PATCH 3/3] mm: don't remap clean subpages when splitting
 isolated thp
Message-ID: <YQknr97njybzQ3be@casper.infradead.org>
References: <20210731063938.1391602-1-yuzhao@google.com>
 <20210731063938.1391602-4-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731063938.1391602-4-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2021 at 12:39:38AM -0600, Yu Zhao wrote:
> +++ b/mm/migrate.c
> @@ -168,14 +168,53 @@ void putback_movable_pages(struct list_head *l)
>  	}
>  }
>  
> +static bool try_to_unmap_clean(struct page_vma_mapped_walk *pvmw, struct page *page)
> +{
> +	void *addr;
> +	bool dirty;
> +
> +	VM_BUG_ON_PAGE(PageLRU(page), page);
> +	VM_BUG_ON_PAGE(PageCompound(page), page);
> +	VM_BUG_ON_PAGE(!PageAnon(page), page);
> +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> +	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
> +
> +	if (PageMlocked(page) || (pvmw->vma->vm_flags & VM_LOCKED))
> +		return false;
> +
> +	/*
> +	 * The pmd entry mapping the old thp was flushed and the pte mapping
> +	 * this subpage has been non present. Therefore, this subpage is
> +	 * inaccessible. We don't need to remap it if it contains only zeros.
> +	 */
> +	addr = kmap_atomic(page);
> +	dirty = !!memchr_inv(addr, 0, PAGE_SIZE);
> +	kunmap_atomic(addr);

kmap_local() is preferred now.  Also, Linus has a particular hatred for
the !! idiom; just compare against NULL.

