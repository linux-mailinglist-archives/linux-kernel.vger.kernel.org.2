Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5AE32C0E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386823AbhCCSqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1386025AbhCCRd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:33:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 782CF64E60;
        Wed,  3 Mar 2021 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614792765;
        bh=LqhEe6XsvgMRMw5brRRys5p5bWw/3PA8pa06ULJXoH0=;
        h=From:To:Cc:Subject:Date:From;
        b=mVA2ZurUCHEdzWR4YBInoVR+jRwPtsVPkZRs1N+//0ktoSALpuiIE1vdbj8wYWs9T
         Fhjk4H9yrrViG78xFE1XSBj4kE9qM1PR9c0+j79GEnnFx0wrNfHO7qvk1hQarBNZV7
         K1uHaGvjzuCZtc0umA12Fx3tYVMS9N/e2w2UNbEvJbyQ1QYJpacOu6whmudLR/H973
         AY6oC5vThrhhOlxFM/W7afaiju9BvkAGR5TPgNn0h9CPk4A9QVBpbES2k1x7xCY6dT
         VY3UhdJoxqJ6kQm1VZjXGY3X80tZZcfWwY06lVdMhGzhEpA4vAtFETdXC4U7kazrD4
         9mIQbJ1QHRHWg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: debugfs access to user mapped host addresses
Date:   Wed,  3 Mar 2021 19:32:39 +0200
Message-Id: <20210303173239.3655-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to have a better debuggability we allow debugfs access
to user mmu mapped host memory. Non-user host memory access will be
rejected.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    | 88 ++++++++++++++++-----
 drivers/misc/habanalabs/common/habanalabs.h | 12 ++-
 drivers/misc/habanalabs/common/mmu/mmu.c    |  2 +
 drivers/misc/habanalabs/gaudi/gaudi.c       | 40 ++++++++--
 drivers/misc/habanalabs/goya/goya.c         | 44 +++++++++--
 5 files changed, 145 insertions(+), 41 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index fd3135c422b6..fff79b31af32 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -457,21 +457,58 @@ static bool hl_is_device_va(struct hl_device *hdev, u64 addr)
 	return false;
 }
 
-static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr,
-				u64 *phys_addr)
+static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr, u32 size,
+			u64 *phys_addr)
 {
+	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	struct hl_ctx *ctx = hdev->compute_ctx;
-	int rc = 0;
+	struct hl_vm_hash_node *hnode;
+	struct hl_userptr *userptr;
+	enum vm_type_t *vm_type;
+	bool valid = false;
+	u64 end_address;
+	u32 range_size;
+	int i, rc = 0;
 
 	if (!ctx) {
 		dev_err(hdev->dev, "no ctx available\n");
 		return -EINVAL;
 	}
 
+	/* Verify address is mapped */
+	mutex_lock(&ctx->mem_hash_lock);
+	hash_for_each(ctx->mem_hash, i, hnode, node) {
+		vm_type = hnode->ptr;
+
+		if (*vm_type == VM_TYPE_USERPTR) {
+			userptr = hnode->ptr;
+			range_size = userptr->size;
+		} else {
+			phys_pg_pack = hnode->ptr;
+			range_size = phys_pg_pack->total_size;
+		}
+
+		end_address = virt_addr + size;
+		if ((virt_addr >= hnode->vaddr) &&
+				(end_address <= hnode->vaddr + range_size)) {
+			valid = true;
+			break;
+		}
+	}
+	mutex_unlock(&ctx->mem_hash_lock);
+
+	if (!valid) {
+		dev_err(hdev->dev,
+			"virt addr 0x%llx is not mapped\n",
+			virt_addr);
+		return -EINVAL;
+	}
+
 	rc = hl_mmu_va_to_pa(ctx, virt_addr, phys_addr);
 	if (rc) {
-		dev_err(hdev->dev, "virt addr 0x%llx is not mapped to phys addr\n",
-				virt_addr);
+		dev_err(hdev->dev,
+			"virt addr 0x%llx is not mapped to phys addr\n",
+			virt_addr);
 		rc = -EINVAL;
 	}
 
@@ -483,10 +520,11 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
 {
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
+	u64 va, addr = entry->addr;
 	char tmp_buf[32];
-	u64 addr = entry->addr;
-	u32 val;
+	bool user_address;
 	ssize_t rc;
+	u32 val;
 
 	if (atomic_read(&hdev->in_reset)) {
 		dev_warn_ratelimited(hdev->dev, "Can't read during reset\n");
@@ -496,13 +534,15 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
 	if (*ppos)
 		return 0;
 
-	if (hl_is_device_va(hdev, addr)) {
-		rc = device_va_to_pa(hdev, addr, &addr);
+	user_address = hl_is_device_va(hdev, addr);
+	if (user_address) {
+		va = addr;
+		rc = device_va_to_pa(hdev, addr, sizeof(val), &addr);
 		if (rc)
 			return rc;
 	}
 
-	rc = hdev->asic_funcs->debugfs_read32(hdev, addr, &val);
+	rc = hdev->asic_funcs->debugfs_read32(hdev, addr, user_address, &val);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to read from 0x%010llx\n", addr);
 		return rc;
@@ -519,6 +559,7 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	u64 addr = entry->addr;
+	bool user_address;
 	u32 value;
 	ssize_t rc;
 
@@ -531,13 +572,14 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 	if (rc)
 		return rc;
 
-	if (hl_is_device_va(hdev, addr)) {
-		rc = device_va_to_pa(hdev, addr, &addr);
+	user_address = hl_is_device_va(hdev, addr);
+	if (user_address) {
+		rc = device_va_to_pa(hdev, addr, sizeof(value), &addr);
 		if (rc)
 			return rc;
 	}
 
-	rc = hdev->asic_funcs->debugfs_write32(hdev, addr, value);
+	rc = hdev->asic_funcs->debugfs_write32(hdev, addr, user_address, value);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to write 0x%08x to 0x%010llx\n",
 			value, addr);
@@ -552,21 +594,23 @@ static ssize_t hl_data_read64(struct file *f, char __user *buf,
 {
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
-	char tmp_buf[32];
 	u64 addr = entry->addr;
-	u64 val;
+	bool user_address;
+	char tmp_buf[32];
 	ssize_t rc;
+	u64 val;
 
 	if (*ppos)
 		return 0;
 
-	if (hl_is_device_va(hdev, addr)) {
-		rc = device_va_to_pa(hdev, addr, &addr);
+	user_address = hl_is_device_va(hdev, addr);
+	if (user_address) {
+		rc = device_va_to_pa(hdev, addr, sizeof(val), &addr);
 		if (rc)
 			return rc;
 	}
 
-	rc = hdev->asic_funcs->debugfs_read64(hdev, addr, &val);
+	rc = hdev->asic_funcs->debugfs_read64(hdev, addr, user_address, &val);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to read from 0x%010llx\n", addr);
 		return rc;
@@ -583,6 +627,7 @@ static ssize_t hl_data_write64(struct file *f, const char __user *buf,
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	u64 addr = entry->addr;
+	bool user_address;
 	u64 value;
 	ssize_t rc;
 
@@ -590,13 +635,14 @@ static ssize_t hl_data_write64(struct file *f, const char __user *buf,
 	if (rc)
 		return rc;
 
-	if (hl_is_device_va(hdev, addr)) {
-		rc = device_va_to_pa(hdev, addr, &addr);
+	user_address = hl_is_device_va(hdev, addr);
+	if (user_address) {
+		rc = device_va_to_pa(hdev, addr, sizeof(value), &addr);
 		if (rc)
 			return rc;
 	}
 
-	rc = hdev->asic_funcs->debugfs_write64(hdev, addr, value);
+	rc = hdev->asic_funcs->debugfs_write64(hdev, addr, user_address, value);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to write 0x%016llx to 0x%010llx\n",
 			value, addr);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 780adde16387..2dcefd6485e5 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -969,10 +969,14 @@ struct hl_asic_funcs {
 	void (*update_eq_ci)(struct hl_device *hdev, u32 val);
 	int (*context_switch)(struct hl_device *hdev, u32 asid);
 	void (*restore_phase_topology)(struct hl_device *hdev);
-	int (*debugfs_read32)(struct hl_device *hdev, u64 addr, u32 *val);
-	int (*debugfs_write32)(struct hl_device *hdev, u64 addr, u32 val);
-	int (*debugfs_read64)(struct hl_device *hdev, u64 addr, u64 *val);
-	int (*debugfs_write64)(struct hl_device *hdev, u64 addr, u64 val);
+	int (*debugfs_read32)(struct hl_device *hdev, u64 addr,
+				bool user_address, u32 *val);
+	int (*debugfs_write32)(struct hl_device *hdev, u64 addr,
+				bool user_address, u32 val);
+	int (*debugfs_read64)(struct hl_device *hdev, u64 addr,
+				bool user_address, u64 *val);
+	int (*debugfs_write64)(struct hl_device *hdev, u64 addr,
+				bool user_address, u64 val);
 	void (*add_device_attr)(struct hl_device *hdev,
 				struct attribute_group *dev_attr_grp);
 	void (*handle_eqe)(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index 71703a32350f..18a87f0966ab 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -518,6 +518,8 @@ int hl_mmu_va_to_pa(struct hl_ctx *ctx, u64 virt_addr, u64 *phys_addr)
 	struct hl_mmu_hop_info hops;
 	int rc;
 
+	memset(&hops, 0, sizeof(hops));
+
 	rc = hl_mmu_get_tlb_info(ctx, virt_addr, &hops);
 	if (rc)
 		return rc;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 37e3f4cd05c0..8be75f7c97f8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5911,13 +5911,16 @@ static void gaudi_restore_phase_topology(struct hl_device *hdev)
 
 }
 
-static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
+static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr,
+			bool user_address, u32 *val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u64 hbm_bar_addr;
+	u64 hbm_bar_addr, host_phys_end;
 	int rc = 0;
 
+	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
+
 	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
 
 		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
@@ -5949,6 +5952,9 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
 		}
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
+	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
+			user_address && !iommu_present(&pci_bus_type)) {
+		*val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
 	} else {
 		rc = -EFAULT;
 	}
@@ -5956,13 +5962,16 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
 	return rc;
 }
 
-static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
+static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr,
+			bool user_address, u32 val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u64 hbm_bar_addr;
+	u64 hbm_bar_addr, host_phys_end;
 	int rc = 0;
 
+	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
+
 	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
 
 		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
@@ -5994,6 +6003,9 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 		}
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
+	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
+			user_address && !iommu_present(&pci_bus_type)) {
+		*(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 	} else {
 		rc = -EFAULT;
 	}
@@ -6001,13 +6013,16 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 	return rc;
 }
 
-static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
+static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr,
+				bool user_address, u64 *val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u64 hbm_bar_addr;
+	u64 hbm_bar_addr, host_phys_end;
 	int rc = 0;
 
+	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
+
 	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
 
 		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
@@ -6043,6 +6058,9 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
 		}
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
+	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
+			user_address && !iommu_present(&pci_bus_type)) {
+		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
 	} else {
 		rc = -EFAULT;
 	}
@@ -6050,13 +6068,16 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
 	return rc;
 }
 
-static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr, u64 val)
+static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
+				bool user_address, u64 val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u64 hbm_bar_addr;
+	u64 hbm_bar_addr, host_phys_end;
 	int rc = 0;
 
+	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
+
 	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
 
 		if ((gaudi->hw_cap_initialized & HW_CAP_CLK_GATE) &&
@@ -6091,6 +6112,9 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr, u64 val)
 		}
 		if (hbm_bar_addr == U64_MAX)
 			rc = -EIO;
+	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
+			user_address && !iommu_present(&pci_bus_type)) {
+		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
 	} else {
 		rc = -EFAULT;
 	}
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 452bef461fe4..9e7531167c73 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4101,12 +4101,15 @@ static void goya_clear_sm_regs(struct hl_device *hdev)
  * lead to undefined behavior and therefore, should be done with extreme care
  *
  */
-static int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
+static int goya_debugfs_read32(struct hl_device *hdev, u64 addr,
+			bool user_address, u32 *val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 ddr_bar_addr;
+	u64 ddr_bar_addr, host_phys_end;
 	int rc = 0;
 
+	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
+
 	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
 		*val = RREG32(addr - CFG_BASE);
 
@@ -4132,6 +4135,10 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
 		if (ddr_bar_addr == U64_MAX)
 			rc = -EIO;
 
+	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
+			user_address && !iommu_present(&pci_bus_type)) {
+		*val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
+
 	} else {
 		rc = -EFAULT;
 	}
@@ -4154,12 +4161,15 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr, u32 *val)
  * lead to undefined behavior and therefore, should be done with extreme care
  *
  */
-static int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
+static int goya_debugfs_write32(struct hl_device *hdev, u64 addr,
+			bool user_address, u32 val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 ddr_bar_addr;
+	u64 ddr_bar_addr, host_phys_end;
 	int rc = 0;
 
+	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
+
 	if ((addr >= CFG_BASE) && (addr < CFG_BASE + CFG_SIZE)) {
 		WREG32(addr - CFG_BASE, val);
 
@@ -4185,6 +4195,10 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 		if (ddr_bar_addr == U64_MAX)
 			rc = -EIO;
 
+	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
+			user_address && !iommu_present(&pci_bus_type)) {
+		*(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
+
 	} else {
 		rc = -EFAULT;
 	}
@@ -4192,12 +4206,15 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr, u32 val)
 	return rc;
 }
 
-static int goya_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
+static int goya_debugfs_read64(struct hl_device *hdev, u64 addr,
+			bool user_address, u64 *val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 ddr_bar_addr;
+	u64 ddr_bar_addr, host_phys_end;
 	int rc = 0;
 
+	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
+
 	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
 		u32 val_l = RREG32(addr - CFG_BASE);
 		u32 val_h = RREG32(addr + sizeof(u32) - CFG_BASE);
@@ -4227,6 +4244,10 @@ static int goya_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
 		if (ddr_bar_addr == U64_MAX)
 			rc = -EIO;
 
+	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
+			user_address && !iommu_present(&pci_bus_type)) {
+		*val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
+
 	} else {
 		rc = -EFAULT;
 	}
@@ -4234,12 +4255,15 @@ static int goya_debugfs_read64(struct hl_device *hdev, u64 addr, u64 *val)
 	return rc;
 }
 
-static int goya_debugfs_write64(struct hl_device *hdev, u64 addr, u64 val)
+static int goya_debugfs_write64(struct hl_device *hdev, u64 addr,
+				bool user_address, u64 val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 ddr_bar_addr;
+	u64 ddr_bar_addr, host_phys_end;
 	int rc = 0;
 
+	host_phys_end = HOST_PHYS_BASE + HOST_PHYS_SIZE;
+
 	if ((addr >= CFG_BASE) && (addr <= CFG_BASE + CFG_SIZE - sizeof(u64))) {
 		WREG32(addr - CFG_BASE, lower_32_bits(val));
 		WREG32(addr + sizeof(u32) - CFG_BASE, upper_32_bits(val));
@@ -4267,6 +4291,10 @@ static int goya_debugfs_write64(struct hl_device *hdev, u64 addr, u64 val)
 		if (ddr_bar_addr == U64_MAX)
 			rc = -EIO;
 
+	} else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
+			user_address && !iommu_present(&pci_bus_type)) {
+		*(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
+
 	} else {
 		rc = -EFAULT;
 	}
-- 
2.25.1

