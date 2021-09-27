Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F11D418D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 03:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhI0Bo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 21:44:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:39279 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232289AbhI0Bo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 21:44:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="211633428"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="211633428"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 18:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="475750354"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2021 18:43:18 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommu/vt-d: Check FL and SL capability sanity in
 scalable mode
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
 <20210926114535.923263-3-baolu.lu@linux.intel.com>
 <BN9PR11MB5433AF7EE90A4A406E8B1D6E8CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3237dbe8-089b-a159-2c40-4e6a04f0ae8d@linux.intel.com>
Date:   Mon, 27 Sep 2021 09:39:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5433AF7EE90A4A406E8B1D6E8CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 9:33 AM, Tian, Kevin wrote:
>> From: Tian, Kevin
>> Sent: Monday, September 27, 2021 9:30 AM
>>
>>> From: Tian, Kevin
>>> Sent: Monday, September 27, 2021 9:12 AM
>>>
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Sunday, September 26, 2021 7:46 PM
>>>>
>>>> An iommu domain could be allocated and mapped before it's attached to
>>>> any
>>>> device. This requires that in scalable mode, when the domain is allocated,
>>>> the format (FL or SL) of the page table must be determined. In order to
>>>> achieve this, the platform should support consistent SL or FL capabilities
>>>> on all IOMMU's. This adds a check for this and aborts IOMMU probing if it
>>>> doesn't meet this requirement.
>>>
>>> Is this a must? Looks the requirement comes from how the current code
>>> is implemented. It sets DOMAIN_FLAG_USE_FIRST_LEVEL flag in
>>> alloc_domain. But actually the pgtable is not allocated until the 1st device
>>> is attached. If this understanding is correct, you can also postpone the flag
>>> setting until pgtable is actually allocated.
>>
>> Baolu explained to me that RMRR regions are mapped before device
>> attach. So this check is necessary
>>
>>>
>>> of course how to handle inconsistent IOMMU capabilities is another
>>> orthogonal problem. Addressing it should not be only applied to SL/FL
>>> difference. especially this patch doesn't check consistency. it just
>>> checks that an IOMMU must support either SL or FL which doesn't
>>> match the commit msg here.
>>
>> and the overall inconsistency check mechanism is already in place.
>> and the logic here just extends it to cover SL/FL. Given that,
>>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>
>>
>>>
>>>>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>   drivers/iommu/intel/cap_audit.h |  1 +
>>>>   drivers/iommu/intel/cap_audit.c | 13 +++++++++++++
>>>>   2 files changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/intel/cap_audit.h
>>>> b/drivers/iommu/intel/cap_audit.h
>>>> index 74cfccae0e81..d07b75938961 100644
>>>> --- a/drivers/iommu/intel/cap_audit.h
>>>> +++ b/drivers/iommu/intel/cap_audit.h
>>>> @@ -111,6 +111,7 @@ bool intel_cap_smts_sanity(void);
>>>>   bool intel_cap_pasid_sanity(void);
>>>>   bool intel_cap_nest_sanity(void);
>>>>   bool intel_cap_flts_sanity(void);
>>>> +bool intel_cap_slts_sanity(void);
>>>>
>>>>   static inline bool scalable_mode_support(void)
>>>>   {
>>>> diff --git a/drivers/iommu/intel/cap_audit.c
>>>> b/drivers/iommu/intel/cap_audit.c
>>>> index b12e421a2f1a..040e4ae0e42b 100644
>>>> --- a/drivers/iommu/intel/cap_audit.c
>>>> +++ b/drivers/iommu/intel/cap_audit.c
>>>> @@ -163,6 +163,14 @@ static int cap_audit_static(struct intel_iommu
>>>> *iommu, enum cap_audit_type type)
>>>>   			check_irq_capabilities(iommu, i);
>>>>   	}
>>>>
>>>> +	/*
>>>> +	 * If the system is sane to support scalable mode, either SL or FL
>>>> +	 * should be sane.
>>>> +	 */
>>>> +	if (intel_cap_smts_sanity() &&
>>>> +	    !intel_cap_flts_sanity() && !intel_cap_slts_sanity())
>>>> +		return -EFAULT;
> 
> btw this should not be -EFAULT.

Agreed. I will change it to -ENOTSUPP.

Best regards,
baolu

> 
>>>> +
>>>>   out:
>>>>   	rcu_read_unlock();
>>>>   	return 0;
>>>> @@ -203,3 +211,8 @@ bool intel_cap_flts_sanity(void)
>>>>   {
>>>>   	return ecap_flts(intel_iommu_ecap_sanity);
>>>>   }
>>>> +
>>>> +bool intel_cap_slts_sanity(void)
>>>> +{
>>>> +	return ecap_slts(intel_iommu_ecap_sanity);
>>>> +}
>>>> --
>>>> 2.25.1
> 
