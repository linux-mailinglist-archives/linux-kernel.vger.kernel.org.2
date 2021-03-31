Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA75C34FADA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhCaHx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234114AbhCaHxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617177190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bzvf+M3b77HIdjPcRSzSZeq7D/XGxIYBangMV7Eyk+w=;
        b=H1sImrBvMB8yvc5SxAgpeOBOYxEUM8GQseL3Wz7uMRlJvWYFrCL0sc0wL6LurDe8IPZ5W7
        Se53EVwbd+qVAPuMSPsz1UeTefGKtkpbXprKWJ/7fNdHX9HwrO1ycQx65HBadk6uukkuaq
        vKggliX4dIOG3/a1mXqnmIFIDDj7+vA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-CUOM3dXQMymgrc6RuzP5Kw-1; Wed, 31 Mar 2021 03:53:07 -0400
X-MC-Unique: CUOM3dXQMymgrc6RuzP5Kw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88D8B185302B;
        Wed, 31 Mar 2021 07:53:03 +0000 (UTC)
Received: from [10.36.113.60] (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDE9019C44;
        Wed, 31 Mar 2021 07:52:50 +0000 (UTC)
Subject: Re: [PATCH v3 1/8] mm/cma: change cma mutex to irq safe spinlock
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
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
References: <20210331034148.112624-1-mike.kravetz@oracle.com>
 <20210331034148.112624-2-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <4433e570-d492-f617-7c0b-51f00557ea71@redhat.com>
Date:   Wed, 31 Mar 2021 09:52:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210331034148.112624-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.21 05:41, Mike Kravetz wrote:
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
> ---
>   mm/cma.c       | 18 +++++++++---------
>   mm/cma.h       |  2 +-
>   mm/cma_debug.c |  8 ++++----
>   3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index b2393b892d3b..2380f2571eb5 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -24,7 +24,6 @@
>   #include <linux/memblock.h>
>   #include <linux/err.h>
>   #include <linux/mm.h>
> -#include <linux/mutex.h>
>   #include <linux/sizes.h>
>   #include <linux/slab.h>
>   #include <linux/log2.h>
> @@ -83,13 +82,14 @@ static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,
>   			     unsigned int count)
>   {
>   	unsigned long bitmap_no, bitmap_count;
> +	unsigned long flags;
>   
>   	bitmap_no = (pfn - cma->base_pfn) >> cma->order_per_bit;
>   	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
>   
> -	mutex_lock(&cma->lock);
> +	spin_lock_irqsave(&cma->lock, flags);
>   	bitmap_clear(cma->bitmap, bitmap_no, bitmap_count);
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irqrestore(&cma->lock, flags);
>   }
>   
>   static void __init cma_activate_area(struct cma *cma)
> @@ -118,7 +118,7 @@ static void __init cma_activate_area(struct cma *cma)
>   	     pfn += pageblock_nr_pages)
>   		init_cma_reserved_pageblock(pfn_to_page(pfn));
>   
> -	mutex_init(&cma->lock);
> +	spin_lock_init(&cma->lock);
>   
>   #ifdef CONFIG_CMA_DEBUGFS
>   	INIT_HLIST_HEAD(&cma->mem_head);
> @@ -392,7 +392,7 @@ static void cma_debug_show_areas(struct cma *cma)
>   	unsigned long nr_part, nr_total = 0;
>   	unsigned long nbits = cma_bitmap_maxno(cma);
>   
> -	mutex_lock(&cma->lock);
> +	spin_lock_irq(&cma->lock);
>   	pr_info("number of available pages: ");
>   	for (;;) {
>   		next_zero_bit = find_next_zero_bit(cma->bitmap, nbits, start);
> @@ -407,7 +407,7 @@ static void cma_debug_show_areas(struct cma *cma)
>   		start = next_zero_bit + nr_zero;
>   	}
>   	pr_cont("=> %lu free of %lu total pages\n", nr_total, cma->count);
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irq(&cma->lock);
>   }
>   #else
>   static inline void cma_debug_show_areas(struct cma *cma) { }
> @@ -454,12 +454,12 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   		goto out;
>   
>   	for (;;) {
> -		mutex_lock(&cma->lock);
> +		spin_lock_irq(&cma->lock);
>   		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
>   				bitmap_maxno, start, bitmap_count, mask,
>   				offset);
>   		if (bitmap_no >= bitmap_maxno) {
> -			mutex_unlock(&cma->lock);
> +			spin_unlock_irq(&cma->lock);
>   			break;
>   		}
>   		bitmap_set(cma->bitmap, bitmap_no, bitmap_count);
> @@ -468,7 +468,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   		 * our exclusive use. If the migration fails we will take the
>   		 * lock again and unmark it.
>   		 */
> -		mutex_unlock(&cma->lock);
> +		spin_unlock_irq(&cma->lock);
>   
>   		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>   		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> diff --git a/mm/cma.h b/mm/cma.h
> index 68ffad4e430d..2c775877eae2 100644
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -15,7 +15,7 @@ struct cma {
>   	unsigned long   count;
>   	unsigned long   *bitmap;
>   	unsigned int order_per_bit; /* Order of pages represented by one bit */
> -	struct mutex    lock;
> +	spinlock_t	lock;
>   #ifdef CONFIG_CMA_DEBUGFS
>   	struct hlist_head mem_head;
>   	spinlock_t mem_head_lock;
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index d5bf8aa34fdc..2e7704955f4f 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -36,10 +36,10 @@ static int cma_used_get(void *data, u64 *val)
>   	struct cma *cma = data;
>   	unsigned long used;
>   
> -	mutex_lock(&cma->lock);
> +	spin_lock_irq(&cma->lock);
>   	/* pages counter is smaller than sizeof(int) */
>   	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irq(&cma->lock);
>   	*val = (u64)used << cma->order_per_bit;
>   
>   	return 0;
> @@ -53,7 +53,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
>   	unsigned long start, end = 0;
>   	unsigned long bitmap_maxno = cma_bitmap_maxno(cma);
>   
> -	mutex_lock(&cma->lock);
> +	spin_lock_irq(&cma->lock);
>   	for (;;) {
>   		start = find_next_zero_bit(cma->bitmap, bitmap_maxno, end);
>   		if (start >= bitmap_maxno)
> @@ -61,7 +61,7 @@ static int cma_maxchunk_get(void *data, u64 *val)
>   		end = find_next_bit(cma->bitmap, bitmap_maxno, start);
>   		maxchunk = max(end - start, maxchunk);
>   	}
> -	mutex_unlock(&cma->lock);
> +	spin_unlock_irq(&cma->lock);
>   	*val = (u64)maxchunk << cma->order_per_bit;
>   
>   	return 0;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

