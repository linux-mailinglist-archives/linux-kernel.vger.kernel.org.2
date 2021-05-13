Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C54D37F188
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhEMDIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:08:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:6877 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhEMDIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:08:09 -0400
IronPort-SDR: GV/Hc8M+XXmm3uqdNHNEsyOfu2XEZLD2eZFlrc6ThE2iJG2/i0LFThfYqNUPKxmZxA73gSb+je
 3VIX6g76u1/g==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="179451869"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="179451869"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 20:07:00 -0700
IronPort-SDR: WPygU0PGHIqUyfEL+qDio++f7cx4aQ9yZa/w7AdBcZG71qnp2iGkaTENlHO3EgaNNpWeP0JxXj
 xIX/IZ7bcdMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="623085792"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga006.fm.intel.com with ESMTP; 12 May 2021 20:06:58 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, kevin.tian@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RESEND PATACH 1/1] iommu/vt-d: Use user privilege for RID2PASID
 translation
To:     "Raj, Ashok" <ashok.raj@intel.com>
References: <20210512064426.3440915-1-baolu.lu@linux.intel.com>
 <20210512170349.GB102348@otc-nc-03>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3e1f61dd-2f1e-0b11-934a-b0dab2e52d65@linux.intel.com>
Date:   Thu, 13 May 2021 11:06:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210512170349.GB102348@otc-nc-03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashok,

On 5/13/21 1:03 AM, Raj, Ashok wrote:
> On Wed, May 12, 2021 at 02:44:26PM +0800, Lu Baolu wrote:
>> When first-level page tables are used for IOVA translation, we use user
>> privilege by setting U/S bit in the page table entry. This is to make it
>> consistent with the second level translation, where the U/S enforcement
>> is not available. Clear the SRE (Supervisor Request Enable) field in the
>> pasid table entry of RID2PASID so that requests requesting the supervisor
>> privilege are blocked and treated as DMA remapping faults.
>>
>> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 7 +++++--
>>   drivers/iommu/intel/pasid.c | 3 ++-
>>   2 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 708f430af1c4..f1742da42478 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2525,9 +2525,9 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>>   				    struct device *dev,
>>   				    u32 pasid)
>>   {
>> -	int flags = PASID_FLAG_SUPERVISOR_MODE;
>>   	struct dma_pte *pgd = domain->pgd;
>>   	int agaw, level;
>> +	int flags = 0;
>>   
>>   	/*
>>   	 * Skip top levels of page tables for iommu which has
>> @@ -2543,7 +2543,10 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>>   	if (level != 4 && level != 5)
>>   		return -EINVAL;
>>   
>> -	flags |= (level == 5) ? PASID_FLAG_FL5LP : 0;
>> +	if (pasid != PASID_RID2PASID)
>> +		flags |= PASID_FLAG_SUPERVISOR_MODE;
>> +	if (level == 5)
>> +		flags |= PASID_FLAG_FL5LP;
> 
> Given that we are still not bought into the supervisor PASID, should we make this an
> explicit request before turning on SUPERVISOR mode always? Since
> pasid_set_sre() has no return, we have no way to fail it.
> 

The supervisor PASID is now supported in VT-d implementation. This patch
is only for RID2PASID. We need a separated patch to remove the superisor
pasid code once we reach a consensus.

Does this work for you?

Best regards,
baolu

> 
>>   
>>   	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>>   		flags |= PASID_FLAG_PAGE_SNOOP;
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 72646bafc52f..72dc84821dad 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -699,7 +699,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>>   	 * Since it is a second level only translation setup, we should
>>   	 * set SRE bit as well (addresses are expected to be GPAs).
>>   	 */
>> -	pasid_set_sre(pte);
>> +	if (pasid != PASID_RID2PASID)
>> +		pasid_set_sre(pte);
>>   	pasid_set_present(pte);
>>   	pasid_flush_caches(iommu, pte, pasid, did);
>>   
>> -- 
>> 2.25.1
>>
> 
