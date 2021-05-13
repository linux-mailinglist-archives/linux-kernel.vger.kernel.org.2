Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601C037F191
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhEMDPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:15:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:24625 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhEMDPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:15:20 -0400
IronPort-SDR: JiFzRWpkgCF60x3c9vcbSuzo2tcPZfC7jdY/ktIkvv1FHeTDmdVSn4PRUXGRfjFVXqJ49cYt4k
 OLfClmCFN6Zw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="199914853"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="199914853"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 20:14:11 -0700
IronPort-SDR: UHFyjXZ0aRG7aAZq2qUN0bqJ6mFVnClNga7L6JpsrNrtfT11P3iVJ+5nqoziCsuWdheTMVkNjU
 Gvc4DUtdHP9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="623089002"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga006.fm.intel.com with ESMTP; 12 May 2021 20:14:08 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, kevin.tian@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Tweak the description of a DMA fault
To:     "Raj, Ashok" <ashok.raj@intel.com>
References: <20210512065012.3441160-1-baolu.lu@linux.intel.com>
 <20210512165602.GA102348@otc-nc-03>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5e1f5d9c-2edc-e01e-a41b-e14a1af2e0f7@linux.intel.com>
Date:   Thu, 13 May 2021 11:13:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210512165602.GA102348@otc-nc-03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/21 12:56 AM, Raj, Ashok wrote:
> On Wed, May 12, 2021 at 02:50:12PM +0800, Lu Baolu wrote:
>> The Intel IOMMU driver reports the DMA fault reason in a decimal number
>> while the VT-d specification uses a hexadecimal one. It's inconvenient
>> that users need to covert them everytime before consulting the spec.
>> Let's use hexadecimal number for a DMA fault reason.
>>
>> The fault message uses 0xffffffff as PASID for DMA requests w/o PASID.
>> This is confusing. Tweak this by adding "w/o PASID" explicitly.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Maybe simpler to call it NO_PASID, and just PASID 0xxxxx instead?

Yeah, it's okay for me.

> 
> with the minor suggestions below
> 
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>

Thanks!

> 
>> ---
>>   drivers/iommu/intel/dmar.c | 22 ++++++++++++++--------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 1757ac1e1623..11e37d2c2af2 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1911,15 +1911,21 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>>   	reason = dmar_get_fault_reason(fault_reason, &fault_type);
>>   
>>   	if (fault_type == INTR_REMAP)
>> -		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index %llx [fault reason %02d] %s\n",
>> -			source_id >> 8, PCI_SLOT(source_id & 0xFF),
>> -			PCI_FUNC(source_id & 0xFF), addr >> 48,
>> -			fault_reason, reason);
>> -	else
>> -		pr_err("[%s] Request device [%02x:%02x.%d] PASID %x fault addr %llx [fault reason %02d] %s\n",
>> +		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index %llx [fault reason %02xh] %s\n",
>> +		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>> +		       PCI_FUNC(source_id & 0xFF), addr >> 48,
>> +		       fault_reason, reason);
>> +	else if (pasid == INVALID_IOASID)
>> +		pr_err("[%s w/o PASID] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02xh] %s\n",
>>   		       type ? "DMA Read" : "DMA Write",
>>   		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>> -		       PCI_FUNC(source_id & 0xFF), pasid, addr,
>> +		       PCI_FUNC(source_id & 0xFF), addr,
>> +		       fault_reason, reason);
>> +	else
>> +		pr_err("[%s w/ PASID %x] Request device [%02x:%02x.%d] fault addr %llx [fault reason %02xh] %s\n",
> 
> Can you always lead hex values with 0x?

Yes.

> 
>> +		       type ? "DMA Read" : "DMA Write", pasid,
>> +		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
>> +		       PCI_FUNC(source_id & 0xFF), addr,
>>   		       fault_reason, reason);
>>   	return 0;
>>   }
>> @@ -1987,7 +1993,7 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>>   		if (!ratelimited)
>>   			/* Using pasid -1 if pasid is not present */
>>   			dmar_fault_do_one(iommu, type, fault_reason,
>> -					  pasid_present ? pasid : -1,
>> +					  pasid_present ? pasid : INVALID_IOASID,
>>   					  source_id, guest_addr);
>>   
>>   		fault_index++;
>> -- 
>> 2.25.1
>>
> 

Best regards,
baolu
