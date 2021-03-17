Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF533F10E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 14:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhCQNUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 09:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230448AbhCQNUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 09:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615987213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Matc9Hkh3MN82fLamwqdoWppjUrMyd6JaijUxE8frfQ=;
        b=NyRViTl+l6kuJlSaBcVzZ7ejcjQt6AgeJqiOlyi0y2hDGCiyBvFVQPYsrnYR+chKhfNh/n
        AYrSGUA2/8SqQqR/F5DoC2GqmyUG3oiEEw3uY66FzYjWis+qNxq4Gf3qVXO4+PZyDuQgsF
        ln+K6JAVddvaMepqhOmGvZFr1yYjhgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-tOARwmsdOESEoI4_U6CvhA-1; Wed, 17 Mar 2021 09:20:09 -0400
X-MC-Unique: tOARwmsdOESEoI4_U6CvhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F2711B18BC5;
        Wed, 17 Mar 2021 13:20:08 +0000 (UTC)
Received: from [10.36.112.124] (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB5C15D9C0;
        Wed, 17 Mar 2021 13:20:06 +0000 (UTC)
Subject: Re: [PATCH v2] mm: Move page_mapping_file to pagemap.h
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Huang Ying <ying.huang@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20210317123011.350118-1-willy@infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d50e12cd-cd80-baaf-10b1-8fee860209e8@redhat.com>
Date:   Wed, 17 Mar 2021 14:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317123011.350118-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.21 13:30, Matthew Wilcox (Oracle) wrote:
> page_mapping_file() is only used by some architectures, and then it
> is usually only used in one place.  Make it a static inline function
> so other architectures don't have to carry this dead code.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2: Ensure pagemap.h is included in all the files which use page_mapping_file
>   arch/arm/mm/copypage-v4mc.c   |  1 +
>   arch/arm/mm/copypage-v6.c     |  1 +
>   arch/arm/mm/copypage-xscale.c |  1 +
>   arch/csky/abiv1/cacheflush.c  |  1 +
>   arch/mips/mm/cache.c          |  1 +
>   arch/nios2/mm/cacheflush.c    |  1 +
>   arch/sh/mm/cache-sh4.c        |  1 +
>   arch/sh/mm/cache-sh7705.c     |  1 +
>   arch/sparc/mm/tlb.c           |  1 +
>   include/linux/mm.h            |  1 -
>   include/linux/pagemap.h       | 10 ++++++++++
>   mm/util.c                     | 10 ----------
>   12 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mm/copypage-v4mc.c b/arch/arm/mm/copypage-v4mc.c
> index 44f7292ec27b..f1da3b439b96 100644
> --- a/arch/arm/mm/copypage-v4mc.c
> +++ b/arch/arm/mm/copypage-v4mc.c
> @@ -13,6 +13,7 @@
>   #include <linux/init.h>
>   #include <linux/mm.h>
>   #include <linux/highmem.h>
> +#include <linux/pagemap.h>
>   
>   #include <asm/tlbflush.h>
>   #include <asm/cacheflush.h>
> diff --git a/arch/arm/mm/copypage-v6.c b/arch/arm/mm/copypage-v6.c
> index 6a769a6c314e..d8a115de5507 100644
> --- a/arch/arm/mm/copypage-v6.c
> +++ b/arch/arm/mm/copypage-v6.c
> @@ -8,6 +8,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/mm.h>
>   #include <linux/highmem.h>
> +#include <linux/pagemap.h>
>   
>   #include <asm/shmparam.h>
>   #include <asm/tlbflush.h>
> diff --git a/arch/arm/mm/copypage-xscale.c b/arch/arm/mm/copypage-xscale.c
> index eb5d338657d1..bcb485620a05 100644
> --- a/arch/arm/mm/copypage-xscale.c
> +++ b/arch/arm/mm/copypage-xscale.c
> @@ -13,6 +13,7 @@
>   #include <linux/init.h>
>   #include <linux/mm.h>
>   #include <linux/highmem.h>
> +#include <linux/pagemap.h>
>   
>   #include <asm/tlbflush.h>
>   #include <asm/cacheflush.h>
> diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
> index 9f1fe80cc847..07ff17ea33de 100644
> --- a/arch/csky/abiv1/cacheflush.c
> +++ b/arch/csky/abiv1/cacheflush.c
> @@ -4,6 +4,7 @@
>   #include <linux/kernel.h>
>   #include <linux/mm.h>
>   #include <linux/fs.h>
> +#include <linux/pagemap.h>
>   #include <linux/syscalls.h>
>   #include <linux/spinlock.h>
>   #include <asm/page.h>
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 7719d632df8d..a7bf0c80371c 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -15,6 +15,7 @@
>   #include <linux/syscalls.h>
>   #include <linux/mm.h>
>   #include <linux/highmem.h>
> +#include <linux/pagemap.h>
>   
>   #include <asm/cacheflush.h>
>   #include <asm/processor.h>
> diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
> index 65de1bd6a760..6aa9257c3ede 100644
> --- a/arch/nios2/mm/cacheflush.c
> +++ b/arch/nios2/mm/cacheflush.c
> @@ -11,6 +11,7 @@
>   #include <linux/sched.h>
>   #include <linux/mm.h>
>   #include <linux/fs.h>
> +#include <linux/pagemap.h>
>   
>   #include <asm/cacheflush.h>
>   #include <asm/cpuinfo.h>
> diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
> index ddfa9685f1ef..72c2e1b46c08 100644
> --- a/arch/sh/mm/cache-sh4.c
> +++ b/arch/sh/mm/cache-sh4.c
> @@ -16,6 +16,7 @@
>   #include <linux/mutex.h>
>   #include <linux/fs.h>
>   #include <linux/highmem.h>
> +#include <linux/pagemap.h>
>   #include <asm/mmu_context.h>
>   #include <asm/cache_insns.h>
>   #include <asm/cacheflush.h>
> diff --git a/arch/sh/mm/cache-sh7705.c b/arch/sh/mm/cache-sh7705.c
> index 4c67b3d88775..9b63a53a5e46 100644
> --- a/arch/sh/mm/cache-sh7705.c
> +++ b/arch/sh/mm/cache-sh7705.c
> @@ -13,6 +13,7 @@
>   #include <linux/mman.h>
>   #include <linux/mm.h>
>   #include <linux/fs.h>
> +#include <linux/pagemap.h>
>   #include <linux/threads.h>
>   #include <asm/addrspace.h>
>   #include <asm/page.h>
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index 20ee14739333..9a725547578e 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -9,6 +9,7 @@
>   #include <linux/mm.h>
>   #include <linux/swap.h>
>   #include <linux/preempt.h>
> +#include <linux/pagemap.h>
>   
>   #include <asm/tlbflush.h>
>   #include <asm/cacheflush.h>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fbe0843daa90..f69a72f63e44 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1645,7 +1645,6 @@ static inline pgoff_t page_index(struct page *page)
>   
>   bool page_mapped(struct page *page);
>   struct address_space *page_mapping(struct page *page);
> -struct address_space *page_mapping_file(struct page *page);
>   
>   /*
>    * Return true only if the page has been allocated with
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 08fa117f405c..f68fe61c1dec 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -162,6 +162,16 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
>   
>   void release_pages(struct page **pages, int nr);
>   
> +/*
> + * For file cache pages, return the address_space, otherwise return NULL
> + */
> +static inline struct address_space *page_mapping_file(struct page *page)
> +{
> +	if (unlikely(PageSwapCache(page)))
> +		return NULL;
> +	return page_mapping(page);
> +}
> +
>   /*
>    * speculatively take a reference to a page.
>    * If the page is free (_refcount == 0), then _refcount is untouched, and 0
> diff --git a/mm/util.c b/mm/util.c
> index 143c627fb3e8..972e7a0cda5e 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -711,16 +711,6 @@ struct address_space *page_mapping(struct page *page)
>   }
>   EXPORT_SYMBOL(page_mapping);
>   
> -/*
> - * For file cache pages, return the address_space, otherwise return NULL
> - */
> -struct address_space *page_mapping_file(struct page *page)
> -{
> -	if (unlikely(PageSwapCache(page)))
> -		return NULL;
> -	return page_mapping(page);
> -}
> -
>   /* Slow path of page_mapcount() for compound pages */
>   int __page_mapcount(struct page *page)
>   {
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

