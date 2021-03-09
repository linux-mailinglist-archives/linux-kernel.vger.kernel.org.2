Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259B7332B4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhCIP57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:57:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2670 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhCIP51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:57:27 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dw0511sW8z67w3k;
        Tue,  9 Mar 2021 23:49:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 16:57:25 +0100
Received: from [10.210.172.22] (10.210.172.22) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Mar 2021 15:57:24 +0000
Subject: Re: [PATCH 2/2] iommu/iova: Improve restart logic
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <thunder.leizhen@huawei.com>,
        <vjitta@codeaurora.org>, <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        chenxiang <chenxiang66@hisilicon.com>
References: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
 <076b3484d1e5057b95d8c387c894bd6ad2514043.1614962123.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c1181e3b-cdf3-c658-1c57-8ec86d034f4b@huawei.com>
Date:   Tue, 9 Mar 2021 15:55:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <076b3484d1e5057b95d8c387c894bd6ad2514043.1614962123.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.22]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2021 16:35, Robin Murphy wrote:

Hi Robin,

> When restarting after searching below the cached node fails, resetting
> the start point to the anchor node is often overly pessimistic. If
> allocations are made with mixed limits - particularly in the case of the
> opportunistic 32-bit allocation for PCI devices - this could mean
> significant time wasted walking through the whole populated upper range
> just to reach the initial limit. 

Right

> We can improve on that by implementing
> a proper tree traversal to find the first node above the relevant limit,
> and set the exact start point.

Thanks for this. However, as mentioned in the other thread, this does 
not help our performance regression Re: commit 4e89dce72521.

And mentioning this "retry" approach again, in case it was missed, from 
my experiment on the affected HW, it also has generally a dreadfully low 
success rate - less than 1% for the 32b range retry. Retry rate is about 
20%. So I am saying from this 20%, less than 1% of those succeed.

Failing faster sounds key.

Thanks,
John

> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iova.c | 39 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index c28003e1d2ee..471c48dd71e7 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -154,6 +154,43 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
>   		iovad->cached_node = rb_next(&free->node);
>   }
>   
> +static struct rb_node *iova_find_limit(struct iova_domain *iovad, unsigned long limit_pfn)
> +{
> +	struct rb_node *node, *next;
> +	/*
> +	 * Ideally what we'd like to judge here is whether limit_pfn is close
> +	 * enough to the highest-allocated IOVA that starting the allocation
> +	 * walk from the anchor node will be quicker than this initial work to
> +	 * find an exact starting point (especially if that ends up being the
> +	 * anchor node anyway). This is an incredibly crude approximation which
> +	 * only really helps the most likely case, but is at least trivially easy.
> +	 */
> +	if (limit_pfn > iovad->dma_32bit_pfn)
> +		return &iovad->anchor.node;
> +
> +	node = iovad->rbroot.rb_node;
> +	while (to_iova(node)->pfn_hi < limit_pfn)
> +		node = node->rb_right;
> +
> +search_left:
> +	while (node->rb_left && to_iova(node->rb_left)->pfn_lo >= limit_pfn)
> +		node = node->rb_left;
> +
> +	if (!node->rb_left)
> +		return node;
> +
> +	next = node->rb_left;
> +	while (next->rb_right) {
> +		next = next->rb_right;
> +		if (to_iova(next)->pfn_lo >= limit_pfn) {
> +			node = next;
> +			goto search_left;
> +		}
> +	}
> +
> +	return node;
> +}
> +
>   /* Insert the iova into domain rbtree by holding writer lock */
>   static void
>   iova_insert_rbtree(struct rb_root *root, struct iova *iova,
> @@ -219,7 +256,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>   		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
>   			high_pfn = limit_pfn;
>   			low_pfn = retry_pfn;
> -			curr = &iovad->anchor.node;
> +			curr = iova_find_limit(iovad, limit_pfn);
>   			curr_iova = to_iova(curr);
>   			goto retry;
>   		}
> 

