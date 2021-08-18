Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528C13F079B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhHRPOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:14:17 -0400
Received: from foss.arm.com ([217.140.110.172]:45182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239608AbhHRPOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:14:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3362E101E;
        Wed, 18 Aug 2021 08:13:34 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 518DD3F40C;
        Wed, 18 Aug 2021 08:13:31 -0700 (PDT)
Subject: Re: [PATCH v4 00/24] iommu: Refactor DMA domain strictness
To:     Joerg Roedel <joro@8bytes.org>, Sven Peter <sven@svenpeter.dev>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yong Wu <yong.wu@mediatek.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <cover.1628682048.git.robin.murphy@arm.com>
 <YRzvGxTW8m+NUcSi@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <914d7243-7f9d-425e-1ff7-6be218e04913@arm.com>
Date:   Wed, 18 Aug 2021 16:13:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YRzvGxTW8m+NUcSi@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-18 12:29, Joerg Roedel wrote:
> On Wed, Aug 11, 2021 at 01:21:14PM +0100, Robin Murphy wrote:
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
>>    iommu: Indicate queued flushes via gather data
>>    iommu/io-pgtable: Remove non-strict quirk
>>    iommu: Introduce explicit type for non-strict DMA domains
>>    iommu/amd: Prepare for multiple DMA domain types
>>    iommu/arm-smmu: Prepare for multiple DMA domain types
>>    iommu/vt-d: Prepare for multiple DMA domain types
>>    iommu: Express DMA strictness via the domain type
>>    iommu: Expose DMA domain strictness via sysfs
>>    iommu: Only log strictness for DMA domains
>>    iommu: Merge strictness and domain type configs
>>    iommu: Allow enabling non-strict mode dynamically
> 
> Applied all except patch 12. Please re-submit patch 12 together with the
> APPLE DART fixups after v5.15-rc1 is out.

Brilliant, thanks for fixing that up!

Sven - I've prepared the follow-up patches already[1], so consider 
yourself off the hook (I see no point in trying to fix the nominal DART 
cookie bugs between now and then) :)

Cheers,
Robin.

[1] https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/fq-fixes
