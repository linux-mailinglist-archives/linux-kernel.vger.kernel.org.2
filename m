Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3B73F0500
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhHRNkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:40:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237529AbhHRNkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76BB9610CE;
        Wed, 18 Aug 2021 13:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293976;
        bh=bYtK85Ar8Rnqb60iBGp2jrfPZCIA+ez9qs4tR2hHyho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZdL3IkZ/qYvr2fe0zMuo1TUN39a4DkC0RXaGQQEcwW51YMz2xPmzjUirBoqTKU0u
         fcUfOVlFkb95Qg4BrhkL//W9vYGn/BWGwq/6mEh1jufe0K7LtrE0pNWTfAAfUoswbb
         EuGbxcogV4lPE8uyQScwA8A2UJKjAp50PfcLag4JhxHH3VPlVjyCO3LiJNO04jLimK
         b9bPocHAUXlMkezfEhP1q1/ciA/GIR/hvpbR9NBeiPS7HAhSywVtm667kUn1dyPbXi
         1Il4102VZDnPN2j+XDb8WS2mnXN4a/pyKm3Zz5fo/qXmHDpqvVcu4Nn3jkbbBcCUOu
         7vqUDtFzwMzjA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH 09/16] habanalabs/gaudi: add monitored SOBs to state dump
Date:   Wed, 18 Aug 2021 16:39:15 +0300
Message-Id: <20210818133922.63637-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

Current "state dump" is lacking of monitored SOB IDs. Add for
convenience.

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c  | 38 ++++++++++++++++++++++++--
 drivers/misc/habanalabs/gaudi/gaudiP.h |  1 +
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index e9a8ed96fe65..d18a1ab42897 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -108,6 +108,8 @@
 
 #define BIN_REG_STRING_SIZE	sizeof("0b10101010101010101010101010101010")
 
+#define MONITOR_SOB_STRING_SIZE		256
+
 static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
 		"gaudi cq 0_0", "gaudi cq 0_1", "gaudi cq 0_2", "gaudi cq 0_3",
 		"gaudi cq 1_0", "gaudi cq 1_1", "gaudi cq 1_2", "gaudi cq 1_3",
@@ -9185,6 +9187,34 @@ static int gaudi_monitor_valid(struct hl_mon_state_dump *mon)
 		mon->status);
 }
 
+static void gaudi_fill_sobs_from_mon(char *sobs, struct hl_mon_state_dump *mon)
+{
+	const size_t max_write = 10;
+	u32 gid, mask, sob;
+	int i, offset;
+
+	/* Sync object ID is calculated as follows:
+	 * (8 * group_id + cleared bits in mask)
+	 */
+	gid = FIELD_GET(SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_SID_MASK,
+			mon->arm_data);
+	mask = FIELD_GET(SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_MASK_MASK,
+			mon->arm_data);
+
+	for (i = 0, offset = 0; mask && offset < MONITOR_SOB_STRING_SIZE -
+		max_write; mask >>= 1, i++) {
+		if (!(mask & 1)) {
+			sob = gid * MONITOR_MAX_SOBS + i;
+
+			if (offset > 0)
+				offset += snprintf(sobs + offset, max_write,
+							", ");
+
+			offset += snprintf(sobs + offset, max_write, "%u", sob);
+		}
+	}
+}
+
 static int gaudi_print_single_monitor(char **buf, size_t *size, size_t *offset,
 				struct hl_device *hdev,
 				struct hl_mon_state_dump *mon)
@@ -9192,14 +9222,17 @@ static int gaudi_print_single_monitor(char **buf, size_t *size, size_t *offset,
 	const char *name;
 	char scratch_buf1[BIN_REG_STRING_SIZE],
 		scratch_buf2[BIN_REG_STRING_SIZE];
+	char monitored_sobs[MONITOR_SOB_STRING_SIZE] = {0};
 
 	name = hl_state_dump_get_monitor_name(hdev, mon);
 	if (!name)
 		name = "";
 
+	gaudi_fill_sobs_from_mon(monitored_sobs, mon);
+
 	return hl_snprintf_resize(
 		buf, size, offset,
-		"Mon id: %u%s, wait for group id: %u mask %s to reach val: %u and write %u to address 0x%llx. Pending: %s",
+		"Mon id: %u%s, wait for group id: %u mask %s to reach val: %u and write %u to address 0x%llx. Pending: %s. Means sync objects [%s] are being monitored.",
 		mon->id, name,
 		FIELD_GET(SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_ARM_0_SID_MASK,
 				mon->arm_data),
@@ -9216,7 +9249,8 @@ static int gaudi_print_single_monitor(char **buf, size_t *size, size_t *offset,
 			scratch_buf2, sizeof(scratch_buf2),
 			FIELD_GET(
 				SYNC_MNGR_W_S_SYNC_MNGR_OBJS_MON_STATUS_0_PENDING_MASK,
-				mon->status)));
+				mon->status)),
+		monitored_sobs);
 }
 
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 838e98b0d43d..eacc5eadda97 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -117,6 +117,7 @@
 	(((mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_STATUS_511 - \
 	mmSYNC_MNGR_E_N_SYNC_MNGR_OBJS_MON_STATUS_0) + 4) >> 2)
 
+#define MONITOR_MAX_SOBS	8
 
 /* DRAM Memory Map */
 
-- 
2.17.1

