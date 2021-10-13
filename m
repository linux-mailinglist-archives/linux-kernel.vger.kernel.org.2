Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A142BA82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhJMIgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229830AbhJMIgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:36:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F0E660C40;
        Wed, 13 Oct 2021 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634114039;
        bh=SP/aQr6zLnIJau68CWzQYmMMCmXPURcAfsK/jc8rn5A=;
        h=From:To:Cc:Subject:Date:From;
        b=Xid1t30VjLj/ZsF0tp7oxrEww076tmL8JErILJNK3xScAzUeJrzH7IZnsLQXtqMl2
         Li6K5ELCk3xpQE26vlOS6n7wF+RzugKi2CxC61knTPp20YtC4F3gu3sEyIE9W6eHt1
         srBSUrP19/bH5mki/7MWubDx0rMwbqtwKXQmAmtEVOTQ8A/LXIcGgZITOuVzNy58tW
         8Y3Ru+cBDNycMiEyfmSL2kazRf5EJUjEzSLXw5EJVzGwxx8xNW1tV/N9KmS+uvxGw/
         jBZ874Q5Lt9x2l+UAdb+SdEb/NAB0DMI+cUoZ0Pgia12nqQ08eawH4i7+5JVBsZIFL
         h5lk1tuITRG+Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH] habanalabs: context cleanup cosmetics
Date:   Wed, 13 Oct 2021 11:33:53 +0300
Message-Id: <20211013083353.7547-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

No need to check the return value if the following action is the same for
both cases. In addition, now that hl_ctx_free() doesn't print if the
context is not released, its name can be misleading as the context might
stay alive after it is executed with no indication for that.
Hence we can discard it and simply put the refcount.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 22978303ad63..d0aaccd4df2c 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -181,12 +181,6 @@ int hl_ctx_create(struct hl_device *hdev, struct hl_fpriv *hpriv)
 	return rc;
 }
 
-void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx)
-{
-	if (kref_put(&ctx->refcount, hl_ctx_do_release) == 1)
-		return;
-}
-
 int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
 {
 	int rc = 0;
@@ -392,7 +386,7 @@ void hl_ctx_mgr_fini(struct hl_device *hdev, struct hl_ctx_mgr *mgr)
 	idp = &mgr->ctx_handles;
 
 	idr_for_each_entry(idp, ctx, id)
-		hl_ctx_free(hdev, ctx);
+		kref_put(&ctx->refcount, hl_ctx_do_release);
 
 	idr_destroy(&mgr->ctx_handles);
 	mutex_destroy(&mgr->ctx_lock);
-- 
2.17.1

