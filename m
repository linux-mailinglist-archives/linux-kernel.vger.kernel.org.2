Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32042358822
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhDHPWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232030AbhDHPWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:22:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F80A61103;
        Thu,  8 Apr 2021 15:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617895361;
        bh=BMdHucnTXRdaoxXclI1p5JaKZcHIxSTIywiZluPCLwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X46/pcV5T1nCHQlDve37u1GGDvvU56nss+YPpIXdTyQ4qtm5En24YFdJlrfDsJKgb
         8V/nbJeAeZM0682PbGI04NcctrsOAQPRsdFKktjYL2s0v94QFHoHIaPjzH24iN2K7T
         RCBVi8CG0sFYtLzdULFRO3RsNu851oiT1kbRgzn6QIX9ZISSeNRXhy7F8BqKn6T+ln
         g5uVDofiIY+NMMh9le+IBnglCipR7kSncMMZVgaXrTbbAbJenxG2CfkjiWez9DxzqE
         CXJy1LxsaYmfIfIo1l7cVuv/TzDkxKzXmBUDhy9dnfTC8oXgVI6udhjMKG9oiUWMeZ
         NUKlpSgWQzO/g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/7] habanalabs: send dynamic msi-x indexes to f/w
Date:   Thu,  8 Apr 2021 18:22:29 +0300
Message-Id: <20210408152234.15383-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408152234.15383-1-ogabbay@kernel.org>
References: <20210408152234.15383-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

In order to minimize hard coded values between F/W and the driver, we
send msi-x indexes dynamically to the F/W.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 67 +++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  4 +
 drivers/misc/habanalabs/gaudi/gaudi.c         |  2 +-
 drivers/misc/habanalabs/goya/goya.c           |  2 +-
 .../misc/habanalabs/include/common/cpucp_if.h | 75 ++++++++++++++-----
 5 files changed, 131 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index d81a8d537373..532a2fd7bfb4 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -422,6 +422,73 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev,
 	return rc;
 }
 
+static int hl_fw_send_msi_info_msg(struct hl_device *hdev)
+{
+	struct cpucp_array_data_packet *pkt;
+	size_t total_pkt_size, data_size;
+	u64 result;
+	int rc;
+
+	/* skip sending this info for unsupported ASICs */
+	if (!hdev->asic_funcs->get_msi_info)
+		return 0;
+
+	data_size = CPUCP_NUM_OF_MSI_TYPES * sizeof(u32);
+	total_pkt_size = sizeof(struct cpucp_array_data_packet) + data_size;
+
+	/* data should be aligned to 8 bytes in order to CPU-CP to copy it */
+	total_pkt_size = (total_pkt_size + 0x7) & ~0x7;
+
+	/* total_pkt_size is casted to u16 later on */
+	if (total_pkt_size > USHRT_MAX) {
+		dev_err(hdev->dev, "CPUCP array data is too big\n");
+		return -EINVAL;
+	}
+
+	pkt = kzalloc(total_pkt_size, GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
+
+	pkt->length = cpu_to_le32(CPUCP_NUM_OF_MSI_TYPES);
+
+	hdev->asic_funcs->get_msi_info((u32 *)&pkt->data);
+
+	pkt->cpucp_pkt.ctl = cpu_to_le32(CPUCP_PACKET_MSI_INFO_SET <<
+						CPUCP_PKT_CTL_OPCODE_SHIFT);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *)pkt,
+						total_pkt_size, 0, &result);
+
+	/*
+	 * in case packet result is invalid it means that FW does not support
+	 * this feature and will use default/hard coded MSI values. no reason
+	 * to stop the boot
+	 */
+	if (rc && result == cpucp_packet_invalid)
+		rc = 0;
+
+	if (rc)
+		dev_err(hdev->dev, "failed to send CPUCP array data\n");
+
+	kfree(pkt);
+
+	return rc;
+}
+
+int hl_fw_cpucp_handshake(struct hl_device *hdev,
+			u32 cpu_security_boot_status_reg,
+			u32 boot_err0_reg)
+{
+	int rc;
+
+	rc = hl_fw_cpucp_info_get(hdev, cpu_security_boot_status_reg,
+					boot_err0_reg);
+	if (rc)
+		return rc;
+
+	return hl_fw_send_msi_info_msg(hdev);
+}
+
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 {
 	struct cpucp_packet pkt = {};
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index d89ae4c3d634..867986ef4588 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1049,6 +1049,7 @@ struct hl_asic_funcs {
 	int (*hw_block_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
 			u32 block_id, u32 block_size);
 	void (*enable_events_from_fw)(struct hl_device *hdev);
+	void (*get_msi_info)(u32 *table);
 };
 
 
@@ -2374,6 +2375,9 @@ int hl_fw_send_heartbeat(struct hl_device *hdev);
 int hl_fw_cpucp_info_get(struct hl_device *hdev,
 			u32 cpu_security_boot_status_reg,
 			u32 boot_err0_reg);
+int hl_fw_cpucp_handshake(struct hl_device *hdev,
+			u32 cpu_security_boot_status_reg,
+			u32 boot_err0_reg);
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
 int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 791434278904..62e3c63bec20 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7966,7 +7966,7 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
 	if (!(gaudi->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	rc = hl_fw_cpucp_info_get(hdev, mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0);
+	rc = hl_fw_cpucp_handshake(hdev, mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0);
 	if (rc)
 		return rc;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 175b7b0af450..9d49ba649db0 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5245,7 +5245,7 @@ int goya_cpucp_info_get(struct hl_device *hdev)
 	if (!(goya->hw_cap_initialized & HW_CAP_CPU_Q))
 		return 0;
 
-	rc = hl_fw_cpucp_info_get(hdev, mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0);
+	rc = hl_fw_cpucp_handshake(hdev, mmCPU_BOOT_DEV_STS0, mmCPU_BOOT_ERR0);
 	if (rc)
 		return rc;
 
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 88e8ce6e0694..20a710f7a369 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -302,6 +302,27 @@ enum pq_init_status {
  * CPUCP_PACKET_POWER_GET
  *       Fetch the present power consumption of the device (Current * Voltage).
  *
+ * CPUCP_PACKET_NIC_PFC_SET -
+ *       Enable/Disable the NIC PFC feature. The packet's arguments specify the
+ *       NIC port, relevant lanes to configure and one bit indication for
+ *       enable/disable.
+ *
+ * CPUCP_PACKET_NIC_FAULT_GET -
+ *       Fetch the current indication for local/remote faults from the NIC MAC.
+ *       The result is 32-bit value of the relevant register.
+ *
+ * CPUCP_PACKET_NIC_LPBK_SET -
+ *       Enable/Disable the MAC loopback feature. The packet's arguments specify
+ *       the NIC port, relevant lanes to configure and one bit indication for
+ *       enable/disable.
+ *
+ * CPUCP_PACKET_NIC_MAC_INIT -
+ *       Configure the NIC MAC channels. The packet's arguments specify the
+ *       NIC port and the speed.
+ *
+ * CPUCP_PACKET_MSI_INFO_SET -
+ *       set the index number for each supported msi type going from
+ *       host to device
  */
 
 enum cpucp_packet_id {
@@ -337,6 +358,11 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_PLL_INFO_GET,		/* internal */
 	CPUCP_PACKET_NIC_STATUS,		/* internal */
 	CPUCP_PACKET_POWER_GET,			/* internal */
+	CPUCP_PACKET_NIC_PFC_SET,		/* internal */
+	CPUCP_PACKET_NIC_FAULT_GET,		/* internal */
+	CPUCP_PACKET_NIC_LPBK_SET,		/* internal */
+	CPUCP_PACKET_NIC_MAC_CFG,		/* internal */
+	CPUCP_PACKET_MSI_INFO_SET,		/* internal */
 };
 
 #define CPUCP_PACKET_FENCE_VAL	0xFE8CE7A5
@@ -408,6 +434,12 @@ struct cpucp_unmask_irq_arr_packet {
 	__le32 irqs[0];
 };
 
+struct cpucp_array_data_packet {
+	struct cpucp_packet cpucp_pkt;
+	__le32 length;
+	__le32 data[0];
+};
+
 enum cpucp_packet_rc {
 	cpucp_packet_success,
 	cpucp_packet_invalid,
@@ -476,6 +508,22 @@ enum cpucp_pll_type_attributes {
 	cpucp_pll_pci,
 };
 
+/*
+ * MSI type enumeration table for all ASICs and future SW versions.
+ * For future ASIC-LKD compatibility, we can only add new enumerations.
+ * at the end of the table (before CPUCP_NUM_OF_MSI_TYPES).
+ * Changing the order of entries or removing entries is not allowed.
+ */
+enum cpucp_msi_type {
+	CPUCP_EVENT_QUEUE_MSI_TYPE,
+	CPUCP_NIC_PORT1_MSI_TYPE,
+	CPUCP_NIC_PORT3_MSI_TYPE,
+	CPUCP_NIC_PORT5_MSI_TYPE,
+	CPUCP_NIC_PORT7_MSI_TYPE,
+	CPUCP_NIC_PORT9_MSI_TYPE,
+	CPUCP_NUM_OF_MSI_TYPES
+};
+
 /*
  * PLL enumeration table used for all ASICs and future SW versions.
  * For future ASIC-LKD compatibility, we can only add new enumerations.
@@ -492,23 +540,16 @@ enum pll_index {
 	TPC_PLL = 6,
 	IF_PLL = 7,
 	SRAM_PLL = 8,
-	NS_DCORE_PLL = 9,
-	MESH_DCORE_PLL = 10,
-	HBM_PLL = 11,
-	TPC_DCORE_PLL = 12,
-	VIDEO_DCORE_PLL = 13,
-	SRAM_DCORE_PLL = 14,
-	NIC_PHY_DCORE_PLL = 15,
-	MSS_DCORE_PLL = 16,
-	DMA_DCORE_PLL = 17,
-	SIF_PLL = 18,
-	DDR_PLL = 19,
-	VID_PLL = 20,
-	BANK_PLL = 21,
-	MMU_PLL = 22,
-	IC_PLL = 23,
-	MC_PLL = 24,
-	EMMC_PLL = 25,
+	NS_PLL = 9,
+	HBM_PLL = 10,
+	MSS_PLL = 11,
+	DDR_PLL = 12,
+	VID_PLL = 13,
+	BANK_PLL = 14,
+	MMU_PLL = 15,
+	IC_PLL = 16,
+	MC_PLL = 17,
+	EMMC_PLL = 18,
 	PLL_MAX
 };
 
-- 
2.25.1

