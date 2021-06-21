Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318553AE2B2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 07:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFUFTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 01:19:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:49645 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhFUFTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 01:19:46 -0400
IronPort-SDR: 3hn5S7zWgrUGkcg3Ypl98Hf5aaL8yznB6a2V7+IgnT1r+syQJsuQIhR0FkiPui0rbiWWoPSJ3j
 gF5YmjyyXxrA==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="267919629"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="267919629"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 22:17:32 -0700
IronPort-SDR: 9Xxri7XJd9v6KBQMO9fhv7VvxtB0dH0OGtBQ4S0a8I7KOm46M0mLtWytuAniowgdp2Wya2YagJ
 ed//po5RjGhA==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="453761991"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.249]) ([10.254.211.249])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 22:17:29 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-7-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v14 6/6] iommu: Remove mode argument from
 iommu_set_dma_strict()
Message-ID: <c062ef9e-c106-4218-ba2a-c94fdcb6d955@linux.intel.com>
Date:   Mon, 21 Jun 2021 13:17:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624016058-189713-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/18 19:34, John Garry wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 60b1ec42e73b..ff221d3ddcbc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -349,10 +349,9 @@ static int __init iommu_dma_setup(char *str)
>   }
>   early_param("iommu.strict", iommu_dma_setup);
>   
> -void iommu_set_dma_strict(bool strict)
> +void iommu_set_dma_strict(void)
>   {
> -	if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
> -		iommu_dma_strict = strict;
> +	iommu_dma_strict = true;
>   }

Sorry for this late comment.

Normally the cache invalidation policy should come from the user. We
have pre-build kernel option and also a kernel boot command iommu.strict
to override it. These seem reasonable.

We also have a helper (iommu_set_dma_strict()) so that the vendor iommu
driver could squeeze in and change the previous settings mostly due to:

a) vendor iommu driver specific kernel boot command. (We are about to
    deprecate those.)

b) quirky hardware.

c) kernel optimization (e.x. strict mode in VM environment).

a) and b) are mandatory, while c) is optional. In any instance should c)
override the flush mode specified by the user. Hence, probably we should
also have another helper like:

void iommu_set_dma_strict_optional()
{
	if (!(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
		iommu_dma_strict = true;
}

Any thoughts?

Best regards,
baolu
