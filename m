Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38453352F99
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhDBTTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhDBTTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:19:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98B696115A;
        Fri,  2 Apr 2021 19:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617391143;
        bh=pBbpAL0/pxJzHreb6Ogp54MF5P7JUR4YWlDsr8PcI/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cx0THxPUildsqKgkpL2czO6s+0kMxfyIiiyxX1AlgM37YPrSznTevWxEezL3nCsLh
         +emxLqZC/ZndNZhbLJeUmH6nvRXj0xkseXOxlBg/L5+u6AaeYhd9xELX2q3ABL41eP
         tvY3jPB13d0N5V7u+1+kqQ2YMJxyCz7yszsZIFfe2G6vye5UCwdQKOeX5KiCd065X5
         uW9Vm+rgbp3j370mO1MDGXpRCwM6XtY4Le+sqhbwTkyXRRHjBvIg/WOzzEjrpQ9O2K
         HZ58n3ljsYP/3HxYT9iSJzlPmOS8N5nYfklPY6emLR5k+qGeGuYk/YiEIGzOTD8fAl
         lf/d18i6ZqiTw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 2/3] habanalabs/gaudi: sync stream add protection to SOB reset flow
Date:   Fri,  2 Apr 2021 22:18:55 +0300
Message-Id: <20210402191856.4849-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210402191856.4849-1-ogabbay@kernel.org>
References: <20210402191856.4849-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Since we moved the SOB reset flow to workqueue and
not part of the fence release flow, we might reach a
scenario where new context is created while we in the middle
of resetting the SOB.
in such cases the reset may fail due to idle check.
This will mess up the streams sync since the SOB value is invalid.
so we protect this area with a mutex, to delay context creation.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f273b792bc5d..bd711c8d3874 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5729,18 +5729,26 @@ static int gaudi_memset_registers(struct hl_device *hdev, u64 reg_base,
 static int gaudi_schedule_register_memset(struct hl_device *hdev,
 		u32 hw_queue_id, u64 reg_base, u32 num_regs, u32 val)
 {
-	struct hl_ctx *ctx = hdev->compute_ctx;
+	struct hl_ctx *ctx;
 	struct hl_pending_cb *pending_cb;
 	struct packet_msg_long *pkt;
 	u32 cb_size, ctl;
 	struct hl_cb *cb;
-	int i;
+	int i, rc;
+
+	mutex_lock(&hdev->fpriv_list_lock);
+	ctx = hdev->compute_ctx;
 
 	/* If no compute context available or context is going down
 	 * memset registers directly
 	 */
-	if (!ctx || kref_read(&ctx->refcount) == 0)
-		return gaudi_memset_registers(hdev, reg_base, num_regs, val);
+	if (!ctx || kref_read(&ctx->refcount) == 0) {
+		rc = gaudi_memset_registers(hdev, reg_base, num_regs, val);
+		mutex_unlock(&hdev->fpriv_list_lock);
+		return rc;
+	}
+
+	mutex_unlock(&hdev->fpriv_list_lock);
 
 	cb_size = (sizeof(*pkt) * num_regs) +
 			sizeof(struct packet_msg_prot) * 2;
-- 
2.25.1

