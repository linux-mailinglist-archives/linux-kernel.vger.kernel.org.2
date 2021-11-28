Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E62460977
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359115AbhK1TkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:40:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35538 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbhK1TiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:38:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBFDAB80D5D
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C0CC53FC7;
        Sun, 28 Nov 2021 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128091;
        bh=9qHION/j+cCuBe5Fmd/bm9sdSErThEiD7tePTGaE8O8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyCx5HGzwnz4cvo6ALIenJJJVQiD/M0Iy/kb08WvJwpR5A8WoKuln3EZk1bVk6o6G
         AoBGWa75xUmr0+La9fWCXZE/1v7/vq6LSKKxyE2W6SipZFVi89zSu7MQJHoVhXnPQf
         fCF1QN8nK3ouRNHTHY71DpFsnauw3804Bd7a2GmTHMN5t64auRVd/4+qR/RwyH37KR
         vDsuGHzNBKgbY04cDydimn8NeV5SnBBQdYnQFtc/M9i3VkZjnqgFTiN61ktIY+i6zs
         pK4xzNXTIsl6CQa03enCO0qR+YsRFdFtTKLM+va2kLoVqA/TUYF8wP2+ytaie8T7ds
         tKx9WUeI/FdOg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 09/12] habanalabs: handle events during soft-reset
Date:   Sun, 28 Nov 2021 21:34:32 +0200
Message-Id: <20211128193435.266534-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128193435.266534-1-ogabbay@kernel.org>
References: <20211128193435.266534-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Driver should handle events during soft-reset as F/W is not
going through reset and it keeps sending events towards host.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 4 ++++
 drivers/misc/habanalabs/common/habanalabs.h | 2 ++
 drivers/misc/habanalabs/common/irq.c        | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 822d9cec5aaf..720eea0b7e9c 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1019,6 +1019,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 		handle_reset_trigger(hdev, flags);
 
+		hdev->is_in_soft_reset = !hard_reset;
+
 		/* This also blocks future CS/VM/JOB completion operations */
 		hdev->disabled = true;
 
@@ -1171,6 +1173,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	 * is required for the initialization itself
 	 */
 	hdev->disabled = false;
+	hdev->is_in_soft_reset = false;
 
 	rc = hdev->asic_funcs->hw_init(hdev);
 	if (rc) {
@@ -1242,6 +1245,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 out_err:
 	hdev->disabled = true;
+	hdev->is_in_soft_reset = false;
 
 	if (hard_reset) {
 		dev_err(hdev->dev, "Failed to reset! Device is NOT usable\n");
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index a465b4a5f31d..c2129c9fe9e4 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2591,6 +2591,7 @@ struct last_error_session_info {
  *                        protocol will throw an error. Relevant only for
  *                        cases where Linux was not loaded to device CPU
  * @supports_wait_for_multi_cs: true if wait for multi CS is supported
+ * @is_in_soft_reset: Device is currently in soft reset process.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -2719,6 +2720,7 @@ struct hl_device {
 	u8				device_cpu_is_halted;
 	u8				supports_wait_for_multi_cs;
 	u8				stream_master_qid_arr_size;
+	u8				is_in_soft_reset;
 
 	/* Parameters for bring-up */
 	u64				nic_ports_mask;
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 9fd4c18e274e..64e0d9de21bd 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -245,7 +245,7 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
 		 */
 		dma_rmb();
 
-		if (hdev->disabled) {
+		if (hdev->disabled && !hdev->is_in_soft_reset) {
 			dev_warn(hdev->dev, "Device disabled but received an EQ event\n");
 			goto skip_irq;
 		}
-- 
2.25.1

