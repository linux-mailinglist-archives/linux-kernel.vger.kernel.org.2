Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F6337BA31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 12:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhELKTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 06:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhELKTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 06:19:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419ECC061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 03:18:28 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f24so34176249ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=p1Lr28CPZICLNPKVShGVHig8w62YrScW8F9lGxncgd8=;
        b=dnfICAHmPiaeDLZmpGjgeEJJASHaXH0eJI3VC2Xmvidm5MC8C11XJNQ9k+17TxAJTo
         YRRrSBBWMypslM3Wk1tElPLgdgle1FPnAVfdvi66FcpihmPiTyQq6Ev8e6O3UQ+tzcPN
         wH6ZLacZcC2WqGpmOD8Dup9ppdjlknhakMSqabsf4UFWsqeVhK2ea8kr5YfDSiiuGGP9
         9KiChkJOetM1NXnSSs39YpucSFU/gDZkXuWuPfUevO1GLOuVIeaMjBjoEXalbfy7GTx6
         nxkmcrwFv9OakaFC5voS72gN+u1+wPfm8jOAupH1Lfn7O+5hKliGTLcHNcflhWxFzp5H
         bDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=p1Lr28CPZICLNPKVShGVHig8w62YrScW8F9lGxncgd8=;
        b=jKE3JOH1zBxeADxMtA+pqCwBQV6V11stT5tcDIqahex+UBGlul+98h/GyjIhF5dOH0
         R8EgvFSoyALVfWYXzPGYs5jMkxE//f1Tx8f6h6HvWSDljRmpWsnzaUWpCQoI7KWcwEqt
         lo6klgCh20lT7XmM0GxEpcVvA9ns+PkXpqFr9uINCW8YEbcjwAGhsy4vdFp5dlXVdlxO
         v0DcMWpfM8iMzp8I+Fc7n28AcoBrDtHkVjKyPfBnvsMSBwvIONdy9FXW1kfUfouf9UXY
         JUAV3lzRQcJH20eiUyAS/3kSf12eeoU7WDq+vKy/vLP4/fWrFpY8L/PXOsxc2rscoSGh
         hSQw==
X-Gm-Message-State: AOAM531k+aQ/kkLozEbtswJPbHR7u9YyFCj09DEWTxq96yBnDyvWh+N0
        z5OdBkmu3W3Qne+anbXiOOgI9g==
X-Google-Smtp-Source: ABdhPJz/QcR7QJP2BPKNx82MqhkOWkhpOz7JP/5FjEVvCkPodnidDWx4wfZchbZQt9DrOwxbqThaGg==
X-Received: by 2002:a17:906:4e82:: with SMTP id v2mr37700482eju.278.1620814706833;
        Wed, 12 May 2021 03:18:26 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id q18sm16781520edd.3.2021.05.12.03.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 03:18:26 -0700 (PDT)
Date:   Wed, 12 May 2021 12:18:08 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <YJurYOz264HKm4Bz@myrica>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 06:25:07AM -0700, Jacob Pan wrote:
> The void* drvdata parameter isn't really used in iommu_sva_bind_device()
> API, the current IDXD code "borrows" the drvdata for a VT-d private flag
> for supervisor SVA usage.
> 
> Supervisor/Privileged mode request is a generic feature. It should be
> promoted from the VT-d vendor driver to the generic code.
> 
> This patch replaces void* drvdata with a unsigned int flags parameter
> and adjusts callers accordingly.
> 
> Link: https://lore.kernel.org/linux-iommu/YFhiMLR35WWMW%2FHu@myrica/
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Thanks for cleaning this up. Whether Vt-d's supervisor mode will need
rework or not, this is still good to have. One nit below if you resend

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

[...]
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..fcc9d36b4b01 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -152,6 +152,19 @@ enum iommu_dev_features {
>  
>  #define IOMMU_PASID_INVALID	(-1U)
>  
> +/*
> + * The IOMMU_SVA_BIND_SUPERVISOR flag requests a PASID which can be used only
> + * for access to kernel addresses. No IOTLB flushes are automatically done
> + * for kernel mappings; it is valid only for access to the kernel's static
> + * 1:1 mapping of physical memory — not to vmalloc or even module mappings.
> + * A future API addition may permit the use of such ranges, by means of an
> + * explicit IOTLB flush call (akin to the DMA API's unmap method).
> + *
> + * It is unlikely that we will ever hook into flush_tlb_kernel_range() to
> + * do such IOTLB flushes automatically.

I would add that this is platform specific and not all IOMMU drivers
support the feature.

Thanks,
Jean

> + */
> +#define IOMMU_SVA_BIND_SUPERVISOR       BIT(0)
> +
>  #ifdef CONFIG_IOMMU_API
