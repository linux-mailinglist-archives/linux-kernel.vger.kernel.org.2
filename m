Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F8E3ACBC8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhFRNMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:12:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:64373 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232238AbhFRNMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:12:50 -0400
IronPort-SDR: T2w412mmboZhkx4k+r06c/DMBFp3p8ITDo8jqMYjXLgJnlodtt7QjHxgjOTlQA/ltld0F3E8Us
 btkH2j9Wyc4A==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="204721394"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="204721394"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:10:41 -0700
IronPort-SDR: ndZdFsDW8Q3BKEovwvKaFojvoM9Lgdt1pUsbdH7Je72Npur3QRwE+sGTVj3Ui9CsuA7D0y+wic
 hZY4iAqUlEBQ==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485683801"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.157]) ([10.254.212.157])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:10:38 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v14 2/6] iommu: Print strict or lazy mode at init time
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com,
        corbet@lwn.net
References: <1624016058-189713-1-git-send-email-john.garry@huawei.com>
 <1624016058-189713-3-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <502b7d81-7c6e-affd-0e06-4f0caf7e9fb9@linux.intel.com>
Date:   Fri, 18 Jun 2021 21:10:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624016058-189713-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/18 19:34, John Garry wrote:
> As well as the default domain type, it's useful to know whether strict
> or lazy for DMA domains, so add this info in a separate print.
> 
> The (stict/lazy) mode may be also set via iommu.strict earlyparm, but
> this will be processed prior to iommu_subsys_init(), so that print will be
> accurate for drivers which don't set the mode via custom means.
> 
> For the drivers which set the mode via custom means - AMD and Intel drivers
> - they maintain prints to inform a change in policy or that custom cmdline
> methods to change policy are deprecated.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
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

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
