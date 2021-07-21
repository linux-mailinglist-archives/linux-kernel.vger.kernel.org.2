Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296273D1635
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 20:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhGURk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:40:29 -0400
Received: from foss.arm.com ([217.140.110.172]:33214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232456AbhGURkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:40:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4174113E;
        Wed, 21 Jul 2021 11:20:55 -0700 (PDT)
Received: from 010265703453.arm.com (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DC4E3F694;
        Wed, 21 Jul 2021 11:20:54 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: [PATCH 06/23] iommu/ipmmu-vmsa: Drop IOVA cookie management
Date:   Wed, 21 Jul 2021 19:20:17 +0100
Message-Id: <1ca98c5c7ce4e6daf27803adc6f4b362362ce651.1626888444.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1626888444.git.robin.murphy@arm.com>
References: <cover.1626888444.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core code bakes its own cookies now.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/ipmmu-vmsa.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 51ea6f00db2f..31252268f0d0 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -564,10 +564,13 @@ static irqreturn_t ipmmu_irq(int irq, void *dev)
  * IOMMU Operations
  */
 
-static struct iommu_domain *__ipmmu_domain_alloc(unsigned type)
+static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
 {
 	struct ipmmu_vmsa_domain *domain;
 
+	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
+		return NULL;
+
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
@@ -577,27 +580,6 @@ static struct iommu_domain *__ipmmu_domain_alloc(unsigned type)
 	return &domain->io_domain;
 }
 
-static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
-{
-	struct iommu_domain *io_domain = NULL;
-
-	switch (type) {
-	case IOMMU_DOMAIN_UNMANAGED:
-		io_domain = __ipmmu_domain_alloc(type);
-		break;
-
-	case IOMMU_DOMAIN_DMA:
-		io_domain = __ipmmu_domain_alloc(type);
-		if (io_domain && iommu_get_dma_cookie(io_domain)) {
-			kfree(io_domain);
-			io_domain = NULL;
-		}
-		break;
-	}
-
-	return io_domain;
-}
-
 static void ipmmu_domain_free(struct iommu_domain *io_domain)
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
@@ -606,7 +588,6 @@ static void ipmmu_domain_free(struct iommu_domain *io_domain)
 	 * Free the domain resources. We assume that all devices have already
 	 * been detached.
 	 */
-	iommu_put_dma_cookie(io_domain);
 	ipmmu_domain_destroy_context(domain);
 	free_io_pgtable_ops(domain->iop);
 	kfree(domain);
-- 
2.25.1

