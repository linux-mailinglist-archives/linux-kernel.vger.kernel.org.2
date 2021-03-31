Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC234F9CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhCaHZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:25:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:41370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233940AbhCaHZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:25:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617175515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9pDrvoUV0OPpdgOQg44s+1/J3cLbxxbA+8UBAGaaS0=;
        b=ukbSH3Ih1s6Iyh5D8bx+hgQUqHvKE6G+0Izd/i54fLUsnXs6yjj4yq0IHdSo6xWS6uaOam
        prk0A/uVTA2iGovEG4QFdw74B8k5elI/DWlvZGpvIvOnJbzG12zy9UC1NCUY0pC7u6DOGp
        MdvMWaRtA+VWoze4qiDYgiK7fOuznNE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BBE9AD9F;
        Wed, 31 Mar 2021 07:25:15 +0000 (UTC)
Date:   Wed, 31 Mar 2021 09:25:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/8] mm/cma: change cma mutex to irq safe spinlock
Message-ID: <YGQj18K5MKB7eo/m@dhcp22.suse.cz>
References: <20210331034148.112624-1-mike.kravetz@oracle.com>
 <20210331034148.112624-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331034148.112624-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30-03-21 20:41:41, Mike Kravetz wrote:
> cma_release is currently a sleepable operatation because the bitmap
> manipulation is protected by cma->lock mutex. Hugetlb code which relies
> on cma_release for CMA backed (giga) hugetlb pages, however, needs to be
> irq safe.
> 
> The lock doesn't protect any sleepable operation so it can be changed to
> a (irq aware) spin lock. The bitmap processing should be quite fast in
> typical case but if cma sizes grow to TB then we will likely need to
> replace the lock by a more optimized bitmap implementation.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/cma.c       | 18 +++++++++---------
>  mm/cma.h       |  2 +-
>  mm/cma_debug.c |  8 ++++----
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index b2393b892d3b..2380f2571eb5 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -24,7 +24,6 @@
>  #include <linux/memblock.h>
>  #include <linux/err.h>
>  #include <linux/mm.h>
> -#include <linux/mutex.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/log2.h>
> @@ -83,13 +82,14 @@ static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,
>  			     unsigned int count)
>  {
>  	unsigned long bitmap_no, bitmap_count;
> +	unsigned long flags;
>  
>  	bitmap_no = (pfn - cma->base_pfn) >> cma->order_per_bit;
>  	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irqsave(&cma->lock, flags);
>  	bitmap_clear(cma->bitmap, bitmap_no, bitmap_count);
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irqrestore(&cma->lock, flags);
>  }
>  
>  static void __init cma_activate_area(struct cma *cma)
> @@ -118,7 +118,7 @@ static void __init cma_activate_area(struct cma *cma)
>  	     pfn += pageblock_nr_pages)
>  		init_cma_reserved_pageblock(pfn_to_page(pfn));
>  
> -	mutex_init(&cma->lock);
> +	spin_lock_init(&cma->lock);
>  
>  #ifdef CONFIG_CMA_DEBUGFS
>  	INIT_HLIST_HEAD(&cma->mem_head);
> @@ -392,7 +392,7 @@ static void cma_debug_show_areas(struct cma *cma)
>  	unsigned long nr_part, nr_total = 0;
>  	unsigned long nbits = cma_bitmap_maxno(cma);
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irq(&cma->lock);
>  	pr_info("number of available pages: ");
>  	for (;;) {
>  		next_zero_bit = find_next_zero_bit(cma->bitmap, nbits, start);
> @@ -407,7 +407,7 @@ static void cma_debug_show_areas(struct cma *cma)
>  		start = next_zero_bit + nr_zero;
>  	}
>  	pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irq(&cma->lock);
>  }
>  #else
>  static inline void cma_debug_show_areas(struct cma *cma) { }
> @@ -454,12 +454,12 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  		goto out;
>  
>  	for (;;) {
> -		mutex_lock(&cma->lock);
> +		spin_lock_irq(&cma->lock);
>  		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
>  				bitmap_maxno, start, bitmap_count, mask,
>  				offset);
>  		if (bitmap_no >= bitmap_maxno) {
> -			mutex_unlock(&cma->lock);
> +			spin_unlock_irq(&cma->lock);
>  			break;
>  		}
>  		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
> @@ -468,7 +468,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  		 * our exclusive use. If the migration fails we will take the
>  		 * lock again and unmark it.
>  		 */
> -		mutex_unlock(&cma->lock);
> +		spin_unlock_irq(&cma->lock);
>  
>  		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>  		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> diff --git a/mm/cma.h b/mm/cma.h
> index 68ffad4e430d..2c775877eae2 100644
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -15,7 +15,7 @@ struct cma {
>  	unsigned long   count;
>  	unsigned long   *bitmap;
>  	unsigned int order_per_bit; /* Order of pages represented by one bit */
> -	struct mutex    lock;
> +	spinlock_t	lock;
>  #ifdef CONFIG_CMA_DEBUGFS
>  	struct hlist_head mem_head;
>  	spinlock_t mem_head_lock;
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index d5bf8aa34fdc..2e7704955f4f 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -36,10 +36,10 @@ static int cma_used_get(void *data, u64 *val)
>  	struct cma *cma = data;
>  	unsigned long used;
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irq(&cma->lock);
>  	/* pages counter is smaller than sizeof(int) */
>  	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irq(&cma->lock);
>  	*val = (u64)used << cma->order_per_bit;
>  
>  	return 0;
> @@ -53,7 +53,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
>  	unsigned long start, end = 0;
>  	unsigned long bitmap_maxno = cma_bitmap_maxno(cma);
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irq(&cma->lock);
>  	for (;;) {
>  		start = find_next_zero_bit(cma->bitmap, bitmap_maxno, end);
>  		if (start >= bitmap_maxno)
> @@ -61,7 +61,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
>  		end = find_next_bit(cma->bitmap, bitmap_maxno, start);
>  		maxchunk = max(end - start, maxchunk);
>  	}
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irq(&cma->lock);
>  	*val = (u64)maxchunk << cma->order_per_bit;
>  
>  	return 0;
> -- 
> 2.30.2
> 

-- 
Michal Hocko
SUSE Labs
