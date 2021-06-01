Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BBC397577
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhFAOfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:35:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3111 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhFAOfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:35:52 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvZ976ssJz6M4NR;
        Tue,  1 Jun 2021 22:21:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:34:09 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:34:06 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 0/7] iommu: Allow IOVA rcache range be configured
Date:   Tue, 1 Jun 2021 22:29:34 +0800
Message-ID: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
exceeds the IOVA rcache upper limit (meaning that they are not cached),
performance can be reduced. 

This is much more pronounced from commit 4e89dce72521 ("iommu/iova: Retry
from last rb tree node if iova search fails"), as discussed at [0].

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

Differences to v2:
- Drop DMA mapping API to allow LLD set set for now
- Update default domain immediately, instead of in reprobe
- Fix build warning

Differences to v1:
- Many
- Change method to not operate on a 'live' IOMMU domain:
	- rather, force device driver to be re-probed once
	  dma_max_opt_size is set, and reconfig a new IOMMU group then
- Add iommu sysfs max_dma_opt_size file, and allow updating same as how
  group type is changed 

John Garry (7):
  iommu: Reactor iommu_group_store_type()
  iova: Allow rcache range upper limit to be flexible
  iommu: Allow iommu_change_dev_def_domain() realloc default domain for
    same type
  iova: Add iova_domain_len_is_cached()
  iova: Add init_iova_domain_ext()
  iommu: Allow max opt DMA len be set for a group via sysfs
  dma-iommu: Use init_iova_domain_ext() for IOVA domain init

 drivers/iommu/dma-iommu.c |  17 +++-
 drivers/iommu/iommu.c     | 172 ++++++++++++++++++++++++++------------
 drivers/iommu/iova.c      |  63 +++++++++++---
 include/linux/iommu.h     |   6 ++
 include/linux/iova.h      |  21 ++++-
 5 files changed, 210 insertions(+), 69 deletions(-)

-- 
2.26.2

