Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62BD3A6B01
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhFNP4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:56:46 -0400
Received: from foss.arm.com ([217.140.110.172]:39602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233222AbhFNP4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:56:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48FDC11D4;
        Mon, 14 Jun 2021 08:54:42 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2AF73F70D;
        Mon, 14 Jun 2021 08:54:40 -0700 (PDT)
Subject: Re: [PATCH v12 1/5] iommu: Print strict or lazy mode at init time
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, baolu.lu@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, thunder.leizhen@huawei.com,
        chenxiang66@hisilicon.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-2-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5d98ab53-2ff0-fcbb-3177-bb04a9d2b554@arm.com>
Date:   Mon, 14 Jun 2021 16:54:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1623414043-40745-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-11 13:20, John Garry wrote:
> As well as the default domain type, it's useful to know whether strict
> or lazy for DMA domains, so add this info in a separate print.
> 
> The (stict/lazy) mode may be also set via iommu.strict earlyparm, but
> this will be processed prior to iommu_subsys_init(), so that print will be
> accurate for drivers which don't set the mode via custom means.
> 
> For the drivers which do set the mode via custom means - the AMD and Intel
> drivers - they still maintain prints to notify the change in policy.

Note that you then start removing said prints later in the series, but 
if we repurpose then as deprecation warnings instead as Baolu suggests 
then I reckon it all works out OK. Assuming that,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iommu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5419c4b9f27a..cf58949cc2f3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -138,6 +138,11 @@ static int __init iommu_subsys_init(void)
>   		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
>   			"(set via kernel command line)" : "");
>   
> +	pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
> +		iommu_dma_strict ? "strict" : "lazy",
> +		(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
> +			"(set via kernel command line)" : "");
> +
>   	return 0;
>   }
>   subsys_initcall(iommu_subsys_init);
> 
