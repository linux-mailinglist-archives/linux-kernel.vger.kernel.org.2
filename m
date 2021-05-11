Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF96537AE05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhEKSJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:09:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:51498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232108AbhEKSJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:09:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E24AAB6D;
        Tue, 11 May 2021 18:08:16 +0000 (UTC)
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in kmalloc_index()
 to compile-time
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210511173448.GA54466@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <00093b51-0da0-602e-22c6-cc94af58263a@suse.cz>
Date:   Tue, 11 May 2021 20:08:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511173448.GA54466@hyeyoo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 7:34 PM, Hyeonggon Yoo wrote:
> currently when size is not supported by kmalloc_index, compiler will
> generate a run-time BUG() while compile-time error is also possible,
> and better. so changed BUG to BUILD_BUG_ON_MSG to make compile-time
> check possible.
> 
> also removed code that allocates more than 32MB because current
> implementation supports only up to 32MB.
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Thanks!

> ---
>  include/linux/slab.h | 7 +++++--
>  mm/slab_common.c     | 7 +++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 6d454886bcaf..df1937309df2 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -345,6 +345,9 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>   * 1 =  65 .. 96 bytes
>   * 2 = 129 .. 192 bytes
>   * n = 2^(n-1)+1 .. 2^n
> + *
> + * Note: there's no need to optimize kmalloc_index because it's evaluated
> + * in compile-time.
>   */
>  static __always_inline unsigned int kmalloc_index(size_t size)
>  {
> @@ -381,8 +384,8 @@ static __always_inline unsigned int kmalloc_index(size_t size)
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
> index fe8b68482670..97664bbe8147 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1192,8 +1192,8 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
>  
>  /*
>   * kmalloc_info[] is to make slub_debug=,kmalloc-xx option work at boot time.
> - * kmalloc_index() supports up to 2^26=64MB, so the final entry of the table is
> - * kmalloc-67108864.
> + * kmalloc_index() supports up to 2^25=32MB, so the final entry of the table is
> + * kmalloc-32M.
>   */
>  const struct kmalloc_info_struct kmalloc_info[] __initconst = {
>  	INIT_KMALLOC_INFO(0, 0),
> @@ -1221,8 +1221,7 @@ const struct kmalloc_info_struct kmalloc_info[] __initconst = {
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

