Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43BC4475ED
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhKGUy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:54:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235705AbhKGUy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:54:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 477BB61458;
        Sun,  7 Nov 2021 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636318304;
        bh=22k2KPrA1Ke65OXLDFLYegjQ2DFK4DNdMULXd8ov5Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISUIsQERVQq26uoI1RcO5cgSMq1Tr4YJcHIKiQXK4KlNVXjDvWzP7ThKRM1LcpJm1
         k31STVSD3Be5vRb1qfzYeb3lQDIb3ORv5qVHiVNTD+FDfAf/NOObw0FxKrgNjVMojj
         LwW3STKrVuYFeaYCM8dFRAGCL3COeaIVcb4Xt/pk/DbP+xFRrIYkj1H4JKtKuJrPnX
         ldrOzmC6+Esrann9CgMCwzTnGSeuxO6Shj2Aj1qrABx8nPgs93+cneTI6zPovV/3Er
         3snKgdMOuzZSwA0azqXoTZ8FeNQ00tN2K8sdvMGNm+OcPzyzU9F9Wguy5fKdvP+jmL
         mVXGjdIsY65LA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bharat Jauhari <bjauhari@habana.ai>
Subject: [PATCH 02/10] habanalabs: handle abort scenario for user interrupt
Date:   Sun,  7 Nov 2021 22:51:28 +0200
Message-Id: <20211107205136.2329007-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107205136.2329007-1-ogabbay@kernel.org>
References: <20211107205136.2329007-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Jauhari <bjauhari@habana.ai>

In case of device reset, the driver does a force trigger on all waiting
users to release them from waiting. However, the driver does not handle
error scenario while waiting.

hl_interrupt_wait_ioctl() now exits the wait in case of an error with
abort status.

Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 34 +++++++++----------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 4c8000fd246c..41b48929cd59 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2768,7 +2768,7 @@ static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				u32 timeout_us, u64 user_address,
 				u64 target_value, u16 interrupt_offset,
-				enum hl_cs_wait_status *status,
+				u32 *status,
 				u64 *timestamp)
 {
 	struct hl_user_pending_interrupt *pend;
@@ -2815,13 +2815,14 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	}
 
 	if (completion_value >= target_value) {
-		*status = CS_WAIT_STATUS_COMPLETED;
+		*status = HL_WAIT_CS_STATUS_COMPLETED;
 		/* There was no interrupt, we assume the completion is now. */
 		pend->fence.timestamp = ktime_get();
-	} else
-		*status = CS_WAIT_STATUS_BUSY;
+	} else {
+		*status = HL_WAIT_CS_STATUS_BUSY;
+	}
 
-	if (!timeout_us || (*status == CS_WAIT_STATUS_COMPLETED))
+	if (!timeout_us || (*status == HL_WAIT_CS_STATUS_COMPLETED))
 		goto remove_pending_user_interrupt;
 
 wait_again:
@@ -2850,7 +2851,13 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		}
 
 		if (completion_value >= target_value) {
-			*status = CS_WAIT_STATUS_COMPLETED;
+			*status = HL_WAIT_CS_STATUS_COMPLETED;
+		} else if (pend->fence.error) {
+			dev_err_ratelimited(hdev->dev,
+				"interrupt based wait ioctl aborted(error:%d) due to a reset cycle initiated\n",
+				pend->fence.error);
+			/* set the command completion status as ABORTED */
+			*status = HL_WAIT_CS_STATUS_ABORTED;
 		} else {
 			timeout = completion_rc;
 			goto wait_again;
@@ -2861,7 +2868,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 			interrupt->interrupt_id);
 		rc = -EINTR;
 	} else {
-		*status = CS_WAIT_STATUS_BUSY;
+		*status = HL_WAIT_CS_STATUS_BUSY;
 	}
 
 remove_pending_user_interrupt:
@@ -2883,7 +2890,7 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	struct hl_device *hdev = hpriv->hdev;
 	struct asic_fixed_properties *prop;
 	union hl_wait_cs_args *args = data;
-	enum hl_cs_wait_status status;
+	u32 status = HL_WAIT_CS_STATUS_BUSY;
 	u64 timestamp;
 	int rc;
 
@@ -2926,22 +2933,13 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	}
 
 	memset(args, 0, sizeof(*args));
+	args->out.status = status;
 
 	if (timestamp) {
 		args->out.timestamp_nsec = timestamp;
 		args->out.flags |= HL_WAIT_CS_STATUS_FLAG_TIMESTAMP_VLD;
 	}
 
-	switch (status) {
-	case CS_WAIT_STATUS_COMPLETED:
-		args->out.status = HL_WAIT_CS_STATUS_COMPLETED;
-		break;
-	case CS_WAIT_STATUS_BUSY:
-	default:
-		args->out.status = HL_WAIT_CS_STATUS_BUSY;
-		break;
-	}
-
 	return 0;
 }
 
-- 
2.25.1

