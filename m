Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC154475F3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbhKGUyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235763AbhKGUyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:54:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0FD8613D3;
        Sun,  7 Nov 2021 20:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636318313;
        bh=vq9Kjp3zmEiQ2kpt2OZKz3g6vApbTG08DmQFfoSveXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iR3NAr6izfAgneu7z9OmUS2imTBpPonP4TOK6t61/lYVZMAQ7QD5kWDDmVZbgNmEt
         kgm93v5sfHk2y4Dc+ltKUAycAGZATyO17d2TgdT9wI0JtwfxC9551g2uUoshJfBYLg
         mi1bUdOmRzz9zCuRzXdz4sVoFNfTAVSnu5IEteXjqOfXSUKQ0pEDKKvRK3R1/tFLqB
         DTluYg6GVmsFe0nEyun1ptIGYnr5X6vsOjgsyTwpFM6J8xfF9qduxyIm4lHCVsjqE2
         CHStkQkXiigryKavE9Z/7FZgQXIXDM0L+y3c3jCLzMq8Q101FptWa/gixh9Y6IjVp4
         VyWXfvt1CQSng==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bharat Jauhari <bjauhari@habana.ai>
Subject: [PATCH 08/10] habanalabs: refactor wait-for-user-interrupt function
Date:   Sun,  7 Nov 2021 22:51:34 +0200
Message-Id: <20211107205136.2329007-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107205136.2329007-1-ogabbay@kernel.org>
References: <20211107205136.2329007-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Jauhari <bjauhari@habana.ai>

Refactor the wait-for-user-interrupt routine to make it more
generic for re-use for other user exposed h/w interfaces in future
ASICs.

Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 54a5425a77a0..e97b21988dea 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2782,12 +2782,12 @@ static inline unsigned long hl_usecs64_to_jiffies(const u64 usecs)
 
 static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				u64 timeout_us, u64 user_address,
-				u64 target_value, u16 interrupt_offset,
+				u64 target_value, struct hl_user_interrupt *interrupt,
+
 				u32 *status,
 				u64 *timestamp)
 {
 	struct hl_user_pending_interrupt *pend;
-	struct hl_user_interrupt *interrupt;
 	unsigned long timeout, flags;
 	u64 completion_value;
 	long completion_rc;
@@ -2805,11 +2805,6 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 
 	hl_fence_init(&pend->fence, ULONG_MAX);
 
-	if (interrupt_offset == HL_COMMON_USER_INTERRUPT_ID)
-		interrupt = &hdev->common_user_interrupt;
-	else
-		interrupt = &hdev->user_interrupt[interrupt_offset];
-
 	/* Add pending user interrupt to relevant list for the interrupt
 	 * handler to monitor
 	 */
@@ -2898,9 +2893,10 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 
 static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 {
-	u16 interrupt_id, interrupt_offset, first_interrupt, last_interrupt;
+	u16 interrupt_id, first_interrupt, last_interrupt;
 	struct hl_device *hdev = hpriv->hdev;
 	struct asic_fixed_properties *prop;
+	struct hl_user_interrupt *interrupt;
 	union hl_wait_cs_args *args = data;
 	u32 status = HL_WAIT_CS_STATUS_BUSY;
 	u64 timestamp;
@@ -2913,8 +2909,7 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		return -EPERM;
 	}
 
-	interrupt_id =
-		FIELD_GET(HL_WAIT_CS_FLAGS_INTERRUPT_MASK, args->in.flags);
+	interrupt_id = FIELD_GET(HL_WAIT_CS_FLAGS_INTERRUPT_MASK, args->in.flags);
 
 	first_interrupt = prop->first_available_user_msix_interrupt;
 	last_interrupt = prop->first_available_user_msix_interrupt +
@@ -2927,15 +2922,14 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	}
 
 	if (interrupt_id == HL_COMMON_USER_INTERRUPT_ID)
-		interrupt_offset = HL_COMMON_USER_INTERRUPT_ID;
+		interrupt = &hdev->common_user_interrupt;
 	else
-		interrupt_offset = interrupt_id - first_interrupt;
+		interrupt = &hdev->user_interrupt[interrupt_id - first_interrupt];
 
 	rc = _hl_interrupt_wait_ioctl(hdev, hpriv->ctx,
 				args->in.interrupt_timeout_us, args->in.addr,
-				args->in.target, interrupt_offset, &status,
+				args->in.target, interrupt, &status,
 				&timestamp);
-
 	if (rc) {
 		if (rc != -EINTR)
 			dev_err_ratelimited(hdev->dev,
-- 
2.25.1

