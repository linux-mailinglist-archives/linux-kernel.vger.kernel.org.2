Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994793B9122
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhGAL37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236252AbhGAL3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:29:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08F9D61483
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 11:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625138845;
        bh=+PrCy/brWsl6C7GWaf3BPwJ+n1bTqGiArU3Ip5WK8e0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SbFqu5qxSMRenDjf9+LaOhHc/llF0VpIDwIBwFXV36iZZVEEGaE1C4NRLuZWUONCD
         vxj/TM96bbqGL1SVsIc4/D2CXdR2X6hZbNk+zc/+KzVFxghDBKW5ZNYzAyEtJS4UzW
         w+N0uIbtXEdrLFJcVDr6xFk3T+AEGKbOR1uCPFvuiCH0Lm0Bx4WRoy+WEKwts5Xb+y
         a/vfn9opBuiXcr4qw40qHd9HFtXSXYzSUJkot+vKj0RpdUKDpqlgXvR2f5zqU+tdmY
         JJ7Pfc/eKImOjuKy+toebzrJxNF/U8mez4taWUARPKSZ2UBorG+sj7TzlP8UVJ1YRg
         6XVGeMehQvABw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] habanalabs: release pending user interrupts on device fini
Date:   Thu,  1 Jul 2021 14:27:14 +0300
Message-Id: <20210701112717.9540-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701112717.9540-1-ogabbay@kernel.org>
References: <20210701112717.9540-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In device fini there was missing a call to release all pending user
interrupts. That can cause a process to be stuck inside the driver's
IOCTL of wait for interrupts, in case the device is removed or
simulator is killed at the same time.

In addition, also call to remove inactive codec job was missing.

Moreover, to prevent such errors in the future (where code is added
to reset path but not to device fini), we moved some common parts
to two dedicated functions:
cleanup_resources
take_release_locks

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 100 +++++++++++-------------
 1 file changed, 46 insertions(+), 54 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index ff4cbde289c0..43d0dcbd20e3 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -866,6 +866,48 @@ static void device_disable_open_processes(struct hl_device *hdev)
 	mutex_unlock(&hdev->fpriv_list_lock);
 }
 
+static void take_release_locks(struct hl_device *hdev)
+{
+	/* Flush anyone that is inside the critical section of enqueue
+	 * jobs to the H/W
+	 */
+	hdev->asic_funcs->hw_queues_lock(hdev);
+	hdev->asic_funcs->hw_queues_unlock(hdev);
+
+	/* Flush anyone that is inside device open */
+	mutex_lock(&hdev->fpriv_list_lock);
+	mutex_unlock(&hdev->fpriv_list_lock);
+}
+
+static void cleanup_resources(struct hl_device *hdev, bool hard_reset)
+{
+	if (hard_reset) {
+		device_late_fini(hdev);
+
+		/*
+		 * Now that the heartbeat thread is closed, flush processes
+		 * which are sending messages to CPU
+		 */
+		mutex_lock(&hdev->send_cpu_message_lock);
+		mutex_unlock(&hdev->send_cpu_message_lock);
+	}
+
+	/*
+	 * Halt the engines and disable interrupts so we won't get any more
+	 * completions from H/W and we won't have any accesses from the
+	 * H/W to the host machine
+	 */
+	hdev->asic_funcs->halt_engines(hdev, hard_reset);
+
+	/* Go over all the queues, release all CS and their jobs */
+	hl_cs_rollback_all(hdev);
+
+	/* Release all pending user interrupts, each pending user interrupt
+	 * holds a reference to user context
+	 */
+	hl_release_pending_user_interrupts(hdev);
+}
+
 /*
  * hl_device_reset - reset the device
  *
@@ -970,15 +1012,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		/* This also blocks future CS/VM/JOB completion operations */
 		hdev->disabled = true;
 
-		/* Flush anyone that is inside the critical section of enqueue
-		 * jobs to the H/W
-		 */
-		hdev->asic_funcs->hw_queues_lock(hdev);
-		hdev->asic_funcs->hw_queues_unlock(hdev);
-
-		/* Flush anyone that is inside device open */
-		mutex_lock(&hdev->fpriv_list_lock);
-		mutex_unlock(&hdev->fpriv_list_lock);
+		take_release_locks(hdev);
 
 		dev_err(hdev->dev, "Going to RESET device!\n");
 	}
@@ -999,31 +1033,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		return 0;
 	}
 
-	if (hard_reset) {
-		device_late_fini(hdev);
-
-		/*
-		 * Now that the heartbeat thread is closed, flush processes
-		 * which are sending messages to CPU
-		 */
-		mutex_lock(&hdev->send_cpu_message_lock);
-		mutex_unlock(&hdev->send_cpu_message_lock);
-	}
-
-	/*
-	 * Halt the engines and disable interrupts so we won't get any more
-	 * completions from H/W and we won't have any accesses from the
-	 * H/W to the host machine
-	 */
-	hdev->asic_funcs->halt_engines(hdev, hard_reset);
-
-	/* Go over all the queues, release all CS and their jobs */
-	hl_cs_rollback_all(hdev);
-
-	/* Release all pending user interrupts, each pending user interrupt
-	 * holds a reference to user context
-	 */
-	hl_release_pending_user_interrupts(hdev);
+	cleanup_resources(hdev, hard_reset);
 
 kill_processes:
 	if (hard_reset) {
@@ -1567,31 +1577,13 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Mark device as disabled */
 	hdev->disabled = true;
 
-	/* Flush anyone that is inside the critical section of enqueue
-	 * jobs to the H/W
-	 */
-	hdev->asic_funcs->hw_queues_lock(hdev);
-	hdev->asic_funcs->hw_queues_unlock(hdev);
-
-	/* Flush anyone that is inside device open */
-	mutex_lock(&hdev->fpriv_list_lock);
-	mutex_unlock(&hdev->fpriv_list_lock);
+	take_release_locks(hdev);
 
 	hdev->hard_reset_pending = true;
 
 	hl_hwmon_fini(hdev);
 
-	device_late_fini(hdev);
-
-	/*
-	 * Halt the engines and disable interrupts so we won't get any more
-	 * completions from H/W and we won't have any accesses from the
-	 * H/W to the host machine
-	 */
-	hdev->asic_funcs->halt_engines(hdev, true);
-
-	/* Go over all the queues, release all CS and their jobs */
-	hl_cs_rollback_all(hdev);
+	cleanup_resources(hdev, true);
 
 	/* Kill processes here after CS rollback. This is because the process
 	 * can't really exit until all its CSs are done, which is what we
-- 
2.25.1

