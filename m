Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC623A187E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbhFIPGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238833AbhFIPFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:05:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6AF3613BF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623251035;
        bh=xJUGus0+fTPiZgq3hfqJx6aFTuf5xrApp0kJcdAsayc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=q0vbZ+xtfqArmu1aChXNMkNSNxgPLZqfQ7nE94+eJfmEZ0bCRJ8X4ReEPBICysQ3r
         z5t+C4flS57ItTBHx+eEFRdC37dgwyqXJdNdlFWWG7XIP6AwYVZKcYGPixncDtFrNd
         jU8o/vlbSZ1JYibk/NnODkOrrxrO+Ly1b0x+8nbHd6d7YwrBaWOEsTP+wAfazwFw88
         sSi4pLxWKfHpDv4j0QKcXBlSl9RQWljO8Z3DZATmlhKN75kUZKo7Qi+McjmpQXP15e
         +fv0F5xKzlh11F29TohzAleuh1FPp53YHhP6t4w0VPWSptVuvQzBW7Ul/PxXLAYw+e
         t9/wsUQ1KrSDQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] habanalabs: print firmware versions
Date:   Wed,  9 Jun 2021 18:03:43 +0300
Message-Id: <20210609150343.4712-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609150343.4712-1-ogabbay@kernel.org>
References: <20210609150343.4712-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware in habanalabs devices is composed of several components.
During device initialization, we read these versions from the device.
Print them during device initialization to allow better visibility in
automated systems.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 105 +++++++++++++++++--
 1 file changed, 95 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 2bb2a4145640..14e70422af25 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -11,11 +11,41 @@
 #include <linux/firmware.h>
 #include <linux/crc32.h>
 #include <linux/slab.h>
+#include <linux/ctype.h>
 
 #define FW_FILE_MAX_SIZE		0x1400000 /* maximum size of 20MB */
 
 #define FW_CPU_STATUS_POLL_INTERVAL_USEC	10000
 
+static char *extract_fw_ver_from_str(const char *fw_str)
+{
+	char *str, *fw_ver, *whitespace;
+
+	fw_ver = kmalloc(16, GFP_KERNEL);
+	if (!fw_ver)
+		return NULL;
+
+	str = strnstr(fw_str, "fw-", VERSION_MAX_LEN);
+	if (!str)
+		goto free_fw_ver;
+
+	/* Skip the fw- part */
+	str += 3;
+
+	/* Copy until the next whitespace */
+	whitespace =  strnstr(str, " ", 15);
+	if (!whitespace)
+		goto free_fw_ver;
+
+	strscpy(fw_ver, str, whitespace - str + 1);
+
+	return fw_ver;
+
+free_fw_ver:
+	kfree(fw_ver);
+	return NULL;
+}
+
 static int hl_request_fw(struct hl_device *hdev,
 				const struct firmware **firmware_p,
 				const char *fw_name)
@@ -573,8 +603,9 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev,
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct cpucp_packet pkt = {};
-	void *cpucp_info_cpu_addr;
 	dma_addr_t cpucp_info_dma_addr;
+	void *cpucp_info_cpu_addr;
+	char *kernel_ver;
 	u64 result;
 	int rc;
 
@@ -621,6 +652,12 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev,
 		goto out;
 	}
 
+	kernel_ver = extract_fw_ver_from_str(prop->cpucp_info.kernel_version);
+	if (kernel_ver) {
+		dev_info(hdev->dev, "Linux version %s", kernel_ver);
+		kfree(kernel_ver);
+	}
+
 	/* assume EQ code doesn't need to check eqe index */
 	hdev->event_queue.check_eqe_index = false;
 
@@ -1066,24 +1103,26 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 static int hl_fw_static_read_device_fw_version(struct hl_device *hdev,
 					enum hl_fw_component fwc)
 {
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct fw_load_mgr *fw_loader = &hdev->fw_loader;
 	struct static_fw_load_mgr *static_loader;
-	const char *name;
+	char *dest, *boot_ver, *preboot_ver;
 	u32 ver_off, limit;
-	char *dest;
+	const char *name;
+	char btl_ver[32];
 
 	static_loader = &hdev->fw_loader.static_loader;
 
 	switch (fwc) {
 	case FW_COMP_BOOT_FIT:
 		ver_off = RREG32(static_loader->boot_fit_version_offset_reg);
-		dest = hdev->asic_prop.uboot_ver;
+		dest = prop->uboot_ver;
 		name = "Boot-fit";
 		limit = static_loader->boot_fit_version_max_off;
 		break;
 	case FW_COMP_PREBOOT:
 		ver_off = RREG32(static_loader->preboot_version_offset_reg);
-		dest = hdev->asic_prop.preboot_ver;
+		dest = prop->preboot_ver;
 		name = "Preboot";
 		limit = static_loader->preboot_version_max_off;
 		break;
@@ -1105,6 +1144,30 @@ static int hl_fw_static_read_device_fw_version(struct hl_device *hdev,
 		return -EIO;
 	}
 
+	if (fwc == FW_COMP_BOOT_FIT) {
+		boot_ver = extract_fw_ver_from_str(prop->uboot_ver);
+		if (boot_ver) {
+			dev_info(hdev->dev, "boot-fit version %s\n", boot_ver);
+			kfree(boot_ver);
+		}
+	} else if (fwc == FW_COMP_PREBOOT) {
+		preboot_ver = strnstr(prop->preboot_ver, "Preboot",
+						VERSION_MAX_LEN);
+		if (preboot_ver && preboot_ver != prop->preboot_ver) {
+			strscpy(btl_ver, prop->preboot_ver,
+				min((int) (preboot_ver - prop->preboot_ver),
+									31));
+			dev_info(hdev->dev, "%s\n", btl_ver);
+		}
+
+		preboot_ver = extract_fw_ver_from_str(prop->preboot_ver);
+		if (preboot_ver) {
+			dev_info(hdev->dev, "preboot version %s\n",
+								preboot_ver);
+			kfree(preboot_ver);
+		}
+	}
+
 	return 0;
 }
 
@@ -1691,21 +1754,43 @@ static void hl_fw_dynamic_read_device_fw_version(struct hl_device *hdev,
 					enum hl_fw_component fwc,
 					const char *fw_version)
 {
-	char *dest;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	char *preboot_ver, *boot_ver;
+	char btl_ver[32];
 
 	switch (fwc) {
 	case FW_COMP_BOOT_FIT:
-		dest = hdev->asic_prop.uboot_ver;
+		strscpy(prop->uboot_ver, fw_version, VERSION_MAX_LEN);
+		boot_ver = extract_fw_ver_from_str(prop->uboot_ver);
+		if (boot_ver) {
+			dev_info(hdev->dev, "boot-fit version %s\n", boot_ver);
+			kfree(boot_ver);
+		}
+
 		break;
 	case FW_COMP_PREBOOT:
-		dest = hdev->asic_prop.preboot_ver;
+		strscpy(prop->preboot_ver, fw_version, VERSION_MAX_LEN);
+		preboot_ver = strnstr(prop->preboot_ver, "Preboot",
+						VERSION_MAX_LEN);
+		if (preboot_ver && preboot_ver != prop->preboot_ver) {
+			strscpy(btl_ver, prop->preboot_ver,
+				min((int) (preboot_ver - prop->preboot_ver),
+									31));
+			dev_info(hdev->dev, "%s\n", btl_ver);
+		}
+
+		preboot_ver = extract_fw_ver_from_str(prop->preboot_ver);
+		if (preboot_ver) {
+			dev_info(hdev->dev, "preboot version %s\n",
+								preboot_ver);
+			kfree(preboot_ver);
+		}
+
 		break;
 	default:
 		dev_warn(hdev->dev, "Undefined FW component: %d\n", fwc);
 		return;
 	}
-
-	strscpy(dest, fw_version, VERSION_MAX_LEN);
 }
 
 /**
-- 
2.25.1

