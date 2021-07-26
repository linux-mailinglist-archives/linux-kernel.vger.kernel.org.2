Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125DE3D518B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 05:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhGZCpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 22:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhGZCpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 22:45:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046CEC061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 20:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RAkBaJcAPELwC1B8vW73sx7vizUe93GJAbJNf3OG52M=; b=VMhfcOenwLocwQgQFJRBi6pOF6
        UDsA1qkO06DXplKF1DK1+mmux5fNS0BbB+g/1x5Tjn+Jdd+/rxEIx5FM+5PVR4StyB0Ht8B0X0IQB
        uLZOOHhtbtneM6GDfaHeHHyWTaDMR7IhluBwJkh01zAEUhXKmUiUJ0r3b72gYz018sbPFKsZad3J5
        hAWyOWY5DgMF+5TjOe6zkib+Q7r4LcfWxustvpsXI82S064qpDfUBapEGXc0OQY9FJeO2IECz4g+o
        cNHFz9KyURgqwAZjPQZkAwLJEdmbJx+4rlOQlCesQqFOpMGloYeVuRstkEOz9SIZeZVNhsUPP/tDX
        5o2GuvQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7rFL-00DYm4-34; Mon, 26 Jul 2021 03:25:42 +0000
Date:   Mon, 26 Jul 2021 04:25:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        weiyongjun1@huawei.com
Subject: Re: [PATCH] mm/vmalloc: add missing __GFP_HIGHMEM flag for vmalloc
Message-ID: <YP4rM7qtSet+H+nG@casper.infradead.org>
References: <20210726032333.3404164-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726032333.3404164-1-chenwandun@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 11:23:33AM +0800, Chen Wandun wrote:
> struct page array can also be allocated in highmem during vmalloc,
> that will ease the low memory stress in 32bit system.

Huh?  Where does it get kmapped in order to access it?

> Fixes: f255935b9767 ("mm: cleanup the gfp_mask handling in __vmalloc_area_node")
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  mm/vmalloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 3824dc16ce1c..8d9b0b08a6dc 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2885,7 +2885,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  
>  	/* Please note that the recursion is strictly bounded. */
>  	if (array_size > PAGE_SIZE) {
> -		area->pages = __vmalloc_node(array_size, 1, nested_gfp, node,
> +		area->pages = __vmalloc_node(array_size, 1,
> +					nested_gfp | __GFP_HIGHMEM, node,
>  					area->caller);
>  	} else {
>  		area->pages = kmalloc_node(array_size, nested_gfp, node);
> -- 
> 2.25.1
> 
> 
