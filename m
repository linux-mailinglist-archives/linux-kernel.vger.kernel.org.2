Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798883C1564
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 16:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhGHOqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 10:46:34 -0400
Received: from foss.arm.com ([217.140.110.172]:60604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhGHOqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:46:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4B321424;
        Thu,  8 Jul 2021 07:43:51 -0700 (PDT)
Received: from [10.57.35.192] (unknown [10.57.35.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C709D3F66F;
        Thu,  8 Jul 2021 07:43:50 -0700 (PDT)
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu v2
 and uses identity mapping
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     will@kernel.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
 <YObFJREB9/JlcNZP@8bytes.org> <fde11cec-d1bd-49be-f129-c69a973d1b3b@arm.com>
 <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f3bdedcb-5602-cbca-7df1-019e8b8c4217@arm.com>
Date:   Thu, 8 Jul 2021 15:43:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-08 14:57, Kai-Heng Feng wrote:
> On Thu, Jul 8, 2021 at 6:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-07-08 10:28, Joerg Roedel wrote:
>>> On Thu, Jul 08, 2021 at 03:42:32PM +0800, Kai-Heng Feng wrote:
>>>> @@ -344,6 +344,9 @@ static int iommu_init_device(struct device *dev)
>>>>
>>>>               iommu = amd_iommu_rlookup_table[dev_data->devid];
>>>>               dev_data->iommu_v2 = iommu->is_iommu_v2;
>>>> +
>>>> +            if (dev_data->iommu_v2)
>>>> +                    swiotlb = 1;
>>>
>>> This looks like the big hammer, as it will affect all other systems
>>> where the AMD GPUs are in their own group.
>>>
>>> What is needed here is an explicit check whether a non-iommu-v2 device
>>> is direct-mapped because it shares a group with the GPU, and only enable
>>> swiotlb in this case.
>>
>> Right, it's basically about whether any DMA-limited device might at any
>> time end up in an IOMMU_DOMAIN_IDENTITY domain. And given the
>> possibility of device hotplug and the user being silly with the sysfs
>> interface, I don't think we can categorically determine that at boot time.
>>
>> Also note that Intel systems are likely to be similarly affected (in
>> fact intel-iommu doesn't even have the iommu_default_passthough() check
>> so it's probably even easier to blow up).
> 
> swiotlb is enabled by pci_swiotlb_detect_4gb() and intel-iommu doesn't
> disable it.

Oh, right... I did say I found this dance hard to follow. Clearly I 
shouldn't have trusted what I thought I remembered from looking at it 
yesterday :)

Also not helped by the fact that it sets iommu_detected which *does* 
disable SWIOTLB, but only on IA-64.

> I wonder if we can take the same approach in amd-iommu?

Certainly if there's a precedent for leaving SWIOTLB enabled even if it 
*might* be redundant, that seems like the easiest option (it's what we 
do on arm64 too, but then we have system topologies where some devices 
may not be behind IOMMUs even when others are). More fun would be to try 
to bring it up at the first sign of IOMMU_DOMAIN_IDENTITY if it was 
disabled previously, but I don't have the highest hope of that being 
practical.

Robin.
