Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD333221F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBVWIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:08:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:42766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhBVWIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:08:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74A9664DE9;
        Mon, 22 Feb 2021 22:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031691;
        bh=snBX7eEjKO4v+I+3fo+FKI/34TWnlub8Akr0S9X9qHo=;
        h=From:To:Cc:Subject:Date:From;
        b=UZQNt6vjs7EF6jZkWunMpq/j5uJ42tA3OtGUHZMi4K8Q1fxnEIkCNxHxYwLRP09lu
         oruYkNLftYqobRvDZm8Xp2I9XnpAyzn8pbhMybTeodBniG8tD025XZFM4eUZbbZT4B
         NtlchmyR/BXwKOLA6oE+HoX0p9RReQ+JqGGJK3DCRQmkYKSwd6y/X98z/bYSe+kYcY
         2XRiTmM8eL561XNru6pQNl7yaGq3B7xlCte6R2eNXfX91mgWAn8nM+cfyyj7ng9R+z
         Om8ki1Rlzb8SV3CJ5VOOQZ85Ll5FUiAzFiA+D4GHdkn34koOB0ssgVAhao7dT3RQht
         DwsHbbYwNLiiw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/5] habanalabs: add reset support when user closes FD
Date:   Tue, 23 Feb 2021 00:08:02 +0200
Message-Id: <20210222220806.9311-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to support command submissions that are done directly from
user space, the driver must perform soft reset once user closes its FD.
In case the soft reset fails or device is not idle, a hard reset should
be performed.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 21 +++++++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h |  2 ++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 15fcb5c31c4b..ed1838c15c78 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -93,9 +93,26 @@ void hl_hpriv_put(struct hl_fpriv *hpriv)
 static int hl_device_release(struct inode *inode, struct file *filp)
 {
 	struct hl_fpriv *hpriv = filp->private_data;
+	struct hl_device *hdev = hpriv->hdev;
 
-	hl_cb_mgr_fini(hpriv->hdev, &hpriv->cb_mgr);
-	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
+	hl_cb_mgr_fini(hdev, &hpriv->cb_mgr);
+	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
+
+	if (hdev->reset_upon_device_release) {
+		u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
+
+		/* We try soft reset first */
+		hl_device_reset(hdev, false, false);
+
+		/* If device is not idle perform hard reset */
+		if (!hdev->asic_funcs->is_device_idle(hdev, idle_mask,
+				HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)) {
+			dev_info(hdev->dev,
+				"device is not idle (mask %#llx %#llx) after soft reset, performing hard reset",
+				idle_mask[0], idle_mask[1]);
+			hl_device_reset(hdev, true, false);
+		}
+	}
 
 	filp->private_data = NULL;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index dc9f5a83dfc9..706361a81410 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1920,6 +1920,7 @@ struct hl_mmu_funcs {
  * @device_fini_pending: true if device_fini was called and might be
  *                       waiting for the reset thread to finish
  * @supports_staged_submission: true if staged submissions are supported
+ * @reset_upon_device_release: true if reset is required upon device release
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -2026,6 +2027,7 @@ struct hl_device {
 	u8				process_kill_trial_cnt;
 	u8				device_fini_pending;
 	u8				supports_staged_submission;
+	u8				reset_upon_device_release;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
-- 
2.25.1

