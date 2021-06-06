Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE0239CE15
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 10:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhFFIZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 04:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhFFIZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 04:25:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48CA9613EF;
        Sun,  6 Jun 2021 08:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622967808;
        bh=eP9lNo+PNkmlhnRtbqtVGFoEnd+hjESduemt5sa9pFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRBqPSz/fXV4AwqSWb3pjqWFpCV9yiag1Zxi80J8qvF37w0dk8QqJucMe+Y6w4rhq
         5N+ATeTVTomMc2aEVXkpFiSJwBgUgPwqhEeBeJ/st4bikMjoR9op7CjdIBR4tib6Bm
         HkwTQNb2BKMMRnw3X9EpInz8wt32fkTPVGOJoY5JdMYYsK4X+7uSeTPZGGxH8/AgJq
         uMQ4oJpr7GzTeLsqeV0/Qu+nj+QaHOcemf59ygoU/Hyy1R21ypv/EyTKJhgnW3WKWr
         OmlwaKpeCeD3eBsKW+G1/pBy/LD5XuIGb+3q+ZnV/1iMqHAT3VukvfXSUb5UmR1R0A
         8jF8eDsVGuiUw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/6] habanalabs/gaudi: add FW alive event support
Date:   Sun,  6 Jun 2021 11:23:16 +0300
Message-Id: <20210606082320.4319-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606082320.4319-1-ogabbay@kernel.org>
References: <20210606082320.4319-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order for driver to be aware of process or thread crashes inside
GAUDI's CPU, we introduce a new event which contains all relevant
information. Upon event reception, driver will dump information and
will reset the device.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c             | 15 +++++++++++++++
 drivers/misc/habanalabs/include/common/cpucp_if.h | 15 +++++++++++++++
 .../habanalabs/include/gaudi/gaudi_async_events.h |  1 +
 .../include/gaudi/gaudi_async_ids_map_extended.h  |  2 +-
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 68b1187c9c1f..9a4b0b495a29 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7451,6 +7451,16 @@ static void gaudi_print_out_of_sync_info(struct hl_device *hdev,
 			sync_err->pi, sync_err->ci, q->pi, atomic_read(&q->ci));
 }
 
+static void gaudi_print_fw_alive_info(struct hl_device *hdev,
+					struct hl_eq_fw_alive *fw_alive)
+{
+	dev_err(hdev->dev,
+		"FW alive report: severity=%s, process_id=%u, thread_id=%u, uptime=%llu seconds\n",
+		(fw_alive->severity == FW_ALIVE_SEVERITY_MINOR) ?
+		"Minor" : "Critical", fw_alive->process_id,
+		fw_alive->thread_id, fw_alive->uptime_seconds);
+}
+
 static int gaudi_soft_reset_late_init(struct hl_device *hdev)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -7905,6 +7915,11 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		gaudi_print_out_of_sync_info(hdev, &eq_entry->pkt_sync_err);
 		goto reset_device;
 
+	case GAUDI_EVENT_FW_ALIVE_S:
+		gaudi_print_irq_info(hdev, event_type, false);
+		gaudi_print_fw_alive_info(hdev, &eq_entry->fw_alive);
+		goto reset_device;
+
 	default:
 		dev_err(hdev->dev, "Received invalid H/W interrupt %d\n",
 				event_type);
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index c7da62243619..d4dc189a6c92 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -84,6 +84,20 @@ struct hl_eq_sm_sei_data {
 	__u8 pad[3];
 };
 
+enum hl_fw_alive_severity {
+	FW_ALIVE_SEVERITY_MINOR,
+	FW_ALIVE_SEVERITY_CRITICAL
+};
+
+struct hl_eq_fw_alive {
+	__le64 uptime_seconds;
+	__le32 process_id;
+	__le32 thread_id;
+	/* enum hl_fw_alive_severity */
+	__u8 severity;
+	__u8 pad[7];
+};
+
 struct hl_eq_entry {
 	struct hl_eq_header hdr;
 	union {
@@ -91,6 +105,7 @@ struct hl_eq_entry {
 		struct hl_eq_hbm_ecc_data hbm_ecc_data;
 		struct hl_eq_sm_sei_data sm_sei_data;
 		struct cpucp_pkt_sync_err pkt_sync_err;
+		struct hl_eq_fw_alive fw_alive;
 		__le64 data[7];
 	};
 };
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
index e8651abf84f2..f66c759952e4 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
@@ -303,6 +303,7 @@ enum gaudi_async_event_id {
 	GAUDI_EVENT_NIC3_QP1 = 619,
 	GAUDI_EVENT_NIC4_QP0 = 620,
 	GAUDI_EVENT_NIC4_QP1 = 621,
+	GAUDI_EVENT_FW_ALIVE_S = 645,
 	GAUDI_EVENT_DEV_RESET_REQ = 646,
 	GAUDI_EVENT_PKT_QUEUE_OUT_SYNC = 647,
 	GAUDI_EVENT_FIX_POWER_ENV_S = 658,
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
index 3dc79c131805..e87554ab0102 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
@@ -669,7 +669,7 @@ static struct gaudi_async_events_ids_map gaudi_irq_map_table[] = {
 	{ .fc_id = 642, .cpu_id = 491, .valid = 0, .name = "" },
 	{ .fc_id = 643, .cpu_id = 492, .valid = 0, .name = "" },
 	{ .fc_id = 644, .cpu_id = 493, .valid = 0, .name = "" },
-	{ .fc_id = 645, .cpu_id = 494, .valid = 0, .name = "" },
+	{ .fc_id = 645, .cpu_id = 494, .valid = 1, .name = "FW_ALIVE_S" },
 	{ .fc_id = 646, .cpu_id = 495, .valid = 1, .name = "DEV_RESET_REQ" },
 	{ .fc_id = 647, .cpu_id = 496, .valid = 1,
 		.name = "PKT_QUEUE_OUT_SYNC" },
-- 
2.25.1

