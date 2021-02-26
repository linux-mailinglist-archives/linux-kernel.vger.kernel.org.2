Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C713263C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhBZOHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:07:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:55054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230105AbhBZOFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:05:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D637FB077;
        Fri, 26 Feb 2021 14:03:21 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, robh+dt@kernel.org, robin.murphy@arm.com,
        ardb@kernel.org, hch@infradead.org, narmstrong@baylibre.com,
        dwmw2@infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [RFC 09/13] iommu/arm-smmu: Make use of dev_64bit_mmio_supported()
Date:   Fri, 26 Feb 2021 15:03:01 +0100
Message-Id: <20210226140305.26356-10-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226140305.26356-1-nsaenzjulienne@suse.de>
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some arm SMMU implementations might sit on a bus that doesn't support
64bit memory accesses. In that case default to using hi_lo_{readq,
writeq}() and BUG if such platform tries to use AArch64 formats as they
rely on writeq()'s atomicity.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.h | 9 +++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index d8c6bfde6a61..239ff42b20c3 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1889,6 +1889,15 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_64K;
 	}
 
+	/*
+	 * 64bit accesses not possible through the interconnect, AArch64
+	 * formats depend on it.
+	 */
+	BUG_ON(!dev_64bit_mmio_supported(smmu->dev) &&
+	       smmu->features & (ARM_SMMU_FEAT_FMT_AARCH64_4K |
+				ARM_SMMU_FEAT_FMT_AARCH64_16K |
+				ARM_SMMU_FEAT_FMT_AARCH64_64K));
+
 	if (smmu->impl && smmu->impl->cfg_probe) {
 		ret = smmu->impl->cfg_probe(smmu);
 		if (ret)
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index d2a2d1bc58ba..997d13a21717 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -477,15 +477,20 @@ static inline void arm_smmu_writel(struct arm_smmu_device *smmu, int page,
 {
 	if (smmu->impl && unlikely(smmu->impl->write_reg))
 		smmu->impl->write_reg(smmu, page, offset, val);
-	else
+	else if (dev_64bit_mmio_supported(smmu->dev))
 		writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
+	else
+		hi_lo_writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
 }
 
 static inline u64 arm_smmu_readq(struct arm_smmu_device *smmu, int page, int offset)
 {
 	if (smmu->impl && unlikely(smmu->impl->read_reg64))
 		return smmu->impl->read_reg64(smmu, page, offset);
-	return readq_relaxed(arm_smmu_page(smmu, page) + offset);
+	else if (dev_64bit_mmio_supported(smmu->dev))
+		return readq_relaxed(arm_smmu_page(smmu, page) + offset);
+	else
+		return hi_lo_readq_relaxed(arm_smmu_page(smmu, page) + offset);
 }
 
 static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
-- 
2.30.1

