Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC12634348B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhCUULr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230336AbhCUULi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:11:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C249361944;
        Sun, 21 Mar 2021 20:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616357498;
        bh=3XReXXhoy2tYviynTJ5Q900MnucAp85YDI06L2VKMPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aouzb2raCAIla8bsY7P9d6g1PAuUdtXbuukfOqAQDVvQonwpbSxCGXbx0Bb4x7jRk
         VBi+vql4D2pn4mIcP7mEQAEoRnC4DAJz9zcgx5UoWxVT1otQCR3Ptsxd4ixrMLk/8l
         Fkq07yZcn2mRWDDzRAtsdOGZxgLumZCb7BIfXaRvDHMwEscH9f/QvI8Z3hkuGXjFiO
         7s7OocBA+vkiPpioHHgRlPxjMSw27nFZKv1mpwyqN0QjcF6dRCYja5gt3W4ruAc5zV
         q+OvrPsGMGcQqaOQmX6gp+YBGhHrhU69XtZiNZW2BbhNHF6AW8/YCEZSJyXP3P7WUK
         F0S1OIMKgxqVQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/3] habanalabs: support legacy and new pll indexes
Date:   Sun, 21 Mar 2021 22:11:29 +0200
Message-Id: <20210321201130.4670-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321201130.4670-1-ogabbay@kernel.org>
References: <20210321201130.4670-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

In order to use minimum of hard coded values common to LKD and F/W
a dynamic method to work with PLLs is introduced in this patch.
Formerly asic specific PLL numbering is now common for all asics.
To be backward compatible a bit in dev status is defined, if the bit is
not set LKD will keep working with old PLL numbering.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 49 ++++++++++++++++++-
 drivers/misc/habanalabs/common/habanalabs.h   | 14 ++++--
 drivers/misc/habanalabs/common/sysfs.c        | 24 ++++++---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 33 +++++++++++++
 drivers/misc/habanalabs/goya/goya.c           | 26 ++++++++++
 .../misc/habanalabs/include/common/cpucp_if.h | 41 ++++++++++++++++
 .../habanalabs/include/common/hl_boot_if.h    |  6 +++
 .../habanalabs/include/gaudi/gaudi_fw_if.h    | 14 ------
 .../misc/habanalabs/include/goya/goya_fw_if.h | 11 -----
 9 files changed, 182 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 2a58edaf984a..092691a8917d 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -539,18 +539,63 @@ int hl_fw_cpucp_total_energy_get(struct hl_device *hdev, u64 *total_energy)
 	return rc;
 }
 
-int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u16 pll_index,
+int get_used_pll_index(struct hl_device *hdev, enum pll_index input_pll_index,
+						enum pll_index *pll_index)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u8 pll_byte, pll_bit_off;
+	bool dynamic_pll;
+
+	if (input_pll_index >= PLL_MAX) {
+		dev_err(hdev->dev, "PLL index %d is out of range\n",
+							input_pll_index);
+		return -EINVAL;
+	}
+
+	dynamic_pll = prop->fw_security_status_valid &&
+		(prop->fw_app_security_map & CPU_BOOT_DEV_STS0_DYN_PLL_EN);
+
+	if (!dynamic_pll) {
+		/*
+		 * in case we are working with legacy FW (each asic has unique
+		 * PLL numbering) extract the legacy numbering
+		 */
+		*pll_index = hdev->legacy_pll_map[input_pll_index];
+		return 0;
+	}
+
+	/* PLL map is a u8 array */
+	pll_byte = prop->cpucp_info.pll_map[input_pll_index >> 3];
+	pll_bit_off = input_pll_index & 0x7;
+
+	if (!(pll_byte & BIT(pll_bit_off))) {
+		dev_err(hdev->dev, "PLL index %d is not supported\n",
+							input_pll_index);
+		return -EINVAL;
+	}
+
+	*pll_index = input_pll_index;
+
+	return 0;
+}
+
+int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, enum pll_index pll_index,
 		u16 *pll_freq_arr)
 {
 	struct cpucp_packet pkt;
+	enum pll_index used_pll_idx;
 	u64 result;
 	int rc;
 
+	rc = get_used_pll_index(hdev, pll_index, &used_pll_idx);
+	if (rc)
+		return rc;
+
 	memset(&pkt, 0, sizeof(pkt));
 
 	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PLL_INFO_GET <<
 				CPUCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.pll_type = __cpu_to_le16(pll_index);
+	pkt.pll_type = __cpu_to_le16((u16)used_pll_idx);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 			HL_CPUCP_INFO_TIMEOUT_USEC, &result);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 65f34918faed..dc8126b270d1 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1946,6 +1946,8 @@ struct hl_mmu_funcs {
  * @aggregated_cs_counters: aggregated cs counters among all contexts
  * @mmu_priv: device-specific MMU data.
  * @mmu_func: device-related MMU functions.
+ * @legacy_pll_map: map holding map between dynamic (common) PLL indexes and
+ *                  static (asic specific) PLL indexes.
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -2070,6 +2072,8 @@ struct hl_device {
 	struct hl_mmu_priv		mmu_priv;
 	struct hl_mmu_funcs		mmu_func[MMU_NUM_PGT_LOCATIONS];
 
+	enum pll_index			*legacy_pll_map;
+
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
@@ -2383,7 +2387,9 @@ int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters);
 int hl_fw_cpucp_total_energy_get(struct hl_device *hdev,
 			u64 *total_energy);
-int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u16 pll_index,
+int get_used_pll_index(struct hl_device *hdev, enum pll_index input_pll_index,
+						enum pll_index *pll_index);
+int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, enum pll_index pll_index,
 		u16 *pll_freq_arr);
 int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power);
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
@@ -2404,8 +2410,10 @@ int hl_pci_set_outbound_region(struct hl_device *hdev,
 int hl_pci_init(struct hl_device *hdev);
 void hl_pci_fini(struct hl_device *hdev);
 
-long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
-void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
+long hl_get_frequency(struct hl_device *hdev, enum pll_index pll_index,
+								bool curr);
+void hl_set_frequency(struct hl_device *hdev, enum pll_index pll_index,
+								u64 freq);
 int hl_get_temperature(struct hl_device *hdev,
 		       int sensor_index, u32 attr, long *value);
 int hl_set_temperature(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index f37634cf8b65..c7ac5dc0cda4 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -9,12 +9,18 @@
 
 #include <linux/pci.h>
 
-long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
+long hl_get_frequency(struct hl_device *hdev, enum pll_index pll_index,
+								bool curr)
 {
 	struct cpucp_packet pkt;
+	u32 used_pll_idx;
 	u64 result;
 	int rc;
 
+	rc = get_used_pll_index(hdev, pll_index, &used_pll_idx);
+	if (rc)
+		return rc;
+
 	memset(&pkt, 0, sizeof(pkt));
 
 	if (curr)
@@ -23,7 +29,7 @@ long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
 	else
 		pkt.ctl = cpu_to_le32(CPUCP_PACKET_FREQUENCY_GET <<
 						CPUCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.pll_index = cpu_to_le32(pll_index);
+	pkt.pll_index = cpu_to_le32((u32)used_pll_idx);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 						0, &result);
@@ -31,23 +37,29 @@ long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to get frequency of PLL %d, error %d\n",
-			pll_index, rc);
+			used_pll_idx, rc);
 		return rc;
 	}
 
 	return (long) result;
 }
 
-void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
+void hl_set_frequency(struct hl_device *hdev, enum pll_index pll_index,
+								u64 freq)
 {
 	struct cpucp_packet pkt;
+	u32 used_pll_idx;
 	int rc;
 
+	rc = get_used_pll_index(hdev, pll_index, &used_pll_idx);
+	if (rc)
+		return;
+
 	memset(&pkt, 0, sizeof(pkt));
 
 	pkt.ctl = cpu_to_le32(CPUCP_PACKET_FREQUENCY_SET <<
 					CPUCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.pll_index = cpu_to_le32(pll_index);
+	pkt.pll_index = cpu_to_le32((u32)used_pll_idx);
 	pkt.value = cpu_to_le64(freq);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
@@ -56,7 +68,7 @@ void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
 	if (rc)
 		dev_err(hdev->dev,
 			"Failed to set frequency to PLL %d, error %d\n",
-			pll_index, rc);
+			used_pll_idx, rc);
 }
 
 u64 hl_get_max_power(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index a65ae0dbdb92..8fa190fde462 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -105,6 +105,36 @@
 
 #define GAUDI_PLL_MAX 10
 
+/*
+ * this enum kept here for compatibility with old FW (in which each asic has
+ * unique PLL numbering
+ */
+enum gaudi_pll_index {
+	GAUDI_CPU_PLL = 0,
+	GAUDI_PCI_PLL,
+	GAUDI_SRAM_PLL,
+	GAUDI_HBM_PLL,
+	GAUDI_NIC_PLL,
+	GAUDI_DMA_PLL,
+	GAUDI_MESH_PLL,
+	GAUDI_MME_PLL,
+	GAUDI_TPC_PLL,
+	GAUDI_IF_PLL,
+};
+
+static enum pll_index gaudi_pll_map[PLL_MAX] = {
+	[CPU_PLL] = GAUDI_CPU_PLL,
+	[PCI_PLL] = GAUDI_PCI_PLL,
+	[SRAM_PLL] = GAUDI_SRAM_PLL,
+	[HBM_PLL] = GAUDI_HBM_PLL,
+	[NIC_PLL] = GAUDI_NIC_PLL,
+	[DMA_PLL] = GAUDI_DMA_PLL,
+	[MESH_PLL] = GAUDI_MESH_PLL,
+	[MME_PLL] = GAUDI_MME_PLL,
+	[TPC_PLL] = GAUDI_TPC_PLL,
+	[IF_PLL] = GAUDI_IF_PLL,
+};
+
 static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
 		"gaudi cq 0_0", "gaudi cq 0_1", "gaudi cq 0_2", "gaudi cq 0_3",
 		"gaudi cq 1_0", "gaudi cq 1_1", "gaudi cq 1_2", "gaudi cq 1_3",
@@ -1588,6 +1618,9 @@ static int gaudi_sw_init(struct hl_device *hdev)
 
 	hdev->asic_specific = gaudi;
 
+	/* store legacy PLL map */
+	hdev->legacy_pll_map = gaudi_pll_map;
+
 	/* Create DMA pool for small allocations */
 	hdev->dma_pool = dma_pool_create(dev_name(hdev->dev),
 			&hdev->pdev->dev, GAUDI_DMA_POOL_BLK_SIZE, 8, 0);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 9e7531167c73..f3b3145b206f 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -118,6 +118,29 @@
 #define IS_MME_IDLE(mme_arch_sts) \
 	(((mme_arch_sts) & MME_ARCH_IDLE_MASK) == MME_ARCH_IDLE_MASK)
 
+/*
+ * this enum kept here for compatibility with old FW (in which each asic has
+ * unique PLL numbering
+ */
+enum goya_pll_index {
+	GOYA_CPU_PLL = 0,
+	GOYA_IC_PLL,
+	GOYA_MC_PLL,
+	GOYA_MME_PLL,
+	GOYA_PCI_PLL,
+	GOYA_EMMC_PLL,
+	GOYA_TPC_PLL,
+};
+
+static enum pll_index goya_pll_map[PLL_MAX] = {
+	[CPU_PLL] = GOYA_CPU_PLL,
+	[IC_PLL] = GOYA_IC_PLL,
+	[MC_PLL] = GOYA_MC_PLL,
+	[MME_PLL] = GOYA_MME_PLL,
+	[PCI_PLL] = GOYA_PCI_PLL,
+	[EMMC_PLL] = GOYA_EMMC_PLL,
+	[TPC_PLL] = GOYA_TPC_PLL,
+};
 
 static const char goya_irq_name[GOYA_MSIX_ENTRIES][GOYA_MAX_STRING_LEN] = {
 		"goya cq 0", "goya cq 1", "goya cq 2", "goya cq 3",
@@ -853,6 +876,9 @@ static int goya_sw_init(struct hl_device *hdev)
 
 	hdev->asic_specific = goya;
 
+	/* store legacy PLL map */
+	hdev->legacy_pll_map = goya_pll_map;
+
 	/* Create DMA pool for small allocations */
 	hdev->dma_pool = dma_pool_create(dev_name(hdev->dev),
 			&hdev->pdev->dev, GOYA_DMA_POOL_BLK_SIZE, 8, 0);
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 6ba480a316ce..e745c78dd8fd 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -28,6 +28,9 @@
 #define CPUCP_PKT_HBM_ECC_INFO_HBM_CH_SHIFT		6
 #define CPUCP_PKT_HBM_ECC_INFO_HBM_CH_MASK		0x000007C0
 
+#define PLL_MAP_MAX_BITS	128
+#define PLL_MAP_LEN		(PLL_MAP_MAX_BITS / 8)
+
 /*
  * info of the pkt queue pointers in the first async occurrence
  */
@@ -473,6 +476,42 @@ enum cpucp_pll_type_attributes {
 	cpucp_pll_pci,
 };
 
+/*
+ * PLL enumeration table used for all ASICs and future SW versions.
+ * For future ASIC-LKD compatibility, we can only add new enumerations.
+ * at the end of the table.
+ * Changing the order of entries or removing entries is not allowed.
+ */
+enum pll_index {
+	CPU_PLL = 0,
+	PCI_PLL = 1,
+	NIC_PLL = 2,
+	DMA_PLL = 3,
+	MESH_PLL = 4,
+	MME_PLL = 5,
+	TPC_PLL = 6,
+	IF_PLL = 7,
+	SRAM_PLL = 8,
+	NS_DCORE_PLL = 9,
+	MESH_DCORE_PLL = 10,
+	HBM_PLL = 11,
+	TPC_DCORE_PLL = 12,
+	VIDEO_DCORE_PLL = 13,
+	SRAM_DCORE_PLL = 14,
+	NIC_PHY_DCORE_PLL = 15,
+	MSS_DCORE_PLL = 16,
+	DMA_DCORE_PLL = 17,
+	SIF_PLL = 18,
+	DDR_PLL = 19,
+	VID_PLL = 20,
+	BANK_PLL = 21,
+	MMU_PLL = 22,
+	IC_PLL = 23,
+	MC_PLL = 24,
+	EMMC_PLL = 25,
+	PLL_MAX
+};
+
 /* Event Queue Packets */
 
 struct eq_generic_event {
@@ -547,6 +586,7 @@ struct cpucp_security_info {
  * @dram_size: available DRAM size.
  * @card_name: card name that will be displayed in HWMON subsystem on the host
  * @sec_info: security information
+ * @pll_map: Bit map of supported PLLs for current ASIC version.
  */
 struct cpucp_info {
 	struct cpucp_sensor sensors[CPUCP_MAX_SENSORS];
@@ -568,6 +608,7 @@ struct cpucp_info {
 	__u8 pad[7];
 	struct cpucp_security_info sec_info;
 	__le32 reserved6;
+	uint8_t pll_map[PLL_MAP_LEN];
 };
 
 struct cpucp_mac_addr {
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index d17185b6aea9..1717874ff306 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -179,6 +179,11 @@
  *					configured and is ready for use.
  *					Initialized in: ppboot
  *
+ * CPU_BOOT_DEV_STS0_DYN_PLL_EN		Dynamic PLL configuration is enabled.
+ *					FW sends to host a bitmap of supported
+ *					PLLs.
+ *					Initialized in: linux
+ *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
  *					running FW populates the device status
@@ -206,6 +211,7 @@
 #define CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN			(1 << 15)
 #define CPU_BOOT_DEV_STS0_FW_LD_COM_EN			(1 << 16)
 #define CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN		(1 << 17)
+#define CPU_BOOT_DEV_STS0_DYN_PLL_EN			(1 << 19)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 
 enum cpu_boot_status {
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
index 25acd9e87e20..a9f51f9f9e92 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
@@ -20,20 +20,6 @@
 #define UBOOT_FW_OFFSET			0x100000	/* 1MB in SRAM */
 #define LINUX_FW_OFFSET			0x800000	/* 8MB in HBM */
 
-enum gaudi_pll_index {
-	CPU_PLL = 0,
-	PCI_PLL,
-	SRAM_PLL,
-	HBM_PLL,
-	NIC_PLL,
-	DMA_PLL,
-	MESH_PLL,
-	MME_PLL,
-	TPC_PLL,
-	IF_PLL,
-	PLL_MAX
-};
-
 enum gaudi_nic_axi_error {
 	RXB,
 	RXE,
diff --git a/drivers/misc/habanalabs/include/goya/goya_fw_if.h b/drivers/misc/habanalabs/include/goya/goya_fw_if.h
index daf8d8cd14be..bc05f86c73ac 100644
--- a/drivers/misc/habanalabs/include/goya/goya_fw_if.h
+++ b/drivers/misc/habanalabs/include/goya/goya_fw_if.h
@@ -15,17 +15,6 @@
 #define UBOOT_FW_OFFSET		0x100000		/* 1MB in SRAM */
 #define LINUX_FW_OFFSET		0x800000		/* 8MB in DDR */
 
-enum goya_pll_index {
-	CPU_PLL = 0,
-	IC_PLL,
-	MC_PLL,
-	MME_PLL,
-	PCI_PLL,
-	EMMC_PLL,
-	TPC_PLL,
-	PLL_MAX
-};
-
 #define GOYA_PLL_FREQ_LOW		50000000 /* 50 MHz */
 
 #endif /* GOYA_FW_IF_H */
-- 
2.25.1

