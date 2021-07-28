Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8C33D92A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhG1QAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:00:22 -0400
Received: from foss.arm.com ([217.140.110.172]:59632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237492AbhG1P7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:59:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC1F41424;
        Wed, 28 Jul 2021 08:59:48 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6669C3F70D;
        Wed, 28 Jul 2021 08:59:47 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH v2 24/24] iommu: Only log strictness for DMA domains
Date:   Wed, 28 Jul 2021 16:58:45 +0100
Message-Id: <b2da9ba999b54acded9198cf92cf9b7d0fce1b45.1627468310.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
References: <cover.1627468308.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When passthrough is enabled, the default strictness policy becomes
irrelevant, since any subsequent runtime override to a DMA domain type
now embodies an explicit choice of strictness as well. Save on noise by
only logging the default policy when it is meaningfully in effect.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index be399d630953..87d7b299436e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -144,10 +144,11 @@ static int __init iommu_subsys_init(void)
 		(iommu_cmd_line & IOMMU_CMD_LINE_DMA_API) ?
 			"(set via kernel command line)" : "");
 
-	pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
-		iommu_dma_strict ? "strict" : "lazy",
-		(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
-			"(set via kernel command line)" : "");
+	if (!iommu_default_passthrough())
+		pr_info("DMA domain TLB invalidation policy: %s mode %s\n",
+			iommu_dma_strict ? "strict" : "lazy",
+			(iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
+				"(set via kernel command line)" : "");
 
 	return 0;
 }
-- 
2.25.1

