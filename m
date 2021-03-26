Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61DA34A1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCZGZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:25:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14554 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCZGZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:25:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6Bjc0gCrzNqRh;
        Fri, 26 Mar 2021 14:23:00 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:25:26 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/8] iommu: fix a couple of spelling mistakes detected by codespell tool
Date:   Fri, 26 Mar 2021 14:24:04 +0800
Message-ID: <20210326062412.1262-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This detection and correction covers the entire driver/iommu directory.

Zhen Lei (8):
  iommu/pamu: fix a couple of spelling mistakes
  iommu/omap: Fix spelling mistake "alignement" -> "alignment"
  iommu/mediatek: Fix spelling mistake "phyiscal" -> "physical"
  iommu/sun50i: Fix spelling mistake "consits" -> "consists"
  iommu: fix a couple of spelling mistakes
  iommu/amd: fix a couple of spelling mistakes
  iommu/arm-smmu: Fix spelling mistake "initally" -> "initially"
  iommu/vt-d: fix a couple of spelling mistakes

 drivers/iommu/amd/amd_iommu_types.h   | 2 +-
 drivers/iommu/amd/init.c              | 4 ++--
 drivers/iommu/amd/iommu.c             | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 2 +-
 drivers/iommu/fsl_pamu.c              | 2 +-
 drivers/iommu/fsl_pamu_domain.c       | 2 +-
 drivers/iommu/fsl_pamu_domain.h       | 2 +-
 drivers/iommu/intel/dmar.c            | 6 +++---
 drivers/iommu/intel/iommu.c           | 2 +-
 drivers/iommu/intel/irq_remapping.c   | 2 +-
 drivers/iommu/iommu.c                 | 4 ++--
 drivers/iommu/iova.c                  | 2 +-
 drivers/iommu/mtk_iommu.c             | 2 +-
 drivers/iommu/omap-iommu.c            | 2 +-
 drivers/iommu/sun50i-iommu.c          | 2 +-
 15 files changed, 19 insertions(+), 19 deletions(-)

-- 
1.8.3


