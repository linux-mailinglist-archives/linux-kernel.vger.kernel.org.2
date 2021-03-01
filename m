Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30884327E16
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhCAMR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:17:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13400 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhCAMRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:17:23 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dpzjb5ng1zjSsg;
        Mon,  1 Mar 2021 20:15:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 20:16:28 +0800
From:   John Garry <john.garry@huawei.com>
To:     <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/3] iommu/iova: Add CPU hotplug handler to flush rcaches to core code
Date:   Mon, 1 Mar 2021 20:12:18 +0800
Message-ID: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
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

Also correct a code comment.

Based on v5.12-rc1. Tested on arm64 only.

John Garry (3):
  iova: Add CPU hotplug handler to flush rcaches
  iommu/vt-d: Remove IOVA domain rcache flushing for CPU offlining
  iova: Correct comment for free_cpu_cached_iovas()

 drivers/iommu/intel/iommu.c | 31 -------------------------------
 drivers/iommu/iova.c        | 32 ++++++++++++++++++++++++++++++--
 include/linux/cpuhotplug.h  |  2 +-
 include/linux/iova.h        |  1 +
 4 files changed, 32 insertions(+), 34 deletions(-)

-- 
2.26.2

