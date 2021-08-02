Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D193DE345
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 01:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhHBXwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 19:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232208AbhHBXwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 19:52:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91C0560EE6;
        Mon,  2 Aug 2021 23:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627948348;
        bh=9vSRnJfBD9lgwL64I4OrHlQlDF+8XGMW3KrAv+VkKj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAgsx2AOzYLQuNhnaD5z8l1cBuS4mwMxRGJ1FNW72cMu97jxC9Vvm44KfqSNjV8qo
         rDqHCGffC1zTInM+yutb8XZAEkj1jU/AXjiF8wwpqjbcxlAbP4UpKm/gjxRo/gJ20y
         lcI0kzdhKCH8N4rfvX/JS2O/M3B//quUMB5NSaM5xDa24Qlvz3Z2KAEBFrbv8F0iwf
         74OJJZR7vWzg2EIK8O3bTVECMSoRB+aK2rX7otyGqOQyskHtgRHU4T9II/zo3/OMaE
         j0nb5EFslvZy1V4x2h2CHxs76ov1SOtpHq9e3NHnmVJ29MbItWhBiXgngUDiJ4owcI
         K1TWatoBAaF0w==
Date:   Mon, 2 Aug 2021 16:52:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Wang Hai <wanghai38@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] slub: fix kmalloc_pagealloc_invalid_free unit test
Message-ID: <YQiFNwdFb4DRwykI@archlinux-ax161>
References: <20210802180819.1110165-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802180819.1110165-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 11:08:18AM -0700, Shakeel Butt wrote:
> The unit test kmalloc_pagealloc_invalid_free makes sure that for the
> higher order slub allocation which goes to page allocator, the free is
> called with the correct address i.e. the virtual address of the head
> page.
> 
> The commit f227f0faf63b ("slub: fix unreclaimable slab stat for bulk
> free") unified the free code paths for page allocator based slub
> allocations but instead of using the address passed by the caller, it
> extracted the address from the page. Thus making the unit test
> kmalloc_pagealloc_invalid_free moot. So, fix this by using the address
> passed by the caller.
> 
> Should we fix this? I think yes because dev expect kasan to catch these
> type of programming bugs.
> 
> Fixes: f227f0faf63b ("slub: fix unreclaimable slab stat for bulk free")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Thank you for the quick fix! It passes my tests on arm64 and x86_64 in
QEMU with a few different clang versions.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  mm/slub.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index af984e4990e8..60aeedc436d5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3236,12 +3236,12 @@ struct detached_freelist {
>  	struct kmem_cache *s;
>  };
>  
> -static inline void free_nonslab_page(struct page *page)
> +static inline void free_nonslab_page(struct page *page, void *object)
>  {
>  	unsigned int order = compound_order(page);
>  
>  	VM_BUG_ON_PAGE(!PageCompound(page), page);
> -	kfree_hook(page_address(page));
> +	kfree_hook(object);
>  	mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
>  	__free_pages(page, order);
>  }
> @@ -3282,7 +3282,7 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
>  	if (!s) {
>  		/* Handle kalloc'ed objects */
>  		if (unlikely(!PageSlab(page))) {
> -			free_nonslab_page(page);
> +			free_nonslab_page(page, object);
>  			p[size] = NULL; /* mark object processed */
>  			return size;
>  		}
> @@ -4258,7 +4258,7 @@ void kfree(const void *x)
>  
>  	page = virt_to_head_page(x);
>  	if (unlikely(!PageSlab(page))) {
> -		free_nonslab_page(page);
> +		free_nonslab_page(page, object);
>  		return;
>  	}
>  	slab_free(page->slab_cache, page, object, NULL, 1, _RET_IP_);
> -- 
> 2.32.0.554.ge1b32706d8-goog
> 
> 
