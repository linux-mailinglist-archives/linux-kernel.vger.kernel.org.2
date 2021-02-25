Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E898325363
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhBYQUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:20:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231843AbhBYQU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:20:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89A4264EFA;
        Thu, 25 Feb 2021 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614269985;
        bh=ELOmmMCJsZosj5gAiscZ60gUdKpr9M3OkL1XDR9tALg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAUCIKebf5xEUBxsPxIC7teODtLf2WTT0wqUBwjchtmv3ZNRqFdCi/6/5NPeMX5vm
         0uwMSmYrTcAvs+9iClgk2IwzSBEJje/YKBKwUhc5fcMbSWkTpE6vOthtdUZUoBB0kv
         QQqguuPKcPvAOlSrrqvgR39sxmJhhuCqGM/EnfnS4rx37rWndypKJIQf+RXfSfWDDt
         Uy4Gtqh/aDEzgPMWfKajq26bsaWH1j9nIy1cQeZv9pDdMRDVnZkqYnFbZ5JkED0bb0
         cT5ZXbVBdlrC1si/mFZ2laBH9T7WYsPH+NxzaJztjaLsqfFFD3BouGyKiZcZD8CQzT
         k8rnks708wZ9g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sagiv Ozeri <sozeri@habana.ai>
Subject: [PATCH 2/4] habanalabs: return current power via INFO IOCTL
Date:   Thu, 25 Feb 2021 18:19:37 +0200
Message-Id: <20210225161939.20842-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225161939.20842-1-ogabbay@kernel.org>
References: <20210225161939.20842-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagiv Ozeri <sozeri@habana.ai>

Add driver implementation for reading the current power from the device
CPU F/W.

Signed-off-by: Sagiv Ozeri <sozeri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 23 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  1 +
 .../misc/habanalabs/common/habanalabs_ioctl.c | 22 ++++++++++++++++++
 .../misc/habanalabs/include/common/cpucp_if.h |  5 ++++
 include/uapi/misc/habanalabs.h                |  9 ++++++++
 5 files changed, 60 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 6f3692bf5eff..2a58edaf984a 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -565,6 +565,29 @@ int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u16 pll_index,
 	return rc;
 }
 
+int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power)
+{
+	struct cpucp_packet pkt;
+	u64 result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_POWER_GET <<
+				CPUCP_PKT_CTL_OPCODE_SHIFT);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+			HL_CPUCP_INFO_TIMEOUT_USEC, &result);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to read power, error %d\n", rc);
+		return rc;
+	}
+
+	*power = result;
+
+	return rc;
+}
+
 static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 {
 	/* Some of the status codes below are deprecated in newer f/w
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 9129582e9339..33ada9425a62 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2363,6 +2363,7 @@ int hl_fw_cpucp_total_energy_get(struct hl_device *hdev,
 			u64 *total_energy);
 int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u16 pll_index,
 		u16 *pll_freq_arr);
+int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power);
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
 			u32 cpu_security_boot_status_reg, u32 boot_err0_reg,
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 95a0b144604d..3f762e021428 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -444,6 +444,25 @@ static int pll_frequency_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 		min((size_t) max_size, sizeof(freq_info))) ? -EFAULT : 0;
 }
 
+static int power_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	struct hl_device *hdev = hpriv->hdev;
+	u32 max_size = args->return_size;
+	struct hl_power_info power_info = {0};
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	int rc;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	rc = hl_fw_cpucp_power_get(hdev, &power_info.power);
+	if (rc)
+		return rc;
+
+	return copy_to_user(out, &power_info,
+		min((size_t) max_size, sizeof(power_info))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -524,6 +543,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_PLL_FREQUENCY:
 		return pll_frequency_info(hpriv, args);
 
+	case HL_INFO_POWER:
+		return power_info(hpriv, args);
+
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index bf4e7900d8c8..6ba480a316ce 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -296,6 +296,9 @@ enum pq_init_status {
  *       The result is composed of 4 outputs, each is 16-bit
  *       frequency in MHz.
  *
+ * CPUCP_PACKET_POWER_GET
+ *       Fetch the present power consumption of the device (Current * Voltage).
+ *
  */
 
 enum cpucp_packet_id {
@@ -329,6 +332,8 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_PCIE_REPLAY_CNT_GET,	/* internal */
 	CPUCP_PACKET_TOTAL_ENERGY_GET,		/* internal */
 	CPUCP_PACKET_PLL_INFO_GET,		/* internal */
+	CPUCP_PACKET_NIC_STATUS,		/* internal */
+	CPUCP_PACKET_POWER_GET,			/* internal */
 };
 
 #define CPUCP_PACKET_FENCE_VAL	0xFE8CE7A5
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 05c7cf4e727e..92fd000ce0d3 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -297,6 +297,7 @@ enum hl_device_status {
 #define HL_INFO_SYNC_MANAGER		14
 #define HL_INFO_TOTAL_ENERGY		15
 #define HL_INFO_PLL_FREQUENCY		16
+#define HL_INFO_POWER			17
 
 #define HL_INFO_VERSION_MAX_LEN	128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
@@ -410,6 +411,14 @@ struct hl_pll_frequency_info {
 	__u16 output[HL_PLL_NUM_OUTPUTS];
 };
 
+/**
+ * struct hl_power_info - power information
+ * @power: power consumption
+ */
+struct hl_power_info {
+	__u64 power;
+};
+
 /**
  * struct hl_info_sync_manager - sync manager information
  * @first_available_sync_object: first available sob
-- 
2.25.1

