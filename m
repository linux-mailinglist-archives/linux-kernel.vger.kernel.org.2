Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA37409CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbhIMTNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241533AbhIMTNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:13:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D703D60F26;
        Mon, 13 Sep 2021 19:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631560312;
        bh=iULRhj5KLnHd/+v+YrzdE0hblCEvh1be8oqNRSVk52c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E4fqUJvqzNqHZOkl8c6BmFNOrE3VCwbQZyFs7KQSf0v2QcNrx5ZudrITqPrwjk9ib
         ExMksEMAcHfJIgSXL1PXqaOlgYgLp+BUJkzRbTKCU47s1cA1NigIfPRjfXGdYwuRe4
         duwW08ngj7PS/u0IQyLh/JBpYgKCeTzYQvbCn50/9hC6mNqybjvEd5xNID8qfP1AKv
         1hpGLYTmHow9gJhVTFVUF7aSDA7Lf+27WZPajze9k3HVVXyPn709VTUpo28Od6tty6
         pBN0a81CaFsc07iVUCiTkvodtQPFuZueBQSsABOLx1gOE9UtNO5hxTXZXp6LEyDjjV
         eh7RnjAfTrC2w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 2/2] habanalabs: fix wait offset handling
Date:   Mon, 13 Sep 2021 22:11:46 +0300
Message-Id: <20210913191146.92956-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210913191146.92956-1-ogabbay@kernel.org>
References: <20210913191146.92956-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Add handling for case where the user doesn't set wait offset,
and keeps it as 0. In such a case the driver will decrement one
from this zero value which will cause the code to wait for
wrong number of signals.

The solution is to treat this case as in legacy wait cs,
and wait for the next signal.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/hw_queue.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 76b7de8f1406..0743319b10c7 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -437,6 +437,7 @@ void hl_hw_queue_encaps_sig_set_sob_info(struct hl_device *hdev,
 			struct hl_cs_compl *cs_cmpl)
 {
 	struct hl_cs_encaps_sig_handle *handle = cs->encaps_sig_hdl;
+	u32 offset = 0;
 
 	cs_cmpl->hw_sob = handle->hw_sob;
 
@@ -446,9 +447,13 @@ void hl_hw_queue_encaps_sig_set_sob_info(struct hl_device *hdev,
 	 * set offset 1 for example he mean to wait only for the first
 	 * signal only, which will be pre_sob_val, and if he set offset 2
 	 * then the value required is (pre_sob_val + 1) and so on...
+	 * if user set wait offset to 0, then treat it as legacy wait cs,
+	 * wait for the next signal.
 	 */
-	cs_cmpl->sob_val = handle->pre_sob_val +
-			(job->encaps_sig_wait_offset - 1);
+	if (job->encaps_sig_wait_offset)
+		offset = job->encaps_sig_wait_offset - 1;
+
+	cs_cmpl->sob_val = handle->pre_sob_val + offset;
 }
 
 static int init_wait_cs(struct hl_device *hdev, struct hl_cs *cs,
-- 
2.17.1

