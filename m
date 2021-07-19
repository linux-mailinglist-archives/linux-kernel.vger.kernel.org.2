Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A42B3CE325
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 18:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346626AbhGSPes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242570AbhGSO4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:56:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0999F613D0;
        Mon, 19 Jul 2021 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626708862;
        bh=WyzVJ4LYzOsI9QJ+S9W6cHWb+Fz4jetsojffwi13Ick=;
        h=From:To:Cc:Subject:Date:From;
        b=H1if53KUwWxQtGoEZ4WIZtSSNAGapexR886IwIOtg2DCyhaUBoBwIqdDCMRZbdtGy
         1LGoLQd71BB8MaPC4sHH1Ly+GSr2saBFpxhmLmShD+Z4n4qoUJz9X4yUQk91aAsv7j
         P3M5DGHDkiBYkrRSFsxB1Nnx/9yncZ3zF9xoUXVfjw2y1AfoDuKiAEdYOaqdiDpZjf
         tijFYitMJtgJ0z4JswtOqzPJAYgzuw8vB3SpVP0r8h3/rCJC8Cw9Spcp1i/dTYhGJZ
         YbsXQg9Q80Map6HOG+ZK6rgkEsXoB7M4sRUOVV7Dp3R2Yn5+EkNg4gQ3/wKtzzO1AC
         mdiso2QUjotZg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 1/4] habanalabs: minor fixes to signals from graph
Date:   Mon, 19 Jul 2021 18:34:14 +0300
Message-Id: <20210719153417.4787-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

- fix signals reservation flow when setting the next available signal
  value.
- fix how driver treats the wait offset, by decrement 1 from the user
  value before actually building the wait cs.
- fix debug logs to print in decimal the sob value instead of hex.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 30 +++++++++----------
 drivers/misc/habanalabs/common/hw_queue.c     | 16 ++++++----
 drivers/misc/habanalabs/gaudi/gaudi.c         |  7 +++--
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 94b37ab08f90..fea0f05a4954 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -556,7 +556,7 @@ static inline void cs_release_sob_reset_handler(struct hl_device *hdev,
 			(hl_cs_cmpl->type == CS_TYPE_COLLECTIVE_WAIT) ||
 			(!!hl_cs_cmpl->encaps_signals)) {
 		dev_dbg(hdev->dev,
-				"CS 0x%llx type %d finished, sob_id: %d, sob_val: 0x%x\n",
+				"CS 0x%llx type %d finished, sob_id: %d, sob_val: %u\n",
 				hl_cs_cmpl->cs_seq,
 				hl_cs_cmpl->type,
 				hl_cs_cmpl->hw_sob->sob_id,
@@ -1694,7 +1694,15 @@ int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 			return -EINVAL;
 		}
 
-		prop->next_sob_val = count;
+		/*
+		 * next_sob_val always points to the next available signal
+		 * in the sob, so in encaps signals it will be the next one
+		 * after reserving the required amount.
+		 */
+		if (encaps_sig)
+			prop->next_sob_val = count + 1;
+		else
+			prop->next_sob_val = count;
 
 		/* only two SOBs are currently in use */
 		prop->curr_sob_offset = other_sob_offset;
@@ -1710,11 +1718,11 @@ int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 		 * in addition, if we have combination of cs signal and
 		 * encaps, and at the point we need to reset the sob there was
 		 * no more reservations and only signal cs keep coming,
-		 * in such case we need to signal_cs to put the refcount and
+		 * in such case we need signal_cs to put the refcount and
 		 * reset the sob.
 		 */
 		if (other_sob->need_reset)
-			kref_put(&other_sob->kref, hl_sob_reset);
+			hw_sob_put(other_sob);
 
 		if (encaps_sig) {
 			/* set reset indication for the sob */
@@ -1946,16 +1954,6 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	 */
 	handle->pre_sob_val = prop->next_sob_val - handle->count;
 
-	/* set the hw_sob to the handle after calling the sob wraparound handler
-	 * since sob could have changed.
-	 */
-	handle->hw_sob = hw_sob;
-
-	/* store the current sob value for unreserve validity check, and
-	 * signal offset support
-	 */
-	handle->pre_sob_val = prop->next_sob_val - handle->count;
-
 	*signals_count = prop->next_sob_val;
 	hdev->asic_funcs->hw_queues_unlock(hdev);
 
@@ -1963,9 +1961,9 @@ static int cs_ioctl_reserve_signals(struct hl_fpriv *hpriv,
 	*handle_id = hdl_id;
 
 	dev_dbg(hdev->dev,
-		"Signals reserved, sob_id: %d, sob addr: 0x%x, sob val: 0x%x, q_idx: %d, hdl_id: %d\n",
+		"Signals reserved, sob_id: %d, sob addr: 0x%x, last sob_val: %u, q_idx: %d, hdl_id: %d\n",
 			hw_sob->sob_id, handle->hw_sob->sob_addr,
-			prop->next_sob_val, q_idx, hdl_id);
+			prop->next_sob_val - 1, q_idx, hdl_id);
 	goto out;
 
 remove_idr:
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 3d9b24ce2020..6d3beccad91b 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -416,7 +416,7 @@ static int init_signal_cs(struct hl_device *hdev,
 	cs_cmpl->sob_val = prop->next_sob_val;
 
 	dev_dbg(hdev->dev,
-		"generate signal CB, sob_id: %d, sob val: 0x%x, q_idx: %d, seq: %llu\n",
+		"generate signal CB, sob_id: %d, sob val: %u, q_idx: %d, seq: %llu\n",
 		cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val, q_idx,
 		cs_cmpl->cs_seq);
 
@@ -442,9 +442,13 @@ void hl_hw_queue_encaps_sig_set_sob_info(struct hl_device *hdev,
 
 	/* Note that encaps_sig_wait_offset was validated earlier in the flow
 	 * for offset value which exceeds the max reserved signal count.
+	 * always decrement 1 of the offset since when the user
+	 * set offset 1 for example he mean to wait only for the first
+	 * signal only, which will be pre_sob_val, and if he set offset 2
+	 * then the value required is (pre_sob_val + 1) and so on...
 	 */
 	cs_cmpl->sob_val = handle->pre_sob_val +
-			(job->encaps_sig_wait_offset);
+			(job->encaps_sig_wait_offset - 1);
 }
 
 static int init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
@@ -469,7 +473,7 @@ static int init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
 		 */
 		hl_hw_queue_encaps_sig_set_sob_info(hdev, cs, job, cs_cmpl);
 
-		dev_dbg(hdev->dev, "Wait for encaps signals handle, qidx(%u), CS sequence(%llu), sob val: %u, offset: %u\n",
+		dev_dbg(hdev->dev, "Wait for encaps signals handle, qidx(%u), CS sequence(%llu), sob val: 0x%x, offset: %u\n",
 				cs->encaps_sig_hdl->q_idx,
 				cs->encaps_sig_hdl->cs_seq,
 				cs_cmpl->sob_val,
@@ -587,10 +591,12 @@ static int encaps_sig_first_staged_cs_handler
 		cs_cmpl->sob_val = encaps_sig_hdl->pre_sob_val +
 						encaps_sig_hdl->count;
 
-		dev_dbg(hdev->dev, "CS seq (%llu) added to encaps signal handler id (%u), count(%u), qidx(%u)\n",
+		dev_dbg(hdev->dev, "CS seq (%llu) added to encaps signal handler id (%u), count(%u), qidx(%u), sob(%u), val(%u)\n",
 				cs->sequence, encaps_sig_hdl->id,
 				encaps_sig_hdl->count,
-				encaps_sig_hdl->q_idx);
+				encaps_sig_hdl->q_idx,
+				cs_cmpl->hw_sob->sob_id,
+				cs_cmpl->sob_val);
 
 	} else {
 		dev_err(hdev->dev, "encaps handle id(%u) wasn't found!\n",
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 529ccd8b8911..f134cd7a6798 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1223,9 +1223,10 @@ static void gaudi_collective_slave_init_job(struct hl_device *hdev,
 		hl_hw_queue_encaps_sig_set_sob_info(hdev, job->cs, job,
 						cs_cmpl);
 
-		dev_dbg(hdev->dev, "collective wait: Sequence %llu found, sob val incremented to: %u\n",
+		dev_dbg(hdev->dev, "collective wait: Sequence %llu found, sob_id: %u,  wait for sob_val: %u\n",
 				job->cs->sequence,
-				job->cs->encaps_sig_hdl->pre_sob_val);
+				cs_cmpl->hw_sob->sob_id,
+				cs_cmpl->sob_val);
 	}
 
 	/* Add to wait CBs using slave monitor */
@@ -1238,7 +1239,7 @@ static void gaudi_collective_slave_init_job(struct hl_device *hdev,
 	wait_prop.size = cb_size;
 
 	dev_dbg(hdev->dev,
-		"Generate slave wait CB, sob %d, val:0x%x, mon %d, q %d\n",
+		"Generate slave wait CB, sob %d, val:%x, mon %d, q %d\n",
 		cs_cmpl->hw_sob->sob_id, cs_cmpl->sob_val,
 		prop->collective_slave_mon_id, queue_id);
 
-- 
2.25.1

