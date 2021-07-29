Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA88C3D9BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 04:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbhG2Cz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 22:55:26 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13208 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhG2CzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 22:55:25 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GZw3S1PjKz1CNwc;
        Thu, 29 Jul 2021 10:49:24 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 29
 Jul 2021 10:55:20 +0800
Subject: Re: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>
References: <cover.1627468308.git.robin.murphy@arm.com>
CC:     Maxime Ripard <mripard@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        <dianders@chromium.org>, <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <49c7ca2c-11a3-ff93-05bc-feb482a79980@hisilicon.com>
Date:   Thu, 29 Jul 2021 10:55:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,


在 2021/7/28 23:58, Robin Murphy 写道:
> Hi all,
>
> Here's v2 where things start to look more realistic, hence the expanded
> CC list. The patches are now based on the current iommu/core branch to
> take John's iommu_set_dma_strict() cleanup into account.
>
> The series remiains in two (or possibly 3) logical parts - for people
> CC'd on cookie cleanup patches, the later parts should not affect you
> since your drivers don't implement non-strict mode anyway; the cleanup
> is all pretty straightforward, but please do yell at me if I've managed
> to let a silly mistake slip through and broken your driver.
>
> This time I have also build-tested x86 as well as arm64 :)

I have tested those patchset on ARM64 with SMMUV3, and the testcases are 
as follows:
- Boot with iommu.strict=0, running fio and it works well;
- Boot with iommu.strict=1, running fio and it works well;
- Change strict mode to lazy mode when building, the change takes effect;
- Boot without iommu.strict(default strict mode), change the sysfs 
interface type from DMA to DMA-FQ dynamically during running fio, and it 
works well;
- Boot without iommu.strict(default strict mode), change the sysfs 
interface type from DMA-FQ to DMA dynamically, and it is not allowed and 
print "Device or resource busy"
(i know it is qualified, and we can change no-strict mode to strict by 
unbind the driver -> change the sysfs interface (type)->bind the driver 
(tested this and it works well),
but i have a small question: is it also possible to change from DMA-FQ 
to DMA dynamically? )

Anyway, please feel free to add :
Tested-by: Xiang Chen <chenxiang66@hisilicon.com>

>
> Changes in v2:
>
> - Add iommu_is_dma_domain() helper to abstract flag check (and help
>    avoid silly typos like the one in v1).
> - Tweak a few commit messages for spelling and (hopefully) clarity.
> - Move the iommu_create_device_direct_mappings() update to patch #14
>    where it should have been.
> - Rewrite patch #20 as a conversion of the now-existing option.
> - Clean up the ops->flush_iotlb_all check which is also made redundant
>    by the new domain type
> - Add patch #24, which is arguably tangential, but it was something I
>    spotted during the rebase, so...
>
> Once again, the whole lot is available on a branch here:
>
> https://gitlab.arm.com/linux-arm/linux-rm/-/tree/iommu/fq
>
> Thanks,
> Robin.
>
>
> CC: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> CC: Geert Uytterhoeven <geert+renesas@glider.be>
> CC: Yong Wu <yong.wu@mediatek.com>
> CC: Heiko Stuebner <heiko@sntech.de>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> Robin Murphy (24):
>    iommu: Pull IOVA cookie management into the core
>    iommu/amd: Drop IOVA cookie management
>    iommu/arm-smmu: Drop IOVA cookie management
>    iommu/vt-d: Drop IOVA cookie management
>    iommu/exynos: Drop IOVA cookie management
>    iommu/ipmmu-vmsa: Drop IOVA cookie management
>    iommu/mtk: Drop IOVA cookie management
>    iommu/rockchip: Drop IOVA cookie management
>    iommu/sprd: Drop IOVA cookie management
>    iommu/sun50i: Drop IOVA cookie management
>    iommu/virtio: Drop IOVA cookie management
>    iommu/dma: Unexport IOVA cookie management
>    iommu/dma: Remove redundant "!dev" checks
>    iommu: Introduce explicit type for non-strict DMA domains
>    iommu/amd: Prepare for multiple DMA domain types
>    iommu/arm-smmu: Prepare for multiple DMA domain types
>    iommu/vt-d: Prepare for multiple DMA domain types
>    iommu: Express DMA strictness via the domain type
>    iommu: Expose DMA domain strictness via sysfs
>    iommu: Merge strictness and domain type configs
>    iommu/dma: Factor out flush queue init
>    iommu: Allow enabling non-strict mode dynamically
>    iommu/arm-smmu: Allow non-strict in pgtable_quirks interface
>    iommu: Only log strictness for DMA domains
>
>   .../ABI/testing/sysfs-kernel-iommu_groups     |  2 +
>   drivers/iommu/Kconfig                         | 80 +++++++++----------
>   drivers/iommu/amd/iommu.c                     | 21 +----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++--
>   drivers/iommu/arm/arm-smmu/arm-smmu.c         | 29 ++++---
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  8 --
>   drivers/iommu/dma-iommu.c                     | 44 +++++-----
>   drivers/iommu/exynos-iommu.c                  | 18 +----
>   drivers/iommu/intel/iommu.c                   | 23 ++----
>   drivers/iommu/iommu.c                         | 53 +++++++-----
>   drivers/iommu/ipmmu-vmsa.c                    | 27 +------
>   drivers/iommu/mtk_iommu.c                     |  6 --
>   drivers/iommu/rockchip-iommu.c                | 11 +--
>   drivers/iommu/sprd-iommu.c                    |  6 --
>   drivers/iommu/sun50i-iommu.c                  | 12 +--
>   drivers/iommu/virtio-iommu.c                  |  8 --
>   include/linux/dma-iommu.h                     |  9 ++-
>   include/linux/iommu.h                         | 15 +++-
>   18 files changed, 171 insertions(+), 226 deletions(-)
>


