Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97349362EBE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbhDQJHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235923AbhDQJHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:07:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63026611C2;
        Sat, 17 Apr 2021 09:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618650404;
        bh=c8WRDm633C2sZ64rH5GVNi/rfRahK86bCmyB44MmA3E=;
        h=From:To:Cc:Subject:Date:From;
        b=dEUUw60L5gGiCUeeVjfuBs545vMmoak7tiIV3lok8AMAaWUHWBcCoIMdd9MDG6RSE
         oRVcidoHPZRUSHXrP8hE1PQeZAHUE7gopc0FDnqWUK6qC6+WEl0RVaQ3S2HfraiM7y
         /G3A2JYNAu5sK29YFtfJXLXUAP7sy+GI5M2cqh6bjwDn6MTyVIACxUKH6dAMfTG/cm
         ffJKh3PsUgPGuii/4Fk4xt1Dc/KRcoeQrQry72SmW5bowrAyweCZzLY6ldn5FVCeYJ
         syfSmR2GEweYjbS8uXpfc9JCaQFX7ChAzd5D5UIq86dLv7wTeCLtNrWSvYkKE2AtBh
         gBGtFrQry+ajA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bharat Jauhari <bjauhari@habana.ai>
Subject: [PATCH 1/7] habanalabs: expose ASIC specific PLL index
Date:   Sat, 17 Apr 2021 12:06:32 +0300
Message-Id: <20210417090638.9802-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Jauhari <bjauhari@habana.ai>

Currently the user cannot interpret the PLL information based on index
as its exposed as an integer.

This commit exposes ASIC specific PLL indexes and maps it to a generic
FW compatible index.

Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 34 +++++++-----
 drivers/misc/habanalabs/common/habanalabs.h  | 16 +++---
 drivers/misc/habanalabs/common/sysfs.c       |  4 +-
 drivers/misc/habanalabs/gaudi/gaudi.c        | 55 +++++++-------------
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c  | 12 ++---
 drivers/misc/habanalabs/goya/goya.c          | 47 +++++++----------
 drivers/misc/habanalabs/goya/goya_hwmgr.c    | 40 +++++++-------
 include/uapi/misc/habanalabs.h               | 33 ++++++++++++
 8 files changed, 127 insertions(+), 114 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 832dd5c5bb06..7cf82da67dab 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -661,18 +661,13 @@ int hl_fw_cpucp_total_energy_get(struct hl_device *hdev, u64 *total_energy)
 	return rc;
 }
 
-int get_used_pll_index(struct hl_device *hdev, enum pll_index input_pll_index,
+int get_used_pll_index(struct hl_device *hdev, u32 input_pll_index,
 						enum pll_index *pll_index)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u8 pll_byte, pll_bit_off;
 	bool dynamic_pll;
-
-	if (input_pll_index >= PLL_MAX) {
-		dev_err(hdev->dev, "PLL index %d is out of range\n",
-							input_pll_index);
-		return -EINVAL;
-	}
+	int fw_pll_idx;
 
 	dynamic_pll = prop->fw_security_status_valid &&
 		(prop->fw_app_security_map & CPU_BOOT_DEV_STS0_DYN_PLL_EN);
@@ -680,28 +675,39 @@ int get_used_pll_index(struct hl_device *hdev, enum pll_index input_pll_index,
 	if (!dynamic_pll) {
 		/*
 		 * in case we are working with legacy FW (each asic has unique
-		 * PLL numbering) extract the legacy numbering
+		 * PLL numbering) use the driver based index as they are
+		 * aligned with fw legacy numbering
 		 */
-		*pll_index = hdev->legacy_pll_map[input_pll_index];
+		*pll_index = input_pll_index;
 		return 0;
 	}
 
+	/* retrieve a FW compatible PLL index based on
+	 * ASIC specific user request
+	 */
+	fw_pll_idx = hdev->asic_funcs->map_pll_idx_to_fw_idx(input_pll_index);
+	if (fw_pll_idx < 0) {
+		dev_err(hdev->dev, "Invalid PLL index (%u) error %d\n",
+			input_pll_index, fw_pll_idx);
+		return -EINVAL;
+	}
+
 	/* PLL map is a u8 array */
-	pll_byte = prop->cpucp_info.pll_map[input_pll_index >> 3];
-	pll_bit_off = input_pll_index & 0x7;
+	pll_byte = prop->cpucp_info.pll_map[fw_pll_idx >> 3];
+	pll_bit_off = fw_pll_idx & 0x7;
 
 	if (!(pll_byte & BIT(pll_bit_off))) {
 		dev_err(hdev->dev, "PLL index %d is not supported\n",
-							input_pll_index);
+			fw_pll_idx);
 		return -EINVAL;
 	}
 
-	*pll_index = input_pll_index;
+	*pll_index = fw_pll_idx;
 
 	return 0;
 }
 
-int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, enum pll_index pll_index,
+int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u32 pll_index,
 		u16 *pll_freq_arr)
 {
 	struct cpucp_packet pkt;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 44e89da30b4a..91291a8e201e 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -930,6 +930,9 @@ enum div_select_defs {
  *                         driver is ready to receive asynchronous events. This
  *                         function should be called during the first init and
  *                         after every hard-reset of the device
+ * @get_msi_info: Retrieve asic-specific MSI ID of the f/w async event
+ * @map_pll_idx_to_fw_idx: convert driver specific per asic PLL index to
+ *                         generic f/w compatible PLL Indexes
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1054,6 +1057,7 @@ struct hl_asic_funcs {
 			u32 block_id, u32 block_size);
 	void (*enable_events_from_fw)(struct hl_device *hdev);
 	void (*get_msi_info)(u32 *table);
+	int (*map_pll_idx_to_fw_idx)(u32 pll_idx);
 };
 
 
@@ -1950,8 +1954,6 @@ struct hl_mmu_funcs {
  * @aggregated_cs_counters: aggregated cs counters among all contexts
  * @mmu_priv: device-specific MMU data.
  * @mmu_func: device-related MMU functions.
- * @legacy_pll_map: map holding map between dynamic (common) PLL indexes and
- *                  static (asic specific) PLL indexes.
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -2071,8 +2073,6 @@ struct hl_device {
 	struct hl_mmu_priv		mmu_priv;
 	struct hl_mmu_funcs		mmu_func[MMU_NUM_PGT_LOCATIONS];
 
-	enum pll_index			*legacy_pll_map;
-
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
@@ -2387,9 +2387,9 @@ int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters);
 int hl_fw_cpucp_total_energy_get(struct hl_device *hdev,
 			u64 *total_energy);
-int get_used_pll_index(struct hl_device *hdev, enum pll_index input_pll_index,
+int get_used_pll_index(struct hl_device *hdev, u32 input_pll_index,
 						enum pll_index *pll_index);
-int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, enum pll_index pll_index,
+int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u32 pll_index,
 		u16 *pll_freq_arr);
 int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power);
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
@@ -2411,9 +2411,9 @@ int hl_pci_set_outbound_region(struct hl_device *hdev,
 int hl_pci_init(struct hl_device *hdev);
 void hl_pci_fini(struct hl_device *hdev);
 
-long hl_get_frequency(struct hl_device *hdev, enum pll_index pll_index,
+long hl_get_frequency(struct hl_device *hdev, u32 pll_index,
 								bool curr);
-void hl_set_frequency(struct hl_device *hdev, enum pll_index pll_index,
+void hl_set_frequency(struct hl_device *hdev, u32 pll_index,
 								u64 freq);
 int hl_get_temperature(struct hl_device *hdev,
 		       int sensor_index, u32 attr, long *value);
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 9fa61573a89d..c9f649b31e3a 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -9,7 +9,7 @@
 
 #include <linux/pci.h>
 
-long hl_get_frequency(struct hl_device *hdev, enum pll_index pll_index,
+long hl_get_frequency(struct hl_device *hdev, u32 pll_index,
 								bool curr)
 {
 	struct cpucp_packet pkt;
@@ -44,7 +44,7 @@ long hl_get_frequency(struct hl_device *hdev, enum pll_index pll_index,
 	return (long) result;
 }
 
-void hl_set_frequency(struct hl_device *hdev, enum pll_index pll_index,
+void hl_set_frequency(struct hl_device *hdev, u32 pll_index,
 								u64 freq)
 {
 	struct cpucp_packet pkt;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b751652f80a8..81155f06c126 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -105,36 +105,6 @@
 
 #define GAUDI_PLL_MAX 10
 
-/*
- * this enum kept here for compatibility with old FW (in which each asic has
- * unique PLL numbering
- */
-enum gaudi_pll_index {
-	GAUDI_CPU_PLL = 0,
-	GAUDI_PCI_PLL,
-	GAUDI_SRAM_PLL,
-	GAUDI_HBM_PLL,
-	GAUDI_NIC_PLL,
-	GAUDI_DMA_PLL,
-	GAUDI_MESH_PLL,
-	GAUDI_MME_PLL,
-	GAUDI_TPC_PLL,
-	GAUDI_IF_PLL,
-};
-
-static enum pll_index gaudi_pll_map[PLL_MAX] = {
-	[CPU_PLL] = GAUDI_CPU_PLL,
-	[PCI_PLL] = GAUDI_PCI_PLL,
-	[SRAM_PLL] = GAUDI_SRAM_PLL,
-	[HBM_PLL] = GAUDI_HBM_PLL,
-	[NIC_PLL] = GAUDI_NIC_PLL,
-	[DMA_PLL] = GAUDI_DMA_PLL,
-	[MESH_PLL] = GAUDI_MESH_PLL,
-	[MME_PLL] = GAUDI_MME_PLL,
-	[TPC_PLL] = GAUDI_TPC_PLL,
-	[IF_PLL] = GAUDI_IF_PLL,
-};
-
 static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
 		"gaudi cq 0_0", "gaudi cq 0_1", "gaudi cq 0_2", "gaudi cq 0_3",
 		"gaudi cq 1_0", "gaudi cq 1_1", "gaudi cq 1_2", "gaudi cq 1_3",
@@ -810,7 +780,7 @@ static int gaudi_fetch_psoc_frequency(struct hl_device *hdev)
 			freq = 0;
 		}
 	} else {
-		rc = hl_fw_cpucp_pll_info_get(hdev, CPU_PLL, pll_freq_arr);
+		rc = hl_fw_cpucp_pll_info_get(hdev, HL_GAUDI_CPU_PLL, pll_freq_arr);
 
 		if (rc)
 			return rc;
@@ -1652,9 +1622,6 @@ static int gaudi_sw_init(struct hl_device *hdev)
 
 	hdev->asic_specific = gaudi;
 
-	/* store legacy PLL map */
-	hdev->legacy_pll_map = gaudi_pll_map;
-
 	/* Create DMA pool for small allocations */
 	hdev->dma_pool = dma_pool_create(dev_name(hdev->dev),
 			&hdev->pdev->dev, GAUDI_DMA_POOL_BLK_SIZE, 8, 0);
@@ -8783,6 +8750,23 @@ static void gaudi_enable_events_from_fw(struct hl_device *hdev)
 	WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR, GAUDI_EVENT_INTS_REGISTER);
 }
 
+static int gaudi_map_pll_idx_to_fw_idx(u32 pll_idx)
+{
+	switch (pll_idx) {
+	case HL_GAUDI_CPU_PLL: return CPU_PLL;
+	case HL_GAUDI_PCI_PLL: return PCI_PLL;
+	case HL_GAUDI_NIC_PLL: return NIC_PLL;
+	case HL_GAUDI_DMA_PLL: return DMA_PLL;
+	case HL_GAUDI_MESH_PLL: return MESH_PLL;
+	case HL_GAUDI_MME_PLL: return MME_PLL;
+	case HL_GAUDI_TPC_PLL: return TPC_PLL;
+	case HL_GAUDI_IF_PLL: return IF_PLL;
+	case HL_GAUDI_SRAM_PLL: return SRAM_PLL;
+	case HL_GAUDI_HBM_PLL: return HBM_PLL;
+	default: return -EINVAL;
+	}
+}
+
 static const struct hl_asic_funcs gaudi_funcs = {
 	.early_init = gaudi_early_init,
 	.early_fini = gaudi_early_fini,
@@ -8866,7 +8850,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.ack_protection_bits_errors = gaudi_ack_protection_bits_errors,
 	.get_hw_block_id = gaudi_get_hw_block_id,
 	.hw_block_mmap = gaudi_block_mmap,
-	.enable_events_from_fw = gaudi_enable_events_from_fw
+	.enable_events_from_fw = gaudi_enable_events_from_fw,
+	.map_pll_idx_to_fw_idx = gaudi_map_pll_idx_to_fw_idx
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c b/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
index 8c49da4bcbd5..9b60eadd4c35 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
@@ -13,7 +13,7 @@ void gaudi_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
 	struct gaudi_device *gaudi = hdev->asic_specific;
 
 	if (freq == PLL_LAST)
-		hl_set_frequency(hdev, MME_PLL, gaudi->max_freq_value);
+		hl_set_frequency(hdev, HL_GAUDI_MME_PLL, gaudi->max_freq_value);
 }
 
 int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
@@ -23,7 +23,7 @@ int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, MME_PLL, false);
+	value = hl_get_frequency(hdev, HL_GAUDI_MME_PLL, false);
 
 	if (value < 0) {
 		dev_err(hdev->dev, "Failed to retrieve device max clock %ld\n",
@@ -33,7 +33,7 @@ int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 
 	*max_clk = (value / 1000 / 1000);
 
-	value = hl_get_frequency(hdev, MME_PLL, true);
+	value = hl_get_frequency(hdev, HL_GAUDI_MME_PLL, true);
 
 	if (value < 0) {
 		dev_err(hdev->dev,
@@ -57,7 +57,7 @@ static ssize_t clk_max_freq_mhz_show(struct device *dev,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, MME_PLL, false);
+	value = hl_get_frequency(hdev, HL_GAUDI_MME_PLL, false);
 
 	gaudi->max_freq_value = value;
 
@@ -85,7 +85,7 @@ static ssize_t clk_max_freq_mhz_store(struct device *dev,
 
 	gaudi->max_freq_value = value * 1000 * 1000;
 
-	hl_set_frequency(hdev, MME_PLL, gaudi->max_freq_value);
+	hl_set_frequency(hdev, HL_GAUDI_MME_PLL, gaudi->max_freq_value);
 
 fail:
 	return count;
@@ -100,7 +100,7 @@ static ssize_t clk_cur_freq_mhz_show(struct device *dev,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, MME_PLL, true);
+	value = hl_get_frequency(hdev, HL_GAUDI_MME_PLL, true);
 
 	return sprintf(buf, "%lu\n", (value / 1000 / 1000));
 }
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e27338f4aad2..e0ad2a269779 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -118,30 +118,6 @@
 #define IS_MME_IDLE(mme_arch_sts) \
 	(((mme_arch_sts) & MME_ARCH_IDLE_MASK) == MME_ARCH_IDLE_MASK)
 
-/*
- * this enum kept here for compatibility with old FW (in which each asic has
- * unique PLL numbering
- */
-enum goya_pll_index {
-	GOYA_CPU_PLL = 0,
-	GOYA_IC_PLL,
-	GOYA_MC_PLL,
-	GOYA_MME_PLL,
-	GOYA_PCI_PLL,
-	GOYA_EMMC_PLL,
-	GOYA_TPC_PLL,
-};
-
-static enum pll_index goya_pll_map[PLL_MAX] = {
-	[CPU_PLL] = GOYA_CPU_PLL,
-	[IC_PLL] = GOYA_IC_PLL,
-	[MC_PLL] = GOYA_MC_PLL,
-	[MME_PLL] = GOYA_MME_PLL,
-	[PCI_PLL] = GOYA_PCI_PLL,
-	[EMMC_PLL] = GOYA_EMMC_PLL,
-	[TPC_PLL] = GOYA_TPC_PLL,
-};
-
 static const char goya_irq_name[GOYA_MSIX_ENTRIES][GOYA_MAX_STRING_LEN] = {
 		"goya cq 0", "goya cq 1", "goya cq 2", "goya cq 3",
 		"goya cq 4", "goya cpu eq"
@@ -775,7 +751,8 @@ static void goya_fetch_psoc_frequency(struct hl_device *hdev)
 			freq = 0;
 		}
 	} else {
-		rc = hl_fw_cpucp_pll_info_get(hdev, PCI_PLL, pll_freq_arr);
+		rc = hl_fw_cpucp_pll_info_get(hdev, HL_GOYA_PCI_PLL,
+				pll_freq_arr);
 
 		if (rc)
 			return;
@@ -897,9 +874,6 @@ static int goya_sw_init(struct hl_device *hdev)
 
 	hdev->asic_specific = goya;
 
-	/* store legacy PLL map */
-	hdev->legacy_pll_map = goya_pll_map;
-
 	/* Create DMA pool for small allocations */
 	hdev->dma_pool = dma_pool_create(dev_name(hdev->dev),
 			&hdev->pdev->dev, GOYA_DMA_POOL_BLK_SIZE, 8, 0);
@@ -5512,6 +5486,20 @@ static void goya_enable_events_from_fw(struct hl_device *hdev)
 			GOYA_ASYNC_EVENT_ID_INTS_REGISTER);
 }
 
+static int goya_map_pll_idx_to_fw_idx(u32 pll_idx)
+{
+	switch (pll_idx) {
+	case HL_GOYA_CPU_PLL: return CPU_PLL;
+	case HL_GOYA_PCI_PLL: return PCI_PLL;
+	case HL_GOYA_MME_PLL: return MME_PLL;
+	case HL_GOYA_TPC_PLL: return TPC_PLL;
+	case HL_GOYA_IC_PLL: return IC_PLL;
+	case HL_GOYA_MC_PLL: return MC_PLL;
+	case HL_GOYA_EMMC_PLL: return EMMC_PLL;
+	default: return -EINVAL;
+	}
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5595,7 +5583,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.ack_protection_bits_errors = goya_ack_protection_bits_errors,
 	.get_hw_block_id = goya_get_hw_block_id,
 	.hw_block_mmap = goya_block_mmap,
-	.enable_events_from_fw = goya_enable_events_from_fw
+	.enable_events_from_fw = goya_enable_events_from_fw,
+	.map_pll_idx_to_fw_idx = goya_map_pll_idx_to_fw_idx
 };
 
 /*
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index 3acb36a1a902..7d007125727f 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -13,19 +13,19 @@ void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
 
 	switch (freq) {
 	case PLL_HIGH:
-		hl_set_frequency(hdev, MME_PLL, hdev->high_pll);
-		hl_set_frequency(hdev, TPC_PLL, hdev->high_pll);
-		hl_set_frequency(hdev, IC_PLL, hdev->high_pll);
+		hl_set_frequency(hdev, HL_GOYA_MME_PLL, hdev->high_pll);
+		hl_set_frequency(hdev, HL_GOYA_TPC_PLL, hdev->high_pll);
+		hl_set_frequency(hdev, HL_GOYA_IC_PLL, hdev->high_pll);
 		break;
 	case PLL_LOW:
-		hl_set_frequency(hdev, MME_PLL, GOYA_PLL_FREQ_LOW);
-		hl_set_frequency(hdev, TPC_PLL, GOYA_PLL_FREQ_LOW);
-		hl_set_frequency(hdev, IC_PLL, GOYA_PLL_FREQ_LOW);
+		hl_set_frequency(hdev, HL_GOYA_MME_PLL, GOYA_PLL_FREQ_LOW);
+		hl_set_frequency(hdev, HL_GOYA_TPC_PLL, GOYA_PLL_FREQ_LOW);
+		hl_set_frequency(hdev, HL_GOYA_IC_PLL, GOYA_PLL_FREQ_LOW);
 		break;
 	case PLL_LAST:
-		hl_set_frequency(hdev, MME_PLL, goya->mme_clk);
-		hl_set_frequency(hdev, TPC_PLL, goya->tpc_clk);
-		hl_set_frequency(hdev, IC_PLL, goya->ic_clk);
+		hl_set_frequency(hdev, HL_GOYA_MME_PLL, goya->mme_clk);
+		hl_set_frequency(hdev, HL_GOYA_TPC_PLL, goya->tpc_clk);
+		hl_set_frequency(hdev, HL_GOYA_IC_PLL, goya->ic_clk);
 		break;
 	default:
 		dev_err(hdev->dev, "unknown frequency setting\n");
@@ -39,7 +39,7 @@ int goya_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, MME_PLL, false);
+	value = hl_get_frequency(hdev, HL_GOYA_MME_PLL, false);
 
 	if (value < 0) {
 		dev_err(hdev->dev, "Failed to retrieve device max clock %ld\n",
@@ -49,7 +49,7 @@ int goya_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 
 	*max_clk = (value / 1000 / 1000);
 
-	value = hl_get_frequency(hdev, MME_PLL, true);
+	value = hl_get_frequency(hdev, HL_GOYA_MME_PLL, true);
 
 	if (value < 0) {
 		dev_err(hdev->dev,
@@ -72,7 +72,7 @@ static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, MME_PLL, false);
+	value = hl_get_frequency(hdev, HL_GOYA_MME_PLL, false);
 
 	if (value < 0)
 		return value;
@@ -105,7 +105,7 @@ static ssize_t mme_clk_store(struct device *dev, struct device_attribute *attr,
 		goto fail;
 	}
 
-	hl_set_frequency(hdev, MME_PLL, value);
+	hl_set_frequency(hdev, HL_GOYA_MME_PLL, value);
 	goya->mme_clk = value;
 
 fail:
@@ -121,7 +121,7 @@ static ssize_t tpc_clk_show(struct device *dev, struct device_attribute *attr,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, TPC_PLL, false);
+	value = hl_get_frequency(hdev, HL_GOYA_TPC_PLL, false);
 
 	if (value < 0)
 		return value;
@@ -154,7 +154,7 @@ static ssize_t tpc_clk_store(struct device *dev, struct device_attribute *attr,
 		goto fail;
 	}
 
-	hl_set_frequency(hdev, TPC_PLL, value);
+	hl_set_frequency(hdev, HL_GOYA_TPC_PLL, value);
 	goya->tpc_clk = value;
 
 fail:
@@ -170,7 +170,7 @@ static ssize_t ic_clk_show(struct device *dev, struct device_attribute *attr,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, IC_PLL, false);
+	value = hl_get_frequency(hdev, HL_GOYA_IC_PLL, false);
 
 	if (value < 0)
 		return value;
@@ -203,7 +203,7 @@ static ssize_t ic_clk_store(struct device *dev, struct device_attribute *attr,
 		goto fail;
 	}
 
-	hl_set_frequency(hdev, IC_PLL, value);
+	hl_set_frequency(hdev, HL_GOYA_IC_PLL, value);
 	goya->ic_clk = value;
 
 fail:
@@ -219,7 +219,7 @@ static ssize_t mme_clk_curr_show(struct device *dev,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, MME_PLL, true);
+	value = hl_get_frequency(hdev, HL_GOYA_MME_PLL, true);
 
 	if (value < 0)
 		return value;
@@ -236,7 +236,7 @@ static ssize_t tpc_clk_curr_show(struct device *dev,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, TPC_PLL, true);
+	value = hl_get_frequency(hdev, HL_GOYA_TPC_PLL, true);
 
 	if (value < 0)
 		return value;
@@ -253,7 +253,7 @@ static ssize_t ic_clk_curr_show(struct device *dev,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, IC_PLL, true);
+	value = hl_get_frequency(hdev, HL_GOYA_IC_PLL, true);
 
 	if (value < 0)
 		return value;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index d3e017b5f0db..6d2d34c9f375 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -239,6 +239,39 @@ enum gaudi_engine_id {
 	GAUDI_ENGINE_ID_SIZE
 };
 
+/*
+ * ASIC specific PLL index
+ *
+ * Used to retrieve in frequency info of different IPs via
+ * HL_INFO_PLL_FREQUENCY under HL_IOCTL_INFO IOCTL. The enums need to be
+ * used as an index in struct hl_pll_frequency_info
+ */
+
+enum hl_goya_pll_index {
+	HL_GOYA_CPU_PLL = 0,
+	HL_GOYA_IC_PLL,
+	HL_GOYA_MC_PLL,
+	HL_GOYA_MME_PLL,
+	HL_GOYA_PCI_PLL,
+	HL_GOYA_EMMC_PLL,
+	HL_GOYA_TPC_PLL,
+	HL_GOYA_PLL_MAX
+};
+
+enum hl_gaudi_pll_index {
+	HL_GAUDI_CPU_PLL = 0,
+	HL_GAUDI_PCI_PLL,
+	HL_GAUDI_SRAM_PLL,
+	HL_GAUDI_HBM_PLL,
+	HL_GAUDI_NIC_PLL,
+	HL_GAUDI_DMA_PLL,
+	HL_GAUDI_MESH_PLL,
+	HL_GAUDI_MME_PLL,
+	HL_GAUDI_TPC_PLL,
+	HL_GAUDI_IF_PLL,
+	HL_GAUDI_PLL_MAX
+};
+
 enum hl_device_status {
 	HL_DEVICE_STATUS_OPERATIONAL,
 	HL_DEVICE_STATUS_IN_RESET,
-- 
2.25.1

