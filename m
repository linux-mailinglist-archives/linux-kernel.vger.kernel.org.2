Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C61930C71F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbhBBRLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:11:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236283AbhBBQ4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:56:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2790964E3F;
        Tue,  2 Feb 2021 16:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612284966;
        bh=oU2q3lltU6B8Q5x7Sat8ULXeTGF1gITBfpy/54pO/+0=;
        h=From:To:Cc:Subject:Date:From;
        b=VJ6OEPpw1V7r450/RaqnTSJW3GAPbh4EI8CmOBz6oBIaXQ7Yw9+jLO0Vtxh3vqSy8
         4V/HFCOiyEj3OScUpuVjiYpE2LhZQMkhn0Mbb2iMi5pYNpNl89GzrimuY5axBB76q1
         030PpvnX0p1LTu1NpKZ0BkIACl2qMg9M2Ukc8qsq3ItgXkBr1pm10BDswYLsKJqnpg
         OMd2+QcNFyhvNjbXJacv/9fWw+3EGtFPCDGHV5i+GQawrZ1OtiSKgWmeSOGUlm+0bE
         W3vFdNcuvPnTRc/TJ0UD86VSU9xpw3YQlGZW51R7L/fTdieYy+B8XUBQDcM5nkEJUQ
         YlIsW1oDGxzUQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/4] habanalabs: improve communication protocol with cpucp
Date:   Tue,  2 Feb 2021 18:55:57 +0200
Message-Id: <20210202165600.4620-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Current messaging communictaion protocol with cpucp can get out
of sync due to coherency issues. In order to improve the protocol
reliability, we modify the protocol to expect a different
acknowledgment for every packet sent to cpucp.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c    | 17 +++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h     |  3 +++
 drivers/misc/habanalabs/gaudi/gaudi.c           |  6 +++++-
 drivers/misc/habanalabs/goya/goya.c             |  6 +++++-
 .../misc/habanalabs/include/common/hl_boot_if.h |  5 +++++
 5 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index ba6920f2b4ab..31b52a223f02 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -90,9 +90,10 @@ int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
 int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 				u16 len, u32 timeout, u64 *result)
 {
+	struct hl_hw_queue *queue = &hdev->kernel_queues[hw_queue_id];
 	struct cpucp_packet *pkt;
 	dma_addr_t pkt_dma_addr;
-	u32 tmp;
+	u32 tmp, expected_ack_val;
 	int rc = 0;
 
 	pkt = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev, len,
@@ -115,14 +116,22 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 		goto out;
 	}
 
+	/* set fence to a non valid value */
+	pkt->fence = UINT_MAX;
+
 	rc = hl_hw_queue_send_cb_no_cmpl(hdev, hw_queue_id, len, pkt_dma_addr);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to send CB on CPU PQ (%d)\n", rc);
 		goto out;
 	}
 
+	if (hdev->asic_prop.fw_cpucp_ack_with_pi)
+		expected_ack_val = queue->pi;
+	else
+		expected_ack_val = CPUCP_PACKET_FENCE_VAL;
+
 	rc = hl_poll_timeout_memory(hdev, &pkt->fence, tmp,
-				(tmp == CPUCP_PACKET_FENCE_VAL), 1000,
+				(tmp == expected_ack_val), 1000,
 				timeout, true);
 
 	hl_hw_queue_inc_ci_kernel(hdev, hw_queue_id);
@@ -777,6 +786,10 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
 
+		if (prop->fw_boot_cpu_security_map &
+				CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN)
+			prop->fw_cpucp_ack_with_pi = true;
+
 		dev_dbg(hdev->dev,
 			"Firmware boot CPU security status %#x\n",
 			prop->fw_boot_cpu_security_map);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 30f32f2edb8a..3c54010f7ab9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -419,6 +419,8 @@ struct hl_mmu_properties {
  *                            from BOOT_DEV_STS0
  * @dram_supports_virtual_memory: is there an MMU towards the DRAM
  * @hard_reset_done_by_fw: true if firmware is handling hard reset flow
+ * @fw_cpucp_ack_with_pi: true if cpucp is acking messages with the PQ PI
+ *                        instead of a magic number
  * @num_functional_hbms: number of functional HBMs in each DCORE.
  */
 struct asic_fixed_properties {
@@ -479,6 +481,7 @@ struct asic_fixed_properties {
 	u8				fw_security_status_valid;
 	u8				dram_supports_virtual_memory;
 	u8				hard_reset_done_by_fw;
+	u8				fw_cpucp_ack_with_pi;
 	u8				num_functional_hbms;
 };
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 52fcaf25531a..006c34ae35c2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -533,6 +533,7 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
 	prop->hard_reset_done_by_fw = false;
+	prop->fw_cpucp_ack_with_pi = false;
 
 	return 0;
 }
@@ -4438,9 +4439,12 @@ static void gaudi_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 	/* ring the doorbell */
 	WREG32(db_reg_offset, db_value);
 
-	if (hw_queue_id == GAUDI_QUEUE_ID_CPU_PQ)
+	if (hw_queue_id == GAUDI_QUEUE_ID_CPU_PQ) {
+		/* make sure device CPU will read latest data from host */
+		mb();
 		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
 				GAUDI_EVENT_PI_UPDATE);
+	}
 }
 
 static void gaudi_pqe_write(struct hl_device *hdev, __le64 *pqe,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index a954e7c02375..53db7e966866 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -461,6 +461,7 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
 	prop->hard_reset_done_by_fw = false;
+	prop->fw_cpucp_ack_with_pi = false;
 
 	return 0;
 }
@@ -2806,9 +2807,12 @@ void goya_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 	/* ring the doorbell */
 	WREG32(db_reg_offset, db_value);
 
-	if (hw_queue_id == GOYA_QUEUE_ID_CPU_PQ)
+	if (hw_queue_id == GOYA_QUEUE_ID_CPU_PQ) {
+		/* make sure device CPU will read latest data from host */
+		mb();
 		WREG32(mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR,
 				GOYA_ASYNC_EVENT_ID_PI_UPDATE);
+	}
 }
 
 void goya_pqe_write(struct hl_device *hdev, __le64 *pqe, struct hl_bd *bd)
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 57785478a4ef..e87f5a98e193 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -166,6 +166,10 @@
  *					FW handles HBM ECC indications.
  *					Initialized in: linux
  *
+ * CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN	Packets ack value used in the armcpd
+ *					is set to the PI counter.
+ *					Initialized in: linux
+ *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
  *					running FW populates the device status
@@ -190,6 +194,7 @@
 #define CPU_BOOT_DEV_STS0_SP_SRAM_EN			(1 << 12)
 #define CPU_BOOT_DEV_STS0_CLK_GATE_EN			(1 << 13)
 #define CPU_BOOT_DEV_STS0_HBM_ECC_EN			(1 << 14)
+#define CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN			(1 << 15)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 
 enum cpu_boot_status {
-- 
2.25.1

