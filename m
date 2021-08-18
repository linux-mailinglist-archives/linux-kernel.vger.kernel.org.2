Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1213F04FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbhHRNkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237255AbhHRNkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 378DB60238
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293972;
        bh=12Qc0nZCrECcOUWtd+W44VeMpOR34t7Eq9Fu4bfHAtw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TrC6EEb2Sq4CDHa1id5iBrsL2G+lkopiAJtYU+ZKKNkcjAuPwgaB44ankK4Cu9wiB
         +QtL3BAOLZ5lF/q2JsJyM6MPXFKNaEchT+DwQUKslgJqASIjl1QbCwm3u4jzuwGslm
         kLQ687Mm7SEZh8oCkviarrun+bdZLD3ANyWw2psfqjmJSaBaqAOFUgKbi0h7Sd4PTY
         HzqtnWaBmm2hZFOS80+FnEzu/oYkznVSiUWevwXfbjfzMExL7jVqCkzN0ykzSp3j5n
         CmIlsWGu7LXw8pMTC2aGGmjPBEcvluZc6wp7f8GE9Q2f4u3Sv0daLtDLF2Mb6lpwQX
         l6qw2qM9Ua4Ow==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 06/16] habanalabs: update to latest firmware headers
Date:   Wed, 18 Aug 2021 16:39:12 +0300
Message-Id: <20210818133922.63637-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add several new packets between driver and firmware.
Add matching compatibility bits for backward compatibility.
Add support for 4K event types.
Add information about pcie errors.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/include/common/cpucp_if.h | 92 +++++++++++++++++--
 .../habanalabs/include/common/hl_boot_if.h    | 23 +++++
 2 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 2d6f8ea35375..7afee76ae0b7 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -98,6 +98,18 @@ struct hl_eq_fw_alive {
 	__u8 pad[7];
 };
 
+enum hl_pcie_addr_dec_cause {
+	PCIE_ADDR_DEC_HBW_ERR_RESP,
+	PCIE_ADDR_DEC_LBW_ERR_RESP,
+	PCIE_ADDR_DEC_TLP_BLOCKED_BY_RR
+};
+
+struct hl_eq_pcie_addr_dec_data {
+	/* enum hl_pcie_addr_dec_cause */
+	__u8 addr_dec_cause;
+	__u8 pad[7];
+};
+
 struct hl_eq_entry {
 	struct hl_eq_header hdr;
 	union {
@@ -106,6 +118,7 @@ struct hl_eq_entry {
 		struct hl_eq_sm_sei_data sm_sei_data;
 		struct cpucp_pkt_sync_err pkt_sync_err;
 		struct hl_eq_fw_alive fw_alive;
+		struct hl_eq_pcie_addr_dec_data pcie_addr_dec_data;
 		__le64 data[7];
 	};
 };
@@ -116,7 +129,7 @@ struct hl_eq_entry {
 #define EQ_CTL_READY_MASK		0x80000000
 
 #define EQ_CTL_EVENT_TYPE_SHIFT		16
-#define EQ_CTL_EVENT_TYPE_MASK		0x03FF0000
+#define EQ_CTL_EVENT_TYPE_MASK		0x0FFF0000
 
 #define EQ_CTL_INDEX_SHIFT		0
 #define EQ_CTL_INDEX_MASK		0x0000FFFF
@@ -300,7 +313,7 @@ enum pq_init_status {
  *       The packet's arguments specify the desired sensor and the field to
  *       set.
  *
- * CPUCP_PACKET_PCIE_THROUGHPUT_GET
+ * CPUCP_PACKET_PCIE_THROUGHPUT_GET -
  *       Get throughput of PCIe.
  *       The packet's arguments specify the transaction direction (TX/RX).
  *       The window measurement is 10[msec], and the return value is in KB/sec.
@@ -309,19 +322,19 @@ enum pq_init_status {
  *       Replay count measures number of "replay" events, which is basicly
  *       number of retries done by PCIe.
  *
- * CPUCP_PACKET_TOTAL_ENERGY_GET
+ * CPUCP_PACKET_TOTAL_ENERGY_GET -
  *       Total Energy is measurement of energy from the time FW Linux
  *       is loaded. It is calculated by multiplying the average power
  *       by time (passed from armcp start). The units are in MilliJouls.
  *
- * CPUCP_PACKET_PLL_INFO_GET
+ * CPUCP_PACKET_PLL_INFO_GET -
  *       Fetch frequencies of PLL from the required PLL IP.
  *       The packet's arguments specify the device PLL type
  *       Pll type is the PLL from device pll_index enum.
  *       The result is composed of 4 outputs, each is 16-bit
  *       frequency in MHz.
  *
- * CPUCP_PACKET_POWER_GET
+ * CPUCP_PACKET_POWER_GET -
  *       Fetch the present power consumption of the device (Current * Voltage).
  *
  * CPUCP_PACKET_NIC_PFC_SET -
@@ -345,6 +358,24 @@ enum pq_init_status {
  * CPUCP_PACKET_MSI_INFO_SET -
  *       set the index number for each supported msi type going from
  *       host to device
+ *
+ * CPUCP_PACKET_NIC_XPCS91_REGS_GET -
+ *       Fetch the un/correctable counters values from the NIC MAC.
+ *
+ * CPUCP_PACKET_NIC_STAT_REGS_GET -
+ *       Fetch various NIC MAC counters from the NIC STAT.
+ *
+ * CPUCP_PACKET_NIC_STAT_REGS_CLR -
+ *       Clear the various NIC MAC counters in the NIC STAT.
+ *
+ * CPUCP_PACKET_NIC_STAT_REGS_ALL_GET -
+ *       Fetch all NIC MAC counters from the NIC STAT.
+ *
+ * CPUCP_PACKET_IS_IDLE_CHECK -
+ *       Check if the device is IDLE in regard to the DMA/compute engines
+ *       and QMANs. The f/w will return a bitmask where each bit represents
+ *       a different engine or QMAN according to enum cpucp_idle_mask.
+ *       The bit will be 1 if the engine is NOT idle.
  */
 
 enum cpucp_packet_id {
@@ -385,6 +416,11 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_NIC_LPBK_SET,		/* internal */
 	CPUCP_PACKET_NIC_MAC_CFG,		/* internal */
 	CPUCP_PACKET_MSI_INFO_SET,		/* internal */
+	CPUCP_PACKET_NIC_XPCS91_REGS_GET,	/* internal */
+	CPUCP_PACKET_NIC_STAT_REGS_GET,		/* internal */
+	CPUCP_PACKET_NIC_STAT_REGS_CLR,		/* internal */
+	CPUCP_PACKET_NIC_STAT_REGS_ALL_GET,	/* internal */
+	CPUCP_PACKET_IS_IDLE_CHECK,		/* internal */
 };
 
 #define CPUCP_PACKET_FENCE_VAL	0xFE8CE7A5
@@ -414,6 +450,11 @@ enum cpucp_packet_id {
 #define CPUCP_PKT_VAL_LPBK_IN2_SHIFT	1
 #define CPUCP_PKT_VAL_LPBK_IN2_MASK	0x000000000000001Eull
 
+#define CPUCP_PKT_VAL_MAC_CNT_IN1_SHIFT	0
+#define CPUCP_PKT_VAL_MAC_CNT_IN1_MASK	0x0000000000000001ull
+#define CPUCP_PKT_VAL_MAC_CNT_IN2_SHIFT	1
+#define CPUCP_PKT_VAL_MAC_CNT_IN2_MASK	0x00000000FFFFFFFEull
+
 /* heartbeat status bits */
 #define CPUCP_PKT_HB_STATUS_EQ_FAULT_SHIFT		0
 #define CPUCP_PKT_HB_STATUS_EQ_FAULT_MASK		0x00000001
@@ -467,7 +508,8 @@ struct cpucp_packet {
 		__le32 status_mask;
 	};
 
-	__le32 reserved;
+	/* For NIC requests */
+	__le32 port_index;
 };
 
 struct cpucp_unmask_irq_arr_packet {
@@ -476,6 +518,12 @@ struct cpucp_unmask_irq_arr_packet {
 	__le32 irqs[0];
 };
 
+struct cpucp_nic_status_packet {
+	struct cpucp_packet cpucp_pkt;
+	__le32 length;
+	__le32 data[0];
+};
+
 struct cpucp_array_data_packet {
 	struct cpucp_packet cpucp_pkt;
 	__le32 length;
@@ -721,4 +769,36 @@ struct cpucp_nic_info {
 	__u8 reserved[6];
 };
 
+/*
+ * struct cpucp_nic_status - describes the status of a NIC port.
+ * @port: NIC port index.
+ * @bad_format_cnt: e.g. CRC.
+ * @responder_out_of_sequence_psn_cnt: e.g NAK.
+ * @high_ber_reinit_cnt: link reinit due to high BER.
+ * @correctable_err_cnt: e.g. bit-flip.
+ * @uncorrectable_err_cnt: e.g. MAC errors.
+ * @retraining_cnt: re-training counter.
+ * @up: is port up.
+ * @pcs_link: has PCS link.
+ * @phy_ready: is PHY ready.
+ * @auto_neg: is Autoneg enabled.
+ * @timeout_retransmission_cnt: timeout retransmission events
+ * @high_ber_cnt: high ber events
+ */
+struct cpucp_nic_status {
+	__le32 port;
+	__le32 bad_format_cnt;
+	__le32 responder_out_of_sequence_psn_cnt;
+	__le32 high_ber_reinit;
+	__le32 correctable_err_cnt;
+	__le32 uncorrectable_err_cnt;
+	__le32 retraining_cnt;
+	__u8 up;
+	__u8 pcs_link;
+	__u8 phy_ready;
+	__u8 auto_neg;
+	__le32 timeout_retransmission_cnt;
+	__le32 high_ber_cnt;
+};
+
 #endif /* CPUCP_IF_H */
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 1f296784fa2b..3099653234e4 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -210,6 +210,10 @@
  *					configured and is ready for use.
  *					Initialized in: ppboot
  *
+ * CPU_BOOT_DEV_STS0_FW_NIC_MAC_EN	NIC MAC channels init is done by FW and
+ *					any access to them is done via the FW.
+ *					Initialized in: linux
+ *
  * CPU_BOOT_DEV_STS0_DYN_PLL_EN		Dynamic PLL configuration is enabled.
  *					FW sends to host a bitmap of supported
  *					PLLs.
@@ -233,6 +237,21 @@
  *					prevent IRQs overriding each other.
  *					Initialized in: linux
  *
+ * CPU_BOOT_DEV_STS0_FW_NIC_STAT_XPCS91_EN
+ *					NIC STAT and XPCS91 access is restricted
+ *					and is done via FW only.
+ *					Initialized in: linux
+ *
+ * CPU_BOOT_DEV_STS0_FW_NIC_STAT_EXT_EN
+ *					NIC STAT get all is supported.
+ *					Initialized in: linux
+ *
+ * CPU_BOOT_DEV_STS0_IS_IDLE_CHECK_EN
+ *					F/W checks if the device is idle by reading defined set
+ *					of registers. It returns a bitmask of all the engines,
+ *					where a bit is set if the engine is not idle.
+ *					Initialized in: linux
+ *
  * CPU_BOOT_DEV_STS0_ENABLED		Device status register enabled.
  *					This is a main indication that the
  *					running FW populates the device status
@@ -260,10 +279,14 @@
 #define CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN			(1 << 15)
 #define CPU_BOOT_DEV_STS0_FW_LD_COM_EN			(1 << 16)
 #define CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN		(1 << 17)
+#define CPU_BOOT_DEV_STS0_FW_NIC_MAC_EN			(1 << 18)
 #define CPU_BOOT_DEV_STS0_DYN_PLL_EN			(1 << 19)
 #define CPU_BOOT_DEV_STS0_GIC_PRIVILEGED_EN		(1 << 20)
 #define CPU_BOOT_DEV_STS0_EQ_INDEX_EN			(1 << 21)
 #define CPU_BOOT_DEV_STS0_MULTI_IRQ_POLL_EN		(1 << 22)
+#define CPU_BOOT_DEV_STS0_FW_NIC_STAT_XPCS91_EN		(1 << 23)
+#define CPU_BOOT_DEV_STS0_FW_NIC_STAT_EXT_EN		(1 << 24)
+#define CPU_BOOT_DEV_STS0_IS_IDLE_CHECK_EN		(1 << 25)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
 #define CPU_BOOT_DEV_STS1_ENABLED			(1 << 31)
 
-- 
2.17.1

