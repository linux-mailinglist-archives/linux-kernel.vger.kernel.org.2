Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7E3221F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhBVWI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:08:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbhBVWIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:08:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE8D764E05
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614031692;
        bh=7phbDZ7Ic3gLHhQhisC3QiHsaYounggBuYZoKYAo2PQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BpysAGI4f3+sAJca+oX4YMbrLRr1MO88dK3PIamYV+alrxFsNv0x5E+kY52ufZ1nT
         SczG4QBuj21MaP0NzAQrwNsB8PzAr1OTJWxstIyydMkVqY4xsnMb9TO6gY3XgMn8Gu
         fPhqNKu3z7sbZJ01tMlL5dGkUCc0XkZ5OOhB7M5x8glw/2bgF+cATJWSEnPqsPUlGB
         q4zT+v2T07y8NCtClS7U8ZaS2vkygD4IYP9tl1cosHVPnZ3QE1L+igrjh45b6CPeMR
         nJ3bEQfsiYj3u17N70Z2TxOc8OXcbERl2YL1OshAcbxqfnjTEg/N0mlruWcnAiVuTb
         mH1YcmFTKB4eA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] habanalabs: reset after device is actually released
Date:   Tue, 23 Feb 2021 00:08:03 +0200
Message-Id: <20210222220806.9311-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222220806.9311-1-ogabbay@kernel.org>
References: <20210222220806.9311-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device is actually released only after the refcnt of the hpriv
structure is 0, which means all its contexts were closed.

If we reset the device while a context is still open, there are
possibilities for unexpected behavior and crashes. For example, if the
process has a mapping of a register block that is now currently being
reset, and the process writes/reads to that block during the reset,
the device can get stuck.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 32 ++++++++++++-------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index ed1838c15c78..8cc3264ae378 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -70,6 +70,22 @@ static void hpriv_release(struct kref *ref)
 	mutex_unlock(&hdev->fpriv_list_lock);
 
 	kfree(hpriv);
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
 }
 
 void hl_hpriv_get(struct hl_fpriv *hpriv)
@@ -98,22 +114,6 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	hl_cb_mgr_fini(hdev, &hpriv->cb_mgr);
 	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
 
-	if (hdev->reset_upon_device_release) {
-		u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] = {0};
-
-		/* We try soft reset first */
-		hl_device_reset(hdev, false, false);
-
-		/* If device is not idle perform hard reset */
-		if (!hdev->asic_funcs->is_device_idle(hdev, idle_mask,
-				HL_BUSY_ENGINES_MASK_EXT_SIZE, NULL)) {
-			dev_info(hdev->dev,
-				"device is not idle (mask %#llx %#llx) after soft reset, performing hard reset",
-				idle_mask[0], idle_mask[1]);
-			hl_device_reset(hdev, true, false);
-		}
-	}
-
 	filp->private_data = NULL;
 
 	hl_hpriv_put(hpriv);
-- 
2.25.1

