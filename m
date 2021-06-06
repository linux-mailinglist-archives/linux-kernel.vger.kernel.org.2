Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CA439CE14
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 10:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFFIZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 04:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhFFIZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 04:25:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1C2F61420;
        Sun,  6 Jun 2021 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622967806;
        bh=14TchkU1nC9LPWkIjuXLStNF+5M/GzHvD7mySh12JdY=;
        h=From:To:Cc:Subject:Date:From;
        b=Mb5zej5OErLLu4ExvVDn6pHiZSjbFfEUlZDhMIfJO0PM/xnsvfAjP+I/g/MPu8vgr
         axB0qWvSJ10iH6Qk77G75Ll98chMIOmguISyixk9hkiHzBh0ZdLs/n2IyEmehXbBzA
         GxMzCtN1GX8u5UXIWHCRnNBvVMOmRhNReQK6qPeUegYwXIoubVRn/ermJKUhXwBNeV
         t6KXw2NW7w29TtT7yRLV1lq1+vcZDLPXTMfTwW9PURo9rzvHNZn1hZbj9BqCxaMErn
         3RZAdSzZm4VJm/NEsZkfPe8RjvHdoPLCEsBDkcjYOOXK+pWoSkYap82nAyJds9WLNt
         oQmqmGb3hl7ew==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/6] habanalabs/gaudi: don't use disabled ports in collective wait
Date:   Sun,  6 Jun 2021 11:23:15 +0300
Message-Id: <20210606082320.4319-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In the collective wait, we put jobs on the QMANs of all the NICs. The
code takes into account if a port is disabled only in case of PCI card.
When this info arrives from the f/w, the code doesn't take it into
account, and it tries to schedule jobs on NICs that aren't enabled and
thats a bug.

To fix this, after the f/w sends us the list of disabled ports, we
update the state of the QMANs according to that list. In addition,
we need to update the HW_CAP bits so the collective wait operation
will not try to use those QMANs. We also need to update the collective
master monitor mask.

Moreover, we need to add a protection for such future cases and in case
the user will try to submit work to those QMANs.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 219 +++++++++-----------------
 1 file changed, 71 insertions(+), 148 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 007248946b63..68b1187c9c1f 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1000,9 +1000,27 @@ static void gaudi_sob_group_reset_error(struct kref *ref)
 		hw_sob_group->base_sob_id);
 }
 
+static void gaudi_collective_mstr_sob_mask_set(struct gaudi_device *gaudi)
+{
+	struct gaudi_collective_properties *prop;
+	int i;
+
+	prop = &gaudi->collective_props;
+
+	memset(prop->mstr_sob_mask, 0, sizeof(prop->mstr_sob_mask));
+
+	for (i = 0 ; i < NIC_NUMBER_OF_ENGINES ; i++)
+		if (gaudi->hw_cap_initialized & BIT(HW_CAP_NIC_SHIFT + i))
+			prop->mstr_sob_mask[i / HL_MAX_SOBS_PER_MONITOR] |=
+					BIT(i % HL_MAX_SOBS_PER_MONITOR);
+	/* Set collective engine bit */
+	prop->mstr_sob_mask[i / HL_MAX_SOBS_PER_MONITOR] |=
+				BIT(i % HL_MAX_SOBS_PER_MONITOR);
+}
+
 static int gaudi_collective_init(struct hl_device *hdev)
 {
-	u32 i, master_monitor_sobs, sob_id, reserved_sobs_per_group;
+	u32 i, sob_id, reserved_sobs_per_group;
 	struct gaudi_collective_properties *prop;
 	struct gaudi_device *gaudi;
 
@@ -1028,22 +1046,7 @@ static int gaudi_collective_init(struct hl_device *hdev)
 		gaudi_collective_map_sobs(hdev, i);
 	}
 
-	prop->mstr_sob_mask[0] = 0;
-	master_monitor_sobs = HL_MAX_SOBS_PER_MONITOR;
-	for (i = 0 ; i < master_monitor_sobs ; i++)
-		if (gaudi->hw_cap_initialized & BIT(HW_CAP_NIC_SHIFT + i))
-			prop->mstr_sob_mask[0] |= BIT(i);
-
-	prop->mstr_sob_mask[1] = 0;
-	master_monitor_sobs =
-		NIC_NUMBER_OF_ENGINES - HL_MAX_SOBS_PER_MONITOR;
-	for (i = 0 ; i < master_monitor_sobs; i++) {
-		if (gaudi->hw_cap_initialized & BIT(HW_CAP_NIC_SHIFT + i))
-			prop->mstr_sob_mask[1] |= BIT(i);
-	}
-
-	/* Set collective engine bit */
-	prop->mstr_sob_mask[1] |= BIT(i);
+	gaudi_collective_mstr_sob_mask_set(gaudi);
 
 	return 0;
 }
@@ -4272,8 +4275,8 @@ static void gaudi_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 			&hdev->fw_loader.dynamic_loader.comm_desc.cpu_dyn_regs;
 	u32 db_reg_offset, db_value, dma_qm_offset, q_off, irq_handler_offset;
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	int dma_id;
 	bool invalid_queue = false;
+	int dma_id;
 
 	switch (hw_queue_id) {
 	case GAUDI_QUEUE_ID_DMA_0_0...GAUDI_QUEUE_ID_DMA_0_3:
@@ -4499,164 +4502,84 @@ static void gaudi_ring_doorbell(struct hl_device *hdev, u32 hw_queue_id, u32 pi)
 		db_reg_offset = mmTPC7_QM_PQ_PI_3;
 		break;
 
-	case GAUDI_QUEUE_ID_NIC_0_0:
-		db_reg_offset = mmNIC0_QM0_PQ_PI_0;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_0_1:
-		db_reg_offset = mmNIC0_QM0_PQ_PI_1;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_0_2:
-		db_reg_offset = mmNIC0_QM0_PQ_PI_2;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_0_3:
-		db_reg_offset = mmNIC0_QM0_PQ_PI_3;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_1_0:
-		db_reg_offset = mmNIC0_QM1_PQ_PI_0;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_1_1:
-		db_reg_offset = mmNIC0_QM1_PQ_PI_1;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_1_2:
-		db_reg_offset = mmNIC0_QM1_PQ_PI_2;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_1_3:
-		db_reg_offset = mmNIC0_QM1_PQ_PI_3;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_2_0:
-		db_reg_offset = mmNIC1_QM0_PQ_PI_0;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_2_1:
-		db_reg_offset = mmNIC1_QM0_PQ_PI_1;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_2_2:
-		db_reg_offset = mmNIC1_QM0_PQ_PI_2;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_2_3:
-		db_reg_offset = mmNIC1_QM0_PQ_PI_3;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_3_0:
-		db_reg_offset = mmNIC1_QM1_PQ_PI_0;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_3_1:
-		db_reg_offset = mmNIC1_QM1_PQ_PI_1;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_3_2:
-		db_reg_offset = mmNIC1_QM1_PQ_PI_2;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_3_3:
-		db_reg_offset = mmNIC1_QM1_PQ_PI_3;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_4_0:
-		db_reg_offset = mmNIC2_QM0_PQ_PI_0;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_4_1:
-		db_reg_offset = mmNIC2_QM0_PQ_PI_1;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_4_2:
-		db_reg_offset = mmNIC2_QM0_PQ_PI_2;
-		break;
+	case GAUDI_QUEUE_ID_NIC_0_0...GAUDI_QUEUE_ID_NIC_0_3:
+		if (!(gaudi->hw_cap_initialized & HW_CAP_NIC0))
+			invalid_queue = true;
 
-	case GAUDI_QUEUE_ID_NIC_4_3:
-		db_reg_offset = mmNIC2_QM0_PQ_PI_3;
+		q_off = ((hw_queue_id - 1) & 0x3) * 4;
+		db_reg_offset = mmNIC0_QM0_PQ_PI_0 + q_off;
 		break;
 
-	case GAUDI_QUEUE_ID_NIC_5_0:
-		db_reg_offset = mmNIC2_QM1_PQ_PI_0;
-		break;
+	case GAUDI_QUEUE_ID_NIC_1_0...GAUDI_QUEUE_ID_NIC_1_3:
+		if (!(gaudi->hw_cap_initialized & HW_CAP_NIC1))
+			invalid_queue = true;
 
-	case GAUDI_QUEUE_ID_NIC_5_1:
-		db_reg_offset = mmNIC2_QM1_PQ_PI_1;
+		q_off = ((hw_queue_id - 1) & 0x3) * 4;
+		db_reg_offset = mmNIC0_QM1_PQ_PI_0 + q_off;
 		break;
 
-	case GAUDI_QUEUE_ID_NIC_5_2:
-		db_reg_offset = mmNIC2_QM1_PQ_PI_2;
-		break;
+	case GAUDI_QUEUE_ID_NIC_2_0...GAUDI_QUEUE_ID_NIC_2_3:
+		if (!(gaudi->hw_cap_initialized & HW_CAP_NIC2))
+			invalid_queue = true;
 
-	case GAUDI_QUEUE_ID_NIC_5_3:
-		db_reg_offset = mmNIC2_QM1_PQ_PI_3;
+		q_off = ((hw_queue_id - 1) & 0x3) * 4;
+		db_reg_offset = mmNIC1_QM0_PQ_PI_0 + q_off;
 		break;
 
-	case GAUDI_QUEUE_ID_NIC_6_0:
-		db_reg_offset = mmNIC3_QM0_PQ_PI_0;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_6_1:
-		db_reg_offset = mmNIC3_QM0_PQ_PI_1;
-		break;
+	case GAUDI_QUEUE_ID_NIC_3_0...GAUDI_QUEUE_ID_NIC_3_3:
+		if (!(gaudi->hw_cap_initialized & HW_CAP_NIC3))
+			invalid_queue = true;
 
-	case GAUDI_QUEUE_ID_NIC_6_2:
-		db_reg_offset = mmNIC3_QM0_PQ_PI_2;
+		q_off = ((hw_queue_id - 1) & 0x3) * 4;
+		db_reg_offset = mmNIC1_QM1_PQ_PI_0 + q_off;
 		break;
 
-	case GAUDI_QUEUE_ID_NIC_6_3:
-		db_reg_offset = mmNIC3_QM0_PQ_PI_3;
-		break;
+	case GAUDI_QUEUE_ID_NIC_4_0...GAUDI_QUEUE_ID_NIC_4_3:
+		if (!(gaudi->hw_cap_initialized & HW_CAP_NIC4))
+			invalid_queue = true;
 
-	case GAUDI_QUEUE_ID_NIC_7_0:
-		db_reg_offset = mmNIC3_QM1_PQ_PI_0;
+		q_off = ((hw_queue_id - 1) & 0x3) * 4;
+		db_reg_offset = mmNIC2_QM0_PQ_PI_0 + q_off;
 		break;
 
-	case GAUDI_QUEUE_ID_NIC_7_1:
-		db_reg_offset = mmNIC3_QM1_PQ_PI_1;
-		break;
+	case GAUDI_QUEUE_ID_NIC_5_0...GAUDI_QUEUE_ID_NIC_5_3:
+		if (!(gaudi->hw_cap_initialized & HW_CAP_NIC5))
+			invalid_queue = true;
 
-	case GAUDI_QUEUE_ID_NIC_7_2:
-		db_reg_offset = mmNIC3_QM1_PQ_PI_2;
+		q_off = ((hw_queue_id - 1) & 0x3) * 4;
+		db_reg_offset = mmNIC2_QM1_PQ_PI_0 + q_off;
 		break;
 
-	case GAUDI_QUEUE_ID_NIC_7_3:
-		db_reg_offset = mmNIC3_QM1_PQ_PI_3;
-		break;
-
-	case GAUDI_QUEUE_ID_NIC_8_0:
-		db_reg_offset = mmNIC4_QM0_PQ_PI_0;
-		break;
+	case GAUDI_QUEUE_ID_NIC_6_0...GAUDI_QUEUE_ID_NIC_6_3:
+		if (!(gaudi->hw_cap_initialized & HW_CAP_NIC6))
+			invalid_queue = true;
 
-	case GAUDI_QUEUE_ID_NIC_8_1:
-		db_reg_offset = mmNIC4_QM0_PQ_PI_1;
+		q_off = ((hw_queue_id - 1) & 0x3) * 4;
+		db_reg_offset = mmNIC3_QM0_PQ_PI_0 + q_off;
 		break;
 
-	case GAUDI_QUEUE_ID_NIC_8_2:
-		db_reg_offset = mmNIC4_QM0_PQ_PI_2;
-		break;
+	case GAUDI_QUEUE_ID_NIC_7_0...GAUDI_QUEUE_ID_NIC_7_3:
+		if (!(gaudi->hw_cap_initialized & HW_CAP_NIC7))
+			invalid_queue = true;
 
-	case GAUDI_QUEUE_ID_NIC_8_3:
-		db_reg_offset = mmNIC4_QM0_PQ_PI_3;
+		q_off = ((hw_queue_id - 1) & 0x3) * 4;
+		db_reg_offset = mmNIC3_QM1_PQ_PI_0 + q_off;
 		break;
 
-	case GAUDI_QUEUE_ID_NIC_9_0:
-		db_reg_offset = mmNIC4_QM1_PQ_PI_0;
-		break;
+	case GAUDI_QUEUE_ID_NIC_8_0...GAUDI_QUEUE_ID_NIC_8_3:
+		if (!(gaudi->hw_cap_initialized & HW_CAP_NIC8))
+			invalid_queue = true;
 
-	case GAUDI_QUEUE_ID_NIC_9_1:
-		db_reg_offset = mmNIC4_QM1_PQ_PI_1;
+		q_off = ((hw_queue_id - 1) & 0x3) * 4;
+		db_reg_offset = mmNIC4_QM0_PQ_PI_0 + q_off;
 		break;
 
-	case GAUDI_QUEUE_ID_NIC_9_2:
-		db_reg_offset = mmNIC4_QM1_PQ_PI_2;
-		break;
+	case GAUDI_QUEUE_ID_NIC_9_0...GAUDI_QUEUE_ID_NIC_9_3:
+		if (!(gaudi->hw_cap_initialized & HW_CAP_NIC9))
+			invalid_queue = true;
 
-	case GAUDI_QUEUE_ID_NIC_9_3:
-		db_reg_offset = mmNIC4_QM1_PQ_PI_3;
+		q_off = ((hw_queue_id - 1) & 0x3) * 4;
+		db_reg_offset = mmNIC4_QM1_PQ_PI_0 + q_off;
 		break;
 
 	default:
-- 
2.25.1

