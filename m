Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D53E3E9095
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbhHKMXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:23:08 -0400
Received: from foss.arm.com ([217.140.110.172]:48958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237775AbhHKMWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:22:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4615E139F;
        Wed, 11 Aug 2021 05:22:27 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B6CD3F718;
        Wed, 11 Aug 2021 05:22:25 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com
Subject: [PATCH v4 18/24] iommu/arm-smmu: Prepare for multiple DMA domain types
Date:   Wed, 11 Aug 2021 13:21:32 +0100
Message-Id: <8f217ef285bd0bb9456c27ef622d2efdbbca1ad8.1628682049.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1628682048.git.robin.murphy@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for the strict vs. non-strict decision for DMA domains to
be expressed in the domain type, make sure we expose our flush queue
awareness by accepting the new domain type.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d9c93d8d193d..883a99cb10c1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1972,6 +1972,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
 	    type != IOMMU_DOMAIN_DMA &&
+	    type != IOMMU_DOMAIN_DMA_FQ &&
 	    type != IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index a325d4769c17..1d013b1d7bb2 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -866,7 +866,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	struct arm_smmu_domain *smmu_domain;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_IDENTITY) {
-		if (using_legacy_binding || type != IOMMU_DOMAIN_DMA)
+		if (using_legacy_binding ||
+		    (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_DMA_FQ))
 			return NULL;
 	}
 	/*
-- 
2.25.1

