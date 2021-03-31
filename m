Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0496350586
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 19:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhCaRfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 13:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233867AbhCaRes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 13:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617212087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfb3+QJTICoAcBVnRAz+A/OozCnNFwZhALhIsGKfQ1M=;
        b=Uwel9WHAj7Io3/8AaYwRCnjHuNgpo/A3btGRPVdkyk7FwX5L3roy6z6kTTMDgSAaBrIGly
        bYWBgrpILaWOCe6t2TnzwJv5j+JQvlbsBc7YPAAYWkuTx3Z3yGfV6ZI5Jo8xmB4FAeNL3z
        2wV03fJwy4m+mlKG8+fSEm8UhMCbJHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-ctfOQft4NFG91yjqFYrHFA-1; Wed, 31 Mar 2021 13:34:43 -0400
X-MC-Unique: ctfOQft4NFG91yjqFYrHFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13357180FCA1;
        Wed, 31 Mar 2021 17:34:42 +0000 (UTC)
Received: from [10.36.113.60] (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70A661DB;
        Wed, 31 Mar 2021 17:34:40 +0000 (UTC)
Subject: Re: [PATCH] mm: use proper type for cma_[alloc|release]
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, Matthew Wilcox <willy@infradead.org>
References: <20210331164018.710560-1-minchan@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5af695c6-4698-9945-1d2d-164665c056f6@redhat.com>
Date:   Wed, 31 Mar 2021 19:34:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210331164018.710560-1-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.03.21 18:40, Minchan Kim wrote:
> size_t in cma_alloc is confusing since it makes people think
> it's byte count, not pages. Change it to unsigned long[1].
> 
> The unsigned int in cma_release is also not right so change it.
> Since we have unsigned long in cma_release, free_contig_range
> should also respect it.
> 
> [1] 67a2e213e7e9, mm: cma: fix incorrect type conversion for size during dma allocation
> Link: https://lore.kernel.org/linux-mm/20210324043434.GP1719932@casper.infradead.org/
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>   include/linux/cma.h        |  4 ++--
>   include/linux/gfp.h        |  2 +-
>   include/trace/events/cma.h | 22 +++++++++++-----------
>   mm/cma.c                   | 17 +++++++++--------
>   mm/page_alloc.c            |  6 +++---
>   5 files changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 217999c8a762..53fd8c3cdbd0 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -44,9 +44,9 @@ extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>   					unsigned int order_per_bit,
>   					const char *name,
>   					struct cma **res_cma);
> -extern struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> +extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
>   			      bool no_warn);
> -extern bool cma_release(struct cma *cma, const struct page *pages, unsigned int count);
> +extern bool cma_release(struct cma *cma, const struct page *pages, unsigned long count);
>   
>   extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data);
>   #endif
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 0a88f84b08f4..529c27c6cb15 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -639,7 +639,7 @@ extern int alloc_contig_range(unsigned long start, unsigned long end,
>   extern struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
>   				       int nid, nodemask_t *nodemask);
>   #endif
> -void free_contig_range(unsigned long pfn, unsigned int nr_pages);
> +void free_contig_range(unsigned long pfn, unsigned long nr_pages);
>   
>   #ifdef CONFIG_CMA
>   /* CMA stuff */
> diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
> index 5cf385ae7c08..c3d354702cb0 100644
> --- a/include/trace/events/cma.h
> +++ b/include/trace/events/cma.h
> @@ -11,7 +11,7 @@
>   DECLARE_EVENT_CLASS(cma_alloc_class,
>   
>   	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
> -		 unsigned int count, unsigned int align),
> +		 unsigned long count, unsigned int align),
>   
>   	TP_ARGS(name, pfn, page, count, align),
>   
> @@ -19,7 +19,7 @@ DECLARE_EVENT_CLASS(cma_alloc_class,
>   		__string(name, name)
>   		__field(unsigned long, pfn)
>   		__field(const struct page *, page)
> -		__field(unsigned int, count)
> +		__field(unsigned long, count)
>   		__field(unsigned int, align)
>   	),
>   
> @@ -31,7 +31,7 @@ DECLARE_EVENT_CLASS(cma_alloc_class,
>   		__entry->align = align;
>   	),
>   
> -	TP_printk("name=%s pfn=%lx page=%p count=%u align=%u",
> +	TP_printk("name=%s pfn=%lx page=%p count=%lu align=%u",
>   		  __get_str(name),
>   		  __entry->pfn,
>   		  __entry->page,
> @@ -42,7 +42,7 @@ DECLARE_EVENT_CLASS(cma_alloc_class,
>   TRACE_EVENT(cma_release,
>   
>   	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
> -		 unsigned int count),
> +		 unsigned long count),
>   
>   	TP_ARGS(name, pfn, page, count),
>   
> @@ -50,7 +50,7 @@ TRACE_EVENT(cma_release,
>   		__string(name, name)
>   		__field(unsigned long, pfn)
>   		__field(const struct page *, page)
> -		__field(unsigned int, count)
> +		__field(unsigned long, count)
>   	),
>   
>   	TP_fast_assign(
> @@ -60,7 +60,7 @@ TRACE_EVENT(cma_release,
>   		__entry->count = count;
>   	),
>   
> -	TP_printk("name=%s pfn=%lx page=%p count=%u",
> +	TP_printk("name=%s pfn=%lx page=%p count=%lu",
>   		  __get_str(name),
>   		  __entry->pfn,
>   		  __entry->page,
> @@ -69,13 +69,13 @@ TRACE_EVENT(cma_release,
>   
>   TRACE_EVENT(cma_alloc_start,
>   
> -	TP_PROTO(const char *name, unsigned int count, unsigned int align),
> +	TP_PROTO(const char *name, unsigned long count, unsigned int align),
>   
>   	TP_ARGS(name, count, align),
>   
>   	TP_STRUCT__entry(
>   		__string(name, name)
> -		__field(unsigned int, count)
> +		__field(unsigned long, count)
>   		__field(unsigned int, align)
>   	),
>   
> @@ -85,7 +85,7 @@ TRACE_EVENT(cma_alloc_start,
>   		__entry->align = align;
>   	),
>   
> -	TP_printk("name=%s count=%u align=%u",
> +	TP_printk("name=%s count=%lu align=%u",
>   		  __get_str(name),
>   		  __entry->count,
>   		  __entry->align)
> @@ -94,7 +94,7 @@ TRACE_EVENT(cma_alloc_start,
>   DEFINE_EVENT(cma_alloc_class, cma_alloc_finish,
>   
>   	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
> -		 unsigned int count, unsigned int align),
> +		 unsigned long count, unsigned int align),
>   
>   	TP_ARGS(name, pfn, page, count, align)
>   );
> @@ -102,7 +102,7 @@ DEFINE_EVENT(cma_alloc_class, cma_alloc_finish,
>   DEFINE_EVENT(cma_alloc_class, cma_alloc_busy_retry,
>   
>   	TP_PROTO(const char *name, unsigned long pfn, const struct page *page,
> -		 unsigned int count, unsigned int align),
> +		 unsigned long count, unsigned int align),
>   
>   	TP_ARGS(name, pfn, page, count, align)
>   );
> diff --git a/mm/cma.c b/mm/cma.c
> index de6b9f01be53..f3bca4178c7f 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -80,7 +80,7 @@ static unsigned long cma_bitmap_pages_to_bits(const struct cma *cma,
>   }
>   
>   static void cma_clear_bitmap(struct cma *cma, unsigned long pfn,
> -			     unsigned int count)
> +			     unsigned long count)
>   {
>   	unsigned long bitmap_no, bitmap_count;
>   
> @@ -423,21 +423,21 @@ static inline void cma_debug_show_areas(struct cma *cma) { }
>    * This function allocates part of contiguous memory on specific
>    * contiguous memory area.
>    */
> -struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> -		       bool no_warn)
> +struct page *cma_alloc(struct cma *cma, unsigned long count,
> +		       unsigned int align, bool no_warn)
>   {
>   	unsigned long mask, offset;
>   	unsigned long pfn = -1;
>   	unsigned long start = 0;
>   	unsigned long bitmap_maxno, bitmap_no, bitmap_count;
> -	size_t i;
> +	unsigned long i;
>   	struct page *page = NULL;
>   	int ret = -ENOMEM;
>   
>   	if (!cma || !cma->count || !cma->bitmap)
>   		goto out;
>   
> -	pr_debug("%s(cma %p, count %zu, align %d)\n", __func__, (void *)cma,
> +	pr_debug("%s(cma %p, count %lu, align %d)\n", __func__, (void *)cma,
>   		 count, align);
>   
>   	if (!count)
> @@ -505,7 +505,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   	}
>   
>   	if (ret && !no_warn) {
> -		pr_err_ratelimited("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
> +		pr_err_ratelimited("%s: %s: alloc failed, req-size: %lu pages, ret: %d\n",
>   				   __func__, cma->name, count, ret);
>   		cma_debug_show_areas(cma);
>   	}
> @@ -534,14 +534,15 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>    * It returns false when provided pages do not belong to contiguous area and
>    * true otherwise.
>    */
> -bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
> +bool cma_release(struct cma *cma, const struct page *pages,
> +		 unsigned long count)
>   {
>   	unsigned long pfn;
>   
>   	if (!cma || !pages)
>   		return false;
>   
> -	pr_debug("%s(page %p, count %u)\n", __func__, (void *)pages, count);
> +	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
>   
>   	pfn = page_to_pfn(pages);
>   
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index c53fe4fa10bf..21540fb29b0d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8817,9 +8817,9 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
>   }
>   #endif /* CONFIG_CONTIG_ALLOC */
>   
> -void free_contig_range(unsigned long pfn, unsigned int nr_pages)
> +void free_contig_range(unsigned long pfn, unsigned long nr_pages)
>   {
> -	unsigned int count = 0;
> +	unsigned long count = 0;
>   
>   	for (; nr_pages--; pfn++) {
>   		struct page *page = pfn_to_page(pfn);
> @@ -8827,7 +8827,7 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
>   		count += page_count(page) != 1;
>   		__free_page(page);
>   	}
> -	WARN(count != 0, "%d pages are still in use!\n", count);
> +	WARN(count != 0, "%lu pages are still in use!\n", count);
>   }
>   EXPORT_SYMBOL(free_contig_range);
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

