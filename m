Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FBD35DA78
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243885AbhDMIzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:55:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16581 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhDMIze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:55:34 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FKKBK2bPNz1BGZD;
        Tue, 13 Apr 2021 16:52:57 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 16:55:05 +0800
From:   Keqian Zhu <zhukeqian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Will Deacon" <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Yi Sun <yi.y.sun@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        <wanghaibin.wang@huawei.com>, <jiangkunkun@huawei.com>,
        <yuzenghui@huawei.com>, <lushenming@huawei.com>
Subject: [PATCH v3 00/12] iommu/smmuv3: Implement hardware dirty log tracking
Date:   Tue, 13 Apr 2021 16:54:45 +0800
Message-ID: <20210413085457.25400-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.224]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch series is split from the series[1] that containes both IOMMU part and
VFIO part. The new VFIO part will be sent out in another series.

[1] https://lore.kernel.org/linux-iommu/20210310090614.26668-1-zhukeqian1@huawei.com/

changelog:

v3:
 - Merge start_dirty_log and stop_dirty_log into switch_dirty_log. (Yi Sun)
 - Maintain the dirty log status in iommu_domain.
 - Update commit message to make patch easier to review.

v2:
 - Address all comments of RFC version, thanks for all of you ;-)
 - Add a bugfix that start dirty log for newly added dma ranges and domain.



Hi everyone,

This patch series introduces a framework of iommu dirty log tracking, and smmuv3
realizes this framework. This new feature can be used by VFIO dma dirty tracking.

Intention：

Some types of IOMMU are capable of tracking DMA dirty log, such as
ARM SMMU with HTTU or Intel IOMMU with SLADE. This introduces the
dirty log tracking framework in the IOMMU base layer.

Three new essential interfaces are added, and we maintaince the status
of dirty log tracking in iommu_domain.
1. iommu_switch_dirty_log: Perform actions to start|stop dirty log tracking
2. iommu_sync_dirty_log: Sync dirty log from IOMMU into a dirty bitmap
3. iommu_clear_dirty_log: Clear dirty log of IOMMU by a mask bitmap

About SMMU HTTU:

HTTU (Hardware Translation Table Update) is a feature of ARM SMMUv3, it can update
access flag or/and dirty state of the TTD (Translation Table Descriptor) by hardware.
With HTTU, stage1 TTD is classified into 3 types:
                        DBM bit             AP[2](readonly bit)
1. writable_clean         1                       1
2. writable_dirty         1                       0
3. readonly               0                       1

If HTTU_HD (manage dirty state) is enabled, smmu can change TTD from writable_clean to
writable_dirty. Then software can scan TTD to sync dirty state into dirty bitmap. With
this feature, we can track the dirty log of DMA continuously and precisely.

About this series:

Patch 1-3：Introduce dirty log tracking framework in the IOMMU base layer, and two common
           interfaces that can be used by many types of iommu.

Patch 4-6: Add feature detection for smmu HTTU and enable HTTU for smmu stage1 mapping.
           And add feature detection for smmu BBML. We need to split block mapping when
           start dirty log tracking and merge page mapping when stop dirty log tracking,
		   which requires break-before-make procedure. But it might cause problems when the
		   TTD is alive. The I/O streams might not tolerate translation faults. So BBML
		   should be used.

Patch 7-12: We implement these interfaces for arm smmuv3.

Thanks,
Keqian

Jean-Philippe Brucker (1):
  iommu/arm-smmu-v3: Add support for Hardware Translation Table Update

Keqian Zhu (3):
  iommu: Introduce dirty log tracking framework
  iommu: Add iommu_split_block interface
  iommu: Add iommu_merge_page interface

Kunkun Jiang (8):
  iommu/arm-smmu-v3: Enable HTTU for stage1 with io-pgtable mapping
  iommu/arm-smmu-v3: Add feature detection for BBML
  iommu/arm-smmu-v3: Realize split_block iommu ops
  iommu/arm-smmu-v3: Realize merge_page iommu ops
  iommu/arm-smmu-v3: Realize switch_dirty_log iommu ops
  iommu/arm-smmu-v3: Realize sync_dirty_log iommu ops
  iommu/arm-smmu-v3: Realize clear_dirty_log iommu ops
  iommu/arm-smmu-v3: Add HWDBM device feature reporting

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 217 +++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  14 +
 drivers/iommu/io-pgtable-arm.c                | 392 +++++++++++++++++-
 drivers/iommu/iommu.c                         | 266 ++++++++++++
 include/linux/io-pgtable.h                    |  23 +
 include/linux/iommu.h                         |  76 ++++
 7 files changed, 988 insertions(+), 2 deletions(-)

-- 
2.19.1

