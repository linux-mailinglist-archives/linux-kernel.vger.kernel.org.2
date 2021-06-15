Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159B83A78FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhFOI1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:27:23 -0400
Received: from foss.arm.com ([217.140.110.172]:56602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhFOI1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:27:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C362D6E;
        Tue, 15 Jun 2021 01:25:17 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF4AC3F694;
        Tue, 15 Jun 2021 01:25:15 -0700 (PDT)
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, dwmw2@infradead.org
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxarm@huawei.com, thunder.leizhen@huawei.com,
        chenxiang66@hisilicon.com
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
 <f3940a3f-d1c1-148d-e4b5-51cecf924ff5@linux.intel.com>
 <03675e2f-c3a6-ce33-ef96-f9ae544b2d13@huawei.com>
 <824db374-dc82-a9ea-b162-2f51e70ef999@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c3e1bb30-e1a9-08d7-0787-06a0bb119461@arm.com>
Date:   Tue, 15 Jun 2021 09:25:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <824db374-dc82-a9ea-b162-2f51e70ef999@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-15 08:26, Lu Baolu wrote:
> Hi John,
> 
> On 6/14/21 4:03 PM, John Garry wrote:
>> On 12/06/2021 03:14, Lu Baolu wrote:
>>> On 2021/6/11 20:20, John Garry wrote:
>>>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>> index 2a71347611d4..4467353f981b 100644
>>>> --- a/drivers/iommu/Kconfig
>>>> +++ b/drivers/iommu/Kconfig
>>>> @@ -94,6 +94,7 @@ choice
>>>>       prompt "IOMMU default DMA mode"
>>>>       depends on IOMMU_DMA
>>>> +    default IOMMU_DEFAULT_LAZY if INTEL_IOMMU
>>>>       default IOMMU_DEFAULT_STRICT
>>>
>>> If two default values are different. Which one will be overridden?
>>
>> If I understand your question correctly, I think you are asking if 
>> both are set:
>> CONFIG_IOMMU_DEFAULT_LAZY=y
>> CONFIG_IOMMU_DEFAULT_STRICT=y
>>
>> If this happens, then make defconfig complains about both being set, 
>> and selects the 2nd, whatever that is.
> 
> On x86, Intel or AMD, this will be
> 
>      prompt "IOMMU default DMA mode"
>        depends on IOMMU_DMA
>        default IOMMU_DEFAULT_LAZY
>        default IOMMU_DEFAULT_STRICT
> 
> which will be default, LAZY or STRICT? Will it cause complains?

See Documentation/kbuild/kconfig-language.rst:

   A config option can have any number of default values. If multiple
   default values are visible, only the first defined one is active.


Robin.
