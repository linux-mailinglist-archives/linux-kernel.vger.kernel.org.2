Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C49732BABF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 21:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358154AbhCCLz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 06:55:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:61075 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353312AbhCCFId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 00:08:33 -0500
IronPort-SDR: LJVo5w0mtb/XkrK/qqeqhK4kG07idtpDRnHw8JKRZi4p5uMaVq8IMtN7nEPyo86Q1xYpsCc+bT
 d6M2o7B0V2FA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="187160062"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="187160062"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:06:15 -0800
IronPort-SDR: 2c4Ag05Xnpus+ArzV0OBxfdEX2R3S3Eys+j+1+/KFIAcsKXGg+NAnCCBddEDDi0oAUmGqDRUnh
 RvU1nazkV9PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="428035702"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2021 21:06:12 -0800
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: Re: [PATCH v2 2/4] iommu/vt-d: Enable write protect propagation from
 guest
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614680040-1989-3-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ed71158c-d906-f503-3372-dd7936a992ba@linux.intel.com>
Date:   Wed, 3 Mar 2021 12:57:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1614680040-1989-3-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/21 6:13 PM, Jacob Pan wrote:
> Write protect bit, when set, inhibits supervisor writes to the read-only
> pages. In guest supervisor shared virtual addressing (SVA), write-protect
> should be honored upon guest bind supervisor PASID request.
> 
> This patch extends the VT-d portion of the IOMMU UAPI to include WP bit.
> WPE bit of the  supervisor PASID entry will be set to match CPU CR0.WP bit.
> 
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 3 +++
>   include/uapi/linux/iommu.h  | 3 ++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 0b7e0e726ade..b7e39239f539 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -763,6 +763,9 @@ intel_pasid_setup_bind_data(struct intel_iommu *iommu, struct pasid_entry *pte,
>   			return -EINVAL;
>   		}
>   		pasid_set_sre(pte);
> +		/* Enable write protect WP if guest requested */
> +		if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_WPE)
> +			pasid_set_wpe(pte);
>   	}
>   
>   	if (pasid_data->flags & IOMMU_SVA_VTD_GPASID_EAFE) {
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 35d48843acd8..3a9164cc9937 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -288,7 +288,8 @@ struct iommu_gpasid_bind_data_vtd {
>   #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write through */
>   #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem type enable */
>   #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level cache disable */
> -#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
> +#define IOMMU_SVA_VTD_GPASID_WPE	(1 << 6) /* Write protect enable */
> +#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 7)
>   	__u64 flags;
>   	__u32 pat;
>   	__u32 emt;
> 

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
