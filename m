Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCBC370A8C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 08:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhEBGjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 02:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229909AbhEBGjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 02:39:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC37D61408;
        Sun,  2 May 2021 06:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619937532;
        bh=Cr/Dd+i1YhqVGwWDjxg4CKwWYLN+n5f2IDiwEX2sARc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=diPq3VnJ8fkuDQbf5hcegDFeMsVyft+WZ0X/IzjqnHpgMG6v2NNdOo8FrD/gGZ5n0
         xvS6zH3+ljqnpDpo1ZTGCd6DpfHqXUl7LK6be3YWPEanb8k1vMBsp4GoaaASWfpodJ
         6hWSmvPAj6rNCjEkLJJ3q5AH5xLPQzTkqGtiMT2LAgB2w4GUVYdBoAnSOKp8A+C0/2
         2/Cmx+M3lXyyLxr7WQ+Bt6SM2MR1lItlGvYXzbHGRK2VHc4PIRi/3GYmp9IOsxjxFd
         WtdXzZV2/Zv4TctP020n7J/D3JMfkJlLqsxYBv2TToQcW6BDnCglypOvMIH7Uc7mtJ
         7nTSLozBCobdw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 3/4] habanalabs: load boot fit to device
Date:   Sun,  2 May 2021 09:38:44 +0300
Message-Id: <20210502063845.4615-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502063845.4615-1-ogabbay@kernel.org>
References: <20210502063845.4615-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Implementing dynamic boot fit image load to the device.
Note that some necessary adjustment were added to the static loader as
well so that both loaders can co-exist.
as this is not the final FW load stage the dynamic FW load is still
forced to be non functional.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 577 +++++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h  |  61 +-
 drivers/misc/habanalabs/gaudi/gaudi.c        |  23 +-
 drivers/misc/habanalabs/goya/goya.c          |  23 +-
 4 files changed, 615 insertions(+), 69 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 284563388710..e85747d8392a 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -9,9 +9,18 @@
 #include "../include/common/hl_boot_if.h"
 
 #include <linux/firmware.h>
+#include <linux/crc32.h>
 #include <linux/slab.h>
 
-#define FW_FILE_MAX_SIZE	0x1400000 /* maximum size of 20MB */
+#define FW_FILE_MAX_SIZE		0x1400000 /* maximum size of 20MB */
+
+/*
+ * when copying image to FW we assume that PCI bar should not be re-set
+ * (refers mainly to DRAM in which we do such it to access arbitrary region's
+ * memory address) and we limit the BAR offset to 1G which should be more than
+ * reasonable for image copy purposes.
+ */
+#define FW_IMAGE_MAX_BAR_OFFSET		(1024 * 1024 * 1024)
 
 static int hl_request_fw(struct hl_device *hdev,
 				const struct firmware **firmware_p,
@@ -53,6 +62,53 @@ static int hl_request_fw(struct hl_device *hdev,
 	return rc;
 }
 
+/**
+ * hl_release_firmware() - release FW
+ *
+ * @fw: fw descriptor
+ *
+ * note: this inline function added to serve as a comprehensive mirror for the
+ *       hl_request_fw function.
+ */
+static inline void hl_release_firmware(const struct firmware *fw)
+{
+	release_firmware(fw);
+}
+
+/**
+ * hl_fw_copy_fw_to_device() - copy FW to device
+ *
+ * @hdev: pointer to hl_device structure.
+ * @fw: fw descriptor
+ * @dst: IO memory mapped address space to copy firmware to
+ * @src_offset: offset in src FW to copy from
+ * @size: amount of bytes to copy (0 to copy the whole binary)
+ *
+ * actual copy of FW binary data to device, shared by static and dynamic loaders
+ */
+static int hl_fw_copy_fw_to_device(struct hl_device *hdev,
+				const struct firmware *fw, void __iomem *dst,
+				u32 src_offset, u32 size)
+{
+	const void *fw_data;
+
+	/* size 0 indicates to copy the whole file */
+	if (!size)
+		size = fw->size;
+
+	if (src_offset + size > fw->size) {
+		dev_err(hdev->dev,
+			"size to copy(%u) and offset(%u) are invalid\n",
+			size, src_offset);
+		return -EINVAL;
+	}
+
+	fw_data = (const void *) fw->data;
+
+	memcpy_toio(dst, fw_data + src_offset, size);
+	return 0;
+}
+
 /**
  * hl_fw_load_fw_to_device() - Load F/W code to device's memory.
  *
@@ -70,33 +126,15 @@ int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 				void __iomem *dst, u32 src_offset, u32 size)
 {
 	const struct firmware *fw;
-	const void *fw_data;
-	size_t fw_size;
 	int rc;
 
 	rc = hl_request_fw(hdev, &fw, fw_name);
 	if (rc)
 		return rc;
 
-	fw_size = fw->size;
-
-	if (size - src_offset > fw_size) {
-		dev_err(hdev->dev,
-			"size to copy(%u) and offset(%u) are invalid\n",
-			size, src_offset);
-		rc = -EINVAL;
-		goto out;
-	}
-
-	if (size)
-		fw_size = size;
-
-	fw_data = (const void *) fw->data;
+	rc = hl_fw_copy_fw_to_device(hdev, fw, dst, src_offset, size);
 
-	memcpy_toio(dst, fw_data + src_offset, fw_size);
-
-out:
-	release_firmware(fw);
+	hl_release_firmware(fw);
 	return rc;
 }
 
@@ -882,12 +920,15 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 	 */
 	prop->dynamic_fw_load = 0;
 
+	/* initialize FW loader once we know what load protocol is used */
+	hdev->asic_funcs->init_firmware_loader(hdev);
+
 	dev_dbg(hdev->dev, "Attempting %s FW load\n",
 			prop->dynamic_fw_load ? "dynamic" : "legacy");
 	return 0;
 }
 
-static int hl_read_device_fw_version(struct hl_device *hdev,
+static int hl_fw_static_read_device_fw_version(struct hl_device *hdev,
 					enum hl_fw_component fwc)
 {
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
@@ -932,19 +973,21 @@ static int hl_read_device_fw_version(struct hl_device *hdev,
 	return 0;
 }
 
-static int hl_fw_read_preboot_status_legacy(struct hl_device *hdev,
-		u32 cpu_boot_status_reg, u32 cpu_security_boot_status_reg,
-		u32 boot_err0_reg, u32 timeout)
+/**
+ * hl_fw_preboot_update_state - update internal data structures during
+ *                              handshake with preboot
+ *
+ *
+ * @hdev: pointer to the habanalabs device structure
+ *
+ * @return 0 on success, otherwise non-zero error code
+ */
+static void hl_fw_preboot_update_state(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 security_status;
-	int rc;
-
-	rc = hl_read_device_fw_version(hdev, FW_COMP_PREBOOT);
-	if (rc)
-		return rc;
+	u32 preboot_caps;
 
-	security_status = prop->fw_preboot_caps_map;
+	preboot_caps = prop->fw_preboot_caps_map;
 
 	/* We read security status multiple times during boot:
 	 * 1. preboot - a. Check whether the security status bits are valid
@@ -959,29 +1002,42 @@ static int hl_fw_read_preboot_status_legacy(struct hl_device *hdev,
 	 * Check security status bit (CPU_BOOT_DEV_STS0_ENABLED), if it is set
 	 * check security enabled bit (CPU_BOOT_DEV_STS0_SECURITY_EN)
 	 */
-	if (security_status & CPU_BOOT_DEV_STS0_ENABLED) {
+	if (preboot_caps & CPU_BOOT_DEV_STS0_ENABLED) {
 		prop->fw_security_status_valid = 1;
 
 		/* FW security should be derived from PCI ID, we keep this
 		 * check for backward compatibility
 		 */
-		if (security_status & CPU_BOOT_DEV_STS0_SECURITY_EN)
+		if (preboot_caps & CPU_BOOT_DEV_STS0_SECURITY_EN)
 			prop->fw_security_disabled = false;
 
-		if (security_status & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
+		if (preboot_caps & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
 	} else {
 		prop->fw_security_status_valid = 0;
 	}
 
 	dev_dbg(hdev->dev, "Firmware preboot security status %#x\n",
-			security_status);
+			preboot_caps);
 
 	dev_dbg(hdev->dev, "Firmware preboot hard-reset is %s\n",
 			prop->hard_reset_done_by_fw ? "enabled" : "disabled");
 
 	dev_info(hdev->dev, "firmware-level security is %s\n",
 			prop->fw_security_disabled ? "disabled" : "enabled");
+}
+
+static int hl_fw_static_read_preboot_status(struct hl_device *hdev,
+		u32 cpu_boot_status_reg, u32 cpu_security_boot_status_reg,
+		u32 boot_err0_reg, u32 timeout)
+{
+	int rc;
+
+	rc = hl_fw_static_read_device_fw_version(hdev, FW_COMP_PREBOOT);
+	if (rc)
+		return rc;
+
+	hl_fw_preboot_update_state(hdev);
 
 	return 0;
 }
@@ -992,8 +1048,6 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 {
 	int rc;
 
-	hdev->asic_funcs->init_firmware_loader(hdev);
-
 	/* pldm was added for cases in which we use preboot on pldm and want
 	 * to load boot fit, but we can't wait for preboot because it runs
 	 * very slowly
@@ -1012,7 +1066,7 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 		return rc;
 
 	if (!hdev->asic_prop.dynamic_fw_load)
-		return hl_fw_read_preboot_status_legacy(hdev, cpu_boot_status_reg,
+		return hl_fw_static_read_preboot_status(hdev, cpu_boot_status_reg,
 				cpu_boot_caps_reg, boot_err0_reg,
 				timeout);
 
@@ -1059,7 +1113,7 @@ static void hl_fw_dynamic_report_error_status(struct hl_device *hdev,
  *
  * @hdev: pointer to the habanalabs device structure
  * @fw_loader: managing structure for loading device's FW
- * @lkd_cmd: LKD to FW cmd code
+ * @cmd: LKD to FW cmd code
  * @size: size of next FW component to be loaded (0 if not necessary)
  *
  * LDK to FW exact command layout is defined at struct comms_command.
@@ -1072,12 +1126,45 @@ static void hl_fw_dynamic_send_cmd(struct hl_device *hdev,
 				struct fw_load_mgr *fw_loader,
 				enum comms_cmd cmd, unsigned int size)
 {
-	struct comms_command lkd_cmd;
+	struct cpu_dyn_regs *dyn_regs;
+	u32 val;
 
-	lkd_cmd.val = FIELD_PREP(COMMS_COMMAND_CMD_MASK, cmd);
-	lkd_cmd.val |= FIELD_PREP(COMMS_COMMAND_SIZE_MASK, size);
+	dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
 
-	WREG32(fw_loader->kmd_msg_to_cpu_reg, lkd_cmd.val);
+	val = FIELD_PREP(COMMS_COMMAND_CMD_MASK, cmd);
+	val |= FIELD_PREP(COMMS_COMMAND_SIZE_MASK, size);
+
+	WREG32(le32_to_cpu(dyn_regs->kmd_msg_to_cpu), val);
+}
+
+/**
+ * hl_fw_dynamic_extract_fw_response - update the FW response
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ * @response: FW response
+ * @status: the status read from CPU status register
+ *
+ * @return 0 on success, otherwise non-zero error code
+ */
+static int hl_fw_dynamic_extract_fw_response(struct hl_device *hdev,
+						struct fw_load_mgr *fw_loader,
+						struct fw_response *response,
+						u32 status)
+{
+	response->status = FIELD_GET(COMMS_STATUS_STATUS_MASK, status);
+	response->ram_offset = FIELD_GET(COMMS_STATUS_OFFSET_MASK, status) <<
+						COMMS_STATUS_OFFSET_ALIGN_SHIFT;
+	response->ram_type = FIELD_GET(COMMS_STATUS_RAM_TYPE_MASK, status);
+
+	if ((response->ram_type != COMMS_SRAM) &&
+					(response->ram_type != COMMS_DRAM)) {
+		dev_err(hdev->dev, "FW status: invalid RAM type %u\n",
+							response->ram_type);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 /**
@@ -1098,13 +1185,16 @@ static int hl_fw_dynamic_wait_for_status(struct hl_device *hdev,
 						enum comms_sts expected_status,
 						u32 timeout)
 {
+	struct cpu_dyn_regs *dyn_regs;
 	u32 status;
 	int rc;
 
+	dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
+
 	/* Wait for expected status */
 	rc = hl_poll_timeout(
 		hdev,
-		fw_loader->cpu_cmd_status_to_host_reg,
+		dyn_regs->cpu_cmd_status_to_host,
 		status,
 		FIELD_GET(COMMS_STATUS_STATUS_MASK, status) == expected_status,
 		10000,
@@ -1116,7 +1206,17 @@ static int hl_fw_dynamic_wait_for_status(struct hl_device *hdev,
 		return -EIO;
 	}
 
-	return 0;
+	/*
+	 * skip storing FW response for NOOP to preserve the actual desired
+	 * FW status
+	 */
+	if (expected_status == COMMS_STS_NOOP)
+		return 0;
+
+	rc = hl_fw_dynamic_extract_fw_response(hdev, fw_loader,
+					&fw_loader->dynamic_loader.response,
+					status);
+	return rc;
 }
 
 /**
@@ -1147,7 +1247,7 @@ static int hl_fw_dynamic_send_clear_cmd(struct hl_device *hdev,
  *
  * @hdev: pointer to the habanalabs device structure
  * @fw_loader: managing structure for loading device's FW
- * @lkd_cmd: LKD to FW cmd code
+ * @cmd: LKD to FW cmd code
  * @size: size of next FW component to be loaded (0 if not necessary)
  * @wait_ok: if true also wait for OK response from FW
  * @timeout: timeout for status wait
@@ -1217,6 +1317,353 @@ static int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
 	return 0;
 }
 
+/**
+ * hl_fw_compat_crc32 - CRC compatible with FW
+ *
+ * @data: pointer to the data
+ * @size: size of the data
+ *
+ * @return the CRC32 result
+ *
+ * NOTE: kernel's CRC32 differ's from standard CRC32 calculation.
+ *       in order to be aligned we need to flip the bits of both the input
+ *       initial CRC and kernel's CRC32 result.
+ *       in addition both sides use initial CRC of 0,
+ */
+static u32 hl_fw_compat_crc32(u8 *data, size_t size)
+{
+	return ~crc32_le(~((u32)0), data, size);
+}
+
+/**
+ * hl_fw_dynamic_validate_memory_bound - validate memory bounds for memory
+ *                                        transfer (image or descriptor) between
+ *                                        host and FW
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @addr: device address of memory transfer
+ * @size: memory transter size
+ * @region: PCI memory region
+ *
+ * @return 0 on success, otherwise non-zero error code
+ */
+static int hl_fw_dynamic_validate_memory_bound(struct hl_device *hdev,
+						u64 addr, size_t size,
+						struct pci_mem_region *region)
+{
+	u64 end_addr;
+
+	/* now make sure that the memory transfer is within region's bounds */
+	end_addr = addr + size;
+	if (end_addr >= region->region_base + region->region_size) {
+		dev_err(hdev->dev,
+			"dynamic FW load: memory transfer end address out of memory region bounds. addr: %llx\n",
+							end_addr);
+		return -EIO;
+	}
+
+	/*
+	 * now make sure memory transfer is within predefined BAR bounds.
+	 * this is to make sure we do not need to set the bar (e.g. for DRAM
+	 * memory transfers)
+	 */
+	if (end_addr >= region->region_base - region->offset_in_bar +
+						FW_IMAGE_MAX_BAR_OFFSET) {
+		dev_err(hdev->dev,
+			"FW image beyond PCI BAR bounds\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/**
+ * hl_fw_dynamic_validate_descriptor - validate FW descriptor
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ * @fw_desc: the descriptor form FW
+ *
+ * @return 0 on success, otherwise non-zero error code
+ */
+static int hl_fw_dynamic_validate_descriptor(struct hl_device *hdev,
+					struct fw_load_mgr *fw_loader,
+					struct lkd_fw_comms_desc *fw_desc)
+{
+	struct pci_mem_region *region;
+	enum pci_region region_id;
+	size_t data_size;
+	u32 data_crc32;
+	u8 *data_ptr;
+	u64 addr;
+	int rc;
+
+	if (le32_to_cpu(fw_desc->header.magic) != HL_COMMS_DESC_MAGIC) {
+		dev_err(hdev->dev, "Invalid magic for dynamic FW descriptor (%x)\n",
+				fw_desc->header.magic);
+		return -EIO;
+	}
+
+	if (fw_desc->header.version != HL_COMMS_DESC_VER) {
+		dev_err(hdev->dev, "Invalid version for dynamic FW descriptor (%x)\n",
+				fw_desc->header.version);
+		return -EIO;
+	}
+
+	/*
+	 * calc CRC32 of data without header.
+	 * note that no alignment/stride address issues here as all structures
+	 * are 64 bit padded
+	 */
+	data_size = sizeof(struct lkd_fw_comms_desc) -
+					sizeof(struct comms_desc_header);
+	data_ptr = (u8 *)fw_desc + sizeof(struct comms_desc_header);
+
+	if (le16_to_cpu(fw_desc->header.size) != data_size) {
+		dev_err(hdev->dev,
+			"Invalid descriptor size 0x%x, expected size 0x%lx\n",
+					fw_desc->header.size, data_size);
+		return -EIO;
+	}
+
+	data_crc32 = hl_fw_compat_crc32(data_ptr, data_size);
+
+	if (data_crc32 != le32_to_cpu(fw_desc->header.crc32)) {
+		dev_err(hdev->dev,
+			"CRC32 mismatch for dynamic FW descriptor (%x:%x)\n",
+					data_crc32, fw_desc->header.crc32);
+		return -EIO;
+	}
+
+	/* find memory region to which to copy the image */
+	addr = le64_to_cpu(fw_desc->img_addr);
+	region_id = hl_get_pci_memory_region(hdev, addr);
+	if ((region_id != PCI_REGION_SRAM) &&
+			((region_id != PCI_REGION_DRAM))) {
+		dev_err(hdev->dev,
+			"Invalid region to copy FW image address=%llx\n", addr);
+		return -EIO;
+	}
+
+	region = &hdev->pci_mem_region[region_id];
+
+	/* store the region for the copy stage */
+	fw_loader->dynamic_loader.image_region = region;
+
+	/*
+	 * here we know that the start address is valid, now make sure that the
+	 * image is within region's bounds
+	 */
+	rc = hl_fw_dynamic_validate_memory_bound(hdev, addr,
+					fw_loader->dynamic_loader.fw_image_size,
+					region);
+	if (rc) {
+		dev_err(hdev->dev,
+			"invalid mem transfer request for FW image\n");
+		return rc;
+	}
+
+	return 0;
+}
+
+static int hl_fw_dynamic_validate_response(struct hl_device *hdev,
+						struct fw_response *response,
+						struct pci_mem_region *region)
+{
+	u64 device_addr;
+	int rc;
+
+	device_addr = region->region_base + response->ram_offset;
+
+	/*
+	 * validate that the descriptor is within region's bounds
+	 * Note that as the start address was supplied according to the RAM
+	 * type- testing only the end address is enough
+	 */
+	rc = hl_fw_dynamic_validate_memory_bound(hdev, device_addr,
+					sizeof(struct lkd_fw_comms_desc),
+					region);
+	return rc;
+}
+
+/**
+ * hl_fw_dynamic_read_and_validate_descriptor - read and validate FW descriptor
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ *
+ * @return 0 on success, otherwise non-zero error code
+ */
+static int hl_fw_dynamic_read_and_validate_descriptor(struct hl_device *hdev,
+						struct fw_load_mgr *fw_loader)
+{
+	struct lkd_fw_comms_desc *fw_desc;
+	struct pci_mem_region *region;
+	struct fw_response *response;
+	enum pci_region region_id;
+	void __iomem *src;
+	int rc;
+
+	fw_desc = &fw_loader->dynamic_loader.comm_desc;
+	response = &fw_loader->dynamic_loader.response;
+
+	region_id = (response->ram_type == COMMS_SRAM) ?
+					PCI_REGION_SRAM : PCI_REGION_DRAM;
+
+	region = &hdev->pci_mem_region[region_id];
+
+	rc = hl_fw_dynamic_validate_response(hdev, response, region);
+	if (rc) {
+		dev_err(hdev->dev,
+			"invalid mem transfer request for FW descriptor\n");
+		return rc;
+	}
+
+	/* extract address copy the descriptor from */
+	src = hdev->pcie_bar[region->bar_id] + region->offset_in_bar +
+							response->ram_offset;
+	memcpy_fromio(fw_desc, src, sizeof(struct lkd_fw_comms_desc));
+
+	return hl_fw_dynamic_validate_descriptor(hdev, fw_loader, fw_desc);
+}
+
+/**
+ * hl_fw_dynamic_request_descriptor - handshake with CPU to get FW descriptor
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ * @next_image_size: size to allocate for next FW component
+ *
+ * @return 0 on success, otherwise non-zero error code
+ */
+static int hl_fw_dynamic_request_descriptor(struct hl_device *hdev,
+						struct fw_load_mgr *fw_loader,
+						size_t next_image_size)
+{
+	int rc;
+
+	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_PREP_DESC,
+						next_image_size, true,
+						fw_loader->cpu_timeout);
+	if (rc)
+		return rc;
+
+	return hl_fw_dynamic_read_and_validate_descriptor(hdev, fw_loader);
+}
+
+/**
+ * hl_fw_dynamic_read_device_fw_version - read FW version to exposed properties
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fwc: the firmware component
+ * @fw_version: fw component's version string
+ */
+static void hl_fw_dynamic_read_device_fw_version(struct hl_device *hdev,
+					enum hl_fw_component fwc,
+					const char *fw_version)
+{
+	char *dest;
+
+	switch (fwc) {
+	case FW_COMP_BOOT_FIT:
+		dest = hdev->asic_prop.uboot_ver;
+		break;
+	case FW_COMP_PREBOOT:
+		dest = hdev->asic_prop.preboot_ver;
+		break;
+	default:
+		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
+	}
+
+	strscpy(dest, fw_version, VERSION_MAX_LEN);
+}
+
+/**
+ * hl_fw_dynamic_copy_image - copy image to memory allocated by the FW
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw: fw descriptor
+ * @fw_loader: managing structure for loading device's FW
+ */
+static int hl_fw_dynamic_copy_image(struct hl_device *hdev,
+						const struct firmware *fw,
+						struct fw_load_mgr *fw_loader)
+{
+	struct lkd_fw_comms_desc *fw_desc;
+	struct pci_mem_region *region;
+	void __iomem *dest;
+	u64 addr;
+	int rc;
+
+	fw_desc = &fw_loader->dynamic_loader.comm_desc;
+	addr = le64_to_cpu(fw_desc->img_addr);
+
+	/* find memory region to which to copy the image */
+	region = fw_loader->dynamic_loader.image_region;
+
+	dest = hdev->pcie_bar[region->bar_id] + region->offset_in_bar +
+					(addr - region->region_base);
+
+	rc = hl_fw_copy_fw_to_device(hdev, fw, dest,
+					fw_loader->boot_fit_img.src_off,
+					fw_loader->boot_fit_img.copy_size);
+
+	return rc;
+}
+
+/**
+ * hl_fw_dynamic_load_boot_fit - load boot fit using dynamic protocol
+ *
+ * @hdev: pointer to the habanalabs device structure
+ * @fw_loader: managing structure for loading device's FW
+ *
+ * @return 0 on success, otherwise non-zero error code
+ */
+static int hl_fw_dynamic_load_boot_fit(struct hl_device *hdev,
+						struct fw_load_mgr *fw_loader)
+{
+	const struct firmware *fw;
+	int rc = 0;
+
+	/* request FW in order to communicate to FW the size to be allocated */
+	rc = hl_request_fw(hdev, &fw, fw_loader->boot_fit_img.image_name);
+	if (rc)
+		return rc;
+
+	/* store the image size for future validation */
+	fw_loader->dynamic_loader.fw_image_size = fw->size;
+
+	rc = hl_fw_dynamic_request_descriptor(hdev, fw_loader, fw->size);
+	if (rc)
+		goto release_fw;
+
+	/* read preboot version */
+	hl_fw_dynamic_read_device_fw_version(hdev, FW_COMP_PREBOOT,
+				fw_loader->dynamic_loader.comm_desc.cur_fw_ver);
+
+	/* update state during preboot handshake */
+	hl_fw_preboot_update_state(hdev);
+
+	/* copy boot fit to space allocated by FW */
+	rc = hl_fw_dynamic_copy_image(hdev, fw, fw_loader);
+	if (rc)
+		goto release_fw;
+
+	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_DATA_RDY,
+						0, true,
+						fw_loader->cpu_timeout);
+	if (rc)
+		goto release_fw;
+
+	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_EXEC,
+						0, false,
+						fw_loader->boot_fit_timeout);
+
+release_fw:
+	hl_release_firmware(fw);
+	return rc;
+}
+
 /**
  * hl_fw_dynamic_init_cpu - initialize the device CPU using dynamic protocol
  *
@@ -1238,11 +1685,37 @@ static int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
 static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 					struct fw_load_mgr *fw_loader)
 {
+	struct cpu_dyn_regs *dyn_regs;
 	int rc;
 
 	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_RST_STATE,
 						0, true,
 						fw_loader->cpu_timeout);
+	if (rc)
+		goto protocol_err;
+
+	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU)) {
+		rc = hl_fw_dynamic_request_descriptor(hdev, fw_loader, 0);
+		if (rc)
+			goto protocol_err;
+
+		/* read preboot version */
+		hl_fw_dynamic_read_device_fw_version(hdev, FW_COMP_PREBOOT,
+				fw_loader->dynamic_loader.comm_desc.cur_fw_ver);
+		return 0;
+	}
+
+	/* load boot fit to FW */
+	rc = hl_fw_dynamic_load_boot_fit(hdev, fw_loader);
+	if (rc)
+		goto protocol_err;
+
+	return 0;
+
+protocol_err:
+	dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
+	fw_read_errors(hdev, le32_to_cpu(dyn_regs->cpu_boot_err0),
+					le32_to_cpu(dyn_regs->cpu_boot_status));
 	return rc;
 }
 
@@ -1267,13 +1740,13 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 		return 0;
 
 	/* init common loader parameters */
-	static_loader = &fw_loader->static_loader;
-	cpu_msg_status_reg = fw_loader->cpu_cmd_status_to_host_reg;
-	msg_to_cpu_reg = fw_loader->kmd_msg_to_cpu_reg;
 	cpu_timeout = fw_loader->cpu_timeout;
 
 	/* init static loader parameters */
-	cpu_security_boot_status_reg = static_loader->cpu_boot_status_reg;
+	static_loader = &fw_loader->static_loader;
+	cpu_msg_status_reg = static_loader->cpu_cmd_status_to_host_reg;
+	msg_to_cpu_reg = static_loader->kmd_msg_to_cpu_reg;
+	cpu_security_boot_status_reg = static_loader->cpu_boot_dev_status_reg;
 	cpu_boot_status_reg = static_loader->cpu_boot_status_reg;
 
 	dev_info(hdev->dev, "Going to wait for device boot (up to %lds)\n",
@@ -1336,7 +1809,7 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 	dev_dbg(hdev->dev, "uboot status = %d\n", status);
 
 	/* Read U-Boot version now in case we will later fail */
-	hl_read_device_fw_version(hdev, FW_COMP_BOOT_FIT);
+	hl_fw_static_read_device_fw_version(hdev, FW_COMP_BOOT_FIT);
 
 	/* Clear reset status since we need to read it again from boot CPU */
 	prop->hard_reset_done_by_fw = false;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index fff282774739..161d33bcc79a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -846,6 +846,8 @@ struct pci_mem_region {
  * struct static_fw_load_mgr - static FW load manager
  * @preboot_version_max_off: max offset to preboot version
  * @boot_fit_version_max_off: max offset to boot fit version
+ * @kmd_msg_to_cpu_reg: register address for KDM->CPU messages
+ * @cpu_cmd_status_to_host_reg: register address for CPU command status response
  * @cpu_boot_status_reg: boot status register
  * @cpu_boot_dev_status_reg: boot device status register
  * @boot_err0_reg: boot error register
@@ -856,6 +858,8 @@ struct pci_mem_region {
 struct static_fw_load_mgr {
 	u64 preboot_version_max_off;
 	u64 boot_fit_version_max_off;
+	u32 kmd_msg_to_cpu_reg;
+	u32 cpu_cmd_status_to_host_reg;
 	u32 cpu_boot_status_reg;
 	u32 cpu_boot_dev_status_reg;
 	u32 boot_err0_reg;
@@ -864,37 +868,68 @@ struct static_fw_load_mgr {
 	u32 sram_offset_mask;
 };
 
+/**
+ * struct fw_response - FW response to LKD command
+ * @ram_offset: descriptor offset into the RAM
+ * @ram_type: RAM type containing the descriptor (SRAM/DRAM)
+ * @status: command status
+ */
+struct fw_response {
+	u32 ram_offset;
+	u8 ram_type;
+	u8 status;
+};
+
 /**
  * struct dynamic_fw_load_mgr - dynamic FW load manager
- * TODO: currently empty, will be filled once boot stages implementation will
- *       progress.
+ * @response: FW to LKD response
+ * @comm_desc: the communication descriptor with FW
+ * @image_region: region to copy the FW image to
+ * @fw_image_size: FW image size
  */
 struct dynamic_fw_load_mgr {
+	struct fw_response response;
+	struct lkd_fw_comms_desc comm_desc;
+	struct pci_mem_region *image_region;
+	size_t fw_image_size;
+};
+
+/**
+ * struct fw_image_props - properties of FW image
+ * @image_name: name of the image
+ * @src_off: offset in src FW to copy from
+ * @copy_size: amount of bytes to copy (0 to copy the whole binary)
+ */
+struct fw_image_props {
+	char *image_name;
+	u32 src_off;
+	u32 copy_size;
 };
 
 /**
  * struct fw_load_mgr - manager FW loading process
- * @kmd_msg_to_cpu_reg: register address for KDM->CPU messages
- * @cpu_cmd_status_to_host_reg: register address for CPU command status response
+ * @dynamic_loader: specific structure for dynamic load
+ * @static_loader: specific structure for static load
+ * @boot_fit_img: boot fit image properties
+ * @linux_img: linux image properties
  * @cpu_timeout: CPU response timeout in usec
  * @boot_fit_timeout: Boot fit load timeout in usec
  * @skip_bmc: should BMC be skipped
  * @sram_bar_id: SRAM bar ID
- * @static_loader: specific structure for static load
- * @dynamic_loader: specific structure for dynamic load
+ * @dram_bar_id: DRAM bar ID
  */
 struct fw_load_mgr {
-	u32 kmd_msg_to_cpu_reg;
-	u32 cpu_cmd_status_to_host_reg;
+	union {
+		struct dynamic_fw_load_mgr dynamic_loader;
+		struct static_fw_load_mgr static_loader;
+	};
+	struct fw_image_props boot_fit_img;
+	struct fw_image_props linux_img;
 	u32 cpu_timeout;
 	u32 boot_fit_timeout;
 	u8 skip_bmc;
 	u8 sram_bar_id;
-
-	union {
-		struct static_fw_load_mgr static_loader;
-		struct dynamic_fw_load_mgr dynamic_loader;
-	};
+	u8 dram_bar_id;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 0b03c6946748..e3a64600dc3b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3732,7 +3732,23 @@ static int gaudi_load_boot_fit_to_device(struct hl_device *hdev)
 
 static void gaudi_init_dynamic_firmware_loader(struct hl_device *hdev)
 {
+	struct dynamic_fw_load_mgr *dynamic_loader;
+	struct cpu_dyn_regs *dyn_regs;
 
+	dynamic_loader = &hdev->fw_loader.dynamic_loader;
+
+	/*
+	 * here we update initial values for few specific dynamic regs (as
+	 * before reading the first descriptor from FW those value has to be
+	 * hard-coded) in later stages of the protocol those values will be
+	 * updated automatically by reading the FW descriptor so data there
+	 * will always be up-to-date
+	 */
+	dyn_regs = &dynamic_loader->comm_desc.cpu_dyn_regs;
+	dyn_regs->kmd_msg_to_cpu =
+				cpu_to_le32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU);
+	dyn_regs->cpu_cmd_status_to_host =
+				cpu_to_le32(mmCPU_CMD_STATUS_TO_HOST);
 }
 
 static void gaudi_init_static_firmware_loader(struct hl_device *hdev)
@@ -3743,6 +3759,8 @@ static void gaudi_init_static_firmware_loader(struct hl_device *hdev)
 
 	static_loader->preboot_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
 	static_loader->boot_fit_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
+	static_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
+	static_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
 	static_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
 	static_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
 	static_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
@@ -3757,12 +3775,13 @@ static void gaudi_init_firmware_loader(struct hl_device *hdev)
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
 
 	/* fill common fields */
-	fw_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
-	fw_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
+	fw_loader->boot_fit_img.image_name = GAUDI_BOOT_FIT_FILE;
+	fw_loader->linux_img.image_name = GAUDI_LINUX_FW_FILE;
 	fw_loader->cpu_timeout = GAUDI_CPU_TIMEOUT_USEC;
 	fw_loader->boot_fit_timeout = GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC;
 	fw_loader->skip_bmc = !hdev->bmc_enable;
 	fw_loader->sram_bar_id = SRAM_BAR_ID;
+	fw_loader->dram_bar_id = HBM_BAR_ID;
 
 	if (prop->dynamic_fw_load)
 		gaudi_init_dynamic_firmware_loader(hdev);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c3a241227fe0..469587a63804 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2435,7 +2435,23 @@ static int goya_load_boot_fit_to_device(struct hl_device *hdev)
 
 static void goya_init_dynamic_firmware_loader(struct hl_device *hdev)
 {
+	struct dynamic_fw_load_mgr *dynamic_loader;
+	struct cpu_dyn_regs *dyn_regs;
 
+	dynamic_loader = &hdev->fw_loader.dynamic_loader;
+
+	/*
+	 * here we update initial values for few specific dynamic regs (as
+	 * before reading the first descriptor from FW those value has to be
+	 * hard-coded) in later stages of the protocol those values will be
+	 * updated automatically by reading the FW descriptor so data there
+	 * will always be up-to-date
+	 */
+	dyn_regs = &dynamic_loader->comm_desc.cpu_dyn_regs;
+	dyn_regs->kmd_msg_to_cpu =
+				cpu_to_le32(mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU);
+	dyn_regs->cpu_cmd_status_to_host =
+				cpu_to_le32(mmCPU_CMD_STATUS_TO_HOST);
 }
 
 static void goya_init_static_firmware_loader(struct hl_device *hdev)
@@ -2446,6 +2462,8 @@ static void goya_init_static_firmware_loader(struct hl_device *hdev)
 
 	static_loader->preboot_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
 	static_loader->boot_fit_version_max_off = SRAM_SIZE - VERSION_MAX_LEN;
+	static_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
+	static_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
 	static_loader->cpu_boot_status_reg = mmPSOC_GLOBAL_CONF_CPU_BOOT_STATUS;
 	static_loader->cpu_boot_dev_status_reg = mmCPU_BOOT_DEV_STS0;
 	static_loader->boot_err0_reg = mmCPU_BOOT_ERR0;
@@ -2460,12 +2478,13 @@ static void goya_init_firmware_loader(struct hl_device *hdev)
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
 
 	/* fill common fields */
-	fw_loader->kmd_msg_to_cpu_reg = mmPSOC_GLOBAL_CONF_KMD_MSG_TO_CPU;
-	fw_loader->cpu_cmd_status_to_host_reg = mmCPU_CMD_STATUS_TO_HOST;
+	fw_loader->boot_fit_img.image_name = GOYA_BOOT_FIT_FILE;
+	fw_loader->linux_img.image_name = GOYA_LINUX_FW_FILE;
 	fw_loader->cpu_timeout = GOYA_CPU_TIMEOUT_USEC;
 	fw_loader->boot_fit_timeout = GOYA_BOOT_FIT_REQ_TIMEOUT_USEC;
 	fw_loader->skip_bmc = false;
 	fw_loader->sram_bar_id = SRAM_CFG_BAR_ID;
+	fw_loader->dram_bar_id = DDR_BAR_ID;
 
 	if (prop->dynamic_fw_load)
 		goya_init_dynamic_firmware_loader(hdev);
-- 
2.25.1

