Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9976537927A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 17:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbhEJPWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 11:22:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:56766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234617AbhEJPVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 11:21:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56046AD5C;
        Mon, 10 May 2021 15:20:02 +0000 (UTC)
Subject: Re: [PATCH v2] mm: kmalloc_index: make compiler break when size is
 not supported
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz> <20210510135857.GA3594@hyeyoo>
 <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
 <20210510150230.GA74915@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <90591d7e-41e4-9ae5-54ae-ded467c498cf@suse.cz>
Date:   Mon, 10 May 2021 17:19:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210510150230.GA74915@hyeyoo>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/21 5:02 PM, Hyeonggon Yoo wrote:
> updated patch. let me know if something is wrong!
> 
> 
> 0001-mm-kmalloc_index-make-compiler-break-when-size-is-no.patch
> 
> From 8fe7ecdfb0f5bd5b08771512303d72f1c6447362 Mon Sep 17 00:00:00 2001
> From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Date: Mon, 10 May 2021 23:57:34 +0900
> Subject: [PATCH] mm: kmalloc_index: make compiler break when size is not
>  supported

I'd rephrase the subject:
mm, slub: change run-time assertion in kmalloc_index() to compile-time

> currently when size is not supported by kmalloc_index, compiler will not
> break.

"... compiler will generate a run-time BUG() while a compile-time error is also
possible, and better"

> so changed BUG to BUILD_BUG_ON_MSG to make compiler break if size is
> wrong. this is done in compile time.
> 
> also removed code that allocates more than 32MB because current
> implementation supports only up to 32MB.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  include/linux/slab.h | 7 +++++--
>  mm/slab_common.c     | 7 +++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0c97d788762c..fd0c7229d105 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -346,6 +346,9 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>   * 1 =  65 .. 96 bytes
>   * 2 = 129 .. 192 bytes
>   * n = 2^(n-1)+1 .. 2^n
> + *
> + * Note: you don't need to optimize kmalloc_index because it's evaluated

"there's no need to..."

> + * in compile-time.
>   */
>  static __always_inline unsigned int kmalloc_index(size_t size)
>  {
> @@ -382,8 +385,8 @@ static __always_inline unsigned int kmalloc_index(size_t size)
>  	if (size <=  8 * 1024 * 1024) return 23;
>  	if (size <=  16 * 1024 * 1024) return 24;
>  	if (size <=  32 * 1024 * 1024) return 25;
> -	if (size <=  64 * 1024 * 1024) return 26;
> -	BUG();
> +
> +	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
>  
>  	/* Will never be reached. Needed because the compiler may complain */
>  	return -1;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index f8833d3e5d47..39d4eca8cf9b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -745,8 +745,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
>  
>  /*
>   * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
> - * kmalloc_index() supports up to 2^26=64MB, so the final entry of the table is
> - * kmalloc-67108864.
> + * kmalloc_index() supports up to 2^25=32MB, so the final entry of the table is
> + * kmalloc-33554432.

      kmalloc-32M

>   */
>  const struct kmalloc_info_struct kmalloc_info[] __initconst = {
>  	INIT_KMALLOC_INFO(0, 0),
> @@ -774,8 +774,7 @@ const struct kmalloc_info_struct kmalloc_info[] __initconst = {
>  	INIT_KMALLOC_INFO(4194304, 4M),
>  	INIT_KMALLOC_INFO(8388608, 8M),
>  	INIT_KMALLOC_INFO(16777216, 16M),
> -	INIT_KMALLOC_INFO(33554432, 32M),
> -	INIT_KMALLOC_INFO(67108864, 64M)
> +	INIT_KMALLOC_INFO(33554432, 32M)
>  };
>  
>  /*
> 

Thanks
