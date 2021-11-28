Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B78460978
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359203AbhK1TkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:40:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52582 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbhK1TiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:38:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E2DA6111B
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F865C53FC1;
        Sun, 28 Nov 2021 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128094;
        bh=PoypfzjjuLfngL6yf9s1rRigB6hR1P/ZiJx33+pQ0X4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQC7jTbmj7M7j9WlVwp0BBOKTIafKoGZYfiE+yC2wmruIcMr9guXh/wj9ffG+R15F
         jH5SG8Q86mK5ZtcLJAjZBWNRyWbLJcshAbJOwFiXW4zxJHFb33qsN7lnswI9pB2ojH
         so6is/Yj07TFYYLhl4UuoeBvRt3+tPFF4PVUkKFeXUpQvjW67t2lwkess6Zx8kOFls
         SFg5wdPN12hikV59riSyk34NvH78rHqpE6kWydl3AXY6wQI6zucQezmf5H3yBkWE3g
         2Wn/4bJNtWpwBCjgmKKrFJ0kFi9KAkGdggnAt1shIyuQVwvAxTdefIQoi2CzUmr5aF
         EwnK5kGLpAb8Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 11/12] habanalabs: add SOB information to signal submission uAPI
Date:   Sun, 28 Nov 2021 21:34:34 +0200
Message-Id: <20211128193435.266534-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128193435.266534-1-ogabbay@kernel.org>
References: <20211128193435.266534-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

For debug purpose, add SOB address and SOB initial counter value
before current submission to uAPI output.

Using SOB address and initial counter, user can calculate how much of
the submmision has been completed.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 37 +++++++++++++++----
 drivers/misc/habanalabs/common/habanalabs.h   |  5 +++
 drivers/misc/habanalabs/common/hw_queue.c     |  3 ++
 include/uapi/misc/habanalabs.h                | 10 ++++-
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 4e893364a3cc..7a277f442207 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -1277,7 +1277,8 @@ static u32 get_stream_master_qid_mask(struct hl_device *hdev, u32 qid)
 
 static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 				u32 num_chunks, u64 *cs_seq, u32 flags,
-				u32 encaps_signals_handle, u32 timeout)
+				u32 encaps_signals_handle, u32 timeout,
+				u16 *signal_initial_sob_count)
 {
 	bool staged_mid, int_queues_only = true;
 	struct hl_device *hdev = hpriv->hdev;
@@ -1444,6 +1445,8 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		goto free_cs_object;
 	}
 
+	*signal_initial_sob_count = cs->initial_sob_count;
+
 	rc = HL_CS_STATUS_SUCCESS;
 	goto put_cs;
 
@@ -1472,6 +1475,7 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 	int rc = 0, do_ctx_switch;
 	void __user *chunks;
 	u32 num_chunks, tmp;
+	u16 sob_count;
 	int ret;
 
 	do_ctx_switch = atomic_cmpxchg(&ctx->thread_ctx_switch_token, 1, 0);
@@ -1512,7 +1516,7 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 			rc = 0;
 		} else {
 			rc = cs_ioctl_default(hpriv, chunks, num_chunks,
-					cs_seq, 0, 0, hdev->timeout_jiffies);
+					cs_seq, 0, 0, hdev->timeout_jiffies, &sob_count);
 		}
 
 		mutex_unlock(&hpriv->restore_phase_mutex);
@@ -1963,7 +1967,8 @@ static int cs_ioctl_unreserve_signals(struct hl_fpriv *hpriv, u32 handle_id)
 
 static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 				void __user *chunks, u32 num_chunks,
-				u64 *cs_seq, u32 flags, u32 timeout)
+				u64 *cs_seq, u32 flags, u32 timeout,
+				u32 *signal_sob_addr_offset, u16 *signal_initial_sob_count)
 {
 	struct hl_cs_encaps_sig_handle *encaps_sig_hdl = NULL;
 	bool handle_found = false, is_wait_cs = false,
@@ -2195,6 +2200,9 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		goto free_cs_object;
 	}
 
+	*signal_sob_addr_offset = cs->sob_addr_offset;
+	*signal_initial_sob_count = cs->initial_sob_count;
+
 	rc = HL_CS_STATUS_SUCCESS;
 	if (is_wait_cs)
 		wait_cs_submitted = true;
@@ -2225,6 +2233,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	void __user *chunks;
 	u32 num_chunks, flags, timeout,
 		signals_count = 0, sob_addr = 0, handle_id = 0;
+	u16 sob_initial_count = 0;
 	int rc;
 
 	rc = hl_cs_sanity_checks(hpriv, args);
@@ -2255,7 +2264,8 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	case CS_TYPE_WAIT:
 	case CS_TYPE_COLLECTIVE_WAIT:
 		rc = cs_ioctl_signal_wait(hpriv, cs_type, chunks, num_chunks,
-					&cs_seq, args->in.cs_flags, timeout);
+					&cs_seq, args->in.cs_flags, timeout,
+					&sob_addr, &sob_initial_count);
 		break;
 	case CS_RESERVE_SIGNALS:
 		rc = cs_ioctl_reserve_signals(hpriv,
@@ -2271,20 +2281,33 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		rc = cs_ioctl_default(hpriv, chunks, num_chunks, &cs_seq,
 						args->in.cs_flags,
 						args->in.encaps_sig_handle_id,
-						timeout);
+						timeout, &sob_initial_count);
 		break;
 	}
 out:
 	if (rc != -EAGAIN) {
 		memset(args, 0, sizeof(*args));
 
-		if (cs_type == CS_RESERVE_SIGNALS) {
+		switch (cs_type) {
+		case CS_RESERVE_SIGNALS:
 			args->out.handle_id = handle_id;
 			args->out.sob_base_addr_offset = sob_addr;
 			args->out.count = signals_count;
-		} else {
+			break;
+		case CS_TYPE_SIGNAL:
+			args->out.sob_base_addr_offset = sob_addr;
+			args->out.sob_count_before_submission = sob_initial_count;
+			args->out.seq = cs_seq;
+			break;
+		case CS_TYPE_DEFAULT:
+			args->out.sob_count_before_submission = sob_initial_count;
+			args->out.seq = cs_seq;
+			break;
+		default:
 			args->out.seq = cs_seq;
+			break;
 		}
+
 		args->out.status = rc;
 	}
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 77ac4bb98137..93d0a85265be 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1545,6 +1545,9 @@ struct hl_userptr {
  * @submission_time_jiffies: submission time of the cs
  * @type: CS_TYPE_*.
  * @encaps_sig_hdl_id: encaps signals handle id, set for the first staged cs.
+ * @sob_addr_offset: sob offset from the configuration base address.
+ * @initial_sob_count: count of completed signals in SOB before current submission of signal or
+ *                     cs with encaps signals.
  * @submitted: true if CS was submitted to H/W.
  * @completed: true if CS was completed by device.
  * @timedout : true if CS was timedout.
@@ -1580,6 +1583,8 @@ struct hl_cs {
 	u64			submission_time_jiffies;
 	enum hl_cs_type		type;
 	u32			encaps_sig_hdl_id;
+	u32			sob_addr_offset;
+	u16			initial_sob_count;
 	u8			submitted;
 	u8			completed;
 	u8			timedout;
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 0743319b10c7..fc841d651210 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -429,6 +429,9 @@ static int init_signal_cs(struct hl_device *hdev,
 	rc = hl_cs_signal_sob_wraparound_handler(hdev, q_idx, &hw_sob, 1,
 								false);
 
+	job->cs->sob_addr_offset = hw_sob->sob_addr;
+	job->cs->initial_sob_count = prop->next_sob_val - 1;
+
 	return rc;
 }
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index cd86937c572d..648850b954a3 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -929,9 +929,17 @@ struct hl_cs_out {
 
 	/*
 	 * SOB base address offset
-	 * Valid only when HL_CS_FLAGS_RESERVE_SIGNALS_ONLY is set
+	 * Valid only when HL_CS_FLAGS_RESERVE_SIGNALS_ONLY or HL_CS_FLAGS_SIGNAL is set
 	 */
 	__u32 sob_base_addr_offset;
+
+	/*
+	 * Count of completed signals in SOB before current signal submission.
+	 * Valid only when (HL_CS_FLAGS_ENCAP_SIGNALS & HL_CS_FLAGS_STAGED_SUBMISSION)
+	 * or HL_CS_FLAGS_SIGNAL is set
+	 */
+	__u16 sob_count_before_submission;
+	__u16 pad[3];
 };
 
 union hl_cs_args {
-- 
2.25.1

