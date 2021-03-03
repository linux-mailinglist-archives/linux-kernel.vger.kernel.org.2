Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4962832C01E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580876AbhCCSfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345206AbhCCRRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:17:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAFFC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 09:16:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n4so7042508wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I6oAOf+1ZMeSBc0SuKKOMGczX7volpKJqxQn9uhodGs=;
        b=VwJ+VHKJcT2Nf/kj3+7hqNO+M8Jub4xI+zPtfFYoQaqgHTl43E/lHcDJW8zwY4eHUq
         PiLw+a7S0TTjtZt0wIdcfocKW4sdtFAs+BSeXQZ7Un71ucylyW/orAbwxZOd7ajhi3GX
         BrLrJ0idIv26+gJboNFBabl6If2U02DArAp2HxxleK+xXxnRqmRLke66PLBm06i/jUHb
         /08oxS3l20Pa7g0INWbcIVqHiKWSiGijLLQ2QZcfFHHpI5KTNRRHdE3+U6JeNHXDdKBq
         A43uJFcfy0NniInhBbUpqMWuHe8aZYtoy4MIMq65vyW2fo9cxrlohPDpfXYdJndR4OVD
         4CPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I6oAOf+1ZMeSBc0SuKKOMGczX7volpKJqxQn9uhodGs=;
        b=qHT3cCqAsQrPLzECxdL0rNGRobM6PXGvs1KQTZPg3pfKvBPJ/HSzWE5hM7J1NgWs26
         5cbHQLPWEEToAP2rj+q0JQJtaLbSEWYqqBmdufCWPAHkhFLpFtWLooUxY+sYgQsUGRTI
         9h92SNLe4YM1TTxmhaCeklmy0j1XeD6HLRw7r5KsUKwrlgLYCong6LIQCM+VqY/bAHxr
         Qz7VY6QV2ylLeGQHT7xlH3+eOzK1OmuvDeLvp5XpV9wxg0wsW8bgZDEmXv7V+BgNr2Mc
         CvySEMyoPWUBQdb80bYsjFCRW8FXBFA9UGmA86X4hpI0Kb427isOHNqd3Y2UxjIvM0q3
         DB2Q==
X-Gm-Message-State: AOAM533xrzUv6RPNafzfXCTzRKU0nbPaUwo+i3JxiqzyKV3THSRemv5F
        Z7y5VWqMb4tx2NZ+guhUZd9myA==
X-Google-Smtp-Source: ABdhPJxEGFLtLtT2CVJqW85OgSqITesZWdYSO96CmRmaHjOUEzXMjLr6QhIIoiQz8us9HKvesrIHzQ==
X-Received: by 2002:a1c:3c02:: with SMTP id j2mr62026wma.92.1614791779611;
        Wed, 03 Mar 2021 09:16:19 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id o2sm6209999wme.16.2021.03.03.09.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:16:18 -0800 (PST)
Date:   Wed, 3 Mar 2021 18:15:57 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFC v1 05/15] iommu/arm-smmu-v3: Set sync op from
 consumer driver of cd-lib
Message-ID: <YD/ETcVwWATG4M6e@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-6-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-6-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:43:32PM +0530, Vivek Gautam wrote:
> Te change allows different consumers of arm-smmu-v3-cd-lib to set
> their respective sync op for pasid entries.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c | 1 -
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c        | 7 +++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> index ec37476c8d09..acaa09acecdd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> @@ -265,7 +265,6 @@ struct iommu_vendor_psdtable_ops arm_cd_table_ops = {
>  	.free	 = arm_smmu_free_cd_tables,
>  	.prepare = arm_smmu_prepare_cd,
>  	.write	 = arm_smmu_write_ctx_desc,
> -	.sync	 = arm_smmu_sync_cd,
>  };
>  
>  struct iommu_pasid_table *arm_smmu_register_cd_table(struct device *dev,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2f86c6ac42b6..0c644be22b4b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1869,6 +1869,13 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>  	if (ret)
>  		goto out_free_cd_tables;
>  
> +	/*
> +	 * Strange to setup an op here?
> +	 * cd-lib is the actual user of sync op, and therefore the platform
> +	 * drivers should assign this sync/maintenance ops as per need.
> +	 */
> +	tbl->ops->sync = arm_smmu_sync_cd;
> +

Modifying a static struct from here doesn't feel right. I think the
interface should be roughly similar to io-pgtable since the principle is
the same. So the sync() op should be separate from arm_cd_table_ops since
it's a callback into the driver. Maybe pass it to
iommu_register_pasid_table().

Thanks,
Jean
