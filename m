Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264683A9536
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhFPIod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:44:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:13682 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232012AbhFPIoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:44:30 -0400
IronPort-SDR: ub69TCHkezbFX2XHupt/7iETjThXS7heEMI9+6G/vGcDA8dmAd4lQBxdppHWmcECO4/zi0U5sx
 A7+/L5P0Gh9w==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291770840"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="291770840"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 01:42:23 -0700
IronPort-SDR: XkMrx79+dB/mNC/PtGc2214acDd1tQm3kKMHkMe7U42BlYgoA1S0+ARJaX4DmyEBki/aLU+Wte
 49DGkPS1dyLg==
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="484805084"
Received: from hchan3-mobl1.gar.corp.intel.com (HELO [10.254.212.123]) ([10.254.212.123])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 01:42:20 -0700
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thunder.leizhen@huawei.com, chenxiang66@hisilicon.com
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
 <f3940a3f-d1c1-148d-e4b5-51cecf924ff5@linux.intel.com>
 <03675e2f-c3a6-ce33-ef96-f9ae544b2d13@huawei.com>
 <824db374-dc82-a9ea-b162-2f51e70ef999@linux.intel.com>
 <c3e1bb30-e1a9-08d7-0787-06a0bb119461@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a4b794be-6648-c088-877d-cdf8762151f6@linux.intel.com>
Date:   Wed, 16 Jun 2021 16:42:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c3e1bb30-e1a9-08d7-0787-06a0bb119461@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/15 16:25, Robin Murphy wrote:
> On 2021-06-15 08:26, Lu Baolu wrote:
>> Hi John,
>>
>> On 6/14/21 4:03 PM, John Garry wrote:
>>> On 12/06/2021 03:14, Lu Baolu wrote:
>>>> On 2021/6/11 20:20, John Garry wrote:
>>>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>>> index 2a71347611d4..4467353f981b 100644
>>>>> --- a/drivers/iommu/Kconfig
>>>>> +++ b/drivers/iommu/Kconfig
>>>>> @@ -94,6 +94,7 @@ choice
>>>>>       prompt "IOMMU default DMA mode"
>>>>>       depends on IOMMU_DMA
>>>>> +    default IOMMU_DEFAULT_LAZY if INTEL_IOMMU
>>>>>       default IOMMU_DEFAULT_STRICT
>>>>
>>>> If two default values are different. Which one will be overridden?
>>>
>>> If I understand your question correctly, I think you are asking if 
>>> both are set:
>>> CONFIG_IOMMU_DEFAULT_LAZY=y
>>> CONFIG_IOMMU_DEFAULT_STRICT=y
>>>
>>> If this happens, then make defconfig complains about both being set, 
>>> and selects the 2nd, whatever that is.
>>
>> On x86, Intel or AMD, this will be
>>
>>      prompt "IOMMU default DMA mode"
>>        depends on IOMMU_DMA
>>        default IOMMU_DEFAULT_LAZY
>>        default IOMMU_DEFAULT_STRICT
>>
>> which will be default, LAZY or STRICT? Will it cause complains?
> 
> See Documentation/kbuild/kconfig-language.rst:
> 
>    A config option can have any number of default values. If multiple
>    default values are visible, only the first defined one is active.

Get it. Thank you, Robin.

Best regards,
baolu
