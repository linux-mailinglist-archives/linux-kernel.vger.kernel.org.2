Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FD7355003
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbhDFJgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:36:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:45342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237208AbhDFJgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:36:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617701760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SRwipLY+b1q1Ng3CPB27+Kz4klgfyfup2vzIC/VRkiQ=;
        b=Qr1DCsawXUipVa6pi5VbIAfveKswpPD63XOD8j/eDIdjWVfzTG3YcnfWXPXf2qxAXqV8HC
        0VSdcnA3csvhK0Vq8Dg+u0gsK2lEaw96h6e03RHjSo8SklLubVtazN610qcIYbLD4ESvLP
        Pgyhl+1Rcs8eliP9H7RXCdKSj7pHi64=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99584B12E;
        Tue,  6 Apr 2021 09:35:59 +0000 (UTC)
Date:   Tue, 6 Apr 2021 11:35:56 +0200
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
Subject: Re: [PATCH v4 1/8] mm/cma: change cma mutex to irq safe spinlock
Message-ID: <YGwrfGcme4TW/pdW@dhcp22.suse.cz>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405230043.182734-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-04-21 16:00:36, Mike Kravetz wrote:
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

I belive I have acked the previous version already. Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/cma.c       | 18 +++++++++---------
>  mm/cma.h       |  2 +-
>  mm/cma_debug.c |  8 ++++----
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index f3bca4178c7f..995e15480937 100644
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
>  			     unsigned long count)
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
> @@ -454,12 +454,12 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
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
> @@ -468,7 +468,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
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
