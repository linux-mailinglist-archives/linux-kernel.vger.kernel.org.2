Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6B3B3F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFYI3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:29:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhFYI3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:29:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D91261435;
        Fri, 25 Jun 2021 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624609630;
        bh=ReA4mFsbSOV+n958VJNpxhVyJxNyMyavcrnO6m8Ir8I=;
        h=From:To:Cc:Subject:Date:From;
        b=CJ42ifLdriI77srh91aszyIVxkJDSzX3eG2o+GMka6uF33GzFvsb96e3lenxJSNSQ
         aMYRrkXt6CpCdwvxAXvmTkeRWVN+znhxsTpaFIQptOzSv+UeiWkzUTGtY+zKrNsP1h
         /qwRm+qxS3bDLij9INPbsqtaisVDPCuIy8DX2WKjRqzEh3ubZytARKHFAFAl5vaOSV
         /R3rjJALbJxchDjSPQAByjqb59I3H2tmVSW5DenImb7d9N+F+6UPKRPPHlmQxTZY7K
         g9+LyCyfCkFaBqWo1nPzLPDWPZFo0uZIS59a/4sDEi4OPzvECW62WCB9TY6KGFgzg6
         2B2qXC2IkWEPg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 1/2] habanalabs: support hint addresses range reservation
Date:   Fri, 25 Jun 2021 11:27:05 +0300
Message-Id: <20210625082706.9884-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Add support for pre-determined driver-reserved device VA address ranges.
This is needed for future ASIC support where some contents must be
mapped into these pre-determined ranges because the H/W will be
configured using these ranges.

In case the user asks to map a VA without a hint address, avoid
allocating the device VA from the reserved ranges.

Make sure the validation checks of the hint address take into account
situation where the DRAM page size is not pow of 2.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 22 ++++++++
 drivers/misc/habanalabs/common/memory.c     | 62 ++++++++++++++++++---
 2 files changed, 76 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6b3cdd7e068a..0edc72e678c9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -381,6 +381,16 @@ struct hl_mmu_properties {
 	u8	host_resident;
 };
 
+/**
+ * struct hl_hints_range - hint addresses reserved va range.
+ * @start_addr: start address of the va range.
+ * @end_addr: end address of the va range.
+ */
+struct hl_hints_range {
+	u64 start_addr;
+	u64 end_addr;
+};
+
 /**
  * struct asic_fixed_properties - ASIC specific immutable properties.
  * @hw_queues_props: H/W queues properties.
@@ -392,6 +402,10 @@ struct hl_mmu_properties {
  * @pmmu: PCI (host) MMU address translation properties.
  * @pmmu_huge: PCI (host) MMU address translation properties for memory
  *              allocated with huge pages.
+ * @hints_dram_reserved_va_range: dram hint addresses reserved range.
+ * @hints_host_reserved_va_range: host hint addresses reserved range.
+ * @hints_host_hpage_reserved_va_range: host huge page hint addresses reserved
+ *                                      range.
  * @sram_base_address: SRAM physical start address.
  * @sram_end_address: SRAM physical end address.
  * @sram_user_base_address - SRAM physical start address for user access.
@@ -412,6 +426,8 @@ struct hl_mmu_properties {
  *                    to the device's MMU.
  * @cb_va_end_addr: virtual end address of command buffers which are mapped to
  *                  the device's MMU.
+ * @dram_hints_align_mask: dram va hint addresses alignment mask which is used
+ *                  for hints validity check.
  * @mmu_pgt_size: MMU page tables total size.
  * @mmu_pte_size: PTE size in MMU page tables.
  * @mmu_hop_table_size: MMU hop table size.
@@ -470,6 +486,7 @@ struct hl_mmu_properties {
  * @dram_supports_virtual_memory: is there an MMU towards the DRAM
  * @hard_reset_done_by_fw: true if firmware is handling hard reset flow
  * @num_functional_hbms: number of functional HBMs in each DCORE.
+ * @hints_range_reservation: device support hint addresses range reservation.
  * @iatu_done_by_fw: true if iATU configuration is being done by FW.
  * @dynamic_fw_load: is dynamic FW load is supported.
  * @gic_interrupts_enable: true if FW is not blocking GIC controller,
@@ -483,6 +500,9 @@ struct asic_fixed_properties {
 	struct hl_mmu_properties	dmmu;
 	struct hl_mmu_properties	pmmu;
 	struct hl_mmu_properties	pmmu_huge;
+	struct hl_hints_range		hints_dram_reserved_va_range;
+	struct hl_hints_range		hints_host_reserved_va_range;
+	struct hl_hints_range		hints_host_hpage_reserved_va_range;
 	u64				sram_base_address;
 	u64				sram_end_address;
 	u64				sram_user_base_address;
@@ -500,6 +520,7 @@ struct asic_fixed_properties {
 	u64				mmu_dram_default_page_addr;
 	u64				cb_va_start_addr;
 	u64				cb_va_end_addr;
+	u64				dram_hints_align_mask;
 	u32				mmu_pgt_size;
 	u32				mmu_pte_size;
 	u32				mmu_hop_table_size;
@@ -542,6 +563,7 @@ struct asic_fixed_properties {
 	u8				dram_supports_virtual_memory;
 	u8				hard_reset_done_by_fw;
 	u8				num_functional_hbms;
+	u8				hints_range_reservation;
 	u8				iatu_done_by_fw;
 	u8				dynamic_fw_load;
 	u8				gic_interrupts_enable;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index af339ce1ab4f..d9429b98313a 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -528,6 +528,33 @@ static inline int add_va_block(struct hl_device *hdev,
 	return rc;
 }
 
+/**
+ * is_hint_crossing_range() - check if hint address crossing specified reserved
+ * range.
+ */
+static inline bool is_hint_crossing_range(enum hl_va_range_type range_type,
+		u64 start_addr, u32 size, struct asic_fixed_properties *prop) {
+	bool range_cross;
+
+	if (range_type == HL_VA_RANGE_TYPE_DRAM)
+		range_cross =
+			hl_mem_area_crosses_range(start_addr, size,
+			prop->hints_dram_reserved_va_range.start_addr,
+			prop->hints_dram_reserved_va_range.end_addr);
+	else if (range_type == HL_VA_RANGE_TYPE_HOST)
+		range_cross =
+			hl_mem_area_crosses_range(start_addr,	size,
+			prop->hints_host_reserved_va_range.start_addr,
+			prop->hints_host_reserved_va_range.end_addr);
+	else
+		range_cross =
+			hl_mem_area_crosses_range(start_addr, size,
+			prop->hints_host_hpage_reserved_va_range.start_addr,
+			prop->hints_host_hpage_reserved_va_range.end_addr);
+
+	return range_cross;
+}
+
 /**
  * get_va_block() - get a virtual block for the given size and alignment.
  *
@@ -536,6 +563,7 @@ static inline int add_va_block(struct hl_device *hdev,
  * @size: requested block size.
  * @hint_addr: hint for requested address by the user.
  * @va_block_align: required alignment of the virtual block start address.
+ * @range_type: va range type (host, dram)
  *
  * This function does the following:
  * - Iterate on the virtual block list to find a suitable virtual block for the
@@ -545,13 +573,17 @@ static inline int add_va_block(struct hl_device *hdev,
  */
 static u64 get_va_block(struct hl_device *hdev,
 				struct hl_va_range *va_range,
-				u64 size, u64 hint_addr, u32 va_block_align)
+				u64 size, u64 hint_addr, u32 va_block_align,
+				enum hl_va_range_type range_type)
 {
 	struct hl_vm_va_block *va_block, *new_va_block = NULL;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u64 tmp_hint_addr, valid_start, valid_size, prev_start, prev_end,
-		align_mask, reserved_valid_start = 0, reserved_valid_size = 0;
+		align_mask, reserved_valid_start = 0, reserved_valid_size = 0,
+		dram_hint_mask = prop->dram_hints_align_mask;
 	bool add_prev = false;
 	bool is_align_pow_2  = is_power_of_2(va_range->page_size);
+	bool is_hint_dram_addr = hl_is_dram_va(hdev, hint_addr);
 
 	if (is_align_pow_2)
 		align_mask = ~((u64)va_block_align - 1);
@@ -564,12 +596,12 @@ static u64 get_va_block(struct hl_device *hdev,
 		size = DIV_ROUND_UP_ULL(size, va_range->page_size) *
 							va_range->page_size;
 
-	tmp_hint_addr = hint_addr;
+	tmp_hint_addr = hint_addr & ~dram_hint_mask;
 
 	/* Check if we need to ignore hint address */
 	if ((is_align_pow_2 && (hint_addr & (va_block_align - 1))) ||
-			(!is_align_pow_2 &&
-				do_div(tmp_hint_addr, va_range->page_size))) {
+		(!is_align_pow_2 && is_hint_dram_addr &&
+			do_div(tmp_hint_addr, va_range->page_size))) {
 
 		dev_dbg(hdev->dev,
 			"Hint address 0x%llx will be ignored because it is not aligned\n",
@@ -596,6 +628,16 @@ static u64 get_va_block(struct hl_device *hdev,
 		if (valid_size < size)
 			continue;
 
+		/*
+		 * In case hint address is 0, and arc_hints_range_reservation
+		 * property enabled, then avoid allocating va blocks from the
+		 * range reserved for hint addresses
+		 */
+		if (prop->hints_range_reservation && !hint_addr)
+			if (is_hint_crossing_range(range_type, valid_start,
+					size, prop))
+				continue;
+
 		/* Pick the minimal length block which has the required size */
 		if (!new_va_block || (valid_size < reserved_valid_size)) {
 			new_va_block = va_block;
@@ -670,7 +712,7 @@ u64 hl_reserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
 		enum hl_va_range_type type, u32 size, u32 alignment)
 {
 	return get_va_block(hdev, ctx->va_range[type], size, 0,
-			max(alignment, ctx->va_range[type]->page_size));
+			max(alignment, ctx->va_range[type]->page_size), type);
 }
 
 /**
@@ -1006,6 +1048,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	u32 handle = 0, va_block_align;
 	int rc;
 	bool is_userptr = args->flags & HL_MEM_USERPTR;
+	enum hl_va_range_type va_range_type = 0;
 
 	/* Assume failure */
 	*device_addr = 0;
@@ -1038,7 +1081,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		/* get required alignment */
 		if (phys_pg_pack->page_size == page_size) {
 			va_range = ctx->va_range[HL_VA_RANGE_TYPE_HOST];
-
+			va_range_type = HL_VA_RANGE_TYPE_HOST;
 			/*
 			 * huge page alignment may be needed in case of regular
 			 * page mapping, depending on the host VA alignment
@@ -1053,6 +1096,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 			 * mapping
 			 */
 			va_range = ctx->va_range[HL_VA_RANGE_TYPE_HOST_HUGE];
+			va_range_type = HL_VA_RANGE_TYPE_HOST_HUGE;
 			va_block_align = huge_page_size;
 		}
 	} else {
@@ -1078,6 +1122,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 		/* DRAM VA alignment is the same as the MMU page size */
 		va_range = ctx->va_range[HL_VA_RANGE_TYPE_DRAM];
+		va_range_type = HL_VA_RANGE_TYPE_DRAM;
 		va_block_align = hdev->asic_prop.dmmu.page_size;
 	}
 
@@ -1101,7 +1146,8 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	}
 
 	ret_vaddr = get_va_block(hdev, va_range, phys_pg_pack->total_size,
-					hint_addr, va_block_align);
+					hint_addr, va_block_align,
+					va_range_type);
 	if (!ret_vaddr) {
 		dev_err(hdev->dev, "no available va block for handle %u\n",
 				handle);
-- 
2.25.1

