Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCD132C0BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386704AbhCCSpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbhCCR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:27:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF427C061761
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 09:25:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l12so24563393wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sTamhW9kBjxgzkEQoLRyMj5hVf4Faxe5WhEqC1E4/4A=;
        b=PvFI6RNC5gKkiR4uElMabw36/xB+ietKweTBJ4T98xol1ziCDi0AA0R+IDtXnc5Jsx
         qEao7IHKNQZLfegHpIDSWl1V+a11e0koptzY0nszPgQYWuyYf/+Doh9jF0vbrOgXMYlz
         21Z7Ygx6i3E7XgJgk8INKMwhBKsm7Ca0oNMrRDvzpjSda8mtQal62NDw9tqiXVTvxcLr
         fElIGrLQ9ltww+SCGkRKjuCTlAVc08d+qT8iG9D9f/PybhIBuHYcPh4JbOcQgQQ8Fasf
         X3HtjnlV2CK5gJ1vnSd5P+azVJpctQJFhMYAwenEGER4nvRFIO6/9NXh2sN5GzhjuSk4
         a48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sTamhW9kBjxgzkEQoLRyMj5hVf4Faxe5WhEqC1E4/4A=;
        b=lSjgaCX1qNbCZO5Q5cBCxLYmbKS4v0boHTMRDOT9xeYgiKbW94yqd4rS8nMd4Axw9R
         jhGSWhjU1G+UgCH87G+lMq1Bt8PX/PwvpkibSIywO/6dBN5T8fZsSAAAg/M0lT91A2Wg
         Oz7iIahFFfx41/cZnhW2fmIT/s7lAZSBa0LpbsICkvxH9tCTVsPss2d5ynXla4JGFJ14
         O6/2tIoVURH/+z7Idt7ycoWFpCTDP47Ur/aa/F19Xlf9MPgbxTy1vK5iy2N4MeEO/jof
         h3/FhVBWpyOkILHJjO149UX3Gt4Z2lj0qGaQ00Zg8ZLpTYSDKdWutstDsTxSywJO23Gl
         LIeg==
X-Gm-Message-State: AOAM5324DMxvjWdXLDHBd/h7isryPVbPc5uLuqSjRLpZ7arivGuxxMED
        zxd6Ntw5/I3WlCHANlWbiA6Wxg==
X-Google-Smtp-Source: ABdhPJxEGN1rH8+VtjTLr+Dh5jEKvGOweEYJsKpNFFpw9C+4jgIY35xjxjoSoEJ/Son74X8HB1937Q==
X-Received: by 2002:a5d:550b:: with SMTP id b11mr24476367wrv.313.1614792355644;
        Wed, 03 Mar 2021 09:25:55 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b65sm6127924wmh.4.2021.03.03.09.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:25:55 -0800 (PST)
Date:   Wed, 3 Mar 2021 18:25:33 +0100
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
Subject: Re: [PATCH RFC v1 15/15] iommu/virtio: Update fault type and reason
 info for viommu fault
Message-ID: <YD/GjQIKkaJ5+UJM@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-16-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-16-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:43:42PM +0530, Vivek Gautam wrote:
> Fault type information can tell about a page request fault or
> an unreceoverable fault, and further additions to fault reasons
> and the related PASID information can help in handling faults
> efficiently.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
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
>  drivers/iommu/virtio-iommu.c      | 27 +++++++++++++++++++++++++--
>  include/uapi/linux/virtio_iommu.h | 13 ++++++++++++-
>  2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 9cc3d35125e9..10ef9e98214a 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -652,9 +652,16 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
>  	char *reason_str;
>  
>  	u8 reason	= fault->reason;
> +	u16 type	= fault->flt_type;
>  	u32 flags	= le32_to_cpu(fault->flags);
>  	u32 endpoint	= le32_to_cpu(fault->endpoint);
>  	u64 address	= le64_to_cpu(fault->address);
> +	u32 pasid	= le32_to_cpu(fault->pasid);
> +
> +	if (type == VIRTIO_IOMMU_FAULT_F_PAGE_REQ) {
> +		dev_info(viommu->dev, "Page request fault - unhandled\n");
> +		return 0;
> +	}
>  
>  	switch (reason) {
>  	case VIRTIO_IOMMU_FAULT_R_DOMAIN:
> @@ -663,6 +670,21 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
>  	case VIRTIO_IOMMU_FAULT_R_MAPPING:
>  		reason_str = "page";
>  		break;
> +	case VIRTIO_IOMMU_FAULT_R_WALK_EABT:
> +		reason_str = "page walk external abort";
> +		break;
> +	case VIRTIO_IOMMU_FAULT_R_PTE_FETCH:
> +		reason_str = "pte fetch";
> +		break;
> +	case VIRTIO_IOMMU_FAULT_R_PERMISSION:
> +		reason_str = "permission";
> +		break;
> +	case VIRTIO_IOMMU_FAULT_R_ACCESS:
> +		reason_str = "access";
> +		break;
> +	case VIRTIO_IOMMU_FAULT_R_OOR_ADDRESS:
> +		reason_str = "output address";
> +		break;
>  	case VIRTIO_IOMMU_FAULT_R_UNKNOWN:
>  	default:
>  		reason_str = "unknown";
> @@ -671,8 +693,9 @@ static int viommu_fault_handler(struct viommu_dev *viommu,
>  
>  	/* TODO: find EP by ID and report_iommu_fault */
>  	if (flags & VIRTIO_IOMMU_FAULT_F_ADDRESS)
> -		dev_err_ratelimited(viommu->dev, "%s fault from EP %u at %#llx [%s%s%s]\n",
> -				    reason_str, endpoint, address,
> +		dev_err_ratelimited(viommu->dev,
> +				    "%s fault from EP %u PASID %u at %#llx [%s%s%s]\n",
> +				    reason_str, endpoint, pasid, address,
>  				    flags & VIRTIO_IOMMU_FAULT_F_READ ? "R" : "",
>  				    flags & VIRTIO_IOMMU_FAULT_F_WRITE ? "W" : "",
>  				    flags & VIRTIO_IOMMU_FAULT_F_EXEC ? "X" : "");
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 608c8d642e1f..a537d82777f7 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -290,19 +290,30 @@ struct virtio_iommu_req_invalidate {
>  #define VIRTIO_IOMMU_FAULT_R_UNKNOWN		0
>  #define VIRTIO_IOMMU_FAULT_R_DOMAIN		1
>  #define VIRTIO_IOMMU_FAULT_R_MAPPING		2
> +#define VIRTIO_IOMMU_FAULT_R_WALK_EABT		3
> +#define VIRTIO_IOMMU_FAULT_R_PTE_FETCH		4
> +#define VIRTIO_IOMMU_FAULT_R_PERMISSION		5
> +#define VIRTIO_IOMMU_FAULT_R_ACCESS		6
> +#define VIRTIO_IOMMU_FAULT_R_OOR_ADDRESS	7
>  
>  #define VIRTIO_IOMMU_FAULT_F_READ		(1 << 0)
>  #define VIRTIO_IOMMU_FAULT_F_WRITE		(1 << 1)
>  #define VIRTIO_IOMMU_FAULT_F_EXEC		(1 << 2)
>  #define VIRTIO_IOMMU_FAULT_F_ADDRESS		(1 << 8)
>  
> +#define VIRTIO_IOMMU_FAULT_F_DMA_UNRECOV	1
> +#define VIRTIO_IOMMU_FAULT_F_PAGE_REQ		2

Currently all reported faults are unrecoverable, so to be consistent
DMA_UNRECOV should be 0. But I'd prefer having just a new "page request"
flag in the flags field, instead of the flt_type field.

For page requests we'll also need a 16-bit fault ID field to store the PRI
"page request group index" or the stall "stag". "last" and "privileged"
flags as well, to match the PRI page request. And a new command to
complete a page fault.

> +
>  struct virtio_iommu_fault {
>  	__u8					reason;
> -	__u8					reserved[3];
> +	__le16					flt_type;
> +	__u8					reserved;
>  	__le32					flags;
>  	__le32					endpoint;
>  	__u8					reserved2[4];

Why not replace reserved2 with the pasid?  It fits perfectly :)

Thanks,
Jean

>  	__le64					address;
> +	__le32					pasid;
> +	__u8					reserved3[4];
>  };
>  
>  #endif
> -- 
> 2.17.1
> 
