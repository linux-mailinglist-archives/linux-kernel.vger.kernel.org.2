Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFFD367963
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 07:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhDVFok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 01:44:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:64172 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhDVFoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:44:37 -0400
IronPort-SDR: xV1Z3RRjb/WtKFEihkvzfET9UYE1juTKwtFIM3ZLYUJlYV6HvbaU4SwMfc44pe5p3lRu0Ynwqd
 9XlJHZ8eY7Fg==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="175316669"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="175316669"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 22:44:03 -0700
IronPort-SDR: OiZdGW1Av586D5MrQvzGUrwiUhBfctjZwZ/+Pyckqj1gLR1228+nK0/UXRuR0T+h8rBfd6fxWF
 Px7Xo04WsKZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="524527974"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2021 22:44:01 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix sysfs leak in alloc_domain()
To:     Rolf Eike Beer <eb@emlix.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
References: <1716403.SmlLz2RZUD@devpool47>
 <17411490.HIIP88n32C@mobilepool36.emlix.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <b13c4073-5976-b4e0-4dc7-4e07e68cbb5f@linux.intel.com>
Date:   Thu, 22 Apr 2021 13:34:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <17411490.HIIP88n32C@mobilepool36.emlix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rolf,

On 4/22/21 1:39 PM, Rolf Eike Beer wrote:
> iommu_device_sysfs_add() is called before, so is has to be cleaned on subsequent
> errors.
> 
> Fixes: 39ab9555c2411 ("iommu: Add sysfs bindings for struct iommu_device")
> Cc: stable@vger.kernel.org # 4.11.x
> Signed-off-by: Rolf Eike Beer <eb@emlix.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

P.S. Next time when you submit a new version, please use a version tag.

Best regards,
baolu

> ---
>   drivers/iommu/intel/dmar.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d5c51b5c20af..c2bfccb19e24 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1144,7 +1144,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   
>   		err = iommu_device_register(&iommu->iommu);
>   		if (err)
> -			goto err_unmap;
> +			goto err_sysfs;
>   	}
>   
>   	drhd->iommu = iommu;
> @@ -1152,6 +1152,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   
>   	return 0;
>   
> +err_sysfs:
> +	iommu_device_sysfs_remove(&iommu->iommu);
>   err_unmap:
>   	unmap_iommu(iommu);
>   error_free_seq_id:
> 
