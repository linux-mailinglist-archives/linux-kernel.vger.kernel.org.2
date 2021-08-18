Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE33F0501
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbhHRNkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237517AbhHRNkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60B91610A7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293975;
        bh=2c/rNwI8XCexnhF5mC2zHZ9EM3vaTUzpyAV4/Dx6Ado=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=q+k6K/YPJhu7GQODX/vtkabVJ9QXHKlKXgLP6NmWPpoStWNjhcbrGO3CbK/p3miWt
         yUOL3K51RRz/BKAyknj0o0lfKKelWNfGuKFPFAh8EL2qqB6988tcb4lYxLU6n8Mb29
         oUL5hBKZHVDbGcXSH//4g8PCLf5SlqL7aCrHvdpWsahr5adLMv9JYIhiMH4fcdASVS
         CE4kRHhAJ9EeLhoedrXrLkI2WsmlBYvbvL2G3504HM2ZFMadSa1VPh735ehp2MOCQn
         beN1tpO1yRx7BwRcNBYDZQaH4ZSYnW/LlnztmQd0Jd+47K6z7/olqb+yRxRwal+w7e
         y1IeQ3+ovAmUA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 08/16] habanalabs/gaudi: restore user registers when context opens
Date:   Wed, 18 Aug 2021 16:39:14 +0300
Message-Id: <20210818133922.63637-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because we don't have multiple contexts in GAUDI, and to minimize
calls to is_idle function (which uses many register reads), move
the call to clear the user registers to the opening of the single
user context.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 3fbcdb013a7e..e9a8ed96fe65 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6088,7 +6088,7 @@ static int gaudi_restore_user_registers(struct hl_device *hdev)
 
 static int gaudi_context_switch(struct hl_device *hdev, u32 asid)
 {
-	return gaudi_restore_user_registers(hdev);
+	return 0;
 }
 
 static int gaudi_mmu_clear_pgt_range(struct hl_device *hdev)
@@ -8658,10 +8658,20 @@ static void gaudi_internal_cb_pool_fini(struct hl_device *hdev,
 
 static int gaudi_ctx_init(struct hl_ctx *ctx)
 {
+	int rc;
+
 	if (ctx->asid == HL_KERNEL_ASID_ID)
 		return 0;
 
-	return gaudi_internal_cb_pool_init(ctx->hdev, ctx);
+	rc = gaudi_internal_cb_pool_init(ctx->hdev, ctx);
+	if (rc)
+		return rc;
+
+	rc = gaudi_restore_user_registers(ctx->hdev);
+	if (rc)
+		gaudi_internal_cb_pool_fini(ctx->hdev, ctx);
+
+	return rc;
 }
 
 static void gaudi_ctx_fini(struct hl_ctx *ctx)
-- 
2.17.1

