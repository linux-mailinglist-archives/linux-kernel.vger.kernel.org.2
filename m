Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218133BACF0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhGDLxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 07:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229569AbhGDLxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 07:53:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB11B61108;
        Sun,  4 Jul 2021 11:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625399468;
        bh=qHh5AtOHgBlffXz2jpJa3lbu6eXpCEkUHYuAC5rEhJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRrJG920T4H3Q1eyaYvgaxu1nGqZ91vS6rxiQ2ubJfn29krpgLNfMRe0vwSiS9Ejs
         /kW1rO9biYKfev02+vR+6wh7R0YKddzLFj/IKDSKdAxpZ1Vr38uTYZoEO+PcbVuAmu
         Ya5lKQIhtFjRRcbN0tXRxt7w6ku0mpQNuLo/VBJTzJXMkZYgsfMi5Z0Pb1KLC3hwwQ
         GpTyzat6KEf0H5MdD5v2mJ74fSyH1dE1VnXZH74UmQ+D1vZwTj8In9jfgaHR36Kl0q
         c80Kmt+viIXqL8aSacfrGNDi4CHDtJ5delI8KSbm9DIP3g6GbdkjCJVkcFsXkPa96f
         EpetJByQ2Mm8A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 2/4] habanalabs: expose state dump
Date:   Sun,  4 Jul 2021 14:51:00 +0300
Message-Id: <20210704115102.9223-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704115102.9223-1-ogabbay@kernel.org>
References: <20210704115102.9223-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

To improve the user's ability to debug the case where a workload that
is part of executing training/inference of a topology is getting stuck,
we need to add a 'core dump' each time a CS times-out. The 'core dump'
shall contain all relevant Sync Manager information and corresponding
fence values.

The most recent dumps shall be accessible via debugfs, under
'state_dump' node. Reading from the node will provide the oldest dump
available. Writing an integer value X will discard X dumps, starting
with the oldest one, i.e. subsequent read will now return newer
dumps.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs     |  11 +
 drivers/misc/habanalabs/common/Makefile       |   3 +-
 .../habanalabs/common/command_submission.c    |   4 +
 drivers/misc/habanalabs/common/debugfs.c      |  93 ++++
 drivers/misc/habanalabs/common/device.c       |   2 +
 drivers/misc/habanalabs/common/habanalabs.h   | 132 +++++
 drivers/misc/habanalabs/common/state_dump.c   | 451 ++++++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudi.c         |  24 +-
 drivers/misc/habanalabs/goya/goya.c           |  24 +-
 9 files changed, 741 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/state_dump.c

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index e78ceb1f70b3..25f33500bcc9 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -215,6 +215,17 @@ Description:    Sets the skip reset on timeout option for the device. Value of
                 "0" means device will be reset in case some CS has timed out,
                 otherwise it will not be reset.
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/state_dump
+Date:           Oct 2021
+KernelVersion:  5.15
+Contact:        ynudelman@habana.ai
+Description:    Gets the state dump occurring on a CS timeout or failure.
+                State dump is used for debug and is created each time in case of
+                a problem in a CS execution, before reset.
+                Reading from the node returns the newest state dump available.
+                Writing an integer X discards X state dumps, so that the
+                next read would return X+1-st newest state dump.
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/stop_on_err
 Date:           Mar 2020
 KernelVersion:  5.6
diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
index 5d8b48288cf4..6ebe3c7001ff 100644
--- a/drivers/misc/habanalabs/common/Makefile
+++ b/drivers/misc/habanalabs/common/Makefile
@@ -10,4 +10,5 @@ HL_COMMON_FILES := common/habanalabs_drv.o common/device.o common/context.o \
 		common/asid.o common/habanalabs_ioctl.o \
 		common/command_buffer.o common/hw_queue.o common/irq.o \
 		common/sysfs.o common/hwmon.o common/memory.o \
-		common/command_submission.o common/firmware_if.o
+		common/command_submission.o common/firmware_if.o \
+		common/state_dump.o
diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 997a37e78241..a0846880400c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -621,6 +621,10 @@ static void cs_timedout(struct work_struct *work)
 		break;
 	}
 
+	rc = hl_state_dump(hdev);
+	if (rc)
+		dev_err(hdev->dev, "Error during system state dump %d\n", rc);
+
 	cs_put(cs);
 
 	if (likely(!skip_reset_on_timeout)) {
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 77f7c2aa571d..51744e42b808 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -1043,6 +1043,60 @@ static ssize_t hl_security_violations_read(struct file *f, char __user *buf,
 	return 0;
 }
 
+static ssize_t hl_state_dump_read(struct file *f, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	ssize_t rc;
+
+	down_read(&entry->state_dump_sem);
+	if (!entry->state_dump[entry->state_dump_head])
+		rc = 0;
+	else
+		rc = simple_read_from_buffer(
+			buf, count, ppos,
+			entry->state_dump[entry->state_dump_head],
+			strlen(entry->state_dump[entry->state_dump_head]));
+	up_read(&entry->state_dump_sem);
+
+	return rc;
+}
+
+static ssize_t hl_state_dump_write(struct file *f, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	ssize_t rc;
+	u32 size;
+	int i;
+
+	rc = kstrtouint_from_user(buf, count, 10, &size);
+	if (rc)
+		return rc;
+
+	if (size <= 0 || size >= ARRAY_SIZE(entry->state_dump)) {
+		dev_err(hdev->dev, "Invalid number of dumps to skip\n");
+		return -EINVAL;
+	}
+
+	if (entry->state_dump[entry->state_dump_head]) {
+		down_write(&entry->state_dump_sem);
+		for (i = 0; i < size; ++i) {
+			vfree(entry->state_dump[entry->state_dump_head]);
+			entry->state_dump[entry->state_dump_head] = NULL;
+			if (entry->state_dump_head > 0)
+				entry->state_dump_head--;
+			else
+				entry->state_dump_head =
+					ARRAY_SIZE(entry->state_dump) - 1;
+		}
+		up_write(&entry->state_dump_sem);
+	}
+
+	return count;
+}
+
 static const struct file_operations hl_data32b_fops = {
 	.owner = THIS_MODULE,
 	.read = hl_data_read32,
@@ -1110,6 +1164,12 @@ static const struct file_operations hl_security_violations_fops = {
 	.read = hl_security_violations_read
 };
 
+static const struct file_operations hl_state_dump_fops = {
+	.owner = THIS_MODULE,
+	.read = hl_state_dump_read,
+	.write = hl_state_dump_write
+};
+
 static const struct hl_info_list hl_debugfs_list[] = {
 	{"command_buffers", command_buffers_show, NULL},
 	{"command_submission", command_submission_show, NULL},
@@ -1172,6 +1232,7 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 	INIT_LIST_HEAD(&dev_entry->userptr_list);
 	INIT_LIST_HEAD(&dev_entry->ctx_mem_hash_list);
 	mutex_init(&dev_entry->file_mutex);
+	init_rwsem(&dev_entry->state_dump_sem);
 	spin_lock_init(&dev_entry->cb_spinlock);
 	spin_lock_init(&dev_entry->cs_spinlock);
 	spin_lock_init(&dev_entry->cs_job_spinlock);
@@ -1283,6 +1344,12 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 				dev_entry->root,
 				&hdev->skip_reset_on_timeout);
 
+	debugfs_create_file("state_dump",
+				0600,
+				dev_entry->root,
+				dev_entry,
+				&hl_state_dump_fops);
+
 	for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
 		debugfs_create_file(hl_debugfs_list[i].name,
 					0444,
@@ -1297,6 +1364,7 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 void hl_debugfs_remove_device(struct hl_device *hdev)
 {
 	struct hl_dbg_device_entry *entry = &hdev->hl_debugfs;
+	int i;
 
 	debugfs_remove_recursive(entry->root);
 
@@ -1304,6 +1372,9 @@ void hl_debugfs_remove_device(struct hl_device *hdev)
 
 	vfree(entry->blob_desc.data);
 
+	for (i = 0; i < ARRAY_SIZE(entry->state_dump); ++i)
+		vfree(entry->state_dump[i]);
+
 	kfree(entry->entry_arr);
 }
 
@@ -1416,6 +1487,28 @@ void hl_debugfs_remove_ctx_mem_hash(struct hl_device *hdev, struct hl_ctx *ctx)
 	spin_unlock(&dev_entry->ctx_mem_hash_spinlock);
 }
 
+/**
+ * hl_debugfs_set_state_dump - register state dump making it accessible via
+ *                             debugfs
+ * @hdev: pointer to the device structure
+ * @data: the actual dump data
+ * @length: the length of the data
+ */
+void hl_debugfs_set_state_dump(struct hl_device *hdev, char *data,
+					unsigned long length)
+{
+	struct hl_dbg_device_entry *dev_entry = &hdev->hl_debugfs;
+
+	down_write(&dev_entry->state_dump_sem);
+
+	dev_entry->state_dump_head = (dev_entry->state_dump_head + 1) %
+					ARRAY_SIZE(dev_entry->state_dump);
+	vfree(dev_entry->state_dump[dev_entry->state_dump_head]);
+	dev_entry->state_dump[dev_entry->state_dump_head] = data;
+
+	up_write(&dev_entry->state_dump_sem);
+}
+
 void __init hl_debugfs_init(void)
 {
 	hl_debug_root = debugfs_create_dir("habanalabs", NULL);
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 45070e891544..86426052a191 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1375,6 +1375,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 
 	hdev->compute_ctx = NULL;
 
+	hdev->asic_funcs->state_dump_init(hdev);
+
 	hl_debugfs_add_device(hdev);
 
 	/* debugfs nodes are created in hl_ctx_init so it must be called after
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 5ae95d2abaa6..c1bb175d004b 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -20,6 +20,7 @@
 #include <linux/scatterlist.h>
 #include <linux/hashtable.h>
 #include <linux/debugfs.h>
+#include <linux/rwsem.h>
 #include <linux/bitfield.h>
 #include <linux/genalloc.h>
 #include <linux/sched/signal.h>
@@ -65,6 +66,11 @@
 
 #define HL_COMMON_USER_INTERRUPT_ID	0xFFF
 
+#define HL_STATE_DUMP_HIST_LEN		5
+
+#define OBJ_NAMES_HASH_TABLE_BITS	7 /* 1 << 7 buckets */
+#define SYNC_TO_ENGINE_HASH_TABLE_BITS	7 /* 1 << 7 buckets */
+
 /* Memory */
 #define MEM_HASH_TABLE_BITS		7 /* 1 << 7 buckets */
 
@@ -1123,6 +1129,7 @@ struct fw_load_mgr {
  *                         generic f/w compatible PLL Indexes
  * @init_firmware_loader: initialize data for FW loader.
  * @init_cpu_scrambler_dram: Enable CPU specific DRAM scrambling
+ * @state_dump_init: initialize constants required for state dump
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1248,6 +1255,7 @@ struct hl_asic_funcs {
 	int (*map_pll_idx_to_fw_idx)(u32 pll_idx);
 	void (*init_firmware_loader)(struct hl_device *hdev);
 	void (*init_cpu_scrambler_dram)(struct hl_device *hdev);
+	void (*state_dump_init)(struct hl_device *hdev);
 };
 
 
@@ -1781,9 +1789,12 @@ struct hl_debugfs_entry {
  * @ctx_mem_hash_list: list of available contexts with MMU mappings.
  * @ctx_mem_hash_spinlock: protects cb_list.
  * @blob_desc: descriptor of blob
+ * @state_dump: data of the system states in case of a bad cs.
+ * @state_dump_sem: protects state_dump.
  * @addr: next address to read/write from/to in read/write32.
  * @mmu_addr: next virtual address to translate to physical address in mmu_show.
  * @mmu_asid: ASID to use while translating in mmu_show.
+ * @state_dump_head: index of the latest state dump
  * @i2c_bus: generic u8 debugfs file for bus value to use in i2c_data_read.
  * @i2c_addr: generic u8 debugfs file for address value to use in i2c_data_read.
  * @i2c_reg: generic u8 debugfs file for register value to use in i2c_data_read.
@@ -1805,14 +1816,117 @@ struct hl_dbg_device_entry {
 	struct list_head		ctx_mem_hash_list;
 	spinlock_t			ctx_mem_hash_spinlock;
 	struct debugfs_blob_wrapper	blob_desc;
+	char				*state_dump[HL_STATE_DUMP_HIST_LEN];
+	struct rw_semaphore		state_dump_sem;
 	u64				addr;
 	u64				mmu_addr;
 	u32				mmu_asid;
+	u32				state_dump_head;
 	u8				i2c_bus;
 	u8				i2c_addr;
 	u8				i2c_reg;
 };
 
+/**
+ * struct hl_hw_obj_name_entry - single hw object name, member of
+ * hl_state_dump_specs
+ * @node: link to the containing hash table
+ * @name: hw object name
+ * @id: object identifier
+ */
+struct hl_hw_obj_name_entry {
+	struct hlist_node	node;
+	const char		*name;
+	u32			id;
+};
+
+enum hl_state_dump_specs_props {
+	SP_SYNC_OBJ_BASE_ADDR,
+	SP_NEXT_SYNC_OBJ_ADDR,
+	SP_SYNC_OBJ_AMOUNT,
+	SP_MON_OBJ_WR_ADDR_LOW,
+	SP_MON_OBJ_WR_ADDR_HIGH,
+	SP_MON_OBJ_WR_DATA,
+	SP_MON_OBJ_ARM_DATA,
+	SP_MON_OBJ_STATUS,
+	SP_MONITORS_AMOUNT,
+	SP_TPC0_CMDQ,
+	SP_TPC0_CFG_SO,
+	SP_NEXT_TPC,
+	SP_MME_CMDQ,
+	SP_MME_CFG_SO,
+	SP_NEXT_MME,
+	SP_DMA_CMDQ,
+	SP_DMA_CFG_SO,
+	SP_DMA_QUEUES_OFFSET,
+	SP_NUM_OF_MME_ENGINES,
+	SP_SUB_MME_ENG_NUM,
+	SP_NUM_OF_DMA_ENGINES,
+	SP_NUM_OF_TPC_ENGINES,
+	SP_ENGINE_NUM_OF_QUEUES,
+	SP_ENGINE_NUM_OF_STREAMS,
+	SP_ENGINE_NUM_OF_FENCES,
+	SP_FENCE0_CNT_OFFSET,
+	SP_FENCE0_RDATA_OFFSET,
+	SP_CP_STS_OFFSET,
+	SP_NUM_CORES,
+
+	SP_MAX
+};
+
+enum hl_sync_engine_type {
+	ENGINE_TPC,
+	ENGINE_DMA,
+	ENGINE_MME,
+};
+
+/**
+ * struct hl_sync_to_engine_map_entry - sync object id to engine mapping entry
+ * @engine_type: type of the engine
+ * @engine_id: id of the engine
+ * @sync_id: id of the sync object
+ */
+struct hl_sync_to_engine_map_entry {
+	struct hlist_node		node;
+	enum hl_sync_engine_type	engine_type;
+	u32				engine_id;
+	u32				sync_id;
+};
+
+/**
+ * struct hl_sync_to_engine_map - maps sync object id to associated engine id
+ * @tb: hash table containing the mapping, each element is of type
+ *      struct hl_sync_to_engine_map_entry
+ */
+struct hl_sync_to_engine_map {
+	DECLARE_HASHTABLE(tb, SYNC_TO_ENGINE_HASH_TABLE_BITS);
+};
+
+/**
+ * struct hl_state_dump_specs_funcs - virtual functions used by the state dump
+ * @gen_sync_to_engine_map: generate a hash map from sync obj id to its engine
+ */
+struct hl_state_dump_specs_funcs {
+	int (*gen_sync_to_engine_map)(struct hl_device *hdev,
+				struct hl_sync_to_engine_map *map);
+};
+
+/**
+ * struct hl_state_dump_specs - defines ASIC known hw objects names
+ * @so_id_to_str_tb: sync objects names index table
+ * @monitor_id_to_str_tb: monitors names index table
+ * @funcs: virtual functions used for state dump
+ * @sync_namager_names: readable names for sync manager if available (ex: N_E)
+ * @props: pointer to a per asic const props array required for state dump
+ */
+struct hl_state_dump_specs {
+	DECLARE_HASHTABLE(so_id_to_str_tb, OBJ_NAMES_HASH_TABLE_BITS);
+	DECLARE_HASHTABLE(monitor_id_to_str_tb, OBJ_NAMES_HASH_TABLE_BITS);
+	struct hl_state_dump_specs_funcs	funcs;
+	const char * const			*sync_namager_names;
+	s64					*props;
+};
+
 
 /*
  * DEVICES
@@ -2151,6 +2265,7 @@ struct hl_mmu_funcs {
  * @mmu_func: device-related MMU functions.
  * @fw_loader: FW loader manager.
  * @pci_mem_region: array of memory regions in the PCI
+ * @state_dump_specs: constants and dictionaries needed to dump system state.
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -2295,6 +2410,8 @@ struct hl_device {
 
 	struct pci_mem_region		pci_mem_region[PCI_REGION_NUMBER];
 
+	struct hl_state_dump_specs	state_dump_specs;
+
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
 	u64				max_power;
@@ -2676,6 +2793,14 @@ void hl_release_pending_user_interrupts(struct hl_device *hdev);
 int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 			struct hl_hw_sob **hw_sob, u32 count);
 
+int hl_state_dump(struct hl_device *hdev);
+const char *hl_state_dump_get_sync_name(struct hl_device *hdev, u32 sync_id);
+void hl_state_dump_free_sync_to_engine_map(struct hl_sync_to_engine_map *map);
+__printf(4, 5) int hl_snprintf_resize(char **buf, size_t *size, size_t *offset,
+					const char *format, ...);
+char *hl_format_as_binary(char *buf, size_t buf_len, u32 n);
+const char *hl_sync_engine_to_string(enum hl_sync_engine_type engine_type);
+
 #ifdef CONFIG_DEBUG_FS
 
 void hl_debugfs_init(void);
@@ -2695,6 +2820,8 @@ void hl_debugfs_remove_userptr(struct hl_device *hdev,
 				struct hl_userptr *userptr);
 void hl_debugfs_add_ctx_mem_hash(struct hl_device *hdev, struct hl_ctx *ctx);
 void hl_debugfs_remove_ctx_mem_hash(struct hl_device *hdev, struct hl_ctx *ctx);
+void hl_debugfs_set_state_dump(struct hl_device *hdev, char *data,
+					unsigned long length);
 
 #else
 
@@ -2768,6 +2895,11 @@ static inline void hl_debugfs_remove_ctx_mem_hash(struct hl_device *hdev,
 {
 }
 
+void hl_debugfs_set_state_dump(struct hl_device *hdev, char *data,
+					unsigned long length)
+{
+}
+
 #endif
 
 /* IOCTLs */
diff --git a/drivers/misc/habanalabs/common/state_dump.c b/drivers/misc/habanalabs/common/state_dump.c
new file mode 100644
index 000000000000..6a142a6acdfa
--- /dev/null
+++ b/drivers/misc/habanalabs/common/state_dump.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2021 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include <uapi/misc/habanalabs.h>
+#include "habanalabs.h"
+
+/**
+ * A helper function, format an integer as binary using supplied scratch buffer,
+ * return the pointer to the buffer.
+ * @buf: the buffer to use
+ * @buf_len: buffer capacity
+ * @n: number to format
+ *
+ * Returns pointer to buf
+ */
+char *hl_format_as_binary(char *buf, size_t buf_len, u32 n)
+{
+	int i;
+	u32 bit;
+	bool leading0 = true;
+	char *wrptr = buf;
+
+	if (buf_len > 0 && buf_len < 3) {
+		*wrptr = '\0';
+		return buf;
+	}
+
+	wrptr[0] = '0';
+	wrptr[1] = 'b';
+	wrptr += 2;
+	/* Remove 3 characters from length for '0b' and '\0' termination */
+	buf_len -= 3;
+
+	for (i = 0; i < sizeof(n) * BITS_PER_BYTE && buf_len; ++i, n <<= 1) {
+		/* Writing bit calculation in one line would cause a false
+		 * positive static code analysis error, so splitting.
+		 */
+		bit = n & (1 << (sizeof(n) * BITS_PER_BYTE - 1));
+		bit = !!bit;
+		leading0 &= !bit;
+		if (!leading0) {
+			*wrptr = '0' + bit;
+			++wrptr;
+		}
+	}
+
+	*wrptr = '\0';
+
+	return buf;
+}
+
+/**
+ * resize_to_fit - helper function, resize buffer to fit given amount of data
+ * @buf: destination buffer double pointer
+ * @size: pointer to the size container
+ * @desired_size: size the buffer must contain
+ *
+ * Returns 0 on success or error code on failure.
+ * On success, the size of buffer is at least desired_size. Buffer is allocated
+ * via vmalloc and must be freed with vfree.
+ */
+static int resize_to_fit(char **buf, size_t *size, size_t desired_size)
+{
+	char *resized_buf;
+	size_t new_size;
+
+	if (*size >= desired_size)
+		return 0;
+
+	/* Not enough space to print all, have to resize */
+	new_size =
+		max(PAGE_SIZE, round_up(desired_size, PAGE_SIZE));
+	resized_buf = vmalloc(new_size);
+	if (!resized_buf)
+		return -ENOMEM;
+	memcpy(resized_buf, *buf, *size);
+	vfree(*buf);
+	*buf = resized_buf;
+	*size = new_size;
+
+	return 1;
+}
+
+/**
+ * hl_snprintf_resize() - print formatted data to buffer, resize as needed
+ * @buf: buffer double pointer, to be written to and resized, must be either
+ *       NULL or allocated with vmalloc.
+ * @size: current size of the buffer
+ * @offset: current offset to write to
+ * @format: format of the data
+ *
+ * This function will write formatted data into the buffer. If buffer is not
+ * large enough, it will be resized using vmalloc. Size may be modified if the
+ * buffer was resized, offset will be advanced by the number of bytes written
+ * not including the terminating character
+ *
+ * Returns 0 on success or error code on failure
+ *
+ * Note that the buffer has to be manually released using vfree.
+ */
+int hl_snprintf_resize(char **buf, size_t *size, size_t *offset,
+			   const char *format, ...)
+{
+	va_list args;
+	size_t length;
+	int rc;
+
+	if (*buf == NULL && (*size != 0 || *offset != 0))
+		return -EINVAL;
+
+	va_start(args, format);
+	length = vsnprintf(*buf + *offset, *size - *offset, format, args);
+	va_end(args);
+
+	rc = resize_to_fit(buf, size, *offset + length + 1);
+	if (rc < 0)
+		return rc;
+	else if (rc > 0) {
+		/* Resize was needed, write again */
+		va_start(args, format);
+		length = vsnprintf(*buf + *offset, *size - *offset, format,
+				   args);
+		va_end(args);
+	}
+
+	*offset += length;
+
+	return 0;
+}
+
+/**
+ * hl_sync_engine_to_string - convert engine type enum to string literal
+ * @engine_type: engine type (TPC/MME/DMA)
+ *
+ * Return the resolved string literal
+ */
+const char *hl_sync_engine_to_string(enum hl_sync_engine_type engine_type)
+{
+	switch (engine_type) {
+	case ENGINE_DMA:
+		return "DMA";
+	case ENGINE_MME:
+		return "MME";
+	case ENGINE_TPC:
+		return "TPC";
+	}
+	return "Invalid Engine Type";
+}
+
+/**
+ * hl_print_resize_sync_engine - helper function, format engine name and ID
+ * using hl_snprintf_resize
+ * @buf: destination buffer double pointer to be used with hl_snprintf_resize
+ * @size: pointer to the size container
+ * @offset: pointer to the offset container
+ * @engine_type: engine type (TPC/MME/DMA)
+ * @engine_id: engine numerical id
+ *
+ * Returns 0 on success or error code on failure
+ */
+static int hl_print_resize_sync_engine(char **buf, size_t *size, size_t *offset,
+				enum hl_sync_engine_type engine_type,
+				u32 engine_id)
+{
+	return hl_snprintf_resize(buf, size, offset, "%s%u",
+			hl_sync_engine_to_string(engine_type), engine_id);
+}
+
+/**
+ * hl_state_dump_get_sync_name - transform sync object id to name if available
+ * @hdev: pointer to the device
+ * @sync_id: sync object id
+ *
+ * Returns a name literal or NULL if not resolved.
+ * Note: returning NULL shall not be considered as a failure, as not all
+ * sync objects are named.
+ */
+const char *hl_state_dump_get_sync_name(struct hl_device *hdev, u32 sync_id)
+{
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	struct hl_hw_obj_name_entry *entry;
+
+	hash_for_each_possible(sds->so_id_to_str_tb, entry,
+				node, sync_id)
+		if (sync_id == entry->id)
+			return entry->name;
+
+	return NULL;
+}
+
+/**
+ * hl_state_dump_free_sync_to_engine_map - free sync object to engine map
+ * @map: sync object to engine map
+ *
+ * Note: generic free implementation, the allocation is implemented per ASIC.
+ */
+void hl_state_dump_free_sync_to_engine_map(struct hl_sync_to_engine_map *map)
+{
+	struct hl_sync_to_engine_map_entry *entry;
+	struct hlist_node *tmp_node;
+	int i;
+
+	hash_for_each_safe(map->tb, i, tmp_node, entry, node) {
+		hash_del(&entry->node);
+		kfree(entry);
+	}
+}
+
+/**
+ * hl_state_dump_get_sync_to_engine - transform sync_id to
+ * hl_sync_to_engine_map_entry if available for current id
+ * @map: sync object to engine map
+ * @sync_id: sync object id
+ *
+ * Returns the translation entry if found or NULL if not.
+ * Note, returned NULL shall not be considered as a failure as the map
+ * does not cover all possible, it is a best effort sync ids.
+ */
+static struct hl_sync_to_engine_map_entry *
+hl_state_dump_get_sync_to_engine(struct hl_sync_to_engine_map *map, u32 sync_id)
+{
+	struct hl_sync_to_engine_map_entry *entry;
+
+	hash_for_each_possible(map->tb, entry, node, sync_id)
+		if (entry->sync_id == sync_id)
+			return entry;
+	return NULL;
+}
+
+/**
+ * hl_state_dump_read_sync_objects - read sync objects array
+ * @hdev: pointer to the device
+ * @index: sync manager block index starting with E_N
+ *
+ * Returns array of size SP_SYNC_OBJ_AMOUNT on success or NULL on failure
+ */
+static u32 *hl_state_dump_read_sync_objects(struct hl_device *hdev, u32 index)
+{
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	u32 *sync_objects;
+	s64 base_addr; /* Base addr can be negative */
+	int i;
+
+	base_addr =
+		sds->props[SP_SYNC_OBJ_BASE_ADDR] +
+		sds->props[SP_NEXT_SYNC_OBJ_ADDR] *
+		index;
+
+	sync_objects = vmalloc(
+		sds->props[SP_SYNC_OBJ_AMOUNT] *
+		sizeof(u32));
+	if (!sync_objects)
+		return NULL;
+
+	for (i = 0;
+		i < sds->props[SP_SYNC_OBJ_AMOUNT];
+		++i) {
+		sync_objects[i] =
+		RREG32(base_addr + i * sizeof(u32));
+	}
+
+	return sync_objects;
+}
+
+/**
+ * hl_state_dump_free_sync_objects - free sync objects array allocated by
+ * hl_state_dump_read_sync_objects
+ * @sync_objects: sync objects array
+ */
+static void hl_state_dump_free_sync_objects(u32 *sync_objects)
+{
+	vfree(sync_objects);
+}
+
+
+/**
+ * hl_state_dump_print_syncs_single_block - print active sync objects on a
+ * single block
+ * @hdev: pointer to the device
+ * @index: sync manager block index starting with E_N
+ * @buf: destination buffer double pointer to be used with hl_snprintf_resize
+ * @size: pointer to the size container
+ * @offset: pointer to the offset container
+ * @map: sync engines names map
+ *
+ * Returns 0 on success or error code on failure
+ */
+static int
+hl_state_dump_print_syncs_single_block(struct hl_device *hdev, u32 index,
+				char **buf, size_t *size, size_t *offset,
+				struct hl_sync_to_engine_map *map)
+{
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	const char *sync_name;
+	u32 *sync_objects = NULL;
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
+	sync_objects = hl_state_dump_read_sync_objects(hdev, index);
+	if (!sync_objects) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0;
+		i < sds->props[SP_SYNC_OBJ_AMOUNT];
+		++i) {
+		struct hl_sync_to_engine_map_entry *entry;
+		u64 sync_object_addr;
+
+		if (!sync_objects[i])
+			continue;
+
+		sync_object_addr =
+			sds->props[SP_SYNC_OBJ_BASE_ADDR] +
+			sds->props[SP_NEXT_SYNC_OBJ_ADDR] *
+			index + i * sizeof(u32);
+
+		rc = hl_snprintf_resize(buf, size, offset, "sync id: %u", i);
+		if (rc)
+			goto free_sync_objects;
+		sync_name = hl_state_dump_get_sync_name(hdev, i);
+		if (sync_name) {
+			rc = hl_snprintf_resize(buf, size, offset, " %s",
+						sync_name);
+			if (rc)
+				goto free_sync_objects;
+		}
+		rc = hl_snprintf_resize(buf, size, offset, ", value: %u",
+					sync_objects[i]);
+		if (rc)
+			goto free_sync_objects;
+
+		/* Append engine string */
+		entry = hl_state_dump_get_sync_to_engine(map,
+			(u32)sync_object_addr);
+		if (entry) {
+			rc = hl_snprintf_resize(buf, size, offset, ", Engine: ");
+			if (rc)
+				goto free_sync_objects;
+			rc = hl_print_resize_sync_engine(buf, size, offset,
+						entry->engine_type,
+						entry->engine_id);
+			if (rc)
+				goto free_sync_objects;
+		}
+
+		rc = hl_snprintf_resize(buf, size, offset, "\n");
+		if (rc)
+			goto free_sync_objects;
+	}
+
+free_sync_objects:
+	hl_state_dump_free_sync_objects(sync_objects);
+out:
+	return rc;
+}
+
+/**
+ * hl_state_dump_print_syncs - print active sync objects
+ * @hdev: pointer to the device
+ * @buf: destination buffer double pointer to be used with hl_snprintf_resize
+ * @size: pointer to the size container
+ * @offset: pointer to the offset container
+ *
+ * Returns 0 on success or error code on failure
+ */
+static int hl_state_dump_print_syncs(struct hl_device *hdev,
+					char **buf, size_t *size,
+					size_t *offset)
+
+{
+	struct hl_state_dump_specs *sds = &hdev->state_dump_specs;
+	struct hl_sync_to_engine_map *map;
+	u32 index;
+	int rc = 0;
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	rc = sds->funcs.gen_sync_to_engine_map(hdev, map);
+	if (rc)
+		goto free_map_mem;
+
+	rc = hl_snprintf_resize(buf, size, offset, "Non zero sync objects:\n");
+	if (rc)
+		goto out;
+
+	if (sds->sync_namager_names) {
+		for (index = 0; sds->sync_namager_names[index]; ++index) {
+			rc = hl_state_dump_print_syncs_single_block(
+				hdev, index, buf, size, offset, map);
+			if (rc)
+				goto out;
+		}
+	} else {
+		for (index = 0; index < sds->props[SP_NUM_CORES]; ++index) {
+			rc = hl_state_dump_print_syncs_single_block(
+				hdev, index, buf, size, offset, map);
+			if (rc)
+				goto out;
+		}
+	}
+
+out:
+	hl_state_dump_free_sync_to_engine_map(map);
+free_map_mem:
+	kfree(map);
+
+	return rc;
+}
+
+/**
+ * hl_state_dump() - dump system state
+ * @hdev: pointer to device structure
+ */
+int hl_state_dump(struct hl_device *hdev)
+{
+	char *buf = NULL;
+	size_t offset = 0, size = 0;
+	int rc;
+
+	rc = hl_snprintf_resize(&buf, &size, &offset,
+				"Timestamp taken on: %llu\n\n",
+				ktime_to_ns(ktime_get()));
+
+	rc = hl_state_dump_print_syncs(hdev, &buf, &size, &offset);
+	if (rc)
+		goto err;
+
+	hl_snprintf_resize(&buf, &size, &offset, "\n");
+
+	hl_debugfs_set_state_dump(hdev, buf, size);
+
+	return 0;
+err:
+	vfree(buf);
+	return rc;
+}
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index aa8a0ca5aca2..7f90f637d7f4 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -348,6 +348,8 @@ static enum hl_queue_type gaudi_queue_type[GAUDI_QUEUE_ID_SIZE] = {
 	QUEUE_TYPE_INT, /* GAUDI_QUEUE_ID_NIC_9_3 */
 };
 
+static s64 gaudi_state_dump_specs_props[SP_MAX] = {0};
+
 struct ecc_info_extract_params {
 	u64 block_address;
 	u32 num_memories;
@@ -8977,6 +8979,25 @@ static int gaudi_map_pll_idx_to_fw_idx(u32 pll_idx)
 	}
 }
 
+static int gaudi_gen_sync_to_engine_map(struct hl_device *hdev,
+				struct hl_sync_to_engine_map *map)
+{
+	/* Not implemented */
+	return 0;
+}
+
+
+static struct hl_state_dump_specs_funcs gaudi_state_dump_funcs = {
+	.gen_sync_to_engine_map = gaudi_gen_sync_to_engine_map,
+};
+
+static void gaudi_state_dump_init(struct hl_device *hdev)
+{
+	/* Not implemented */
+	hdev->state_dump_specs.props = gaudi_state_dump_specs_props;
+	hdev->state_dump_specs.funcs = gaudi_state_dump_funcs;
+}
+
 static const struct hl_asic_funcs gaudi_funcs = {
 	.early_init = gaudi_early_init,
 	.early_fini = gaudi_early_fini,
@@ -9062,7 +9083,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.enable_events_from_fw = gaudi_enable_events_from_fw,
 	.map_pll_idx_to_fw_idx = gaudi_map_pll_idx_to_fw_idx,
 	.init_firmware_loader = gaudi_init_firmware_loader,
-	.init_cpu_scrambler_dram = gaudi_init_scrambler_hbm
+	.init_cpu_scrambler_dram = gaudi_init_scrambler_hbm,
+	.state_dump_init = gaudi_state_dump_init
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 755e08cf2ecc..2c3d642d31ab 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -350,6 +350,8 @@ static u32 goya_all_events[] = {
 	GOYA_ASYNC_EVENT_ID_FIX_THERMAL_ENV_E
 };
 
+static s64 goya_state_dump_specs_props[SP_MAX] = {0};
+
 static int goya_mmu_clear_pgt_range(struct hl_device *hdev);
 static int goya_mmu_set_dram_default_page(struct hl_device *hdev);
 static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev);
@@ -5524,6 +5526,25 @@ static int goya_map_pll_idx_to_fw_idx(u32 pll_idx)
 	}
 }
 
+static int goya_gen_sync_to_engine_map(struct hl_device *hdev,
+				struct hl_sync_to_engine_map *map)
+{
+	/* Not implemented */
+	return 0;
+}
+
+
+static struct hl_state_dump_specs_funcs goya_state_dump_funcs = {
+	.gen_sync_to_engine_map = goya_gen_sync_to_engine_map,
+};
+
+static void goya_state_dump_init(struct hl_device *hdev)
+{
+	/* Not implemented */
+	hdev->state_dump_specs.props = goya_state_dump_specs_props;
+	hdev->state_dump_specs.funcs = goya_state_dump_funcs;
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5609,7 +5630,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.enable_events_from_fw = goya_enable_events_from_fw,
 	.map_pll_idx_to_fw_idx = goya_map_pll_idx_to_fw_idx,
 	.init_firmware_loader = goya_init_firmware_loader,
-	.init_cpu_scrambler_dram = goya_cpu_init_scrambler_dram
+	.init_cpu_scrambler_dram = goya_cpu_init_scrambler_dram,
+	.state_dump_init = goya_state_dump_init,
 };
 
 /*
-- 
2.25.1

