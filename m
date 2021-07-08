Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A333C1801
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhGHRZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:25:07 -0400
Received: from foss.arm.com ([217.140.110.172]:35038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhGHRZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:25:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4415FED1;
        Thu,  8 Jul 2021 10:22:23 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27E413F73B;
        Thu,  8 Jul 2021 10:22:22 -0700 (PDT)
Subject: Re: [PATCH 1/4] dma-iommu: add kalloc gfp flag to alloc helper
To:     David Stevens <stevensd@chromium.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
References: <20210707075505.2896824-1-stevensd@google.com>
 <20210707075505.2896824-2-stevensd@google.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8cdbcbbb-5064-ae7f-af4a-abb0e4203b6d@arm.com>
Date:   Thu, 8 Jul 2021 18:22:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707075505.2896824-2-stevensd@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-07 08:55, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Add gfp flag for kalloc calls within __iommu_dma_alloc_pages, so the
> function can be called from atomic contexts.

Why bother? If you need GFP_ATOMIC for allocating the pages array, then 
you don't not need it for allocating the pages themselves. It's hardly 
rocket science to infer one from the other.

Robin.

> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/iommu/dma-iommu.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 614f0dd86b08..00993b56c977 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -593,7 +593,8 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
>   }
>   
>   static struct page **__iommu_dma_alloc_pages(struct device *dev,
> -		unsigned int count, unsigned long order_mask, gfp_t gfp)
> +		unsigned int count, unsigned long order_mask,
> +		gfp_t page_gfp, gfp_t kalloc_gfp)
>   {
>   	struct page **pages;
>   	unsigned int i = 0, nid = dev_to_node(dev);
> @@ -602,15 +603,15 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   	if (!order_mask)
>   		return NULL;
>   
> -	pages = kvzalloc(count * sizeof(*pages), GFP_KERNEL);
> +	pages = kvzalloc(count * sizeof(*pages), kalloc_gfp);
>   	if (!pages)
>   		return NULL;
>   
>   	/* IOMMU can map any pages, so himem can also be used here */
> -	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
> +	page_gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
>   
>   	/* It makes no sense to muck about with huge pages */
> -	gfp &= ~__GFP_COMP;
> +	page_gfp &= ~__GFP_COMP;
>   
>   	while (count) {
>   		struct page *page = NULL;
> @@ -624,7 +625,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   		for (order_mask &= (2U << __fls(count)) - 1;
>   		     order_mask; order_mask &= ~order_size) {
>   			unsigned int order = __fls(order_mask);
> -			gfp_t alloc_flags = gfp;
> +			gfp_t alloc_flags = page_gfp;
>   
>   			order_size = 1U << order;
>   			if (order_mask > order_size)
> @@ -680,7 +681,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
>   
>   	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>   	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
> -					gfp);
> +					gfp, GFP_KERNEL);
>   	if (!pages)
>   		return NULL;
>   
> 
