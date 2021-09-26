Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B74185BC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 04:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhIZCsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 22:48:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:22443 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhIZCsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 22:48:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="224340660"
X-IronPort-AV: E=Sophos;i="5.85,322,1624345200"; 
   d="scan'208";a="224340660"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2021 19:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,322,1624345200"; 
   d="scan'208";a="475573998"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 25 Sep 2021 19:46:39 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Use second level for GPA->HPA translation
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20210924022931.780963-1-baolu.lu@linux.intel.com>
 <BN9PR11MB54338F4F946F5E9BD3D4D5388CA49@BN9PR11MB5433.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <047dec82-4530-ab93-d8f1-a21405a1d955@linux.intel.com>
Date:   Sun, 26 Sep 2021 10:43:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB54338F4F946F5E9BD3D4D5388CA49@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

Thanks for reviewing my patch.

On 9/24/21 11:16 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Friday, September 24, 2021 10:30 AM
>>
>> The IOMMU VT-d implementation uses the first level for GPA->HPA
>> translation
>> by default. Although both the first level and the second level could handle
>> the DMA translation, they are different in some way. For example, the
>> second
>> level translation has separate controls for the Access/Dirty page tracking
>> and the page-level forcing snoop. With first level translation, there're
>> no such controls. This uses the second level for GPA->HPA translation so
> 
> first-level has no page-granular snoop control, but has a global control
> in pasid entry.

Agreed. Will add this.

> 
>> that it could provide a consistent hardware interface for use cases like
>> dirty page tracking during the VM live migration.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/intel-iommu.h |  7 ++-----
>>   drivers/iommu/intel/iommu.c | 21 +++++++++++++--------
>>   2 files changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 05a65eb155f7..a5fb20702201 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -517,22 +517,19 @@ struct context_entry {
>>   	u64 hi;
>>   };
>>
>> -/* si_domain contains mulitple devices */
>> -#define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
> 
> this is a separate cleanup. better mention it in the commit msg or
> put in another patch.

Sure.

> 
>> -
>>   /*
>>    * When VT-d works in the scalable mode, it allows DMA translation to
>>    * happen through either first level or second level page table. This
>>    * bit marks that the DMA translation for the domain goes through the
>>    * first level page table, otherwise, it goes through the second level.
>>    */
>> -#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(1)
>> +#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(0)
>>
>>   /*
>>    * Domain represents a virtual machine which demands iommu nested
>>    * translation mode support.
>>    */
>> -#define DOMAIN_FLAG_NESTING_MODE		BIT(2)
>> +#define DOMAIN_FLAG_NESTING_MODE		BIT(1)
>>
>>   struct dmar_domain {
>>   	int	nid;			/* node id */
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index d75f59ae28e6..c814fea0522e 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -522,7 +522,7 @@ static inline void free_devinfo_mem(void *vaddr)
>>
>>   static inline int domain_type_is_si(struct dmar_domain *domain)
>>   {
>> -	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
>> +	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
>>   }
>>
>>   static inline bool domain_use_first_level(struct dmar_domain *domain)
>> @@ -1874,12 +1874,18 @@ static void free_dmar_iommu(struct
>> intel_iommu *iommu)
>>    * Check and return whether first level is used by default for
>>    * DMA translation.
>>    */
>> -static bool first_level_by_default(void)
>> +static bool first_level_by_default(unsigned int type)
>>   {
>> -	return scalable_mode_support() && intel_cap_flts_sanity();
>> +	if (type == IOMMU_DOMAIN_UNMANAGED)
>> +		return false;
>> +
> 
> I think the order is not correct. what about 2nd level is even not
> present?

Fair enough. How about

#1) hardware only capable of first level, return true
#2) hardware only capable of second level, return false

(we fail iommu initialization if neither FL nor SL)
Then, both FL and SL are supported.

#3) domain is type of UNMANAGED, return false
#4) otherwise, return true.

Does this make sense?

> 
> 
>> +	if (!scalable_mode_support() || !intel_cap_flts_sanity())
>> +		return false;
>> +
>> +	return true;
>>   }
>>
>> -static struct dmar_domain *alloc_domain(int flags)
>> +static struct dmar_domain *alloc_domain(unsigned int type)
>>   {
>>   	struct dmar_domain *domain;
>>
>> @@ -1889,8 +1895,7 @@ static struct dmar_domain *alloc_domain(int flags)
>>
>>   	memset(domain, 0, sizeof(*domain));
>>   	domain->nid = NUMA_NO_NODE;
>> -	domain->flags = flags;
>> -	if (first_level_by_default())
>> +	if (first_level_by_default(type))
>>   		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
>>   	domain->has_iotlb_device = false;
>>   	INIT_LIST_HEAD(&domain->devices);
>> @@ -2708,7 +2713,7 @@ static int __init si_domain_init(int hw)
>>   	struct device *dev;
>>   	int i, nid, ret;
>>
>> -	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
>> +	si_domain = alloc_domain(IOMMU_DOMAIN_IDENTITY);
>>   	if (!si_domain)
>>   		return -EFAULT;
>>
>> @@ -4517,7 +4522,7 @@ static struct iommu_domain
>> *intel_iommu_domain_alloc(unsigned type)
>>   	case IOMMU_DOMAIN_DMA:
>>   	case IOMMU_DOMAIN_DMA_FQ:
>>   	case IOMMU_DOMAIN_UNMANAGED:
>> -		dmar_domain = alloc_domain(0);
>> +		dmar_domain = alloc_domain(type);
>>   		if (!dmar_domain) {
>>   			pr_err("Can't allocate dmar_domain\n");
>>   			return NULL;
>> --
>> 2.25.1
> 

Best regards,
baolu
