Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487B935B774
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 01:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhDKXtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 19:49:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:8874 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235229AbhDKXtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 19:49:42 -0400
IronPort-SDR: 2Q8YAqGh3v1WZnA9GkJmEM8YtRZAWcaZ0ODmSX03jdcwJfMzw0QrkmxB7NdgTX75OTM7o+c5ml
 2ereCzpaiWVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="258060218"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="258060218"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 16:49:24 -0700
IronPort-SDR: bD4D54lCGzxs/O6N1lptfZGUcvuKNR0SFkvzvLX9G5zIazPCN8TreX47efQwJgz4lEpLZHWWAR
 DYVzUrLMwMBw==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="423561225"
Received: from jiezhao-mobl1.ccr.corp.intel.com (HELO [10.254.214.21]) ([10.254.214.21])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 16:49:22 -0700
Cc:     baolu.lu@linux.intel.com, Camille Lu <camille.lu@hpe.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.4 v2 1/1] iommu/vt-d: Fix agaw for a supported 48 bit
 guest address width
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
References: <20210407184030.21683-1-saeed.mirzamohammadi@oracle.com>
 <deca9431-a52a-2818-4493-5a6ffeadccb9@linux.intel.com>
 <E3377E7A-073F-4D9C-92FE-8CC4836343AF@oracle.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <036429a7-9924-7ed5-6be9-2bd087594e9b@linux.intel.com>
Date:   Mon, 12 Apr 2021 07:49:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <E3377E7A-073F-4D9C-92FE-8CC4836343AF@oracle.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I guess you need to ask Greg KH <gregkh@linuxfoundation.org> with this
Cc-ing to stable@vger.kernel.org.

Best regards,
baolu

On 2021/4/12 3:36, Saeed Mirzamohammadi wrote:
> Hi Lu,
> 
> Thanks for the review. May I know when do we expect this to be applied 
> to 5.4?
> 
> Thanks,
> Saeed
> 
>> On Apr 7, 2021, at 5:25 PM, Lu Baolu <baolu.lu@linux.intel.com 
>> <mailto:baolu.lu@linux.intel.com>> wrote:
>>
>> On 4/8/21 2:40 AM, Saeed Mirzamohammadi wrote:
>>> The IOMMU driver calculates the guest addressability for a DMA request
>>> based on the value of the mgaw reported from the IOMMU. However, this
>>> is a fused value and as mentioned in the spec, the guest width
>>> should be calculated based on the minimum of supported adjusted guest
>>> address width (SAGAW) and MGAW.
>>> This is from specification:
>>> "Guest addressability for a given DMA request is limited to the
>>> minimum of the value reported through this field and the adjusted
>>> guest address width of the corresponding page-table structure.
>>> (Adjusted guest address widths supported by hardware are reported
>>> through the SAGAW field)."
>>> This causes domain initialization to fail and following
>>> errors appear for EHCI PCI driver:
>>> [    2.486393] ehci-pci 0000:01:00.4: EHCI Host Controller
>>> [    2.486624] ehci-pci 0000:01:00.4: new USB bus registered, 
>>> assigned bus
>>> number 1
>>> [    2.489127] ehci-pci 0000:01:00.4: DMAR: Allocating domain failed
>>> [    2.489350] ehci-pci 0000:01:00.4: DMAR: 32bit DMA uses non-identity
>>> mapping
>>> [    2.489359] ehci-pci 0000:01:00.4: can't setup: -12
>>> [    2.489531] ehci-pci 0000:01:00.4: USB bus 1 deregistered
>>> [    2.490023] ehci-pci 0000:01:00.4: init 0000:01:00.4 fail, -12
>>> [    2.490358] ehci-pci: probe of 0000:01:00.4 failed with error -12
>>> This issue happens when the value of the sagaw corresponds to a
>>> 48-bit agaw. This fix updates the calculation of the agaw based on
>>> the minimum of IOMMU's sagaw value and MGAW.
>>> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com 
>>> <mailto:saeed.mirzamohammadi@oracle.com>>
>>> Tested-by: Camille Lu <camille.lu@hpe.com <mailto:camille.lu@hpe.com>>
>>> ---
>>> Change in v2:
>>> - Added cap_width to calculate AGAW based on the minimum value of 
>>> MGAW and AGAW.
>>> ---
>>>  drivers/iommu/intel-iommu.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>> index 953d86ca6d2b..a2a03df97704 100644
>>> --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -1853,7 +1853,7 @@ static inline int guestwidth_to_adjustwidth(int 
>>> gaw)
>>>  static int domain_init(struct dmar_domain *domain, struct 
>>> intel_iommu *iommu,
>>>       int guest_width)
>>>  {
>>> -int adjust_width, agaw;
>>> +int adjust_width, agaw, cap_width;
>>> unsigned long sagaw;
>>> int err;
>>>  @@ -1867,8 +1867,9 @@ static int domain_init(struct dmar_domain 
>>> *domain, struct intel_iommu *iommu,
>>> domain_reserve_special_ranges(domain);
>>> /* calculate AGAW */
>>> -if (guest_width > cap_mgaw(iommu->cap))
>>> -guest_width = cap_mgaw(iommu->cap);
>>> +cap_width = min_t(int, cap_mgaw(iommu->cap), 
>>> agaw_to_width(iommu->agaw));
>>> +if (guest_width > cap_width)
>>> +guest_width = cap_width;
>>> domain->gaw = guest_width;
>>> adjust_width = guestwidth_to_adjustwidth(guest_width);
>>> agaw = width_to_agaw(adjust_width);
>>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com 
>> <mailto:baolu.lu@linux.intel.com>>
>>
>> Best regards,
>> baolu
> 
