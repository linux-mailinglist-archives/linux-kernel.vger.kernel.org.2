Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3131420903
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhJDKK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhJDKKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:10:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D29E26120A;
        Mon,  4 Oct 2021 10:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633342115;
        bh=S28+USb4TMJB9Lg73Bqg916zJBDtTNKZI7m5oJ5GM10=;
        h=From:To:Cc:Subject:Date:From;
        b=KekLCORHAMUo2R/Bt5wiGoZf5rV2XpY62qKeaJ3C2nd4QC74+uagEGxtByWVQjCso
         g7HUXQ6JuKKkwU/+atj0VBfRFVNLNFa+scXka5+jRJbHa1gYms/2jDwiqKhZyHaYzW
         M3+kBRD2woNxFhnYenyr/eYLnMwv2ehxmwwnysGfK/6y7rCUT2A/C6AN2VbGtbG4Zn
         FJVS280miDifhLs6RVTbs0S1k4wrYUaZEh6w9OVBgCItfA0T9Tbn1YNIpeOmCmwZe8
         JLx0A8dIMBYaf4IVa3wgBNR4KXd/bN9214rJSeZSA0nPqTKwEn6YDV/P01NbxYP2EV
         ryXzNx8ulE7aQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/6] habanalabs: add support for a long interrupt target value
Date:   Mon,  4 Oct 2021 13:08:25 +0300
Message-Id: <20211004100830.27573-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to avoid user target value wraparound, we modify the
current interface so user will be able to wait for an 8-byte
target value rather than a 4-byte value.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c |  8 ++++----
 include/uapi/misc/habanalabs.h                      | 13 +++++++------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index a344928363c8..44bab01cd033 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2739,13 +2739,13 @@ static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 
 static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				u32 timeout_us, u64 user_address,
-				u32 target_value, u16 interrupt_offset,
+				u64 target_value, u16 interrupt_offset,
 				enum hl_cs_wait_status *status)
 {
 	struct hl_user_pending_interrupt *pend;
 	struct hl_user_interrupt *interrupt;
 	unsigned long timeout, flags;
-	u32 completion_value;
+	u64 completion_value;
 	long completion_rc;
 	int rc = 0;
 
@@ -2779,7 +2779,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	/* We check for completion value as interrupt could have been received
 	 * before we added the node to the wait list
 	 */
-	if (copy_from_user(&completion_value, u64_to_user_ptr(user_address), 4)) {
+	if (copy_from_user(&completion_value, u64_to_user_ptr(user_address), 8)) {
 		dev_err(hdev->dev, "Failed to copy completion value from user\n");
 		rc = -EFAULT;
 		goto remove_pending_user_interrupt;
@@ -2811,7 +2811,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		reinit_completion(&pend->fence.completion);
 		spin_unlock_irqrestore(&interrupt->wait_list_lock, flags);
 
-		if (copy_from_user(&completion_value, u64_to_user_ptr(user_address), 4)) {
+		if (copy_from_user(&completion_value, u64_to_user_ptr(user_address), 8)) {
 			dev_err(hdev->dev, "Failed to copy completion value from user\n");
 			rc = -EFAULT;
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index ccfcb4d188fc..fe73630e1a05 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -897,11 +897,7 @@ struct hl_wait_cs_in {
 			 */
 			__u64 addr;
 			/* Target value for completion comparison */
-			__u32 target;
-			/* Absolute timeout to wait for interrupt
-			 * in microseconds
-			 */
-			__u32 interrupt_timeout_us;
+			__u64 target;
 		};
 	};
 
@@ -917,7 +913,12 @@ struct hl_wait_cs_in {
 
 	/* Multi CS API info- valid entries in multi-CS array */
 	__u8 seq_arr_len;
-	__u8 pad[7];
+	__u8 pad[3];
+
+	/* Absolute timeout to wait for an interrupt in microseconds.
+	 * Relevant only when HL_WAIT_CS_FLAGS_INTERRUPT is set
+	 */
+	__u32 interrupt_timeout_us;
 };
 
 #define HL_WAIT_CS_STATUS_COMPLETED	0
-- 
2.17.1

