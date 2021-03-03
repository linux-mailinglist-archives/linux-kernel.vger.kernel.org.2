Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7703A32C024
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhCCSfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380738AbhCCRTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:19:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85D1C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 09:18:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id i9so5820028wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5iBsMQqFOU14HEvyYWYO+cEIgAJ26J54CPr7LWlg7Ck=;
        b=tJsSbW7npNeXuT2aUfv+xVzgDPQaXPBn/6WhvvP+1VpmGrNWVlB/6c73uxaz1NkEnV
         kuYCUjcUrfSFI2/OlqRPlXzBBSlUpgblF/vd2AUFIsDz3l1X+8C1xy0N/ypdfroHVoqk
         /sBnwUtbxubfsNj1+4sQS56KQAeYGICeiPg1Sm0yFT6f72NZXglUsrDDWhxlLI8TzRvc
         HyRqlUtaBuwmcy1tpzZ1TG+MQzSeIiYtJrDYvzs/zM6Ksw6N5gyMQKU27zae1ci/Q2zn
         SGKaMqxm9hi2hv5Bg3uSsGsdocWUssbrjXRYj2ff7z6+XkW1cRE5F5QQunLfqdKrxPoN
         3Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5iBsMQqFOU14HEvyYWYO+cEIgAJ26J54CPr7LWlg7Ck=;
        b=CDgAO/8nych1Yfac7s5R2mqeurdLAsgGhdUxsxxW8XWGJ5pqRyIOkr7j2ohfC+Fn8o
         i9zLSSyEoA6hTpLkiCUcQc2BnRw0BWuEVZh6kE44XFfQTtQNf42+Me732O9WvuyFegQg
         sH3hxX/N2XPgkWTPVeFZ1/f5Zx1A5KdXAKYokQLZkEZmh+TlNb0FYouJvDOFAi9FFeDe
         i7rJyaMt/IKWAKWEeRNoRtZJO1qkD9ruEI6ZMBRGY51tOEZSS6s1TmIX74mEhyy0PgE9
         wRbNIP/eeOw8j7T00yFvvnN53o/QaXRluZF4hJv5oamtRuUgRkmGAAp9oYz3o3veVRYB
         VSUw==
X-Gm-Message-State: AOAM530/K/9CfeMaUrWrodRooSIytNlEb+n/r12Awkv1DYKKBUFpLwvI
        4myBAxb4FkrJgxRtx3tbMHaC+A==
X-Google-Smtp-Source: ABdhPJwC8M1M+ADRQsf7KzCeua/t0GLhmB9md5x6408Cc3EtgTN6TPy0ZU8dctF1TddT/5Mj9RvYVA==
X-Received: by 2002:a05:600c:2f08:: with SMTP id r8mr31246wmn.95.1614791900389;
        Wed, 03 Mar 2021 09:18:20 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id 91sm10498408wrl.20.2021.03.03.09.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:18:19 -0800 (PST)
Date:   Wed, 3 Mar 2021 18:17:58 +0100
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
Subject: Re: [PATCH RFC v1 06/15] iommu/virtio: Add headers for table format
 probing
Message-ID: <YD/ExjIwG/as52CI@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-7-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-7-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:43:33PM +0530, Vivek Gautam wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> Add required UAPI defines for probing table format for underlying
> iommu hardware. The device may provide information about hardware
> tables and additional capabilities for each device.
> This allows guest to correctly fabricate stage-1 page tables.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> [Vivek: Use a single "struct virtio_iommu_probe_table_format" rather
>         than separate structures for page table and pasid table format.

Makes sense. I've integrated that into the spec draft, added more precise
documentation and modified some of the definitions.

The current draft is here:
https://jpbrucker.net/virtio-iommu/spec/virtio-iommu-v0.13.pdf
Posted on the list here
https://lists.oasis-open.org/archives/virtio-dev/202102/msg00012.html

> 	Also update commit message.]
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
>  include/uapi/linux/virtio_iommu.h | 44 ++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 237e36a280cb..43821e33e7af 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -2,7 +2,7 @@
>  /*
>   * Virtio-iommu definition v0.12
>   *
> - * Copyright (C) 2019 Arm Ltd.
> + * Copyright (C) 2019-2021 Arm Ltd.

Not strictly necessary. But if you're modifying this comment please also
remove the "v0.12" above

>   */
>  #ifndef _UAPI_LINUX_VIRTIO_IOMMU_H
>  #define _UAPI_LINUX_VIRTIO_IOMMU_H
> @@ -111,6 +111,12 @@ struct virtio_iommu_req_unmap {
>  
>  #define VIRTIO_IOMMU_PROBE_T_NONE		0
>  #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
> +#define VIRTIO_IOMMU_PROBE_T_INPUT_RANGE	3
> +#define VIRTIO_IOMMU_PROBE_T_OUTPUT_SIZE	4
> +#define VIRTIO_IOMMU_PROBE_T_PASID_SIZE		5
> +#define VIRTIO_IOMMU_PROBE_T_PAGE_TABLE_FMT	6
> +#define VIRTIO_IOMMU_PROBE_T_PASID_TABLE_FMT	7

Since there is a single struct we can have a single
VIRTIO_IOMMU_PROBE_T_TABLE_FORMAT.

>  
>  #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
>  
> @@ -130,6 +136,42 @@ struct virtio_iommu_probe_resv_mem {
>  	__le64					end;
>  };
>  
> +struct virtio_iommu_probe_page_size_mask {
> +	struct virtio_iommu_probe_property	head;
> +	__u8					reserved[4];
> +	__le64					mask;
> +};
> +
> +struct virtio_iommu_probe_input_range {
> +	struct virtio_iommu_probe_property	head;
> +	__u8					reserved[4];
> +	__le64					start;
> +	__le64					end;
> +};
> +
> +struct virtio_iommu_probe_output_size {
> +	struct virtio_iommu_probe_property	head;
> +	__u8					bits;
> +	__u8					reserved[3];
> +};
> +
> +struct virtio_iommu_probe_pasid_size {
> +	struct virtio_iommu_probe_property	head;
> +	__u8					bits;
> +	__u8					reserved[3];
> +};
> +
> +/* Arm LPAE page table format */
> +#define VIRTIO_IOMMU_FOMRAT_PGTF_ARM_LPAE	1

s/FOMRAT/FORMAT

> +/* Arm smmu-v3 type PASID table format */
> +#define VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3	2

These should be with the Arm-specific definitions patches 11 and 14

Thanks,
Jean

> +
> +struct virtio_iommu_probe_table_format {
> +	struct virtio_iommu_probe_property	head;
> +	__le16					format;
> +	__u8					reserved[2];
> +};
> +
>  struct virtio_iommu_req_probe {
>  	struct virtio_iommu_req_head		head;
>  	__le32					endpoint;
> -- 
> 2.17.1
> 
