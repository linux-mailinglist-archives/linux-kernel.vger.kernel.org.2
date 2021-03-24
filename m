Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D324348582
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbhCXXsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbhCXXrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:47:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94781C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=krp81/RbBROV9r7rw0KqbZnwuOxdnczzeQmdrTNXVdY=; b=k6oajFblnwqa9EVL51rb7Tep9P
        cJov/75GWc6gpRlsldxRJ1amkXJ5Fuu6wM/XHuQV1iueic4L0FjafT+GgI9YY6J524n2qS4PYOTfA
        wX5ZorbGk7K1FegaXKKhdEyqSpSpOXEUyRybpl+CoEtShyfNT4iJLoZ4V4hAgjEV0EJrLo2HKEaNo
        JToQUJ+VvfqBvCocuGu9szQacFNvGlm+BNHRTvq8DSdDV9ru++TZc6vNaP5KKmonjLkqogm9iqggx
        ut2QxHYlJGwL0rUNJAubB/vLDY1qkPdGzHLGjJIS/hSixQUirCe12t+vV8gX9sl77gotUEbp0mnqG
        Skfcopdw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPDDo-000MYO-8x; Wed, 24 Mar 2021 23:47:33 +0000
Subject: Re: [PATCH V2] mm/slub.c: Trivial typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210325044940.14516-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <79efaafd-01cd-f2da-a821-997999ef5fd9@infradead.org>
Date:   Wed, 24 Mar 2021 16:47:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210325044940.14516-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 9:49 PM, Bhaskar Chowdhury wrote:
> s/operatios/operations/
> s/Mininum/Minimum/
> s/mininum/minimum/  ......two different places.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Changes from V1:
>   David's finding incorporated.i.e operation->operations
>  mm/slub.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 3021ce9bf1b3..75d103ad5d2e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3,7 +3,7 @@
>   * SLUB: A slab allocator that limits cache line use instead of queuing
>   * objects in per cpu and per node lists.
>   *
> - * The allocator synchronizes using per slab locks or atomic operatios
> + * The allocator synchronizes using per slab locks or atomic operations
>   * and only uses a centralized lock to manage a pool of partial slabs.
>   *
>   * (C) 2007 SGI, Christoph Lameter
> @@ -160,7 +160,7 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
>  #undef SLUB_DEBUG_CMPXCHG
> 
>  /*
> - * Mininum number of partial slabs. These will be left on the partial
> + * Minimum number of partial slabs. These will be left on the partial
>   * lists even if they are empty. kmem_cache_shrink may reclaim them.
>   */
>  #define MIN_PARTIAL 5
> @@ -832,7 +832,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
>   *
>   * 	A. Free pointer (if we cannot overwrite object on free)
>   * 	B. Tracking data for SLAB_STORE_USER
> - * 	C. Padding to reach required alignment boundary or at mininum
> + * 	C. Padding to reach required alignment boundary or at minimum
>   * 		one word if debugging is on to be able to detect writes
>   * 		before the word boundary.
>   *
> @@ -3421,7 +3421,7 @@ static unsigned int slub_min_objects;
>   *
>   * Higher order allocations also allow the placement of more objects in a
>   * slab and thereby reduce object handling overhead. If the user has
> - * requested a higher mininum order then we start with that one instead of
> + * requested a higher minimum order then we start with that one instead of
>   * the smallest order which will fit the object.
>   */
>  static inline unsigned int slab_order(unsigned int size,
> --


-- 
~Randy

