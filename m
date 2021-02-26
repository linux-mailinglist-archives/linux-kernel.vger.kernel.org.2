Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ED73263C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhBZOHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:07:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:55052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhBZOFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:05:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8613FB03F;
        Fri, 26 Feb 2021 14:03:22 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        ardb@kernel.org, hch@infradead.org, narmstrong@baylibre.com,
        dwmw2@infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 10/13] iommu/arm-smmu-impl: Get rid of Marvell's implementation details
Date:   Fri, 26 Feb 2021 15:03:02 +0100
Message-Id: <20210226140305.26356-11-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226140305.26356-1-nsaenzjulienne@suse.de>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm-smmu can now deal with integrations on buses that don't support
64bit MMIO accesses. No need to create a special case for that on
Marvell's integration.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
index 136872e77195..55d40e37e144 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-impl.c
@@ -145,25 +145,6 @@ static const struct arm_smmu_impl arm_mmu500_impl = {
 	.reset = arm_mmu500_reset,
 };
 
-static u64 mrvl_mmu500_readq(struct arm_smmu_device *smmu, int page, int off)
-{
-	/*
-	 * Marvell Armada-AP806 erratum #582743.
-	 * Split all the readq to double readl
-	 */
-	return hi_lo_readq_relaxed(arm_smmu_page(smmu, page) + off);
-}
-
-static void mrvl_mmu500_writeq(struct arm_smmu_device *smmu, int page, int off,
-			       u64 val)
-{
-	/*
-	 * Marvell Armada-AP806 erratum #582743.
-	 * Split all the writeq to double writel
-	 */
-	hi_lo_writeq_relaxed(val, arm_smmu_page(smmu, page) + off);
-}
-
 static int mrvl_mmu500_cfg_probe(struct arm_smmu_device *smmu)
 {
 
@@ -181,8 +162,6 @@ static int mrvl_mmu500_cfg_probe(struct arm_smmu_device *smmu)
 }
 
 static const struct arm_smmu_impl mrvl_mmu500_impl = {
-	.read_reg64 = mrvl_mmu500_readq,
-	.write_reg64 = mrvl_mmu500_writeq,
 	.cfg_probe = mrvl_mmu500_cfg_probe,
 	.reset = arm_mmu500_reset,
 };
-- 
2.30.1

