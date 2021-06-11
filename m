Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69AB3A41F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhFKM2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:28:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3212 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhFKM2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:28:18 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G1fzS1f28z6K5nT;
        Fri, 11 Jun 2021 20:19:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 11 Jun 2021 14:26:17 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 13:26:14 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v12 0/5] Enhance IOMMU default DMA mode build options
Date:   Fri, 11 Jun 2021 20:20:38 +0800
Message-ID: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a reboot of Zhen Lei's series from a couple of years ago, which
never made it across the line.

I still think that it has some value, so taking up the mantle.

Motivation:
Allow lazy mode be default mode for DMA domains for all ARCHs, and not
only those who hardcode it (to be lazy). For ARM64, currently we must use
a kernel command line parameter to use lazy mode, which is less than
ideal.

I have now included the print for strict/lazy mode, which I originally
sent in:
https://lore.kernel.org/linux-iommu/72eb3de9-1d1c-ae46-c5a9-95f26525d435@huawei.com/

There was some concern there about drivers and their custom prints
conflicting with the print in that patch, but I think that it
should be ok.

Difference to v11:
- Rebase to next-20210610
- Drop strict mode globals in Intel and AMD drivers
- Include patch to print strict vs lazy mode
- Include patch to remove argument from iommu_set_dma_strict()

Differences to v10:
- Rebase to v5.13-rc4
- Correct comment and typo in Kconfig (Randy)
- Make Kconfig choice depend on relevant architectures

Differences to v9:
https://lore.kernel.org/linux-iommu/20190613084240.16768-1-thunder.leizhen@huawei.com/#t
- Rebase to v5.13-rc2
- Remove CONFIG_IOMMU_DEFAULT_PASSTHROUGH from choice:
  Since we can dynamically change default domain of group, lazy or strict and
  passthrough are not mutually exclusive
- Drop ia64 patch, which I don't think was ever required
- Drop "x86/dma: use IS_ENABLED() to simplify the code", which is no
  longer required
- Drop s390/pci patch, as this arch does not use CONFIG_IOMMU_API or even
  already honour CONFIG_IOMMU_DEFAULT_PASSTHROUGH
  https://lore.kernel.org/linux-iommu/20190613084240.16768-4-thunder.leizhen@huawei.com/
- Drop powernv/iommu patch, as I no longer think that it is relevant
  https://lore.kernel.org/linux-iommu/20190613084240.16768-5-thunder.leizhen@huawei.com/
- Some tidying

John Garry (2):
  iommu: Print strict or lazy mode at init time
  iommu: Remove mode argument from iommu_set_dma_strict()

Zhen Lei (3):
  iommu: Enhance IOMMU default DMA mode build options
  iommu/vt-d: Add support for IOMMU default DMA mode build options
  iommu/amd: Add support for IOMMU default DMA mode build options

 drivers/iommu/Kconfig               | 39 +++++++++++++++++++++++++++++
 drivers/iommu/amd/amd_iommu_types.h |  6 -----
 drivers/iommu/amd/init.c            |  3 +--
 drivers/iommu/amd/iommu.c           |  6 -----
 drivers/iommu/intel/iommu.c         | 15 +++++------
 drivers/iommu/iommu.c               | 13 +++++++---
 include/linux/iommu.h               |  2 +-
 7 files changed, 56 insertions(+), 28 deletions(-)

-- 
2.26.2

