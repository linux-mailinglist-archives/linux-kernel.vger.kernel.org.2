Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4045CAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbhKXR2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:28:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4164 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhKXR2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:28:35 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HznqG0SXmz67rcd;
        Thu, 25 Nov 2021 01:21:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 18:25:23 +0100
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 17:25:23 +0000
Subject: Re: [PATCH 9/9] iommu: Move flush queue data into iommu_dma_cookie
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <suravee.suthikulpanit@amd.com>, <baolu.lu@linux.intel.com>,
        <willy@infradead.org>, <linux-kernel@vger.kernel.org>
References: <cover.1637671820.git.robin.murphy@arm.com>
 <49bfd9636fd21c4b40e07558db6bfbbf82a449ac.1637674723.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9dece0b8-2832-f467-91f3-f63ef0f70d16@huawei.com>
Date:   Wed, 24 Nov 2021 17:25:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <49bfd9636fd21c4b40e07558db6bfbbf82a449ac.1637674723.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2021 14:10, Robin Murphy wrote:
> ruct iommu_dma_msi_page {
>   	struct list_head	list;
> @@ -41,7 +43,19 @@ struct iommu_dma_cookie {
>   	enum iommu_dma_cookie_type	type;
>   	union {
>   		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
> -		struct iova_domain	iovad;
> +		struct {
> +			struct iova_domain	iovad;
> +
> +			struct iova_fq __percpu *fq;	/* Flush queue */
> +			/* Number of TLB flushes that have been started */
> +			atomic64_t		fq_flush_start_cnt;
> +			/* Number of TLB flushes that have been finished */
> +			atomic64_t		fq_flush_finish_cnt;
> +			/* Timer to regularily empty the flush queues */
> +			struct timer_list	fq_timer;
> +			/* 1 when timer is active, 0 when not */
> +			atomic_t		fq_timer_on;

I thought that putting all the FQ stuff in its own structure would be 
neater, but that's just personal preference.

Thanks,
John
