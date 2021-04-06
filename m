Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9913549DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 03:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242087AbhDFBHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 21:07:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:13651 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235769AbhDFBHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 21:07:43 -0400
IronPort-SDR: +1Bxe5pKf9d2d9+Yt4h7/cmdzCD7s9wZIWcFMZE8C2NmOuMa1U0yXKld9E9shqZ0zYU9jelPWk
 orrXXUeNrE9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="173030537"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="173030537"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 18:07:36 -0700
IronPort-SDR: Wtwhc4FlTpvJsuXZDx/ruo9zOYrdhP9yb/4kWwe7nLyGVLSKtTejyMTw8aQadzl5gMAJGAKmyB
 +fG8nCb/dG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="440713227"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2021 18:07:34 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 4/5] iommu/vt-d: Use user privilege for RID2PASID
 translation
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20210320025415.641201-1-baolu.lu@linux.intel.com>
 <20210320025415.641201-5-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <84f0ca29-04e0-446b-745a-73e2f9e49f3b@linux.intel.com>
Date:   Tue, 6 Apr 2021 08:58:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210320025415.641201-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/21 10:54 AM, Lu Baolu wrote:
> When first-level page tables are used for IOVA translation, we use user
> privilege by setting U/S bit in the page table entry. This is to make it
> consistent with the second level translation, where the U/S enforcement
> is not available. Clear the SRE (Supervisor Request Enable) field in the
> pasid table entry of RID2PASID so that requests requesting the supervisor
> privilege are blocked and treated as DMA remapping faults.
> 
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

We found some devices still require SRE to be set during internal tests.
I will drop this patch from my queue for v5.13 for now.

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 7 +++++--
>   drivers/iommu/intel/pasid.c | 3 ++-
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 868f195f55ff..7354f9ce47d8 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2494,9 +2494,9 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>   				    struct device *dev,
>   				    u32 pasid)
>   {
> -	int flags = PASID_FLAG_SUPERVISOR_MODE;
>   	struct dma_pte *pgd = domain->pgd;
>   	int agaw, level;
> +	int flags = 0;
>   
>   	/*
>   	 * Skip top levels of page tables for iommu which has
> @@ -2512,7 +2512,10 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>   	if (level != 4 && level != 5)
>   		return -EINVAL;
>   
> -	flags |= (level == 5) ? PASID_FLAG_FL5LP : 0;
> +	if (pasid != PASID_RID2PASID)
> +		flags |= PASID_FLAG_SUPERVISOR_MODE;
> +	if (level == 5)
> +		flags |= PASID_FLAG_FL5LP;
>   
>   	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
>   					     domain->iommu_did[iommu->seq_id],
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 0bf7e0a76890..dd69df5a188a 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -673,7 +673,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>   	 * Since it is a second level only translation setup, we should
>   	 * set SRE bit as well (addresses are expected to be GPAs).
>   	 */
> -	pasid_set_sre(pte);
> +	if (pasid != PASID_RID2PASID)
> +		pasid_set_sre(pte);
>   	pasid_set_present(pte);
>   	pasid_flush_caches(iommu, pte, pasid, did);
>   
> 
