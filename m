Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9293A3411FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCSBM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:12:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:53681 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231989AbhCSBLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:11:54 -0400
IronPort-SDR: VQhX1t+R3NRubK5UksXO1HvUsWeQgWFelvayBRNLTxWW75gUF3MbubN/A0bxVT9zyYi80Lorbe
 SQ38bFxh9ySQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="253807850"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="253807850"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 18:11:53 -0700
IronPort-SDR: x+MgqkNqPy2F2VFdTbXqhIBZxCpqoZXDNrbT1D/v6ToPMW9/OnawiGv09j1i/+jG7cgEe1zupQ
 FJSNjHJzK2Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="434078622"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2021 18:11:48 -0700
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix lockdep splat in
 intel_pasid_get_entry()
To:     Joerg Roedel <joro@8bytes.org>
References: <20210317005834.173503-1-baolu.lu@linux.intel.com>
 <YFMpmLNd73IVcgWq@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <89f87115-32dc-205e-61e0-71de0d626303@linux.intel.com>
Date:   Fri, 19 Mar 2021 09:02:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFMpmLNd73IVcgWq@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 3/18/21 6:21 PM, Joerg Roedel wrote:
> On Wed, Mar 17, 2021 at 08:58:34AM +0800, Lu Baolu wrote:
>> The pasid_lock is used to synchronize different threads from modifying a
>> same pasid directory entry at the same time. It causes below lockdep splat.
>>
>> [   83.296538] ========================================================
>> [   83.296538] WARNING: possible irq lock inversion dependency detected
>> [   83.296539] 5.12.0-rc3+ #25 Tainted: G        W
>> [   83.296539] --------------------------------------------------------
>> [   83.296540] bash/780 just changed the state of lock:
>> [   83.296540] ffffffff82b29c98 (device_domain_lock){..-.}-{2:2}, at:
>>             iommu_flush_dev_iotlb.part.0+0x32/0x110
>> [   83.296547] but this lock took another, SOFTIRQ-unsafe lock in the past:
>> [   83.296547]  (pasid_lock){+.+.}-{2:2}
>> [   83.296548]
>>
>>             and interrupts could create inverse lock ordering between them.
>>
>> [   83.296549] other info that might help us debug this:
>> [   83.296549] Chain exists of:
>>                   device_domain_lock --> &iommu->lock --> pasid_lock
>> [   83.296551]  Possible interrupt unsafe locking scenario:
>>
>> [   83.296551]        CPU0                    CPU1
>> [   83.296552]        ----                    ----
>> [   83.296552]   lock(pasid_lock);
>> [   83.296553]                                local_irq_disable();
>> [   83.296553]                                lock(device_domain_lock);
>> [   83.296554]                                lock(&iommu->lock);
>> [   83.296554]   <Interrupt>
>> [   83.296554]     lock(device_domain_lock);
>> [   83.296555]
>>                  *** DEADLOCK ***
>>
>> Fix it by replacing the pasid_lock with an atomic exchange operation.
>>
>> Reported-and-tested-by: Dave Jiang <dave.jiang@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/pasid.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 9fb3d3e80408..1ddcb8295f72 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -24,7 +24,6 @@
>>   /*
>>    * Intel IOMMU system wide PASID name space:
>>    */
>> -static DEFINE_SPINLOCK(pasid_lock);
>>   u32 intel_pasid_max_id = PASID_MAX;
>>   
>>   int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid)
>> @@ -259,19 +258,18 @@ struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>>   	dir_index = pasid >> PASID_PDE_SHIFT;
>>   	index = pasid & PASID_PTE_MASK;
>>   
>> -	spin_lock(&pasid_lock);
>>   	entries = get_pasid_table_from_pde(&dir[dir_index]);
>>   	if (!entries) {
>>   		entries = alloc_pgtable_page(info->iommu->node);
>> -		if (!entries) {
>> -			spin_unlock(&pasid_lock);
>> +		if (!entries)
>>   			return NULL;
>> -		}
>>   
>> -		WRITE_ONCE(dir[dir_index].val,
>> -			   (u64)virt_to_phys(entries) | PASID_PTE_PRESENT);
>> +		if (cmpxchg64(&dir[dir_index].val, 0ULL,
>> +			      (u64)virt_to_phys(entries) | PASID_PTE_PRESENT)) {
>> +			free_pgtable_page(entries);
>> +			entries = get_pasid_table_from_pde(&dir[dir_index]);
> 
> This is racy, someone could have already cleared the pasid-entry again.

This code modifies the pasid directory entry. The pasid directory
entries are allocated on demand and will never be freed.

> What you need to do here is to retry the whole path by adding a goto
> to before  the first get_pasid_table_from_pde() call.

Yes. Retrying by adding a goto makes the code clearer.

> 
> Btw, what makes sure that the pasid_entry does not go away when it is
> returned here?

As explained above, it handles the pasid directory table entry which
won't go away.

> 
> Regards,
> 
> 	Joerg
> 

Best regards,
baolu
