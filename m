Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF43C6BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhGMHzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:55:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234501AbhGMHz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:55:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A051F61284;
        Tue, 13 Jul 2021 07:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626162758;
        bh=TQ6sdhWKe+kNChpuWxEyKEy/4NJ3fXPkXqhiSFmQ9ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gF1ngwHNhyF9D1UpWT79jLRS0iLiNJDJXW4uwus4HOE7WULVxZd3tKolYVN+15WMx
         ncg0TcGmILJwNkFaJdDeDWEPRpeNA/nsN7Ub/3UT5j9eHrWNUv4Tb3zSvYokNrzPX4
         07OTBcjgY0eb1XXzWrCcNbL89NMgz26ysICjLY9Wx+MWcU5ewvy+wI4lITWtHC5Iaa
         0lKQFXV8IRRbNM4h2L/3vSKtMrL477cXeBvKeklJKef0KF0BulEUnLqpRK3qRdYEM+
         ybMA17larE75O1xSVVff7CXy6UWYc5DqY4tZAdXfWKxaA7XAp1YJFNncU7p8ZUOWbr
         NP10UY/Thc6Qg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 07/11] habanalabs: get multiple fences under same cs_lock
Date:   Tue, 13 Jul 2021 10:52:22 +0300
Message-Id: <20210713075226.11094-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713075226.11094-1-ogabbay@kernel.org>
References: <20210713075226.11094-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

To add proper support for wait-for-multi-CS, locking the CS lock
for each CS fence in the list is not efficient.

Instead, this patch add support to lock the CS lock once to get all
required fences.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 108 +++++++++++-------
 drivers/misc/habanalabs/common/context.c      |  53 +++++++--
 drivers/misc/habanalabs/common/habanalabs.h   |   3 +
 3 files changed, 113 insertions(+), 51 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index a0846880400c..b373a52a47a7 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -152,8 +152,17 @@ static void hl_fence_release(struct kref *kref)
 
 void hl_fence_put(struct hl_fence *fence)
 {
-	if (fence)
-		kref_put(&fence->refcount, hl_fence_release);
+	if (IS_ERR_OR_NULL(fence))
+		return;
+	kref_put(&fence->refcount, hl_fence_release);
+}
+
+void hl_fences_put(struct hl_fence **fence, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++, fence++)
+		hl_fence_put(*fence);
 }
 
 void hl_fence_get(struct hl_fence *fence)
@@ -1896,61 +1905,76 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	return rc;
 }
 
-static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
-				u64 timeout_us, u64 seq,
-				enum hl_cs_wait_status *status, s64 *timestamp)
+static int hl_wait_for_fence(struct hl_ctx *ctx, u64 seq, struct hl_fence *fence,
+				enum hl_cs_wait_status *status, u64 timeout_us,
+				s64 *timestamp)
 {
-	struct hl_fence *fence;
-	unsigned long timeout;
-	int rc = 0;
+	struct hl_device *hdev = ctx->hdev;
 	long completion_rc;
+	int rc = 0;
 
-	if (timestamp)
-		*timestamp = 0;
-
-	if (timeout_us == MAX_SCHEDULE_TIMEOUT)
-		timeout = timeout_us;
-	else
-		timeout = usecs_to_jiffies(timeout_us);
-
-	hl_ctx_get(hdev, ctx);
-
-	fence = hl_ctx_get_fence(ctx, seq);
 	if (IS_ERR(fence)) {
 		rc = PTR_ERR(fence);
 		if (rc == -EINVAL)
 			dev_notice_ratelimited(hdev->dev,
 				"Can't wait on CS %llu because current CS is at seq %llu\n",
 				seq, ctx->cs_sequence);
-	} else if (fence) {
-		if (!timeout_us)
-			completion_rc = completion_done(&fence->completion);
-		else
-			completion_rc =
-				wait_for_completion_interruptible_timeout(
-					&fence->completion, timeout);
-
-		if (completion_rc > 0) {
-			*status = CS_WAIT_STATUS_COMPLETED;
-			if (timestamp)
-				*timestamp = ktime_to_ns(fence->timestamp);
-		} else {
-			*status = CS_WAIT_STATUS_BUSY;
-		}
-
-		if (fence->error == -ETIMEDOUT)
-			rc = -ETIMEDOUT;
-		else if (fence->error == -EIO)
-			rc = -EIO;
+		return rc;
+	}
 
-		hl_fence_put(fence);
-	} else {
+	if (!fence) {
 		dev_dbg(hdev->dev,
 			"Can't wait on seq %llu because current CS is at seq %llu (Fence is gone)\n",
-			seq, ctx->cs_sequence);
+				seq, ctx->cs_sequence);
+
 		*status = CS_WAIT_STATUS_GONE;
+		return 0;
+	}
+
+	if (!timeout_us) {
+		completion_rc = completion_done(&fence->completion);
+	} else {
+		unsigned long timeout;
+
+		timeout = (timeout_us == MAX_SCHEDULE_TIMEOUT) ?
+				timeout_us : usecs_to_jiffies(timeout_us);
+		completion_rc =
+			wait_for_completion_interruptible_timeout(
+				&fence->completion, timeout);
 	}
 
+	if (completion_rc > 0) {
+		*status = CS_WAIT_STATUS_COMPLETED;
+		if (timestamp)
+			*timestamp = ktime_to_ns(fence->timestamp);
+	} else {
+		*status = CS_WAIT_STATUS_BUSY;
+	}
+
+	if (fence->error == -ETIMEDOUT)
+		rc = -ETIMEDOUT;
+	else if (fence->error == -EIO)
+		rc = -EIO;
+
+	return rc;
+}
+
+static int _hl_cs_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
+				u64 timeout_us, u64 seq,
+				enum hl_cs_wait_status *status, s64 *timestamp)
+{
+	struct hl_fence *fence;
+	int rc = 0;
+
+	if (timestamp)
+		*timestamp = 0;
+
+	hl_ctx_get(hdev, ctx);
+
+	fence = hl_ctx_get_fence(ctx, seq);
+
+	rc = hl_wait_for_fence(ctx, seq, fence, status, timeout_us, timestamp);
+	hl_fence_put(fence);
 	hl_ctx_put(ctx);
 
 	return rc;
diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 19b6b045219e..1001c65c5e7a 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -229,31 +229,66 @@ int hl_ctx_put(struct hl_ctx *ctx)
 	return kref_put(&ctx->refcount, hl_ctx_do_release);
 }
 
-struct hl_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
+/* this function shall be called with cs_lock locked */
+static struct hl_fence *hl_ctx_get_fence_locked(struct hl_ctx *ctx, u64 seq)
 {
 	struct asic_fixed_properties *asic_prop = &ctx->hdev->asic_prop;
 	struct hl_fence *fence;
 
-	spin_lock(&ctx->cs_lock);
-
-	if (seq >= ctx->cs_sequence) {
-		spin_unlock(&ctx->cs_lock);
+	if (seq >= ctx->cs_sequence)
 		return ERR_PTR(-EINVAL);
-	}
 
-	if (seq + asic_prop->max_pending_cs < ctx->cs_sequence) {
-		spin_unlock(&ctx->cs_lock);
+	if (seq + asic_prop->max_pending_cs < ctx->cs_sequence)
 		return NULL;
-	}
 
 	fence = ctx->cs_pending[seq & (asic_prop->max_pending_cs - 1)];
 	hl_fence_get(fence);
+	return fence;
+}
+
+struct hl_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq)
+{
+	struct hl_fence *fence;
+
+	spin_lock(&ctx->cs_lock);
+
+	fence = hl_ctx_get_fence_locked(ctx, seq);
 
 	spin_unlock(&ctx->cs_lock);
 
 	return fence;
 }
 
+int hl_ctx_get_fences(struct hl_ctx *ctx, u64 *seq_arr,
+				struct hl_fence **fence, u32 arr_len)
+{
+	struct hl_fence **fence_arr_base = fence;
+	int i, rc = 0;
+
+	spin_lock(&ctx->cs_lock);
+
+	for (i = 0; i < arr_len; i++, fence++) {
+		u64 seq = seq_arr[i];
+
+		*fence = hl_ctx_get_fence_locked(ctx, seq);
+
+		if (IS_ERR(*fence)) {
+			dev_err(ctx->hdev->dev,
+				"Failed to get fence for CS with seq 0x%llx\n",
+					seq);
+			rc = PTR_ERR(*fence);
+			break;
+		}
+	}
+
+	spin_unlock(&ctx->cs_lock);
+
+	if (rc)
+		hl_fences_put(fence_arr_base, i);
+
+	return rc;
+}
+
 /*
  * hl_ctx_mgr_init - initialize the context manager
  *
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index a0f3c580b58b..26f75d070f72 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2645,6 +2645,8 @@ void hl_ctx_do_release(struct kref *ref);
 void hl_ctx_get(struct hl_device *hdev,	struct hl_ctx *ctx);
 int hl_ctx_put(struct hl_ctx *ctx);
 struct hl_fence *hl_ctx_get_fence(struct hl_ctx *ctx, u64 seq);
+int hl_ctx_get_fences(struct hl_ctx *ctx, u64 *seq_arr,
+				struct hl_fence **fence, u32 arr_len);
 void hl_ctx_mgr_init(struct hl_ctx_mgr *mgr);
 void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr);
 
@@ -2692,6 +2694,7 @@ struct hl_cs_job *hl_cs_allocate_job(struct hl_device *hdev,
 void hl_sob_reset_error(struct kref *ref);
 int hl_gen_sob_mask(u16 sob_base, u8 sob_mask, u8 *mask);
 void hl_fence_put(struct hl_fence *fence);
+void hl_fences_put(struct hl_fence **fence, int len);
 void hl_fence_get(struct hl_fence *fence);
 void cs_get(struct hl_cs *cs);
 bool cs_needs_completion(struct hl_cs *cs);
-- 
2.25.1

