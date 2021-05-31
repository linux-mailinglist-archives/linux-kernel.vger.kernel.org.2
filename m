Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3C939662F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhEaRAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:00:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232163AbhEaPRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:17:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7659A6128A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622474055;
        bh=bwHF6IjEwRv6psfejvU1PBJoUhfi+Swof04BKI4LSaE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=j9HsVmlz7iV8U0DInAkAc1m6T3nkkj1FE/p9XmrXyOJWpC1jD/o5dOMZLAwA0714R
         u+svHa/CNvNsv/cuGEzS+idNzN+xPsDsuYfMJz56lqS4bdembPjRHN1srPechye0l8
         ZhcjmIXDyFOhh1SoEQc3BEctLg8B6/DBxvpTrR+zZTNVeko6AkkXQ4/bcSnIaZfcdW
         tUNLjsx46k2cOZu/PAVNMH5TTPQZMVZ9+udMkHNcTRafOrHvQvUU/M6TRMSVhhHH+s
         iyYco6W05+Xq5SsNNp+In7KSBTmoMLyQc98zuRtgWJeZz7jqTMF01DF6ic+8EZed3R
         Yfs9qKm56rA6g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] habanalabs/gaudi: update to latest f/w specs
Date:   Mon, 31 May 2021 18:14:03 +0300
Message-Id: <20210531151403.12494-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531151403.12494-1-ogabbay@kernel.org>
References: <20210531151403.12494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the firmware interface files to their latest version.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/include/common/hl_boot_if.h    | 36 +++++++++++++------
 .../habanalabs/include/gaudi/gaudi_fw_if.h    |  7 ++++
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 89ac8020f821..fa8a5ad2d438 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -333,24 +333,41 @@ struct cpu_dyn_regs {
 #define HL_COMMS_DESC_VER	1
 
 /* HCMv - Habana Communications Message + header version */
-#define HL_COMMS_MSG_MAGIC_VER(ver)	(0x48434D00 | ((ver) & 0xff))
+#define HL_COMMS_MSG_MAGIC_VALUE	0x48434D00
+#define HL_COMMS_MSG_MAGIC_MASK		0xFFFFFF00
+#define HL_COMMS_MSG_MAGIC_VER_MASK	0xFF
+
+#define HL_COMMS_MSG_MAGIC_VER(ver)	(HL_COMMS_MSG_MAGIC_VALUE |	\
+					((ver) & HL_COMMS_MSG_MAGIC_VER_MASK))
 #define HL_COMMS_MSG_MAGIC_V0		HL_COMMS_DESC_MAGIC
 #define HL_COMMS_MSG_MAGIC_V1		HL_COMMS_MSG_MAGIC_VER(1)
 
 #define HL_COMMS_MSG_MAGIC		HL_COMMS_MSG_MAGIC_V1
 
+#define HL_COMMS_MSG_MAGIC_VALIDATE_MAGIC(magic)			\
+		(((magic) & HL_COMMS_MSG_MAGIC_MASK) ==			\
+		HL_COMMS_MSG_MAGIC_VALUE)
+
+#define HL_COMMS_MSG_MAGIC_VALIDATE_VERSION(magic, ver)			\
+		(((magic) & HL_COMMS_MSG_MAGIC_VER_MASK) >=		\
+		((ver) & HL_COMMS_MSG_MAGIC_VER_MASK))
+
+#define HL_COMMS_MSG_MAGIC_VALIDATE(magic, ver)				\
+		(HL_COMMS_MSG_MAGIC_VALIDATE_MAGIC((magic)) &&		\
+		HL_COMMS_MSG_MAGIC_VALIDATE_VERSION((magic), (ver)))
+
 enum comms_msg_type {
 	HL_COMMS_DESC_TYPE = 0,
 	HL_COMMS_RESET_CAUSE_TYPE = 1,
 };
 
-/* TODO: remove this struct after the code is updated to use comms_msg_header */
+/* TODO: remove this struct after the code is updated to use message */
 /* this is the comms descriptor header - meta data */
 struct comms_desc_header {
 	__le32 magic;		/* magic for validation */
 	__le32 crc32;		/* CRC32 of the descriptor w/o header */
 	__le16 size;		/* size of the descriptor w/o header */
-	__u8 version;		/* descriptor version */
+	__u8 version;	/* descriptor version */
 	__u8 reserved[5];	/* pad to 64 bit */
 };
 
@@ -359,7 +376,7 @@ struct comms_msg_header {
 	__le32 magic;		/* magic for validation */
 	__le32 crc32;		/* CRC32 of the message w/o header */
 	__le16 size;		/* size of the message w/o header */
-	__u8 version;		/* message payload version */
+	__u8 version;	/* message payload version */
 	__u8 type;		/* message type */
 	__u8 reserved[4];	/* pad to 64 bit */
 };
@@ -372,8 +389,7 @@ struct lkd_fw_comms_desc {
 	char cur_fw_ver[VERSION_MAX_LEN];
 	/* can be used for 1 more version w/o ABI change */
 	char reserved0[VERSION_MAX_LEN];
-	/* address for next FW component load */
-	__le64 img_addr;
+	__le64 img_addr;	/* address for next FW component load */
 };
 
 enum comms_reset_cause {
@@ -382,10 +398,11 @@ enum comms_reset_cause {
 	HL_RESET_CAUSE_TDR = 2,
 };
 
-#define RESET_CAUSE_PADDING	7
+/* TODO: remove define after struct name is aligned on all projects */
+#define lkd_msg_comms lkd_fw_comms_msg
 
 /* this is the comms message descriptor */
-struct lkd_msg_comms {
+struct lkd_fw_comms_msg {
 	struct comms_msg_header header;
 	/* union for future expantions of new messages */
 	union {
@@ -400,7 +417,6 @@ struct lkd_msg_comms {
 		};
 		struct {
 			__u8 reset_cause;
-			__u8 reserved[RESET_CAUSE_PADDING]; /* 64 bit pad */
 		};
 	};
 };
@@ -474,7 +490,7 @@ enum comms_cmd {
 struct comms_command {
 	union {		/* bit fields are only for FW use */
 		struct {
-			u32 size :25;			/* 32MB max. */
+			u32 size :25;		/* 32MB max. */
 			u32 reserved :2;
 			enum comms_cmd cmd :5;		/* 32 commands */
 		};
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
index a4afb984d0ae..34ca4fe50d91 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
@@ -20,6 +20,9 @@
 #define UBOOT_FW_OFFSET			0x100000	/* 1MB in SRAM */
 #define LINUX_FW_OFFSET			0x800000	/* 8MB in HBM */
 
+/* HBM thermal delta in [Deg] added to composite (CTemp) */
+#define HBM_TEMP_ADJUST_COEFF		6
+
 enum gaudi_nic_axi_error {
 	RXB,
 	RXE,
@@ -56,6 +59,8 @@ struct eq_nic_sei_event {
  * @pcs_link: has PCS link.
  * @phy_ready: is PHY ready.
  * @auto_neg: is Autoneg enabled.
+ * @timeout_retransmission_cnt: timeout retransmission events
+ * @high_ber_cnt: high ber events
  */
 struct gaudi_nic_status {
 	__u32 port;
@@ -69,6 +74,8 @@ struct gaudi_nic_status {
 	__u8 pcs_link;
 	__u8 phy_ready;
 	__u8 auto_neg;
+	__u32 timeout_retransmission_cnt;
+	__u32 high_ber_cnt;
 };
 
 struct gaudi_flops_2_data {
-- 
2.25.1

