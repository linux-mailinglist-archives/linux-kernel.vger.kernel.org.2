Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D763E332E46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCIS2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:28:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhCIS2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:28:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3113F65062;
        Tue,  9 Mar 2021 18:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615314524;
        bh=sbBBi0k4Wj1FhEimcdyKbTBIxq93UD40dFD1AOESWpQ=;
        h=From:To:Cc:Subject:Date:From;
        b=k+pUZDmvfLEiZUNf4jsrZHtCr116WzJyJYcrq1WOPkMhT5ErB2e+9to1Qnv2RPlLf
         sKYQ7s4WJox92SYbGHmgUrrBEJ5F27Avj3SaIoV41I3bKN61JnK3phffXf3LZRWgWV
         DCQoP35jzJxZl8m5x1QdvWGhohIPwDEZE7K3UvZVZdpDruSuNZjUEP/lm4vFZ0cQIr
         eqlDn5IYW0XBNRslIonR/H7LIOJiMQrUo6OSvFUcB4s/U7FxJSsa/nFc4cwA61vKwj
         DGtP3cWoKQHnQYlthuiQAn0zNBUCczM7H1PH3AjJasjvrwVdeYsBjBTKAHzcFHFrYR
         EJy+1xiAZS3XQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs/gaudi: reset device upon BMC request
Date:   Tue,  9 Mar 2021 20:28:37 +0200
Message-Id: <20210309182838.4641-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In case the BMC of the devices' box wants to initiate a reset of
a specific device, it must go through driver.
Once driver will receive the request it will initiate a hard reset
flow.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c                         | 4 ++++
 drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h    | 1 +
 .../habanalabs/include/gaudi/gaudi_async_ids_map_extended.h   | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8be75f7c97f8..099c51350be6 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7575,6 +7575,10 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 			event_type, cause);
 		break;
 
+	case GAUDI_EVENT_BMC_RESET_CMD:
+		gaudi_print_irq_info(hdev, event_type, false);
+		goto reset_device;
+
 	case GAUDI_EVENT_PKT_QUEUE_OUT_SYNC:
 		gaudi_print_irq_info(hdev, event_type, false);
 		gaudi_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
index 0a0fa57024f8..25f835ba2cd6 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
@@ -303,6 +303,7 @@ enum gaudi_async_event_id {
 	GAUDI_EVENT_NIC3_QP1 = 619,
 	GAUDI_EVENT_NIC4_QP0 = 620,
 	GAUDI_EVENT_NIC4_QP1 = 621,
+	GAUDI_EVENT_BMC_RESET_CMD = 646,
 	GAUDI_EVENT_PKT_QUEUE_OUT_SYNC = 647,
 	GAUDI_EVENT_FIX_POWER_ENV_S = 658,
 	GAUDI_EVENT_FIX_POWER_ENV_E = 659,
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
index 9106395eb920..079be1fb8f70 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
@@ -670,7 +670,7 @@ static struct gaudi_async_events_ids_map gaudi_irq_map_table[] = {
 	{ .fc_id = 643, .cpu_id = 492, .valid = 0, .name = "" },
 	{ .fc_id = 644, .cpu_id = 493, .valid = 0, .name = "" },
 	{ .fc_id = 645, .cpu_id = 494, .valid = 0, .name = "" },
-	{ .fc_id = 646, .cpu_id = 495, .valid = 0, .name = "" },
+	{ .fc_id = 646, .cpu_id = 495, .valid = 1, .name = "BMC_RST_CMD" },
 	{ .fc_id = 647, .cpu_id = 496, .valid = 0, .name = "" },
 	{ .fc_id = 648, .cpu_id = 497, .valid = 0, .name = "" },
 	{ .fc_id = 649, .cpu_id = 498, .valid = 0, .name = "" },
-- 
2.25.1

