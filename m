Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE22031A461
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 19:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhBLSPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 13:15:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhBLSPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 13:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613153619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLqsR4sSEYCEMnG5ZaXCSNXnc9ht4025gA+UtCzISME=;
        b=gONeQ9BXr8bx0y77O/8hM5QdVquzeBpbOACK05QSN+RcQS086ZCA4aOotvVcaqv0DWHLvA
        c3PwN3ryDH9UDjwIS536fyvs6kPxuVg3Q2mtqEzDYD6QXRyw2H/O1Dlgcfc748ANegnh3Q
        bHSX5nUOTjKapZmbYa3Fv2/jrNf73fQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-bsa7C5m5OF-etwpAJO51Pg-1; Fri, 12 Feb 2021 13:13:37 -0500
X-MC-Unique: bsa7C5m5OF-etwpAJO51Pg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C801D80196C;
        Fri, 12 Feb 2021 18:13:34 +0000 (UTC)
Received: from [10.36.114.34] (ovpn-114-34.ams2.redhat.com [10.36.114.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8387A60BF1;
        Fri, 12 Feb 2021 18:13:24 +0000 (UTC)
Subject: Re: [PATCH 1/2] iommu: Report domain nesting info for arm-smmu-v3
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
 <20210212105859.8445-2-vivek.gautam@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <28c0204d-2a5e-4eb9-d869-9dbd6edab55a@redhat.com>
Date:   Fri, 12 Feb 2021 19:13:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210212105859.8445-2-vivek.gautam@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,
On 2/12/21 11:58 AM, Vivek Gautam wrote:
> Add a vendor specific structure for domain nesting info for
> arm smmu-v3, and necessary info fields required to populate
> stage1 page tables.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> ---
>  include/uapi/linux/iommu.h | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 4d3d988fa353..5f059bcf7720 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -323,7 +323,8 @@ struct iommu_gpasid_bind_data {
>  #define IOMMU_GPASID_BIND_VERSION_1	1
>  	__u32 version;
>  #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> -#define IOMMU_PASID_FORMAT_LAST		2
> +#define IOMMU_PASID_FORMAT_ARM_SMMU_V3	2
> +#define IOMMU_PASID_FORMAT_LAST		3
>  	__u32 format;
>  	__u32 addr_width;
>  #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> @@ -409,6 +410,21 @@ struct iommu_nesting_info_vtd {
>  	__u64	ecap_reg;
>  };
>  
> +/*
> + * struct iommu_nesting_info_arm_smmuv3 - Arm SMMU-v3 nesting info.
> + */
> +struct iommu_nesting_info_arm_smmuv3 {
> +	__u32	flags;
> +	__u16	asid_bits;
> +
> +	/* Arm LPAE page table format as per kernel */
> +#define ARM_PGTBL_32_LPAE_S1		(0x0)
> +#define ARM_PGTBL_64_LPAE_S1		(0x2)
Shouldn't it be a bitfield instead as both can be supported (the actual
driver only supports 64b table format though). Does it match matches
IDR0.TTF?
> +	__u8	pgtbl_fmt;
So I understand this API is supposed to allow VFIO to expose those info
early enough to the userspace to help configuring the viommu and avoid
errors later on. I wonder how far we want to go on this path. What about
those other caps that impact the STE/CD validity. There may be others...

SMMU_IDR0.CD2L (support of 2 stage CD)
SMMU_IDR0.TTENDIAN (endianness)
SMMU_IDR0.HTTU (if 0 forbids HA/HD setting in the CD)
SMMU_IDR3.STT (impacts T0SZ)

Thanks

Eric

> +
> +	__u8	padding[9];
> +};
> +
>  /*
>   * struct iommu_nesting_info - Information for nesting-capable IOMMU.
>   *			       userspace should check it before using
> @@ -445,11 +461,13 @@ struct iommu_nesting_info_vtd {
>   * +---------------+------------------------------------------------------+
>   *
>   * data struct types defined for @format:
> - * +================================+=====================================+
> - * | @format                        | data struct                         |
> - * +================================+=====================================+
> - * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd       |
> - * +--------------------------------+-------------------------------------+
> + * +================================+======================================+
> + * | @format                        | data struct                          |
> + * +================================+======================================+
> + * | IOMMU_PASID_FORMAT_INTEL_VTD   | struct iommu_nesting_info_vtd        |
> + * +---------------+-------------------------------------------------------+
> + * | IOMMU_PASID_FORMAT_ARM_SMMU_V3 | struct iommu_nesting_info_arm_smmuv3 |
> + * +--------------------------------+--------------------------------------+
>   *
>   */
>  struct iommu_nesting_info {
> @@ -466,6 +484,7 @@ struct iommu_nesting_info {
>  	/* Vendor specific data */
>  	union {
>  		struct iommu_nesting_info_vtd vtd;
> +		struct iommu_nesting_info_arm_smmuv3 smmuv3;
>  	} vendor;
>  };
>  
> 

