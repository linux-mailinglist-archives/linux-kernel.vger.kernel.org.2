Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5FD36D68C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 13:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbhD1LeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 07:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239255AbhD1LeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 07:34:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D738B61430
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 11:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619609612;
        bh=PyfIr/6Oi2f1x4YFiM7ahCADL1Js+Ghny2wy/NpFjyE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DV5Eetam0asThoajP8J6aRDyZvEsKxgZAnAyCxzvaxgR+7l+DE6kET2CbTobY3i4/
         aw9E1CoWptWubrCslnYpfgpbay+jl2vIpfBJujAAnbc0GZLCeBX9aSEgqEHXTsFcV9
         /7JjkVgu+2GuVyzXYjRsLw7gjFHR84SiHZBAd0z3tsJRWypI4wIKSgHHL9lmd4AH0O
         AF4FILlASMI0nsrXdpXpVBJeA9zCoA0PeWgtOZLhDjLN/+BtqzqkXZU2LXPpA8gXyO
         4Dlk0XOlXTSolWHimAxLKd4PoElt4GLGwgiMZfyyk9ZYSVdpfM06XLNhxczoJZX9f9
         YRNyR2dBQIk9Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] habanalabs: update to latest f/w headers
Date:   Wed, 28 Apr 2021 14:33:22 +0300
Message-Id: <20210428113323.17222-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428113323.17222-1-ogabbay@kernel.org>
References: <20210428113323.17222-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the common and GAUDI firmware header files to the latest version

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/include/common/cpucp_if.h |  3 +
 .../habanalabs/include/common/hl_boot_if.h    | 80 ++++++++++---------
 .../habanalabs/include/gaudi/gaudi_fw_if.h    | 39 +++++++++
 3 files changed, 83 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index bf10ca8d2457..4f1123102968 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -631,6 +631,8 @@ struct cpucp_security_info {
  * @card_name: card name that will be displayed in HWMON subsystem on the host
  * @sec_info: security information
  * @pll_map: Bit map of supported PLLs for current ASIC version.
+ * @mme_binning_mask: MME binning mask,
+ *                   (0 = functional, 1 = binned)
  */
 struct cpucp_info {
 	struct cpucp_sensor sensors[CPUCP_MAX_SENSORS];
@@ -653,6 +655,7 @@ struct cpucp_info {
 	struct cpucp_security_info sec_info;
 	__le32 reserved6;
 	__u8 pll_map[PLL_MAP_LEN];
+	__le64 mme_binning_mask;
 };
 
 struct cpucp_mac_addr {
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 84c14688d69a..0fd749c92fc2 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -99,6 +99,7 @@
 #define CPU_BOOT_ERR0_PLL_FAIL			(1 << 12)
 #define CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL	(1 << 13)
 #define CPU_BOOT_ERR0_ENABLED			(1 << 31)
+#define CPU_BOOT_ERR1_ENABLED			(1 << 31)
 
 /*
  * BOOT DEVICE STATUS bits in BOOT_DEVICE_STS registers
@@ -219,6 +220,7 @@
 #define CPU_BOOT_DEV_STS0_FW_IATU_CONF_EN		(1 << 17)
 #define CPU_BOOT_DEV_STS0_DYN_PLL_EN			(1 << 19)
 #define CPU_BOOT_DEV_STS0_ENABLED			(1 << 31)
+#define CPU_BOOT_DEV_STS1_ENABLED			(1 << 31)
 
 enum cpu_boot_status {
 	CPU_BOOT_STATUS_NA = 0,		/* Default value after reset of chip */
@@ -264,33 +266,33 @@ enum cpu_msg_status {
 
 /* communication registers mapping - consider ABI when changing */
 struct cpu_dyn_regs {
-	uint32_t cpu_pq_base_addr_low;
-	uint32_t cpu_pq_base_addr_high;
-	uint32_t cpu_pq_length;
-	uint32_t cpu_pq_init_status;
-	uint32_t cpu_eq_base_addr_low;
-	uint32_t cpu_eq_base_addr_high;
-	uint32_t cpu_eq_length;
-	uint32_t cpu_eq_ci;
-	uint32_t cpu_cq_base_addr_low;
-	uint32_t cpu_cq_base_addr_high;
-	uint32_t cpu_cq_length;
-	uint32_t cpu_pf_pq_pi;
-	uint32_t cpu_boot_dev_sts0;
-	uint32_t cpu_boot_dev_sts1;
-	uint32_t cpu_boot_err0;
-	uint32_t cpu_boot_err1;
-	uint32_t cpu_boot_status;
-	uint32_t fw_upd_sts;
-	uint32_t fw_upd_cmd;
-	uint32_t fw_upd_pending_sts;
-	uint32_t fuse_ver_offset;
-	uint32_t preboot_ver_offset;
-	uint32_t uboot_ver_offset;
-	uint32_t hw_state;
-	uint32_t kmd_msg_to_cpu;
-	uint32_t cpu_cmd_status_to_host;
-	uint32_t reserved1[32];		/* reserve for future use */
+	__le32 cpu_pq_base_addr_low;
+	__le32 cpu_pq_base_addr_high;
+	__le32 cpu_pq_length;
+	__le32 cpu_pq_init_status;
+	__le32 cpu_eq_base_addr_low;
+	__le32 cpu_eq_base_addr_high;
+	__le32 cpu_eq_length;
+	__le32 cpu_eq_ci;
+	__le32 cpu_cq_base_addr_low;
+	__le32 cpu_cq_base_addr_high;
+	__le32 cpu_cq_length;
+	__le32 cpu_pf_pq_pi;
+	__le32 cpu_boot_dev_sts0;
+	__le32 cpu_boot_dev_sts1;
+	__le32 cpu_boot_err0;
+	__le32 cpu_boot_err1;
+	__le32 cpu_boot_status;
+	__le32 fw_upd_sts;
+	__le32 fw_upd_cmd;
+	__le32 fw_upd_pending_sts;
+	__le32 fuse_ver_offset;
+	__le32 preboot_ver_offset;
+	__le32 uboot_ver_offset;
+	__le32 hw_state;
+	__le32 kmd_msg_to_cpu;
+	__le32 cpu_cmd_status_to_host;
+	__le32 reserved1[32];		/* reserve for future use */
 };
 
 /* HCDM - Habana Communications Descriptor Magic */
@@ -299,11 +301,11 @@ struct cpu_dyn_regs {
 
 /* this is the comms descriptor header - meta data */
 struct comms_desc_header {
-	uint32_t magic;		/* magic for validation */
-	uint32_t crc32;		/* CRC32 of the descriptor w/o header */
-	uint16_t size;		/* size of the descriptor w/o header */
-	uint8_t version;	/* descriptor version */
-	uint8_t reserved[5];	/* pad to 64 bit */
+	__le32 magic;		/* magic for validation */
+	__le32 crc32;		/* CRC32 of the descriptor w/o header */
+	__le16 size;		/* size of the descriptor w/o header */
+	__u8 version;	/* descriptor version */
+	__u8 reserved[5];	/* pad to 64 bit */
 };
 
 /* this is the main FW descriptor - consider ABI when changing */
@@ -314,7 +316,7 @@ struct lkd_fw_comms_desc {
 	char cur_fw_ver[VERSION_MAX_LEN];
 	/* can be used for 1 more version w/o ABI change */
 	char reserved0[VERSION_MAX_LEN];
-	uint64_t img_addr;	/* address for next FW component load */
+	__le64 img_addr;	/* address for next FW component load */
 };
 
 /*
@@ -386,11 +388,11 @@ enum comms_cmd {
 struct comms_command {
 	union {		/* bit fields are only for FW use */
 		struct {
-			unsigned int size :25;		/* 32MB max. */
-			unsigned int reserved :2;
+			u32 size :25;		/* 32MB max. */
+			u32 reserved :2;
 			enum comms_cmd cmd :5;		/* 32 commands */
 		};
-		unsigned int val;
+		__le32 val;
 	};
 };
 
@@ -449,11 +451,11 @@ enum comms_ram_types {
 struct comms_status {
 	union {		/* bit fields are only for FW use */
 		struct {
-			unsigned int offset :26;
-			unsigned int ram_type :2;
+			u32 offset :26;
+			enum comms_ram_types ram_type :2;
 			enum comms_sts status :4;	/* 16 statuses */
 		};
-		unsigned int val;
+		__le32 val;
 	};
 };
 
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
index a9f51f9f9e92..a4afb984d0ae 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
@@ -27,6 +27,7 @@ enum gaudi_nic_axi_error {
 	TXE,
 	QPC_RESP,
 	NON_AXI_ERR,
+	TMR,
 };
 
 /*
@@ -42,6 +43,44 @@ struct eq_nic_sei_event {
 	__u8 pad[6];
 };
 
+/*
+ * struct gaudi_nic_status - describes the status of a NIC port.
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
+ */
+struct gaudi_nic_status {
+	__u32 port;
+	__u32 bad_format_cnt;
+	__u32 responder_out_of_sequence_psn_cnt;
+	__u32 high_ber_reinit;
+	__u32 correctable_err_cnt;
+	__u32 uncorrectable_err_cnt;
+	__u32 retraining_cnt;
+	__u8 up;
+	__u8 pcs_link;
+	__u8 phy_ready;
+	__u8 auto_neg;
+};
+
+struct gaudi_flops_2_data {
+	union {
+		struct {
+			__u32 spsram_init_done : 1;
+			__u32 reserved : 31;
+		};
+		__u32 data;
+	};
+};
+
 #define GAUDI_PLL_FREQ_LOW		200000000 /* 200 MHz */
 
 #endif /* GAUDI_FW_IF_H */
-- 
2.25.1

