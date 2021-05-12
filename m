Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9301537B469
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhELDRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:17:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2DCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 20:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b3q1cOi5vzb/fYvgXV1ILp6S0UFGe9AtTSyL/tGSRuc=; b=v7uCNGf4pSOH3gT0X6IjJcmOHy
        JI9VLLn7NG+T1g8+fnu/w62HMsQbejNHTFcV3+ygfzu/NIIUBqe6ZjZTumpwYMqUv3Zd3eyHxz1vF
        3oe+WHrz8qHgArXsllzikF9Gjg1WPqob0mFeHjDAg1/M6LpV/5RfuVLYhcDvBYAhRb2C82QP+zart
        52ppKfh4FYvku2hRRvDc0HGfffDtqOO5Etg28OxY6naqBhTZ+pstUX4HYY58nfsM5Mykb9tIIKZpm
        mO+sJqw9s9OuT1rpXJCxAk/m1Q42eqP99HTHNV7vZGlQofAIjIE1wsAsdligDMqc2/WFXyOOhnZTl
        io6C0rRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgfLB-007taj-9F; Wed, 12 May 2021 03:15:28 +0000
Date:   Wed, 12 May 2021 04:15:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/debug: Check page poisoned firstly in dump_page()
Message-ID: <YJtIRR2NfpRtYQrG@casper.infradead.org>
References: <20210512031057.13580-1-wangkefeng.wang@huawei.com>
 <20210512031057.13580-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512031057.13580-3-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 11:10:57AM +0800, Kefeng Wang wrote:
> If page is poisoned, it will crash when we call some page related
> functions, so must check whether the page is poisoned or not firstly.

https://lore.kernel.org/linux-mm/20210430145549.2662354-4-willy@infradead.org/

> Fixes: 6197ab984b41 ("mm: improve dump_page() for compound pages")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/debug.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index 84cdcd0f7bd3..cf84cd9df527 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -44,20 +44,19 @@ const struct trace_print_flags vmaflag_names[] = {
>  
>  static void __dump_page(struct page *page, const char *reason)
>  {
> -	struct page *head = compound_head(page);
> +	struct page *head = NULL;
>  	struct address_space *mapping;
> -	bool page_poisoned = PagePoisoned(page);
> -	bool compound = PageCompound(page);
> +	bool compound;
>  	/*
>  	 * Accessing the pageblock without the zone lock. It could change to
>  	 * "isolate" again in the meantime, but since we are just dumping the
>  	 * state for debugging, it should be fine to accept a bit of
>  	 * inaccuracy here due to racing.
>  	 */
> -	bool page_cma = is_migrate_cma_page(page);
> +	bool page_cma;
>  	int mapcount;
>  	char *type = "";
> -
> +	bool page_poisoned = PagePoisoned(page);
>  	/*
>  	 * If struct page is poisoned don't access Page*() functions as that
>  	 * leads to recursive loop. Page*() check for poisoned pages, and calls
> @@ -68,6 +67,10 @@ static void __dump_page(struct page *page, const char *reason)
>  		goto hex_only;
>  	}
>  
> +	head = compound_head(page);
> +	page_poisoned = PagePoisoned(page);
> +	page_cma = is_migrate_cma_page(page);
> +
>  	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
>  		/*
>  		 * Corrupt page, so we cannot call page_mapping. Instead, do a
> @@ -178,7 +181,7 @@ static void __dump_page(struct page *page, const char *reason)
>  	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>  			sizeof(unsigned long), page,
>  			sizeof(struct page), false);
> -	if (head != page)
> +	if (head && head != page)
>  		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
>  			sizeof(unsigned long), head,
>  			sizeof(struct page), false);
> -- 
> 2.26.2
> 
> 
