Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE1F33A91E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 01:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhCOAkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 20:40:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:42755 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhCOAjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 20:39:33 -0400
IronPort-SDR: pKxB1cJsRb6X3jKQjWKQmcexODXWxWLZhmzleW1CgrXDdwLxmidpRpCq17VaXwfpl+OycjLUpJ
 2h5gLF2KbpKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="168290211"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="168290211"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2021 17:39:30 -0700
IronPort-SDR: vKnhhgjxnJ+IojiaywWi+NrhZHUSIurGvg4QlS6j5JsRBzmRCfdRPZWLcT/YhhWWFGssislb1a
 3m5yEJwx+hDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="432516352"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 14 Mar 2021 17:39:26 -0700
Cc:     baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
        will@kernel.org, jacob.jun.pan@linux.intel.com,
        ashok.raj@intel.com, ravi.v.shankar@intel.com, yian.chen@intel.com,
        sohil.mehta@intel.com
Subject: Re: [PATCH] iommu/vt-d: Disable SVM when ATS/PRI/PASID are not
 enabled in the device
To:     Kyung Min Park <kyung.min.park@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210314201534.918-1-kyung.min.park@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2c02519d-d23b-92d6-9638-36632c06d517@linux.intel.com>
Date:   Mon, 15 Mar 2021 08:30:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210314201534.918-1-kyung.min.park@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/21 4:15 AM, Kyung Min Park wrote:
> Currently, the Intel VT-d supports Shared Virtual Memory (SVM) only when
> IO page fault is supported. Otherwise, shared memory pages can not be
> swapped out and need to be pinned. The device needs the Address Translation
> Service (ATS), Page Request Interface (PRI) and Process Address Space
> Identifier (PASID) capabilities to be enabled to support IO page fault.
> 
> Disable SVM when ATS, PRI and PASID are not enabled in the device.
> 
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ee0932307d64..956a02eb40b4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5380,6 +5380,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
>   		if (!info)
>   			return -EINVAL;
>   
> +		if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
> +			return -EINVAL;
> +
>   		if (info->iommu->flags & VTD_FLAG_SVM_CAPABLE)
>   			return 0;
>   	}
> 

Thanks for the patch.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
