Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A23B349276
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhCYMxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:53:00 -0400
Received: from foss.arm.com ([217.140.110.172]:48298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhCYMwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:52:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEAC71474;
        Thu, 25 Mar 2021 05:52:40 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A5083F792;
        Thu, 25 Mar 2021 05:52:39 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] iommu: Delete iommu_dma_free_cpu_cached_iovas()
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, baolu.lu@linux.intel.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
 <1616675401-151997-4-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9852e410-eec8-1d82-8704-cd7bc8b0a07b@arm.com>
Date:   Thu, 25 Mar 2021 12:52:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616675401-151997-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-25 12:30, John Garry wrote:
> Function iommu_dma_free_cpu_cached_iovas() no longer has any caller, so
> delete it.
> 
> With that, function free_cpu_cached_iovas() may be made static.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 9 ---------
>   drivers/iommu/iova.c      | 3 ++-
>   include/linux/dma-iommu.h | 8 --------
>   include/linux/iova.h      | 5 -----
>   4 files changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index af765c813cc8..9da7e9901bec 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -53,15 +53,6 @@ struct iommu_dma_cookie {
>   
>   static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
>   
> -void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> -		struct iommu_domain *domain)
> -{
> -	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	struct iova_domain *iovad = &cookie->iovad;
> -
> -	free_cpu_cached_iovas(cpu, iovad);
> -}
> -
>   static void iommu_dma_entry_dtor(unsigned long data)
>   {
>   	struct page *freelist = (struct page *)data;
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index c78312560425..8a493ee92c79 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -22,6 +22,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>   				     unsigned long size,
>   				     unsigned long limit_pfn);
>   static void init_iova_rcaches(struct iova_domain *iovad);
> +static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>   static void free_iova_rcaches(struct iova_domain *iovad);
>   static void fq_destroy_all_entries(struct iova_domain *iovad);
>   static void fq_flush_timeout(struct timer_list *t);
> @@ -998,7 +999,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   /*
>    * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
>    */
> -void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
> +static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>   {
>   	struct iova_cpu_rcache *cpu_rcache;
>   	struct iova_rcache *rcache;
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 706b68d1359b..2112f21f73d8 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -37,9 +37,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>   
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
> -void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> -		struct iommu_domain *domain);
> -
>   #else /* CONFIG_IOMMU_DMA */
>   
>   struct iommu_domain;
> @@ -81,10 +78,5 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>   {
>   }
>   
> -static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> -		struct iommu_domain *domain)
> -{
> -}
> -
>   #endif	/* CONFIG_IOMMU_DMA */
>   #endif	/* __DMA_IOMMU_H */
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 4be6c0ab4997..71d8a2de6635 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -157,7 +157,6 @@ int init_iova_flush_queue(struct iova_domain *iovad,
>   			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
>   struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>   void put_iova_domain(struct iova_domain *iovad);
> -void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>   #else
>   static inline int iova_cache_get(void)
>   {
> @@ -234,10 +233,6 @@ static inline void put_iova_domain(struct iova_domain *iovad)
>   {
>   }
>   
> -static inline void free_cpu_cached_iovas(unsigned int cpu,
> -					 struct iova_domain *iovad)
> -{
> -}
>   #endif
>   
>   #endif
> 
