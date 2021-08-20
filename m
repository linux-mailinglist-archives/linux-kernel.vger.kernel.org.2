Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BCF3F2E90
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhHTPIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 11:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238805AbhHTPIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:08:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE98F61053;
        Fri, 20 Aug 2021 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629472047;
        bh=iYNDHH1x+/1JntY+1B165lij+k4ViTs0KYXKXaGq1Is=;
        h=From:To:Cc:Subject:Date:From;
        b=gKBR28KGFFenmNCWf12bd7CcBa7Ge4/SEV9QBZ4MLBnAQG7DA7/pRPbLvoMo+Rg24
         Yxk7ENdrXN/0D6U5PZXrHSvTVwuV/yOZ4+n0fVdIcWzCcnK2M4hPHGjr0A5TexDSuA
         5l20WEg/TrDnPS3sXpL7wKRy6IbyEEMcXL7De7hE/6w1enfbvM8yydUUYiFSXPHqqL
         9zLA8OxU4gZQxaLol8Cp5yjl2MhhzY7gXRF8dTQYxGJojixVWeJKe7rfgd87R3aajj
         CcnEvk2Pv5t8VTTwZlpoHenQeN8iyvwKf8dc/haZ9snAwausEHCxmdb9t5uR0PY1Hf
         q+EvB2pnkx1BQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 1/4] habanalabs: add "in device creation" status
Date:   Fri, 20 Aug 2021 18:07:16 +0300
Message-Id: <20210820150719.67934-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

On init, the disabled state is cleared right before hw_init and that
causes the device to report on "Operational" state before the device
initialization is finished. Although the char device is not yet exposed
to the user at this stage, the sysfs entries are exposed.

This can cause errors in monitoring applications that use the sysfs
entries.

In order to avoid this, a new state "in device creation" is introduced
to ne reported when the device is not disabled but is still in init
flow.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c         |  3 +++
 drivers/misc/habanalabs/common/habanalabs.h     |  2 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c |  8 ++++++--
 drivers/misc/habanalabs/common/sysfs.c          | 14 +++++---------
 include/uapi/misc/habanalabs.h                  |  4 +++-
 5 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 3751c915f731..c2641030d9ff 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -23,6 +23,8 @@ enum hl_device_status hl_device_status(struct hl_device *hdev)
 		status = HL_DEVICE_STATUS_NEEDS_RESET;
 	else if (hdev->disabled)
 		status = HL_DEVICE_STATUS_MALFUNCTION;
+	else if (!hdev->init_done)
+		status = HL_DEVICE_STATUS_IN_DEVICE_CREATION;
 	else
 		status = HL_DEVICE_STATUS_OPERATIONAL;
 
@@ -44,6 +46,7 @@ bool hl_device_operational(struct hl_device *hdev,
 	case HL_DEVICE_STATUS_NEEDS_RESET:
 		return false;
 	case HL_DEVICE_STATUS_OPERATIONAL:
+	case HL_DEVICE_STATUS_IN_DEVICE_CREATION:
 	default:
 		return true;
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 465fd909a7b7..d22ad9e4d5e8 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2010,7 +2010,7 @@ struct hl_state_dump_specs {
 
 #define HL_STR_MAX	32
 
-#define HL_DEV_STS_MAX (HL_DEVICE_STATUS_NEEDS_RESET + 1)
+#define HL_DEV_STS_MAX (HL_DEVICE_STATUS_LAST + 1)
 
 /* Theoretical limit only. A single host can only contain up to 4 or 8 PCIe
  * x16 cards. In extreme cases, there are hosts that can accommodate 16 cards.
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 3df4313d72cd..2ef59fd465ba 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -317,12 +317,16 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 		hdev->asic_prop.fw_security_enabled = false;
 
 	/* Assign status description string */
-	strncpy(hdev->status[HL_DEVICE_STATUS_MALFUNCTION],
-					"disabled", HL_STR_MAX);
+	strncpy(hdev->status[HL_DEVICE_STATUS_OPERATIONAL],
+					"operational", HL_STR_MAX);
 	strncpy(hdev->status[HL_DEVICE_STATUS_IN_RESET],
 					"in reset", HL_STR_MAX);
+	strncpy(hdev->status[HL_DEVICE_STATUS_MALFUNCTION],
+					"disabled", HL_STR_MAX);
 	strncpy(hdev->status[HL_DEVICE_STATUS_NEEDS_RESET],
 					"needs reset", HL_STR_MAX);
+	strncpy(hdev->status[HL_DEVICE_STATUS_IN_DEVICE_CREATION],
+					"in device creation", HL_STR_MAX);
 
 	hdev->major = hl_major;
 	hdev->reset_on_lockup = reset_on_lockup;
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index db72df282ef8..3b590a0515fb 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -285,16 +285,12 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
-	char *str;
+	char str[HL_STR_MAX];
 
-	if (atomic_read(&hdev->in_reset))
-		str = "In reset";
-	else if (hdev->disabled)
-		str = "Malfunction";
-	else if (hdev->needs_reset)
-		str = "Needs Reset";
-	else
-		str = "Operational";
+	strncpy(str, hdev->status[hl_device_status(hdev)], HL_STR_MAX);
+
+	/* use uppercase for backward compatibility */
+	str[0] = 'A' + (str[0] - 'a');
 
 	return sprintf(buf, "%s\n", str);
 }
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index e3425bcc6d15..52ddb8365119 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -276,7 +276,9 @@ enum hl_device_status {
 	HL_DEVICE_STATUS_OPERATIONAL,
 	HL_DEVICE_STATUS_IN_RESET,
 	HL_DEVICE_STATUS_MALFUNCTION,
-	HL_DEVICE_STATUS_NEEDS_RESET
+	HL_DEVICE_STATUS_NEEDS_RESET,
+	HL_DEVICE_STATUS_IN_DEVICE_CREATION,
+	HL_DEVICE_STATUS_LAST = HL_DEVICE_STATUS_IN_DEVICE_CREATION
 };
 
 enum hl_server_type {
-- 
2.17.1

