Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC88388F72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 15:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353759AbhESNr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 09:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbhESNrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 09:47:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BBFC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6cgVXjYuC8nAsxdiKYXOmR2kYogLXyfB8N1EBy5OUXY=; b=HaSU3bhw5jnd4qwqpRENnQ93F2
        yLj8+K0nqAnZ+MvNqAMILNmedsd6NnrvC/ebJ9IMjGxCW1Nwl7ehR6cDiwa/t1g+Hir5NageHI1kn
        xFk1M8kSTmnYb9g9EFaBkO014Y6XzNPvY9t7OVqg5W9PXBz+G0iTSmvXpg3VXkqe8T9WRMq2dFgXj
        F/BzzEnedATvDETuEqM/tAdrKX1oBgV0+HDJ7qUwVimFOwyFz09QBSrQB1BjuiF/zaaV635GAiRnC
        3QBanmjgsg5IBBCBf/qZWGiJY2O6FWWd/Y8FEro/txJDzxZmufmnG2S+ZS15Zu8fSFk6L/6DcKKzu
        8SrPcmoA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljMUa-00EzH5-SA; Wed, 19 May 2021 13:44:22 +0000
Date:   Wed, 19 May 2021 14:44:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] mm/vmalloc: Switch to bulk allocator in
 __vmalloc_area_node()
Message-ID: <YKUWKFyLdqTYliwu@infradead.org>
References: <20210516202056.2120-1-urezki@gmail.com>
 <20210516202056.2120-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516202056.2120-3-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (!page_order) {
> +		area->nr_pages = alloc_pages_bulk_array_node(
> +			gfp_mask, node, nr_small_pages, area->pages);
> +	} else {
> +		/*
> +		 * Careful, we allocate and map page_order pages, but tracking is done
> +		 * per PAGE_SIZE page so as to keep the vm_struct APIs independent of

Comments over 80 lines are completely unreadable, so please avoid them.

> +		 * the physical/mapped size.
> +		 */
> +		while (area->nr_pages < nr_small_pages) {
> +			struct page *page;
> +			int i;
> +
> +			/* Compound pages required for remap_vmalloc_page */
> +			page = alloc_pages_node(node, gfp_mask | __GFP_COMP, page_order);
> +			if (unlikely(!page))
> +				break;
>  
> +			for (i = 0; i < (1U << page_order); i++)
> +				area->pages[area->nr_pages + i] = page + i;
>  
> +			if (gfpflags_allow_blocking(gfp_mask))
> +				cond_resched();
> +
> +			area->nr_pages += 1U << page_order;
> +		}

In fact splitting this whole high order allocation logic into a little
helper would massivel benefit the function by ordering it more logical
and reducing a level of indentation.

> +	/*
> +	 * If not enough pages were obtained to accomplish an
> +	 * allocation request, free them via __vfree() if any.
> +	 */
> +	if (area->nr_pages != nr_small_pages) {
> +		warn_alloc(gfp_mask, NULL,
> +			"vmalloc size %lu allocation failure: "
> +			"page order %u allocation failed",
> +			area->nr_pages * PAGE_SIZE, page_order);
> +		goto fail;
> +	}

From reading __alloc_pages_bulk not allocating all pages is something
that cn happen fairly easily.  Shouldn't we try to allocate the missing
pages manually and/ore retry here?

> +
> +	if (vmap_pages_range(addr, addr + size, prot, area->pages, page_shift) < 0) {

Another pointlessly long line.
