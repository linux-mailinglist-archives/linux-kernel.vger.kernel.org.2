Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10E0362EC1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhDQJHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235945AbhDQJHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:07:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96560611EF;
        Sat, 17 Apr 2021 09:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618650408;
        bh=DlVbR0iOKpjyJoiok3TeJsPJ5/H/kK0Y/SAU+RhxKFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHwXn6WO+rZenA0b46HeEunzTEQEgU/i3PgDZdfr5BBGaWrVUKUC4gsXiusJ/UeOa
         y4V5EfYsuHJA22Djb3/USgnUYR+u+jtO8SCaUrJwvt8LhHu5+7WLCetRTz5Mq9ec6u
         hbeqb+PZemyxsTLQgTLcChf+mJS9WMWMDtSsNLuva8XXPKLSUv/7lsCVU4xLAeTr5a
         eiw9QoynDp+M3X9zpdoWYbMATD80vtPSW8hJItXTiSFjZLsg6UpQp/QWenpI4tBcLR
         vJaC+fe9+21/gw3W5esMvHYgtmY1+x51003Wpd0MWxzzz1C0RlhJ+1ld5YEgbaCQv9
         IPL6Y1JqGf4jg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 4/7] habanalabs: prepare preboot stage to dynamic f/w load
Date:   Sat, 17 Apr 2021 12:06:35 +0300
Message-Id: <20210417090638.9802-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417090638.9802-1-ogabbay@kernel.org>
References: <20210417090638.9802-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Start the skeleton for the dynamic F/W load by marking current preboot
code path as legacy.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 79 ++++++++++++++++----
 drivers/misc/habanalabs/common/habanalabs.h  |  8 +-
 2 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 7cf82da67dab..337c76fb5e3c 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -811,21 +811,15 @@ static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 	}
 }
 
-int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
-		u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
-		u32 timeout)
+static int hl_fw_read_preboot_caps(struct hl_device *hdev,
+					u32 cpu_boot_status_reg,
+					u32 cpu_boot_caps_reg,
+					u32 boot_err0_reg, u32 timeout)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 status, security_status;
+	u32 status;
 	int rc;
 
-	/* pldm was added for cases in which we use preboot on pldm and want
-	 * to load boot fit, but we can't wait for preboot because it runs
-	 * very slowly
-	 */
-	if (!(hdev->fw_components & FW_TYPE_PREBOOT_CPU) || hdev->pldm)
-		return 0;
-
 	/* Need to check two possible scenarios:
 	 *
 	 * CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT - for newer firmwares where
@@ -848,18 +842,41 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		timeout);
 
 	if (rc) {
-		dev_err(hdev->dev, "Failed to read preboot version\n");
+		dev_err(hdev->dev, "CPU boot ready status timeout\n");
 		detect_cpu_boot_status(hdev, status);
-		fw_read_errors(hdev, boot_err0_reg,
-				cpu_security_boot_status_reg);
+		fw_read_errors(hdev, boot_err0_reg, cpu_boot_status_reg);
 		return -EIO;
 	}
 
+	prop->fw_preboot_caps_map = RREG32(cpu_boot_caps_reg);
+
+	/*
+	 * For now- force dynamic_fw_load to false as LKD does not yet
+	 * implements all necessary parts of it.
+	 * TODO: once dynamic load is ready set to:
+	 * prop->dynamic_fw_load = !!(prop->fw_preboot_caps_map &
+	 *                                CPU_BOOT_DEV_STS0_FW_LD_COM_EN)
+	 */
+	prop->dynamic_fw_load = 0;
+
+	dev_dbg(hdev->dev, "Attempting %s FW load\n",
+			prop->dynamic_fw_load ? "dynamic" : "legacy");
+	return 0;
+}
+
+static int hl_fw_read_preboot_status_legacy(struct hl_device *hdev,
+		u32 cpu_boot_status_reg, u32 cpu_security_boot_status_reg,
+		u32 boot_err0_reg, u32 timeout)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 security_status;
+	int rc;
+
 	rc = hdev->asic_funcs->read_device_fw_version(hdev, FW_COMP_PREBOOT);
 	if (rc)
 		return rc;
 
-	security_status = RREG32(cpu_security_boot_status_reg);
+	security_status = prop->fw_preboot_caps_map;
 
 	/* We read security status multiple times during boot:
 	 * 1. preboot - a. Check whether the security status bits are valid
@@ -901,6 +918,38 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	return 0;
 }
 
+int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
+		u32 cpu_boot_caps_reg, u32 boot_err0_reg,
+		u32 timeout)
+{
+	int rc;
+
+	/* pldm was added for cases in which we use preboot on pldm and want
+	 * to load boot fit, but we can't wait for preboot because it runs
+	 * very slowly
+	 */
+	if (!(hdev->fw_components & FW_TYPE_PREBOOT_CPU) || hdev->pldm)
+		return 0;
+
+	/*
+	 * In order to determine boot method (static VS dymanic) we need to
+	 * read the boot caps register
+	 */
+	rc = hl_fw_read_preboot_caps(hdev, cpu_boot_status_reg,
+				cpu_boot_caps_reg, boot_err0_reg,
+				timeout);
+	if (rc)
+		return rc;
+
+	if (!hdev->asic_prop.dynamic_fw_load)
+		return hl_fw_read_preboot_status_legacy(hdev, cpu_boot_status_reg,
+				cpu_boot_caps_reg, boot_err0_reg,
+				timeout);
+
+	dev_err(hdev->dev, "Dynamic FW load is not supported\n");
+	return -EINVAL;
+}
+
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
 			u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 91291a8e201e..6441a270e10a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -420,6 +420,9 @@ struct hl_mmu_properties {
  * @cb_pool_cb_size: size of each CB in the CB pool.
  * @max_pending_cs: maximum of concurrent pending command submissions
  * @max_queues: maximum amount of queues in the system
+ * @fw_preboot_caps_map: bitmap representation of preboot cpu capabilities
+ *                              reported by FW, bit description can be found in
+ *                              CPU_BOOT_DEV_STS*
  * @fw_boot_cpu_security_map: bitmap representation of boot cpu security status
  *                            reported by FW, bit description can be found in
  *                            CPU_BOOT_DEV_STS*
@@ -446,6 +449,7 @@ struct hl_mmu_properties {
  * @hard_reset_done_by_fw: true if firmware is handling hard reset flow
  * @num_functional_hbms: number of functional HBMs in each DCORE.
  * @iatu_done_by_fw: true if iATU configuration is being done by FW.
+ * @dynamic_fw_load: is dynamic FW load is supported.
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -491,6 +495,7 @@ struct asic_fixed_properties {
 	u32				cb_pool_cb_size;
 	u32				max_pending_cs;
 	u32				max_queues;
+	u32				fw_preboot_caps_map;
 	u32				fw_boot_cpu_security_map;
 	u32				fw_app_security_map;
 	u16				collective_first_sob;
@@ -510,6 +515,7 @@ struct asic_fixed_properties {
 	u8				hard_reset_done_by_fw;
 	u8				num_functional_hbms;
 	u8				iatu_done_by_fw;
+	u8				dynamic_fw_load;
 };
 
 /**
@@ -2397,7 +2403,7 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
 			bool skip_bmc, u32 cpu_timeout, u32 boot_fit_timeout);
 int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
-		u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
+		u32 cpu_boot_caps_reg, u32 boot_err0_reg,
 		u32 timeout);
 
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
-- 
2.25.1

