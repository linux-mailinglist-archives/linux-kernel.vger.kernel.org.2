Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D701D3D9E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 09:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhG2HPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 03:15:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:41944 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234526AbhG2HPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:15:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="209707886"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="209707886"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 00:15:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="464977711"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 00:15:33 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, john.garry@huawei.com,
        dianders@chromium.org
Subject: Re: [PATCH v2 18/24] iommu: Express DMA strictness via the domain
 type
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <50bee17e9248ccfccb33a10238210d4ff4f4cf4d.1627468309.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b479f1f9-ecf2-2798-2df8-ae3d4c06bc63@linux.intel.com>
Date:   Thu, 29 Jul 2021 15:13:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <50bee17e9248ccfccb33a10238210d4ff4f4cf4d.1627468309.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 7/28/21 11:58 PM, Robin Murphy wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 982545234cf3..eecb5657de69 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -136,6 +136,9 @@ static int __init iommu_subsys_init(void)
>   		}
>   	}
>   
> +	if (!iommu_default_passthrough() && !iommu_dma_strict)
> +		iommu_def_domain_type = IOMMU_DOMAIN_DMA_FQ;

iommu_dma_strict could be changed later by the vendor iommu driver via
iommu_set_dma_strict(). This seems not to be the right place to set
iommu_def_domain_type.

> +
>   	pr_info("Default domain type: %s %s\n",
>   		iommu_domain_type_str(iommu_def_domain_type),
>   		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?

Best regards,
baolu
