Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D763C3C9C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhGKM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 08:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232819AbhGKM5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 08:57:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9175261026;
        Sun, 11 Jul 2021 12:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626008069;
        bh=c0fxBkLHu5v5FXE1QpAIXoJGBg2h1WcInQx/slrHnJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZpabGZsj8fBjU7wHxouFdBzhEG7smcVUe8bCLTJ8gcmGWGjLVLPqikZFjE/7VKFQ
         bZHxXNT922bR2NPCJdnG0Byv4w705L695zXaEqinSMyqJBM9kZtNKA34Uh/L2xf4nV
         aJTrt9ieS40MF7sBgqLYies+PAS/Kk6Yu08dStj4VjhvnWVvoZot+cMdA9sWp2bFnT
         mgJD/t99Lfrp6DXKS58AhXnJGpZPYNwLFDIwIQX9jLmMmvTimregv2uh0jtYiKIq8o
         0G0pXxq23mRDyQRq4BBsRL3u8kcx2ly9M5kzQhimvggyC32VuPtfLXEqymSAkmIrlO
         fGiapyuep5VTg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 4/7] habanalabs: mark linux image as not loaded after hw_fini
Date:   Sun, 11 Jul 2021 15:54:15 +0300
Message-Id: <20210711125418.17533-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711125418.17533-1-ogabbay@kernel.org>
References: <20210711125418.17533-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

If hard reset fails after the call to hw_fini and before loading the
linux image to the device, a subsequent call to hw_fini should
communicate via COMMS (or MSG_TO_CPU regs for old FW versions).
However, the driver still tries in this case to communicate via the GIC,
and thus no hard reset is actually done.
To avoid that, the patch clears the linux_loaded flag after every call
to hw_fini.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 28fe15a28361..4fcd24e5a609 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1075,9 +1075,12 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	hdev->asic_funcs->hw_fini(hdev, hard_reset);
 
 	if (hard_reset) {
+		hdev->fw_loader.linux_loaded = false;
+
 		/* Release kernel context */
 		if (hdev->kernel_ctx && hl_ctx_put(hdev->kernel_ctx) == 1)
 			hdev->kernel_ctx = NULL;
+
 		hl_vm_fini(hdev);
 		hl_mmu_fini(hdev);
 		hl_eq_reset(hdev, &hdev->event_queue);
@@ -1611,6 +1614,8 @@ void hl_device_fini(struct hl_device *hdev)
 	/* Reset the H/W. It will be in idle state after this returns */
 	hdev->asic_funcs->hw_fini(hdev, true);
 
+	hdev->fw_loader.linux_loaded = false;
+
 	/* Release kernel context */
 	if ((hdev->kernel_ctx) && (hl_ctx_put(hdev->kernel_ctx) != 1))
 		dev_err(hdev->dev, "kernel ctx is still alive\n");
-- 
2.25.1

