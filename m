Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF923DA7C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbhG2PnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:43:22 -0400
Received: from foss.arm.com ([217.140.110.172]:50878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237891AbhG2PnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:43:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27E076D;
        Thu, 29 Jul 2021 08:43:16 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A26983F73D;
        Thu, 29 Jul 2021 08:43:13 -0700 (PDT)
Subject: Re: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yong Wu <yong.wu@mediatek.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <2947762.k3LOHGUjKi@diego>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ade9f10e-836c-f29e-030b-23fe0a3187fb@arm.com>
Date:   Thu, 29 Jul 2021 16:43:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2947762.k3LOHGUjKi@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-29 16:04, Heiko Stübner wrote:
> Hi Robin,
> 
> Am Mittwoch, 28. Juli 2021, 17:58:21 CEST schrieb Robin Murphy:
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
> TL;DR: arm64 yay, arm32 nay ;-)

Cheers Heiko!

> testcase:
> 5.14-rc3
> + iommu/next
> + patches 1+8 (the ones you cc'd me on)
>    iommu: Pull IOVA cookie management into the core
>    iommu/rockchip: Drop IOVA cookie management
> 
> rk3399+hdmi (puma): boots with graphics
> rk3399+edp (kevin): boots with graphics
> px30+dsi (minievb): boots with graphics
> 
> rk3288 (arm32, veyron-pinky): hangs when trying to start the rockchip-drm
> at some points the rest of the system recovers and fills the log with
> 
> [   47.193776] [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
> [   47.193867] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:31:plane-0] commit wait timed out
> [   57.433743] [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
> [   57.433828] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [PLANE:40:plane-4] commit wait timed out
> 
> spews
> 
> testcase 2:
> 5.14-rc3
> + iommu/next
> 
> all works fine on both arm32+arm64
> 
> 
> That whole iommu voodoo is a bit over my head right now, so I'm not sure
> what to poke to diagnose this.

Dang, this wasn't supposed to affect 32-bit Arm at all, since that 
doesn't touch any of the default domain stuff either way. I have both my 
RK3288 box (which IIRC doesn't currently boot) and an Odroid-U3 in the 
"desk pile" right in front of me, so at worst I'll try bringing one of 
those to life to see what silly thing I have indeed done to break 32-bit.

I have a vague idea forming already, which suggests that it might get 
better again once patch #12 is applied, but even if so there's no excuse 
not to be bisectable, so I need to dig in and fix it - many thanks for 
yelling as requested :D

Robin.

> 
> 
> Heiko
> 
> 
>> Changes in v2:
>>
>> - Add iommu_is_dma_domain() helper to abstract flag check (and help
>>    avoid silly typos like the one in v1).
>> - Tweak a few commit messages for spelling and (hopefully) clarity.
>> - Move the iommu_create_device_direct_mappings() update to patch #14
>>    where it should have been.
>> - Rewrite patch #20 as a conversion of the now-existing option.
>> - Clean up the ops->flush_iotlb_all check which is also made redundant
>>    by the new domain type
>> - Add patch #24, which is arguably tangential, but it was something I
>>    spotted during the rebase, so...
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
>>    iommu: Pull IOVA cookie management into the core
>>    iommu/amd: Drop IOVA cookie management
>>    iommu/arm-smmu: Drop IOVA cookie management
>>    iommu/vt-d: Drop IOVA cookie management
>>    iommu/exynos: Drop IOVA cookie management
>>    iommu/ipmmu-vmsa: Drop IOVA cookie management
>>    iommu/mtk: Drop IOVA cookie management
>>    iommu/rockchip: Drop IOVA cookie management
>>    iommu/sprd: Drop IOVA cookie management
>>    iommu/sun50i: Drop IOVA cookie management
>>    iommu/virtio: Drop IOVA cookie management
>>    iommu/dma: Unexport IOVA cookie management
>>    iommu/dma: Remove redundant "!dev" checks
>>    iommu: Introduce explicit type for non-strict DMA domains
>>    iommu/amd: Prepare for multiple DMA domain types
>>    iommu/arm-smmu: Prepare for multiple DMA domain types
>>    iommu/vt-d: Prepare for multiple DMA domain types
>>    iommu: Express DMA strictness via the domain type
>>    iommu: Expose DMA domain strictness via sysfs
>>    iommu: Merge strictness and domain type configs
>>    iommu/dma: Factor out flush queue init
>>    iommu: Allow enabling non-strict mode dynamically
>>    iommu/arm-smmu: Allow non-strict in pgtable_quirks interface
>>    iommu: Only log strictness for DMA domains
>>
>>   .../ABI/testing/sysfs-kernel-iommu_groups     |  2 +
>>   drivers/iommu/Kconfig                         | 80 +++++++++----------
>>   drivers/iommu/amd/iommu.c                     | 21 +----
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++--
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c         | 29 ++++---
>>   drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  8 --
>>   drivers/iommu/dma-iommu.c                     | 44 +++++-----
>>   drivers/iommu/exynos-iommu.c                  | 18 +----
>>   drivers/iommu/intel/iommu.c                   | 23 ++----
>>   drivers/iommu/iommu.c                         | 53 +++++++-----
>>   drivers/iommu/ipmmu-vmsa.c                    | 27 +------
>>   drivers/iommu/mtk_iommu.c                     |  6 --
>>   drivers/iommu/rockchip-iommu.c                | 11 +--
>>   drivers/iommu/sprd-iommu.c                    |  6 --
>>   drivers/iommu/sun50i-iommu.c                  | 12 +--
>>   drivers/iommu/virtio-iommu.c                  |  8 --
>>   include/linux/dma-iommu.h                     |  9 ++-
>>   include/linux/iommu.h                         | 15 +++-
>>   18 files changed, 171 insertions(+), 226 deletions(-)
>>
>>
> 
> 
> 
> 
