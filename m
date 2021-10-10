Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1807427FFC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhJJIFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 04:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhJJIFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 04:05:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F11A60F43;
        Sun, 10 Oct 2021 08:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633852997;
        bh=5MY4OxKqJQSS+NfNQDZvm1w0+YY4CmXgyCqxEgMsWMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDzlEob4EthVFAoN/giGVOuz3635+819fs8fQeMAo1NMA6+iQupHUFUeKktlvMNU7
         GksOul3wIe+FZ3hEfFm2On6oTM27PsVuFe5fLyyuYqjEKpI1fb5zElGTn02d73QCCq
         Eqw6emRBVwf962e+N4SCvOhWAD2nmlp+xsT1ybM7J31NPeW6SJFNVvECo7InaKivxV
         X368hOQTbl6zmwxCUp6eG7N6Umx7H2hA0gkgODcYTqwv8PYPOsvwMg7zMnxlhmOBO6
         D/JvFBPLpUTzT4iEp5J6NGN432UAI+lcwkhzdAr7Pz1zTvjfegNVghwFAFJrgF8HQ5
         Bo9zaXXvrVFoQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 4/5] habanalabs: fix race condition in multi CS completion
Date:   Sun, 10 Oct 2021 11:03:06 +0300
Message-Id: <20211010080307.153420-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211010080307.153420-1-ogabbay@kernel.org>
References: <20211010080307.153420-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

Race condition occurs when CS fence completes and multi CS did not
completed yet, while waiting for multi CS ends and returns indication
to user that the CS completed. Next wait for multi CS may be triggered
by previous multi CS completion without any current CS completed,
causing an error.

Example scenario :
1. User do multi CS wait for CSs 1 and 2 on master QID 0

2. CS 1 and 2 reached the "cs release" code. The thread of CS 1
   completed both the CS and multi CS handling but the completion
   thread of CS 2 completed the CS but still did not executed
   complete_multi_cs (note that in CS completion the sequence is to
   first do complete all for the CS and then another complete all to
   signal the multi_cs)

3. User received indication that CS 1 and 2 completed (since we check
   the CS fence and both indicated as completed) and immediately waits
   on CS 3 and 4, also on master QID 0.

4. Completion thread of CS2 executed complete_multi_cs before
   completion of CS 3 and 4 and so will trigger the multi CS wait of
   CSs 3 and 4 as they wait on master QID 0.

This will trigger multi CS completion although none of its
current CS has been completed.

Fixed by adding multi CS complete handling indication for each CS.
CS will be marked to the user as completed only if its fence completed
and multi CS handling is done.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 20 ++++++++++++++++++-
 drivers/misc/habanalabs/common/habanalabs.h   |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 4bc24852a283..8e4dc1441fff 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -143,6 +143,7 @@ static void hl_fence_init(struct hl_fence *fence, u64 sequence)
 	fence->cs_sequence = sequence;
 	fence->error = 0;
 	fence->timestamp = ktime_set(0, 0);
+	fence->mcs_handling_done = false;
 	init_completion(&fence->completion);
 }
 
@@ -535,10 +536,21 @@ static void complete_multi_cs(struct hl_device *hdev, struct hl_cs *cs)
 				mcs_compl->timestamp =
 						ktime_to_ns(fence->timestamp);
 			complete_all(&mcs_compl->completion);
+
+			/*
+			 * Setting mcs_handling_done inside the lock ensures
+			 * at least one fence have mcs_handling_done set to
+			 * true before wait for mcs finish. This ensures at
+			 * least one CS will be set as completed when polling
+			 * mcs fences.
+			 */
+			fence->mcs_handling_done = true;
 		}
 
 		spin_unlock(&mcs_compl->lock);
 	}
+	/* In case CS completed without mcs completion initialized */
+	fence->mcs_handling_done = true;
 }
 
 static inline void cs_release_sob_reset_handler(struct hl_device *hdev,
@@ -2372,7 +2384,13 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data)
 
 		mcs_data->stream_master_qid_map |= fence->stream_master_qid_map;
 
-		if (status == CS_WAIT_STATUS_BUSY)
+		/*
+		 * Using mcs_handling_done to avoid possibility of mcs_data
+		 * returns to user indicating CS completed before it finished
+		 * all of its mcs handling, to avoid race the next time the
+		 * user waits for mcs.
+		 */
+		if (status == CS_WAIT_STATUS_BUSY || !fence->mcs_handling_done)
 			continue;
 
 		mcs_data->completion_bitmap |= BIT(i);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index a06135155b57..48f0e52cd5be 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -610,6 +610,9 @@ struct asic_fixed_properties {
  * @error: mark this fence with error
  * @timestamp: timestamp upon completion
  * @take_timestamp: timestamp shall be taken upon completion
+ * @mcs_handling_done: indicates that corresponding command submission has
+ *                     finished msc handling, this does not mean it was part
+ *                     of the mcs
  */
 struct hl_fence {
 	struct completion	completion;
@@ -619,6 +622,7 @@ struct hl_fence {
 	int			error;
 	ktime_t			timestamp;
 	u8			take_timestamp;
+	u8			mcs_handling_done;
 };
 
 /**
-- 
2.25.1

