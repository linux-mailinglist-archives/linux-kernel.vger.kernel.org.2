Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E2A39A2B3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhFCOE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:04:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3142 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhFCOEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:04:55 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FwnNK2l4Sz6M4c0;
        Thu,  3 Jun 2021 21:50:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 16:03:09 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 15:03:06 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linuxarm@huawei.com>, <thunder.leizhen@huawei.com>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v10 0/3] Enhance IOMMU default DMA mode build options
Date:   Thu, 3 Jun 2021 21:58:32 +0800
Message-ID: <1622728715-209296-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Zhen Lei (3):
  iommu: Enhance IOMMU default DMA mode build options
  iommu/vt-d: Add support for IOMMU default DMA mode build options
  iommu/amd: Add support for IOMMU default DMA mode build options

 drivers/iommu/Kconfig       | 35 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/init.c    |  3 ++-
 drivers/iommu/intel/iommu.c |  2 +-
 drivers/iommu/iommu.c       |  3 ++-
 4 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.26.2

