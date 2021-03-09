Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05F53329D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhCIPKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:10:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:38848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhCIPJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:09:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43273AC8C;
        Tue,  9 Mar 2021 15:09:46 +0000 (UTC)
Subject: Re: [PATCH] mm/slub: Add slub_debug option to panic on memory
 corruption
To:     Georgi Djakov <georgi.djakov@linaro.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210309134720.29052-1-georgi.djakov@linaro.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <390d8a2f-ead9-48a9-99eb-65c73bd18422@suse.cz>
Date:   Tue, 9 Mar 2021 16:09:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309134720.29052-1-georgi.djakov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/21 2:47 PM, Georgi Djakov wrote:
> Being able to stop the system immediately when a memory corruption
> is detected is crucial to finding the source of it. This is very
> useful when the memory can be inspected with kdump or other tools.

Is this in some testing scenarios where you would also use e.g. panic_on_warn?
We could hook to that. If not, we could introduce a new
panic_on_memory_corruption that would apply also for debug_pagealloc and whatnot?

> Let's add an option panic the kernel when slab debug catches an
> object or list corruption.
> 
> This new option is not enabled by default (yet), so it needs to be
> enabled explicitly (for example by adding "slub_debug=FZPUC" to
> the kernel command line).
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/vm/slub.rst | 1 +
>  include/linux/slab.h      | 3 +++
>  mm/slab.h                 | 2 +-
>  mm/slub.c                 | 9 +++++++++
>  4 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
> index 03f294a638bd..32878c44f3de 100644
> --- a/Documentation/vm/slub.rst
> +++ b/Documentation/vm/slub.rst
> @@ -53,6 +53,7 @@ Possible debug options are::
>  	Z		Red zoning
>  	P		Poisoning (object and padding)
>  	U		User tracking (free and alloc)
> +	C		Panic on object corruption (enables SLAB_CORRUPTION_PANIC)
>  	T		Trace (please only use on single slabs)
>  	A		Enable failslab filter mark for the cache
>  	O		Switch debugging off for caches that would have
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 0c97d788762c..ebff5e704d08 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -39,6 +39,9 @@
>  #define SLAB_STORE_USER		((slab_flags_t __force)0x00010000U)
>  /* Panic if kmem_cache_create() fails */
>  #define SLAB_PANIC		((slab_flags_t __force)0x00040000U)
> +/* Panic if memory corruption is detected */
> +#define SLAB_CORRUPTION_PANIC	((slab_flags_t __force)0x00080000U)
> +
>  /*
>   * SLAB_TYPESAFE_BY_RCU - **WARNING** READ THIS!
>   *
> diff --git a/mm/slab.h b/mm/slab.h
> index 120b1d0dfb6d..ae0079017fc6 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -134,7 +134,7 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
>  #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER)
>  #elif defined(CONFIG_SLUB_DEBUG)
>  #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
> -			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS)
> +			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS | SLAB_CORRUPTION_PANIC)
>  #else
>  #define SLAB_DEBUG_FLAGS (0)
>  #endif
> diff --git a/mm/slub.c b/mm/slub.c
> index 077a019e4d7a..49351427f701 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -741,6 +741,8 @@ void object_err(struct kmem_cache *s, struct page *page,
>  {
>  	slab_bug(s, "%s", reason);
>  	print_trailer(s, page, object);
> +	if (slub_debug & SLAB_CORRUPTION_PANIC)
> +		panic(reason);
>  }
>  
>  static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
> @@ -755,6 +757,8 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct page *page,
>  	slab_bug(s, "%s", buf);
>  	print_page_info(page);
>  	dump_stack();
> +	if (slub_debug & SLAB_CORRUPTION_PANIC)
> +		panic("slab: slab error\n");
>  }
>  
>  static void init_object(struct kmem_cache *s, void *object, u8 val)
> @@ -776,6 +780,8 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
>  static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
>  						void *from, void *to)
>  {
> +	if (slub_debug & SLAB_CORRUPTION_PANIC)
> +		panic("slab: object overwritten\n");
>  	slab_fix(s, "Restoring 0x%p-0x%p=0x%x\n", from, to - 1, data);
>  	memset(from, data, to - from);
>  }
> @@ -1319,6 +1325,9 @@ parse_slub_debug_flags(char *str, slab_flags_t *flags, char **slabs, bool init)
>  		case 'a':
>  			*flags |= SLAB_FAILSLAB;
>  			break;
> +		case 'c':
> +			*flags |= SLAB_CORRUPTION_PANIC;
> +			break;
>  		case 'o':
>  			/*
>  			 * Avoid enabling debugging on caches if its minimum
> 

