Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E3460975
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358719AbhK1TkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbhK1TiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:38:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA06C061748
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 11:34:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58E8C610D5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF83C53FC7;
        Sun, 28 Nov 2021 19:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128088;
        bh=jLBvJqQalZU+NFbypANby0TYwTyJ9oIoEQ1Tvd3eMT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EvTcyJJtoayTuBVbnkRdhjkPG7R/uZPE39eiIWk/gFrVw691HC7g9v6LMu2erVBcf
         qQiZLlFFLFfIKchpTd4R/HeOc4kGKj3sa9qcFhEh2T9uVAP4cuQqZygOsMiO04vvm7
         VO4HqnJHcInkL4RtCi7T6Je59oA4NQDZdyqSYgpkp3E8bAK3wkTrOhHJDAUcY6GJPy
         GlKYI+It+yA1iI1dflx7CnQ8ULzJorLib2yfh7lcJiDhATofJ6oW6OBGtafHW5H01h
         /x8NMA/8np2wipMi+KFrSAdJKvKwehQFL+Q2Wm30KXFpd76V8csjD17hQhd2K9XbKJ
         PgDseWgsKb5wA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 07/12] habanalabs: add power information type to POWER_GET packet
Date:   Sun, 28 Nov 2021 21:34:30 +0200
Message-Id: <20211128193435.266534-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128193435.266534-1-ogabbay@kernel.org>
References: <20211128193435.266534-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

In new f/w versions, it is required to explicitly indicate the power
information type when querying the F/W for power info.
When getting the current power level it should be set to power_input.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 1 +
 include/uapi/misc/habanalabs.h               | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index cf67800f2b47..bafadcc65497 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -969,6 +969,7 @@ int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power)
 
 	pkt.ctl = cpu_to_le32(CPUCP_PACKET_POWER_GET <<
 				CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.type = CPUCP_POWER_INPUT;
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 			HL_CPUCP_INFO_TIMEOUT_USEC, &result);
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index eb8565fdae70..cd86937c572d 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -333,6 +333,7 @@ enum hl_server_type {
  * HL_INFO_SYNC_MANAGER  - Retrieve sync manager info per dcore
  * HL_INFO_TOTAL_ENERGY  - Retrieve total energy consumption
  * HL_INFO_PLL_FREQUENCY - Retrieve PLL frequency
+ * HL_INFO_POWER         - Retrieve power information
  * HL_INFO_OPEN_STATS    - Retrieve info regarding recent device open calls
  * HL_INFO_DRAM_REPLACED_ROWS - Retrieve DRAM replaced rows info
  * HL_INFO_DRAM_PENDING_ROWS - Retrieve DRAM pending rows num
-- 
2.25.1

