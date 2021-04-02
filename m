Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C87352F98
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDBTTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 15:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBTTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:19:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4528461163;
        Fri,  2 Apr 2021 19:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617391142;
        bh=TloOr9uUjiay4U8lrbS/0EWtLCdbRIr+Zgq5HJLUIz8=;
        h=From:To:Cc:Subject:Date:From;
        b=pjYuZo4ITMya/aKhpDt60Pue8gO7OOtLe061ZC9NXX68um8O2JqGALCXOq4+Eqyxy
         UVJgGP366kW7C//QwR3BmF34ezTCzoDq4PNFJWsT6hmeBQI31EkAP4wNZAND35lTW9
         4aqAXo7NaPu03LdZRPuumAfsrWAxCcCaUEEfWvYcmR1PL+R+307oZbOWK6K/hRp+e3
         uWMmZmm26JbAlKDfiV6OandcgpU5FG5VhtsZ/gy9sNRvdwBUwD5OHcoZAwLUR2G7iJ
         5Z5tA8EBLFWzRWX8ngd5AXJYJF4zgs+zp5vWZ01ZKqWDFrnYS9JYeA4jVX2OAWNBqr
         MkaqAOUgt2Qaw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Alon Mizrahi <amizrahi@habana.ai>
Subject: [PATCH 1/3] habanalabs: add custom timeout flag per cs
Date:   Fri,  2 Apr 2021 22:18:54 +0300
Message-Id: <20210402191856.4849-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon Mizrahi <amizrahi@habana.ai>

There is a need to allow to user to send command submissions with
custom timeout as some CS take longer than the max timeout that is
used by default.

Signed-off-by: Alon Mizrahi <amizrahi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 35 +++++++++++--------
 drivers/misc/habanalabs/common/habanalabs.h   |  2 ++
 drivers/misc/habanalabs/common/hw_queue.c     |  2 +-
 include/uapi/misc/habanalabs.h                | 15 ++++++--
 4 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 21a60b7c2091..ff8791a651fd 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -467,8 +467,7 @@ static void cs_handle_tdr(struct hl_device *hdev, struct hl_cs *cs)
 
 	if (next_entry_found && !next->tdr_active) {
 		next->tdr_active = true;
-		schedule_delayed_work(&next->work_tdr,
-					hdev->timeout_jiffies);
+		schedule_delayed_work(&next->work_tdr, next->timeout_jiffies);
 	}
 
 	spin_unlock(&hdev->cs_mirror_lock);
@@ -622,7 +621,7 @@ static void cs_timedout(struct work_struct *work)
 
 static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 			enum hl_cs_type cs_type, u64 user_sequence,
-			struct hl_cs **cs_new)
+			struct hl_cs **cs_new, u32 flags, u32 timeout)
 {
 	struct hl_cs_counters_atomic *cntr;
 	struct hl_fence *other = NULL;
@@ -649,6 +648,8 @@ static int allocate_cs(struct hl_device *hdev, struct hl_ctx *ctx,
 	cs->submitted = false;
 	cs->completed = false;
 	cs->type = cs_type;
+	cs->timestamp = !!(flags & HL_CS_FLAGS_TIMESTAMP);
+	cs->timeout_jiffies = timeout;
 	INIT_LIST_HEAD(&cs->job_list);
 	INIT_DELAYED_WORK(&cs->work_tdr, cs_timedout);
 	kref_init(&cs->refcount);
@@ -1092,7 +1093,8 @@ static int cs_staged_submission(struct hl_device *hdev, struct hl_cs *cs,
 }
 
 static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
-				u32 num_chunks, u64 *cs_seq, u32 flags)
+				u32 num_chunks, u64 *cs_seq, u32 flags,
+				u32 timeout)
 {
 	bool staged_mid, int_queues_only = true;
 	struct hl_device *hdev = hpriv->hdev;
@@ -1121,11 +1123,11 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		staged_mid = false;
 
 	rc = allocate_cs(hdev, hpriv->ctx, CS_TYPE_DEFAULT,
-			staged_mid ? user_sequence : ULLONG_MAX, &cs);
+			staged_mid ? user_sequence : ULLONG_MAX, &cs, flags,
+			timeout);
 	if (rc)
 		goto free_cs_chunk_array;
 
-	cs->timestamp = !!(flags & HL_CS_FLAGS_TIMESTAMP);
 	*cs_seq = cs->sequence;
 
 	hl_debugfs_add_cs(cs);
@@ -1323,7 +1325,8 @@ static int hl_submit_pending_cb(struct hl_fpriv *hpriv)
 		list_move_tail(&pending_cb->cb_node, &local_cb_list);
 	spin_unlock(&ctx->pending_cb_lock);
 
-	rc = allocate_cs(hdev, ctx, CS_TYPE_DEFAULT, ULLONG_MAX, &cs);
+	rc = allocate_cs(hdev, ctx, CS_TYPE_DEFAULT, ULLONG_MAX, &cs, 0,
+				hdev->timeout_jiffies);
 	if (rc)
 		goto add_list_elements;
 
@@ -1424,7 +1427,7 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 			rc = 0;
 		} else {
 			rc = cs_ioctl_default(hpriv, chunks, num_chunks,
-								cs_seq, 0);
+					cs_seq, 0, hdev->timeout_jiffies);
 		}
 
 		mutex_unlock(&hpriv->restore_phase_mutex);
@@ -1594,7 +1597,7 @@ static int cs_ioctl_signal_wait_create_jobs(struct hl_device *hdev,
 
 static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 				void __user *chunks, u32 num_chunks,
-				u64 *cs_seq, bool timestamp)
+				u64 *cs_seq, u32 flags, u32 timeout)
 {
 	struct hl_cs_chunk *cs_chunk_array, *chunk;
 	struct hw_queue_properties *hw_queue_prop;
@@ -1700,7 +1703,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		}
 	}
 
-	rc = allocate_cs(hdev, ctx, cs_type, ULLONG_MAX, &cs);
+	rc = allocate_cs(hdev, ctx, cs_type, ULLONG_MAX, &cs, flags, timeout);
 	if (rc) {
 		if (cs_type == CS_TYPE_WAIT ||
 			cs_type == CS_TYPE_COLLECTIVE_WAIT)
@@ -1708,8 +1711,6 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 		goto free_cs_chunk_array;
 	}
 
-	cs->timestamp = !!timestamp;
-
 	/*
 	 * Save the signal CS fence for later initialization right before
 	 * hanging the wait CS on the queue.
@@ -1767,7 +1768,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	enum hl_cs_type cs_type;
 	u64 cs_seq = ULONG_MAX;
 	void __user *chunks;
-	u32 num_chunks, flags;
+	u32 num_chunks, flags, timeout;
 	int rc;
 
 	rc = hl_cs_sanity_checks(hpriv, args);
@@ -1793,16 +1794,20 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 			!(flags & HL_CS_FLAGS_STAGED_SUBMISSION_FIRST))
 		cs_seq = args->in.seq;
 
+	timeout = flags & HL_CS_FLAGS_CUSTOM_TIMEOUT
+			? msecs_to_jiffies(args->in.timeout * 1000)
+			: hpriv->hdev->timeout_jiffies;
+
 	switch (cs_type) {
 	case CS_TYPE_SIGNAL:
 	case CS_TYPE_WAIT:
 	case CS_TYPE_COLLECTIVE_WAIT:
 		rc = cs_ioctl_signal_wait(hpriv, cs_type, chunks, num_chunks,
-			&cs_seq, args->in.cs_flags & HL_CS_FLAGS_TIMESTAMP);
+					&cs_seq, args->in.cs_flags, timeout);
 		break;
 	default:
 		rc = cs_ioctl_default(hpriv, chunks, num_chunks, &cs_seq,
-							args->in.cs_flags);
+						args->in.cs_flags, timeout);
 		break;
 	}
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index ddb65639f518..54d7735991c7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1245,6 +1245,7 @@ struct hl_userptr {
  * @sequence: the sequence number of this CS.
  * @staged_sequence: the sequence of the staged submission this CS is part of,
  *                   relevant only if staged_cs is set.
+ * @timeout_jiffies: cs timeout in jiffies.
  * @type: CS_TYPE_*.
  * @submitted: true if CS was submitted to H/W.
  * @completed: true if CS was completed by device.
@@ -1273,6 +1274,7 @@ struct hl_cs {
 	struct list_head	debugfs_list;
 	u64			sequence;
 	u64			staged_sequence;
+	u64			timeout_jiffies;
 	enum hl_cs_type		type;
 	u8			submitted;
 	u8			completed;
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 4acc25dccad3..173438461835 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -629,7 +629,7 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 	if ((hdev->timeout_jiffies != MAX_SCHEDULE_TIMEOUT) &&
 				first_entry && cs_needs_timeout(cs)) {
 		cs->tdr_active = true;
-		schedule_delayed_work(&cs->work_tdr, hdev->timeout_jiffies);
+		schedule_delayed_work(&cs->work_tdr, cs->timeout_jiffies);
 
 	}
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 92fd000ce0d3..90798eaac728 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -630,6 +630,7 @@ struct hl_cs_chunk {
 #define HL_CS_FLAGS_STAGED_SUBMISSION		0x40
 #define HL_CS_FLAGS_STAGED_SUBMISSION_FIRST	0x80
 #define HL_CS_FLAGS_STAGED_SUBMISSION_LAST	0x100
+#define HL_CS_FLAGS_CUSTOM_TIMEOUT		0x200
 
 #define HL_CS_STATUS_SUCCESS		0
 
@@ -665,8 +666,18 @@ struct hl_cs_in {
 	 */
 	__u32 num_chunks_execute;
 
-	/* Number of chunks in restore phase array - Currently not in use */
-	__u32 num_chunks_store;
+	union {
+		/* Number of chunks in restore phase array -
+		 * Currently not in use
+		 */
+		__u32 num_chunks_store;
+
+		/* timeout in seconds - valid only if HL_CS_FLAGS_CUSTOM_TIMEOUT
+		 * is set. this parameter is ignored in case of future multiple
+		 * users support.
+		 */
+		__u32 timeout;
+	};
 
 	/* HL_CS_FLAGS_* */
 	__u32 cs_flags;
-- 
2.25.1

