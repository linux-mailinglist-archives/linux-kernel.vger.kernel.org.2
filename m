Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2FD4193E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbhI0MMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234213AbhI0MMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:12:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA22261002;
        Mon, 27 Sep 2021 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632744666;
        bh=zQo41+BG4mNBvBGIz4WVC8NNP4Q4VHzJrCrCMLbyr8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TPqMITMwmLGtLaoOHkcOK3U5ASp7I9RvcU4zT/QJyirQDLBS1CnO5ZF3zZeO/yZsZ
         ufPdY02EHl/d9EotPCSttzjs0baW9UrgG84X6xwgqb4dVRh9Uk8NLYMR2hucY0i3oT
         v1rCb/0Toq1ce6Dd5pVmmaGcRTEnWED2G0e7fxluAd5uPKL0e8AsKAgf/uN6BHU2QD
         +y1C0CeM4PDI+07EOoKKSjw+GHHh7hAUr0EWGgGd62ISa5NpazpJ61Ig/AW886pGX7
         tWXG1zbQtNXX8QT7GCNcoqT6IR4jSLljxOvQzL/BGqgBQvT2bqNbWDTEeTxb9MhdYC
         AVDKLV7tgR0iA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH 2/2] habanalabs: fix resetting args in wait for CS
Date:   Mon, 27 Sep 2021 15:10:55 +0300
Message-Id: <20210927121055.97751-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210927121055.97751-1-ogabbay@kernel.org>
References: <20210927121055.97751-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajaravi Krishna Katta <rkatta@habana.ai>

If _hl_cs_wait_ioctl returns -ERESTARTSYS, resetting args would clear
user flags and will result in error in case the userspace repeats the
ioctl call.

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_submission.c   | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 39fc6d4fb971..b479d9ebeb94 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2688,16 +2688,17 @@ static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
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
-- 
2.17.1

