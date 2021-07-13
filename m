Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B53C6BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhGMHz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234267AbhGMHzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:55:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD71561026
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626162752;
        bh=2CWrMgklscnQDJ8TgwKAh10bY/ZPFyhy4QcGwRmaixY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i1SBNqeXjp4P9Uen4lLtKYHx2WbHMviKJv2wJ7H/wSgX+GEpKnBSsjxlrLV7hW9rm
         2zMyio4oQeyAqpX9smGgW1Vj34POtReJI+nH8NKTBIlD8vSALcZMoZnCjXchL7f83T
         VXuUZrazzKb88U9JZ1DyztFaA3maFX3VdyB86GVNfk4lPAhVo8im2qsSkolHUvqPY6
         JtxmMuC3IsWy1BWrTkDL4FYn05jE+AINavg91Hi3Xw182j3cJnVwVxCEhY65Nr4ABI
         ntMUCMastiR9NZJodAbMmFHkIOCa0+S9mvj2ozKtI79nyLtcnwsuiO49tCJd21TYvc
         qEm5a/+X5Ac4Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] habanalabs/gaudi: fix information printed on SM event
Date:   Tue, 13 Jul 2021 10:52:17 +0300
Message-Id: <20210713075226.11094-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713075226.11094-1-ogabbay@kernel.org>
References: <20210713075226.11094-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the SM name instead of index because it is more informational for
the user to know the SM name instead of id when a SM interrupt occurs.

In addition, the index that is printed is of the SOB group, not
a specific SOB.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 34 ++++++++++++++++++---------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 6cbedeee15d1..561485dcddaf 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -430,8 +430,14 @@ static s64 gaudi_state_dump_specs_props[] = {
 	[SP_NUM_CORES] = 1,
 };
 
+/* The order here is opposite to the order of the indexing in the h/w.
+ * i.e. SYNC_MGR_W_S is actually 0, SYNC_MGR_E_S is 1, etc.
+ */
 static const char * const gaudi_sync_manager_names[] = {
-	"SYNC_MGR_E_N", "SYNC_MGR_W_N", "SYNC_MGR_E_S", "SYNC_MGR_W_S",
+	"SYNC_MGR_E_N",
+	"SYNC_MGR_W_N",
+	"SYNC_MGR_E_S",
+	"SYNC_MGR_W_S",
 	NULL
 };
 
@@ -7414,24 +7420,30 @@ static void gaudi_print_sm_sei_info(struct hl_device *hdev, u16 event_type,
 {
 	u32 index = event_type - GAUDI_EVENT_DMA_IF_SEI_0;
 
+	/* Flip the bits as the enum is ordered in the opposite way */
+	index = (index ^ 0x3) & 0x3;
+
 	switch (sei_data->sei_cause) {
 	case SM_SEI_SO_OVERFLOW:
-		dev_err(hdev->dev,
-			"SM %u SEI Error: SO %u overflow/underflow",
-			index, le32_to_cpu(sei_data->sei_log));
+		dev_err_ratelimited(hdev->dev,
+			"%s SEI Error: SOB Group %u overflow/underflow",
+			gaudi_sync_manager_names[index],
+			le32_to_cpu(sei_data->sei_log));
 		break;
 	case SM_SEI_LBW_4B_UNALIGNED:
-		dev_err(hdev->dev,
-			"SM %u SEI Error: Unaligned 4B LBW access, monitor agent address low - %#x",
-			index, le32_to_cpu(sei_data->sei_log));
+		dev_err_ratelimited(hdev->dev,
+			"%s SEI Error: Unaligned 4B LBW access, monitor agent address low - %#x",
+			gaudi_sync_manager_names[index],
+			le32_to_cpu(sei_data->sei_log));
 		break;
 	case SM_SEI_AXI_RESPONSE_ERR:
-		dev_err(hdev->dev,
-			"SM %u SEI Error: AXI ID %u response error",
-			index, le32_to_cpu(sei_data->sei_log));
+		dev_err_ratelimited(hdev->dev,
+			"%s SEI Error: AXI ID %u response error",
+			gaudi_sync_manager_names[index],
+			le32_to_cpu(sei_data->sei_log));
 		break;
 	default:
-		dev_err(hdev->dev, "Unknown SM SEI cause %u",
+		dev_err_ratelimited(hdev->dev, "Unknown SM SEI cause %u",
 				le32_to_cpu(sei_data->sei_log));
 		break;
 	}
-- 
2.25.1

