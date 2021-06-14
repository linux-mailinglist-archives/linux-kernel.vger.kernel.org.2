Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9653A6991
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhFNPH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:07:29 -0400
Received: from foss.arm.com ([217.140.110.172]:38202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhFNPHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:07:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6547B1FB;
        Mon, 14 Jun 2021 08:05:22 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DECD13F70D;
        Mon, 14 Jun 2021 08:05:20 -0700 (PDT)
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To:     John Garry <john.garry@huawei.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
 <4f2cec34-bad9-e1bf-85c1-04d1a0c1aecf@linux.intel.com>
 <6055cd0d-a1d3-a73a-6831-3837021f3c9c@huawei.com>
 <0a04f964-80f4-7b2a-9740-eae4596e4e09@arm.com>
 <453a4606-099c-3d06-13fd-dc29c24230f5@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a37fa781-8372-5014-c96e-0dde43217778@arm.com>
Date:   Mon, 14 Jun 2021 16:05:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <453a4606-099c-3d06-13fd-dc29c24230f5@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-14 15:19, John Garry wrote:
> On 14/06/2021 15:11, Robin Murphy wrote:
>> On 2021-06-14 08:53, John Garry wrote:
>>> On 12/06/2021 03:22, Lu Baolu wrote:
>>>> On 2021/6/11 20:20, John Garry wrote:
>>>>> @@ -453,8 +452,7 @@ static int __init intel_iommu_setup(char *str)
>>>>>                pr_warn("intel_iommu=forcedac deprecated; use
>>>>> iommu.forcedac instead\n");
>>>>>                iommu_dma_forcedac = true;
>>>>>            } else if (!strncmp(str, "strict", 6)) {
>>>>> -            pr_info("Disable batched IOTLB flush\n");
>>>>> -            intel_iommu_strict = 1;
>>>>> +            iommu_set_dma_strict(true);
>>>> I would like to deprecate this command line and ask users to use
>>>> iommu.strict instead.
>>> ok, but then I should probably make the AMD driver also officially
>>> support this.
>> Oops, I should have documented that "iommu.strict" already applies to
>> x86 as well. The interaction with the driver-specific parameters is a
>> bit weird and unintuitive, but it was done knowingly. Let me quickly
>> spin a kernel-parameters.txt fix for that...
> 
> So I already had a pending patch here for the same to be included in 
> this series:
> https://github.com/hisilicon/kernel-dev/commit/2375a2d888d78de9eb7d91d6f2c5891395300a96 
> 
> 
> If you want to do it, then ok. I might have to reorder the series though...

Yeah, sorry for the complication. Your subsequent deprecation of the x86 
parameters doesn't need to conflict, but we should probably also update 
that the default value now depends on the kernel config, which will :(

Thanks,
Robin.
