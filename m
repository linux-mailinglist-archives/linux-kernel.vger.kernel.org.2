Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB3233A4E9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 14:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbhCNM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 08:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235205AbhCNM7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 08:59:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE8D064EE7;
        Sun, 14 Mar 2021 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615726758;
        bh=QLzHV+oBAkg8Jg+eGDw/kc2QyoLaxRNAWpyhveCeM4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzTEIPuoAGx13HDsxgDNrWwXQ/1Mp1tJ0ncdlVcze/qmaJbH+FXERhgL1RdW2Q/BJ
         s3H7z2nkbvq7HQ0yXuAIcv6e9BwJ/77FkFtlhPdsK2kncZwIIhFjG8uM0PV1NABMd4
         6I5698jd0AVL12MvdVLdboIll3Ax5ISNBtSwOGTMYQh4WLS1zerWnww+rHtscaNwlr
         uFhkbV9ziGVaA4RnpA44NtzQB9GLH+tOa4aNzTsOOilVNWfiM8m2NfQlkBB3L3bJew
         5AQSP1No1gYqFX9CDEbZdxZx5oRpsvGYehnC4qj2XQTxSDAf6BiQMvoZqnWHyOB/53
         +8LQphRFD+aRw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/4] habanalabs/gaudi: Update async events header
Date:   Sun, 14 Mar 2021 14:59:10 +0200
Message-Id: <20210314125912.9306-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210314125912.9306-1-ogabbay@kernel.org>
References: <20210314125912.9306-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Update with latest version from the Firmware team.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c         |  2 +-
 .../include/gaudi/gaudi_async_events.h        |  2 +-
 .../gaudi/gaudi_async_ids_map_extended.h      | 35 ++++++++++++-------
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 0bcee675e1db..a65ae0dbdb92 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7574,7 +7574,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 			event_type, cause);
 		break;
 
-	case GAUDI_EVENT_BMC_RESET_CMD:
+	case GAUDI_EVENT_DEV_RESET_REQ:
 		gaudi_print_irq_info(hdev, event_type, false);
 		goto reset_device;
 
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
index 25f835ba2cd6..e8651abf84f2 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
@@ -303,7 +303,7 @@ enum gaudi_async_event_id {
 	GAUDI_EVENT_NIC3_QP1 = 619,
 	GAUDI_EVENT_NIC4_QP0 = 620,
 	GAUDI_EVENT_NIC4_QP1 = 621,
-	GAUDI_EVENT_BMC_RESET_CMD = 646,
+	GAUDI_EVENT_DEV_RESET_REQ = 646,
 	GAUDI_EVENT_PKT_QUEUE_OUT_SYNC = 647,
 	GAUDI_EVENT_FIX_POWER_ENV_S = 658,
 	GAUDI_EVENT_FIX_POWER_ENV_E = 659,
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
index 079be1fb8f70..3dc79c131805 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
@@ -670,18 +670,29 @@ static struct gaudi_async_events_ids_map gaudi_irq_map_table[] = {
 	{ .fc_id = 643, .cpu_id = 492, .valid = 0, .name = "" },
 	{ .fc_id = 644, .cpu_id = 493, .valid = 0, .name = "" },
 	{ .fc_id = 645, .cpu_id = 494, .valid = 0, .name = "" },
-	{ .fc_id = 646, .cpu_id = 495, .valid = 1, .name = "BMC_RST_CMD" },
-	{ .fc_id = 647, .cpu_id = 496, .valid = 0, .name = "" },
-	{ .fc_id = 648, .cpu_id = 497, .valid = 0, .name = "" },
-	{ .fc_id = 649, .cpu_id = 498, .valid = 0, .name = "" },
-	{ .fc_id = 650, .cpu_id = 499, .valid = 0, .name = "" },
-	{ .fc_id = 651, .cpu_id = 500, .valid = 0, .name = "" },
-	{ .fc_id = 652, .cpu_id = 501, .valid = 0, .name = "" },
-	{ .fc_id = 653, .cpu_id = 502, .valid = 0, .name = "" },
-	{ .fc_id = 654, .cpu_id = 503, .valid = 0, .name = "" },
-	{ .fc_id = 655, .cpu_id = 504, .valid = 0, .name = "" },
-	{ .fc_id = 656, .cpu_id = 505, .valid = 0, .name = "" },
-	{ .fc_id = 657, .cpu_id = 506, .valid = 1, .name = "PKT_QUEUE_ASYNC" },
+	{ .fc_id = 646, .cpu_id = 495, .valid = 1, .name = "DEV_RESET_REQ" },
+	{ .fc_id = 647, .cpu_id = 496, .valid = 1,
+		.name = "PKT_QUEUE_OUT_SYNC" },
+	{ .fc_id = 648, .cpu_id = 497, .valid = 1,
+		.name = "STATUS_NIC0_ENG0" },
+	{ .fc_id = 649, .cpu_id = 498, .valid = 1,
+		.name = "STATUS_NIC0_ENG1" },
+	{ .fc_id = 650, .cpu_id = 499, .valid = 1,
+		.name = "STATUS_NIC1_ENG0" },
+	{ .fc_id = 651, .cpu_id = 500, .valid = 1,
+		.name = "STATUS_NIC1_ENG1" },
+	{ .fc_id = 652, .cpu_id = 501, .valid = 1,
+		.name = "STATUS_NIC2_ENG0" },
+	{ .fc_id = 653, .cpu_id = 502, .valid = 1,
+		.name = "STATUS_NIC2_ENG1" },
+	{ .fc_id = 654, .cpu_id = 503, .valid = 1,
+		.name = "STATUS_NIC3_ENG0" },
+	{ .fc_id = 655, .cpu_id = 504, .valid = 1,
+		.name = "STATUS_NIC3_ENG1" },
+	{ .fc_id = 656, .cpu_id = 505, .valid = 1,
+		.name = "STATUS_NIC4_ENG0" },
+	{ .fc_id = 657, .cpu_id = 506, .valid = 1,
+		.name = "STATUS_NIC4_ENG1" },
 	{ .fc_id = 658, .cpu_id = 507, .valid = 1, .name = "FIX_POWER_ENV_S" },
 	{ .fc_id = 659, .cpu_id = 508, .valid = 1, .name = "FIX_POWER_ENV_E" },
 	{ .fc_id = 660, .cpu_id = 509, .valid = 1,
-- 
2.25.1

