Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27B635882A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhDHPXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231975AbhDHPW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:22:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2966A6113A;
        Thu,  8 Apr 2021 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617895368;
        bh=oTei11Ju7GCNmhENUtcPef7+B16rkEziRjZCmZ3rnDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LS5WJbj4MkwTQHuiOoKO/7j5m9wmJS0MfUND1gqjLFP/DfL/thaK6+7E+Zvi/9Ev2
         eqjdpBPUJiETWtvnm48kcTXeq8UJ7h6D+H2W8OpkPuvFYSIAWy1ul9ZuzTLpPjnUIz
         +2qb3i3vFy6o7ReuvuSJilBy5cAO5NO6dR6neiFo6+rz6fxuNxsyhG0BZeGRZdvJGw
         sKGLYDte6kkuSMiHVE5TxrNzM1wHi5/TZ4TQlS9pVEqHSMxD+VV4mBrG/ZtmGXov5J
         cSuMDTSOxmr+5SFTGPFMd1/becRwdMjo+ZMJEv5aC7D0bEIvBCRnGFXkyY6wGeHctG
         pyIYME5eDuszQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 7/7] habanalabs: update to latest F/W communication header
Date:   Thu,  8 Apr 2021 18:22:34 +0300
Message-Id: <20210408152234.15383-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408152234.15383-1-ogabbay@kernel.org>
References: <20210408152234.15383-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

update files to latest version from F/W team.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/include/common/cpucp_if.h |   3 +-
 .../habanalabs/include/common/hl_boot_if.h    | 198 ++++++++++++++++++
 2 files changed, 200 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 20a710f7a369..27cd0ba99aa3 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -11,6 +11,8 @@
 #include <linux/types.h>
 #include <linux/if_ether.h>
 
+#include "hl_boot_if.h"
+
 #define NUM_HBM_PSEUDO_CH				2
 #define NUM_HBM_CH_PER_DEV				8
 #define CPUCP_PKT_HBM_ECC_INFO_WR_PAR_SHIFT		0
@@ -564,7 +566,6 @@ struct eq_generic_event {
  */
 
 #define CARD_NAME_MAX_LEN		16
-#define VERSION_MAX_LEN			128
 #define CPUCP_MAX_SENSORS		128
 #define CPUCP_MAX_NICS			128
 #define CPUCP_LANES_PER_NIC		4
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 980b432fd76e..e0a259e0495c 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -13,6 +13,8 @@
 
 #define BOOT_FIT_SRAM_OFFSET		0x200000
 
+#define VERSION_MAX_LEN			128
+
 /*
  * CPU error bits in BOOT_ERROR registers
  *
@@ -251,6 +253,7 @@ enum kmd_msg {
 	KMD_MSG_SKIP_BMC,
 	RESERVED,
 	KMD_MSG_RST_DEV,
+	KMD_MSG_LAST
 };
 
 enum cpu_msg_status {
@@ -259,4 +262,199 @@ enum cpu_msg_status {
 	CPU_MSG_ERR,
 };
 
+/* communication registers mapping - consider ABI when changing */
+struct cpu_dyn_regs {
+	uint32_t cpu_pq_base_addr_low;
+	uint32_t cpu_pq_base_addr_high;
+	uint32_t cpu_pq_length;
+	uint32_t cpu_pq_init_status;
+	uint32_t cpu_eq_base_addr_low;
+	uint32_t cpu_eq_base_addr_high;
+	uint32_t cpu_eq_length;
+	uint32_t cpu_eq_ci;
+	uint32_t cpu_cq_base_addr_low;
+	uint32_t cpu_cq_base_addr_high;
+	uint32_t cpu_cq_length;
+	uint32_t cpu_pf_pq_pi;
+	uint32_t cpu_boot_dev_sts0;
+	uint32_t cpu_boot_dev_sts1;
+	uint32_t cpu_boot_err0;
+	uint32_t cpu_boot_err1;
+	uint32_t cpu_boot_status;
+	uint32_t fw_upd_sts;
+	uint32_t fw_upd_cmd;
+	uint32_t fw_upd_pending_sts;
+	uint32_t fuse_ver_offset;
+	uint32_t preboot_ver_offset;
+	uint32_t uboot_ver_offset;
+	uint32_t hw_state;
+	uint32_t kmd_msg_to_cpu;
+	uint32_t cpu_cmd_status_to_host;
+	uint32_t reserved1[32];		/* reserve for future use */
+};
+
+/* HCDM - Habana Communications Descriptor Magic */
+#define HL_COMMS_DESC_MAGIC	0x4843444D
+#define HL_COMMS_DESC_VER	1
+
+/* this is the comms descriptor header - meta data */
+struct comms_desc_header {
+	uint32_t magic;		/* magic for validation */
+	uint32_t crc32;		/* CRC32 of the descriptor w/o header */
+	uint16_t size;		/* size of the descriptor w/o header */
+	uint8_t version;	/* descriptor version */
+	uint8_t reserved[5];	/* pad to 64 bit */
+};
+
+/* this is the main FW descriptor - consider ABI when changing */
+struct lkd_fw_comms_desc {
+	struct comms_desc_header header;
+	struct cpu_dyn_regs cpu_dyn_regs;
+	char fuse_ver[VERSION_MAX_LEN];
+	char cur_fw_ver[VERSION_MAX_LEN];
+	/* can be used for 1 more version w/o ABI change */
+	char reserved0[VERSION_MAX_LEN];
+	uint64_t img_addr;	/* address for next FW component load */
+};
+
+/*
+ * LKD commands:
+ *
+ * COMMS_NOOP			Used to clear the command register and no actual
+ *				command is send.
+ *
+ * COMMS_CLR_STS		Clear status command - FW should clear the
+ *				status register. Used for synchronization
+ *				between the commands as part of the race free
+ *				protocol.
+ *
+ * COMMS_RST_STATE		Reset the current communication state which is
+ *				kept by FW for proper responses.
+ *				Should be used in the beginning of the
+ *				communication cycle to clean any leftovers from
+ *				previous communication attempts.
+ *
+ * COMMS_PREP_DESC		Prepare descriptor for setting up the
+ *				communication and other dynamic data:
+ *				struct lkd_fw_comms_desc.
+ *				This command has a parameter stating the next FW
+ *				component size, so the FW can actually prepare a
+ *				space for it and in the status response provide
+ *				the descriptor offset. The Offset of the next FW
+ *				data component is a part of the descriptor
+ *				structure.
+ *
+ * COMMS_DATA_RDY		The FW data has been uploaded and is ready for
+ *				validation.
+ *
+ * COMMS_EXEC			Execute the next FW component.
+ *
+ * COMMS_RST_DEV		Reset the device.
+ *
+ * COMMS_GOTO_WFE		Execute WFE command. Allowed only on non-secure
+ *				devices.
+ *
+ * COMMS_SKIP_BMC		Perform actions required for BMC-less servers.
+ *				Do not wait for BMC response.
+ *
+ * COMMS_LOW_PLL_OPP		Initialize PLLs for low OPP.
+ */
+enum comms_cmd {
+	COMMS_NOOP = 0,
+	COMMS_CLR_STS = 1,
+	COMMS_RST_STATE = 2,
+	COMMS_PREP_DESC = 3,
+	COMMS_DATA_RDY = 4,
+	COMMS_EXEC = 5,
+	COMMS_RST_DEV = 6,
+	COMMS_GOTO_WFE = 7,
+	COMMS_SKIP_BMC = 8,
+	COMMS_LOW_PLL_OPP = 9,
+	COMMS_INVLD_LAST
+};
+
+#define COMMS_COMMAND_SIZE_SHIFT	0
+#define COMMS_COMMAND_SIZE_MASK		0x1FFFFFF
+#define COMMS_COMMAND_CMD_SHIFT		27
+#define COMMS_COMMAND_CMD_MASK		0xF8000000
+
+/*
+ * LKD command to FW register structure
+ * @size	- FW component size
+ * @cmd		- command from enum comms_cmd
+ */
+struct comms_command {
+	union {		/* bit fields are only for FW use */
+		struct {
+			unsigned int size :25;		/* 32MB max. */
+			unsigned int reserved :2;
+			enum comms_cmd cmd :5;		/* 32 commands */
+		};
+		unsigned int val;
+	};
+};
+
+/*
+ * FW status
+ *
+ * COMMS_STS_NOOP		Used to clear the status register and no actual
+ *				status is provided.
+ *
+ * COMMS_STS_ACK		Command has been received and recognized.
+ *
+ * COMMS_STS_OK			Command execution has finished successfully.
+ *
+ * COMMS_STS_ERR		Command execution was unsuccessful and resulted
+ *				in error.
+ *
+ * COMMS_STS_VALID_ERR		FW validation has failed.
+ *
+ * COMMS_STS_TIMEOUT_ERR	Command execution has timed out.
+ */
+enum comms_sts {
+	COMMS_STS_NOOP = 0,
+	COMMS_STS_ACK = 1,
+	COMMS_STS_OK = 2,
+	COMMS_STS_ERR = 3,
+	COMMS_STS_VALID_ERR = 4,
+	COMMS_STS_TIMEOUT_ERR = 5,
+	COMMS_STS_INVLD_LAST
+};
+
+/* RAM types for FW components loading - defines the base address */
+enum comms_ram_types {
+	COMMS_SRAM = 0,
+	COMMS_DRAM = 1,
+};
+
+#define COMMS_STATUS_OFFSET_SHIFT	0
+#define COMMS_STATUS_OFFSET_MASK	0x03FFFFFF
+#define COMMS_STATUS_OFFSET_ALIGN_SHIFT	2
+#define COMMS_STATUS_RAM_TYPE_SHIFT	26
+#define COMMS_STATUS_RAM_TYPE_MASK	0x0C000000
+#define COMMS_STATUS_STATUS_SHIFT	28
+#define COMMS_STATUS_STATUS_MASK	0xF0000000
+
+/*
+ * FW status to LKD register structure
+ * @offset	- an offset from the base of the ram_type shifted right by
+ *		  2 bits (always aligned to 32 bits).
+ *		  Allows a maximum addressable offset of 256MB from RAM base.
+ *		  Example: for real offset in RAM of 0x800000 (8MB), the value
+ *		  in offset field is (0x800000 >> 2) = 0x200000.
+ * @ram_type	- the RAM type that should be used for offset from
+ *		  enum comms_ram_types
+ * @status	- status from enum comms_sts
+ */
+struct comms_status {
+	union {		/* bit fields are only for FW use */
+		struct {
+			unsigned int offset :26;
+			unsigned int ram_type :2;
+			enum comms_sts status :4;	/* 16 statuses */
+		};
+		unsigned int val;
+	};
+};
+
 #endif /* HL_BOOT_IF_H */
-- 
2.25.1

