Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936CD42A5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbhJLNnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236945AbhJLNnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:43:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FC1261074;
        Tue, 12 Oct 2021 13:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634046060;
        bh=iDJjNUcv4WsQxR88J/gzb5NdchixBgTIErVD8CGqmsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXE4nWSmsq/sACz0/UgYnh31X77ivma93D7sUWx7jljbpzr09ikq1extpSM3EfziK
         /P7xzNwbyLlhnQRzXQUOmy8lcpUT+s9erLHO7qUNUBc4uCrLVvE5akMuKRVqqvhZx8
         h5Awba28OtuZtkfGFmm3M/g2WH05CRgSfC8u2MSbouNO89IdfybHqllpPMepDo20mP
         R548io4I8zApqg5WAQ8FAIEUnm15KTw7jzlPndk2YPzO9A8ygXo0US8uLPllBdyez4
         pzHtr/G0CmyuJFxRd88D/xQ6PqZnPWD+jgIZ3IaVgC6FPcdxse2jxjVwijFmTCXfum
         GrXBD/C/PwpxA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 3/3] habanalabs: simplify wait for interrupt with timestamp flow
Date:   Tue, 12 Oct 2021 16:40:51 +0300
Message-Id: <20211012134051.73555-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012134051.73555-1-ogabbay@kernel.org>
References: <20211012134051.73555-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

Remove the flag that determines whether to take a timestamp once the
interrupt arrives.
Instead, always take the timestamp once per interrupt.
This is a must for the user-space to measure its graph operations
to evaluate the graph computation time.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 11 +++++------
 drivers/misc/habanalabs/common/habanalabs.h         |  2 --
 drivers/misc/habanalabs/common/irq.c                |  4 ++--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index a3358cc3c877..f94ac2350a9b 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2768,7 +2768,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				u32 timeout_us, u64 user_address,
 				u64 target_value, u16 interrupt_offset,
 				enum hl_cs_wait_status *status,
-				bool take_timestamp, u64 *timestamp)
+				u64 *timestamp)
 {
 	struct hl_user_pending_interrupt *pend;
 	struct hl_user_interrupt *interrupt;
@@ -2792,8 +2792,6 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	hl_fence_init(&pend->fence, ULONG_MAX);
 
-	pend->fence.take_timestamp = take_timestamp;
-
 	if (interrupt_offset == HL_COMMON_USER_INTERRUPT_ID)
 		interrupt = &hdev->common_user_interrupt;
 	else
@@ -2815,9 +2813,11 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		goto remove_pending_user_interrupt;
 	}
 
-	if (completion_value >= target_value)
+	if (completion_value >= target_value) {
 		*status = CS_WAIT_STATUS_COMPLETED;
-	else
+		/* There was no interrupt, we assume the completion is now. */
+		pend->fence.timestamp = ktime_get();
+	} else
 		*status = CS_WAIT_STATUS_BUSY;
 
 	if (!timeout_us || (*status == CS_WAIT_STATUS_COMPLETED))
@@ -2914,7 +2914,6 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx,
 				args->in.interrupt_timeout_us, args->in.addr,
 				args->in.target, interrupt_offset, &status,
-				args->in.flags & HL_CS_FLAGS_TIMESTAMP,
 				&timestamp);
 
 	if (rc) {
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e7b3b121f24d..a2002cbf794b 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -615,7 +615,6 @@ struct asic_fixed_properties {
  *                         masters QIDs that multi cs is waiting on
  * @error: mark this fence with error
  * @timestamp: timestamp upon completion
- * @take_timestamp: timestamp shall be taken upon completion
  * @mcs_handling_done: indicates that corresponding command submission has
  *                     finished msc handling, this does not mean it was part
  *                     of the mcs
@@ -627,7 +626,6 @@ struct hl_fence {
 	u32			stream_master_qid_map;
 	int			error;
 	ktime_t			timestamp;
-	u8			take_timestamp;
 	u8			mcs_handling_done;
 };
 
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 0dd00ffd1809..96d82b682674 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -141,11 +141,11 @@ static void handle_user_cq(struct hl_device *hdev,
 			struct hl_user_interrupt *user_cq)
 {
 	struct hl_user_pending_interrupt *pend;
+	ktime_t now = ktime_get();
 
 	spin_lock(&user_cq->wait_list_lock);
 	list_for_each_entry(pend, &user_cq->wait_list_head, wait_list_node) {
-		if (pend->fence.take_timestamp)
-			pend->fence.timestamp = ktime_get();
+		pend->fence.timestamp = now;
 		complete_all(&pend->fence.completion);
 	}
 	spin_unlock(&user_cq->wait_list_lock);
-- 
2.17.1

