Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF47536779F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhDVC4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:56:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:31225 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhDVC4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:56:45 -0400
IronPort-SDR: /TMpOlmxty2X0zknak5RjPLe2KaCcNcqcvjyTnpVLsirGiUXhRUlHm/yg4fJ6O3xG89ElI5exn
 v2HLMPpqcC3A==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="259769979"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="259769979"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 19:56:10 -0700
IronPort-SDR: KJiZnzHyJabZvX/+Np71+BAyI3aZRBCq19+5TKA2sv6jnYpEs14H/e6Ck8lmabicUpuinf73Yg
 DNPSWbjZrcPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="455600224"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2021 19:56:08 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Intel IOMMU: fix sysfs leak in hotplug init path
To:     Rolf Eike Beer <eb@emlix.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
References: <1716403.SmlLz2RZUD@devpool47>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f14bd336-bc77-bba9-05f3-3f57f34c59e3@linux.intel.com>
Date:   Thu, 22 Apr 2021 10:46:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1716403.SmlLz2RZUD@devpool47>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rolf,

On 4/21/21 11:12 PM, Rolf Eike Beer wrote:
> Signed-off-by: Rolf Eike Beer <eb@emlix.com>

Thanks for the patch!

Can you please adjust the subject to "iommu/vt-d: Fix sysfs leak in
alloc_domain()"? It's not only for hotplug path.

Please also add commit message.

Add below Fixes tag as well:

Fixes: 39ab9555c2411 ("iommu: Add sysfs bindings for struct iommu_device")

> ---
>   drivers/iommu/intel/dmar.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> I have not actually tested this but I guess it should match the code in
> free_iommu() just below.
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index d5c51b5c20af..fb37a9b79b3a 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1144,7 +1144,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   
>   		err = iommu_device_register(&iommu->iommu);
>   		if (err)
> -			goto err_unmap;
> +			goto err_unregister;
>   	}
>   
>   	drhd->iommu = iommu;
> @@ -1152,6 +1152,8 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>   
>   	return 0;
>   
> +err_unregister:
> +	iommu_device_sysfs_remove(&iommu->iommu);
>   err_unmap:
>   	unmap_iommu(iommu);
>   error_free_seq_id:
> 

Best regards,
baolu
