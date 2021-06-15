Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238CC3A77F6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFOHaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:30:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:2501 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhFOHaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:30:09 -0400
IronPort-SDR: m9j6sfytZgW/aQrWbkFRpR6p5vFRpvNbf7QTGOh0h0YbFzR5xQ2Qet9nIrilewS8rGPVjGghgV
 /lMUfbiSPUCw==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="291572678"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="291572678"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 00:27:53 -0700
IronPort-SDR: NhPtFRnH3Fzy5OVQxBazWhogkyHcuZquz8oQL1Qi6xEiNOXLelQQ3/bGTsFOjDJYnIzoy2wska
 cSHMVG53fLEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="554359035"
Received: from unknown (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2021 00:27:51 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org, robin.murphy@arm.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
 <f3940a3f-d1c1-148d-e4b5-51cecf924ff5@linux.intel.com>
 <03675e2f-c3a6-ce33-ef96-f9ae544b2d13@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <824db374-dc82-a9ea-b162-2f51e70ef999@linux.intel.com>
Date:   Tue, 15 Jun 2021 15:26:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <03675e2f-c3a6-ce33-ef96-f9ae544b2d13@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 6/14/21 4:03 PM, John Garry wrote:
> On 12/06/2021 03:14, Lu Baolu wrote:
>> On 2021/6/11 20:20, John Garry wrote:
>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>> index 2a71347611d4..4467353f981b 100644
>>> --- a/drivers/iommu/Kconfig
>>> +++ b/drivers/iommu/Kconfig
>>> @@ -94,6 +94,7 @@ choice
>>>       prompt "IOMMU default DMA mode"
>>>       depends on IOMMU_DMA
>>> +    default IOMMU_DEFAULT_LAZY if INTEL_IOMMU
>>>       default IOMMU_DEFAULT_STRICT
>>
>> If two default values are different. Which one will be overridden?
> 
> If I understand your question correctly, I think you are asking if both 
> are set:
> CONFIG_IOMMU_DEFAULT_LAZY=y
> CONFIG_IOMMU_DEFAULT_STRICT=y
> 
> If this happens, then make defconfig complains about both being set, and 
> selects the 2nd, whatever that is.

On x86, Intel or AMD, this will be

	prompt "IOMMU default DMA mode"
	  depends on IOMMU_DMA
	  default IOMMU_DEFAULT_LAZY
	  default IOMMU_DEFAULT_STRICT

which will be default, LAZY or STRICT? Will it cause complains?

> 
> If neither are set, then IOMMU_DEFAULT_LAZY is set if INTEL_IOMMU is 
> set, otherwise IOMMU_DEFAULT_STRICT.
> 
> Thanks,
> John

Best regards,
baolu
