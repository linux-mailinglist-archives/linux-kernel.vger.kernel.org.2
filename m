Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9832349277
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhCYMxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:53:37 -0400
Received: from foss.arm.com ([217.140.110.172]:48336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbhCYMxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:53:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 904421476;
        Thu, 25 Mar 2021 05:53:07 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5015F3F792;
        Thu, 25 Mar 2021 05:53:06 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] iommu: Stop exporting free_iova_fast()
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, baolu.lu@linux.intel.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
 <1616675401-151997-5-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <19a23ac8-249e-0e7b-18a1-19c09e63415a@arm.com>
Date:   Thu, 25 Mar 2021 12:53:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1616675401-151997-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-25 12:30, John Garry wrote:
> Function free_iova_fast() is only referenced by dma-iommu.c, which can
> only be in-built, so stop exporting it.
> 
> This was missed in an earlier tidy-up patch.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iova.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 8a493ee92c79..e31e79a9f5c3 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -493,7 +493,6 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
>   
>   	free_iova(iovad, pfn);
>   }
> -EXPORT_SYMBOL_GPL(free_iova_fast);
>   
>   #define fq_ring_for_each(i, fq) \
>   	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
> 
