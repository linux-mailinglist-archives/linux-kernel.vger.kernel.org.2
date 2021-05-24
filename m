Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E543438E289
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbhEXIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 04:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232483AbhEXIry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 04:47:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DC0A61153;
        Mon, 24 May 2021 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621845986;
        bh=6dPwvem5kTvOt3JyS9oQLGeKEj7gGJQkRKTJNypNIx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGgst3IUcy/EtEUqPnclFrB3kcNyPnJRjHJC+oqZ++VKG3iXjJnXwLL83mWbY8nft
         LWriBW5GE2WACwl7/BaddTrQOLuxug/G2JWUEQNJ7lp5ZYd7FIr6ik2x+7iWvFME5s
         ggAzRReVcJEOlPhrEgt8eEJHfh0/f5RewBCWIRoM0Qec+F5oMtZgftnoI7kVMdle8S
         J3hAsUhvp8nKAQ9uhfQhUi0SSJj/m7K2uHQvmM1QP+P+yn19m5UBHqlXs3Z4pSfPoq
         k4EgRlWfY2kY/QaxH7oRObfW9jEeQBWc0oH0XJSGZ/BG0MC9WKM3spnFJMLm4PkqY/
         uiq3/33opTjTw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/3] habanalabs: track security status using positive logic
Date:   Mon, 24 May 2021 11:46:18 +0300
Message-Id: <20210524084619.4680-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210524084619.4680-1-ogabbay@kernel.org>
References: <20210524084619.4680-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Using negative logic (i.e. fw_security_disabled) is confusing.

Modify the flag to use positive logic (fw_security_enabled).

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h   |  6 +--
 .../misc/habanalabs/common/habanalabs_drv.c   |  6 +--
 drivers/misc/habanalabs/gaudi/gaudi.c         | 48 +++++++++----------
 .../misc/habanalabs/gaudi/gaudi_coresight.c   |  2 +-
 .../misc/habanalabs/gaudi/gaudi_security.c    | 15 +++---
 drivers/misc/habanalabs/goya/goya.c           | 20 ++++----
 drivers/misc/habanalabs/goya/goya_coresight.c |  2 +-
 8 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index c19acefdb7e4..4cc6690a3e26 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1142,7 +1142,7 @@ static void hl_fw_preboot_update_state(struct hl_device *hdev)
 			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
 
 	dev_dbg(hdev->dev, "firmware-level security is %s\n",
-			prop->fw_security_disabled ? "disabled" : "enabled");
+			prop->fw_security_enabled ? "enabled" : "disabled");
 
 	dev_dbg(hdev->dev, "GIC controller is %s\n",
 			prop->gic_interrupts_enable ? "enabled" : "disabled");
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index f1ff4d503cf2..e751868b3ed3 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -456,8 +456,8 @@ struct hl_mmu_properties {
  * @user_interrupt_count: number of user interrupts.
  * @tpc_enabled_mask: which TPCs are enabled.
  * @completion_queues_count: number of completion queues.
- * @fw_security_disabled: true if security measures are disabled in firmware,
- *                        false otherwise
+ * @fw_security_enabled: true if security measures are enabled in firmware,
+ *                       false otherwise
  * @fw_cpu_boot_dev_sts0_valid: status bits are valid and can be fetched from
  *                              BOOT_DEV_STS0
  * @fw_cpu_boot_dev_sts1_valid: status bits are valid and can be fetched from
@@ -531,7 +531,7 @@ struct asic_fixed_properties {
 	u16				user_interrupt_count;
 	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
-	u8				fw_security_disabled;
+	u8				fw_security_enabled;
 	u8				fw_cpu_boot_dev_sts0_valid;
 	u8				fw_cpu_boot_dev_sts1_valid;
 	u8				dram_supports_virtual_memory;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 339a1860c1e7..bd67d4ceab56 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -308,10 +308,10 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	}
 
 	if (pdev)
-		hdev->asic_prop.fw_security_disabled =
-				!is_asic_secured(hdev->asic_type);
+		hdev->asic_prop.fw_security_enabled =
+					is_asic_secured(hdev->asic_type);
 	else
-		hdev->asic_prop.fw_security_disabled = true;
+		hdev->asic_prop.fw_security_enabled = false;
 
 	/* Assign status description string */
 	strncpy(hdev->status[HL_DEVICE_STATUS_MALFUNCTION],
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e155fae5edcb..836465dccc61 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -687,7 +687,7 @@ static int gaudi_early_init(struct hl_device *hdev)
 	prop->dram_pci_bar_size = pci_resource_len(pdev, HBM_BAR_ID);
 
 	/* If FW security is enabled at this point it means no access to ELBI */
-	if (!hdev->asic_prop.fw_security_disabled) {
+	if (hdev->asic_prop.fw_security_enabled) {
 		hdev->asic_prop.iatu_done_by_fw = true;
 
 		/*
@@ -763,7 +763,14 @@ static int gaudi_fetch_psoc_frequency(struct hl_device *hdev)
 	u16 pll_freq_arr[HL_PLL_NUM_OUTPUTS], freq;
 	int rc;
 
-	if (hdev->asic_prop.fw_security_disabled) {
+	if (hdev->asic_prop.fw_security_enabled) {
+		rc = hl_fw_cpucp_pll_info_get(hdev, HL_GAUDI_CPU_PLL, pll_freq_arr);
+
+		if (rc)
+			return rc;
+
+		freq = pll_freq_arr[2];
+	} else {
 		/* Backward compatibility */
 		div_fctr = RREG32(mmPSOC_CPU_PLL_DIV_FACTOR_2);
 		div_sel = RREG32(mmPSOC_CPU_PLL_DIV_SEL_2);
@@ -791,13 +798,6 @@ static int gaudi_fetch_psoc_frequency(struct hl_device *hdev)
 				div_sel);
 			freq = 0;
 		}
-	} else {
-		rc = hl_fw_cpucp_pll_info_get(hdev, HL_GAUDI_CPU_PLL, pll_freq_arr);
-
-		if (rc)
-			return rc;
-
-		freq = pll_freq_arr[2];
 	}
 
 	prop->psoc_timestamp_frequency = freq;
@@ -1525,7 +1525,7 @@ static int gaudi_alloc_cpu_accessible_dma_mem(struct hl_device *hdev)
 	hdev->cpu_pci_msb_addr =
 		GAUDI_CPU_PCI_MSB_ADDR(hdev->cpu_accessible_dma_address);
 
-	if (hdev->asic_prop.fw_security_disabled)
+	if (!hdev->asic_prop.fw_security_enabled)
 		GAUDI_PCI_TO_CPU_ADDR(hdev->cpu_accessible_dma_address);
 
 free_dma_mem_arr:
@@ -1725,7 +1725,7 @@ static int gaudi_sw_init(struct hl_device *hdev)
 free_cpu_accessible_dma_pool:
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 free_cpu_dma_mem:
-	if (hdev->asic_prop.fw_security_disabled)
+	if (!hdev->asic_prop.fw_security_enabled)
 		GAUDI_CPU_TO_PCI_ADDR(hdev->cpu_accessible_dma_address,
 					hdev->cpu_pci_msb_addr);
 	hdev->asic_funcs->asic_dma_free_coherent(hdev,
@@ -1747,7 +1747,7 @@ static int gaudi_sw_fini(struct hl_device *hdev)
 
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 
-	if (hdev->asic_prop.fw_security_disabled)
+	if (!hdev->asic_prop.fw_security_enabled)
 		GAUDI_CPU_TO_PCI_ADDR(hdev->cpu_accessible_dma_address,
 					hdev->cpu_pci_msb_addr);
 
@@ -1967,7 +1967,7 @@ static void gaudi_init_scrambler_sram(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 
-	if (!hdev->asic_prop.fw_security_disabled)
+	if (hdev->asic_prop.fw_security_enabled)
 		return;
 
 	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
@@ -2039,7 +2039,7 @@ static void gaudi_init_scrambler_hbm(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 
-	if (!hdev->asic_prop.fw_security_disabled)
+	if (hdev->asic_prop.fw_security_enabled)
 		return;
 
 	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
@@ -2109,7 +2109,7 @@ static void gaudi_init_scrambler_hbm(struct hl_device *hdev)
 
 static void gaudi_init_e2e(struct hl_device *hdev)
 {
-	if (!hdev->asic_prop.fw_security_disabled)
+	if (hdev->asic_prop.fw_security_enabled)
 		return;
 
 	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
@@ -2484,7 +2484,7 @@ static void gaudi_init_hbm_cred(struct hl_device *hdev)
 {
 	uint32_t hbm0_wr, hbm1_wr, hbm0_rd, hbm1_rd;
 
-	if (!hdev->asic_prop.fw_security_disabled)
+	if (hdev->asic_prop.fw_security_enabled)
 		return;
 
 	if (hdev->asic_prop.fw_cpu_boot_dev_sts0_valid &&
@@ -3602,7 +3602,7 @@ static void gaudi_set_clock_gating(struct hl_device *hdev)
 	if (hdev->in_debug)
 		return;
 
-	if (!hdev->asic_prop.fw_security_disabled)
+	if (hdev->asic_prop.fw_security_enabled)
 		return;
 
 	for (i = GAUDI_PCI_DMA_1, qman_offset = 0 ; i < GAUDI_HBM_DMA_1 ; i++) {
@@ -3662,7 +3662,7 @@ static void gaudi_disable_clock_gating(struct hl_device *hdev)
 	u32 qman_offset;
 	int i;
 
-	if (!hdev->asic_prop.fw_security_disabled)
+	if (hdev->asic_prop.fw_security_enabled)
 		return;
 
 	for (i = 0, qman_offset = 0 ; i < DMA_NUMBER_OF_CHANNELS ; i++) {
@@ -3897,7 +3897,7 @@ static int gaudi_init_cpu(struct hl_device *hdev)
 	 * The device CPU works with 40 bits addresses.
 	 * This register sets the extension to 50 bits.
 	 */
-	if (hdev->asic_prop.fw_security_disabled)
+	if (!hdev->asic_prop.fw_security_enabled)
 		WREG32(mmCPU_IF_CPU_MSB_ADDR, hdev->cpu_pci_msb_addr);
 
 	rc = hl_fw_init_cpu(hdev);
@@ -3991,7 +3991,7 @@ static void gaudi_pre_hw_init(struct hl_device *hdev)
 	/* Perform read from the device to make sure device is up */
 	RREG32(mmHW_STATE);
 
-	if (hdev->asic_prop.fw_security_disabled) {
+	if (!hdev->asic_prop.fw_security_enabled) {
 		/* Set the access through PCI bars (Linux driver only) as
 		 * secured
 		 */
@@ -4129,7 +4129,7 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 	/* Set device to handle FLR by H/W as we will put the device CPU to
 	 * halt mode
 	 */
-	if (hdev->asic_prop.fw_security_disabled &&
+	if (!hdev->asic_prop.fw_security_enabled &&
 				!hdev->asic_prop.hard_reset_done_by_fw)
 		WREG32(mmPCIE_AUX_FLR_CTRL, (PCIE_AUX_FLR_CTRL_HW_CTRL_MASK |
 					PCIE_AUX_FLR_CTRL_INT_MASK_MASK));
@@ -4150,7 +4150,7 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 		WREG32(irq_handler_offset, GAUDI_EVENT_HALT_MACHINE);
 	}
 
-	if (hdev->asic_prop.fw_security_disabled &&
+	if (!hdev->asic_prop.fw_security_enabled &&
 				!hdev->asic_prop.hard_reset_done_by_fw) {
 
 		/* Configure the reset registers. Must be done as early as
@@ -4185,7 +4185,7 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 		WREG32(mmPREBOOT_PCIE_EN, LKD_HARD_RESET_MAGIC);
 
 		/* Restart BTL/BLR upon hard-reset */
-		if (hdev->asic_prop.fw_security_disabled)
+		if (!hdev->asic_prop.fw_security_enabled)
 			WREG32(mmPSOC_GLOBAL_CONF_BOOT_SEQ_RE_START, 1);
 
 		WREG32(mmPSOC_GLOBAL_CONF_SW_ALL_RST,
@@ -7573,7 +7573,7 @@ static int gaudi_hbm_read_interrupts(struct hl_device *hdev, int device,
 		return 0;
 	}
 
-	if (!hdev->asic_prop.fw_security_disabled) {
+	if (hdev->asic_prop.fw_security_enabled) {
 		dev_info(hdev->dev, "Cannot access MC regs for ECC data while security is enabled\n");
 		return 0;
 	}
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
index 6e56fa1c6c69..9e271fd9f0d2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_coresight.c
@@ -634,7 +634,7 @@ static int gaudi_config_etr(struct hl_device *hdev,
 		WREG32(mmPSOC_ETR_BUFWM, 0x3FFC);
 		WREG32(mmPSOC_ETR_RSZ, input->buffer_size);
 		WREG32(mmPSOC_ETR_MODE, input->sink_mode);
-		if (hdev->asic_prop.fw_security_disabled) {
+		if (!hdev->asic_prop.fw_security_enabled) {
 			/* make ETR not privileged */
 			val = FIELD_PREP(
 					PSOC_ETR_AXICTL_PROTCTRLBIT0_MASK, 0);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
index 9a706c5980ef..0d3240f1f7d7 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_security.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
@@ -1448,7 +1448,7 @@ static void gaudi_init_dma_protection_bits(struct hl_device *hdev)
 	u32 pb_addr, mask;
 	u8 word_offset;
 
-	if (hdev->asic_prop.fw_security_disabled) {
+	if (!hdev->asic_prop.fw_security_enabled) {
 		gaudi_pb_set_block(hdev, mmDMA_IF_E_S_BASE);
 		gaudi_pb_set_block(hdev, mmDMA_IF_E_S_DOWN_CH0_BASE);
 		gaudi_pb_set_block(hdev, mmDMA_IF_E_S_DOWN_CH1_BASE);
@@ -9135,7 +9135,7 @@ static void gaudi_init_tpc_protection_bits(struct hl_device *hdev)
 	u32 pb_addr, mask;
 	u8 word_offset;
 
-	if (hdev->asic_prop.fw_security_disabled) {
+	if (!hdev->asic_prop.fw_security_enabled) {
 		gaudi_pb_set_block(hdev, mmTPC0_E2E_CRED_BASE);
 		gaudi_pb_set_block(hdev, mmTPC1_E2E_CRED_BASE);
 		gaudi_pb_set_block(hdev, mmTPC2_E2E_CRED_BASE);
@@ -12818,7 +12818,7 @@ static void gaudi_init_protection_bits(struct hl_device *hdev)
 	 * secured
 	 */
 
-	if (hdev->asic_prop.fw_security_disabled) {
+	if (!hdev->asic_prop.fw_security_enabled) {
 		gaudi_pb_set_block(hdev, mmIF_E_PLL_BASE);
 		gaudi_pb_set_block(hdev, mmMESH_W_PLL_BASE);
 		gaudi_pb_set_block(hdev, mmSRAM_W_PLL_BASE);
@@ -13023,7 +13023,7 @@ void gaudi_init_security(struct hl_device *hdev)
 	 * property configuration of MME SBAB and ACC to be non-privileged and
 	 * non-secured
 	 */
-	if (hdev->asic_prop.fw_security_disabled) {
+	if (!hdev->asic_prop.fw_security_enabled) {
 		WREG32(mmMME0_SBAB_PROT, 0x2);
 		WREG32(mmMME0_ACC_PROT, 0x2);
 		WREG32(mmMME1_SBAB_PROT, 0x2);
@@ -13032,11 +13032,12 @@ void gaudi_init_security(struct hl_device *hdev)
 		WREG32(mmMME2_ACC_PROT, 0x2);
 		WREG32(mmMME3_SBAB_PROT, 0x2);
 		WREG32(mmMME3_ACC_PROT, 0x2);
-	}
 
-	/* On RAZWI, 0 will be returned from RR and 0xBABA0BAD from PB */
-	if (hdev->asic_prop.fw_security_disabled)
+		/*
+		 * On RAZWI, 0 will be returned from RR and 0xBABA0BAD from PB
+		 */
 		WREG32(0xC01B28, 0x1);
+	}
 
 	gaudi_init_range_registers_lbw(hdev);
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 3d7a760cf2ba..bcefc372a689 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -619,7 +619,7 @@ static int goya_early_init(struct hl_device *hdev)
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
 	/* If FW security is enabled at this point it means no access to ELBI */
-	if (!hdev->asic_prop.fw_security_disabled) {
+	if (hdev->asic_prop.fw_security_enabled) {
 		hdev->asic_prop.iatu_done_by_fw = true;
 		goto pci_init;
 	}
@@ -726,7 +726,15 @@ static void goya_fetch_psoc_frequency(struct hl_device *hdev)
 	u16 pll_freq_arr[HL_PLL_NUM_OUTPUTS], freq;
 	int rc;
 
-	if (hdev->asic_prop.fw_security_disabled) {
+	if (hdev->asic_prop.fw_security_enabled) {
+		rc = hl_fw_cpucp_pll_info_get(hdev, HL_GOYA_PCI_PLL,
+				pll_freq_arr);
+
+		if (rc)
+			return;
+
+		freq = pll_freq_arr[1];
+	} else {
 		div_fctr = RREG32(mmPSOC_PCI_PLL_DIV_FACTOR_1);
 		div_sel = RREG32(mmPSOC_PCI_PLL_DIV_SEL_1);
 		nr = RREG32(mmPSOC_PCI_PLL_NR);
@@ -753,14 +761,6 @@ static void goya_fetch_psoc_frequency(struct hl_device *hdev)
 				div_sel);
 			freq = 0;
 		}
-	} else {
-		rc = hl_fw_cpucp_pll_info_get(hdev, HL_GOYA_PCI_PLL,
-				pll_freq_arr);
-
-		if (rc)
-			return;
-
-		freq = pll_freq_arr[1];
 	}
 
 	prop->psoc_timestamp_frequency = freq;
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
index 6b7445cca580..c55c100fdd24 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -434,7 +434,7 @@ static int goya_config_etr(struct hl_device *hdev,
 		WREG32(mmPSOC_ETR_BUFWM, 0x3FFC);
 		WREG32(mmPSOC_ETR_RSZ, input->buffer_size);
 		WREG32(mmPSOC_ETR_MODE, input->sink_mode);
-		if (hdev->asic_prop.fw_security_disabled) {
+		if (!hdev->asic_prop.fw_security_enabled) {
 			/* make ETR not privileged */
 			val = FIELD_PREP(PSOC_ETR_AXICTL_PROTCTRLBIT0_MASK, 0);
 			/* make ETR non-secured (inverted logic) */
-- 
2.25.1

