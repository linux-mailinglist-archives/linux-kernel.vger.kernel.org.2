Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C03358825
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhDHPXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232066AbhDHPW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:22:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B03461107;
        Thu,  8 Apr 2021 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617895365;
        bh=7WFAnQ/8djE+dqJ6MwJ6l6HQ1G1zogJCj7MupyVIWXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LoPBhkPPkuJlDRP4wlRR9OJNyNSySSvHAjGLNh6QLP6+Ia4SBs4g+hHaCJ9LPS7d0
         bNSnbULz4lrfbo7E4JNq3Qny5dyAPaU4jQ0ID6eoUFIq6wdIO/rjVaw5HQYILv/Gio
         f9U9ggq/T/21Q/a+kdoTO/JoHxY9W5yXp7t4jK4qZMXtYxZRxOEcrzt35DKj0yOQt4
         6pFonr/oHQ8llmN0ymYmSge0UjBJklpbmcyPIDK+Jipx12bJhP38QRfgBSoWFoNVxR
         81mFP3MibQ+UhXuVYwQoOGz8MIng/qpiIVCY6W5R+l5SsN2b9SwaacnPbUu9c5t3/j
         TIiibxazY7J1g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 5/7] habanalabs/gaudi: skip iATU if F/W security is enabled
Date:   Thu,  8 Apr 2021 18:22:32 +0300
Message-Id: <20210408152234.15383-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408152234.15383-1-ogabbay@kernel.org>
References: <20210408152234.15383-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As part of the securing GAUDI, the F/W will configure the PCI iATU
regions. If the driver identifies a secured PCI ID, it will know to
skip iATU configuration in a very early stage.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  3 ++
 drivers/misc/habanalabs/common/pci/pci.c    | 52 +++++++++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 23 +++++++++
 drivers/misc/habanalabs/goya/goya.c         | 24 +++++++++-
 4 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index c1b46126c522..44e89da30b4a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -445,6 +445,7 @@ struct hl_mmu_properties {
  * @dram_supports_virtual_memory: is there an MMU towards the DRAM
  * @hard_reset_done_by_fw: true if firmware is handling hard reset flow
  * @num_functional_hbms: number of functional HBMs in each DCORE.
+ * @iatu_done_by_fw: true if iATU configuration is being done by FW.
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -508,6 +509,7 @@ struct asic_fixed_properties {
 	u8				dram_supports_virtual_memory;
 	u8				hard_reset_done_by_fw;
 	u8				num_functional_hbms;
+	u8				iatu_done_by_fw;
 };
 
 /**
@@ -2400,6 +2402,7 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 			bool is_wc[3]);
+int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data);
 int hl_pci_iatu_write(struct hl_device *hdev, u32 addr, u32 data);
 int hl_pci_set_inbound_region(struct hl_device *hdev, u8 region,
 		struct hl_inbound_pci_region *pci_region);
diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index b799f9258fb0..e941b7eef346 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -85,6 +85,58 @@ static void hl_pci_bars_unmap(struct hl_device *hdev)
 	pci_release_regions(pdev);
 }
 
+int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data)
+{
+	struct pci_dev *pdev = hdev->pdev;
+	ktime_t timeout;
+	u64 msec;
+	u32 val;
+
+	if (hdev->pldm)
+		msec = HL_PLDM_PCI_ELBI_TIMEOUT_MSEC;
+	else
+		msec = HL_PCI_ELBI_TIMEOUT_MSEC;
+
+	/* Clear previous status */
+	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_STS, 0);
+
+	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_ADDR, (u32) addr);
+	pci_write_config_dword(pdev, mmPCI_CONFIG_ELBI_CTRL, 0);
+
+	timeout = ktime_add_ms(ktime_get(), msec);
+	for (;;) {
+		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_STS, &val);
+		if (val & PCI_CONFIG_ELBI_STS_MASK)
+			break;
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_STS,
+						&val);
+			break;
+		}
+
+		usleep_range(300, 500);
+	}
+
+	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE) {
+		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_DATA, data);
+
+		return 0;
+	}
+
+	if (val & PCI_CONFIG_ELBI_STS_ERR) {
+		dev_err(hdev->dev, "Error reading from ELBI\n");
+		return -EIO;
+	}
+
+	if (!(val & PCI_CONFIG_ELBI_STS_MASK)) {
+		dev_err(hdev->dev, "ELBI read didn't finish in time\n");
+		return -EIO;
+	}
+
+	dev_err(hdev->dev, "ELBI read has undefined bits in status\n");
+	return -EIO;
+}
+
 /**
  * hl_pci_elbi_write() - Write through the ELBI interface.
  * @hdev: Pointer to hl_device structure.
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 841748392e49..8730b691ec61 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -629,6 +629,11 @@ static int gaudi_init_iatu(struct hl_device *hdev)
 	struct hl_outbound_pci_region outbound_region;
 	int rc;
 
+	if (hdev->asic_prop.iatu_done_by_fw) {
+		hdev->asic_funcs->set_dma_mask_from_fw(hdev);
+		return 0;
+	}
+
 	/* Inbound Region 0 - Bar 0 - Point to SRAM + CFG */
 	inbound_region.mode = PCI_BAR_MATCH_MODE;
 	inbound_region.bar = SRAM_BAR_ID;
@@ -673,6 +678,7 @@ static int gaudi_early_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct pci_dev *pdev = hdev->pdev;
+	u32 fw_boot_status;
 	int rc;
 
 	rc = gaudi_get_fixed_properties(hdev);
@@ -706,6 +712,23 @@ static int gaudi_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, HBM_BAR_ID);
 
+	/* If FW security is enabled at this point it means no access to ELBI */
+	if (!hdev->asic_prop.fw_security_disabled) {
+		hdev->asic_prop.iatu_done_by_fw = true;
+		goto pci_init;
+	}
+
+	rc = hl_pci_elbi_read(hdev, CFG_BASE + mmCPU_BOOT_DEV_STS0,
+				&fw_boot_status);
+	if (rc)
+		goto free_queue_props;
+
+	/* Check whether FW is configuring iATU */
+	if ((fw_boot_status & CPU_BOOT_DEV_STS0_ENABLED) &&
+			(fw_boot_status & CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN))
+		hdev->asic_prop.iatu_done_by_fw = true;
+
+pci_init:
 	rc = hl_pci_init(hdev);
 	if (rc)
 		goto free_queue_props;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 44dd4d8d8822..e27338f4aad2 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -555,6 +555,11 @@ static int goya_init_iatu(struct hl_device *hdev)
 	struct hl_outbound_pci_region outbound_region;
 	int rc;
 
+	if (hdev->asic_prop.iatu_done_by_fw) {
+		hdev->asic_funcs->set_dma_mask_from_fw(hdev);
+		return 0;
+	}
+
 	/* Inbound Region 0 - Bar 0 - Point to SRAM and CFG */
 	inbound_region.mode = PCI_BAR_MATCH_MODE;
 	inbound_region.bar = SRAM_CFG_BAR_ID;
@@ -602,7 +607,7 @@ static int goya_early_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct pci_dev *pdev = hdev->pdev;
-	u32 val;
+	u32 fw_boot_status, val;
 	int rc;
 
 	rc = goya_get_fixed_properties(hdev);
@@ -636,6 +641,23 @@ static int goya_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
+	/* If FW security is enabled at this point it means no access to ELBI */
+	if (!hdev->asic_prop.fw_security_disabled) {
+		hdev->asic_prop.iatu_done_by_fw = true;
+		goto pci_init;
+	}
+
+	rc = hl_pci_elbi_read(hdev, CFG_BASE + mmCPU_BOOT_DEV_STS0,
+				&fw_boot_status);
+	if (rc)
+		goto free_queue_props;
+
+	/* Check whether FW is configuring iATU */
+	if ((fw_boot_status & CPU_BOOT_DEV_STS0_ENABLED) &&
+			(fw_boot_status & CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN))
+		hdev->asic_prop.iatu_done_by_fw = true;
+
+pci_init:
 	rc = hl_pci_init(hdev);
 	if (rc)
 		goto free_queue_props;
-- 
2.25.1

