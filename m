Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2593D1630
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhGURkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:40:12 -0400
Received: from foss.arm.com ([217.140.110.172]:33114 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231192AbhGURkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:40:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F2F4113E;
        Wed, 21 Jul 2021 11:20:47 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CAE33F694;
        Wed, 21 Jul 2021 11:20:45 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH 01/23] iommu: Pull IOVA cookie management into the core
Date:   Wed, 21 Jul 2021 19:20:12 +0100
Message-Id: <86f8bd2a3e78766b60270d70490f0275706b7525.1626888444.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
References: <cover.1626888444.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that everyone has converged on iommu-dma for IOMMU_DOMAIN_DMA
support, we can abandon the notion of drivers being responsible for the
cookie type, and consolidate all the management into the core code.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 7 +++++++
 include/linux/iommu.h | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5419c4b9f27a..0952de57c466 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt)    "iommu: " fmt
 
 #include <linux/device.h>
+#include <linux/dma-iommu.h>
 #include <linux/kernel.h>
 #include <linux/bug.h>
 #include <linux/types.h>
@@ -1941,6 +1942,11 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
 	/* Assume all sizes by default; the driver may override this later */
 	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
 
+	/* Temporarily ignore -EEXIST while drivers still get their own cookies */
+	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain) == -ENOMEM) {
+		iommu_domain_free(domain);
+		domain = NULL;
+	}
 	return domain;
 }
 
@@ -1952,6 +1958,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
+	iommu_put_dma_cookie(domain);
 	domain->ops->domain_free(domain);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..007662b65474 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -40,6 +40,7 @@ struct iommu_domain;
 struct notifier_block;
 struct iommu_sva;
 struct iommu_fault_event;
+struct iommu_dma_cookie;
 
 /* iommu fault flags */
 #define IOMMU_FAULT_READ	0x0
@@ -86,7 +87,7 @@ struct iommu_domain {
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
-	void *iova_cookie;
+	struct iommu_dma_cookie *iova_cookie;
 };
 
 enum iommu_cap {
-- 
2.25.1

