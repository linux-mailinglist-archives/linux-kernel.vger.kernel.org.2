Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE5359F00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbhDIMpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:45:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:32587 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232286AbhDIMpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:45:41 -0400
IronPort-SDR: uJw4RP0+BX4kZGyJaD5trBteKLIVeoLCFzKU2feL4my2HOiUycZYXARQ2/5qVuD9S2i8am/eS8
 mJLoRdyERKuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="193792940"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="193792940"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 05:45:28 -0700
IronPort-SDR: J94+ZmKkZJjSqlr6+lLmCF0kmDHnfTMyeqpMal5eYal2X3t1/7Vx23ZOjTVO5Gd4Jiz6cdcNwj
 ZkM2sWPffxmA==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="422714028"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.245]) ([10.254.211.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 05:45:25 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH 2/2] iommu/sva: Remove mm parameter from SVA bind API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1617901736-24788-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f29495e1-e3a0-8c45-bfca-067c1e996eca@linux.intel.com>
Date:   Fri, 9 Apr 2021 20:45:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1617901736-24788-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/4/9 1:08, Jacob Pan wrote:
>   /**
>    * iommu_sva_alloc_pasid - Allocate a PASID for the mm
> - * @mm: the mm
>    * @min: minimum PASID value (inclusive)
>    * @max: maximum PASID value (inclusive)
>    *
> - * Try to allocate a PASID for this mm, or take a reference to the existing one
> - * provided it fits within the [@min, @max] range. On success the PASID is
> - * available in mm->pasid, and must be released with iommu_sva_free_pasid().
> + * Try to allocate a PASID for the current mm, or take a reference to the
> + * existing one provided it fits within the [@min, @max] range. On success
> + * the PASID is available in the current mm->pasid, and must be released with
> + * iommu_sva_free_pasid().
>    * @min must be greater than 0, because 0 indicates an unused mm->pasid.
>    *
>    * Returns 0 on success and < 0 on error.
>    */
> -int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
> +int iommu_sva_alloc_pasid(ioasid_t min, ioasid_t max)
>   {
>   	int ret = 0;
>   	ioasid_t pasid;
> +	struct mm_struct *mm;
>   
>   	if (min == INVALID_IOASID || max == INVALID_IOASID ||
>   	    min == 0 || max < min)
>   		return -EINVAL;
>   
>   	mutex_lock(&iommu_sva_lock);
> +	mm = get_task_mm(current);

How could we allocate a supervisor PASID through iommu_sva_alloc_pasid()
if we always use current->mm here?

> +	if (!mm) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
>   	if (mm->pasid) {
>   		if (mm->pasid >= min && mm->pasid <= max)
>   			ioasid_get(mm->pasid);
> @@ -45,22 +51,32 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>   		else
>   			mm->pasid = pasid;
>   	}
> +	mmput(mm);
> +out_unlock:
>   	mutex_unlock(&iommu_sva_lock);
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);

Best regards,
baolu
