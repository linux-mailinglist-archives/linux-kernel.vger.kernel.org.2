Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0941145031C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhKOLJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237623AbhKOLI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:08:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 412F163214;
        Mon, 15 Nov 2021 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636974329;
        bh=C4Hm5E0mc+61aHzvrmU32F+t64ia3wqRLiIL0OVh+M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6qWJCLn7deQDfd17UuokN3XCD1cVxPLCxNgB6fVGHd46zDCnC5gVRcMs0Z5TWWgs
         Rph2OrOOu1DX/YBZQJ6i2tsIXO5+AxJ9waajI02uBKARw/8eZvEfAsgkrR4LULaCUX
         3eIa/LVNwCGPOlSOfl6gzZmNYI71dn4JoTAl4+o1UR5NPXCpAmFIKszqgl+Ijw0ttp
         P3O895VIHgpplYbR36ZWCjbNkphf0f6DKAakfvbuRc/yDSDKUuTcXfq/DV+aoqL4IP
         Bpcza20v0jnEuJgBUhEukd+SqJHNRAxU+8P2/lWnmeYebUfsR5rHHxaJQDEAWTViaR
         MGcfCvGkaKbHA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 3/7] habanalabs: add support for fetching historic errors
Date:   Mon, 15 Nov 2021 13:05:17 +0200
Message-Id: <20211115110521.783103-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115110521.783103-1-ogabbay@kernel.org>
References: <20211115110521.783103-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

A new uAPI is added for debug purposes of the user-space to retrieve
errors related data from previous session (before device reset was
performed).

Inforamtion is filled when a razwi or CS timeout happens and can
contain one of the following:

1. Retrieve timestamp of last time the device was opened and razwi or
   CS timeout happened.
2. Retrieve information about last CS timeout.
3. Retrieve information about last razwi error.

This information doesn't contain user data, so no danger of data
leakage between users.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    |   8 +
 drivers/misc/habanalabs/common/habanalabs.h   |  37 ++++
 .../misc/habanalabs/common/habanalabs_drv.c   |   4 +
 .../misc/habanalabs/common/habanalabs_ioctl.c |  60 +++++++
 drivers/misc/habanalabs/gaudi/gaudi.c         | 167 +++++++++++++-----
 include/uapi/misc/habanalabs.h                |  58 +++++-
 6 files changed, 290 insertions(+), 44 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index e97b21988dea..c1fd4ba14c60 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -733,6 +733,14 @@ static void cs_timedout(struct work_struct *work)
 
 	hdev = cs->ctx->hdev;
 
+	/* Save only the first CS timeout parameters */
+	rc = atomic_cmpxchg(&hdev->last_error.cs_write_disable, 0, 1);
+	if (!rc) {
+		hdev->last_error.open_dev_timestamp = hdev->last_successful_open_ktime;
+		hdev->last_error.cs_timeout_timestamp = ktime_get();
+		hdev->last_error.cs_timeout_seq = cs->sequence;
+	}
+
 	switch (cs->type) {
 	case CS_TYPE_SIGNAL:
 		dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9aa144d2fe40..612a9f461b38 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2405,6 +2405,40 @@ struct hl_clk_throttle {
 	u32		aggregated_reason;
 };
 
+/**
+ * struct last_error_session_info - info about last session in which CS timeout or
+ *                                    razwi error occurred.
+ * @open_dev_timestamp: device open timestamp.
+ * @cs_timeout_timestamp: CS timeout timestamp.
+ * @razwi_timestamp: razwi timestamp.
+ * @cs_write_disable: if set writing to CS parameters in the structure is disabled so the
+ *                    first (root cause) CS timeout will not be overwritten.
+ * @razwi_write_disable: if set writing to razwi parameters in the structure is disabled so the
+ *                       first (root cause) razwi will not be overwritten.
+ * @cs_timeout_seq: CS timeout sequence number.
+ * @razwi_addr: address that caused razwi.
+ * @razwi_engine_id_1: engine id of the razwi initiator, if it was initiated by engine that does
+ *                     not have engine id it will be set to U16_MAX.
+ * @razwi_engine_id_2: second engine id of razwi initiator. Might happen that razwi have 2 possible
+ *                     engines which one them caused the razwi. In that case, it will contain the
+ *                     second possible engine id, otherwise it will be set to U16_MAX.
+ * @razwi_non_engine_initiator: in case the initiator of the razwi does not have engine id.
+ * @razwi_type: cause of razwi, page fault or access error, otherwise it will be set to U8_MAX.
+ */
+struct last_error_session_info {
+	ktime_t		open_dev_timestamp;
+	ktime_t		cs_timeout_timestamp;
+	ktime_t		razwi_timestamp;
+	atomic_t	cs_write_disable;
+	atomic_t	razwi_write_disable;
+	u64		cs_timeout_seq;
+	u64		razwi_addr;
+	u16		razwi_engine_id_1;
+	u16		razwi_engine_id_2;
+	u8		razwi_non_engine_initiator;
+	u8		razwi_type;
+};
+
 /**
  * struct hl_device - habanalabs device structure.
  * @pdev: pointer to PCI device, can be NULL in case of simulator device.
@@ -2488,6 +2522,7 @@ struct hl_clk_throttle {
  *                          device initialization. Mainly used to debug and
  *                          workaround firmware bugs
  * @dram_pci_bar_start: start bus address of PCIe bar towards DRAM.
+ * @last_successful_open_ktime: timestamp (ktime) of the last successful device open.
  * @last_successful_open_jif: timestamp (jiffies) of the last successful
  *                            device open.
  * @last_open_session_duration_jif: duration (jiffies) of the last device open
@@ -2632,6 +2667,7 @@ struct hl_device {
 	struct multi_cs_completion	multi_cs_completion[
 							MULTI_CS_MAX_USER_CTX];
 	struct hl_clk_throttle		clk_throttling;
+	struct last_error_session_info	last_error;
 
 	u32				*stream_master_qid_arr;
 	atomic64_t			dram_used_mem;
@@ -2645,6 +2681,7 @@ struct hl_device {
 	u64				open_counter;
 	u64				fw_poll_interval_usec;
 	atomic_t			in_reset;
+	ktime_t				last_successful_open_ktime;
 	enum hl_pll_frequency		curr_pll_profile;
 	enum cpucp_card_types		card_type;
 	u32				major;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 85034f2f2e89..1070c80d739c 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -187,8 +187,12 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	hl_debugfs_add_file(hpriv);
 
+	atomic_set(&hdev->last_error.cs_write_disable, 0);
+	atomic_set(&hdev->last_error.razwi_write_disable, 0);
+
 	hdev->open_counter++;
 	hdev->last_successful_open_jif = jiffies;
+	hdev->last_successful_open_ktime = ktime_get();
 
 	return 0;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 68c655acdec8..360a1e9bbd5d 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -540,6 +540,57 @@ static int dram_replaced_rows_info(struct hl_fpriv *hpriv, struct hl_info_args *
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
 
+static int last_err_open_dev_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_info_last_err_open_dev_time info = {0};
+	struct hl_device *hdev = hpriv->hdev;
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	info.timestamp = ktime_to_ns(hdev->last_error.open_dev_timestamp);
+
+	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
+}
+
+static int cs_timeout_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_info_cs_timeout_event info = {0};
+	struct hl_device *hdev = hpriv->hdev;
+	u32 max_size = args->return_size;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	info.seq = hdev->last_error.cs_timeout_seq;
+	info.timestamp = ktime_to_ns(hdev->last_error.cs_timeout_timestamp);
+
+	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
+}
+
+static int razwi_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	u32 max_size = args->return_size;
+	struct hl_info_razwi_event info = {0};
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	info.timestamp = ktime_to_ns(hdev->last_error.razwi_timestamp);
+	info.addr = hdev->last_error.razwi_addr;
+	info.engine_id_1 = hdev->last_error.razwi_engine_id_1;
+	info.engine_id_2 = hdev->last_error.razwi_engine_id_2;
+	info.no_engine_id = hdev->last_error.razwi_non_engine_initiator;
+	info.error_type = hdev->last_error.razwi_type;
+
+	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -632,6 +683,15 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_DRAM_PENDING_ROWS:
 		return dram_pending_rows_info(hpriv, args);
 
+	case HL_INFO_LAST_ERR_OPEN_DEV_TIME:
+		return last_err_open_dev_info(hpriv, args);
+
+	case HL_INFO_CS_TIMEOUT_EVENT:
+		return cs_timeout_info(hpriv, args);
+
+	case HL_INFO_RAZWI_EVENT:
+		return razwi_info(hpriv, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index a9e279bfebae..aed55db368d7 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6970,8 +6970,9 @@ static void gaudi_get_event_desc(u16 event_type, char *desc, size_t size)
 	snprintf(desc, size, "N/A");
 }
 
-static const char *gaudi_get_razwi_initiator_dma_name(struct hl_device *hdev,
-							u32 x_y, bool is_write)
+static const char *gaudi_get_razwi_initiator_dma_name(struct hl_device *hdev, u32 x_y,
+							bool is_write, s32 *engine_id_1,
+							s32 *engine_id_2)
 {
 	u32 dma_id[2], dma_offset, err_cause[2], mask, i;
 
@@ -7011,44 +7012,64 @@ static const char *gaudi_get_razwi_initiator_dma_name(struct hl_device *hdev,
 	switch (x_y) {
 	case RAZWI_INITIATOR_ID_X_Y_DMA_IF_W_S_0:
 	case RAZWI_INITIATOR_ID_X_Y_DMA_IF_W_S_1:
-		if ((err_cause[0] & mask) && !(err_cause[1] & mask))
+		if ((err_cause[0] & mask) && !(err_cause[1] & mask)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_0;
 			return "DMA0";
-		else if (!(err_cause[0] & mask) && (err_cause[1] & mask))
+		} else if (!(err_cause[0] & mask) && (err_cause[1] & mask)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_2;
 			return "DMA2";
-		else
+		} else {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_0;
+			*engine_id_2 = GAUDI_ENGINE_ID_DMA_2;
 			return "DMA0 or DMA2";
+		}
 	case RAZWI_INITIATOR_ID_X_Y_DMA_IF_E_S_0:
 	case RAZWI_INITIATOR_ID_X_Y_DMA_IF_E_S_1:
-		if ((err_cause[0] & mask) && !(err_cause[1] & mask))
+		if ((err_cause[0] & mask) && !(err_cause[1] & mask)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_1;
 			return "DMA1";
-		else if (!(err_cause[0] & mask) && (err_cause[1] & mask))
+		} else if (!(err_cause[0] & mask) && (err_cause[1] & mask)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_3;
 			return "DMA3";
-		else
+		} else {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_1;
+			*engine_id_2 = GAUDI_ENGINE_ID_DMA_3;
 			return "DMA1 or DMA3";
+		}
 	case RAZWI_INITIATOR_ID_X_Y_DMA_IF_W_N_0:
 	case RAZWI_INITIATOR_ID_X_Y_DMA_IF_W_N_1:
-		if ((err_cause[0] & mask) && !(err_cause[1] & mask))
+		if ((err_cause[0] & mask) && !(err_cause[1] & mask)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_4;
 			return "DMA4";
-		else if (!(err_cause[0] & mask) && (err_cause[1] & mask))
+		} else if (!(err_cause[0] & mask) && (err_cause[1] & mask)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_6;
 			return "DMA6";
-		else
+		} else {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_4;
+			*engine_id_2 = GAUDI_ENGINE_ID_DMA_6;
 			return "DMA4 or DMA6";
+		}
 	case RAZWI_INITIATOR_ID_X_Y_DMA_IF_E_N_0:
 	case RAZWI_INITIATOR_ID_X_Y_DMA_IF_E_N_1:
-		if ((err_cause[0] & mask) && !(err_cause[1] & mask))
+		if ((err_cause[0] & mask) && !(err_cause[1] & mask)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_5;
 			return "DMA5";
-		else if (!(err_cause[0] & mask) && (err_cause[1] & mask))
+		} else if (!(err_cause[0] & mask) && (err_cause[1] & mask)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_7;
 			return "DMA7";
-		else
+		} else {
+			*engine_id_1 = GAUDI_ENGINE_ID_DMA_5;
+			*engine_id_2 = GAUDI_ENGINE_ID_DMA_7;
 			return "DMA5 or DMA7";
+		}
 	}
 
 unknown_initiator:
 	return "unknown initiator";
 }
 
-static const char *gaudi_get_razwi_initiator_name(struct hl_device *hdev,
-							bool is_write)
+static const char *gaudi_get_razwi_initiator_name(struct hl_device *hdev, bool is_write,
+							u32 *engine_id_1, u32 *engine_id_2)
 {
 	u32 val, x_y, axi_id;
 
@@ -7061,24 +7082,35 @@ static const char *gaudi_get_razwi_initiator_name(struct hl_device *hdev,
 
 	switch (x_y) {
 	case RAZWI_INITIATOR_ID_X_Y_TPC0_NIC0:
-		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_TPC))
+		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_TPC)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_TPC_0;
 			return "TPC0";
-		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_NIC))
+		}
+		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_NIC)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_NIC_0;
 			return "NIC0";
+		}
 		break;
 	case RAZWI_INITIATOR_ID_X_Y_TPC1:
+		*engine_id_1 = GAUDI_ENGINE_ID_TPC_1;
 		return "TPC1";
 	case RAZWI_INITIATOR_ID_X_Y_MME0_0:
 	case RAZWI_INITIATOR_ID_X_Y_MME0_1:
+		*engine_id_1 = GAUDI_ENGINE_ID_MME_0;
 		return "MME0";
 	case RAZWI_INITIATOR_ID_X_Y_MME1_0:
 	case RAZWI_INITIATOR_ID_X_Y_MME1_1:
+		*engine_id_1 = GAUDI_ENGINE_ID_MME_1;
 		return "MME1";
 	case RAZWI_INITIATOR_ID_X_Y_TPC2:
+		*engine_id_1 = GAUDI_ENGINE_ID_TPC_2;
 		return "TPC2";
 	case RAZWI_INITIATOR_ID_X_Y_TPC3_PCI_CPU_PSOC:
-		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_TPC))
+		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_TPC)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_TPC_3;
 			return "TPC3";
+		}
+		/* PCI, CPU or PSOC does not have engine id*/
 		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_PCI))
 			return "PCI";
 		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_CPU))
@@ -7094,32 +7126,49 @@ static const char *gaudi_get_razwi_initiator_name(struct hl_device *hdev,
 	case RAZWI_INITIATOR_ID_X_Y_DMA_IF_W_N_1:
 	case RAZWI_INITIATOR_ID_X_Y_DMA_IF_E_N_0:
 	case RAZWI_INITIATOR_ID_X_Y_DMA_IF_E_N_1:
-		return gaudi_get_razwi_initiator_dma_name(hdev, x_y, is_write);
+		return gaudi_get_razwi_initiator_dma_name(hdev, x_y, is_write,
+				engine_id_1, engine_id_2);
 	case RAZWI_INITIATOR_ID_X_Y_TPC4_NIC1_NIC2:
-		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_TPC))
+		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_TPC)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_TPC_4;
 			return "TPC4";
-		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_NIC))
+		}
+		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_NIC)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_NIC_1;
 			return "NIC1";
-		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_NIC_FT))
+		}
+		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_NIC_FT)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_NIC_2;
 			return "NIC2";
+		}
 		break;
 	case RAZWI_INITIATOR_ID_X_Y_TPC5:
+		*engine_id_1 = GAUDI_ENGINE_ID_TPC_5;
 		return "TPC5";
 	case RAZWI_INITIATOR_ID_X_Y_MME2_0:
 	case RAZWI_INITIATOR_ID_X_Y_MME2_1:
+		*engine_id_1 = GAUDI_ENGINE_ID_MME_2;
 		return "MME2";
 	case RAZWI_INITIATOR_ID_X_Y_MME3_0:
 	case RAZWI_INITIATOR_ID_X_Y_MME3_1:
+		*engine_id_1 = GAUDI_ENGINE_ID_MME_3;
 		return "MME3";
 	case RAZWI_INITIATOR_ID_X_Y_TPC6:
+		*engine_id_1 = GAUDI_ENGINE_ID_TPC_6;
 		return "TPC6";
 	case RAZWI_INITIATOR_ID_X_Y_TPC7_NIC4_NIC5:
-		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_TPC))
+		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_TPC)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_TPC_7;
 			return "TPC7";
-		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_NIC))
+		}
+		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_NIC)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_NIC_4;
 			return "NIC4";
-		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_NIC_FT))
+		}
+		if (axi_id == RAZWI_INITIATOR_ID_AXI_ID(AXI_ID_NIC_FT)) {
+			*engine_id_1 = GAUDI_ENGINE_ID_NIC_5;
 			return "NIC5";
+		}
 		break;
 	default:
 		break;
@@ -7136,27 +7185,28 @@ static const char *gaudi_get_razwi_initiator_name(struct hl_device *hdev,
 	return "unknown initiator";
 }
 
-static void gaudi_print_razwi_info(struct hl_device *hdev)
+static void gaudi_print_and_get_razwi_info(struct hl_device *hdev, u32 *engine_id_1,
+						u32 *engine_id_2)
 {
+
 	if (RREG32(mmMMU_UP_RAZWI_WRITE_VLD)) {
 		dev_err_ratelimited(hdev->dev,
 			"RAZWI event caused by illegal write of %s\n",
-			gaudi_get_razwi_initiator_name(hdev, true));
+			gaudi_get_razwi_initiator_name(hdev, true, engine_id_1, engine_id_2));
 		WREG32(mmMMU_UP_RAZWI_WRITE_VLD, 0);
 	}
 
 	if (RREG32(mmMMU_UP_RAZWI_READ_VLD)) {
 		dev_err_ratelimited(hdev->dev,
 			"RAZWI event caused by illegal read of %s\n",
-			gaudi_get_razwi_initiator_name(hdev, false));
+			gaudi_get_razwi_initiator_name(hdev, false, engine_id_1, engine_id_2));
 		WREG32(mmMMU_UP_RAZWI_READ_VLD, 0);
 	}
 }
 
-static void gaudi_print_mmu_error_info(struct hl_device *hdev)
+static void gaudi_print_and_get_mmu_error_info(struct hl_device *hdev, u64 *addr, u8 *type)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u64 addr;
 	u32 val;
 
 	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU))
@@ -7164,24 +7214,24 @@ static void gaudi_print_mmu_error_info(struct hl_device *hdev)
 
 	val = RREG32(mmMMU_UP_PAGE_ERROR_CAPTURE);
 	if (val & MMU_UP_PAGE_ERROR_CAPTURE_ENTRY_VALID_MASK) {
-		addr = val & MMU_UP_PAGE_ERROR_CAPTURE_VA_49_32_MASK;
-		addr <<= 32;
-		addr |= RREG32(mmMMU_UP_PAGE_ERROR_CAPTURE_VA);
+		*addr = val & MMU_UP_PAGE_ERROR_CAPTURE_VA_49_32_MASK;
+		*addr <<= 32;
+		*addr |= RREG32(mmMMU_UP_PAGE_ERROR_CAPTURE_VA);
 
-		dev_err_ratelimited(hdev->dev, "MMU page fault on va 0x%llx\n",
-					addr);
+		dev_err_ratelimited(hdev->dev, "MMU page fault on va 0x%llx\n", *addr);
+		*type = HL_RAZWI_PAGE_FAULT;
 
 		WREG32(mmMMU_UP_PAGE_ERROR_CAPTURE, 0);
 	}
 
 	val = RREG32(mmMMU_UP_ACCESS_ERROR_CAPTURE);
 	if (val & MMU_UP_ACCESS_ERROR_CAPTURE_ENTRY_VALID_MASK) {
-		addr = val & MMU_UP_ACCESS_ERROR_CAPTURE_VA_49_32_MASK;
-		addr <<= 32;
-		addr |= RREG32(mmMMU_UP_ACCESS_ERROR_CAPTURE_VA);
+		*addr = val & MMU_UP_ACCESS_ERROR_CAPTURE_VA_49_32_MASK;
+		*addr <<= 32;
+		*addr |= RREG32(mmMMU_UP_ACCESS_ERROR_CAPTURE_VA);
 
-		dev_err_ratelimited(hdev->dev,
-				"MMU access error on va 0x%llx\n", addr);
+		dev_err_ratelimited(hdev->dev, "MMU access error on va 0x%llx\n", *addr);
+		*type = HL_RAZWI_MMU_ACCESS_ERROR;
 
 		WREG32(mmMMU_UP_ACCESS_ERROR_CAPTURE, 0);
 	}
@@ -7700,15 +7750,46 @@ static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type)
 static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
 					bool razwi)
 {
+	u32 engine_id_1, engine_id_2;
 	char desc[64] = "";
+	u64 razwi_addr = 0;
+	u8 razwi_type;
+	int rc;
+
+	/*
+	 * Init engine id by default as not valid and only if razwi initiated from engine with
+	 * engine id it will get valid value.
+	 * Init razwi type to default, will be changed only if razwi caused by page fault of
+	 * MMU access error
+	 */
+	engine_id_1 = U16_MAX;
+	engine_id_2 = U16_MAX;
+	razwi_type = U8_MAX;
 
 	gaudi_get_event_desc(event_type, desc, sizeof(desc));
 	dev_err_ratelimited(hdev->dev, "Received H/W interrupt %d [\"%s\"]\n",
 		event_type, desc);
 
 	if (razwi) {
-		gaudi_print_razwi_info(hdev);
-		gaudi_print_mmu_error_info(hdev);
+		gaudi_print_and_get_razwi_info(hdev, &engine_id_1, &engine_id_2);
+		gaudi_print_and_get_mmu_error_info(hdev, &razwi_addr, &razwi_type);
+
+		/* In case it's the first razwi, save its parameters*/
+		rc = atomic_cmpxchg(&hdev->last_error.razwi_write_disable, 0, 1);
+		if (!rc) {
+			hdev->last_error.open_dev_timestamp = hdev->last_successful_open_ktime;
+			hdev->last_error.razwi_timestamp = ktime_get();
+			hdev->last_error.razwi_addr = razwi_addr;
+			hdev->last_error.razwi_engine_id_1 = engine_id_1;
+			hdev->last_error.razwi_engine_id_2 = engine_id_2;
+			/*
+			 * If first engine id holds non valid value the razwi initiator
+			 * does not have engine id
+			 */
+			hdev->last_error.razwi_non_engine_initiator = (engine_id_1 == U16_MAX);
+			hdev->last_error.razwi_type = razwi_type;
+
+		}
 	}
 }
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 9b4d72897061..eb8565fdae70 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -336,6 +336,14 @@ enum hl_server_type {
  * HL_INFO_OPEN_STATS    - Retrieve info regarding recent device open calls
  * HL_INFO_DRAM_REPLACED_ROWS - Retrieve DRAM replaced rows info
  * HL_INFO_DRAM_PENDING_ROWS - Retrieve DRAM pending rows num
+ * HL_INFO_LAST_ERR_OPEN_DEV_TIME - Retrieve timestamp of the last time the device was opened
+ *                                  and CS timeout or razwi error occurred.
+ * HL_INFO_CS_TIMEOUT_EVENT - Retrieve CS timeout timestamp and its related CS sequence number.
+ * HL_INFO_RAZWI_EVENT - Retrieve parameters of razwi:
+ *                            Timestamp of razwi.
+ *                            The address which accessing it caused the razwi.
+ *                            Razwi initiator.
+ *                            Razwi cause, was it a page fault or MMU access error.
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
@@ -357,8 +365,11 @@ enum hl_server_type {
 #define HL_INFO_OPEN_STATS		18
 #define HL_INFO_DRAM_REPLACED_ROWS	21
 #define HL_INFO_DRAM_PENDING_ROWS	22
+#define HL_INFO_LAST_ERR_OPEN_DEV_TIME	23
+#define HL_INFO_CS_TIMEOUT_EVENT	24
+#define HL_INFO_RAZWI_EVENT		25
 
-#define HL_INFO_VERSION_MAX_LEN	128
+#define HL_INFO_VERSION_MAX_LEN		128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
 
 /**
@@ -575,6 +586,51 @@ struct hl_info_cs_counters {
 	__u64 ctx_validation_drop_cnt;
 };
 
+/**
+ * struct hl_info_last_err_open_dev_time - last error boot information.
+ * @timestamp: timestamp of last time the device was opened and error occurred.
+ */
+struct hl_info_last_err_open_dev_time {
+	__s64 timestamp;
+};
+
+/**
+ * struct hl_info_cs_timeout_event - last CS timeout information.
+ * @timestamp: timestamp when last CS timeout event occurred.
+ * @seq: sequence number of last CS timeout event.
+ */
+struct hl_info_cs_timeout_event {
+	__s64 timestamp;
+	__u64 seq;
+};
+
+#define HL_RAZWI_PAGE_FAULT 0
+#define HL_RAZWI_MMU_ACCESS_ERROR 1
+
+/**
+ * struct hl_info_razwi_event - razwi information.
+ * @timestamp: timestamp of razwi.
+ * @addr: address which accessing it caused razwi.
+ * @engine_id_1: engine id of the razwi initiator, if it was initiated by engine that does not
+ *               have engine id it will be set to U16_MAX.
+ * @engine_id_2: second engine id of razwi initiator. Might happen that razwi have 2 possible
+ *               engines which one them caused the razwi. In that case, it will contain the
+ *               second possible engine id, otherwise it will be set to U16_MAX.
+ * @no_engine_id: if razwi initiator does not have engine id, this field will be set to 1,
+ *                otherwise 0.
+ * @error_type: cause of razwi, page fault or access error, otherwise it will be set to U8_MAX.
+ * @pad: padding to 64 bit.
+ */
+struct hl_info_razwi_event {
+	__s64 timestamp;
+	__u64 addr;
+	__u16 engine_id_1;
+	__u16 engine_id_2;
+	__u8 no_engine_id;
+	__u8 error_type;
+	__u8 pad[2];
+};
+
 enum gaudi_dcores {
 	HL_GAUDI_WS_DCORE,
 	HL_GAUDI_WN_DCORE,
-- 
2.25.1

