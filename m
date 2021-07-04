Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933D13BACF1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhGDLxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 07:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhGDLxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 07:53:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 549D16135B;
        Sun,  4 Jul 2021 11:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625399470;
        bh=6eobSzMwy9/cgOupP9L28p+7B6oX/uMZUchwQPHCDeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=El0ogM8qtWKIZo6zectAWa0F2SqKpyHrxKg3c3yuF60BSZehbn05GV31nGqD1s32Z
         k0BbaPZC8ZQaNz215zRb7udGDKrQZR9EovvofaP8IWFQWY1f/imYBPSpnsF4ig2blb
         PpFHWDHo7Y1Z95Q6h8DFeXrDdffz1QGELdyyV+U894FGqhElZSe5M7AK1y95ThDV+N
         OchjqCoKgZ0/Vg9uVD7r6lAvRsx0RKHkOxScx38o+MNaIDRTPqGsrX1sYC1lzEJSFA
         4xBrIrFy/hJ7u0ROzNuRerinCepVnIKMV/MkSn8/LCf7ojnkVK9bCJ/EGp16edMz5M
         tFND9Sv6fbIMw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 3/4] habanalabs: state dump monitors and fences infrastructure
Date:   Sun,  4 Jul 2021 14:51:01 +0300
Message-Id: <20210704115102.9223-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704115102.9223-1-ogabbay@kernel.org>
References: <20210704115102.9223-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

With the infrastructure in place, monitors and fences dump shall be
implemented.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  33 +++
 drivers/misc/habanalabs/common/state_dump.c | 311 ++++++++++++++++++--
 drivers/misc/habanalabs/gaudi/gaudi.c       |  27 ++
 drivers/misc/habanalabs/goya/goya.c         |  27 ++
 4 files changed, 375 insertions(+), 23 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index c1bb175d004b..3657d24ca467 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1880,6 +1880,24 @@ enum hl_sync_engine_type {
 	ENGINE_MME,
 };
 
+/**
+ * struct hl_mon_state_dump - represents a state dump of a single monitor
+ * @id: monitor id
+ * @wr_addr_low: address monitor will write to, low bits
+ * @wr_addr_high: address monitor will write to, high bits
+ * @wr_data: data monitor will write
+ * @arm_data: register value containing monitor configuration
+ * @status: monitor status
+ */
+struct hl_mon_state_dump {
+	u32		id;
+	u32		wr_addr_low;
+	u32		wr_addr_high;
+	u32		wr_data;
+	u32		arm_data;
+	u32		status;
+};
+
 /**
  * struct hl_sync_to_engine_map_entry - sync object id to engine mapping entry
  * @engine_type: type of the engine
@@ -1905,10 +1923,23 @@ struct hl_sync_to_engine_map {
 /**
  * struct hl_state_dump_specs_funcs - virtual functions used by the state dump
  * @gen_sync_to_engine_map: generate a hash map from sync obj id to its engine
+ * @print_single_monitor: format monitor data as string
+ * @monitor_valid: return true if given monitor dump is valid
+ * @print_fences_single_engine: format fences data as string
  */
 struct hl_state_dump_specs_funcs {
 	int (*gen_sync_to_engine_map)(struct hl_device *hdev,
 				struct hl_sync_to_engine_map *map);
+	int (*print_single_monitor)(char **buf, size_t *size, size_t *offset,
+				    struct hl_device *hdev,
+				    struct hl_mon_state_dump *mon);
+	int (*monitor_valid)(struct hl_mon_state_dump *mon);
+	int (*print_fences_single_engine)(struct hl_device *hdev,
+					u64 base_offset,
+					u64 status_base_offset,
+					enum hl_sync_engine_type engine_type,
+					u32 engine_id, char **buf,
+					size_t *size, size_t *offset);
 };
 
 /**
@@ -2795,6 +2826,8 @@ int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 
 int hl_state_dump(struct hl_device *hdev);
 const char *hl_state_dump_get_sync_name(struct hl_device *hdev, u32 sync_id);
+const char *hl_state_dump_get_monitor_name(struct hl_device *hdev,
+					struct hl_mon_state_dump *mon);
 void hl_state_dump_free_sync_to_engine_map(struct hl_sync_to_engine_map *map);
 __printf(4, 5) int hl_snprintf_resize(char **buf, size_t *size, size_t *offset,
 					const char *format, ...);
diff --git a/drivers/misc/habanalabs/common/state_dump.c b/drivers/misc/habanalabs/common/state_dump.c
index 6a142a6acdfa..34ffab4f9cbc 100644
--- a/drivers/misc/habanalabs/common/state_dump.c
+++ b/drivers/misc/habanalabs/common/state_dump.c
@@ -5,6 +5,7 @@
  * All Rights Reserved.
  */
 
+#include <linux/vmalloc.h>
 #include <uapi/misc/habanalabs.h>
 #include "habanalabs.h"
 
@@ -72,8 +73,7 @@ static int resize_to_fit(char **buf, size_t *size, size_t desired_size)
 		return 0;
 
 	/* Not enough space to print all, have to resize */
-	new_size =
-		max(PAGE_SIZE, round_up(desired_size, PAGE_SIZE));
+	new_size = max(PAGE_SIZE, round_up(desired_size, PAGE_SIZE));
 	resized_buf = vmalloc(new_size);
 	if (!resized_buf)
 		return -ENOMEM;
@@ -192,6 +192,30 @@ const char *hl_state_dump_get_sync_name(struct hl_device *hdev, u32 sync_id)
 	return NULL;
 }
 
+/**
+ * hl_state_dump_get_monitor_name - transform monitor object dump to monitor
+ * name if available
+ * @hdev: pointer to the device
+ * @mon: monitor state dump
+ *
+ * Returns a name literal or NULL if not resolved.
+ * Note: returning NULL shall not be considered as a failure, as not all
+ * monitors are named.
+ */
+const char *hl_state_dump_get_monitor_name(struct hl_device *hdev,
+					struct hl_mon_state_dump *mon)
+{
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	struct hl_hw_obj_name_entry *entry;
+
+	hash_for_each_possible(sds->monitor_id_to_str_tb,
+				entry, node, mon->id)
+		if (mon->id == entry->id)
+			return entry->name;
+
+	return NULL;
+}
+
 /**
  * hl_state_dump_free_sync_to_engine_map - free sync object to engine map
  * @map: sync object to engine map
@@ -245,23 +269,15 @@ static u32 *hl_state_dump_read_sync_objects(struct hl_device *hdev, u32 index)
 	s64 base_addr; /* Base addr can be negative */
 	int i;
 
-	base_addr =
-		sds->props[SP_SYNC_OBJ_BASE_ADDR] +
-		sds->props[SP_NEXT_SYNC_OBJ_ADDR] *
-		index;
+	base_addr = sds->props[SP_SYNC_OBJ_BASE_ADDR] +
+			sds->props[SP_NEXT_SYNC_OBJ_ADDR] * index;
 
-	sync_objects = vmalloc(
-		sds->props[SP_SYNC_OBJ_AMOUNT] *
-		sizeof(u32));
+	sync_objects = vmalloc(sds->props[SP_SYNC_OBJ_AMOUNT] * sizeof(u32));
 	if (!sync_objects)
 		return NULL;
 
-	for (i = 0;
-		i < sds->props[SP_SYNC_OBJ_AMOUNT];
-		++i) {
-		sync_objects[i] =
-		RREG32(base_addr + i * sizeof(u32));
-	}
+	for (i = 0; i < sds->props[SP_SYNC_OBJ_AMOUNT]; ++i)
+		sync_objects[i] = RREG32(base_addr + i * sizeof(u32));
 
 	return sync_objects;
 }
@@ -313,19 +329,16 @@ hl_state_dump_print_syncs_single_block(struct hl_device *hdev, u32 index,
 		goto out;
 	}
 
-	for (i = 0;
-		i < sds->props[SP_SYNC_OBJ_AMOUNT];
-		++i) {
+	for (i = 0; i < sds->props[SP_SYNC_OBJ_AMOUNT]; ++i) {
 		struct hl_sync_to_engine_map_entry *entry;
 		u64 sync_object_addr;
 
 		if (!sync_objects[i])
 			continue;
 
-		sync_object_addr =
-			sds->props[SP_SYNC_OBJ_BASE_ADDR] +
-			sds->props[SP_NEXT_SYNC_OBJ_ADDR] *
-			index + i * sizeof(u32);
+		sync_object_addr = sds->props[SP_SYNC_OBJ_BASE_ADDR] +
+				sds->props[SP_NEXT_SYNC_OBJ_ADDR] * index +
+				i * sizeof(u32);
 
 		rc = hl_snprintf_resize(buf, size, offset, "sync id: %u", i);
 		if (rc)
@@ -346,7 +359,8 @@ hl_state_dump_print_syncs_single_block(struct hl_device *hdev, u32 index,
 		entry = hl_state_dump_get_sync_to_engine(map,
 			(u32)sync_object_addr);
 		if (entry) {
-			rc = hl_snprintf_resize(buf, size, offset, ", Engine: ");
+			rc = hl_snprintf_resize(buf, size, offset,
+						", Engine: ");
 			if (rc)
 				goto free_sync_objects;
 			rc = hl_print_resize_sync_engine(buf, size, offset,
@@ -422,6 +436,245 @@ static int hl_state_dump_print_syncs(struct hl_device *hdev,
 	return rc;
 }
 
+/**
+ * hl_state_dump_alloc_read_sm_block_monitors - read monitors for a specific
+ * block
+ * @hdev: pointer to the device
+ * @index: sync manager block index starting with E_N
+ *
+ * Returns an array of monitor data of size SP_MONITORS_AMOUNT or NULL
+ * on error
+ */
+static struct hl_mon_state_dump *
+hl_state_dump_alloc_read_sm_block_monitors(struct hl_device *hdev, u32 index)
+{
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	struct hl_mon_state_dump *monitors;
+	s64 base_addr; /* Base addr can be negative */
+	int i;
+
+	monitors = vmalloc(sds->props[SP_MONITORS_AMOUNT] *
+			   sizeof(struct hl_mon_state_dump));
+	if (!monitors)
+		return NULL;
+
+	base_addr = sds->props[SP_NEXT_SYNC_OBJ_ADDR] * index;
+
+	for (i = 0; i < sds->props[SP_MONITORS_AMOUNT]; ++i) {
+		monitors[i].id = i;
+		monitors[i].wr_addr_low =
+			RREG32(base_addr + sds->props[SP_MON_OBJ_WR_ADDR_LOW] +
+				i * sizeof(u32));
+
+		monitors[i].wr_addr_high =
+			RREG32(base_addr + sds->props[SP_MON_OBJ_WR_ADDR_HIGH] +
+				i * sizeof(u32));
+
+		monitors[i].wr_data =
+			RREG32(base_addr + sds->props[SP_MON_OBJ_WR_DATA] +
+				i * sizeof(u32));
+
+		monitors[i].arm_data =
+			RREG32(base_addr + sds->props[SP_MON_OBJ_ARM_DATA] +
+				i * sizeof(u32));
+
+		monitors[i].status =
+			RREG32(base_addr + sds->props[SP_MON_OBJ_STATUS] +
+				i * sizeof(u32));
+	}
+
+	return monitors;
+}
+
+/**
+ * hl_state_dump_print_monitors_single_block - print active monitors
+ * @monitors: monitors array created with
+ *            hl_state_dump_alloc_read_sm_block_monitors
+ */
+static void hl_state_dump_free_monitors(struct hl_mon_state_dump *monitors)
+{
+	vfree(monitors);
+}
+
+/**
+ * hl_state_dump_print_monitors_single_block - print active monitors on a
+ * single block
+ * @hdev: pointer to the device
+ * @index: sync manager block index starting with E_N
+ * @buf: destination buffer double pointer to be used with hl_snprintf_resize
+ * @size: pointer to the size container
+ * @offset: pointer to the offset container
+ *
+ * Returns 0 on success or error code on failure
+ */
+static int hl_state_dump_print_monitors_single_block(struct hl_device *hdev,
+						u32 index,
+						char **buf, size_t *size,
+						size_t *offset)
+{
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	struct hl_mon_state_dump *monitors = NULL;
+	int rc = 0, i;
+
+	if (sds->sync_namager_names) {
+		rc = hl_snprintf_resize(
+			buf, size, offset, "%s\n",
+			sds->sync_namager_names[index]);
+		if (rc)
+			goto out;
+	}
+
+	monitors = hl_state_dump_alloc_read_sm_block_monitors(hdev, index);
+	if (!monitors) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < sds->props[SP_MONITORS_AMOUNT]; ++i) {
+		if (!(sds->funcs.monitor_valid(&monitors[i])))
+			continue;
+
+		/* Monitor is valid, dump it */
+		rc = sds->funcs.print_single_monitor(buf, size, offset, hdev,
+							&monitors[i]);
+		if (rc)
+			goto free_monitors;
+
+		hl_snprintf_resize(buf, size, offset, "\n");
+	}
+
+free_monitors:
+	hl_state_dump_free_monitors(monitors);
+out:
+	return rc;
+}
+
+/**
+ * hl_state_dump_print_monitors - print active monitors
+ * @hdev: pointer to the device
+ * @buf: destination buffer double pointer to be used with hl_snprintf_resize
+ * @size: pointer to the size container
+ * @offset: pointer to the offset container
+ *
+ * Returns 0 on success or error code on failure
+ */
+static int hl_state_dump_print_monitors(struct hl_device *hdev,
+					char **buf, size_t *size,
+					size_t *offset)
+{
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	u32 index;
+	int rc = 0;
+
+	rc = hl_snprintf_resize(buf, size, offset,
+		"Valid (armed) monitor objects:\n");
+	if (rc)
+		goto out;
+
+	if (sds->sync_namager_names) {
+		for (index = 0; sds->sync_namager_names[index]; ++index) {
+			rc = hl_state_dump_print_monitors_single_block(
+				hdev, index, buf, size, offset);
+			if (rc)
+				goto out;
+		}
+	} else {
+		for (index = 0; index < sds->props[SP_NUM_CORES]; ++index) {
+			rc = hl_state_dump_print_monitors_single_block(
+				hdev, index, buf, size, offset);
+			if (rc)
+				goto out;
+		}
+	}
+
+out:
+	return rc;
+}
+
+/**
+ * hl_state_dump_print_engine_fences - print active fences for a specific
+ * engine
+ * @hdev: pointer to the device
+ * @engine_type: engine type to use
+ * @buf: destination buffer double pointer to be used with hl_snprintf_resize
+ * @size: pointer to the size container
+ * @offset: pointer to the offset container
+ */
+static int
+hl_state_dump_print_engine_fences(struct hl_device *hdev,
+				  enum hl_sync_engine_type engine_type,
+				  char **buf, size_t *size, size_t *offset)
+{
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	int rc = 0, i, n_fences;
+	u64 base_addr, next_fence;
+
+	switch (engine_type) {
+	case ENGINE_TPC:
+		n_fences = sds->props[SP_NUM_OF_TPC_ENGINES];
+		base_addr = sds->props[SP_TPC0_CMDQ];
+		next_fence = sds->props[SP_NEXT_TPC];
+		break;
+	case ENGINE_MME:
+		n_fences = sds->props[SP_NUM_OF_MME_ENGINES];
+		base_addr = sds->props[SP_MME_CMDQ];
+		next_fence = sds->props[SP_NEXT_MME];
+		break;
+	case ENGINE_DMA:
+		n_fences = sds->props[SP_NUM_OF_DMA_ENGINES];
+		base_addr = sds->props[SP_DMA_CMDQ];
+		next_fence = sds->props[SP_DMA_QUEUES_OFFSET];
+		break;
+	default:
+		return -EINVAL;
+	}
+	for (i = 0; i < n_fences; ++i) {
+		rc = sds->funcs.print_fences_single_engine(
+			hdev,
+			base_addr + next_fence * i +
+				sds->props[SP_FENCE0_CNT_OFFSET],
+			base_addr + next_fence * i +
+				sds->props[SP_CP_STS_OFFSET],
+			engine_type, i, buf, size, offset);
+		if (rc)
+			goto out;
+	}
+out:
+	return rc;
+}
+
+/**
+ * hl_state_dump_print_fences - print active fences
+ * @hdev: pointer to the device
+ * @buf: destination buffer double pointer to be used with hl_snprintf_resize
+ * @size: pointer to the size container
+ * @offset: pointer to the offset container
+ */
+static int hl_state_dump_print_fences(struct hl_device *hdev, char **buf,
+				      size_t *size, size_t *offset)
+{
+	int rc = 0;
+
+	rc = hl_snprintf_resize(buf, size, offset, "Valid (armed) fences:\n");
+	if (rc)
+		goto out;
+
+	rc = hl_state_dump_print_engine_fences(hdev, ENGINE_TPC, buf, size, offset);
+	if (rc)
+		goto out;
+
+	rc = hl_state_dump_print_engine_fences(hdev, ENGINE_MME, buf, size, offset);
+	if (rc)
+		goto out;
+
+	rc = hl_state_dump_print_engine_fences(hdev, ENGINE_DMA, buf, size, offset);
+	if (rc)
+		goto out;
+
+out:
+	return rc;
+}
+
 /**
  * hl_state_dump() - dump system state
  * @hdev: pointer to device structure
@@ -442,6 +695,18 @@ int hl_state_dump(struct hl_device *hdev)
 
 	hl_snprintf_resize(&buf, &size, &offset, "\n");
 
+	rc = hl_state_dump_print_monitors(hdev, &buf, &size, &offset);
+	if (rc)
+		goto err;
+
+	hl_snprintf_resize(&buf, &size, &offset, "\n");
+
+	rc = hl_state_dump_print_fences(hdev, &buf, &size, &offset);
+	if (rc)
+		goto err;
+
+	hl_snprintf_resize(&buf, &size, &offset, "\n");
+
 	hl_debugfs_set_state_dump(hdev, buf, size);
 
 	return 0;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 7f90f637d7f4..29ada339b66a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8986,9 +8986,36 @@ static int gaudi_gen_sync_to_engine_map(struct hl_device *hdev,
 	return 0;
 }
 
+static int gaudi_monitor_valid(struct hl_mon_state_dump *mon)
+{
+	/* Not implemented */
+	return 0;
+}
+
+static int gaudi_print_single_monitor(char **buf, size_t *size, size_t *offset,
+				struct hl_device *hdev,
+				struct hl_mon_state_dump *mon)
+{
+	/* Not implemented */
+	return 0;
+}
+
+
+static int gaudi_print_fences_single_engine(
+	struct hl_device *hdev, u64 base_offset, u64 status_base_offset,
+	enum hl_sync_engine_type engine_type, u32 engine_id, char **buf,
+	size_t *size, size_t *offset)
+{
+	/* Not implemented */
+	return 0;
+}
+
 
 static struct hl_state_dump_specs_funcs gaudi_state_dump_funcs = {
+	.monitor_valid = gaudi_monitor_valid,
+	.print_single_monitor = gaudi_print_single_monitor,
 	.gen_sync_to_engine_map = gaudi_gen_sync_to_engine_map,
+	.print_fences_single_engine = gaudi_print_fences_single_engine,
 };
 
 static void gaudi_state_dump_init(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 2c3d642d31ab..4144a8445eef 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5533,9 +5533,36 @@ static int goya_gen_sync_to_engine_map(struct hl_device *hdev,
 	return 0;
 }
 
+static int goya_monitor_valid(struct hl_mon_state_dump *mon)
+{
+	/* Not implemented */
+	return 0;
+}
+
+static int goya_print_single_monitor(char **buf, size_t *size, size_t *offset,
+				struct hl_device *hdev,
+				struct hl_mon_state_dump *mon)
+{
+	/* Not implemented */
+	return 0;
+}
+
+
+static int goya_print_fences_single_engine(
+	struct hl_device *hdev, u64 base_offset, u64 status_base_offset,
+	enum hl_sync_engine_type engine_type, u32 engine_id, char **buf,
+	size_t *size, size_t *offset)
+{
+	/* Not implemented */
+	return 0;
+}
+
 
 static struct hl_state_dump_specs_funcs goya_state_dump_funcs = {
+	.monitor_valid = goya_monitor_valid,
+	.print_single_monitor = goya_print_single_monitor,
 	.gen_sync_to_engine_map = goya_gen_sync_to_engine_map,
+	.print_fences_single_engine = goya_print_fences_single_engine,
 };
 
 static void goya_state_dump_init(struct hl_device *hdev)
-- 
2.25.1

