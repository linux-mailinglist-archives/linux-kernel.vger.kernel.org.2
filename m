Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB97D439294
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhJYJjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:39:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52702 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhJYJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:39:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CDD1B1FD3E;
        Mon, 25 Oct 2021 09:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635154613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFDKyWHqyVtPJmp22asWqTp6wN27PNTJwsnOdNI5eMw=;
        b=0Xg0WL2wzBuKe8D4tUJxuoGcMnqsjXk7A13F8njp3iYOm50V6ZAwqkd27sCxqrQedMjsFS
        AHnv8t7+kV4e/rV8PmSGEWL7l37LFNVrBJW+ZQpSpbPo3L6jM7G+Dl8edfAarwAeqggGuP
        Y51sabkzcSkC5aslQnkHBvQn33v1ag8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635154613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFDKyWHqyVtPJmp22asWqTp6wN27PNTJwsnOdNI5eMw=;
        b=IOPyp9V44gtzgcvq2Nseafs7GksOT0uX8jP9ZpVb0E0OvDhhgKinc6Nx6P7SXgWt0b4qyx
        d5kyRpiaXeUHasDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92E451377E;
        Mon, 25 Oct 2021 09:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RAozI7V6dmGAUAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 25 Oct 2021 09:36:53 +0000
Message-ID: <be7ee3a6-9b3c-b436-f042-82bd3c416acc@suse.cz>
Date:   Mon, 25 Oct 2021 11:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Rustam Kovhaev <rkovhaev@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, dvyukov@google.com
References: <1dfb7a79-3e66-a9fe-ee7c-1277d7ff5950@suse.cz>
 <20211023064114.708532-1-rkovhaev@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] slob: add size header to all allocations
In-Reply-To: <20211023064114.708532-1-rkovhaev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/21 08:41, Rustam Kovhaev wrote:
> Let's prepend both kmalloc() and kmem_cache_alloc() allocations with the
> size header.
> It simplifies the slab API and guarantees that both kmem_cache_alloc()
> and kmalloc() memory could be freed by kfree().
> 
> meminfo right after the system boot, without the patch:
> Slab:              35456 kB
> 
> the same, with the patch:
> Slab:              36160 kB
> 
> Link: https://lore.kernel.org/lkml/20210929212347.1139666-1-rkovhaev@gmail.com
> Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>

Seems overal correct to me, thanks! I'll just suggest some improvements:

> ---
> v2:
>  - Allocate compound pages in slob_alloc_node()
>  - Use slob_free_pages() in kfree()
>  - Update documentation
> 
>  Documentation/core-api/memory-allocation.rst |   4 +-
>  mm/slob.c                                    | 114 +++++++++----------
>  2 files changed, 55 insertions(+), 63 deletions(-)
> 
> diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
> index 5954ddf6ee13..fea0ed11a7c5 100644
> --- a/Documentation/core-api/memory-allocation.rst
> +++ b/Documentation/core-api/memory-allocation.rst
> @@ -172,5 +172,5 @@ wrappers can allocate memory from that cache.
>  
>  When the allocated memory is no longer needed it must be freed. You can
>  use kvfree() for the memory allocated with `kmalloc`, `vmalloc` and
> -`kvmalloc`. The slab caches should be freed with kmem_cache_free(). And
> -don't forget to destroy the cache with kmem_cache_destroy().
> +`kvmalloc`. The slab caches can be freed with kmem_cache_free() or kvfree().
> +And don't forget to destroy the cache with kmem_cache_destroy().

I would phrase it like this (improves also weird wording "The slab caches
should be freed with..." prior to your patch, etc.):

When the allocated memory is no longer needed it must be freed. Objects
allocated by `kmalloc` can be freed by `kfree` or `kvfree`.
Objects allocated by `kmem_cache_alloc` can be freed with `kmem_cache_free`
or also by `kfree` or `kvfree`.
Memory allocated by `vmalloc` can be freed with `vfree` or `kvfree`.
Memory allocated by `kvmalloc` can be freed with `kvfree`.
Caches created by `kmem_cache_create` should be freed with with
`kmem_cache_destroy`.

> -static void slob_free_pages(void *b, int order)
> +static void slob_free_pages(struct page *sp, int order)
>  {
> -	struct page *sp = virt_to_page(b);
> -
> -	if (current->reclaim_state)
> -		current->reclaim_state->reclaimed_slab += 1 << order;
> +	if (PageSlab(sp)) {
> +		__ClearPageSlab(sp);
> +		page_mapcount_reset(sp);
> +		if (current->reclaim_state)
> +			current->reclaim_state->reclaimed_slab += 1 << order;
> +	}
>  
>  	mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
>  			    -(PAGE_SIZE << order));
> @@ -247,9 +244,7 @@ static void *slob_page_alloc(struct page *sp, size_t size, int align,
>  		/*
>  		 * 'aligned' will hold the address of the slob block so that the
>  		 * address 'aligned'+'align_offset' is aligned according to the
> -		 * 'align' parameter. This is for kmalloc() which prepends the
> -		 * allocated block with its size, so that the block itself is
> -		 * aligned when needed.
> +		 * 'align' parameter.
>  		 */
>  		if (align) {
>  			aligned = (slob_t *)
> @@ -373,25 +368,28 @@ static void *slob_alloc(size_t size, gfp_t gfp, int align, int node,
>  	}
>  	if (unlikely(gfp & __GFP_ZERO))
>  		memset(b, 0, size);
> +	/* Write size in the header */
> +	*(unsigned int *)b = size - align_offset;
> +	b = (void *)b + align_offset;
>  	return b;

I would just "return (void *)b + align_offset;" here,  no need to update 'b'.

>  }
>  
>  /*
>   * slob_free: entry point into the slob allocator.
>   */
> -static void slob_free(void *block, int size)
> +static void slob_free(void *block)
>  {
>  	struct page *sp;
> -	slob_t *prev, *next, *b = (slob_t *)block;
> +	int align_offset = max_t(size_t, ARCH_KMALLOC_MINALIGN, ARCH_SLAB_MINALIGN);

This patch adds a number of these in several functions, it was just
__do_kmalloc_node(). It's compile-time constant so I would just #define it
somewhere at the top of slob.c, e.g. something like:

#if ARCH_KMALLOC_MINALIGN < ARCH_SLAB_MINALIGN
#define SLOB_HDR_SIZE ARCH_SLAB_MINALIGN
#else
#define SLOB_HDR_SIZE ARCH_KMALLOC_MINALIGN
#endif

> +	void *hdr = block - align_offset;
> +	unsigned int size = *(unsigned int *)hdr + align_offset;
> +	slob_t *prev, *next, *b = hdr;

IMHO this is too subtle to put in the declaration. I would move these
assignments below the declarations.

That way you can also ditch 'hdr' and just do a 'block -= SLOB_HDR_SIZE;';

>  	slobidx_t units;
>  	unsigned long flags;
>  	struct list_head *slob_list;
>  
> -	if (unlikely(ZERO_OR_NULL_PTR(block)))
> -		return;
> -	BUG_ON(!size);
> -
> -	sp = virt_to_page(block);
> +	BUG_ON(!size || size >= PAGE_SIZE);
> +	sp = virt_to_page(hdr);
>  	units = SLOB_UNITS(size);
>  
>  	spin_lock_irqsave(&slob_lock, flags);
