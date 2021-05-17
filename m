Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E2D382763
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbhEQIsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:48:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3008 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhEQIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:48:14 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkCP65NDKzmWsc;
        Mon, 17 May 2021 16:44:42 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:46:57 +0800
Received: from [10.174.187.224] (10.174.187.224) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:46:56 +0800
Subject: Re: [RFC PATCH v4 00/13] iommu/smmuv3: Implement hardware dirty log
 tracking
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Yi Sun" <yi.y.sun@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>
References: <20210507102211.8836-1-zhukeqian1@huawei.com>
CC:     <jiangkunkun@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
        "Kirti Wankhede" <kwankhede@nvidia.com>, <lushenming@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        <wanghaibin.wang@huawei.com>
From:   Keqian Zhu <zhukeqian1@huawei.com>
Message-ID: <18952c29-4400-55a6-de0a-c17f5bd4f13a@huawei.com>
Date:   Mon, 17 May 2021 16:46:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210507102211.8836-1-zhukeqian1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.224]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The VFIO part is at here: https://lore.kernel.org/kvm/20210507103608.39440-1-zhukeqian1@huawei.com/

Thanks,
Keqian

On 2021/5/7 18:21, Keqian Zhu wrote:
> Hi Robin, Will and everyone,
> 
> I think this series is relative mature now, please give your valuable suggestions,
> thanks!
> 
> 
> This patch series is split from the series[1] that containes both IOMMU part and
> VFIO part. The VFIO part will be sent out in another series.
> 
> [1] https://lore.kernel.org/linux-iommu/20210310090614.26668-1-zhukeqian1@huawei.com/
> 
> changelog:
> 
> v4:
>  - Modify the framework as suggested by Baolu, thanks!
>  - Add trace for iommu ops.
>  - Extract io-pgtable part.
> 
> v3:
>  - Merge start_dirty_log and stop_dirty_log into switch_dirty_log. (Yi Sun)
>  - Maintain the dirty log status in iommu_domain.
>  - Update commit message to make patch easier to review.
> 
> v2:
>  - Address all comments of RFC version, thanks for all of you ;-)
>  - Add a bugfix that start dirty log for newly added dma ranges and domain.
> 
> 
> 
> Hi everyone,
> 
> This patch series introduces a framework of iommu dirty log tracking, and smmuv3
> realizes this framework. This new feature can be used by VFIO dma dirty tracking.
> 
> Intention：
> 
> Some types of IOMMU are capable of tracking DMA dirty log, such as
> ARM SMMU with HTTU or Intel IOMMU with SLADE. This introduces the
> dirty log tracking framework in the IOMMU base layer.
> 
> Three new essential interfaces are added, and we maintaince the status
> of dirty log tracking in iommu_domain.
> 1. iommu_switch_dirty_log: Perform actions to start|stop dirty log tracking
> 2. iommu_sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
> 3. iommu_clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap
> 
> About SMMU HTTU:
> 
> HTTU (Hardware Translation Table Update) is a feature of ARM SMMUv3, it can update
> access flag or/and dirty state of the TTD (Translation Table Descriptor) by hardware.
> With HTTU, stage1 TTD is classified into 3 types:
>                         DBM bit             AP[2](readonly bit)
> 1. writable_clean         1                       1
> 2. writable_dirty         1                       0
> 3. readonly               0                       1
> 
> If HTTU_HD (manage dirty state) is enabled, smmu can change TTD from writable_clean to
> writable_dirty. Then software can scan TTD to sync dirty state into dirty bitmap. With
> this feature, we can track the dirty log of DMA continuously and precisely.
> 
> About this series:
> 
> Patch 1-3：Introduce dirty log tracking framework in the IOMMU base layer, and two common
>            interfaces that can be used by many types of iommu.
> 
> Patch 4-6: Add feature detection for smmu HTTU and enable HTTU for smmu stage1 mapping.
>            And add feature detection for smmu BBML. We need to split block mapping when
>            start dirty log tracking and merge page mapping when stop dirty log tracking,
> 		   which requires break-before-make procedure. But it might cause problems when the
> 		   TTD is alive. The I/O streams might not tolerate translation faults. So BBML
> 		   should be used.
> 
> Patch 7-12: We implement these interfaces for arm smmuv3.
> 
> Thanks,
> Keqian
> 
> Jean-Philippe Brucker (1):
>   iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
> 
> Keqian Zhu (1):
>   iommu: Introduce dirty log tracking framework
> 
> Kunkun Jiang (11):
>   iommu/io-pgtable-arm: Add quirk ARM_HD and ARM_BBMLx
>   iommu/io-pgtable-arm: Add and realize split_block ops
>   iommu/io-pgtable-arm: Add and realize merge_page ops
>   iommu/io-pgtable-arm: Add and realize sync_dirty_log ops
>   iommu/io-pgtable-arm: Add and realize clear_dirty_log ops
>   iommu/arm-smmu-v3: Enable HTTU for stage1 with io-pgtable mapping
>   iommu/arm-smmu-v3: Add feature detection for BBML
>   iommu/arm-smmu-v3: Realize switch_dirty_log iommu ops
>   iommu/arm-smmu-v3: Realize sync_dirty_log iommu ops
>   iommu/arm-smmu-v3: Realize clear_dirty_log iommu ops
>   iommu/arm-smmu-v3: Realize support_dirty_log iommu ops
> 
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 268 +++++++++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  14 +
>  drivers/iommu/io-pgtable-arm.c                | 389 +++++++++++++++++-
>  drivers/iommu/iommu.c                         | 206 +++++++++-
>  include/linux/io-pgtable.h                    |  23 ++
>  include/linux/iommu.h                         |  65 +++
>  include/trace/events/iommu.h                  |  63 +++
>  8 files changed, 1026 insertions(+), 4 deletions(-)
> 
