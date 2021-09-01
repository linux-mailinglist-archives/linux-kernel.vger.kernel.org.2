Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1CA3FDFFB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbhIAQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343879AbhIAQeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:34:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 571CB61053;
        Wed,  1 Sep 2021 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630513995;
        bh=kyi07a9FS8QoXJ5j2m/nJgNQaGixTuMrEn89ymrUfJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUd8r9f1/QU5Zv5dXnKYOPCcz+mw5QIji12Om2tipQrdTVGt5fFQv08xbLYy+bNYW
         +mNutcfpF4kKz6vPkpXMetlJAsEqJ+ZA4D7S/St5SRbo5JLDKRwHessafUm6dbUPjc
         ifMpD9o2vSBUjrGwhJuBt2NDsWKRDLVnNYuemknaeruzXZM35QrVeeiusaqCQcnqSo
         1yeNm/YVHxr7tCHEH3gidwmDKxh77/pGaC3ZoYXWErIXabr6RuobYz0UN5XF+W3NzT
         crd/mDleoeBnkpxVmtV6Xg95UcqK2UTrWA1ymt88wtMdDwhAQcc3RhALM/vun8sq38
         f/essF6iZ4lKg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 2/2] habanalabs: fix kernel OOPs related to staged cs
Date:   Wed,  1 Sep 2021 19:33:09 +0300
Message-Id: <20210901163309.112126-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210901163309.112126-1-ogabbay@kernel.org>
References: <20210901163309.112126-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

In case of single staged cs with both first/last indications
set, we reach a scenario where in cs_release function flow
we don't cancel the TDR work before freeing the cs memory,
this lead to kernel OOPs since when the timer expires
the work pointer will be freed already.
In addition treat wait encaps cs "not found" handle
as "OK" for the user in order to keep the user interface
for both legacy and encpas signal/wait features the same.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c     | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 9a8b9191c28c..deb080830ecb 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -405,7 +405,7 @@ static void staged_cs_put(struct hl_device *hdev, struct hl_cs *cs)
 static void cs_handle_tdr(struct hl_device *hdev, struct hl_cs *cs)
 {
 	bool next_entry_found = false;
-	struct hl_cs *next;
+	struct hl_cs *next, *first_cs;
 
 	if (!cs_needs_timeout(cs))
 		return;
@@ -415,9 +415,16 @@ static void cs_handle_tdr(struct hl_device *hdev, struct hl_cs *cs)
 	/* We need to handle tdr only once for the complete staged submission.
 	 * Hence, we choose the CS that reaches this function first which is
 	 * the CS marked as 'staged_last'.
+	 * In case single staged cs was submitted which has both first and last
+	 * indications, then "cs_find_first" below will return NULL, since we
+	 * removed the cs node from the list before getting here,
+	 * in such cases just continue with the cs to cancel it's TDR work.
 	 */
-	if (cs->staged_cs && cs->staged_last)
-		cs = hl_staged_cs_find_first(hdev, cs->staged_sequence);
+	if (cs->staged_cs && cs->staged_last) {
+		first_cs = hl_staged_cs_find_first(hdev, cs->staged_sequence);
+		if (first_cs)
+			cs = first_cs;
+	}
 
 	spin_unlock(&hdev->cs_mirror_lock);
 
@@ -2026,9 +2033,10 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 			spin_unlock(&ctx->sig_mgr.lock);
 
 			if (!handle_found) {
-				dev_err(hdev->dev, "Cannot find encapsulated signals handle for seq 0x%llx\n",
+				/* treat as signal CS already finished */
+				dev_dbg(hdev->dev, "Cannot find encapsulated signals handle for seq 0x%llx\n",
 						signal_seq);
-				rc = -EINVAL;
+				rc = 0;
 				goto free_cs_chunk_array;
 			}
 
-- 
2.17.1

