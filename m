Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704FF420908
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhJDKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232785AbhJDKKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:10:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C380C6124F;
        Mon,  4 Oct 2021 10:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633342121;
        bh=V0b0sXNUzYXuYarvdgjxNIFXeF7DXJO9dNiUugr1yvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3c80/l9o7UouSvarhRk9uJDOCZa/PzxeX0XLfwC2JEIHRdWGebyRHX/mJRG76uTY
         1PgByieUst5VtWfSyJZTvz5k4SKA4TTneTSHBatimqEM9Vwh98m6ByBErVN9YPfgSI
         oMxnAwffcduSncZvwMCs5ZV0SinZ5kOwdpA5j3Q8GGs86awCMx3lBeL/t4w56kcf2b
         JKoSqcNsy2hPFIUwWz3Y50lVeLm89PZRbFP57sZLN+p5tw9cdTXRwkR+Lp9x/Zyrg8
         TgrUsdCJz8Ep+rsgr5q5YkutoCoTwjuesBIeo57UV1b9OysvfuNghnS2M36HjpG233
         GVEHSInrUUs4Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 6/6] habanalabs: take timestamp on wait for interrupt
Date:   Mon,  4 Oct 2021 13:08:30 +0300
Message-Id: <20211004100830.27573-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004100830.27573-1-ogabbay@kernel.org>
References: <20211004100830.27573-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

Taking an accurate timestamp in a close proximity of the interrupt is
required for user side statistics management.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_submission.c | 17 +++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h     |  2 ++
 drivers/misc/habanalabs/common/irq.c            |  5 ++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 44bab01cd033..4bc24852a283 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2740,7 +2740,8 @@ static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				u32 timeout_us, u64 user_address,
 				u64 target_value, u16 interrupt_offset,
-				enum hl_cs_wait_status *status)
+				enum hl_cs_wait_status *status,
+				bool take_timestamp, u64 *timestamp)
 {
 	struct hl_user_pending_interrupt *pend;
 	struct hl_user_interrupt *interrupt;
@@ -2764,6 +2765,8 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	hl_fence_init(&pend->fence, ULONG_MAX);
 
+	pend->fence.take_timestamp = take_timestamp;
+
 	if (interrupt_offset == HL_COMMON_USER_INTERRUPT_ID)
 		interrupt = &hdev->common_user_interrupt;
 	else
@@ -2838,6 +2841,8 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	list_del(&pend->wait_list_node);
 	spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 
+	*timestamp = ktime_to_ns(pend->fence.timestamp);
+
 	kfree(pend);
 	hl_ctx_put(ctx);
 
@@ -2851,6 +2856,7 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	struct asic_fixed_properties *prop;
 	union hl_wait_cs_args *args = data;
 	enum hl_cs_wait_status status;
+	u64 timestamp;
 	int rc;
 
 	prop = &hdev->asic_prop;
@@ -2880,7 +2886,9 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx,
 				args->in.interrupt_timeout_us, args->in.addr,
-				args->in.target, interrupt_offset, &status);
+				args->in.target, interrupt_offset, &status,
+				args->in.flags & HL_CS_FLAGS_TIMESTAMP,
+				&timestamp);
 
 	if (rc) {
 		if (rc != -EINTR)
@@ -2892,6 +2900,11 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	memset(args, 0, sizeof(*args));
 
+	if (timestamp) {
+		args->out.timestamp_nsec = timestamp;
+		args->out.flags |= HL_WAIT_CS_STATUS_FLAG_TIMESTAMP_VLD;
+	}
+
 	switch (status) {
 	case CS_WAIT_STATUS_COMPLETED:
 		args->out.status = HL_WAIT_CS_STATUS_COMPLETED;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 99de80915eed..2d9edd734d1c 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -601,6 +601,7 @@ struct asic_fixed_properties {
  *                         masters QIDs that multi cs is waiting on
  * @error: mark this fence with error
  * @timestamp: timestamp upon completion
+ * @take_timestamp: timestamp shall be taken upon completion
  */
 struct hl_fence {
 	struct completion	completion;
@@ -609,6 +610,7 @@ struct hl_fence {
 	u32			stream_master_qid_map;
 	int			error;
 	ktime_t			timestamp;
+	u8			take_timestamp;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 39b14a933393..0dd00ffd1809 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -143,8 +143,11 @@ static void handle_user_cq(struct hl_device *hdev,
 	struct hl_user_pending_interrupt *pend;
 
 	spin_lock(&user_cq->wait_list_lock);
-	list_for_each_entry(pend, &user_cq->wait_list_head, wait_list_node)
+	list_for_each_entry(pend, &user_cq->wait_list_head, wait_list_node) {
+		if (pend->fence.take_timestamp)
+			pend->fence.timestamp = ktime_get();
 		complete_all(&pend->fence.completion);
+	}
 	spin_unlock(&user_cq->wait_list_lock);
 }
 
-- 
2.17.1

