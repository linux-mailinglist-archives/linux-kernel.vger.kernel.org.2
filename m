Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3045352F9A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhDBTTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235659AbhDBTTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:19:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1C0961165
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 19:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617391144;
        bh=YKCC0cvEwNjeG8G8q6Vf9z7LxX/R0u5usjYSdRyoim4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ays87l+OmcYX8ku6rfqWqHHnf4VmyR39uOdSLaBJ5gYSbMXTE0RxvoWNrPI7OjxRo
         PUr4atMhIasUVcqsvQb5nnmYgfW0p43AclaVeThi3aoLQb5N+nF5B0S5Ghnr9YIgMD
         Dq+S/ew84Wg2z4hXJDFZAgEIK/Bj2em+dwEHpObPCDfNrkfJalthKDa0YS0fw7pkus
         l8+StmiL5f2GgaGqYGxe2lrqUSB6zHi02velPLKdToUUGcxLP4e0GzRfXj9NWFE4OB
         ikCg16iSESOtkSCP5ZTq3Qzaq/4/XpEI0c6r9YKHUfINOH1yPBOKSh9z+u5C1IXiAa
         UuK8ZZB34V5OQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] habanalabs/gaudi: add debugfs to DMA from the device
Date:   Fri,  2 Apr 2021 22:18:56 +0300
Message-Id: <20210402191856.4849-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402191856.4849-1-ogabbay@kernel.org>
References: <20210402191856.4849-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to debug program, the user often needs to
dump large parts of the device's DRAM, which can reach to tens of GBs.
Because reading from the device's internal memory through the PCI BAR
is extremely slow, the debug can take hours.

Instead, we can provide the user to copy data through one of the DMA
engines. This will make the operation much faster.

Currently, only GAUDI is supported.

In GAUDI, we need to find a PCI DMA engine that is IDLE and set the
DMA as secured to be able to bypass our MMU as we currently don't
map the temporary buffer to the MMU.

Example bash one-line to dump entire HBM to file (~2 minutes):

for (( i=0x0; i < 0x800000000; i+=0x8000000 )); do \
printf '0x%x\n' $i | sudo tee /sys/kernel/debug/habanalabs/hl0/addr ; \
echo 0x8000000 | sudo tee /sys/kernel/debug/habanalabs/hl0/dma_size ; \
sudo cat /sys/kernel/debug/habanalabs/hl0/data_dma >> hbm.txt ; done

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs     |  68 ++++++--
 drivers/misc/habanalabs/common/debugfs.c      | 118 ++++++++++++-
 drivers/misc/habanalabs/common/habanalabs.h   |  17 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 159 ++++++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudiP.h        |   2 +
 drivers/misc/habanalabs/goya/goya.c           |   8 +
 6 files changed, 352 insertions(+), 20 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index f9e233cbdc37..c78fc9282876 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -82,6 +82,24 @@ Description:    Allows the root user to read or write 64 bit data directly
                 If the IOMMU is disabled, it also allows the root user to read
                 or write from the host a device VA of a host mapped memory
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/data_dma
+Date:           Apr 2021
+KernelVersion:  5.13
+Contact:        ogabbay@kernel.org
+Description:    Allows the root user to read from the device's internal
+                memory (DRAM/SRAM) through a DMA engine.
+                This property is a binary blob that contains the result of the
+                DMA transfer.
+                This custom interface is needed (instead of using the generic
+                Linux user-space PCI mapping) because the amount of internal
+                memory is huge (>32GB) and reading it via the PCI bar will take
+                a very long time.
+                This interface doesn't support concurrency in the same device.
+                In GAUDI and GOYA, this action can cause undefined behavior
+                in case the it is done while the device is executing user
+                workloads.
+                Only supported on GAUDI at this stage.
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/device
 Date:           Jan 2019
 KernelVersion:  5.1
@@ -90,6 +108,24 @@ Description:    Enables the root user to set the device to specific state.
                 Valid values are "disable", "enable", "suspend", "resume".
                 User can read this property to see the valid values
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/dma_size
+Date:           Apr 2021
+KernelVersion:  5.13
+Contact:        ogabbay@kernel.org
+Description:    Specify the size of the DMA transaction when using DMA to read
+                from the device's internal memory. The value can not be larger
+                than 128MB. Writing to this value initiates the DMA transfer.
+                When the write is finished, the user can read the "data_dma"
+                blob
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/dump_security_violations
+Date:           Jan 2021
+KernelVersion:  5.12
+Contact:        ogabbay@kernel.org
+Description:    Dumps all security violations to dmesg. This will also ack
+                all security violations meanings those violations will not be
+                dumped next time user calls this API
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/engines
 Date:           Jul 2019
 KernelVersion:  5.3
@@ -154,6 +190,16 @@ Description:    Displays the hop values and physical address for a given ASID
                 e.g. to display info about VA 0x1000 for ASID 1 you need to do:
                 echo "1 0x1000" > /sys/kernel/debug/habanalabs/hl0/mmu
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/mmu_error
+Date:           Mar 2021
+KernelVersion:  5.12
+Contact:        fkassabri@habana.ai
+Description:    Check and display page fault or access violation mmu errors for
+                all MMUs specified in mmu_cap_mask.
+                e.g. to display error info for MMU hw cap bit 9, you need to do:
+                echo "0x200" > /sys/kernel/debug/habanalabs/hl0/mmu_error
+                cat /sys/kernel/debug/habanalabs/hl0/mmu_error
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/set_power_state
 Date:           Jan 2019
 KernelVersion:  5.1
@@ -161,6 +207,13 @@ Contact:        ogabbay@kernel.org
 Description:    Sets the PCI power state. Valid values are "1" for D0 and "2"
                 for D3Hot
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/stop_on_err
+Date:           Mar 2020
+KernelVersion:  5.6
+Contact:        ogabbay@kernel.org
+Description:    Sets the stop-on_error option for the device engines. Value of
+                "0" is for disable, otherwise enable.
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/userptr
 Date:           Jan 2019
 KernelVersion:  5.1
@@ -175,18 +228,3 @@ KernelVersion:  5.1
 Contact:        ogabbay@kernel.org
 Description:    Displays a list with information about all the active virtual
                 address mappings per ASID and all user mappings of HW blocks
-
-What:           /sys/kernel/debug/habanalabs/hl<n>/stop_on_err
-Date:           Mar 2020
-KernelVersion:  5.6
-Contact:        ogabbay@kernel.org
-Description:    Sets the stop-on_error option for the device engines. Value of
-                "0" is for disable, otherwise enable.
-
-What:           /sys/kernel/debug/habanalabs/hl<n>/dump_security_violations
-Date:           Jan 2021
-KernelVersion:  5.12
-Contact:        ogabbay@kernel.org
-Description:    Dumps all security violations to dmesg. This will also ack
-                all security violations meanings those violations will not be
-                dumped next time user calls this API
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 33de54092543..e1635000ca9a 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -9,7 +9,6 @@
 #include "../include/hw_ip/mmu/mmu_general.h"
 
 #include <linux/pci.h>
-#include <linux/debugfs.h>
 #include <linux/uaccess.h>
 
 #define MMU_ADDR_BUF_SIZE	40
@@ -457,6 +456,34 @@ static bool hl_is_device_va(struct hl_device *hdev, u64 addr)
 	return false;
 }
 
+static bool hl_is_device_internal_memory_va(struct hl_device *hdev, u64 addr,
+						u32 size)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 dram_start_addr, dram_end_addr;
+
+	if (!hdev->mmu_enable)
+		return false;
+
+	if (prop->dram_supports_virtual_memory) {
+		dram_start_addr = prop->dmmu.start_addr;
+		dram_end_addr = prop->dmmu.end_addr;
+	} else {
+		dram_start_addr = prop->dram_base_address;
+		dram_end_addr = prop->dram_end_address;
+	}
+
+	if (hl_mem_area_inside_range(addr, size, dram_start_addr,
+					dram_end_addr))
+		return true;
+
+	if (hl_mem_area_inside_range(addr, size, prop->sram_base_address,
+					prop->sram_end_address))
+		return true;
+
+	return false;
+}
+
 static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr, u32 size,
 			u64 *phys_addr)
 {
@@ -599,6 +626,11 @@ static ssize_t hl_data_read64(struct file *f, char __user *buf,
 	ssize_t rc;
 	u64 val;
 
+	if (atomic_read(&hdev->in_reset)) {
+		dev_warn_ratelimited(hdev->dev, "Can't read during reset\n");
+		return 0;
+	}
+
 	if (*ppos)
 		return 0;
 
@@ -630,6 +662,11 @@ static ssize_t hl_data_write64(struct file *f, const char __user *buf,
 	u64 value;
 	ssize_t rc;
 
+	if (atomic_read(&hdev->in_reset)) {
+		dev_warn_ratelimited(hdev->dev, "Can't write during reset\n");
+		return 0;
+	}
+
 	rc = kstrtoull_from_user(buf, count, 16, &value);
 	if (rc)
 		return rc;
@@ -651,6 +688,63 @@ static ssize_t hl_data_write64(struct file *f, const char __user *buf,
 	return count;
 }
 
+static ssize_t hl_dma_size_write(struct file *f, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u64 addr = entry->addr;
+	ssize_t rc;
+	u32 size;
+
+	if (atomic_read(&hdev->in_reset)) {
+		dev_warn_ratelimited(hdev->dev, "Can't DMA during reset\n");
+		return 0;
+	}
+	rc = kstrtouint_from_user(buf, count, 16, &size);
+	if (rc)
+		return rc;
+
+	if (!size) {
+		dev_err(hdev->dev, "DMA read failed. size can't be 0\n");
+		return -EINVAL;
+	}
+
+	if (size > SZ_128M) {
+		dev_err(hdev->dev,
+			"DMA read failed. size can't be larger than 128MB\n");
+		return -EINVAL;
+	}
+
+	if (!hl_is_device_internal_memory_va(hdev, addr, size)) {
+		dev_err(hdev->dev,
+			"DMA read failed. Invalid 0x%010llx + 0x%08x\n",
+			addr, size);
+		return -EINVAL;
+	}
+
+	/* Free the previous allocation, if there was any */
+	entry->blob_desc.size = 0;
+	vfree(entry->blob_desc.data);
+
+	entry->blob_desc.data = vmalloc(size);
+	if (!entry->blob_desc.data)
+		return -ENOMEM;
+
+	rc = hdev->asic_funcs->debugfs_read_dma(hdev, addr, size,
+						entry->blob_desc.data);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to DMA from 0x%010llx\n", addr);
+		vfree(entry->blob_desc.data);
+		entry->blob_desc.data = NULL;
+		return -EIO;
+	}
+
+	entry->blob_desc.size = size;
+
+	return count;
+}
+
 static ssize_t hl_get_power_state(struct file *f, char __user *buf,
 		size_t count, loff_t *ppos)
 {
@@ -960,6 +1054,11 @@ static const struct file_operations hl_data64b_fops = {
 	.write = hl_data_write64
 };
 
+static const struct file_operations hl_dma_size_fops = {
+	.owner = THIS_MODULE,
+	.write = hl_dma_size_write
+};
+
 static const struct file_operations hl_i2c_data_fops = {
 	.owner = THIS_MODULE,
 	.read = hl_i2c_data_read,
@@ -1062,6 +1161,9 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 	if (!dev_entry->entry_arr)
 		return;
 
+	dev_entry->blob_desc.size = 0;
+	dev_entry->blob_desc.data = NULL;
+
 	INIT_LIST_HEAD(&dev_entry->file_list);
 	INIT_LIST_HEAD(&dev_entry->cb_list);
 	INIT_LIST_HEAD(&dev_entry->cs_list);
@@ -1164,6 +1266,17 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 				dev_entry,
 				&hl_security_violations_fops);
 
+	debugfs_create_file("dma_size",
+				0200,
+				dev_entry->root,
+				dev_entry,
+				&hl_dma_size_fops);
+
+	debugfs_create_blob("data_dma",
+				0400,
+				dev_entry->root,
+				&dev_entry->blob_desc);
+
 	for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
 		debugfs_create_file(hl_debugfs_list[i].name,
 					0444,
@@ -1182,6 +1295,9 @@ void hl_debugfs_remove_device(struct hl_device *hdev)
 	debugfs_remove_recursive(entry->root);
 
 	mutex_destroy(&entry->file_mutex);
+
+	vfree(entry->blob_desc.data);
+
 	kfree(entry->entry_arr);
 }
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 54d7735991c7..d89ae4c3d634 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -19,6 +19,7 @@
 #include <linux/dma-direction.h>
 #include <linux/scatterlist.h>
 #include <linux/hashtable.h>
+#include <linux/debugfs.h>
 #include <linux/bitfield.h>
 #include <linux/genalloc.h>
 #include <linux/sched/signal.h>
@@ -854,8 +855,12 @@ enum div_select_defs {
  * @update_eq_ci: update event queue CI.
  * @context_switch: called upon ASID context switch.
  * @restore_phase_topology: clear all SOBs amd MONs.
- * @debugfs_read32: debug interface for reading u32 from DRAM/SRAM.
- * @debugfs_write32: debug interface for writing u32 to DRAM/SRAM.
+ * @debugfs_read32: debug interface for reading u32 from DRAM/SRAM/Host memory.
+ * @debugfs_write32: debug interface for writing u32 to DRAM/SRAM/Host memory.
+ * @debugfs_read64: debug interface for reading u64 from DRAM/SRAM/Host memory.
+ * @debugfs_write64: debug interface for writing u64 to DRAM/SRAM/Host memory.
+ * @debugfs_read_dma: debug interface for reading up to 2MB from the device's
+ *                    internal memory via DMA engine.
  * @add_device_attr: add ASIC specific device attributes.
  * @handle_eqe: handle event queue entry (IRQ) from CPU-CP.
  * @set_pll_profile: change PLL profile (manual/automatic).
@@ -979,6 +984,8 @@ struct hl_asic_funcs {
 				bool user_address, u64 *val);
 	int (*debugfs_write64)(struct hl_device *hdev, u64 addr,
 				bool user_address, u64 val);
+	int (*debugfs_read_dma)(struct hl_device *hdev, u64 addr, u32 size,
+				void *blob_addr);
 	void (*add_device_attr)(struct hl_device *hdev,
 				struct attribute_group *dev_attr_grp);
 	void (*handle_eqe)(struct hl_device *hdev,
@@ -1569,12 +1576,13 @@ struct hl_debugfs_entry {
  * @userptr_spinlock: protects userptr_list.
  * @ctx_mem_hash_list: list of available contexts with MMU mappings.
  * @ctx_mem_hash_spinlock: protects cb_list.
+ * @blob_desc: descriptor of blob
  * @addr: next address to read/write from/to in read/write32.
  * @mmu_addr: next virtual address to translate to physical address in mmu_show.
  * @mmu_asid: ASID to use while translating in mmu_show.
  * @i2c_bus: generic u8 debugfs file for bus value to use in i2c_data_read.
- * @i2c_bus: generic u8 debugfs file for address value to use in i2c_data_read.
- * @i2c_bus: generic u8 debugfs file for register value to use in i2c_data_read.
+ * @i2c_addr: generic u8 debugfs file for address value to use in i2c_data_read.
+ * @i2c_reg: generic u8 debugfs file for register value to use in i2c_data_read.
  */
 struct hl_dbg_device_entry {
 	struct dentry			*root;
@@ -1592,6 +1600,7 @@ struct hl_dbg_device_entry {
 	spinlock_t			userptr_spinlock;
 	struct list_head		ctx_mem_hash_list;
 	spinlock_t			ctx_mem_hash_spinlock;
+	struct debugfs_blob_wrapper	blob_desc;
 	u64				addr;
 	u64				mmu_addr;
 	u32				mmu_asid;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index bd711c8d3874..15ec995dd7c2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6175,6 +6175,164 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
 	return rc;
 }
 
+static int gaudi_dma_core_transfer(struct hl_device *hdev, int dma_id, u64 addr,
+					u32 size_to_dma, dma_addr_t dma_addr)
+{
+	u32 err_cause, val;
+	u64 dma_offset;
+	int rc;
+
+	dma_offset = dma_id * DMA_CORE_OFFSET;
+
+	WREG32(mmDMA0_CORE_SRC_BASE_LO + dma_offset, lower_32_bits(addr));
+	WREG32(mmDMA0_CORE_SRC_BASE_HI + dma_offset, upper_32_bits(addr));
+	WREG32(mmDMA0_CORE_DST_BASE_LO + dma_offset, lower_32_bits(dma_addr));
+	WREG32(mmDMA0_CORE_DST_BASE_HI + dma_offset, upper_32_bits(dma_addr));
+	WREG32(mmDMA0_CORE_DST_TSIZE_0 + dma_offset, size_to_dma);
+	WREG32(mmDMA0_CORE_COMMIT + dma_offset,
+			(1 << DMA0_CORE_COMMIT_LIN_SHIFT));
+
+	rc = hl_poll_timeout(
+		hdev,
+		mmDMA0_CORE_STS0 + dma_offset,
+		val,
+		((val & DMA0_CORE_STS0_BUSY_MASK) == 0),
+		0,
+		1000000);
+
+	if (rc) {
+		dev_err(hdev->dev,
+			"DMA %d timed-out during reading of 0x%llx\n",
+			dma_id, addr);
+		return -EIO;
+	}
+
+	/* Verify DMA is OK */
+	err_cause = RREG32(mmDMA0_CORE_ERR_CAUSE + dma_offset);
+	if (err_cause) {
+		dev_err(hdev->dev, "DMA Failed, cause 0x%x\n", err_cause);
+		dev_dbg(hdev->dev,
+			"Clearing DMA0 engine from errors (cause 0x%x)\n",
+			err_cause);
+		WREG32(mmDMA0_CORE_ERR_CAUSE + dma_offset, err_cause);
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
+				void *blob_addr)
+{
+	u32 dma_core_sts0, err_cause, cfg1, size_left, pos, size_to_dma;
+	struct gaudi_device *gaudi = hdev->asic_specific;
+	u64 dma_offset, qm_offset;
+	dma_addr_t dma_addr;
+	void *kernel_addr;
+	bool is_eng_idle;
+	int rc, dma_id;
+
+	kernel_addr = hdev->asic_funcs->asic_dma_alloc_coherent(
+						hdev, SZ_2M,
+						&dma_addr,
+						GFP_KERNEL | __GFP_ZERO);
+
+	if (!kernel_addr)
+		return -ENOMEM;
+
+	mutex_lock(&gaudi->clk_gate_mutex);
+
+	hdev->asic_funcs->disable_clock_gating(hdev);
+
+	hdev->asic_funcs->hw_queues_lock(hdev);
+
+	dma_id = gaudi_dma_assignment[GAUDI_PCI_DMA_1];
+	dma_offset = dma_id * DMA_CORE_OFFSET;
+	qm_offset = dma_id * DMA_QMAN_OFFSET;
+	dma_core_sts0 = RREG32(mmDMA0_CORE_STS0 + dma_offset);
+	is_eng_idle = IS_DMA_IDLE(dma_core_sts0);
+
+	if (!is_eng_idle) {
+		dma_id = gaudi_dma_assignment[GAUDI_PCI_DMA_2];
+		dma_offset = dma_id * DMA_CORE_OFFSET;
+		qm_offset = dma_id * DMA_QMAN_OFFSET;
+		dma_core_sts0 = RREG32(mmDMA0_CORE_STS0 + dma_offset);
+		is_eng_idle = IS_DMA_IDLE(dma_core_sts0);
+
+		if (!is_eng_idle) {
+			dev_err_ratelimited(hdev->dev,
+				"Can't read via DMA because it is BUSY\n");
+			rc = -EAGAIN;
+			goto out;
+		}
+	}
+
+	cfg1 = RREG32(mmDMA0_QM_GLBL_CFG1 + qm_offset);
+	WREG32(mmDMA0_QM_GLBL_CFG1 + qm_offset,
+			0xF << DMA0_QM_GLBL_CFG1_CP_STOP_SHIFT);
+
+	/* TODO: remove this by mapping the DMA temporary buffer to the MMU
+	 * using the compute ctx ASID, if exists. If not, use the kernel ctx
+	 * ASID
+	 */
+	WREG32_OR(mmDMA0_CORE_PROT + dma_offset, BIT(DMA0_CORE_PROT_VAL_SHIFT));
+
+	/* Verify DMA is OK */
+	err_cause = RREG32(mmDMA0_CORE_ERR_CAUSE + dma_offset);
+	if (err_cause) {
+		dev_dbg(hdev->dev,
+			"Clearing DMA0 engine from errors (cause 0x%x)\n",
+			err_cause);
+		WREG32(mmDMA0_CORE_ERR_CAUSE + dma_offset, err_cause);
+	}
+
+	pos = 0;
+	size_left = size;
+	size_to_dma = SZ_2M;
+
+	while (size_left > 0) {
+
+		if (size_left < SZ_2M)
+			size_to_dma = size_left;
+
+		rc = gaudi_dma_core_transfer(hdev, dma_id, addr, size_to_dma,
+						dma_addr);
+		if (rc)
+			break;
+
+		memcpy(blob_addr + pos, kernel_addr, size_to_dma);
+
+		if (size_left <= SZ_2M)
+			break;
+
+		pos += SZ_2M;
+		addr += SZ_2M;
+		size_left -= SZ_2M;
+	}
+
+	/* TODO: remove this by mapping the DMA temporary buffer to the MMU
+	 * using the compute ctx ASID, if exists. If not, use the kernel ctx
+	 * ASID
+	 */
+	WREG32_AND(mmDMA0_CORE_PROT + dma_offset,
+			~BIT(DMA0_CORE_PROT_VAL_SHIFT));
+
+	WREG32(mmDMA0_QM_GLBL_CFG1 + qm_offset, cfg1);
+
+out:
+	hdev->asic_funcs->hw_queues_unlock(hdev);
+
+	hdev->asic_funcs->set_clock_gating(hdev);
+
+	mutex_unlock(&gaudi->clk_gate_mutex);
+
+	hdev->asic_funcs->asic_dma_free_coherent(hdev, SZ_2M, kernel_addr,
+						dma_addr);
+
+	return rc;
+}
+
 static u64 gaudi_read_pte(struct hl_device *hdev, u64 addr)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -8639,6 +8797,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.debugfs_write32 = gaudi_debugfs_write32,
 	.debugfs_read64 = gaudi_debugfs_read64,
 	.debugfs_write64 = gaudi_debugfs_write64,
+	.debugfs_read_dma = gaudi_debugfs_read_dma,
 	.add_device_attr = gaudi_add_device_attr,
 	.handle_eqe = gaudi_handle_eqe,
 	.set_pll_profile = gaudi_set_pll_profile,
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 5929be81ec23..2287f76a517b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -347,4 +347,6 @@ void gaudi_halt_coresight(struct hl_device *hdev);
 int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 void gaudi_mmu_prepare_reg(struct hl_device *hdev, u64 reg, u32 asid);
 
+int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
+				void *blob_addr);
 #endif /* GAUDIP_H_ */
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 09b423455439..df3ea74608e3 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4329,6 +4329,13 @@ static int goya_debugfs_write64(struct hl_device *hdev, u64 addr,
 	return rc;
 }
 
+int goya_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
+				void *blob_addr)
+{
+	dev_err(hdev->dev, "Reading via DMA is unimplemented yet\n");
+	return -EPERM;
+}
+
 static u64 goya_read_pte(struct hl_device *hdev, u64 addr)
 {
 	struct goya_device *goya = hdev->asic_specific;
@@ -5521,6 +5528,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.debugfs_write32 = goya_debugfs_write32,
 	.debugfs_read64 = goya_debugfs_read64,
 	.debugfs_write64 = goya_debugfs_write64,
+	.debugfs_read_dma = goya_debugfs_read_dma,
 	.add_device_attr = goya_add_device_attr,
 	.handle_eqe = goya_handle_eqe,
 	.set_pll_profile = goya_set_pll_profile,
-- 
2.25.1

