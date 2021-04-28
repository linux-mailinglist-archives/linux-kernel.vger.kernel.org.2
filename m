Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1137436D68B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbhD1LeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239223AbhD1LeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:34:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7695D61040;
        Wed, 28 Apr 2021 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619609611;
        bh=Ax2RvtKbZ6w8E++eL3TS0FdOpT4rci94b/HZ3yKg+hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntjK+GHUBdt1OFw8I2/zy8gKQXjHi+hAdwMRbdDkR6vPUJgwX7HMNNs49sPOHI7Z+
         OB4VjzZg4dEV31LvFixu0XR0Tq2OinVATJxpp7AvzdTegX5VOpaOkY1PMd7o1AweQi
         gmszRtt8GRKUFHRgm3j2zbYh74Qmg3IYiCPdwJg8m1e4dQlZJdezZ42t/2TsaQY+Mi
         ma3FX9EN35Vz/5T9VAWhLOneBU94Zo272/y8yK8uazIat81Jv/dCpF08L1rm16sd5e
         6DyNW52p6CxX6ipI0pxoTqJ2ZNMIEbi7lZMpmYH/Yutt4zO6wp3hpYef+UE/MGCCPb
         NcbgkMqh33vsA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 3/5] habanalabs: expose ASIC specific PCI info to common code
Date:   Wed, 28 Apr 2021 14:33:21 +0300
Message-Id: <20210428113323.17222-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428113323.17222-1-ogabbay@kernel.org>
References: <20210428113323.17222-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

LKD has interfaces in which it receives device address.
For instance the debugfs_read/write variants receives device address for
CFG/SRAM/DRAM for read/write and need to translate to the mapped PCI BAR
address.

In addition, the dynamic FW load protocol dictates that the address to
which the LKD will copy the image for the next FW component will be
received as a device address and can be placed either in SRAM or DRAM.

We need to distinguish those regions as the access methods to those
regions are different (in DRAM we possibly need to set the BAR base).

Looking forward this code will be used to remove duplicated code in the
debugfs_read/write that search the memory region for the input device
address.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 28 +++++++++++++++
 drivers/misc/habanalabs/common/pci/pci.c    | 26 ++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 39 +++++++++++++++++++++
 drivers/misc/habanalabs/goya/goya.c         | 31 ++++++++++++++++
 4 files changed, 124 insertions(+)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 5df971e5c108..fff282774739 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -818,6 +818,30 @@ enum div_select_defs {
 	DIV_SEL_DIVIDED_PLL = 3,
 };
 
+enum pci_region {
+	PCI_REGION_CFG,
+	PCI_REGION_SRAM,
+	PCI_REGION_DRAM,
+	PCI_REGION_SP_SRAM,
+	PCI_REGION_NUMBER,
+};
+
+/**
+ * struct pci_mem_region - describe memory region in a PCI bar
+ * @region_base: region base address
+ * @region_size: region size
+ * @offset_in_bar: region offset into the bar
+ * @bar_id: bar ID of the region
+ * @used: if used 1, otherwise 0
+ */
+struct pci_mem_region {
+	u64 region_base;
+	u64 region_size;
+	u32 offset_in_bar;
+	u8 bar_id;
+	u8 used;
+};
+
 /**
  * struct static_fw_load_mgr - static FW load manager
  * @preboot_version_max_off: max offset to preboot version
@@ -2014,6 +2038,7 @@ struct hl_mmu_funcs {
  * @mmu_priv: device-specific MMU data.
  * @mmu_func: device-related MMU functions.
  * @fw_loader: FW loader manager.
+ * @pci_mem_region: array of memory regions in the PCI
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -2135,6 +2160,8 @@ struct hl_device {
 
 	struct fw_load_mgr		fw_loader;
 
+	struct pci_mem_region		pci_mem_region[PCI_REGION_NUMBER];
+
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
@@ -2467,6 +2494,7 @@ int hl_pci_set_inbound_region(struct hl_device *hdev, u8 region,
 		struct hl_inbound_pci_region *pci_region);
 int hl_pci_set_outbound_region(struct hl_device *hdev,
 		struct hl_outbound_pci_region *pci_region);
+enum pci_region hl_get_pci_memory_region(struct hl_device *hdev, u64 addr);
 int hl_pci_init(struct hl_device *hdev);
 void hl_pci_fini(struct hl_device *hdev);
 
diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index 5d07ca53d9ce..9ef6c46a3146 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -359,6 +359,32 @@ int hl_pci_set_outbound_region(struct hl_device *hdev,
 	return rc;
 }
 
+/**
+ * hl_get_pci_memory_region() - get PCI region for given address
+ * @hdev: Pointer to hl_device structure.
+ * @addr: device address
+ *
+ * @return region index on success, otherwise PCI_REGION_NUMBER (invalid
+ *         region index)
+ */
+enum pci_region hl_get_pci_memory_region(struct hl_device *hdev, u64 addr)
+{
+	int i;
+
+	for  (i = 0 ; i < PCI_REGION_NUMBER ; i++) {
+		struct pci_mem_region *region = &hdev->pci_mem_region[i];
+
+		if (!region->used)
+			continue;
+
+		if ((addr >= region->region_base) &&
+			(addr < region->region_base + region->region_size))
+			return i;
+	}
+
+	return PCI_REGION_NUMBER;
+}
+
 /**
  * hl_pci_init() - PCI initialization code.
  * @hdev: Pointer to hl_device structure.
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 84c42868e7fd..0b03c6946748 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1590,6 +1590,43 @@ static int gaudi_alloc_internal_qmans_pq_mem(struct hl_device *hdev)
 	return rc;
 }
 
+static void gaudi_set_pci_memory_regions(struct hl_device *hdev)
+{
+	struct pci_mem_region *region;
+
+	/* CFG */
+	region = &hdev->pci_mem_region[PCI_REGION_CFG];
+	region->region_base = CFG_BASE;
+	region->region_size = CFG_SIZE;
+	region->offset_in_bar = CFG_BASE - SPI_FLASH_BASE_ADDR;
+	region->bar_id = CFG_BAR_ID;
+	region->used = 1;
+
+	/* SRAM */
+	region = &hdev->pci_mem_region[PCI_REGION_SRAM];
+	region->region_base = SRAM_BASE_ADDR;
+	region->region_size = SRAM_SIZE;
+	region->offset_in_bar = 0;
+	region->bar_id = SRAM_BAR_ID;
+	region->used = 1;
+
+	/* DRAM */
+	region = &hdev->pci_mem_region[PCI_REGION_DRAM];
+	region->region_base = DRAM_PHYS_BASE;
+	region->region_size = hdev->asic_prop.dram_size;
+	region->offset_in_bar = 0;
+	region->bar_id = HBM_BAR_ID;
+	region->used = 1;
+
+	/* SP SRAM */
+	region = &hdev->pci_mem_region[PCI_REGION_SP_SRAM];
+	region->region_base = PSOC_SCRATCHPAD_ADDR;
+	region->region_size = PSOC_SCRATCHPAD_SIZE;
+	region->offset_in_bar = PSOC_SCRATCHPAD_ADDR - SPI_FLASH_BASE_ADDR;
+	region->bar_id = CFG_BAR_ID;
+	region->used = 1;
+}
+
 static int gaudi_sw_init(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi;
@@ -1664,6 +1701,8 @@ static int gaudi_sw_init(struct hl_device *hdev)
 	hdev->supports_coresight = true;
 	hdev->supports_staged_submission = true;
 
+	gaudi_set_pci_memory_regions(hdev);
+
 	return 0;
 
 free_cpu_accessible_dma_pool:
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index dc5659340220..c3a241227fe0 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -849,6 +849,35 @@ void goya_late_fini(struct hl_device *hdev)
 	hdev->hl_chip_info->info = NULL;
 }
 
+static void goya_set_pci_memory_regions(struct hl_device *hdev)
+{
+	struct pci_mem_region *region;
+
+	/* CFG */
+	region = &hdev->pci_mem_region[PCI_REGION_CFG];
+	region->region_base = CFG_BASE;
+	region->region_size = CFG_SIZE;
+	region->offset_in_bar = CFG_BASE - SRAM_BASE_ADDR;
+	region->bar_id = SRAM_CFG_BAR_ID;
+	region->used = 1;
+
+	/* SRAM */
+	region = &hdev->pci_mem_region[PCI_REGION_SRAM];
+	region->region_base = SRAM_BASE_ADDR;
+	region->region_size = SRAM_SIZE;
+	region->offset_in_bar = 0;
+	region->bar_id = SRAM_CFG_BAR_ID;
+	region->used = 1;
+
+	/* DRAM */
+	region = &hdev->pci_mem_region[PCI_REGION_DRAM];
+	region->region_base = DRAM_PHYS_BASE;
+	region->region_size = hdev->asic_prop.dram_size;
+	region->offset_in_bar = 0;
+	region->bar_id = DDR_BAR_ID;
+	region->used = 1;
+}
+
 /*
  * goya_sw_init - Goya software initialization code
  *
@@ -919,6 +948,8 @@ static int goya_sw_init(struct hl_device *hdev)
 	hdev->supports_coresight = true;
 	hdev->supports_soft_reset = true;
 
+	goya_set_pci_memory_regions(hdev);
+
 	return 0;
 
 free_cpu_accessible_dma_pool:
-- 
2.25.1

