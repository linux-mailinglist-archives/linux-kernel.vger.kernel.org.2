Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9618632C077
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386602AbhCCSok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574212AbhCCRWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:22:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C54C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 09:21:37 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n4so7056120wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=snvF1oZRAeOuQ652xF7hxq8e8Xbivy9W17OCql8Ju58=;
        b=N4GzE8TYwDr5X4gxi0SyFxRoTBr18n1OZjxbvypLvGP0Y4FoY0LysvNlydxCGejw5o
         /cBkCZJLNvfwhcIGdhFCqyxDwdKIZ6qjVhtXO7fN9azK3VGGOf3w8vj2aAp59oSB8xdN
         0dPT6MSfpozH0a30HioSChw0qmgAqCUYwcaapdq7uWhX/Cau9DcgXlxcfIWQUMNLc/LK
         TFzBMXyK/zWnYtJMBqnKSmu5upeKLdHMql2kQ6zKb0XVFDIJl4dEbHe0xo7Qskg90KJL
         JLt1qlFufE95dlru/PO4iXTOUfQzsqlVCf9J3BlUkcK+TVC4CiGinPkkPQSne2U/TFlH
         LzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=snvF1oZRAeOuQ652xF7hxq8e8Xbivy9W17OCql8Ju58=;
        b=cHoRStumNtXkt2z5yIAaCsW1wW1TaP54mA7VsnnDBxLISdkTZn435BOBAxn+HBdb+Z
         XtIpSKJ92sKLhNu1Cm229ojrLIqJsGzjFOBUXn/TvsPJYRPmXJoq3ntd9nbvcUYT6f3o
         4GXf7Ph+TLF4j7Culc7unvSUsSWVViKCN9dL+QZSTj7FUeS077d1UYVhJ4jn8QtbBibI
         3WiP3RyIrx7hP5nifXifCMhfqHFLk6cmYyP/MliiOBqnCxQ0Xa1bYLIuG9CB7QPfmKTx
         1AZq2pyRGQ3qYCwrRzqj+aGQh1maz8QLrSr2YWw5ZnWcf3qfxHPzvyvQixsJ/UVc+axe
         6MYA==
X-Gm-Message-State: AOAM530tCwgRH1kvY2rsOeyAZVohgpCOv+/vOV87v97roXQZ/Rgw6mv6
        zcXIYTfpmXGUv9pvkdJAg7y7aQ==
X-Google-Smtp-Source: ABdhPJz0FpEULBkKSmdBklW+Kq2/Ls1+mEtrqGKqrnMSwdqjEtdd4QHizAokDIN5S9VOM4P4MLCxhg==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr74337wmi.132.1614792096379;
        Wed, 03 Mar 2021 09:21:36 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s23sm6477150wmc.35.2021.03.03.09.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 09:21:35 -0800 (PST)
Date:   Wed, 3 Mar 2021 18:21:14 +0100
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
Subject: Re: [PATCH RFC v1 09/15] iommu/virtio: Update table format probing
 header
Message-ID: <YD/Fiuxd9/kThGxt@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-10-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-10-vivek.gautam@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:43:36PM +0530, Vivek Gautam wrote:
> Add info about asid_bits and additional flags to table format
> probing header.
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
>  include/uapi/linux/virtio_iommu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> index 43821e33e7af..8a0624bab4b2 100644
> --- a/include/uapi/linux/virtio_iommu.h
> +++ b/include/uapi/linux/virtio_iommu.h
> @@ -169,7 +169,10 @@ struct virtio_iommu_probe_pasid_size {
>  struct virtio_iommu_probe_table_format {
>  	struct virtio_iommu_probe_property	head;
>  	__le16					format;
> -	__u8					reserved[2];
> +	__le16					asid_bits;
> +
> +	__le32					flags;

This struct should only contain the head and format fields. asid and flags
should go in a specialized structure - virtio_iommu_probe_pgt_arm64 in the
latest spec draft, where I dropped the asid_bits field in favor of an
"ASID16" flag.

Thanks,
Jean

