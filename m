Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2710636BDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhD0Dab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:30:31 -0400
Received: from foss.arm.com ([217.140.110.172]:43366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhD0Da3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:30:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59E0CD6E;
        Mon, 26 Apr 2021 20:29:47 -0700 (PDT)
Received: from [10.163.75.249] (unknown [10.163.75.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3F293F694;
        Mon, 26 Apr 2021 20:29:45 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 2/6] mm/debug: Factor PagePoisoned out of __dump_page
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210416231531.2521383-1-willy@infradead.org>
 <20210416231531.2521383-3-willy@infradead.org>
Message-ID: <22cb33f0-444e-8b04-13eb-b4e2cff949d2@arm.com>
Date:   Tue, 27 Apr 2021 09:00:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416231531.2521383-3-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/21 4:45 AM, Matthew Wilcox (Oracle) wrote:
> Move the PagePoisoned test into dump_page().  Skip the hex print
> for poisoned pages -- we know they're full of ffffffff.  Move the
> reason printing from __dump_page() to dump_page().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/debug.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index 84cdcd0f7bd3..e73fe0a8ec3d 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -42,11 +42,10 @@ const struct trace_print_flags vmaflag_names[] = {
>  	{0, NULL}
>  };
>  
> -static void __dump_page(struct page *page, const char *reason)
> +static void __dump_page(struct page *page)
>  {
>  	struct page *head = compound_head(page);
>  	struct address_space *mapping;
> -	bool page_poisoned = PagePoisoned(page);
>  	bool compound = PageCompound(page);
>  	/*
>  	 * Accessing the pageblock without the zone lock. It could change to
> @@ -58,16 +57,6 @@ static void __dump_page(struct page *page, const char *reason)
>  	int mapcount;
>  	char *type = "";
>  
> -	/*
> -	 * If struct page is poisoned don't access Page*() functions as that
> -	 * leads to recursive loop. Page*() check for poisoned pages, and calls
> -	 * dump_page() when detected.
> -	 */
> -	if (page_poisoned) {
> -		pr_warn("page:%px is uninitialized and poisoned", page);
> -		goto hex_only;
> -	}
> -
>  	if (page < head || (page >= head + MAX_ORDER_NR_PAGES)) {
>  		/*
>  		 * Corrupt page, so we cannot call page_mapping. Instead, do a
> @@ -173,8 +162,6 @@ static void __dump_page(struct page *page, const char *reason)
>  
>  	pr_warn("%sflags: %#lx(%pGp)%s\n", type, head->flags, &head->flags,
>  		page_cma ? " CMA" : "");
> -
> -hex_only:
>  	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>  			sizeof(unsigned long), page,
>  			sizeof(struct page), false);
> @@ -182,14 +169,16 @@ static void __dump_page(struct page *page, const char *reason)
>  		print_hex_dump(KERN_WARNING, "head: ", DUMP_PREFIX_NONE, 32,
>  			sizeof(unsigned long), head,
>  			sizeof(struct page), false);
> -
> -	if (reason)
> -		pr_warn("page dumped because: %s\n", reason);
>  }
>  
>  void dump_page(struct page *page, const char *reason)
>  {
> -	__dump_page(page, reason);
> +	if (PagePoisoned(page))
> +		pr_warn("page:%p is uninitialized and poisoned", page);
> +	else
> +		__dump_page(page);
> +	if (reason)
> +		pr_warn("page dumped because: %s\n", reason);
>  	dump_page_owner(page);
>  }
>  EXPORT_SYMBOL(dump_page);
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
