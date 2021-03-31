Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18BC345E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhCWMp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:45:57 -0400
Received: from foss.arm.com ([217.140.110.172]:45840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231138AbhCWMpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:45:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F23D6E;
        Tue, 23 Mar 2021 05:45:32 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 972D93F719;
        Tue, 23 Mar 2021 05:45:31 -0700 (PDT)
Subject: Re: [PATCH 1/3] iova: Add CPU hotplug handler to flush rcaches
To:     John Garry <john.garry@huawei.com>, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
 <1614600741-15696-2-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7085b559-3d84-2bc1-5c36-8e034a66f8fc@arm.com>
Date:   Tue, 23 Mar 2021 12:45:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1614600741-15696-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-01 12:12, John Garry wrote:
> Like the intel IOMMU driver already does, flush the per-IOVA domain
> CPU rcache when a CPU goes offline - there's no point in keeping it.

Thanks John!

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iova.c       | 30 +++++++++++++++++++++++++++++-
>   include/linux/cpuhotplug.h |  1 +
>   include/linux/iova.h       |  1 +
>   3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index e6e2fa85271c..c78312560425 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -25,6 +25,17 @@ static void init_iova_rcaches(struct iova_domain *iovad);
>   static void free_iova_rcaches(struct iova_domain *iovad);
>   static void fq_destroy_all_entries(struct iova_domain *iovad);
>   static void fq_flush_timeout(struct timer_list *t);
> +
> +static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct iova_domain *iovad;
> +
> +	iovad = hlist_entry_safe(node, struct iova_domain, cpuhp_dead);
> +
> +	free_cpu_cached_iovas(cpu, iovad);
> +	return 0;
> +}
> +
>   static void free_global_cached_iovas(struct iova_domain *iovad);
>   
>   void
> @@ -51,6 +62,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>   	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
>   	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
>   	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
> +	cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD, &iovad->cpuhp_dead);
>   	init_iova_rcaches(iovad);
>   }
>   EXPORT_SYMBOL_GPL(init_iova_domain);
> @@ -257,10 +269,21 @@ int iova_cache_get(void)
>   {
>   	mutex_lock(&iova_cache_mutex);
>   	if (!iova_cache_users) {
> +		int ret;
> +
> +		ret = cpuhp_setup_state_multi(CPUHP_IOMMU_IOVA_DEAD, "iommu/iova:dead", NULL,
> +					iova_cpuhp_dead);
> +		if (ret) {
> +			mutex_unlock(&iova_cache_mutex);
> +			pr_err("Couldn't register cpuhp handler\n");
> +			return ret;
> +		}
> +
>   		iova_cache = kmem_cache_create(
>   			"iommu_iova", sizeof(struct iova), 0,
>   			SLAB_HWCACHE_ALIGN, NULL);
>   		if (!iova_cache) {
> +			cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
>   			mutex_unlock(&iova_cache_mutex);
>   			pr_err("Couldn't create iova cache\n");
>   			return -ENOMEM;
> @@ -282,8 +305,10 @@ void iova_cache_put(void)
>   		return;
>   	}
>   	iova_cache_users--;
> -	if (!iova_cache_users)
> +	if (!iova_cache_users) {
> +		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
>   		kmem_cache_destroy(iova_cache);
> +	}
>   	mutex_unlock(&iova_cache_mutex);
>   }
>   EXPORT_SYMBOL_GPL(iova_cache_put);
> @@ -606,6 +631,9 @@ void put_iova_domain(struct iova_domain *iovad)
>   {
>   	struct iova *iova, *tmp;
>   
> +	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> +					    &iovad->cpuhp_dead);
> +
>   	free_iova_flush_queue(iovad);
>   	free_iova_rcaches(iovad);
>   	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot, node)
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index f14adb882338..cedac9986557 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -58,6 +58,7 @@ enum cpuhp_state {
>   	CPUHP_NET_DEV_DEAD,
>   	CPUHP_PCI_XGENE_DEAD,
>   	CPUHP_IOMMU_INTEL_DEAD,
> +	CPUHP_IOMMU_IOVA_DEAD,
>   	CPUHP_LUSTRE_CFS_DEAD,
>   	CPUHP_AP_ARM_CACHE_B15_RAC_DEAD,
>   	CPUHP_PADATA_DEAD,
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index c834c01c0a5b..4be6c0ab4997 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -95,6 +95,7 @@ struct iova_domain {
>   						   flush-queues */
>   	atomic_t fq_timer_on;			/* 1 when timer is active, 0
>   						   when not */
> +	struct hlist_node	cpuhp_dead;
>   };
>   
>   static inline unsigned long iova_size(struct iova *iova)
> 
