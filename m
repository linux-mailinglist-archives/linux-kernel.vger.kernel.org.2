Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2AF32AD50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378234AbhCBVgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577331AbhCBSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:50:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B77C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:49:10 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bm21so18422993ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GO9uM42GAO9SsEmJ1Ud/XfdUbUemfb0O0igeT0Ei1wY=;
        b=t+mQ5V1ZRGfRvpmCdmHEuOP/59c00rtGZORfMYX7HKfUuez4VJ7P/g2stb8yyUNxst
         3ZAjAlPey5b3CJ3WR9ZbMsryiwCGUNYW/0V8k9FMVnjy6hJjBWpzfjjD5WpEm6YYL4Ab
         VDVjDBBF9XKN9hploWg3HlOF7IJYNs9JpTZHCCfJCqxXUQNTQhM9W/yR+CCle7AFglTR
         JwLV/77YC40As4lBp9/jzI2lXuADBhVnmmb+HnWiJk2/vGhM19JJYzR+iTV/3LAzusQI
         oiynfHyWGcjdPd9LU0vnZFJxy701IOZKSClNV6a/o2PekNWwL2Y9/I8/ZykzPbqZDnFy
         ynbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GO9uM42GAO9SsEmJ1Ud/XfdUbUemfb0O0igeT0Ei1wY=;
        b=SV9VMzPYxXgKwYpscaggr8GV4dhY1++G1Ehv1BWvT9dTW0YmzmfKSmIKhQUVxLeIOJ
         T7TVDFvm+PFwrL8OUircTNDhZuLTQbY9oIrbuAOLtNbRvHhtUSn/KS08V298MZYKI5Xo
         bylw/KJay+crI+TLECLnuH8wYAIx7BlUourHNFMYN7Q1OXN2+m2oT4z8/kOQt0O0m0kl
         9FDBXfTnCOVZvOhe/JRyP2RAWwojAkqKnZ9/lwunojSbSUb96nR4b30que+yGlzL7roI
         wD7ybJ/QiHBzqnildYIXVVQ56rwemubZqfC1eVXyGkTHpS/PfjF3jK+6m2G/o/yYH1fJ
         cf9Q==
X-Gm-Message-State: AOAM532CA9d76od3MoQhoCVvpDu/eS46CVOmC0doDh5ribj1EZYclvN2
        QAKEve6ojHKfWc1Q0EsV4BTJhpJWNqKQYWsw
X-Google-Smtp-Source: ABdhPJwb8YWbEvP6/92V8OGZy5T5rSbr0v1ooPw/xvrT+z5mCXBhQ92a6NJ3tpmWPZhGNU0QVNj88Q==
X-Received: by 2002:a17:906:a157:: with SMTP id bu23mr21374870ejb.491.1614710949643;
        Tue, 02 Mar 2021 10:49:09 -0800 (PST)
Received: from enceladus (ppp-94-64-113-158.home.otenet.gr. [94.64.113.158])
        by smtp.gmail.com with ESMTPSA id w24sm1645164edt.44.2021.03.02.10.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 10:49:09 -0800 (PST)
Date:   Tue, 2 Mar 2021 20:49:06 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Net <netdev@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-NFS <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] net: page_pool: refactor dma_map into own function
 page_pool_dma_map
Message-ID: <YD6IosORkdRN9B2x@enceladus>
References: <20210301161200.18852-1-mgorman@techsingularity.net>
 <20210301161200.18852-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301161200.18852-5-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mel,

Can you please CC me in future revisions. I almost missed that!

On Mon, Mar 01, 2021 at 04:11:59PM +0000, Mel Gorman wrote:
> From: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> In preparation for next patch, move the dma mapping into its own
> function, as this will make it easier to follow the changes.
> 
> V2: make page_pool_dma_map return boolean (Ilias)
> 

[...]

>  static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
>  						 gfp_t _gfp)
>  {
> +	unsigned int pp_flags = pool->p.flags;
>  	struct page *page;
>  	gfp_t gfp = _gfp;
> -	dma_addr_t dma;
>  
>  	/* We could always set __GFP_COMP, and avoid this branch, as
>  	 * prep_new_page() can handle order-0 with __GFP_COMP.
> @@ -211,30 +234,14 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
>  	if (!page)
>  		return NULL;
>  
> -	if (!(pool->p.flags & PP_FLAG_DMA_MAP))
> -		goto skip_dma_map;
> -
> -	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
> -	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
> -	 * into page private data (i.e 32bit cpu with 64bit DMA caps)
> -	 * This mapping is kept for lifetime of page, until leaving pool.
> -	 */
> -	dma = dma_map_page_attrs(pool->p.dev, page, 0,
> -				 (PAGE_SIZE << pool->p.order),
> -				 pool->p.dma_dir, DMA_ATTR_SKIP_CPU_SYNC);
> -	if (dma_mapping_error(pool->p.dev, dma)) {
> +	if (pp_flags & PP_FLAG_DMA_MAP &&

Nit pick but can we have if ((pp_flags & PP_FLAG_DMA_MAP) && ...

> +	    unlikely(!page_pool_dma_map(pool, page))) {
>  		put_page(page);
>  		return NULL;
>  	}
> -	page->dma_addr = dma;
>  
> -	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
> -		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
> -
> -skip_dma_map:
>  	/* Track how many pages are held 'in-flight' */
>  	pool->pages_state_hold_cnt++;
> -
>  	trace_page_pool_state_hold(pool, page, pool->pages_state_hold_cnt);
>  
>  	/* When page just alloc'ed is should/must have refcnt 1. */
> -- 
> 2.26.2
> 

Otherwise 
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org> 
