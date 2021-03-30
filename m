Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC9734DD66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 03:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhC3BUe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Mar 2021 21:20:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3505 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhC3BUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 21:20:19 -0400
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F8WmF1HMFzRWX7;
        Tue, 30 Mar 2021 09:18:21 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 30 Mar 2021 09:20:15 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Tue, 30 Mar 2021 09:20:15 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        linmiaohe <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH v2 1/8] mm/cma: change cma mutex to irq safe spinlock
Thread-Topic: [PATCH v2 1/8] mm/cma: change cma mutex to irq safe spinlock
Thread-Index: AQHXJPKtsGY6CpxmIUeixSCzA9mWXKqbuTbg
Date:   Tue, 30 Mar 2021 01:20:15 +0000
Message-ID: <3de3a89983894cb79a0f25cf17e838f1@hisilicon.com>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-2-mike.kravetz@oracle.com>
In-Reply-To: <20210329232402.575396-2-mike.kravetz@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.13]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mike Kravetz [mailto:mike.kravetz@oracle.com]
> Sent: Tuesday, March 30, 2021 12:24 PM
> To: linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Cc: Roman Gushchin <guro@fb.com>; Michal Hocko <mhocko@suse.com>; Shakeel Butt
> <shakeelb@google.com>; Oscar Salvador <osalvador@suse.de>; David Hildenbrand
> <david@redhat.com>; Muchun Song <songmuchun@bytedance.com>; David Rientjes
> <rientjes@google.com>; linmiaohe <linmiaohe@huawei.com>; Peter Zijlstra
> <peterz@infradead.org>; Matthew Wilcox <willy@infradead.org>; HORIGUCHI NAOYA
> <naoya.horiguchi@nec.com>; Aneesh Kumar K . V <aneesh.kumar@linux.ibm.com>;
> Waiman Long <longman@redhat.com>; Peter Xu <peterx@redhat.com>; Mina Almasry
> <almasrymina@google.com>; Hillf Danton <hdanton@sina.com>; Joonsoo Kim
> <iamjoonsoo.kim@lge.com>; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; Will Deacon <will@kernel.org>; Andrew Morton
> <akpm@linux-foundation.org>; Mike Kravetz <mike.kravetz@oracle.com>
> Subject: [PATCH v2 1/8] mm/cma: change cma mutex to irq safe spinlock
> 
> Ideally, cma_release could be called from any context.  However, that is
> not possible because a mutex is used to protect the per-area bitmap.
> Change the bitmap to an irq safe spinlock.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

It seems mutex_lock is locking some areas with bitmap operations which
should be safe to atomic context.

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  mm/cma.c       | 20 +++++++++++---------
>  mm/cma.h       |  2 +-
>  mm/cma_debug.c | 10 ++++++----
>  3 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index b2393b892d3b..80875fd4487b 100644
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
> @@ -83,13 +82,14 @@ static void cma_clear_bitmap(struct cma *cma, unsigned long
> pfn,
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
> @@ -391,8 +391,9 @@ static void cma_debug_show_areas(struct cma *cma)
>  	unsigned long start = 0;
>  	unsigned long nr_part, nr_total = 0;
>  	unsigned long nbits = cma_bitmap_maxno(cma);
> +	unsigned long flags;
> 
> -	mutex_lock(&cma->lock);
> +	spin_lock_irqsave(&cma->lock, flags);
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
> @@ -430,6 +431,7 @@ struct page *cma_alloc(struct cma *cma, size_t count,
> unsigned int align,
>  	unsigned long pfn = -1;
>  	unsigned long start = 0;
>  	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
> +	unsigned long flags;
>  	size_t i;
>  	struct page *page = NULL;
>  	int ret = -ENOMEM;
> @@ -454,12 +456,12 @@ struct page *cma_alloc(struct cma *cma, size_t count,
> unsigned int align,
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
> @@ -468,7 +470,7 @@ struct page *cma_alloc(struct cma *cma, size_t count,
> unsigned int align,
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
> --
> 2.30.2

