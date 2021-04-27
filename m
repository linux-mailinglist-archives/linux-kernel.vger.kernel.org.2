Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA8736BDC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhD0DcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:32:09 -0400
Received: from foss.arm.com ([217.140.110.172]:43416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233909AbhD0DcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:32:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8F04D6E;
        Mon, 26 Apr 2021 20:31:25 -0700 (PDT)
Received: from [10.163.75.249] (unknown [10.163.75.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D4023F694;
        Mon, 26 Apr 2021 20:31:24 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 5/6] mm: Constify get_pfnblock_flags_mask and
 get_pfnblock_migratetype
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210416231531.2521383-1-willy@infradead.org>
 <20210416231531.2521383-6-willy@infradead.org>
Message-ID: <88a0db1e-a26c-c5c2-bac1-a1bacaf01a02@arm.com>
Date:   Tue, 27 Apr 2021 09:02:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416231531.2521383-6-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/21 4:45 AM, Matthew Wilcox (Oracle) wrote:
> The struct page is not modified by these routines, so it can be marked
> const.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pageblock-flags.h |  2 +-
>  mm/page_alloc.c                 | 13 +++++++------
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
> index fff52ad370c1..973fd731a520 100644
> --- a/include/linux/pageblock-flags.h
> +++ b/include/linux/pageblock-flags.h
> @@ -54,7 +54,7 @@ extern unsigned int pageblock_order;
>  /* Forward declaration */
>  struct page;
>  
> -unsigned long get_pfnblock_flags_mask(struct page *page,
> +unsigned long get_pfnblock_flags_mask(const struct page *page,
>  				unsigned long pfn,
>  				unsigned long mask);
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0152670c6f04..4be2179eedd5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -474,7 +474,7 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>  #endif
>  
>  /* Return a pointer to the bitmap storing bits affecting a block of pages */
> -static inline unsigned long *get_pageblock_bitmap(struct page *page,
> +static inline unsigned long *get_pageblock_bitmap(const struct page *page,
>  							unsigned long pfn)
>  {
>  #ifdef CONFIG_SPARSEMEM
> @@ -484,7 +484,7 @@ static inline unsigned long *get_pageblock_bitmap(struct page *page,
>  #endif /* CONFIG_SPARSEMEM */
>  }
>  
> -static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
> +static inline int pfn_to_bitidx(const struct page *page, unsigned long pfn)
>  {
>  #ifdef CONFIG_SPARSEMEM
>  	pfn &= (PAGES_PER_SECTION-1);
> @@ -495,7 +495,7 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
>  }
>  
>  static __always_inline
> -unsigned long __get_pfnblock_flags_mask(struct page *page,
> +unsigned long __get_pfnblock_flags_mask(const struct page *page,
>  					unsigned long pfn,
>  					unsigned long mask)
>  {
> @@ -520,13 +520,14 @@ unsigned long __get_pfnblock_flags_mask(struct page *page,
>   *
>   * Return: pageblock_bits flags
>   */
> -unsigned long get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
> -					unsigned long mask)
> +unsigned long get_pfnblock_flags_mask(const struct page *page,
> +					unsigned long pfn, unsigned long mask)
>  {
>  	return __get_pfnblock_flags_mask(page, pfn, mask);
>  }
>  
> -static __always_inline int get_pfnblock_migratetype(struct page *page, unsigned long pfn)
> +static __always_inline int get_pfnblock_migratetype(const struct page *page,
> +					unsigned long pfn)
>  {
>  	return __get_pfnblock_flags_mask(page, pfn, MIGRATETYPE_MASK);
>  }
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
