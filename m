Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1502331A46B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 19:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhBLSR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 13:17:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231401AbhBLSRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 13:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613153787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZl7b/r+ppu+9/FrF3IJzLz0mVLNre9CvDKAjn1o6yA=;
        b=Cw07S8FXGAnpcX2hI8NlAQUR685ZSI9k49y3ct+ImHhWaIiPWoSt2FVptmKXTTXekWfbP8
        bAae/7cpHmu4hD9gTWah0qmWLTFFpiQusn2wU8xY4hU8+NBMgy1KpWEyys+/rfXTYaYWXK
        8WxNL0ddVtZNqO5RK3M5qmfyNk/k6Vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-h8Vd8kzrMlCZ5LdBkFC8Dg-1; Fri, 12 Feb 2021 13:16:25 -0500
X-MC-Unique: h8Vd8kzrMlCZ5LdBkFC8Dg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B61AAFA81;
        Fri, 12 Feb 2021 18:16:23 +0000 (UTC)
Received: from [10.36.114.34] (ovpn-114-34.ams2.redhat.com [10.36.114.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D7915C23D;
        Fri, 12 Feb 2021 18:16:14 +0000 (UTC)
Subject: Re: [PATCH 2/2] iommu: arm-smmu-v3: Report domain nesting info
 reuqired for stage1
To:     Vivek Gautam <vivek.gautam@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org
Cc:     joro@8bytes.org, will.deacon@arm.com, mst@redhat.com,
        robin.murphy@arm.com, jean-philippe@linaro.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com
References: <20210212105859.8445-1-vivek.gautam@arm.com>
 <20210212105859.8445-3-vivek.gautam@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <07d43c06-9876-2595-1139-b0bc67d94a2c@redhat.com>
Date:   Fri, 12 Feb 2021 19:16:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210212105859.8445-3-vivek.gautam@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

On 2/12/21 11:58 AM, Vivek Gautam wrote:
> Update nested domain information required for stage1 page table.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index c11dd3940583..728018921fae 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2555,6 +2555,7 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
>  					void *data)
>  {
>  	struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	unsigned int size;
>  
>  	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> @@ -2571,9 +2572,20 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
>  		return 0;
>  	}
>  
> -	/* report an empty iommu_nesting_info for now */
> -	memset(info, 0x0, size);
> +	/* Update the nesting info as required for stage1 page tables */
> +	info->addr_width = smmu->ias;
> +	info->format = IOMMU_PASID_FORMAT_ARM_SMMU_V3;
> +	info->features = IOMMU_NESTING_FEAT_BIND_PGTBL |
> +			 IOMMU_NESTING_FEAT_PAGE_RESP |
IOMMU_NESTING_FEAT_PAGE_RESP definition is missing too

Eric
> +			 IOMMU_NESTING_FEAT_CACHE_INVLD;
> +	info->pasid_bits = smmu->ssid_bits;
> +	info->vendor.smmuv3.asid_bits = smmu->asid_bits;
> +	info->vendor.smmuv3.pgtbl_fmt = ARM_64_LPAE_S1;
> +	memset(&info->padding, 0x0, 12);
> +	memset(&info->vendor.smmuv3.padding, 0x0, 9);
> +
>  	info->argsz = size;
> +
>  	return 0;
>  }
>  
> 

