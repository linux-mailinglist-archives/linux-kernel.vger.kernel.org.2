Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D097453CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhKPXTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:19:07 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:34675 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbhKPXTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637104568; x=1668640568;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=d1o1kmUayTCh9YPbMfls/1kauYNh2nzD2RfQOEq2JzI=;
  b=DwVlmjZD3Lgcsii+jq9LhiC7EBHgvw7tS/H0PU1rB64F+HPgx43ImkZ0
   PGUogPjh3S3g78HXeuWsXP80j9WQ5rXMIbqVORLTajURw0rf1svhBvgwM
   SakZAfol2NrNKw1QpYG3mg3ElnBowVRQQZ3FT22lv13fpLPvpk2IjMfcA
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Nov 2021 15:16:08 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 15:16:08 -0800
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 16 Nov 2021 15:16:08 -0800
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robdclark@gmail.com>
CC:     <sean@poorly.run>, <robin.murphy@arm.com>, <maz@kernel.org>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
Subject: [RFC 1/2] arm64: Add support for system cache memory type
Date:   Tue, 16 Nov 2021 15:15:59 -0800
Message-ID: <1637104560-37432-1-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Isaac J. Manjarres" <isaacm@codeaurora.org>

Non-coherent devices on systems that support a system or
last level cache may want to request that allocations be
cached in the system cache. For memory that is allocated
by the kernel, and used for DMA with devices, the memory
attributes used for CPU access should match the memory
attributes that will be used for device access.

The memory attributes that need to be programmed into
the MAIR for system cache usage are:

0xf4 - Normal memory, outer write back read/write allocate,
inner non-cacheable.

There is currently no support for this memory attribute for
CPU mappings, so add it.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 arch/arm64/include/asm/memory.h  | 1 +
 arch/arm64/include/asm/pgtable.h | 9 +++++++++
 arch/arm64/include/asm/sysreg.h  | 1 +
 arch/arm64/mm/proc.S             | 3 ++-
 include/linux/dma-map-ops.h      | 8 ++++++++
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0af70d9abede..22553aab67a4 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -134,6 +134,7 @@
 #define MT_NORMAL_NC		2
 #define MT_DEVICE_nGnRnE	3
 #define MT_DEVICE_nGnRE		4
+#define MT_NORMAL_iNC_oWB	5
 
 /*
  * Memory types for Stage-2 translation
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c4ba047a82d2..681c294c364e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -524,6 +524,15 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 	__pgprot_modify(prot, PTE_ATTRINDX_MASK, \
 			PTE_ATTRINDX(MT_NORMAL_NC) | PTE_PXN | PTE_UXN)
 
+/*
+ * Mark the prot value as outer cacheable and inner non-cacheable. Non-coherent
+ * devices on a system with support for a system or last level cache use these
+ * attributes to cache allocations in the system cache.
+ */
+#define pgprot_syscached(prot) \
+	__pgprot_modify(prot, PTE_ATTRINDX_MASK, \
+			PTE_ATTRINDX(MT_NORMAL_iNC_oWB) | PTE_PXN | PTE_UXN)
+
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 struct file;
 extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 16b3f1a1d468..7c50b1840532 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -715,6 +715,7 @@
 #define MAIR_ATTR_NORMAL_TAGGED		UL(0xf0)
 #define MAIR_ATTR_NORMAL		UL(0xff)
 #define MAIR_ATTR_MASK			UL(0xff)
+#define MAIR_ATTR_NORMAL_iNC_oWB	UL(0xf4)
 
 /* Position the attr at the correct index */
 #define MAIR_ATTRIDX(attr, idx)		((attr) << ((idx) * 8))
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index d35c90d2e47a..8a75973e5148 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -64,7 +64,8 @@
 	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
 	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
 	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_iNC_oWB, MT_NORMAL_iNC_oWB))
 
 #ifdef CONFIG_CPU_PM
 /**
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d5b06b3a4a6..1f7d75201577 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -277,6 +277,14 @@ void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 #define pgprot_dmacoherent(prot)	pgprot_noncached(prot)
 #endif
 
+/*
+ * If there is no system cache pgprot, then fallback to dmacoherent
+ * pgprot, as the expectation is that the device is not coherent.
+ */
+#ifndef pgprot_syscached
+#define pgprot_syscached(prot)		pgprot_dmacoherent(prot)
+#endif
+
 pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs);
 #else
 static inline pgprot_t dma_pgprot(struct device *dev, pgprot_t prot,
