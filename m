Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC5432BFFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580636AbhCCSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242777AbhCCRPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:15:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E63CC061763
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 09:14:51 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n22so5800980wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m0yEupP/L76P6gyISve2gAOojgj7J2+MhN1/3SbMwsE=;
        b=C6KCV2Ndp6CnJ973AOgZXdDV2ekUchmEJSgJwIBEmdHi354O2kCSutw5rxsuaetRS2
         6TWGzr8yJbWn4m3Gscu98rUzjS2Da4D50fqwZ+2nRW3QMP/1VIwc8h4YVEOlFw1OyElu
         xR9MPTccInyAI8SkqACUaRFoBJTIw+uwfVrORZaWtVapcLsDmBiWKh6hdddFwFXInOZh
         xJjh9otvchYhdcs8tvPO2rfa1cVCTzy81vjuAhs8lCNNERHj3NaDswXNENqNEwXgT/6q
         jez/V3484hDD5fJMt5nEduLgJm3Fs3iR+fK1ydpKCCATvHZ1rXTXxQ04lcxTcAOS0RKV
         bPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m0yEupP/L76P6gyISve2gAOojgj7J2+MhN1/3SbMwsE=;
        b=Hsen3qYroIG6dlbqPJ8iXYGiN9+PVudFYa4Jrm93pMIKX9i0P4Hm9iMKhDF8zyvDat
         nC0FMvWwxpKqelJDeDkQC55OScPNoac4Sxq6LkKCGnrgyn7ir9frY7wj/5F1qqKHSYVw
         7+T8exQCb+bYLbe8zfKexveru2hkRgI0EHnb2JiB9PyF2brKBAufrqwo2JBYXzgqV2ne
         nxwvHG+X0waZGektKz/lHFkE7DWRaTQHbesTIW6Mu+yY0sDgtBP0rJ4DWV9xeQB8GzAo
         CCstdtRtpSlsdV9W4AjySie4yqhoSyONOUu6xfPYMnLhnaVAdbn0E9k/v81JgcaFIguv
         Zg5g==
X-Gm-Message-State: AOAM532L2toDznDZwnYjhjDB9OXQYpOCfIfXgdcaPuCQYPlZ7uaEPg3F
        skfhP8msB/ytgqq+LSxNTbmxzw==
X-Google-Smtp-Source: ABdhPJyTjnQxRH4h4WtoiKSNYqpA2AI+RhtLePJP1THwR+Upij+BED0FnmLt0W2lDduYTxT0WBRsbg==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr69805wmj.54.1614791690288;
        Wed, 03 Mar 2021 09:14:50 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v5sm6552574wmh.2.2021.03.03.09.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:14:49 -0800 (PST)
Date:   Wed, 3 Mar 2021 18:14:28 +0100
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
Subject: Re: [PATCH RFC v1 04/15] iommu/arm-smmu-v3: Update CD base address
 info for user-space
Message-ID: <YD/D9HJxH9L503an@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-5-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-5-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:43:31PM +0530, Vivek Gautam wrote:
> Update base address information in vendor pasid table info to pass that
> to user-space for stage1 table management.
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
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> index 8a7187534706..ec37476c8d09 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-cd-lib.c
> @@ -55,6 +55,9 @@ static __le64 *arm_smmu_get_cd_ptr(struct iommu_vendor_psdtable_cfg *pst_cfg,
>  		if (arm_smmu_alloc_cd_leaf_table(dev, l1_desc))
>  			return NULL;
>  
> +		if (s1cfg->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
> +			pst_cfg->base = l1_desc->l2ptr_dma;
> +

This isn't the right place, because this path allocates second-level
tables for two-level tables. I don't think we need pst_cfg->base at all,
because for both linear and two-level tables, the base pointer is in
cdcfg->cdtab_dma, which can be read directly.

Thanks,
Jean

>  		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
>  		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
>  		/* An invalid L1CD can be cached */
> @@ -211,6 +214,9 @@ static int arm_smmu_alloc_cd_tables(struct iommu_vendor_psdtable_cfg *pst_cfg)
>  		goto err_free_l1;
>  	}
>  
> +	if (s1cfg->s1fmt == STRTAB_STE_0_S1FMT_64K_L2)
> +		pst_cfg->base = cdcfg->cdtab_dma;
> +
>  	return 0;
>  
>  err_free_l1:
> -- 
> 2.17.1
> 
