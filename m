Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C63BACF2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhGDLxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 07:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhGDLxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 07:53:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ADE9613D2;
        Sun,  4 Jul 2021 11:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625399471;
        bh=0o7FdprM6BfWGnJ5hLmeXNEU8SIQR+8aFqM7vd3MVLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLNrowA6gvEEob4aLlw0FhC37fmmSZoJrDiyusbBNM09LMyiyeaZiCXRnR4hvzzd9
         C4PAuTta03BvC8vqezHZTwpA3vS2NbRh7bAutOirtRlZVGE5BBp2Ftw64NPApipYnZ
         PRGfYEHzu6G7Vv7onZ+EKsthq+bNlk8UJbD075nHDw+j3muS6gMhRVPmmrvYEoNP6Y
         XLYFUmJkBnSjAOr5PbLbwpvE2C4BVCmJ8jZC4Idd7ShWlQ7hLlZajIPWTgurm7duj5
         EZSCzrpNu2eYmM2bIyElfAsnAmsRFjsuTNuGxTndDiKD4joY56aMR7W+1YEi/rMGzN
         089vZlvg7/rcw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 4/4] habanalabs/gaudi: implement state dump
Date:   Sun,  4 Jul 2021 14:51:02 +0300
Message-Id: <20210704115102.9223-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704115102.9223-1-ogabbay@kernel.org>
References: <20210704115102.9223-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

At the first stage, only gaudi core dump shall be implemented, not
including the status registers.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         | 298 +++++++++++++++++-
 drivers/misc/habanalabs/gaudi/gaudiP.h        |  12 +
 .../include/gaudi/asic_reg/gaudi_regs.h       |   3 +
 .../habanalabs/include/gaudi/gaudi_masks.h    |  17 +
 4 files changed, 319 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 29ada339b66a..7dd36d1cb39e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -106,6 +106,8 @@
 
 #define GAUDI_PLL_MAX 10
 
+#define BIN_REG_STRING_SIZE	sizeof("0b10101010101010101010101010101010")
+
 static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
 		"gaudi cq 0_0", "gaudi cq 0_1", "gaudi cq 0_2", "gaudi cq 0_3",
 		"gaudi cq 1_0", "gaudi cq 1_1", "gaudi cq 1_2", "gaudi cq 1_3",
@@ -348,7 +350,90 @@ static enum hl_queue_type gaudi_queue_type[GAUDI_QUEUE_ID_SIZE] = {
 	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_9_3 */
 };
 
-static s64 gaudi_state_dump_specs_props[SP_MAX] = {0};
+static struct hl_hw_obj_name_entry gaudi_so_id_to_str[] = {
+	{ .id = 0,  .name = "SYNC_OBJ_DMA_DOWN_FEEDBACK" },
+	{ .id = 1,  .name = "SYNC_OBJ_DMA_UP_FEEDBACK" },
+	{ .id = 2,  .name = "SYNC_OBJ_DMA_STATIC_DRAM_SRAM_FEEDBACK" },
+	{ .id = 3,  .name = "SYNC_OBJ_DMA_SRAM_DRAM_FEEDBACK" },
+	{ .id = 4,  .name = "SYNC_OBJ_FIRST_COMPUTE_FINISH" },
+	{ .id = 5,  .name = "SYNC_OBJ_HOST_DRAM_DONE" },
+	{ .id = 6,  .name = "SYNC_OBJ_DBG_CTR_DEPRECATED" },
+	{ .id = 7,  .name = "SYNC_OBJ_DMA_ACTIVATIONS_DRAM_SRAM_FEEDBACK" },
+	{ .id = 8,  .name = "SYNC_OBJ_ENGINE_SEM_MME_0" },
+	{ .id = 9,  .name = "SYNC_OBJ_ENGINE_SEM_MME_1" },
+	{ .id = 10, .name = "SYNC_OBJ_ENGINE_SEM_TPC_0" },
+	{ .id = 11, .name = "SYNC_OBJ_ENGINE_SEM_TPC_1" },
+	{ .id = 12, .name = "SYNC_OBJ_ENGINE_SEM_TPC_2" },
+	{ .id = 13, .name = "SYNC_OBJ_ENGINE_SEM_TPC_3" },
+	{ .id = 14, .name = "SYNC_OBJ_ENGINE_SEM_TPC_4" },
+	{ .id = 15, .name = "SYNC_OBJ_ENGINE_SEM_TPC_5" },
+	{ .id = 16, .name = "SYNC_OBJ_ENGINE_SEM_TPC_6" },
+	{ .id = 17, .name = "SYNC_OBJ_ENGINE_SEM_TPC_7" },
+	{ .id = 18, .name = "SYNC_OBJ_ENGINE_SEM_DMA_1" },
+	{ .id = 19, .name = "SYNC_OBJ_ENGINE_SEM_DMA_2" },
+	{ .id = 20, .name = "SYNC_OBJ_ENGINE_SEM_DMA_3" },
+	{ .id = 21, .name = "SYNC_OBJ_ENGINE_SEM_DMA_4" },
+	{ .id = 22, .name = "SYNC_OBJ_ENGINE_SEM_DMA_5" },
+	{ .id = 23, .name = "SYNC_OBJ_ENGINE_SEM_DMA_6" },
+	{ .id = 24, .name = "SYNC_OBJ_ENGINE_SEM_DMA_7" },
+	{ .id = 25, .name = "SYNC_OBJ_DBG_CTR_0" },
+	{ .id = 26, .name = "SYNC_OBJ_DBG_CTR_1" },
+};
+
+static struct hl_hw_obj_name_entry gaudi_monitor_id_to_str[] = {
+	{ .id = 200, .name = "MON_OBJ_DMA_DOWN_FEEDBACK_RESET" },
+	{ .id = 201, .name = "MON_OBJ_DMA_UP_FEADBACK_RESET" },
+	{ .id = 203, .name = "MON_OBJ_DRAM_TO_SRAM_QUEUE_FENCE" },
+	{ .id = 204, .name = "MON_OBJ_TPC_0_CLK_GATE" },
+	{ .id = 205, .name = "MON_OBJ_TPC_1_CLK_GATE" },
+	{ .id = 206, .name = "MON_OBJ_TPC_2_CLK_GATE" },
+	{ .id = 207, .name = "MON_OBJ_TPC_3_CLK_GATE" },
+	{ .id = 208, .name = "MON_OBJ_TPC_4_CLK_GATE" },
+	{ .id = 209, .name = "MON_OBJ_TPC_5_CLK_GATE" },
+	{ .id = 210, .name = "MON_OBJ_TPC_6_CLK_GATE" },
+	{ .id = 211, .name = "MON_OBJ_TPC_7_CLK_GATE" },
+};
+
+static s64 gaudi_state_dump_specs_props[] = {
+	[SP_SYNC_OBJ_BASE_ADDR] = mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0,
+	[SP_NEXT_SYNC_OBJ_ADDR] = NEXT_SYNC_OBJ_ADDR_INTERVAL,
+	[SP_SYNC_OBJ_AMOUNT] = NUM_OF_SOB_IN_BLOCK,
+	[SP_MON_OBJ_WR_ADDR_LOW] =
+		mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0,
+	[SP_MON_OBJ_WR_ADDR_HIGH] =
+		mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRH_0,
+	[SP_MON_OBJ_WR_DATA] = mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_DATA_0,
+	[SP_MON_OBJ_ARM_DATA] = mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_ARM_0,
+	[SP_MON_OBJ_STATUS] = mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_STATUS_0,
+	[SP_MONITORS_AMOUNT] = NUM_OF_MONITORS_IN_BLOCK,
+	[SP_TPC0_CMDQ] = mmTPC0_QM_GLBL_CFG0,
+	[SP_TPC0_CFG_SO] = mmTPC0_CFG_QM_SYNC_OBJECT_ADDR,
+	[SP_NEXT_TPC] = mmTPC1_QM_GLBL_CFG0 - mmTPC0_QM_GLBL_CFG0,
+	[SP_MME_CMDQ] = mmMME0_QM_GLBL_CFG0,
+	[SP_MME_CFG_SO] = mmMME0_CTRL_ARCH_DESC_SYNC_OBJECT_ADDR_LOW_LOCAL,
+	[SP_NEXT_MME] = mmMME2_QM_GLBL_CFG0 - mmMME0_QM_GLBL_CFG0,
+	[SP_DMA_CMDQ] = mmDMA0_QM_GLBL_CFG0,
+	[SP_DMA_CFG_SO] = mmDMA0_CORE_WR_COMP_ADDR_LO,
+	[SP_DMA_QUEUES_OFFSET] = mmDMA1_QM_GLBL_CFG0 - mmDMA0_QM_GLBL_CFG0,
+	[SP_NUM_OF_MME_ENGINES] = NUM_OF_MME_ENGINES,
+	[SP_SUB_MME_ENG_NUM] = NUM_OF_MME_SUB_ENGINES,
+	[SP_NUM_OF_DMA_ENGINES] = NUM_OF_DMA_ENGINES,
+	[SP_NUM_OF_TPC_ENGINES] = NUM_OF_TPC_ENGINES,
+	[SP_ENGINE_NUM_OF_QUEUES] = NUM_OF_QUEUES,
+	[SP_ENGINE_NUM_OF_STREAMS] = NUM_OF_STREAMS,
+	[SP_ENGINE_NUM_OF_FENCES] = NUM_OF_FENCES,
+	[SP_FENCE0_CNT_OFFSET] =
+		mmDMA0_QM_CP_FENCE0_CNT_0 - mmDMA0_QM_GLBL_CFG0,
+	[SP_FENCE0_RDATA_OFFSET] =
+		mmDMA0_QM_CP_FENCE0_RDATA_0 - mmDMA0_QM_GLBL_CFG0,
+	[SP_CP_STS_OFFSET] = mmDMA0_QM_CP_STS_0 - mmDMA0_QM_GLBL_CFG0,
+	[SP_NUM_CORES] = 1,
+};
+
+static const char * const gaudi_sync_manager_names[] = {
+	"SYNC_MGR_E_N", "SYNC_MGR_W_N", "SYNC_MGR_E_S", "SYNC_MGR_W_S",
+	NULL
+};
 
 struct ecc_info_extract_params {
 	u64 block_address;
@@ -8979,25 +9064,141 @@ static int gaudi_map_pll_idx_to_fw_idx(u32 pll_idx)
 	}
 }
 
+static int gaudi_add_sync_to_engine_map_entry(
+	struct hl_sync_to_engine_map *map, u32 reg_value,
+	enum hl_sync_engine_type engine_type, u32 engine_id)
+{
+	struct hl_sync_to_engine_map_entry *entry;
+
+	/* Reg value represents a partial address of sync object,
+	 * it is used as unique identifier. For this we need to
+	 * clear the cutoff cfg base bits from the value.
+	 */
+	if (reg_value == 0 || reg_value == 0xffffffff)
+		return 0;
+	reg_value -= (u32)CFG_BASE;
+
+	/* create a new hash entry */
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	entry->engine_type = engine_type;
+	entry->engine_id = engine_id;
+	entry->sync_id = reg_value;
+	hash_add(map->tb, &entry->node, reg_value);
+
+	return 0;
+}
+
 static int gaudi_gen_sync_to_engine_map(struct hl_device *hdev,
 				struct hl_sync_to_engine_map *map)
 {
-	/* Not implemented */
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	int i, j, rc;
+	u32 reg_value;
+
+	/* Iterate over TPC engines */
+	for (i = 0; i < sds->props[SP_NUM_OF_TPC_ENGINES]; ++i) {
+		/* TPC registered must be accessed with clock gating disabled */
+		mutex_lock(&gaudi->clk_gate_mutex);
+		hdev->asic_funcs->disable_clock_gating(hdev);
+
+		reg_value = RREG32(sds->props[SP_TPC0_CFG_SO] +
+					sds->props[SP_NEXT_TPC] * i);
+
+		/* We can reenable clock_gating */
+		hdev->asic_funcs->set_clock_gating(hdev);
+		mutex_unlock(&gaudi->clk_gate_mutex);
+
+		rc = gaudi_add_sync_to_engine_map_entry(map, reg_value,
+							ENGINE_TPC, i);
+		if (rc)
+			goto free_sync_to_engine_map;
+	}
+
+	/* Iterate over MME engines */
+	for (i = 0; i < sds->props[SP_NUM_OF_MME_ENGINES]; ++i) {
+		for (j = 0; j < sds->props[SP_SUB_MME_ENG_NUM]; ++j) {
+			/* MME registered must be accessed with clock gating
+			 * disabled
+			 */
+			mutex_lock(&gaudi->clk_gate_mutex);
+			hdev->asic_funcs->disable_clock_gating(hdev);
+
+			reg_value = RREG32(sds->props[SP_MME_CFG_SO] +
+						sds->props[SP_NEXT_MME] * i +
+						j * sizeof(u32));
+
+			/* We can reenable clock_gating */
+			hdev->asic_funcs->set_clock_gating(hdev);
+			mutex_unlock(&gaudi->clk_gate_mutex);
+
+			rc = gaudi_add_sync_to_engine_map_entry(
+				map, reg_value, ENGINE_MME,
+				i * sds->props[SP_SUB_MME_ENG_NUM] + j);
+			if (rc)
+				goto free_sync_to_engine_map;
+		}
+	}
+
+	/* Iterate over DMA engines */
+	for (i = 0; i < sds->props[SP_NUM_OF_DMA_ENGINES]; ++i) {
+		reg_value = RREG32(sds->props[SP_DMA_CFG_SO] +
+					sds->props[SP_DMA_QUEUES_OFFSET] * i);
+		rc = gaudi_add_sync_to_engine_map_entry(map, reg_value,
+							ENGINE_DMA, i);
+		if (rc)
+			goto free_sync_to_engine_map;
+	}
+
 	return 0;
+
+free_sync_to_engine_map:
+	hl_state_dump_free_sync_to_engine_map(map);
+
+	return rc;
 }
 
 static int gaudi_monitor_valid(struct hl_mon_state_dump *mon)
 {
-	/* Not implemented */
-	return 0;
+	return FIELD_GET(
+		SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_STATUS_0_VALID_MASK,
+		mon->status);
 }
 
 static int gaudi_print_single_monitor(char **buf, size_t *size, size_t *offset,
 				struct hl_device *hdev,
 				struct hl_mon_state_dump *mon)
 {
-	/* Not implemented */
-	return 0;
+	const char *name;
+	char scratch_buf1[BIN_REG_STRING_SIZE],
+		scratch_buf2[BIN_REG_STRING_SIZE];
+
+	name = hl_state_dump_get_monitor_name(hdev, mon);
+	if (!name)
+		name = "";
+
+	return hl_snprintf_resize(
+		buf, size, offset,
+		"Mon id: %u%s, wait for group id: %u mask %s to reach val: %u and write %u to address 0x%llx. Pending: %s",
+		mon->id, name,
+		FIELD_GET(SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_SID_MASK,
+				mon->arm_data),
+		hl_format_as_binary(
+			scratch_buf1, sizeof(scratch_buf1),
+			FIELD_GET(
+				SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_MASK_MASK,
+				mon->arm_data)),
+		FIELD_GET(SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_SOD_MASK,
+				mon->arm_data),
+		mon->wr_data,
+		(((u64)mon->wr_addr_high) << 32) | mon->wr_addr_low,
+		hl_format_as_binary(
+			scratch_buf2, sizeof(scratch_buf2),
+			FIELD_GET(
+				SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_STATUS_0_PENDING_MASK,
+				mon->status)));
 }
 
 
@@ -9006,8 +9207,68 @@ static int gaudi_print_fences_single_engine(
 	enum hl_sync_engine_type engine_type, u32 engine_id, char **buf,
 	size_t *size, size_t *offset)
 {
-	/* Not implemented */
-	return 0;
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	int rc = -ENOMEM, i;
+	u32 *statuses, *fences;
+
+	statuses = kcalloc(sds->props[SP_ENGINE_NUM_OF_QUEUES],
+			sizeof(*statuses), GFP_KERNEL);
+	if (!statuses)
+		goto out;
+
+	fences = kcalloc(sds->props[SP_ENGINE_NUM_OF_FENCES] *
+				sds->props[SP_ENGINE_NUM_OF_QUEUES],
+			 sizeof(*fences), GFP_KERNEL);
+	if (!fences)
+		goto free_status;
+
+	for (i = 0; i < sds->props[SP_ENGINE_NUM_OF_FENCES]; ++i)
+		statuses[i] = RREG32(status_base_offset + i * sizeof(u32));
+
+	for (i = 0; i < sds->props[SP_ENGINE_NUM_OF_FENCES] *
+				sds->props[SP_ENGINE_NUM_OF_QUEUES]; ++i)
+		fences[i] = RREG32(base_offset + i * sizeof(u32));
+
+	/* The actual print */
+	for (i = 0; i < sds->props[SP_ENGINE_NUM_OF_QUEUES]; ++i) {
+		u32 fence_id;
+		u64 fence_cnt, fence_rdata;
+		const char *engine_name;
+
+		if (!FIELD_GET(TPC0_QM_CP_STS_0_FENCE_IN_PROGRESS_MASK,
+			statuses[i]))
+			continue;
+
+		fence_id =
+			FIELD_GET(TPC0_QM_CP_STS_0_FENCE_ID_MASK, statuses[i]);
+		fence_cnt = base_offset + CFG_BASE +
+			sizeof(u32) *
+			(i + fence_id * sds->props[SP_ENGINE_NUM_OF_QUEUES]);
+		fence_rdata = fence_cnt - sds->props[SP_FENCE0_CNT_OFFSET] +
+				sds->props[SP_FENCE0_RDATA_OFFSET];
+		engine_name = hl_sync_engine_to_string(engine_type);
+
+		rc = hl_snprintf_resize(
+			buf, size, offset,
+			"%s%u, stream %u: fence id %u cnt = 0x%llx (%s%u_QM.CP_FENCE%u_CNT_%u) rdata = 0x%llx (%s%u_QM.CP_FENCE%u_RDATA_%u) value = %u, cp_status = %u\n",
+			engine_name, engine_id,
+			i, fence_id,
+			fence_cnt, engine_name, engine_id, fence_id, i,
+			fence_rdata, engine_name, engine_id, fence_id, i,
+			fences[fence_id],
+			statuses[i]);
+		if (rc)
+			goto free_fences;
+	}
+
+	rc = 0;
+
+free_fences:
+	kfree(fences);
+free_status:
+	kfree(statuses);
+out:
+	return rc;
 }
 
 
@@ -9020,9 +9281,24 @@ static struct hl_state_dump_specs_funcs gaudi_state_dump_funcs = {
 
 static void gaudi_state_dump_init(struct hl_device *hdev)
 {
-	/* Not implemented */
-	hdev->state_dump_specs.props = gaudi_state_dump_specs_props;
-	hdev->state_dump_specs.funcs = gaudi_state_dump_funcs;
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gaudi_so_id_to_str); ++i)
+		hash_add(sds->so_id_to_str_tb,
+			&gaudi_so_id_to_str[i].node,
+			gaudi_so_id_to_str[i].id);
+
+	for (i = 0; i < ARRAY_SIZE(gaudi_monitor_id_to_str); ++i)
+		hash_add(sds->monitor_id_to_str_tb,
+			&gaudi_monitor_id_to_str[i].node,
+			gaudi_monitor_id_to_str[i].id);
+
+	sds->props = gaudi_state_dump_specs_props;
+
+	sds->sync_namager_names = gaudi_sync_manager_names;
+
+	sds->funcs = gaudi_state_dump_funcs;
 }
 
 static const struct hl_asic_funcs gaudi_funcs = {
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 957bf3720f70..838e98b0d43d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -200,6 +200,18 @@
 #define HW_CAP_TPC_MASK		GENMASK(31, 24)
 #define HW_CAP_TPC_SHIFT	24
 
+#define NEXT_SYNC_OBJ_ADDR_INTERVAL \
+	(mmSYNC_MNGR_W_N_SYNC_MNGR_OBJS_SOB_OBJ_0 - \
+	 mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_0)
+#define NUM_OF_MME_ENGINES			2
+#define NUM_OF_MME_SUB_ENGINES		2
+#define NUM_OF_TPC_ENGINES			8
+#define NUM_OF_DMA_ENGINES			8
+#define NUM_OF_QUEUES				5
+#define NUM_OF_STREAMS				4
+#define NUM_OF_FENCES				4
+
+
 #define GAUDI_CPU_PCI_MSB_ADDR(addr)	(((addr) & GENMASK_ULL(49, 39)) >> 39)
 #define GAUDI_PCI_TO_CPU_ADDR(addr)			\
 	do {						\
diff --git a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
index 5bb54b34a8ae..ffdfbd9b3220 100644
--- a/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
+++ b/drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
@@ -126,6 +126,9 @@
 #define mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_1                     0x4F2004
 #define mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_SOB_OBJ_2047                  0x4F3FFC
 #define mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRL_0               0x4F4000
+#define mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_ADDRH_0               0x4F4800
+#define mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_PAY_DATA_0                0x4F5000
+#define mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_ARM_0                     0x4F5800
 #define mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_STATUS_0                  0x4F6000
 #define mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_STATUS_511                0x4F67FC
 
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
index 9aea7e996654..acc85d3ed98b 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
@@ -449,4 +449,21 @@ enum axi_id {
 #define PCIE_AUX_FLR_CTRL_HW_CTRL_MASK                               0x1
 #define PCIE_AUX_FLR_CTRL_INT_MASK_MASK                              0x2
 
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_STATUS_0_VALID_SHIFT        0
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_STATUS_0_VALID_MASK         0x1
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_STATUS_0_PENDING_SHIFT      1
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_STATUS_0_PENDING_MASK       0x1FE
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_SID_SHIFT             0
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_SID_MASK              0xFF
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_MASK_SHIFT            8
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_MASK_MASK             0xFF00
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_SOP_SHIFT             16
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_SOP_MASK              0x10000
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_SOD_SHIFT             17
+#define SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_SOD_MASK              0xFFFE0000
+#define TPC0_QM_CP_STS_0_FENCE_ID_SHIFT                              20
+#define TPC0_QM_CP_STS_0_FENCE_ID_MASK                               0x300000
+#define TPC0_QM_CP_STS_0_FENCE_IN_PROGRESS_SHIFT                     22
+#define TPC0_QM_CP_STS_0_FENCE_IN_PROGRESS_MASK                      0x400000
+
 #endif /* GAUDI_MASKS_H_ */
-- 
2.25.1

