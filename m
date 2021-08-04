Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D9F3E0693
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbhHDRRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:17:15 -0400
Received: from foss.arm.com ([217.140.110.172]:35156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239955AbhHDRQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:16:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AF4911FB;
        Wed,  4 Aug 2021 10:16:44 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A49B3F66F;
        Wed,  4 Aug 2021 10:16:42 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com
Subject: [PATCH v3 17/25] iommu/amd: Prepare for multiple DMA domain types
Date:   Wed,  4 Aug 2021 18:15:45 +0100
Message-Id: <51e020d80bfc7b2dcc90f78fad93faa697644723.1628094601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628094600.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA ops reset/setup can simply be unconditional, since
iommu-dma already knows only to touch DMA domains.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/iommu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 92f7cbe3d14a..f8cd945f1776 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1706,14 +1706,9 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 
 static void amd_iommu_probe_finalize(struct device *dev)
 {
-	struct iommu_domain *domain;
-
 	/* Domains are initialized for this device - have a look what we ended up with */
-	domain = iommu_get_domain_for_dev(dev);
-	if (domain->type == IOMMU_DOMAIN_DMA)
-		iommu_setup_dma_ops(dev, 0, U64_MAX);
-	else
-		set_dma_ops(dev, NULL);
+	set_dma_ops(dev, NULL);
+	iommu_setup_dma_ops(dev, 0, U64_MAX);
 }
 
 static void amd_iommu_release_device(struct device *dev)
-- 
2.25.1

