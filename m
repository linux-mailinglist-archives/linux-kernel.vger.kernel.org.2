Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5423460976
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359001AbhK1TkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:40:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35520 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbhK1TiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:38:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 983A4B80D61
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758F6C004E1;
        Sun, 28 Nov 2021 19:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128087;
        bh=tFxOMmND0DJxcYyO7BlQLGYe7RyCUiX+jRj46tgyJbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcQzJywFSdievqgJXc2MJs7Yb1kqXAbsWXGqT8ZpM+VeOYh2LHEpkFkxF/geStwig
         R/2Lqnq5jtJNX2J4N/6Hu+gia2ZOCItOfEBV0DoDe+jhhKb0bIa+Q+alsfdoKt9opw
         9GycclgazSZkvtWqUCZLKhr0HOiLDluA0Tj7YmzLvdWGCSoW2fMGMDZC8BNIHYTmpC
         i3+0O2LzPWWhl9hpPiRIFSOaZO033NfLKtF0EGJuezukFv2/bPoiuWX/pjiiAF5u0R
         2JwplzIsQx2CBUmtgJmXa9Lc6N5tLQvjC2JqATWMDJf511vim/ShjVcPbr/EST4XxS
         WIUD4AW68/szQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 06/12] habanalabs: add more info ioctls support during reset
Date:   Sun, 28 Nov 2021 21:34:29 +0200
Message-Id: <20211128193435.266534-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128193435.266534-1-ogabbay@kernel.org>
References: <20211128193435.266534-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Some info ioctls can be served even if the device is disabled or
in reset. Hence, we enable more info ioctls during reset, as these
ioctls do not require any H/W nor F/W communication.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/habanalabs_ioctl.c | 55 +++++++++----------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 360a1e9bbd5d..15797d55b4e8 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -614,6 +614,33 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_RESET_COUNT:
 		return get_reset_count(hdev, args);
 
+	case HL_INFO_HW_EVENTS:
+		return hw_events_info(hdev, false, args);
+
+	case HL_INFO_HW_EVENTS_AGGREGATE:
+		return hw_events_info(hdev, true, args);
+
+	case HL_INFO_CS_COUNTERS:
+		return cs_counters_info(hpriv, args);
+
+	case HL_INFO_CLK_THROTTLE_REASON:
+		return clk_throttle_info(hpriv, args);
+
+	case HL_INFO_SYNC_MANAGER:
+		return sync_manager_info(hpriv, args);
+
+	case HL_INFO_OPEN_STATS:
+		return open_stats_info(hpriv, args);
+
+	case HL_INFO_LAST_ERR_OPEN_DEV_TIME:
+		return last_err_open_dev_info(hpriv, args);
+
+	case HL_INFO_CS_TIMEOUT_EVENT:
+		return cs_timeout_info(hpriv, args);
+
+	case HL_INFO_RAZWI_EVENT:
+		return razwi_info(hpriv, args);
+
 	default:
 		break;
 	}
@@ -626,10 +653,6 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	}
 
 	switch (args->op) {
-	case HL_INFO_HW_EVENTS:
-		rc = hw_events_info(hdev, false, args);
-		break;
-
 	case HL_INFO_DRAM_USAGE:
 		rc = dram_usage_info(hpriv, args);
 		break;
@@ -642,10 +665,6 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 		rc = device_utilization(hdev, args);
 		break;
 
-	case HL_INFO_HW_EVENTS_AGGREGATE:
-		rc = hw_events_info(hdev, true, args);
-		break;
-
 	case HL_INFO_CLK_RATE:
 		rc = get_clk_rate(hdev, args);
 		break;
@@ -653,18 +672,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_TIME_SYNC:
 		return time_sync_info(hdev, args);
 
-	case HL_INFO_CS_COUNTERS:
-		return cs_counters_info(hpriv, args);
-
 	case HL_INFO_PCI_COUNTERS:
 		return pci_counters_info(hpriv, args);
 
-	case HL_INFO_CLK_THROTTLE_REASON:
-		return clk_throttle_info(hpriv, args);
-
-	case HL_INFO_SYNC_MANAGER:
-		return sync_manager_info(hpriv, args);
-
 	case HL_INFO_TOTAL_ENERGY:
 		return total_energy_consumption_info(hpriv, args);
 
@@ -674,8 +684,6 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_POWER:
 		return power_info(hpriv, args);
 
-	case HL_INFO_OPEN_STATS:
-		return open_stats_info(hpriv, args);
 
 	case HL_INFO_DRAM_REPLACED_ROWS:
 		return dram_replaced_rows_info(hpriv, args);
@@ -683,15 +691,6 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_DRAM_PENDING_ROWS:
 		return dram_pending_rows_info(hpriv, args);
 
-	case HL_INFO_LAST_ERR_OPEN_DEV_TIME:
-		return last_err_open_dev_info(hpriv, args);
-
-	case HL_INFO_CS_TIMEOUT_EVENT:
-		return cs_timeout_info(hpriv, args);
-
-	case HL_INFO_RAZWI_EVENT:
-		return razwi_info(hpriv, args);
-
 	default:
 		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
-- 
2.25.1

