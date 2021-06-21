Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36423AE40A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFUH0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhFUH0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:26:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A788610CA;
        Mon, 21 Jun 2021 07:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624260256;
        bh=CN6Oa+FXCJ3UnOVWG1eNoqKiiYP4Dafu1coXFEx5B8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nO9aG5+hQuS3TfbHz10g/rqZ57sZs++3yLAYBj8pPhgpLC28UmFcqB/y0czaBMBMo
         yoEuyAZI6Nt2y6beDn0P7oAV5bwyTadGTrWvhxkbrm8JoyNFLNvo/8Os6Z4TX5IC4n
         YrLsNbJPON8W/9PGcohCDJ854M45HSpsbEWzKmvvosBClVe4xCFYLg9b78Ty31OIPa
         /JXFPiweReF01rxDq4bkGat1GwIPPISo82gmUVTSKWm8VTdQXoVWCdNVnQ4hrQBtKO
         gXpOypQdFw5ptWnwDlRPQurq42xFOuidOTVX0RRttBap+yjJUxK2w5r1rqjxW6jwOe
         zHiYibAFNWWhQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/5] habanalabs/gaudi: add support for NIC DERR
Date:   Mon, 21 Jun 2021 10:24:05 +0300
Message-Id: <20210621072406.5421-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621072406.5421-1-ogabbay@kernel.org>
References: <20210621072406.5421-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

We add support for NIC DERR ECC error events, in case this error
is received a device reset will be performed.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c             |  1 +
 .../habanalabs/include/gaudi/gaudi_async_events.h |  5 +++++
 .../include/gaudi/gaudi_async_ids_map_extended.h  | 15 ++++++++++-----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 4a75df240cfc..82d5613f291b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7870,6 +7870,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_DMA_IF0_DERR ... GAUDI_EVENT_DMA_IF3_DERR:
 	case GAUDI_EVENT_HBM_0_DERR ... GAUDI_EVENT_HBM_3_DERR:
 	case GAUDI_EVENT_MMU_DERR:
+	case GAUDI_EVENT_NIC0_CS_DBG_DERR ... GAUDI_EVENT_NIC4_CS_DBG_DERR:
 		gaudi_print_irq_info(hdev, event_type, true);
 		gaudi_handle_ecc_event(hdev, event_type, &eq_entry->ecc_data);
 		goto reset_device;
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
index 2aee18e19b5a..d966bd4dfea6 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
@@ -252,6 +252,11 @@ enum gaudi_async_event_id {
 	GAUDI_EVENT_HBM3_SPI_0 = 407,
 	GAUDI_EVENT_HBM3_SPI_1 = 408,
 	GAUDI_EVENT_PSOC_GPIO_U16_0 = 421,
+	GAUDI_EVENT_NIC0_CS_DBG_DERR = 483,
+	GAUDI_EVENT_NIC1_CS_DBG_DERR = 487,
+	GAUDI_EVENT_NIC2_CS_DBG_DERR = 491,
+	GAUDI_EVENT_NIC3_CS_DBG_DERR = 495,
+	GAUDI_EVENT_NIC4_CS_DBG_DERR = 499,
 	GAUDI_EVENT_RAZWI_OR_ADC = 548,
 	GAUDI_EVENT_TPC0_QM = 572,
 	GAUDI_EVENT_TPC1_QM = 573,
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
index ac4d4b51da7f..479b6b038254 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
@@ -507,23 +507,28 @@ static struct gaudi_async_events_ids_map gaudi_irq_map_table[] = {
 	{ .fc_id = 480, .cpu_id = 329, .valid = 0, .name = "" },
 	{ .fc_id = 481, .cpu_id = 330, .valid = 0, .name = "" },
 	{ .fc_id = 482, .cpu_id = 331, .valid = 0, .name = "" },
-	{ .fc_id = 483, .cpu_id = 332, .valid = 0, .name = "" },
+	{ .fc_id = 483, .cpu_id = 332, .valid = 1,
+		.name = "NIC0_CS_DBG_DERR" },
 	{ .fc_id = 484, .cpu_id = 333, .valid = 0, .name = "" },
 	{ .fc_id = 485, .cpu_id = 334, .valid = 0, .name = "" },
 	{ .fc_id = 486, .cpu_id = 335, .valid = 0, .name = "" },
-	{ .fc_id = 487, .cpu_id = 336, .valid = 0, .name = "" },
+	{ .fc_id = 487, .cpu_id = 336, .valid = 1,
+		.name = "NIC1_CS_DBG_DERR" },
 	{ .fc_id = 488, .cpu_id = 337, .valid = 0, .name = "" },
 	{ .fc_id = 489, .cpu_id = 338, .valid = 0, .name = "" },
 	{ .fc_id = 490, .cpu_id = 339, .valid = 0, .name = "" },
-	{ .fc_id = 491, .cpu_id = 340, .valid = 0, .name = "" },
+	{ .fc_id = 491, .cpu_id = 340, .valid = 1,
+		.name = "NIC2_CS_DBG_DERR" },
 	{ .fc_id = 492, .cpu_id = 341, .valid = 0, .name = "" },
 	{ .fc_id = 493, .cpu_id = 342, .valid = 0, .name = "" },
 	{ .fc_id = 494, .cpu_id = 343, .valid = 0, .name = "" },
-	{ .fc_id = 495, .cpu_id = 344, .valid = 0, .name = "" },
+	{ .fc_id = 495, .cpu_id = 344, .valid = 1,
+		.name = "NIC3_CS_DBG_DERR" },
 	{ .fc_id = 496, .cpu_id = 345, .valid = 0, .name = "" },
 	{ .fc_id = 497, .cpu_id = 346, .valid = 0, .name = "" },
 	{ .fc_id = 498, .cpu_id = 347, .valid = 0, .name = "" },
-	{ .fc_id = 499, .cpu_id = 348, .valid = 0, .name = "" },
+	{ .fc_id = 499, .cpu_id = 348, .valid = 1,
+		.name = "NIC4_CS_DBG_DERR" },
 	{ .fc_id = 500, .cpu_id = 349, .valid = 0, .name = "" },
 	{ .fc_id = 501, .cpu_id = 350, .valid = 0, .name = "" },
 	{ .fc_id = 502, .cpu_id = 351, .valid = 0, .name = "" },
-- 
2.25.1

