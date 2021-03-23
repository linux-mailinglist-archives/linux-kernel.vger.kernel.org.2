Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0D345E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhCWMzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhCWMzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:55:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675B6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LTQEMCkZdiBXrLcpX0fP9V/zBXP3nEkqVdlVQQ2MTjE=; b=FZGahySoelD/j9c7Bm8wddQJGw
        966+pphwKL3Tb3ETkw+oHfZDIyvpPNhRmwp90/cdsi0oDR/kRWB01pDYErZrv3FfPlGvJz1vMsiRH
        KopKbMyhZz9dGtIyGKu1aYtLKlC43KXE071VFy9imHYz6N/ZFw6bj7DPPEoYRRoMGDr3H+fGLRc1P
        bnAGh652qFU2WTRx5OYrkT+CW61CcLgYTQIswre6cmXut4XMDhLi4nd9nnl8vQU7BE2tigkjiACQg
        tGvvXQWOaU8g5Wpr1GkxGgtPIuNHmUSON6w12ink243xND2t6arvNm5s9GzvYrHq65FJWQPcGd+eI
        oOVwuIRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOgXo-00A4AJ-Lf; Tue, 23 Mar 2021 12:54:10 +0000
Date:   Tue, 23 Mar 2021 12:54:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH -next] mm, page_alloc: avoid page_to_pfn() in
 move_freepages()
Message-ID: <20210323125400.GE1719932@casper.infradead.org>
References: <20210323131215.934472-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323131215.934472-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:12:15PM +0800, Liu Shixin wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> The start_pfn and end_pfn are already available in move_freepages_block(),
> there is no need to go back and forth between page and pfn in move_freepages
> and move_freepages_block, and pfn_valid_within() should validate pfn first
> before touching the page.

This looks good to me:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

>  static int move_freepages(struct zone *zone,
> -			  struct page *start_page, struct page *end_page,
> +			  unsigned long start_pfn, unsigned long end_pfn,
>  			  int migratetype, int *num_movable)
>  {
>  	struct page *page;
> +	unsigned long pfn;
>  	unsigned int order;
>  	int pages_moved = 0;
>  
> -	for (page = start_page; page <= end_page;) {
> -		if (!pfn_valid_within(page_to_pfn(page))) {
> -			page++;
> +	for (pfn = start_pfn; pfn <= end_pfn;) {
> +		if (!pfn_valid_within(pfn)) {
> +			pfn++;
>  			continue;
>  		}
>  
> +		page = pfn_to_page(pfn);

I wonder if this wouldn't be even better if we did:

	struct page *start_page = pfn_to_page(start_pfn);

	for (pfn = start_pfn; pfn <= end_pfn; pfn++) {
		struct page *page = start_page + pfn - start_pfn;

		if (!pfn_valid_within(pfn))
			continue;

> -
> -			page++;
> +			pfn++;
>  			continue;

... then we can drop the increment of pfn here

>  		}
>  
> @@ -2458,7 +2459,7 @@ static int move_freepages(struct zone *zone,
>  
>  		order = buddy_order(page);
>  		move_to_free_list(page, zone, order, migratetype);
> -		page += 1 << order;
> +		pfn += 1 << order;

... and change this to pfn += (1 << order) - 1;

Do you have any numbers to quantify the benefit of this change?
