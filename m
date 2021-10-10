Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED5427FFA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 10:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhJJIFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 04:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhJJIFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 04:05:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0173760F8F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 08:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633852994;
        bh=itSVOb5c5GngFgV/t++er3lOT81twdTVXTXWCkyMtMI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Gm9hzsRAY8xviOdTsCS116JX0iYRDXii8yv8wxgQR2emNnepYBJ+mV2yd6BRv2fic
         mCmQD3K7JPCxGQdeAsMJiJ49/FQ2iW4CQ3jvTO2/yapwVwLDZgkhVGylyVj1kedE9A
         1C6hXdigBHxINYlRM7yNnCya1q3RSsoxeTeU7lEuVQycYjDeZ3qqWgA9zij+koQAjV
         ytQlAxYh3kEnGJiVnuB3/K6GtgkFmCKl4NEUsqOdqpXLo8VDSc/nqrfdzJOuimP/eM
         YIwRl4S6wHk8/1Tv4WU7O65yuTuj5PYJ0djN+JR7QHQxZXo0UgNGBUjga2o7OkVgrA
         WNxoiWiJCxDDg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] habanalabs: update firmware files
Date:   Sun, 10 Oct 2021 11:03:04 +0300
Message-Id: <20211010080307.153420-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211010080307.153420-1-ogabbay@kernel.org>
References: <20211010080307.153420-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the firmware headers to the latest version

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/include/common/cpucp_if.h |  12 +-
 .../habanalabs/include/common/hl_boot_if.h    | 185 +++++++++++-------
 .../habanalabs/include/gaudi/gaudi_fw_if.h    |  10 +-
 .../habanalabs/include/gaudi/gaudi_reg_map.h  |   1 +
 4 files changed, 130 insertions(+), 78 deletions(-)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index a6fa1cfa38a5..ae13231fda94 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -542,11 +542,14 @@ enum cpucp_packet_rc {
  */
 enum cpucp_temp_type {
 	cpucp_temp_input,
+	cpucp_temp_min = 4,
+	cpucp_temp_min_hyst,
 	cpucp_temp_max = 6,
 	cpucp_temp_max_hyst,
 	cpucp_temp_crit,
 	cpucp_temp_crit_hyst,
 	cpucp_temp_offset = 19,
+	cpucp_temp_lowest = 21,
 	cpucp_temp_highest = 22,
 	cpucp_temp_reset_history = 23
 };
@@ -555,6 +558,7 @@ enum cpucp_in_attributes {
 	cpucp_in_input,
 	cpucp_in_min,
 	cpucp_in_max,
+	cpucp_in_lowest = 6,
 	cpucp_in_highest = 7,
 	cpucp_in_reset_history
 };
@@ -563,6 +567,7 @@ enum cpucp_curr_attributes {
 	cpucp_curr_input,
 	cpucp_curr_min,
 	cpucp_curr_max,
+	cpucp_curr_lowest = 6,
 	cpucp_curr_highest = 7,
 	cpucp_curr_reset_history
 };
@@ -741,6 +746,9 @@ struct cpucp_security_info {
  * @pll_map: Bit map of supported PLLs for current ASIC version.
  * @mme_binning_mask: MME binning mask,
  *                   (0 = functional, 1 = binned)
+ * @dram_binning_mask: DRAM binning mask, 1 bit per dram instance
+ *                     (0 = functional 1 = binned)
+ * @memory_repair_flag: eFuse flag indicating memory repair
  */
 struct cpucp_info {
 	struct cpucp_sensor sensors[CPUCP_MAX_SENSORS];
@@ -759,7 +767,9 @@ struct cpucp_info {
 	__le64 reserved3;
 	__le64 reserved4;
 	__u8 reserved5;
-	__u8 pad[7];
+	__u8 dram_binning_mask;
+	__u8 memory_repair_flag;
+	__u8 pad[5];
 	struct cpucp_security_info sec_info;
 	__le32 reserved6;
 	__u8 pll_map[PLL_MAP_LEN];
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 8837925b5d85..2626df6ef3ef 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -15,6 +15,28 @@
 
 #define VERSION_MAX_LEN			128
 
+enum cpu_boot_err {
+	CPU_BOOT_ERR_DRAM_INIT_FAIL = 0,
+	CPU_BOOT_ERR_FIT_CORRUPTED = 1,
+	CPU_BOOT_ERR_TS_INIT_FAIL = 2,
+	CPU_BOOT_ERR_DRAM_SKIPPED = 3,
+	CPU_BOOT_ERR_BMC_WAIT_SKIPPED = 4,
+	CPU_BOOT_ERR_NIC_DATA_NOT_RDY = 5,
+	CPU_BOOT_ERR_NIC_FW_FAIL = 6,
+	CPU_BOOT_ERR_SECURITY_NOT_RDY = 7,
+	CPU_BOOT_ERR_SECURITY_FAIL = 8,
+	CPU_BOOT_ERR_EFUSE_FAIL = 9,
+	CPU_BOOT_ERR_PRI_IMG_VER_FAIL = 10,
+	CPU_BOOT_ERR_SEC_IMG_VER_FAIL = 11,
+	CPU_BOOT_ERR_PLL_FAIL = 12,
+	CPU_BOOT_ERR_DEVICE_UNUSABLE_FAIL = 13,
+	CPU_BOOT_ERR_BOOT_FW_CRIT_ERR = 18,
+	CPU_BOOT_ERR_BINNING_FAIL = 19,
+	CPU_BOOT_ERR_ENABLED = 31,
+	CPU_BOOT_ERR_SCND_EN = 63,
+	CPU_BOOT_ERR_LAST = 64 /* we have 2 registers of 32 bits */
+};
+
 /*
  * CPU error bits in BOOT_ERROR registers
  *
@@ -78,25 +100,13 @@
  * CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL	Device is unusable and customer support
  *					should be contacted.
  *
- * CPU_BOOT_ERR0_ARC0_HALT_ACK_NOT_RCVD	HALT ACK from ARC0 is not received
- *					within specified retries after issuing
- *					HALT request. ARC0 appears to be in bad
- *					reset.
- *
- * CPU_BOOT_ERR0_ARC1_HALT_ACK_NOT_RCVD	HALT ACK from ARC1 is not received
- *					within specified retries after issuing
- *					HALT request. ARC1 appears to be in bad
- *					reset.
- *
- * CPU_BOOT_ERR0_ARC0_RUN_ACK_NOT_RCVD	RUN ACK from ARC0 is not received
- *					within specified timeout after issuing
- *					RUN request. ARC0 appears to be in bad
- *					reset.
+ * CPU_BOOT_ERR0_BOOT_FW_CRIT_ERR	Critical error was detected during
+ *					the execution of ppboot or preboot.
+ *					for example: stack overflow.
  *
- * CPU_BOOT_ERR0_ARC1_RUN_ACK_NOT_RCVD	RUN ACK from ARC1 is not received
- *					within specified timeout after issuing
- *					RUN request. ARC1 appears to be in bad
- *					reset.
+ * CPU_BOOT_ERR0_BINNING_FAIL		Binning settings failed, meaning
+ *					malfunctioning components might still be
+ *					in use.
  *
  * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
  *					This is a main indication that the
@@ -104,26 +114,57 @@
  *					registers. Meaning the error bits are
  *					not garbage, but actual error statuses.
  */
-#define CPU_BOOT_ERR0_DRAM_INIT_FAIL		(1 << 0)
-#define CPU_BOOT_ERR0_FIT_CORRUPTED		(1 << 1)
-#define CPU_BOOT_ERR0_TS_INIT_FAIL		(1 << 2)
-#define CPU_BOOT_ERR0_DRAM_SKIPPED		(1 << 3)
-#define CPU_BOOT_ERR0_BMC_WAIT_SKIPPED		(1 << 4)
-#define CPU_BOOT_ERR0_NIC_DATA_NOT_RDY		(1 << 5)
-#define CPU_BOOT_ERR0_NIC_FW_FAIL		(1 << 6)
-#define CPU_BOOT_ERR0_SECURITY_NOT_RDY		(1 << 7)
-#define CPU_BOOT_ERR0_SECURITY_FAIL		(1 << 8)
-#define CPU_BOOT_ERR0_EFUSE_FAIL		(1 << 9)
-#define CPU_BOOT_ERR0_PRI_IMG_VER_FAIL		(1 << 10)
-#define CPU_BOOT_ERR0_SEC_IMG_VER_FAIL		(1 << 11)
-#define CPU_BOOT_ERR0_PLL_FAIL			(1 << 12)
-#define CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL	(1 << 13)
-#define CPU_BOOT_ERR0_ARC0_HALT_ACK_NOT_RCVD	(1 << 14)
-#define CPU_BOOT_ERR0_ARC1_HALT_ACK_NOT_RCVD	(1 << 15)
-#define CPU_BOOT_ERR0_ARC0_RUN_ACK_NOT_RCVD	(1 << 16)
-#define CPU_BOOT_ERR0_ARC1_RUN_ACK_NOT_RCVD	(1 << 17)
-#define CPU_BOOT_ERR0_ENABLED			(1 << 31)
-#define CPU_BOOT_ERR1_ENABLED			(1 << 31)
+#define CPU_BOOT_ERR0_DRAM_INIT_FAIL		(1 << CPU_BOOT_ERR_DRAM_INIT_FAIL)
+#define CPU_BOOT_ERR0_FIT_CORRUPTED		(1 << CPU_BOOT_ERR_FIT_CORRUPTED)
+#define CPU_BOOT_ERR0_TS_INIT_FAIL		(1 << CPU_BOOT_ERR_TS_INIT_FAIL)
+#define CPU_BOOT_ERR0_DRAM_SKIPPED		(1 << CPU_BOOT_ERR_DRAM_SKIPPED)
+#define CPU_BOOT_ERR0_BMC_WAIT_SKIPPED		(1 << CPU_BOOT_ERR_BMC_WAIT_SKIPPED)
+#define CPU_BOOT_ERR0_NIC_DATA_NOT_RDY		(1 << CPU_BOOT_ERR_NIC_DATA_NOT_RDY)
+#define CPU_BOOT_ERR0_NIC_FW_FAIL		(1 << CPU_BOOT_ERR_NIC_FW_FAIL)
+#define CPU_BOOT_ERR0_SECURITY_NOT_RDY		(1 << CPU_BOOT_ERR_SECURITY_NOT_RDY)
+#define CPU_BOOT_ERR0_SECURITY_FAIL		(1 << CPU_BOOT_ERR_SECURITY_FAIL)
+#define CPU_BOOT_ERR0_EFUSE_FAIL		(1 << CPU_BOOT_ERR_EFUSE_FAIL)
+#define CPU_BOOT_ERR0_PRI_IMG_VER_FAIL		(1 << CPU_BOOT_ERR_PRI_IMG_VER_FAIL)
+#define CPU_BOOT_ERR0_SEC_IMG_VER_FAIL		(1 << CPU_BOOT_ERR_SEC_IMG_VER_FAIL)
+#define CPU_BOOT_ERR0_PLL_FAIL			(1 << CPU_BOOT_ERR_PLL_FAIL)
+#define CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL	(1 << CPU_BOOT_ERR_DEVICE_UNUSABLE_FAIL)
+#define CPU_BOOT_ERR0_BOOT_FW_CRIT_ERR		(1 << CPU_BOOT_ERR_BOOT_FW_CRIT_ERR)
+#define CPU_BOOT_ERR0_BINNING_FAIL		(1 << CPU_BOOT_ERR_BINNING_FAIL)
+#define CPU_BOOT_ERR0_ENABLED			(1 << CPU_BOOT_ERR_ENABLED)
+#define CPU_BOOT_ERR1_ENABLED			(1 << CPU_BOOT_ERR_ENABLED)
+
+enum cpu_boot_dev_sts {
+	CPU_BOOT_DEV_STS_SECURITY_EN = 0,
+	CPU_BOOT_DEV_STS_DEBUG_EN = 1,
+	CPU_BOOT_DEV_STS_WATCHDOG_EN = 2,
+	CPU_BOOT_DEV_STS_DRAM_INIT_EN = 3,
+	CPU_BOOT_DEV_STS_BMC_WAIT_EN = 4,
+	CPU_BOOT_DEV_STS_E2E_CRED_EN = 5,
+	CPU_BOOT_DEV_STS_HBM_CRED_EN = 6,
+	CPU_BOOT_DEV_STS_RL_EN = 7,
+	CPU_BOOT_DEV_STS_SRAM_SCR_EN = 8,
+	CPU_BOOT_DEV_STS_DRAM_SCR_EN = 9,
+	CPU_BOOT_DEV_STS_FW_HARD_RST_EN = 10,
+	CPU_BOOT_DEV_STS_PLL_INFO_EN = 11,
+	CPU_BOOT_DEV_STS_SP_SRAM_EN = 12,
+	CPU_BOOT_DEV_STS_CLK_GATE_EN = 13,
+	CPU_BOOT_DEV_STS_HBM_ECC_EN = 14,
+	CPU_BOOT_DEV_STS_PKT_PI_ACK_EN = 15,
+	CPU_BOOT_DEV_STS_FW_LD_COM_EN = 16,
+	CPU_BOOT_DEV_STS_FW_IATU_CONF_EN = 17,
+	CPU_BOOT_DEV_STS_FW_NIC_MAC_EN = 18,
+	CPU_BOOT_DEV_STS_DYN_PLL_EN = 19,
+	CPU_BOOT_DEV_STS_GIC_PRIVILEGED_EN = 20,
+	CPU_BOOT_DEV_STS_EQ_INDEX_EN = 21,
+	CPU_BOOT_DEV_STS_MULTI_IRQ_POLL_EN = 22,
+	CPU_BOOT_DEV_STS_FW_NIC_STAT_XPCS91_EN = 23,
+	CPU_BOOT_DEV_STS_FW_NIC_STAT_EXT_EN = 24,
+	CPU_BOOT_DEV_STS_IS_IDLE_CHECK_EN = 25,
+	CPU_BOOT_DEV_STS_MAP_HWMON_EN = 26,
+	CPU_BOOT_DEV_STS_ENABLED = 31,
+	CPU_BOOT_DEV_STS_SCND_EN = 63,
+	CPU_BOOT_DEV_STS_LAST = 64 /* we have 2 registers of 32 bits */
+};
 
 /*
  * BOOT DEVICE STATUS bits in BOOT_DEVICE_STS registers
@@ -233,7 +274,7 @@
  *					was not served before.
  *					Initialized in: linux
  *
- * CPU_BOOT_DEV_STS0_MULTI_IRQ_POLL_EN  Use multiple scratchpad interfaces to
+ * CPU_BOOT_DEV_STS0_MULTI_IRQ_POLL_EN	Use multiple scratchpad interfaces to
  *					prevent IRQs overriding each other.
  *					Initialized in: linux
  *
@@ -266,35 +307,35 @@
  *					Initialized in: preboot
  *
  */
-#define CPU_BOOT_DEV_STS0_SECURITY_EN			(1 << 0)
-#define CPU_BOOT_DEV_STS0_DEBUG_EN			(1 << 1)
-#define CPU_BOOT_DEV_STS0_WATCHDOG_EN			(1 << 2)
-#define CPU_BOOT_DEV_STS0_DRAM_INIT_EN			(1 << 3)
-#define CPU_BOOT_DEV_STS0_BMC_WAIT_EN			(1 << 4)
-#define CPU_BOOT_DEV_STS0_E2E_CRED_EN			(1 << 5)
-#define CPU_BOOT_DEV_STS0_HBM_CRED_EN			(1 << 6)
-#define CPU_BOOT_DEV_STS0_RL_EN				(1 << 7)
-#define CPU_BOOT_DEV_STS0_SRAM_SCR_EN			(1 << 8)
-#define CPU_BOOT_DEV_STS0_DRAM_SCR_EN			(1 << 9)
-#define CPU_BOOT_DEV_STS0_FW_HARD_RST_EN		(1 << 10)
-#define CPU_BOOT_DEV_STS0_PLL_INFO_EN			(1 << 11)
-#define CPU_BOOT_DEV_STS0_SP_SRAM_EN			(1 << 12)
-#define CPU_BOOT_DEV_STS0_CLK_GATE_EN			(1 << 13)
-#define CPU_BOOT_DEV_STS0_HBM_ECC_EN			(1 << 14)
-#define CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN			(1 << 15)
-#define CPU_BOOT_DEV_STS0_FW_LD_COM_EN			(1 << 16)
-#define CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN		(1 << 17)
-#define CPU_BOOT_DEV_STS0_FW_NIC_MAC_EN			(1 << 18)
-#define CPU_BOOT_DEV_STS0_DYN_PLL_EN			(1 << 19)
-#define CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN		(1 << 20)
-#define CPU_BOOT_DEV_STS0_EQ_INDEX_EN			(1 << 21)
-#define CPU_BOOT_DEV_STS0_MULTI_IRQ_POLL_EN		(1 << 22)
-#define CPU_BOOT_DEV_STS0_FW_NIC_STAT_XPCS91_EN		(1 << 23)
-#define CPU_BOOT_DEV_STS0_FW_NIC_STAT_EXT_EN		(1 << 24)
-#define CPU_BOOT_DEV_STS0_IS_IDLE_CHECK_EN		(1 << 25)
-#define CPU_BOOT_DEV_STS0_MAP_HWMON_EN			(1 << 26)
-#define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
-#define CPU_BOOT_DEV_STS1_ENABLED			(1 << 31)
+#define CPU_BOOT_DEV_STS0_SECURITY_EN		(1 << CPU_BOOT_DEV_STS_SECURITY_EN)
+#define CPU_BOOT_DEV_STS0_DEBUG_EN		(1 << CPU_BOOT_DEV_STS_DEBUG_EN)
+#define CPU_BOOT_DEV_STS0_WATCHDOG_EN		(1 << CPU_BOOT_DEV_STS_WATCHDOG_EN)
+#define CPU_BOOT_DEV_STS0_DRAM_INIT_EN		(1 << CPU_BOOT_DEV_STS_DRAM_INIT_EN)
+#define CPU_BOOT_DEV_STS0_BMC_WAIT_EN		(1 << CPU_BOOT_DEV_STS_BMC_WAIT_EN)
+#define CPU_BOOT_DEV_STS0_E2E_CRED_EN		(1 << CPU_BOOT_DEV_STS_E2E_CRED_EN)
+#define CPU_BOOT_DEV_STS0_HBM_CRED_EN		(1 << CPU_BOOT_DEV_STS_HBM_CRED_EN)
+#define CPU_BOOT_DEV_STS0_RL_EN			(1 << CPU_BOOT_DEV_STS_RL_EN)
+#define CPU_BOOT_DEV_STS0_SRAM_SCR_EN		(1 << CPU_BOOT_DEV_STS_SRAM_SCR_EN)
+#define CPU_BOOT_DEV_STS0_DRAM_SCR_EN		(1 << CPU_BOOT_DEV_STS_DRAM_SCR_EN)
+#define CPU_BOOT_DEV_STS0_FW_HARD_RST_EN	(1 << CPU_BOOT_DEV_STS_FW_HARD_RST_EN)
+#define CPU_BOOT_DEV_STS0_PLL_INFO_EN		(1 << CPU_BOOT_DEV_STS_PLL_INFO_EN)
+#define CPU_BOOT_DEV_STS0_SP_SRAM_EN		(1 << CPU_BOOT_DEV_STS_SP_SRAM_EN)
+#define CPU_BOOT_DEV_STS0_CLK_GATE_EN		(1 << CPU_BOOT_DEV_STS_CLK_GATE_EN)
+#define CPU_BOOT_DEV_STS0_HBM_ECC_EN		(1 << CPU_BOOT_DEV_STS_HBM_ECC_EN)
+#define CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN		(1 << CPU_BOOT_DEV_STS_PKT_PI_ACK_EN)
+#define CPU_BOOT_DEV_STS0_FW_LD_COM_EN		(1 << CPU_BOOT_DEV_STS_FW_LD_COM_EN)
+#define CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN	(1 << CPU_BOOT_DEV_STS_FW_IATU_CONF_EN)
+#define CPU_BOOT_DEV_STS0_FW_NIC_MAC_EN		(1 << CPU_BOOT_DEV_STS_FW_NIC_MAC_EN)
+#define CPU_BOOT_DEV_STS0_DYN_PLL_EN		(1 << CPU_BOOT_DEV_STS_DYN_PLL_EN)
+#define CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN	(1 << CPU_BOOT_DEV_STS_GIC_PRIVILEGED_EN)
+#define CPU_BOOT_DEV_STS0_EQ_INDEX_EN		(1 << CPU_BOOT_DEV_STS_EQ_INDEX_EN)
+#define CPU_BOOT_DEV_STS0_MULTI_IRQ_POLL_EN	(1 << CPU_BOOT_DEV_STS_MULTI_IRQ_POLL_EN)
+#define CPU_BOOT_DEV_STS0_FW_NIC_STAT_XPCS91_EN	(1 << CPU_BOOT_DEV_STS_FW_NIC_STAT_XPCS91_EN)
+#define CPU_BOOT_DEV_STS0_FW_NIC_STAT_EXT_EN	(1 << CPU_BOOT_DEV_STS_FW_NIC_STAT_EXT_EN)
+#define CPU_BOOT_DEV_STS0_IS_IDLE_CHECK_EN	(1 << CPU_BOOT_DEV_STS_IS_IDLE_CHECK_EN)
+#define CPU_BOOT_DEV_STS0_MAP_HWMON_EN		(1 << CPU_BOOT_DEV_STS_MAP_HWMON_EN)
+#define CPU_BOOT_DEV_STS0_ENABLED		(1 << CPU_BOOT_DEV_STS_ENABLED)
+#define CPU_BOOT_DEV_STS1_ENABLED		(1 << CPU_BOOT_DEV_STS_ENABLED)
 
 enum cpu_boot_status {
 	CPU_BOOT_STATUS_NA = 0,		/* Default value after reset of chip */
@@ -411,6 +452,8 @@ struct cpu_dyn_regs {
 enum comms_msg_type {
 	HL_COMMS_DESC_TYPE = 0,
 	HL_COMMS_RESET_CAUSE_TYPE = 1,
+	HL_COMMS_FW_CFG_SKIP_TYPE = 2,
+	HL_COMMS_BINNING_CONF_TYPE = 3,
 };
 
 /* TODO: remove this struct after the code is updated to use message */
@@ -470,6 +513,9 @@ struct lkd_fw_comms_msg {
 		struct {
 			__u8 reset_cause;
 		};
+		struct {
+			__u8 fw_cfg_skip; /* 1 - skip, 0 - don't skip */
+		};
 	};
 };
 
@@ -513,8 +559,6 @@ struct lkd_fw_comms_msg {
  * COMMS_SKIP_BMC		Perform actions required for BMC-less servers.
  *				Do not wait for BMC response.
  *
- * COMMS_LOW_PLL_OPP		Initialize PLLs for low OPP.
- *
  * COMMS_PREP_DESC_ELBI		Same as COMMS_PREP_DESC only that the memory
  *				space is allocated in a ELBI access only
  *				address range.
@@ -530,7 +574,6 @@ enum comms_cmd {
 	COMMS_RST_DEV = 6,
 	COMMS_GOTO_WFE = 7,
 	COMMS_SKIP_BMC = 8,
-	COMMS_LOW_PLL_OPP = 9,
 	COMMS_PREP_DESC_ELBI = 10,
 	COMMS_INVLD_LAST
 };
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
index 34ca4fe50d91..2dba02757d37 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
@@ -8,8 +8,6 @@
 #ifndef GAUDI_FW_IF_H
 #define GAUDI_FW_IF_H
 
-#include <linux/types.h>
-
 #define GAUDI_EVENT_QUEUE_MSI_IDX	8
 #define GAUDI_NIC_PORT1_MSI_IDX		10
 #define GAUDI_NIC_PORT3_MSI_IDX		12
@@ -78,13 +76,13 @@ struct gaudi_nic_status {
 	__u32 high_ber_cnt;
 };
 
-struct gaudi_flops_2_data {
+struct gaudi_cold_rst_data {
 	union {
 		struct {
-			__u32 spsram_init_done : 1;
-			__u32 reserved : 31;
+			u32 spsram_init_done : 1;
+			u32 reserved : 31;
 		};
-		__u32 data;
+		__le32 data;
 	};
 };
 
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h b/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
index b9bd5a7f71eb..92f25c2ae083 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
@@ -33,6 +33,7 @@
 #define mmRDWR_TEST			mmPSOC_GLOBAL_CONF_SCRATCHPAD_30
 #define mmBTL_ID			mmPSOC_GLOBAL_CONF_SCRATCHPAD_31
 #define mmPREBOOT_PCIE_EN		mmPSOC_GLOBAL_CONF_COLD_RST_FLOPS_1
+#define mmCOLD_RST_DATA			mmPSOC_GLOBAL_CONF_COLD_RST_FLOPS_2
 #define mmUPD_PENDING_STS		mmPSOC_GLOBAL_CONF_COLD_RST_FLOPS_3
 
 #endif /* GAUDI_REG_MAP_H_ */
-- 
2.25.1

