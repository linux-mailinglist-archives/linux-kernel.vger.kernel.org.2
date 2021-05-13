Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B8D37F18C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhEMDM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:12:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:29490 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhEMDM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:12:26 -0400
IronPort-SDR: iYhx8zu+pFss2K6oCaCNgvR605oJ/4B5mVE3ZUerynkdsmWtiBUJgMwhLICJ8kvoHlBCDX5Pye
 us52Pm+DEHbg==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="186989707"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="186989707"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 20:11:12 -0700
IronPort-SDR: rYgEoMOfzV+LgG65pLR0vcGBSB+6puHbSyeU7qACrWjxPvcwfOCr8KkY6Sx2peHCyH3k/0tf/P
 uuEpxSDxI9YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="623088032"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga006.fm.intel.com with ESMTP; 12 May 2021 20:11:09 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Support asynchronous IOMMU nested
 capabilities
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20210512070421.3472857-1-baolu.lu@linux.intel.com>
 <MWHPR11MB18867DF70AD168ECFB3CC0648C529@MWHPR11MB1886.namprd11.prod.outlook.com>
 <2eb677d1-14d7-c1dc-6dd4-179c11c76b10@linux.intel.com>
 <BN6PR11MB187532A1AD69016E2AE0ECF38C519@BN6PR11MB1875.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e735211a-1afc-ab0e-aa8a-c43ef60d0e1b@linux.intel.com>
Date:   Thu, 13 May 2021 11:10:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BN6PR11MB187532A1AD69016E2AE0ECF38C519@BN6PR11MB1875.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/21 10:26 AM, Tian, Kevin wrote:
>> From: Lu Baolu
>> Sent: Wednesday, May 12, 2021 7:31 PM
>>
>> Hi Kevin,
>>
>> On 5/12/21 4:30 PM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Wednesday, May 12, 2021 3:04 PM
>>>>
>>>> Current VT-d implementation supports nested translation only if all
>>>> underlying IOMMUs support the nested capability. This is unnecessary
>>>> as the upper layer is allowed to create different containers and set
>>>> them with different type of iommu backend. The IOMMU driver needs to
>>>> guarantee that devices attached to a nested mode iommu_domain should
>>>> support nested capabilility.
>>> so the consistency check is now applied only to the IOMMUs that are
>>> spanned by a given iommu_domain?
>> Yes.
>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/intel/iommu.c | 21 +++++++++++++++++++--
>>>>    1 file changed, 19 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index f1742da42478..1cd4840e6f9f 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -4755,6 +4755,13 @@ static int
>> prepare_domain_attach_device(struct
>>>> iommu_domain *domain,
>>>>    	if (!iommu)
>>>>    		return -ENODEV;
>>>>
>>>> +	if ((dmar_domain->flags & DOMAIN_FLAG_NESTING_MODE) &&
>>>> +	    !ecap_nest(iommu->ecap)) {
>>>> +		dev_err(dev, "%s: iommu not support nested translation\n",
>>>> +			iommu->name);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>>    	/* check if this iommu agaw is sufficient for max mapped address */
>>>>    	addr_width = agaw_to_width(iommu->agaw);
>>>>    	if (addr_width > cap_mgaw(iommu->cap))
>>>> @@ -5451,11 +5458,21 @@ static int
>>>>    intel_iommu_enable_nesting(struct iommu_domain *domain)
>>>>    {
>>>>    	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>>> +	struct dmar_drhd_unit *drhd;
>>>> +	struct intel_iommu *iommu;
>>>> +	bool has_nesting = false;
>>>>    	unsigned long flags;
>>>> -	int ret = -ENODEV;
>>>> +	int ret = -EINVAL;
>>>> +
>>>> +	for_each_active_iommu(iommu, drhd)
>>>> +		if (ecap_nest(iommu->ecap))
>>>> +			has_nesting = true;
>>>> +
>>>> +	if (!has_nesting)
>>>> +		return -ENODEV;
>>> Isn't above still doing global consistency check?
>> The logic is if nested mode is globally unsupported, return false.
> why is this check required? anyway you already have the check when
> prepare device attachment, and only at that point you have accurate
> info for which iommu to be checked. This check looks meaningless
> as even if some IOMMUs support nesting it doesn't mean the IOMMU
> relevant to this domain support it.
> 

Get you. It's really unnecessary. I will drop this check in the new
version.

Best regards,
baolu
