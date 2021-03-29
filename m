Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0771F34D78C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhC2SpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhC2Soy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:44:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 11:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vmsx7Izy3wRv8jlDW+rJXfVq200TFsqarucnACsW650=; b=XNSuBR/SIgoI+hFeIAiDjbXYGn
        aAI8EYWJtwNER0m/VGH7hfj4sklD55vbwncb/rYvu/rBOb7HrW/mqh04jFO/henTznsf0jjJOM76I
        AOlrcxdY1DFDkW/8NpxzqgfIOJxrLCDVza3jUOWFyQVctOSBL2xOzgO6IgSFL9zPTekLc6TuM7LnX
        0apHvEoO8YIoRT1WAxVnQStPVlbfC4mGkMKmcTKRB2ob4nhslHWLgy3bx9W4xWasmKmzJidbccHWy
        8H2ZULjMVOT3t2q8ugKwcDey8X1GEQWfC2p9f8KwWJG5fvMGqNmR7C/obesTVR4wBi8Ki6Vso+1fS
        5Fr0bjHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQwsJ-001y6W-Pl; Mon, 29 Mar 2021 18:44:36 +0000
Date:   Mon, 29 Mar 2021 19:44:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: change size_t to unsigned int for cma_alloc
Message-ID: <20210329184431.GJ351017@casper.infradead.org>
References: <20210329182553.3129234-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329182553.3129234-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:25:53AM -0700, Minchan Kim wrote:
> size_t in cma_alloc is confusing since it makes people think
> it's byte count, not pages. Fix it.

i think it has to be unsigned long.

67a2e213e7e937c41c52ab5bc46bf3f4de469f6e

> Link: https://lore.kernel.org/linux-mm/20210324043434.GP1719932@casper.infradead.org/
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/linux/cma.h | 2 +-
>  mm/cma.c            | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 217999c8a762..a873edc20ca2 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -44,7 +44,7 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  					unsigned int order_per_bit,
>  					const char *name,
>  					struct cma **res_cma);
> -extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> +extern struct page *cma_alloc(struct cma *cma, unsigned int count, unsigned int align,
>  			      bool no_warn);
>  extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
>  
> diff --git a/mm/cma.c b/mm/cma.c
> index 08c45157911a..24dc01e26d45 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -423,21 +423,21 @@ static inline void cma_debug_show_areas(struct cma *cma) { }
>   * This function allocates part of contiguous memory on specific
>   * contiguous memory area.
>   */
> -struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> +struct page *cma_alloc(struct cma *cma, unsigned int count, unsigned int align,
>  		       bool no_warn)
>  {
>  	unsigned long mask, offset;
>  	unsigned long pfn = -1;
>  	unsigned long start = 0;
>  	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
> -	size_t i;
> +	unsigned int i;
>  	struct page *page = NULL;
>  	int ret = -ENOMEM;
>  
>  	if (!cma || !cma->count || !cma->bitmap)
>  		goto out;
>  
> -	pr_debug("%s(cma %p, count %zu, align %d)\n", __func__, (void *)cma,
> +	pr_debug("%s(cma %p, count %u, align %d)\n", __func__, (void *)cma,
>  		 count, align);
>  
>  	if (!count)
> @@ -500,7 +500,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  	}
>  
>  	if (ret && !no_warn) {
> -		pr_err_ratelimited("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
> +		pr_err_ratelimited("%s: %s: alloc failed, req-size: %u pages, ret: %d\n",
>  				   __func__, cma->name, count, ret);
>  		cma_debug_show_areas(cma);
>  	}
> -- 
> 2.31.0.291.g576ba9dcdaf-goog
> 
> 
