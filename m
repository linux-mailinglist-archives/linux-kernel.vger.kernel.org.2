Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A693C8312
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbhGNKop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:44:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3393 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhGNKoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:44:44 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GPv0g1PY3z6L80r;
        Wed, 14 Jul 2021 18:30:43 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 12:41:51 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 11:41:46 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>
CC:     <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <thierry.reding@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <jonathanh@nvidia.com>, <sakari.ailus@linux.intel.com>,
        <bingbu.cao@intel.com>, <tian.shu.qiu@intel.com>,
        <mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
        <digetx@gmail.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>, <chenxiang66@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v4 0/6] iommu: Allow IOVA rcache range be configured
Date:   Wed, 14 Jul 2021 18:36:37 +0800
Message-ID: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
exceeds the IOVA rcache upper limit (meaning that they are not cached),
performance can be reduced. 

This may be much more pronounced from commit 4e89dce72521 ("iommu/iova:
Retry from last rb tree node if iova search fails"), as discussed at [0].

IOVAs which cannot be cached are highly involved in the IOVA ageing issue,
as discussed at [1].

This series allows the IOVA rcache range be configured, so that we may
cache all IOVAs per domain, thus improving performance.

A new IOMMU group sysfs file is added - max_opt_dma_size - which is used
indirectly to configure the IOVA rcache range:
/sys/kernel/iommu_groups/X/max_opt_dma_size

This file is updated same as how the IOMMU group default domain type is
updated, i.e. must unbind the only device in the group first.

The inspiration here comes from block layer request queue sysfs
"optimal_io_size" file, in /sys/block/sdX/queue/optimal_io_size

Some figures for storage scenario (when increasing IOVA rcache range to
cover all DMA mapping sizes from the LLD):
v5.13-rc1 baseline:			1200K IOPS
With series:				1800K IOPS

All above are for IOMMU strict mode. Non-strict mode gives ~1800K IOPS in
all scenarios.

[0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
[1] https://lore.kernel.org/linux-iommu/1607538189-237944-1-git-send-email-john.garry@huawei.com/

Note that I cc'ed maintainers/reviewers only for the changes associated
with patch #5 since it just touches their code in only a minor way.

John Garry (6):
  iommu: Refactor iommu_group_store_type()
  iova: Allow rcache range upper limit to be flexible
  iommu: Allow iommu_change_dev_def_domain() realloc default domain for
    same type
  iommu: Allow max opt DMA len be set for a group via sysfs
  iova: Add iova_len argument to init_iova_domain()
  dma-iommu: Pass iova len for IOVA domain init

 .../ABI/testing/sysfs-kernel-iommu_groups     |  16 ++
 drivers/gpu/drm/tegra/drm.c                   |   2 +-
 drivers/gpu/host1x/dev.c                      |   2 +-
 drivers/iommu/dma-iommu.c                     |  15 +-
 drivers/iommu/iommu.c                         | 172 ++++++++++++------
 drivers/iommu/iova.c                          |  39 +++-
 drivers/staging/media/ipu3/ipu3-dmamap.c      |   2 +-
 drivers/staging/media/tegra-vde/iommu.c       |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c              |   2 +-
 include/linux/iommu.h                         |   6 +
 include/linux/iova.h                          |   9 +-
 11 files changed, 194 insertions(+), 73 deletions(-)

-- 
2.26.2

