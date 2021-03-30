Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A9334E2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhC3IBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:01:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:50542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhC3IBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:01:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617091274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pe5VCGSDllxf1PZsaIK5/mpDXTDmn+RsL8mbSbw0sU=;
        b=H64EbpIHl1fo1knvsAew4miorACtUQIXXL3iwPLcbdMTEW0V8BRZYfVXkL5TzJU1K9UskI
        h6iJpqZlZo9XQy0kkwwmschvseLmifdZMJebv207+V3/K1ZcD3PH066m0kuWpsPNDRBr/3
        ksMyihF33NTTZE859bRR6CkZDUi0ecI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7A63B159;
        Tue, 30 Mar 2021 08:01:13 +0000 (UTC)
Date:   Tue, 30 Mar 2021 10:01:12 +0200
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
Subject: Re: [PATCH v2 1/8] mm/cma: change cma mutex to irq safe spinlock
Message-ID: <YGLayMqYOrMMQ841@dhcp22.suse.cz>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329232402.575396-2-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-03-21 16:23:55, Mike Kravetz wrote:
> Ideally, cma_release could be called from any context.  However, that is
> not possible because a mutex is used to protect the per-area bitmap.
> Change the bitmap to an irq safe spinlock.

I would phrase the changelog slightly differerent
"
cma_release is currently a sleepable operatation because the bitmap
manipulation is protected by cma->lock mutex. Hugetlb code which relies
on cma_release for CMA backed (giga) hugetlb pages, however, needs to be
irq safe.

The lock doesn't protect any sleepable operation so it can be changed to
a (irq aware) spin lock. The bitmap processing should be quite fast in
typical case but if cma sizes grow to TB then we will likely need to
replace the lock by a more optimized bitmap implementation.
"

it seems that you are overusing irqsave variants even from context which
are never called from the IRQ context so they do not need storing flags.

[...]
> @@ -391,8 +391,9 @@ static void cma_debug_show_areas(struct cma *cma)
>  	unsigned long start = 0;
>  	unsigned long nr_part, nr_total = 0;
>  	unsigned long nbits = cma_bitmap_maxno(cma);
> +	unsigned long flags;
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irqsave(&cma->lock, flags);

spin_lock_irq should be sufficient. This is only called from the
allocation context and that is never called from IRQ context.

>  	pr_info("number of available pages: ");
>  	for (;;) {
>  		next_zero_bit = find_next_zero_bit(cma->bitmap, nbits, start);
> @@ -407,7 +408,7 @@ static void cma_debug_show_areas(struct cma *cma)
>  		start = next_zero_bit + nr_zero;
>  	}
>  	pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irqrestore(&cma->lock, flags);
>  }
>  #else
>  static inline void cma_debug_show_areas(struct cma *cma) { }
> @@ -430,6 +431,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  	unsigned long pfn = -1;
>  	unsigned long start = 0;
>  	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
> +	unsigned long flags;
>  	size_t i;
>  	struct page *page = NULL;
>  	int ret = -ENOMEM;
> @@ -454,12 +456,12 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  		goto out;
>  
>  	for (;;) {
> -		mutex_lock(&cma->lock);
> +		spin_lock_irqsave(&cma->lock, flags);
>  		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
>  				bitmap_maxno, start, bitmap_count, mask,
>  				offset);
>  		if (bitmap_no >= bitmap_maxno) {
> -			mutex_unlock(&cma->lock);
> +			spin_unlock_irqrestore(&cma->lock, flags);
>  			break;
>  		}
>  		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);

same here.

> @@ -468,7 +470,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>  		 * our exclusive use. If the migration fails we will take the
>  		 * lock again and unmark it.
>  		 */
> -		mutex_unlock(&cma->lock);
> +		spin_unlock_irqrestore(&cma->lock, flags);
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
> index d5bf8aa34fdc..6379cfbfd568 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -35,11 +35,12 @@ static int cma_used_get(void *data, u64 *val)
>  {
>  	struct cma *cma = data;
>  	unsigned long used;
> +	unsigned long flags;
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irqsave(&cma->lock, flags);
>  	/* pages counter is smaller than sizeof(int) */
>  	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irqrestore(&cma->lock, flags);
>  	*val = (u64)used << cma->order_per_bit;

same here

>  
>  	return 0;
> @@ -52,8 +53,9 @@ static int cma_maxchunk_get(void *data, u64 *val)
>  	unsigned long maxchunk = 0;
>  	unsigned long start, end = 0;
>  	unsigned long bitmap_maxno = cma_bitmap_maxno(cma);
> +	unsigned long flags;
>  
> -	mutex_lock(&cma->lock);
> +	spin_lock_irqsave(&cma->lock, flags);
>  	for (;;) {
>  		start = find_next_zero_bit(cma->bitmap, bitmap_maxno, end);
>  		if (start >= bitmap_maxno)
> @@ -61,7 +63,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
>  		end = find_next_bit(cma->bitmap, bitmap_maxno, start);
>  		maxchunk = max(end - start, maxchunk);
>  	}
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irqrestore(&cma->lock, flags);
>  	*val = (u64)maxchunk << cma->order_per_bit;
>  
>  	return 0;

and here.
-- 
Michal Hocko
SUSE Labs
