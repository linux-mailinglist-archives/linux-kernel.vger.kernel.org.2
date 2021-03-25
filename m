Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1C349217
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhCYMe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:34:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14536 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCYMeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:34:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F5kxW07yFzPlr5;
        Thu, 25 Mar 2021 20:31:43 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 20:34:07 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <dwmw2@infradead.org>,
        <baolu.lu@linux.intel.com>, <robin.murphy@arm.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/4] iommu/iova: Add CPU hotplug handler to flush rcaches to core code
Date:   Thu, 25 Mar 2021 20:29:57 +0800
Message-ID: <1616675401-151997-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel IOMMU driver supports flushing the per-CPU rcaches when a CPU is
offlined.

Let's move it to core code, so everyone can take advantage.

Also throw in a patch to stop exporting free_iova_fast().

Differences to v1:
- Add RB tags (thanks!)
- Add patch to stop exporting free_iova_fast()
- Drop patch to correct comment
- Add patch to delete iommu_dma_free_cpu_cached_iovas() and associated
  changes

John Garry (4):
  iova: Add CPU hotplug handler to flush rcaches
  iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
  iommu: Delete iommu_dma_free_cpu_cached_iovas()
  iommu: Stop exporting free_iova_fast()

 drivers/iommu/dma-iommu.c   |  9 ---------
 drivers/iommu/intel/iommu.c | 31 -------------------------------
 drivers/iommu/iova.c        | 34 +++++++++++++++++++++++++++++++---
 include/linux/cpuhotplug.h  |  2 +-
 include/linux/dma-iommu.h   |  8 --------
 include/linux/iova.h        |  6 +-----
 6 files changed, 33 insertions(+), 57 deletions(-)

-- 
2.26.2

