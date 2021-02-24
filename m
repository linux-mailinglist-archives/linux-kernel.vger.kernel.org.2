Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3994B32424A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhBXQkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235316AbhBXQfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:35:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E80964EF1;
        Wed, 24 Feb 2021 16:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614184471;
        bh=/7nzRW72wpRdycTU5gbE8Mzr0WkUB26k9ukvuay59s8=;
        h=From:To:Cc:Subject:Date:From;
        b=Yg6ltE5JUg7eEng1+7CFhn/Zh7eDWEZ8CzMeff27zWFEK/WcwkQsZr/gmlw1jZ2Fp
         Y78QkPJR893iG458voJjT23XxBEje/Ge+7MG0w94WqoeMw0H2t9Ap8B9aVzv8NOviU
         nkn5HvnYJCQpjYKe7apQjMIfXrvmnjAmAYSV3lXFWltNdzA4+p6WqZhNqxr3QAXcb6
         E4g5Wx52tSXVaNkMxeBX/z+SavcOZG0zQM/ILTzwsvlgSgRELEF1VfuoWYtoKF7VjV
         oh2oTklU/VF5R4lGCbaxwspGIYS7XuJh+3tneHJaMHVfWaP7Pls3jJyftlHAs7wuJp
         QcPdKv+8qzVfw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: use a single FW loading bringup flag
Date:   Wed, 24 Feb 2021 18:34:26 +0200
Message-Id: <20210224163426.4672-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

For simplicity, use a single bringup flag indicating which FW
binaries should loaded to device.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c    | 10 +++++++---
 drivers/misc/habanalabs/common/habanalabs.h     | 11 +++++++----
 drivers/misc/habanalabs/common/habanalabs_drv.c |  3 +--
 drivers/misc/habanalabs/gaudi/gaudi.c           |  2 +-
 drivers/misc/habanalabs/goya/goya.c             |  2 +-
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 09706c571e95..6f3692bf5eff 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -623,7 +623,11 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	u32 status, security_status;
 	int rc;
 
-	if (!hdev->cpu_enable)
+	/* pldm was added for cases in which we use preboot on pldm and want
+	 * to load boot fit, but we can't wait for preboot because it runs
+	 * very slowly
+	 */
+	if (!(hdev->fw_components & FW_TYPE_PREBOOT_CPU) || hdev->pldm)
 		return 0;
 
 	/* Need to check two possible scenarios:
@@ -710,7 +714,7 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	u32 status;
 	int rc;
 
-	if (!(hdev->fw_loading & FW_TYPE_BOOT_CPU))
+	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU))
 		return 0;
 
 	dev_info(hdev->dev, "Going to wait for device boot (up to %lds)\n",
@@ -801,7 +805,7 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		goto out;
 	}
 
-	if (!(hdev->fw_loading & FW_TYPE_LINUX)) {
+	if (!(hdev->fw_components & FW_TYPE_LINUX)) {
 		dev_info(hdev->dev, "Skip loading Linux F/W\n");
 		goto out;
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index ee94953f9ea2..442eca71fd2a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -171,15 +171,19 @@ enum hl_fw_component {
 };
 
 /**
- * enum hl_fw_types - F/W types to load
+ * enum hl_fw_types - F/W types present in the system
  * @FW_TYPE_LINUX: Linux image for device CPU
  * @FW_TYPE_BOOT_CPU: Boot image for device CPU
+ * @FW_TYPE_PREBOOT_CPU: Indicates pre-loaded CPUs are present in the system
+ *                       (preboot, ppboot etc...)
  * @FW_TYPE_ALL_TYPES: Mask for all types
  */
 enum hl_fw_types {
 	FW_TYPE_LINUX = 0x1,
 	FW_TYPE_BOOT_CPU = 0x2,
-	FW_TYPE_ALL_TYPES = (FW_TYPE_LINUX | FW_TYPE_BOOT_CPU)
+	FW_TYPE_PREBOOT_CPU = 0x4,
+	FW_TYPE_ALL_TYPES =
+		(FW_TYPE_LINUX | FW_TYPE_BOOT_CPU | FW_TYPE_PREBOOT_CPU)
 };
 
 /**
@@ -2066,10 +2070,9 @@ struct hl_device {
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
-	u64				fw_loading;
+	u64				fw_components;
 	u8				mmu_enable;
 	u8				mmu_huge_page_opt;
-	u8				cpu_enable;
 	u8				reset_pcilink;
 	u8				cpu_queues_enable;
 	u8				pldm;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index f695ea6253c1..59896566dca1 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -234,8 +234,7 @@ int hl_device_open_ctrl(struct inode *inode, struct file *filp)
 
 static void set_driver_behavior_per_device(struct hl_device *hdev)
 {
-	hdev->cpu_enable = 1;
-	hdev->fw_loading = FW_TYPE_ALL_TYPES;
+	hdev->fw_components = FW_TYPE_ALL_TYPES;
 	hdev->cpu_queues_enable = 1;
 	hdev->heartbeat = 1;
 	hdev->mmu_enable = 1;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index c1f00237273c..4f39737b4808 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3701,7 +3701,7 @@ static int gaudi_init_cpu(struct hl_device *hdev)
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	int rc;
 
-	if (!hdev->cpu_enable)
+	if (!(hdev->fw_components & FW_TYPE_PREBOOT_CPU))
 		return 0;
 
 	if (gaudi->hw_cap_initialized & HW_CAP_CPU)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index a40c428fed94..20abed6ef7e6 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2429,7 +2429,7 @@ static int goya_init_cpu(struct hl_device *hdev)
 	struct goya_device *goya = hdev->asic_specific;
 	int rc;
 
-	if (!hdev->cpu_enable)
+	if (!(hdev->fw_components & FW_TYPE_PREBOOT_CPU))
 		return 0;
 
 	if (goya->hw_cap_initialized & HW_CAP_CPU)
-- 
2.25.1

