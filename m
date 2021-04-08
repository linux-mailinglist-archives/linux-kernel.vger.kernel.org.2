Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEBF358824
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhDHPXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231893AbhDHPWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:22:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4070A61139;
        Thu,  8 Apr 2021 15:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617895364;
        bh=sumEOB2I8fspNl1loGYLtnzYv1+mSmu3vHvTzrh962o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=harhIV2PqShc1VF2Ut39ASS/aLgtC+/cn9++se3CIS/QdHWlk1Ot89mos6NEyKraK
         Xaw+4d1dDrSsOiUbQWAiK1LBiyxpVobECcy1tCnKhwpy6RLjE4BGvycs/beHhElbUk
         r4BOZiHqcqz5YViGiD3dNhYI94qqcZDbhhNGjS4PSBc4l6/m5ykR05cixtYjZSNUxs
         p/O+oYA5sfweelcPR9hgFYVoRjx+9/1SsOxS0Ltfl2yTDXNJaX/Ccq6gj8deIDw9FG
         WKdJxzulAxxBaqLuXwvQxCsjOxRaBlKNk1RGDoGj/fcEvQRnzQSBqFG42v2XDwn1v/
         pM9fUBL6E4j7Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/7] habanalabs/gaudi: derive security status from pci id
Date:   Thu,  8 Apr 2021 18:22:31 +0300
Message-Id: <20210408152234.15383-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408152234.15383-1-ogabbay@kernel.org>
References: <20210408152234.15383-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As F/ security indication must be available before driver approaches
PCI bus, F/W security should be derived from PCI id rather than be
fetched during boot handshake with F/W.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       |  4 ++++
 drivers/misc/habanalabs/common/firmware_if.c  |  6 +++---
 drivers/misc/habanalabs/common/habanalabs.h   |  4 +++-
 .../misc/habanalabs/common/habanalabs_drv.c   | 21 +++++++++++++++++++
 drivers/misc/habanalabs/common/mmu/mmu.c      |  1 +
 drivers/misc/habanalabs/common/sysfs.c        |  3 +++
 drivers/misc/habanalabs/gaudi/gaudi.c         |  2 --
 drivers/misc/habanalabs/goya/goya.c           |  2 --
 8 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 2ed4f2bedc08..00e92b678828 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -327,6 +327,10 @@ static int device_early_init(struct hl_device *hdev)
 		gaudi_set_asic_funcs(hdev);
 		strscpy(hdev->asic_name, "GAUDI", sizeof(hdev->asic_name));
 		break;
+	case ASIC_GAUDI_SEC:
+		gaudi_set_asic_funcs(hdev);
+		strscpy(hdev->asic_name, "GAUDI SEC", sizeof(hdev->asic_name));
+		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
 			hdev->asic_type);
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 532a2fd7bfb4..652571d3b8e6 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -819,16 +819,16 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	if (security_status & CPU_BOOT_DEV_STS0_ENABLED) {
 		prop->fw_security_status_valid = 1;
 
+		/* FW security should be derived from PCI ID, we keep this
+		 * check for backward compatibility
+		 */
 		if (security_status & CPU_BOOT_DEV_STS0_SECURITY_EN)
 			prop->fw_security_disabled = false;
-		else
-			prop->fw_security_disabled = true;
 
 		if (security_status & CPU_BOOT_DEV_STS0_FW_HARD_RST_EN)
 			prop->hard_reset_done_by_fw = true;
 	} else {
 		prop->fw_security_status_valid = 0;
-		prop->fw_security_disabled = true;
 	}
 
 	dev_dbg(hdev->dev, "Firmware preboot security status %#x\n",
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 867986ef4588..c1b46126c522 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -766,11 +766,13 @@ struct hl_eq {
  * @ASIC_INVALID: Invalid ASIC type.
  * @ASIC_GOYA: Goya device.
  * @ASIC_GAUDI: Gaudi device.
+ * @ASIC_GAUDI_SEC: Gaudi secured device (HL-2000).
  */
 enum hl_asic_type {
 	ASIC_INVALID,
 	ASIC_GOYA,
-	ASIC_GAUDI
+	ASIC_GAUDI,
+	ASIC_GAUDI_SEC
 };
 
 struct hl_cs_parser;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 59896566dca1..7135f1e03864 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -47,10 +47,12 @@ MODULE_PARM_DESC(memory_scrub,
 
 #define PCI_IDS_GOYA			0x0001
 #define PCI_IDS_GAUDI			0x1000
+#define PCI_IDS_GAUDI_SEC		0x1010
 
 static const struct pci_device_id ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GOYA), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HABANALABS, PCI_IDS_GAUDI_SEC), },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, ids);
@@ -74,6 +76,9 @@ static enum hl_asic_type get_asic_type(u16 device)
 	case PCI_IDS_GAUDI:
 		asic_type = ASIC_GAUDI;
 		break;
+	case PCI_IDS_GAUDI_SEC:
+		asic_type = ASIC_GAUDI_SEC;
+		break;
 	default:
 		asic_type = ASIC_INVALID;
 		break;
@@ -82,6 +87,16 @@ static enum hl_asic_type get_asic_type(u16 device)
 	return asic_type;
 }
 
+static bool is_asic_secured(enum hl_asic_type asic_type)
+{
+	switch (asic_type) {
+	case ASIC_GAUDI_SEC:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * hl_device_open - open function for habanalabs device
  *
@@ -287,6 +302,12 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 		hdev->asic_type = asic_type;
 	}
 
+	if (pdev)
+		hdev->asic_prop.fw_security_disabled =
+				!is_asic_secured(pdev->device);
+	else
+		hdev->asic_prop.fw_security_disabled = true;
+
 	/* Assign status description string */
 	strncpy(hdev->status[HL_DEVICE_STATUS_MALFUNCTION],
 					"disabled", HL_STR_MAX);
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index ae1778103e23..b37189956b14 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -591,6 +591,7 @@ int hl_mmu_if_set_funcs(struct hl_device *hdev)
 	switch (hdev->asic_type) {
 	case ASIC_GOYA:
 	case ASIC_GAUDI:
+	case ASIC_GAUDI_SEC:
 		hl_mmu_v1_set_funcs(hdev, &hdev->mmu_func[MMU_DR_PGT]);
 		break;
 	default:
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index c7ac5dc0cda4..9fa61573a89d 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -257,6 +257,9 @@ static ssize_t device_type_show(struct device *dev,
 	case ASIC_GAUDI:
 		str = "GAUDI";
 		break;
+	case ASIC_GAUDI_SEC:
+		str = "GAUDI SEC";
+		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
 				hdev->asic_type);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 62e3c63bec20..841748392e49 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -575,8 +575,6 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	for (i = 0 ; i < HL_MAX_DCORES ; i++)
 		prop->first_available_cq[i] = USHRT_MAX;
 
-	/* disable fw security for now, set it in a later stage */
-	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
 	prop->hard_reset_done_by_fw = false;
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 9d49ba649db0..44dd4d8d8822 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -484,8 +484,6 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 	for (i = 0 ; i < HL_MAX_DCORES ; i++)
 		prop->first_available_cq[i] = USHRT_MAX;
 
-	/* disable fw security for now, set it in a later stage */
-	prop->fw_security_disabled = true;
 	prop->fw_security_status_valid = false;
 	prop->hard_reset_done_by_fw = false;
 
-- 
2.25.1

