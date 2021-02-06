Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66088311F28
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 18:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhBFRkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 12:40:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhBFRkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 12:40:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF54764DAF;
        Sat,  6 Feb 2021 17:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612633199;
        bh=M7HdCCmFBU+B8QOQD4rZtkG7F6vLIw3MFm5y/918lJk=;
        h=From:To:Cc:Subject:Date:From;
        b=FSJ0SNkrxiOpsfX7zowC1OHX/Et7yLp4OKtQAq6cqWU48T57xATiSrmH4IjXIVzAF
         +wIoqJJKKw0hKO9o/mlI60GRTYQm2WXuOJ8xdmp22wkYHSMJmie4uDK6IntVVdXuA4
         OXRezIuIPLXJXqo2oXMXWs/JD0QCWT3g1tscmQ8gibHu65HHsPVCwfwlAlKKRiS97G
         /UEwIzHDYAKy1bphkXbXPvqL5C8bTDYBmnCkHdNljGnU7YwVSqzfxTgpUnST+SHIsJ
         EKLgLRVaytHHsm2Yub8HFlb75fkjMjTFSwp21bQ077uhxPYoTypRhDNCRWYYFoN3JY
         6YR1kfxwXPN7g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/3] habanalabs: update security map after init CPU Qs
Date:   Sat,  6 Feb 2021 19:39:52 +0200
Message-Id: <20210206173954.4662-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

when reading CPU_BOOT_DEV_STS0 reg after FW reports SRAM AVAILABLE the
value in the register might not yet be updated by FW.
to overcome this issue another "up-to-date" read of this register is
done at the end of CPU queues init.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 7 ++-----
 drivers/misc/habanalabs/common/habanalabs.h  | 3 ---
 drivers/misc/habanalabs/gaudi/gaudi.c        | 6 +++++-
 drivers/misc/habanalabs/goya/goya.c          | 6 +++++-
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 31b52a223f02..09706c571e95 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -125,7 +125,8 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 		goto out;
 	}
 
-	if (hdev->asic_prop.fw_cpucp_ack_with_pi)
+	if (hdev->asic_prop.fw_app_security_map &
+			CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN)
 		expected_ack_val = queue->pi;
 	else
 		expected_ack_val = CPUCP_PACKET_FENCE_VAL;
@@ -786,10 +787,6 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 				CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
 
-		if (prop->fw_boot_cpu_security_map &
-				CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN)
-			prop->fw_cpucp_ack_with_pi = true;
-
 		dev_dbg(hdev->dev,
 			"Firmware boot CPU security status %#x\n",
 			prop->fw_boot_cpu_security_map);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 18ed3a6000b0..46c37b0c704a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -420,8 +420,6 @@ struct hl_mmu_properties {
  *                            from BOOT_DEV_STS0
  * @dram_supports_virtual_memory: is there an MMU towards the DRAM
  * @hard_reset_done_by_fw: true if firmware is handling hard reset flow
- * @fw_cpucp_ack_with_pi: true if cpucp is acking messages with the PQ PI
- *                        instead of a magic number
  * @num_functional_hbms: number of functional HBMs in each DCORE.
  */
 struct asic_fixed_properties {
@@ -483,7 +481,6 @@ struct asic_fixed_properties {
 	u8				fw_security_status_valid;
 	u8				dram_supports_virtual_memory;
 	u8				hard_reset_done_by_fw;
-	u8				fw_cpucp_ack_with_pi;
 	u8				num_functional_hbms;
 };
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 6905857b363b..f937d90786b2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -536,7 +536,6 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
 	prop->hard_reset_done_by_fw = false;
-	prop->fw_cpucp_ack_with_pi = false;
 
 	return 0;
 }
@@ -3727,6 +3726,7 @@ static int gaudi_init_cpu(struct hl_device *hdev)
 static int gaudi_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct hl_eq *eq;
 	u32 status;
 	struct hl_hw_queue *cpu_pq =
@@ -3783,6 +3783,10 @@ static int gaudi_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
 		return -EIO;
 	}
 
+	/* update FW application security bits */
+	if (prop->fw_security_status_valid)
+		prop->fw_app_security_map = RREG32(mmCPU_BOOT_DEV_STS0);
+
 	gaudi->hw_cap_initialized |= HW_CAP_CPU_Q;
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index af6a5760924c..c30524660761 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -464,7 +464,6 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
 	prop->hard_reset_done_by_fw = false;
-	prop->fw_cpucp_ack_with_pi = false;
 
 	return 0;
 }
@@ -1189,6 +1188,7 @@ static int goya_stop_external_queues(struct hl_device *hdev)
 int goya_init_cpu_queues(struct hl_device *hdev)
 {
 	struct goya_device *goya = hdev->asic_specific;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct hl_eq *eq;
 	u32 status;
 	struct hl_hw_queue *cpu_pq = &hdev->kernel_queues[GOYA_QUEUE_ID_CPU_PQ];
@@ -1241,6 +1241,10 @@ int goya_init_cpu_queues(struct hl_device *hdev)
 		return -EIO;
 	}
 
+	/* update FW application security bits */
+	if (prop->fw_security_status_valid)
+		prop->fw_app_security_map = RREG32(mmCPU_BOOT_DEV_STS0);
+
 	goya->hw_cap_initialized |= HW_CAP_CPU_Q;
 	return 0;
 }
-- 
2.25.1

