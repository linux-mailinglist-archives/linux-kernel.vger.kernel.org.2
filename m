Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6914475F4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhKGUyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:54:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236253AbhKGUyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:54:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 357A260E94;
        Sun,  7 Nov 2021 20:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636318315;
        bh=U7F2x/bf1ygVTO11iNs5+CN7vp9EluM78LlkZKuMZ3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gq41JASQ2TkCUrkI5a3/mf7jfAsxVdrMFJrgbjrgfz5mIY681fLi9Lzla/5Ue4Tqr
         1Ot8aKb6kdnVn4DhUups+Blae9NTzpmqlIS0HC/CBuNzmZdQ1KOjvjfJNYQCrTpXXZ
         h6qXnuRH6bnrPAFcCG1mHVod588f4MQ4v0HI+NAIK6Np9YffJDEFaXxI3j9vgeHJfN
         tZ/KpX+LI8yqd7htusrE4rKMmFWIpTU3eH+d+SrC2kpFgTKGhcYAkn055abXMLIRGm
         NXhr/gBe0tXQ2plLkduok77m//bMzUnvgVGIbu3iFs+s5H2qNBbdne+MWhiO08xmHg
         2CQBuvcf3dTZg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 09/10] habanalabs: add new opcodes for INFO IOCTL
Date:   Sun,  7 Nov 2021 22:51:35 +0200
Message-Id: <20211107205136.2329007-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107205136.2329007-1-ogabbay@kernel.org>
References: <20211107205136.2329007-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Add implementation for new opcodes in the INFO IOCTL:
1. Retrieve the replaced DRAM rows from f/w.
2. Retrieve the pending DRAM rows from f/w.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 66 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  3 +
 .../misc/habanalabs/common/habanalabs_ioctl.c | 43 ++++++++++++
 .../misc/habanalabs/include/common/cpucp_if.h | 33 +++++++++-
 include/uapi/misc/habanalabs.h                |  4 ++
 5 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 9addcfba6a8b..70e992bdbde7 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -972,6 +972,72 @@ int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power)
 	return rc;
 }
 
+int hl_fw_dram_replaced_row_get(struct hl_device *hdev,
+				struct cpucp_hbm_row_info *info)
+{
+	struct cpucp_hbm_row_info *cpucp_repl_rows_info_cpu_addr;
+	dma_addr_t cpucp_repl_rows_info_dma_addr;
+	struct cpucp_packet pkt = {};
+	u64 result;
+	int rc;
+
+	cpucp_repl_rows_info_cpu_addr =
+			hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
+					sizeof(struct cpucp_hbm_row_info),
+					&cpucp_repl_rows_info_dma_addr);
+	if (!cpucp_repl_rows_info_cpu_addr) {
+		dev_err(hdev->dev,
+			"Failed to allocate DMA memory for CPU-CP replaced rows info packet\n");
+		return -ENOMEM;
+	}
+
+	memset(cpucp_repl_rows_info_cpu_addr, 0, sizeof(struct cpucp_hbm_row_info));
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_HBM_REPLACED_ROWS_INFO_GET <<
+					CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.addr = cpu_to_le64(cpucp_repl_rows_info_dma_addr);
+	pkt.data_max_size = cpu_to_le32(sizeof(struct cpucp_hbm_row_info));
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+					HL_CPUCP_INFO_TIMEOUT_USEC, &result);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed to handle CPU-CP replaced rows info pkt, error %d\n", rc);
+		goto out;
+	}
+
+	memcpy(info, cpucp_repl_rows_info_cpu_addr, sizeof(*info));
+
+out:
+	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
+					sizeof(struct cpucp_hbm_row_info),
+					cpucp_repl_rows_info_cpu_addr);
+
+	return rc;
+}
+
+int hl_fw_dram_pending_row_get(struct hl_device *hdev, u32 *pend_rows_num)
+{
+	struct cpucp_packet pkt;
+	u64 result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_HBM_PENDING_ROWS_STATUS << CPUCP_PKT_CTL_OPCODE_SHIFT);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt), 0, &result);
+	if (rc) {
+		dev_err(hdev->dev,
+				"Failed to handle CPU-CP pending rows info pkt, error %d\n", rc);
+		goto out;
+	}
+
+	*pend_rows_num = (u32) result;
+out:
+	return rc;
+}
+
 void hl_fw_ask_hard_reset_without_linux(struct hl_device *hdev)
 {
 	struct static_fw_load_mgr *static_loader =
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index fc201537f7a9..a19563c416ac 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3012,6 +3012,9 @@ int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
 				struct fw_load_mgr *fw_loader,
 				enum comms_cmd cmd, unsigned int size,
 				bool wait_ok, u32 timeout);
+int hl_fw_dram_replaced_row_get(struct hl_device *hdev,
+				struct cpucp_hbm_row_info *info);
+int hl_fw_dram_pending_row_get(struct hl_device *hdev, u32 *pend_rows_num);
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 			bool is_wc[3]);
 int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 19726c6b642a..68c655acdec8 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -503,6 +503,43 @@ static int open_stats_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 		min((size_t) max_size, sizeof(open_stats_info))) ? -EFAULT : 0;
 }
 
+static int dram_pending_rows_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	u32 max_size = args->return_size;
+	u32 pend_rows_num = 0;
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	int rc;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	rc = hl_fw_dram_pending_row_get(hdev, &pend_rows_num);
+	if (rc)
+		return rc;
+
+	return copy_to_user(out, &pend_rows_num,
+			min_t(size_t, max_size, sizeof(pend_rows_num))) ? -EFAULT : 0;
+}
+
+static int dram_replaced_rows_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	u32 max_size = args->return_size;
+	struct cpucp_hbm_row_info info = {0};
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	int rc;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	rc = hl_fw_dram_replaced_row_get(hdev, &info);
+	if (rc)
+		return rc;
+
+	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -589,6 +626,12 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_OPEN_STATS:
 		return open_stats_info(hpriv, args);
 
+	case HL_INFO_DRAM_REPLACED_ROWS:
+		return dram_replaced_rows_info(hpriv, args);
+
+	case HL_INFO_DRAM_PENDING_ROWS:
+		return dram_pending_rows_info(hpriv, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 17927968e19a..5e19c763f3f0 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2020 HabanaLabs, Ltd.
+ * Copyright 2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -377,6 +377,13 @@ enum pq_init_status {
  *       a different engine or QMAN according to enum cpucp_idle_mask.
  *       The bit will be 1 if the engine is NOT idle.
  *
+ * CPUCP_PACKET_HBM_REPLACED_ROWS_INFO_GET -
+ *       Fetch all HBM replaced-rows and prending to be replaced rows data.
+ *
+ * CPUCP_PACKET_HBM_PENDING_ROWS_STATUS -
+ *       Fetch status of HBM rows pending replacement and need a reboot to
+ *       be replaced.
+ *
  * CPUCP_PACKET_POWER_SET -
  *       Resets power history of device to 0
  */
@@ -424,6 +431,8 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_NIC_STAT_REGS_CLR,		/* internal */
 	CPUCP_PACKET_NIC_STAT_REGS_ALL_GET,	/* internal */
 	CPUCP_PACKET_IS_IDLE_CHECK,		/* internal */
+	CPUCP_PACKET_HBM_REPLACED_ROWS_INFO_GET,/* internal */
+	CPUCP_PACKET_HBM_PENDING_ROWS_STATUS,	/* internal */
 	CPUCP_PACKET_POWER_SET,			/* internal */
 };
 
@@ -692,6 +701,7 @@ struct eq_generic_event {
 #define CPUCP_MAX_NIC_LANES		(CPUCP_MAX_NICS * CPUCP_LANES_PER_NIC)
 #define CPUCP_NIC_MASK_ARR_LEN		((CPUCP_MAX_NICS + 63) / 64)
 #define CPUCP_NIC_POLARITY_ARR_LEN	((CPUCP_MAX_NIC_LANES + 63) / 64)
+#define CPUCP_HBM_ROW_REPLACE_MAX	32
 
 struct cpucp_sensor {
 	__le32 type;
@@ -837,4 +847,25 @@ struct cpucp_nic_status {
 	__le32 high_ber_cnt;
 };
 
+enum cpucp_hbm_row_replace_cause {
+	REPLACE_CAUSE_DOUBLE_ECC_ERR,
+	REPLACE_CAUSE_MULTI_SINGLE_ECC_ERR,
+};
+
+struct cpucp_hbm_row_info {
+	__u8 hbm_idx;
+	__u8 pc;
+	__u8 sid;
+	__u8 bank_idx;
+	__le16 row_addr;
+	__u8 replaced_row_cause; /* enum cpucp_hbm_row_replace_cause */
+	__u8 pad;
+};
+
+struct cpucp_hbm_row_replaced_rows_info {
+	__le16 num_replaced_rows;
+	__u8 pad[6];
+	struct cpucp_hbm_row_info replaced_rows[CPUCP_HBM_ROW_REPLACE_MAX];
+};
+
 #endif /* CPUCP_IF_H */
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 257b9630773e..9b4d72897061 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -334,6 +334,8 @@ enum hl_server_type {
  * HL_INFO_TOTAL_ENERGY  - Retrieve total energy consumption
  * HL_INFO_PLL_FREQUENCY - Retrieve PLL frequency
  * HL_INFO_OPEN_STATS    - Retrieve info regarding recent device open calls
+ * HL_INFO_DRAM_REPLACED_ROWS - Retrieve DRAM replaced rows info
+ * HL_INFO_DRAM_PENDING_ROWS - Retrieve DRAM pending rows num
  */
 #define HL_INFO_HW_IP_INFO		0
 #define HL_INFO_HW_EVENTS		1
@@ -353,6 +355,8 @@ enum hl_server_type {
 #define HL_INFO_PLL_FREQUENCY		16
 #define HL_INFO_POWER			17
 #define HL_INFO_OPEN_STATS		18
+#define HL_INFO_DRAM_REPLACED_ROWS	21
+#define HL_INFO_DRAM_PENDING_ROWS	22
 
 #define HL_INFO_VERSION_MAX_LEN	128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
-- 
2.25.1

