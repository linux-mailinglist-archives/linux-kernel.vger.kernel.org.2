Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2E41946C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhI0MlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234333AbhI0MlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:41:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F58961074;
        Mon, 27 Sep 2021 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632746375;
        bh=uJhWmKaHiis+TBaOFG76p9CPbBa9lm2X6WOB4YIzILY=;
        h=From:To:Cc:Subject:Date:From;
        b=XrC28lUMxVDOThldZFKs9LRX13kfwnefeVhYI8apxp9/uye7MwJZAYwH4skDRUAGM
         oCoutpzuolIf0gRZM36bGGsy2FUMMEXwtaaMGZu/crDkCuzvl3BzV+xVHPas460Emh
         5tYi/P9taKbue6H6BuXPLfisnF6eM9hTxGCpbdRemLq9uF9qjnYgWjCnd7Jz2AUZmh
         B0aH+FeKpHzbDPbIso7neXsQ+8iXjixscjRCkJWa0QuMl29KNumXVEZFg/kSXazmdq
         if/+wPNuVL0dsfTsAmoTzCF153Cp+Kn9V2WBFZeDWyVrrR8G9NZCvA9ASWkC7GbOCu
         l5CWGhbCQjv+Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH v2] habanalabs: fix resetting args in wait for CS IOCTL
Date:   Mon, 27 Sep 2021 15:39:30 +0300
Message-Id: <20210927123930.124005-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajaravi Krishna Katta <rkatta@habana.ai>

In wait for CS IOCTL code, the driver resets the incoming args structure
before returning to the user, regardless of the return value of the
IOCTL.

In case the IOCTL returns EINTR, resetting the args will result in error
in case the userspace will repeat the ioctl call immediately (which is
the behavior in the hl-thunk userspace library).

The solution is to reset the args only if the driver returns success (0)
as a return value for the IOCTL.

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 33 +++++++++++--------
 include/uapi/misc/habanalabs.h                |  6 ++--
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 91b57544f7c6..6dafff375f1c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2649,11 +2649,18 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 free_seq_arr:
 	kfree(cs_seq_arr);
 
-	/* update output args */
-	memset(args, 0, sizeof(*args));
 	if (rc)
 		return rc;
 
+	if (mcs_data.wait_status == -ERESTARTSYS) {
+		dev_err_ratelimited(hdev->dev,
+				"user process got signal while waiting for Multi-CS\n");
+		return -EINTR;
+	}
+
+	/* update output args */
+	memset(args, 0, sizeof(*args));
+
 	if (mcs_data.completion_bitmap) {
 		args->out.status = HL_WAIT_CS_STATUS_COMPLETED;
 		args->out.cs_completion_map = mcs_data.completion_bitmap;
@@ -2667,8 +2674,6 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		/* update if some CS was gone */
 		if (mcs_data.timestamp)
 			args->out.flags |= HL_WAIT_CS_STATUS_FLAG_GONE;
-	} else if (mcs_data.wait_status == -ERESTARTSYS) {
-		args->out.status = HL_WAIT_CS_STATUS_INTERRUPTED;
 	} else {
 		args->out.status = HL_WAIT_CS_STATUS_BUSY;
 	}
@@ -2688,16 +2693,17 @@ static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	rc = _hl_cs_wait_ioctl(hdev, hpriv->ctx, args->in.timeout_us, seq,
 				&status, &timestamp);
 
+	if (rc == -ERESTARTSYS) {
+		dev_err_ratelimited(hdev->dev,
+			"user process got signal while waiting for CS handle %llu\n",
+			seq);
+		return -EINTR;
+	}
+
 	memset(args, 0, sizeof(*args));
 
 	if (rc) {
-		if (rc == -ERESTARTSYS) {
-			dev_err_ratelimited(hdev->dev,
-				"user process got signal while waiting for CS handle %llu\n",
-				seq);
-			args->out.status = HL_WAIT_CS_STATUS_INTERRUPTED;
-			rc = -EINTR;
-		} else if (rc == -ETIMEDOUT) {
+		if (rc == -ETIMEDOUT) {
 			dev_err_ratelimited(hdev->dev,
 				"CS %llu has timed-out while user process is waiting for it\n",
 				seq);
@@ -2823,7 +2829,6 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		dev_err_ratelimited(hdev->dev,
 			"user process got signal while waiting for interrupt ID %d\n",
 			interrupt->interrupt_id);
-		*status = HL_WAIT_CS_STATUS_INTERRUPTED;
 		rc = -EINTR;
 	} else {
 		*status = CS_WAIT_STATUS_BUSY;
@@ -2878,8 +2883,6 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 				args->in.interrupt_timeout_us, args->in.addr,
 				args->in.target, interrupt_offset, &status);
 
-	memset(args, 0, sizeof(*args));
-
 	if (rc) {
 		if (rc != -EINTR)
 			dev_err_ratelimited(hdev->dev,
@@ -2888,6 +2891,8 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		return rc;
 	}
 
+	memset(args, 0, sizeof(*args));
+
 	switch (status) {
 	case CS_WAIT_STATUS_COMPLETED:
 		args->out.status = HL_WAIT_CS_STATUS_COMPLETED;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 7cc2a0f3f2f5..d13bb8c1b450 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -917,7 +917,6 @@ struct hl_wait_cs_in {
 #define HL_WAIT_CS_STATUS_BUSY		1
 #define HL_WAIT_CS_STATUS_TIMEDOUT	2
 #define HL_WAIT_CS_STATUS_ABORTED	3
-#define HL_WAIT_CS_STATUS_INTERRUPTED	4
 
 #define HL_WAIT_CS_STATUS_FLAG_GONE		0x1
 #define HL_WAIT_CS_STATUS_FLAG_TIMESTAMP_VLD	0x2
@@ -1286,7 +1285,8 @@ struct hl_debug_args {
  * EIO       - The CS was aborted (usually because the device was reset)
  * ENODEV    - The device wants to do hard-reset (so user need to close FD)
  *
- * The driver also returns a custom define inside the IOCTL which can be:
+ * The driver also returns a custom define in case the IOCTL call returned 0.
+ * The define can be one of the following:
  *
  * HL_WAIT_CS_STATUS_COMPLETED   - The CS has been completed successfully (0)
  * HL_WAIT_CS_STATUS_BUSY        - The CS is still executing (0)
@@ -1294,8 +1294,6 @@ struct hl_debug_args {
  *                                 (ETIMEDOUT)
  * HL_WAIT_CS_STATUS_ABORTED     - The CS was aborted, usually because the
  *                                 device was reset (EIO)
- * HL_WAIT_CS_STATUS_INTERRUPTED - Waiting for the CS was interrupted (EINTR)
- *
  */
 
 #define HL_IOCTL_WAIT_CS			\
-- 
2.17.1

