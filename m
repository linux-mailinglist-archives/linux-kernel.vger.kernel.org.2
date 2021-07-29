Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560E53DA1A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhG2K7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:59:13 -0400
Received: from foss.arm.com ([217.140.110.172]:44962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234156AbhG2K7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:59:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D97D6D;
        Thu, 29 Jul 2021 03:59:09 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32E8D3F66F;
        Thu, 29 Jul 2021 03:59:07 -0700 (PDT)
Subject: Re: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
To:     "chenxiang (M)" <chenxiang66@hisilicon.com>, joro@8bytes.org,
        will@kernel.org
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        dianders@chromium.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <49c7ca2c-11a3-ff93-05bc-feb482a79980@hisilicon.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <942c3da1-fb79-967a-d50e-4cbf5331261c@arm.com>
Date:   Thu, 29 Jul 2021 11:59:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <49c7ca2c-11a3-ff93-05bc-feb482a79980@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-29 03:55, chenxiang (M) wrote:
> Hi Robin,
> 
> 
> 在 2021/7/28 23:58, Robin Murphy 写道:
>> Hi all,
>>
>> Here's v2 where things start to look more realistic, hence the expanded
>> CC list. The patches are now based on the current iommu/core branch to
>> take John's iommu_set_dma_strict() cleanup into account.
>>
>> The series remiains in two (or possibly 3) logical parts - for people
>> CC'd on cookie cleanup patches, the later parts should not affect you
>> since your drivers don't implement non-strict mode anyway; the cleanup
>> is all pretty straightforward, but please do yell at me if I've managed
>> to let a silly mistake slip through and broken your driver.
>>
>> This time I have also build-tested x86 as well as arm64 :)
> 
> I have tested those patchset on ARM64 with SMMUV3, and the testcases are 
> as follows:
> - Boot with iommu.strict=0, running fio and it works well;
> - Boot with iommu.strict=1, running fio and it works well;
> - Change strict mode to lazy mode when building, the change takes effect;
> - Boot without iommu.strict(default strict mode), change the sysfs 
> interface type from DMA to DMA-FQ dynamically during running fio, and it 
> works well;
> - Boot without iommu.strict(default strict mode), change the sysfs 
> interface type from DMA-FQ to DMA dynamically, and it is not allowed and 
> print "Device or resource busy"
> (i know it is qualified, and we can change no-strict mode to strict by 
> unbind the driver -> change the sysfs interface (type)->bind the driver 
> (tested this and it works well),
> but i have a small question: is it also possible to change from DMA-FQ 
> to DMA dynamically? )

As patch #22 mentions, I think it's possible in principle, but it's 
certainly trickier. When enabling a flush queue, it doesn't matter if it 
takes a while for other threads to notice that cookie->fq_domain is now 
set and stop doing synchronous invalidations (and in the SMMU case it 
seems like there are probably enough dependencies to additionally 
prevent the io_pgtable quirk being observable before that). However when 
disabling, we'd need to be absolutely sure that the driver *has* started 
invalidating strictly before we stop queueing freed IOVAs, plus we need 
to be absolutely sure that we've stopped queueing freed IOVAs before we 
attempt to tear down the flush queue itself. I'm not sure off-hand how 
feasible it would be to put all that synchronisation in the right places 
without it also impacting normal operation.

Furthermore, as also noted, there doesn't seem to be a good reason for 
ever actually needing to do that. If a device isn't trusted, it should 
be given a strict domain *before* any driver has a chance to start doing 
anything, or your trust model is broken and pretty useless. I can 
imagine some niche debugging/benchmarking cases where it might help save 
a bit of effort, but nothing with a strong enough justification to be 
worth supporting in mainline.

> Anyway, please feel free to add :
> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>

That's great, thanks!

Robin.

>> Changes in v2:
>>
>> - Add iommu_is_dma_domain() helper to abstract flag check (and help
>>    avoid silly typos like the one in v1).
>> - Tweak a few commit messages for spelling and (hopefully) clarity.
>> - Move the iommu_create_device_direct_mappings() update to patch #14
>>    where it should have been.
>> - Rewrite patch #20 as a conversion of the now-existing option.
>> - Clean up the ops->flush_iotlb_all check which is also made redundant
>>    by the new domain type
>> - Add patch #24, which is arguably tangential, but it was something I
>>    spotted during the rebase, so...
>>
>> Once again, the whole lot is available on a branch here:
>>
>> https://gitlab.arm.com/linux-arm/linux-rm/-/tree/iommu/fq
>>
>> Thanks,
>> Robin.
>>
>>
>> CC: Marek Szyprowski <m.szyprowski@samsung.com>
>> CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> CC: Geert Uytterhoeven <geert+renesas@glider.be>
>> CC: Yong Wu <yong.wu@mediatek.com>
>> CC: Heiko Stuebner <heiko@sntech.de>
>> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
>> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
>> CC: Maxime Ripard <mripard@kernel.org>
>> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>
>> Robin Murphy (24):
>>    iommu: Pull IOVA cookie management into the core
>>    iommu/amd: Drop IOVA cookie management
>>    iommu/arm-smmu: Drop IOVA cookie management
>>    iommu/vt-d: Drop IOVA cookie management
>>    iommu/exynos: Drop IOVA cookie management
>>    iommu/ipmmu-vmsa: Drop IOVA cookie management
>>    iommu/mtk: Drop IOVA cookie management
>>    iommu/rockchip: Drop IOVA cookie management
>>    iommu/sprd: Drop IOVA cookie management
>>    iommu/sun50i: Drop IOVA cookie management
>>    iommu/virtio: Drop IOVA cookie management
>>    iommu/dma: Unexport IOVA cookie management
>>    iommu/dma: Remove redundant "!dev" checks
>>    iommu: Introduce explicit type for non-strict DMA domains
>>    iommu/amd: Prepare for multiple DMA domain types
>>    iommu/arm-smmu: Prepare for multiple DMA domain types
>>    iommu/vt-d: Prepare for multiple DMA domain types
>>    iommu: Express DMA strictness via the domain type
>>    iommu: Expose DMA domain strictness via sysfs
>>    iommu: Merge strictness and domain type configs
>>    iommu/dma: Factor out flush queue init
>>    iommu: Allow enabling non-strict mode dynamically
>>    iommu/arm-smmu: Allow non-strict in pgtable_quirks interface
>>    iommu: Only log strictness for DMA domains
>>
>>   .../ABI/testing/sysfs-kernel-iommu_groups     |  2 +
>>   drivers/iommu/Kconfig                         | 80 +++++++++----------
>>   drivers/iommu/amd/iommu.c                     | 21 +----
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++--
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c         | 29 ++++---
>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  8 --
>>   drivers/iommu/dma-iommu.c                     | 44 +++++-----
>>   drivers/iommu/exynos-iommu.c                  | 18 +----
>>   drivers/iommu/intel/iommu.c                   | 23 ++----
>>   drivers/iommu/iommu.c                         | 53 +++++++-----
>>   drivers/iommu/ipmmu-vmsa.c                    | 27 +------
>>   drivers/iommu/mtk_iommu.c                     |  6 --
>>   drivers/iommu/rockchip-iommu.c                | 11 +--
>>   drivers/iommu/sprd-iommu.c                    |  6 --
>>   drivers/iommu/sun50i-iommu.c                  | 12 +--
>>   drivers/iommu/virtio-iommu.c                  |  8 --
>>   include/linux/dma-iommu.h                     |  9 ++-
>>   include/linux/iommu.h                         | 15 +++-
>>   18 files changed, 171 insertions(+), 226 deletions(-)
>>
> 
> 
