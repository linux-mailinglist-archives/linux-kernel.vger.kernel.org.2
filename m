Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522153B9123
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhGALaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:30:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236259AbhGAL35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:29:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2075561467
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625138846;
        bh=9/4u11h4JiKpCbaEum6ocErjz/XznDxeGE4mOciyT2w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ldUBVhIh/kzBfqHEmdylhpTyTSAJEedTVn3vccB923ZgD20SZepC7bBB8VYYxJpV5
         Ck3uXEG89l0t2rWKapEGR8L216Kb2R9Zi857c/7uoThgF4qRCXmr0ClYwhYQacuDKw
         4odYVjIPmZ2yHrwcJ7Lz0dkxXYpI248/DyOdmix1PmOuHHY2jlYXOVrKwMy56mSkYp
         Y6waTsEQEwslp+XdU0W6SLrQdlrr2MuC5TsedJmd9qwnfBw8RnzwCfKay8N9UNlz5U
         Zeg9I7lgZ/XJ8ZpN78i/cKTlkj0VRACULLtttSAd5Mcz0yNnOI0e7HsYmDE/c9cm0t
         gOfTy5MZspRmA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] habanalabs: handle case of interruptable wait
Date:   Thu,  1 Jul 2021 14:27:15 +0300
Message-Id: <20210701112717.9540-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210701112717.9540-1-ogabbay@kernel.org>
References: <20210701112717.9540-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as we handle it in the regular wait for CS, we need to handle the
case where the waiting for user interrupt was interrupted. In that case,
we need to return correct error code to the user.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 12f20446e99a..997a37e78241 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2102,6 +2102,12 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 			spin_unlock(&interrupt->wait_list_lock);
 			goto wait_again;
 		}
+	} else if (completion_rc == -ERESTARTSYS) {
+		dev_err_ratelimited(hdev->dev,
+			"user process got signal while waiting for interrupt ID %d\n",
+			interrupt->interrupt_id);
+		*status = HL_WAIT_CS_STATUS_INTERRUPTED;
+		rc = -EINTR;
 	} else {
 		*status = CS_WAIT_STATUS_BUSY;
 	}
@@ -2159,8 +2165,9 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	memset(args, 0, sizeof(*args));
 
 	if (rc) {
-		dev_err_ratelimited(hdev->dev,
-			"interrupt_wait_ioctl failed (%d)\n", rc);
+		if (rc != -EINTR)
+			dev_err_ratelimited(hdev->dev,
+				"interrupt_wait_ioctl failed (%d)\n", rc);
 
 		return rc;
 	}
-- 
2.25.1

