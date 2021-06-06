Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4659939CE16
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFFIZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 04:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230130AbhFFIZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 04:25:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4F0A61421;
        Sun,  6 Jun 2021 08:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622967809;
        bh=D29OERI3QjhRidHyT4QTJpvxT9t8ppExVtLgKDHmxZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbzA6vSU2N03r1oi3RLLmX32dUMtxBdgA/OPcxYngdJRDjT/DLF5B6GO6geTc7Fov
         P6QOZtHS9F7IgeALbFmsLDlAAW4gLcLsChvCMF36AUia7CduhXx/TxY9yjAnI8HJSa
         KpiVqTBZLos0e4c9vXcfOXbDnti9ZetPxHg+0ssHcwIg9RxflHSOtpANKCJ2p8rKpK
         Z0dKX2zBj5RR4EBx/682uDClbT0ZHo4SZnhNxyXSBB0vpuq3cKiwSmmoVwPf1K7tbu
         LnlG4KqO06aNb1gU9DTUYf2FwHnC3DQaU5QC6QPGXre7ErA+7wkiTb10Zi/R3No9vh
         z5sbCN82qyblw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 3/6] habanalabs: add debug flag to prevent failure on timeout
Date:   Sun,  6 Jun 2021 11:23:17 +0300
Message-Id: <20210606082320.4319-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606082320.4319-1-ogabbay@kernel.org>
References: <20210606082320.4319-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuri Nudelman <ynudelman@habana.ai>

Sometimes it is useful to allow the command to continue running despite
the timeout occurred, to differentiate between really stuck or just very
time consuming commands. This can be achieved by passing a new debug
flag alongside the cs, HL_CS_FLAGS_SKIP_RESET_ON_TIMEOUT.

Anyway, if the timeout occurred, a warning print shall be issued,
however this shall not fail the submission.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 25 +++++++++++++++----
 drivers/misc/habanalabs/common/habanalabs.h   |  5 ++++
 include/uapi/misc/habanalabs.h                |  1 +
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index ecd96fbe3150..516d190164e4 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -556,6 +556,13 @@ static void cs_do_release(struct kref *ref)
 	else if (!cs->submitted)
 		cs->fence->error = -EBUSY;
 
+	if (unlikely(cs->skip_reset_on_timeout)) {
+		dev_err(hdev->dev,
+			"Command submission %llu completed after %llu (s)\n",
+			cs->sequence,
+			(jiffies - cs->submission_time_jiffies) / HZ);
+	}
+
 	if (cs->timestamp)
 		cs->fence->timestamp = ktime_get();
 	complete_all(&cs->fence->completion);
@@ -571,6 +578,8 @@ static void cs_timedout(struct work_struct *work)
 	int rc;
 	struct hl_cs *cs = container_of(work, struct hl_cs,
 						 work_tdr.work);
+	bool skip_reset_on_timeout = cs->skip_reset_on_timeout;
+
 	rc = cs_get_unless_zero(cs);
 	if (!rc)
 		return;
@@ -581,7 +590,8 @@ static void cs_timedout(struct work_struct *work)
 	}
 
 	/* Mark the CS is timed out so we won't try to cancel its TDR */
-	cs->timedout = true;
+	if (likely(!skip_reset_on_timeout))
+		cs->timedout = true;
 
 	hdev = cs->ctx->hdev;
 
@@ -613,10 +623,12 @@ static void cs_timedout(struct work_struct *work)
 
 	cs_put(cs);
 
-	if (hdev->reset_on_lockup)
-		hl_device_reset(hdev, HL_RESET_TDR);
-	else
-		hdev->needs_reset = true;
+	if (likely(!skip_reset_on_timeout)) {
+		if (hdev->reset_on_lockup)
+			hl_device_reset(hdev, HL_RESET_TDR);
+		else
+			hdev->needs_reset = true;
+	}
 }
 
 static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
@@ -650,6 +662,9 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	cs->type = cs_type;
 	cs->timestamp = !!(flags & HL_CS_FLAGS_TIMESTAMP);
 	cs->timeout_jiffies = timeout;
+	cs->skip_reset_on_timeout =
+		!!(flags & HL_CS_FLAGS_SKIP_RESET_ON_TIMEOUT);
+	cs->submission_time_jiffies = jiffies;
 	INIT_LIST_HEAD(&cs->job_list);
 	INIT_DELAYED_WORK(&cs->work_tdr, cs_timedout);
 	kref_init(&cs->refcount);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e751868b3ed3..56d2f41f8893 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1421,6 +1421,7 @@ struct hl_userptr {
  * @staged_sequence: the sequence of the staged submission this CS is part of,
  *                   relevant only if staged_cs is set.
  * @timeout_jiffies: cs timeout in jiffies.
+ * @submission_time_jiffies: submission time of the cs
  * @type: CS_TYPE_*.
  * @submitted: true if CS was submitted to H/W.
  * @completed: true if CS was completed by device.
@@ -1433,6 +1434,8 @@ struct hl_userptr {
  * @staged_first: true if this is the first staged CS and we need to receive
  *                timeout for this CS.
  * @staged_cs: true if this CS is part of a staged submission.
+ * @skip_reset_on_timeout: true if we shall not reset the device in case
+ *                         timeout occurs (debug scenario).
  */
 struct hl_cs {
 	u16			*jobs_in_queue_cnt;
@@ -1450,6 +1453,7 @@ struct hl_cs {
 	u64			sequence;
 	u64			staged_sequence;
 	u64			timeout_jiffies;
+	u64			submission_time_jiffies;
 	enum hl_cs_type		type;
 	u8			submitted;
 	u8			completed;
@@ -1460,6 +1464,7 @@ struct hl_cs {
 	u8			staged_last;
 	u8			staged_first;
 	u8			staged_cs;
+	u8			skip_reset_on_timeout;
 };
 
 /**
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 6d2d34c9f375..a47485a8d411 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -664,6 +664,7 @@ struct hl_cs_chunk {
 #define HL_CS_FLAGS_STAGED_SUBMISSION_FIRST	0x80
 #define HL_CS_FLAGS_STAGED_SUBMISSION_LAST	0x100
 #define HL_CS_FLAGS_CUSTOM_TIMEOUT		0x200
+#define HL_CS_FLAGS_SKIP_RESET_ON_TIMEOUT	0x400
 
 #define HL_CS_STATUS_SUCCESS		0
 
-- 
2.25.1

