Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A822420907
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhJDKKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232764AbhJDKK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:10:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA9486126A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633342120;
        bh=JsZk0XTiU1dcWnz/dfxKjWJFAldUO90QLoexXeMqh78=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Wdwie1ibUgHurrFtYkg0v79wkmL7NZrlHvETZZ5URCfPHMTsV1NFEWTW3aHbWd+Px
         SQW9fWayKUZvKNWiUOPtaTkEMWCEl47utDOnPfte1LuRHSdbkdopiKV334MigZDD7Y
         +NWtuBGFbfwXpk3uImBwgNmvXwn2AcaR5/nCZA/b8gwCCAd6W6WvZvDfxXg+cFXNCD
         A5EdS3T2XvZB921CC4NdxDLI2TKiVWFia0GHzsBghu9W/fDvQrM4Cz40n0QckWCg5g
         mer679FGkuLTM0kty6T2CszfA/x8aw/3HGUfSPe13mJgzdVnYa38xUEiNXhV48ptHF
         FZQyi82PBMfcA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] habanalabs: prevent race between fd close/open
Date:   Mon,  4 Oct 2021 13:08:29 +0300
Message-Id: <20211004100830.27573-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004100830.27573-1-ogabbay@kernel.org>
References: <20211004100830.27573-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver allows only a single process to open a device's FD at any
single time. This is done by checking "hdev->compute_ctx" under mutex.

Therefore, to prevent a race between the moment a user closes it's FD
and when another user tries to open the device, we need to make sure
that clearing this variable is the very last thing that is done in the
code of the FD's release.

I'm moving the idle check before clearing this variable and the
"reset on device release". btw, if the reset happens it will prevent
any other user from opening the device until the reset is finished.

An important thing to note is that we need to remove the user process
that is closing the device from the process list BEFORE calling the
reset function. That is to prevent a case where the reset code will
try to kill that user process and it is unnecessary as the process
doesn't hold any device/driver resources anymore.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 30 +++++++++++++++++++------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index be18ad0c1bfc..e1949b087ae3 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -69,13 +69,6 @@ static void hpriv_release(struct kref *ref)
 
 	mutex_destroy(&hpriv->restore_phase_mutex);
 
-	mutex_lock(&hdev->fpriv_list_lock);
-	list_del(&hpriv->dev_node);
-	hdev->compute_ctx = NULL;
-	mutex_unlock(&hdev->fpriv_list_lock);
-
-	kfree(hpriv);
-
 	if ((!hdev->pldm) && (hdev->pdev) &&
 			(!hdev->asic_funcs->is_device_idle(hdev,
 				idle_mask,
@@ -87,9 +80,32 @@ static void hpriv_release(struct kref *ref)
 		device_is_idle = false;
 	}
 
+	/* We need to remove the user from the list to make sure the reset process won't
+	 * try to kill the user process. Because, if we got here, it means there are no
+	 * more driver/device resources that the user process is occupying so there is
+	 * no need to kill it
+	 *
+	 * However, we can't set the compute_ctx to NULL at this stage. This is to prevent
+	 * a race between the release and opening the device again. We don't want to let
+	 * a user open the device while there a reset is about to happen.
+	 */
+	mutex_lock(&hdev->fpriv_list_lock);
+	list_del(&hpriv->dev_node);
+	mutex_unlock(&hdev->fpriv_list_lock);
+
 	if ((hdev->reset_if_device_not_idle && !device_is_idle)
 			|| hdev->reset_upon_device_release)
 		hl_device_reset(hdev, HL_RESET_DEVICE_RELEASE);
+
+	/* Now we can mark the compute_ctx as empty. Even if a reset is running in a different
+	 * thread, we don't care because the in_reset is marked so if a user will try to open
+	 * the device it will fail on that, even if compute_ctx is NULL.
+	 */
+	mutex_lock(&hdev->fpriv_list_lock);
+	hdev->compute_ctx = NULL;
+	mutex_unlock(&hdev->fpriv_list_lock);
+
+	kfree(hpriv);
 }
 
 void hl_hpriv_get(struct hl_fpriv *hpriv)
-- 
2.17.1

