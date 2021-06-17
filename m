Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2AA3AB638
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhFQOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhFQOnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:43:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 050EA613BA;
        Thu, 17 Jun 2021 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623940853;
        bh=zdZPtam/AjONUl2j33gtjr7mp2es/vQU9pYn55nZTHM=;
        h=From:To:Cc:Subject:Date:From;
        b=D4AJWOcLhecdIRAvMfKn7UlFbJpdiHHV7SXZDPkU2YOVBQ3otjaQxLYSuMM5zb1kl
         Q53UF6W1IqWYj1KDvGRYtc2qCuCHMltul6Bjl2O07N2xnaRALjwEGVBUBAxoXD8F10
         dHnyNtXBO38hsRjtOK6Y/uwk5WXAmxBo4F2beLxb//qZ8t66sTW0jwMYXKtqcNJaRj
         6wC+fTutnkqu6LdOzuAC/mXlRSQHowKhc3uFGBQwRJsC/qFjYY9dIlFAIjV1coefkP
         W0nqHUDvGn58GEG5xwpZ1cQRcNlLNCYNu5TrwK1GKeZIuPhpkz4XZzlV63omhLSE6d
         O1Mj/gdUtvOnw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/3] habanalabs/gaudi: correct driver events numbering
Date:   Thu, 17 Jun 2021 17:40:46 +0300
Message-Id: <20210617144048.4655-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Currently driver sends fc interrupt id to FW instead of using
cpu interrupt id. We intend to fix that and keep backward
compatibility by using the same interrupt values.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c            | 12 ++++++++----
 .../include/gaudi/gaudi_async_events.h           |  8 ++++----
 .../include/gaudi/gaudi_async_ids_map_extended.h | 16 ++++++++--------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 3a66e56d7cd5..33f36da766fc 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3961,7 +3961,8 @@ static int gaudi_init_cpu_queues(struct hl_device *hdev, u32 cpu_timeout)
 			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
 			le32_to_cpu(dyn_regs->gic_host_pi_upd_irq);
 
-	WREG32(irq_handler_offset, GAUDI_EVENT_PI_UPDATE);
+	WREG32(irq_handler_offset,
+		gaudi_irq_map_table[GAUDI_EVENT_PI_UPDATE].cpu_id);
 
 	err = hl_poll_timeout(
 		hdev,
@@ -4147,7 +4148,8 @@ static void gaudi_hw_fini(struct hl_device *hdev, bool hard_reset)
 				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
 				le32_to_cpu(dyn_regs->gic_host_halt_irq);
 
-		WREG32(irq_handler_offset, GAUDI_EVENT_HALT_MACHINE);
+		WREG32(irq_handler_offset,
+			gaudi_irq_map_table[GAUDI_EVENT_HALT_MACHINE].cpu_id);
 	} else {
 		if (hdev->asic_prop.hard_reset_done_by_fw)
 			gaudi_ask_hard_reset_without_linux(hdev);
@@ -4600,7 +4602,8 @@ static void gaudi_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 				mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
 				le32_to_cpu(dyn_regs->gic_host_pi_upd_irq);
 
-		WREG32(irq_handler_offset, GAUDI_EVENT_PI_UPDATE);
+		WREG32(irq_handler_offset,
+			gaudi_irq_map_table[GAUDI_EVENT_PI_UPDATE].cpu_id);
 	}
 }
 
@@ -8989,7 +8992,8 @@ static void gaudi_enable_events_from_fw(struct hl_device *hdev)
 			mmGIC_DISTRIBUTOR__5_GICD_SETSPI_NSR :
 			le32_to_cpu(dyn_regs->gic_host_ints_irq);
 
-	WREG32(irq_handler_offset, GAUDI_EVENT_INTS_REGISTER);
+	WREG32(irq_handler_offset,
+		gaudi_irq_map_table[GAUDI_EVENT_INTS_REGISTER].cpu_id);
 }
 
 static int gaudi_map_pll_idx_to_fw_idx(u32 pll_idx)
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
index f66c759952e4..2aee18e19b5a 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
@@ -252,10 +252,6 @@ enum gaudi_async_event_id {
 	GAUDI_EVENT_HBM3_SPI_0 = 407,
 	GAUDI_EVENT_HBM3_SPI_1 = 408,
 	GAUDI_EVENT_PSOC_GPIO_U16_0 = 421,
-	GAUDI_EVENT_PI_UPDATE = 484,
-	GAUDI_EVENT_HALT_MACHINE = 485,
-	GAUDI_EVENT_INTS_REGISTER = 486,
-	GAUDI_EVENT_SOFT_RESET = 487,
 	GAUDI_EVENT_RAZWI_OR_ADC = 548,
 	GAUDI_EVENT_TPC0_QM = 572,
 	GAUDI_EVENT_TPC1_QM = 573,
@@ -303,6 +299,10 @@ enum gaudi_async_event_id {
 	GAUDI_EVENT_NIC3_QP1 = 619,
 	GAUDI_EVENT_NIC4_QP0 = 620,
 	GAUDI_EVENT_NIC4_QP1 = 621,
+	GAUDI_EVENT_PI_UPDATE = 635,
+	GAUDI_EVENT_HALT_MACHINE = 636,
+	GAUDI_EVENT_INTS_REGISTER = 637,
+	GAUDI_EVENT_SOFT_RESET = 638,
 	GAUDI_EVENT_FW_ALIVE_S = 645,
 	GAUDI_EVENT_DEV_RESET_REQ = 646,
 	GAUDI_EVENT_PKT_QUEUE_OUT_SYNC = 647,
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
index e87554ab0102..ac4d4b51da7f 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
@@ -508,10 +508,10 @@ static struct gaudi_async_events_ids_map gaudi_irq_map_table[] = {
 	{ .fc_id = 481, .cpu_id = 330, .valid = 0, .name = "" },
 	{ .fc_id = 482, .cpu_id = 331, .valid = 0, .name = "" },
 	{ .fc_id = 483, .cpu_id = 332, .valid = 0, .name = "" },
-	{ .fc_id = 484, .cpu_id = 333, .valid = 1, .name = "PI_UPDATE" },
-	{ .fc_id = 485, .cpu_id = 334, .valid = 1, .name = "HALT_MACHINE" },
-	{ .fc_id = 486, .cpu_id = 335, .valid = 1, .name = "INTS_REGISTER" },
-	{ .fc_id = 487, .cpu_id = 336, .valid = 1, .name = "SOFT_RESET" },
+	{ .fc_id = 484, .cpu_id = 333, .valid = 0, .name = "" },
+	{ .fc_id = 485, .cpu_id = 334, .valid = 0, .name = "" },
+	{ .fc_id = 486, .cpu_id = 335, .valid = 0, .name = "" },
+	{ .fc_id = 487, .cpu_id = 336, .valid = 0, .name = "" },
 	{ .fc_id = 488, .cpu_id = 337, .valid = 0, .name = "" },
 	{ .fc_id = 489, .cpu_id = 338, .valid = 0, .name = "" },
 	{ .fc_id = 490, .cpu_id = 339, .valid = 0, .name = "" },
@@ -659,10 +659,10 @@ static struct gaudi_async_events_ids_map gaudi_irq_map_table[] = {
 	{ .fc_id = 632, .cpu_id = 481, .valid = 0, .name = "" },
 	{ .fc_id = 633, .cpu_id = 482, .valid = 0, .name = "" },
 	{ .fc_id = 634, .cpu_id = 483, .valid = 0, .name = "" },
-	{ .fc_id = 635, .cpu_id = 484, .valid = 0, .name = "" },
-	{ .fc_id = 636, .cpu_id = 485, .valid = 0, .name = "" },
-	{ .fc_id = 637, .cpu_id = 486, .valid = 0, .name = "" },
-	{ .fc_id = 638, .cpu_id = 487, .valid = 0, .name = "" },
+	{ .fc_id = 635, .cpu_id = 484, .valid = 1, .name = "PI_UPDATE" },
+	{ .fc_id = 636, .cpu_id = 485, .valid = 1, .name = "HALT_MACHINE" },
+	{ .fc_id = 637, .cpu_id = 486, .valid = 1, .name = "INTS_REGISTER" },
+	{ .fc_id = 638, .cpu_id = 487, .valid = 1, .name = "SOFT_RESET" },
 	{ .fc_id = 639, .cpu_id = 488, .valid = 0, .name = "" },
 	{ .fc_id = 640, .cpu_id = 489, .valid = 0, .name = "" },
 	{ .fc_id = 641, .cpu_id = 490, .valid = 0, .name = "" },
-- 
2.25.1

