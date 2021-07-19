Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E92B3CE302
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbhGSPel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242934AbhGSO4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:56:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69D89613AE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626708865;
        bh=dp4ibdsDfeda5R8YUHO7LuFAu1R+Jy6hY+IFRn+mjps=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=izrLVm5xO00A8uo1QVvjNK4CeTdElmYKt9hzZPW4LMo4IvM8b2vax49Aq4XRDZluq
         A8vtx3y9bDn7goCOGhy5GYxgW4689+E6NYaJ5mbUeOXIYtPccBYiaa67Nl8YMY2r/v
         nWHu2fFYnbQyEHl5hoVZK4TL+4KoLwUhIi0g+Hxs3TGS+acnT9skvkdUtcqKmHPGck
         C19CLgflK/53hzhXxk4VXhv4sS0v0CsEsqqb3S1l4kCiy37NuxCFiom4LEvX46/5Sx
         BhfGtUa34wxYTdcdqnf4PZbhIgh3rtH2eO9Zo/JHnArmktHl/SzvDHn2GFB++P6lMu
         oNHLB8WAOskhw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] habanalabs: expose server type in INFO IOCTL
Date:   Mon, 19 Jul 2021 18:34:16 +0300
Message-Id: <20210719153417.4787-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719153417.4787-1-ogabbay@kernel.org>
References: <20210719153417.4787-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the server type property to the hl_info_hw_ip_info structure
that is exposed to the user via the INFO IOCTL.

This is needed by the userspace s/w stack to know the connections map
of the internal links that connect the ASIC among themselves inside the
server.

The F/W will tell us, as part of the NIC information, the server type
that the GAUDI is located in.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h   |  3 ++
 .../misc/habanalabs/common/habanalabs_ioctl.c |  2 +
 drivers/misc/habanalabs/gaudi/gaudi.c         |  2 +
 drivers/misc/habanalabs/goya/goya.c           |  2 +
 .../misc/habanalabs/include/common/cpucp_if.h | 11 +++++
 include/uapi/misc/habanalabs.h                | 49 +++++++++++++++++--
 7 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 869c6057ae31..0be3f5414f0b 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 1ea8e70a5a34..6fc2234576de 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -489,6 +489,8 @@ struct hl_hints_range {
  *                                       reserved for the user
  * @first_available_cq: first available CQ for the user.
  * @user_interrupt_count: number of user interrupts.
+ * @server_type: Server type that the ASIC is currently installed in.
+ *               The value is according to enum hl_server_type in uapi file.
  * @tpc_enabled_mask: which TPCs are enabled.
  * @completion_queues_count: number of completion queues.
  * @fw_security_enabled: true if security measures are enabled in firmware,
@@ -570,6 +572,7 @@ struct asic_fixed_properties {
 	u16				first_available_user_msix_interrupt;
 	u16				first_available_cq[HL_MAX_DCORES];
 	u16				user_interrupt_count;
+	u16				server_type;
 	u8				tpc_enabled_mask;
 	u8				completion_queues_count;
 	u8				fw_security_enabled;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index f4dda7b4acdd..86c3257d9ae1 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -94,6 +94,8 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 
 	hw_ip.first_available_interrupt_id =
 			prop->first_available_user_msix_interrupt;
+	hw_ip.server_type = prop->server_type;
+
 	return copy_to_user(out, &hw_ip,
 		min((size_t) size, sizeof(hw_ip))) ? -EFAULT : 0;
 }
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f134cd7a6798..4bb9970db46a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -645,6 +645,8 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	prop->hard_reset_done_by_fw = false;
 	prop->gic_interrupts_enable = true;
 
+	prop->server_type = HL_SERVER_TYPE_UNKNOWN;
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c070cd14753e..8d890c7cce08 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -469,6 +469,8 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	prop->hard_reset_done_by_fw = false;
 	prop->gic_interrupts_enable = true;
 
+	prop->server_type = HL_SERVER_TYPE_UNKNOWN;
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 80b1d5a9d9f1..2d6f8ea35375 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -700,6 +700,15 @@ struct cpucp_mac_addr {
 	__u8 mac_addr[ETH_ALEN];
 };
 
+enum cpucp_serdes_type {
+	TYPE_1_SERDES_TYPE,
+	TYPE_2_SERDES_TYPE,
+	HLS1_SERDES_TYPE,
+	HLS1H_SERDES_TYPE,
+	UNKNOWN_SERDES_TYPE,
+	MAX_NUM_SERDES_TYPE = UNKNOWN_SERDES_TYPE
+};
+
 struct cpucp_nic_info {
 	struct cpucp_mac_addr mac_addrs[CPUCP_MAX_NICS];
 	__le64 link_mask[CPUCP_NIC_MASK_ARR_LEN];
@@ -708,6 +717,8 @@ struct cpucp_nic_info {
 	__le64 link_ext_mask[CPUCP_NIC_MASK_ARR_LEN];
 	__u8 qsfp_eeprom[CPUCP_NIC_QSFP_EEPROM_MAX_LEN];
 	__le64 auto_neg_mask[CPUCP_NIC_MASK_ARR_LEN];
+	__le16 serdes_type; /* enum cpucp_serdes_type */
+	__u8 reserved[6];
 };
 
 #endif /* CPUCP_IF_H */
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index eca86c545916..b877a5b7ee74 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -279,6 +279,14 @@ enum hl_device_status {
 	HL_DEVICE_STATUS_NEEDS_RESET
 };
 
+enum hl_server_type {
+	HL_SERVER_TYPE_UNKNOWN = 0,
+	HL_SERVER_GAUDI_HLS1 = 1,
+	HL_SERVER_GAUDI_HLS1H = 2,
+	HL_SERVER_GAUDI_TYPE1 = 3,
+	HL_SERVER_GAUDI_TYPE2 = 4
+};
+
 /* Opcode for management ioctl
  *
  * HW_IP_INFO            - Receive information about different IP blocks in the
@@ -337,17 +345,50 @@ enum hl_device_status {
 #define HL_INFO_VERSION_MAX_LEN	128
 #define HL_INFO_CARD_NAME_MAX_LEN	16
 
+/**
+ * struct hl_info_hw_ip_info - hardware information on various IPs in the ASIC
+ * @sram_base_address: The first SRAM physical base address that is free to be
+ *                     used by the user.
+ * @dram_base_address: The first DRAM virtual or physical base address that is
+ *                     free to be used by the user.
+ * @dram_size: The DRAM size that is available to the user.
+ * @sram_size: The SRAM size that is available to the user.
+ * @num_of_events: The number of events that can be received from the f/w. This
+ *                 is needed so the user can what is the size of the h/w events
+ *                 array he needs to pass to the kernel when he wants to fetch
+ *                 the event counters.
+ * @device_id: PCI device ID of the ASIC.
+ * @module_id: Module ID of the ASIC for mezzanine cards in servers
+ *             (From OCP spec).
+ * @first_available_interrupt_id: The first available interrupt ID for the user
+ *                                to be used when it works with user interrupts.
+ *                                Relevant for Gaudi2 and later.
+ * @server_type: Server type that the Gaudi ASIC is currently installed in.
+ *               The value is according to enum hl_server_type
+ * @cpld_version: CPLD version on the board.
+ * @psoc_pci_pll_nr: PCI PLL NR value. Needed by the profiler in some ASICs.
+ * @psoc_pci_pll_nf: PCI PLL NF value. Needed by the profiler in some ASICs.
+ * @psoc_pci_pll_od: PCI PLL OD value. Needed by the profiler in some ASICs.
+ * @psoc_pci_pll_div_factor: PCI PLL DIV factor value. Needed by the profiler
+ *                           in some ASICs.
+ * @tpc_enabled_mask: Bit-mask that represents which TPCs are enabled. Relevant
+ *                    for Goya/Gaudi only.
+ * @dram_enabled: Whether the DRAM is enabled.
+ * @cpucp_version: The CPUCP f/w version.
+ * @card_name: The card name as passed by the f/w.
+ * @dram_page_size: The DRAM physical page size.
+ */
 struct hl_info_hw_ip_info {
 	__u64 sram_base_address;
 	__u64 dram_base_address;
 	__u64 dram_size;
 	__u32 sram_size;
 	__u32 num_of_events;
-	__u32 device_id; /* PCI Device ID */
-	__u32 module_id; /* For mezzanine cards in servers (From OCP spec.) */
+	__u32 device_id;
+	__u32 module_id;
 	__u32 reserved;
 	__u16 first_available_interrupt_id;
-	__u16 reserved2;
+	__u16 server_type;
 	__u32 cpld_version;
 	__u32 psoc_pci_pll_nr;
 	__u32 psoc_pci_pll_nf;
@@ -358,7 +399,7 @@ struct hl_info_hw_ip_info {
 	__u8 pad[2];
 	__u8 cpucp_version[HL_INFO_VERSION_MAX_LEN];
 	__u8 card_name[HL_INFO_CARD_NAME_MAX_LEN];
-	__u64 reserved3;
+	__u64 reserved2;
 	__u64 dram_page_size;
 };
 
-- 
2.25.1

