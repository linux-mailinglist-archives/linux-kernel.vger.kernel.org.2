Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9F533A4EB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 14:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhCNM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 08:59:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235248AbhCNM7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 08:59:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A33E664EE5;
        Sun, 14 Mar 2021 12:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615726761;
        bh=n7skvh3YQT3MOdPxXlmLDOAzrMJZwdMdvWRlerV3rWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lx0t166i22wPEKNDGPZLw9vS3s8jG57Rw3z0v1uCw6wviHRfLeyWwpRHHC14Aoc12
         sha8IHFFalrimRIOhtCEHWjNm2h5EX0yu4K056ON809EkXCDV5Om1krR8M4g8QqOwI
         au9j8W3zg5fu3G07X1/7a+3NPgL6jvbLgXKAA1mbgNDR2X1dF1tsoVx0M/NII/Z/cN
         07SHHuVmIQ8aH6IC+cTPfu5VmQgwsflpOsdTWhLK/7X6SR5lPTJkn+X6ZqwfnX3pve
         2Hbg9IuDmu/45K3sTAUk/y4M064A4osUxX3CLN9WpT6Me/VNk4FtC4jCPAj29+HZhC
         oQ8gQ0tbeKP6g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 4/4] habanalabs: support dynamic PLL numbering
Date:   Sun, 14 Mar 2021 14:59:12 +0200
Message-Id: <20210314125912.9306-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210314125912.9306-1-ogabbay@kernel.org>
References: <20210314125912.9306-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

As part of the effort remove hard-coded assumptions from the F/W-driver
communication, introduce support for dynamic pll numbering.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 22 +++++++++-
 drivers/misc/habanalabs/common/habanalabs.h   |  2 +-
 .../misc/habanalabs/include/common/cpucp_if.h | 41 +++++++++++++++++++
 .../habanalabs/include/gaudi/gaudi_fw_if.h    | 14 -------
 .../misc/habanalabs/include/goya/goya_fw_if.h | 11 -----
 5 files changed, 62 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 2a58edaf984a..8843e040c660 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -539,18 +539,36 @@ int hl_fw_cpucp_total_energy_get(struct hl_device *hdev, u64 *total_energy)
 	return rc;
 }
 
-int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u16 pll_index,
+int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, enum pll_index pll_index,
 		u16 *pll_freq_arr)
 {
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u8 pll_byte, pll_bit_off;
 	struct cpucp_packet pkt;
 	u64 result;
 	int rc;
 
+	if (pll_index >= PLL_MAX) {
+		dev_err(hdev->dev, "PLL index %d is out of range\n",
+								pll_index);
+		return -EINVAL;
+	}
+
+	/* PLL map is a u8 array */
+	pll_byte = prop->cpucp_info.pll_map[pll_index >> 3];
+	pll_bit_off = pll_index & 0x7;
+
+	if (!(pll_byte & BIT(pll_bit_off))) {
+		dev_err(hdev->dev, "PLL index %d is not supported\n",
+								pll_index);
+		return -EINVAL;
+	}
+
 	memset(&pkt, 0, sizeof(pkt));
 
 	pkt.ctl = cpu_to_le32(CPUCP_PACKET_PLL_INFO_GET <<
 				CPUCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.pll_type = __cpu_to_le16(pll_index);
+	pkt.pll_type = __cpu_to_le16((u16)pll_index);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 			HL_CPUCP_INFO_TIMEOUT_USEC, &result);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 2dcefd6485e5..5f930cb5e33d 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2379,7 +2379,7 @@ int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters);
 int hl_fw_cpucp_total_energy_get(struct hl_device *hdev,
 			u64 *total_energy);
-int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u16 pll_index,
+int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, enum pll_index pll_index,
 		u16 *pll_freq_arr);
 int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power);
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
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

