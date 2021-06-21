Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4C73AE409
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 09:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFUH0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 03:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhFUH02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:26:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DA2E611CC;
        Mon, 21 Jun 2021 07:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624260255;
        bh=guGaTaMt7FEUOi+6sJH+NPVEBa+SLkGBmP9/UlzP+Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMR1zHyqxPLIZRaYyDJW2QRzHa0A9F9vt9tr9rGSTk0ehUx1mLpHdLXRe7BMEuw11
         uXBZAo3twHporaBtYY3NaKl4TkFvyie+A6dqdylsCYT0lU8Bq8q3gG80ytLwvFC3XR
         rl5qZI0ZUORAD1Ixp+gRQ4iHKKxipWSLBwRZIgEcOgt2CBGRCzJP1el72egZfeVQDf
         ZGN+ps/OA1PfIDd1vHPBO+8BFWQUzTfWJmYb625dHxPl20eSnFwL0bQWHvDCccnlsX
         JTIch5CEntqGnYxUXTiEQBd5S3hB9fFITNQOW2PL+VzxvAwKP43lndlS2ZJbKVBou2
         LAf9zkpN01s+Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 3/5] habanalabs: add validity check for signal cs
Date:   Mon, 21 Jun 2021 10:24:04 +0300
Message-Id: <20210621072406.5421-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210621072406.5421-1-ogabbay@kernel.org>
References: <20210621072406.5421-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

In preparation for a new feature that allows the user to reserve
signals ahead of submissions, we need to change a current assumption
in the code.

Currently, the driver uses 2 SOBs to support signal CS. When the first
SOB reaches max value, the driver switches to the other one and assumes
that when it will need to switch back to the first one, all of the
signals have already been handled.

This assumption won't hold when the new feature will be added, because
using signal reservation, the driver can reach the max SOB value very
fast.

The change is to add a validity check when submitting a signal CS, to
make sure the previous SOB is available (all the signals attached to
it indeed finished).

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 55 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  2 +
 drivers/misc/habanalabs/common/hw_queue.c     | 42 ++++++--------
 3 files changed, 75 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index adedb288d452..80c60fb41bbc 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1497,6 +1497,61 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 	return rc;
 }
 
+/*
+ * hl_cs_signal_sob_wraparound_handler: handle SOB value wrapaound case.
+ * if the SOB value reaches the max value move to the other SOB reserved
+ * to the queue.
+ * Note that this function must be called while hw_queues_lock is taken.
+ */
+int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
+			struct hl_hw_sob **hw_sob, u32 count)
+{
+	struct hl_sync_stream_properties *prop;
+	struct hl_hw_sob *sob = *hw_sob, *other_sob;
+	u8 other_sob_offset;
+
+	prop = &hdev->kernel_queues[q_idx].sync_stream_prop;
+
+	kref_get(&sob->kref);
+
+	/* check for wraparound */
+	if (prop->next_sob_val + count >= HL_MAX_SOB_VAL) {
+		/*
+		 * Decrement as we reached the max value.
+		 * The release function won't be called here as we've
+		 * just incremented the refcount right before calling this
+		 * function.
+		 */
+		kref_put(&sob->kref, hl_sob_reset_error);
+
+		/*
+		 * check the other sob value, if it still in use then fail
+		 * otherwise make the switch
+		 */
+		other_sob_offset = (prop->curr_sob_offset + 1) % HL_RSVD_SOBS;
+		other_sob = &prop->hw_sob[other_sob_offset];
+
+		if (kref_read(&other_sob->kref) != 1) {
+			dev_err(hdev->dev, "error: Cannot switch SOBs q_idx: %d\n",
+								q_idx);
+			return -EINVAL;
+		}
+
+		prop->next_sob_val = 1;
+
+		/* only two SOBs are currently in use */
+		prop->curr_sob_offset = other_sob_offset;
+		*hw_sob = other_sob;
+
+		dev_dbg(hdev->dev, "switched to SOB %d, q_idx: %d\n",
+				prop->curr_sob_offset, q_idx);
+	} else {
+		prop->next_sob_val += count;
+	}
+
+	return 0;
+}
+
 static int cs_ioctl_extract_signal_seq(struct hl_device *hdev,
 		struct hl_cs_chunk *chunk, u64 *signal_seq, struct hl_ctx *ctx)
 {
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index fad112a01009..98aa8524a6a6 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2642,6 +2642,8 @@ int hl_set_voltage(struct hl_device *hdev,
 int hl_set_current(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
 void hl_release_pending_user_interrupts(struct hl_device *hdev);
+int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
+			struct hl_hw_sob **hw_sob, u32 count);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 173438461835..bcabfdbf1e01 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -410,19 +410,20 @@ static void hw_queue_schedule_job(struct hl_cs_job *job)
 	ext_and_hw_queue_submit_bd(hdev, q, ctl, len, ptr);
 }
 
-static void init_signal_cs(struct hl_device *hdev,
+static int init_signal_cs(struct hl_device *hdev,
 		struct hl_cs_job *job, struct hl_cs_compl *cs_cmpl)
 {
 	struct hl_sync_stream_properties *prop;
 	struct hl_hw_sob *hw_sob;
 	u32 q_idx;
+	int rc = 0;
 
 	q_idx = job->hw_queue_id;
 	prop = &hdev->kernel_queues[q_idx].sync_stream_prop;
 	hw_sob = &prop->hw_sob[prop->curr_sob_offset];
 
 	cs_cmpl->hw_sob = hw_sob;
-	cs_cmpl->sob_val = prop->next_sob_val++;
+	cs_cmpl->sob_val = prop->next_sob_val;
 
 	dev_dbg(hdev->dev,
 		"generate signal CB, sob_id: %d, sob val: 0x%x, q_idx: %d\n",
@@ -434,24 +435,9 @@ static void init_signal_cs(struct hl_device *hdev,
 	hdev->asic_funcs->gen_signal_cb(hdev, job->patched_cb,
 				cs_cmpl->hw_sob->sob_id, 0, true);
 
-	kref_get(&hw_sob->kref);
+	rc = hl_cs_signal_sob_wraparound_handler(hdev, q_idx, &hw_sob, 1);
 
-	/* check for wraparound */
-	if (prop->next_sob_val == HL_MAX_SOB_VAL) {
-		/*
-		 * Decrement as we reached the max value.
-		 * The release function won't be called here as we've
-		 * just incremented the refcount.
-		 */
-		kref_put(&hw_sob->kref, hl_sob_reset_error);
-		prop->next_sob_val = 1;
-		/* only two SOBs are currently in use */
-		prop->curr_sob_offset =
-			(prop->curr_sob_offset + 1) % HL_RSVD_SOBS;
-
-		dev_dbg(hdev->dev, "switched to SOB %d, q_idx: %d\n",
-				prop->curr_sob_offset, q_idx);
-	}
+	return rc;
 }
 
 static void init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
@@ -504,22 +490,25 @@ static void init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
  *
  * H/W queues spinlock should be taken before calling this function
  */
-static void init_signal_wait_cs(struct hl_cs *cs)
+static int init_signal_wait_cs(struct hl_cs *cs)
 {
 	struct hl_ctx *ctx = cs->ctx;
 	struct hl_device *hdev = ctx->hdev;
 	struct hl_cs_job *job;
 	struct hl_cs_compl *cs_cmpl =
 			container_of(cs->fence, struct hl_cs_compl, base_fence);
+	int rc = 0;
 
 	/* There is only one job in a signal/wait CS */
 	job = list_first_entry(&cs->job_list, struct hl_cs_job,
 				cs_node);
 
 	if (cs->type & CS_TYPE_SIGNAL)
-		init_signal_cs(hdev, job, cs_cmpl);
+		rc = init_signal_cs(hdev, job, cs_cmpl);
 	else if (cs->type & CS_TYPE_WAIT)
 		init_wait_cs(hdev, cs, job, cs_cmpl);
+
+	return rc;
 }
 
 /*
@@ -590,11 +579,16 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 		}
 	}
 
-	if ((cs->type == CS_TYPE_SIGNAL) || (cs->type == CS_TYPE_WAIT))
-		init_signal_wait_cs(cs);
-	else if (cs->type == CS_TYPE_COLLECTIVE_WAIT)
+	if ((cs->type == CS_TYPE_SIGNAL) || (cs->type == CS_TYPE_WAIT)) {
+		rc = init_signal_wait_cs(cs);
+		if (rc) {
+			dev_err(hdev->dev, "Failed to submit signal cs\n");
+			goto unroll_cq_resv;
+		}
+	} else if (cs->type == CS_TYPE_COLLECTIVE_WAIT)
 		hdev->asic_funcs->collective_wait_init_cs(cs);
 
+
 	spin_lock(&hdev->cs_mirror_lock);
 
 	/* Verify staged CS exists and add to the staged list */
-- 
2.25.1

