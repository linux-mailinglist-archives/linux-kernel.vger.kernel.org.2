Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404EA3A671A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhFNMxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233758AbhFNMxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:53:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA352613EE;
        Mon, 14 Jun 2021 12:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623675072;
        bh=Jme9E6x0WVovqQUEK/dCteoCbgWLdcjtxSOHte2xX/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOGRZqBu3yFZoBxI5CjGxqCqPlD7C28LEdvpOuQQIhtUBm1QcVV0zkUTYt9WO40tk
         FrSxC/p9pfrDxocLg5VjKWvv8T7GceH7qcrIYcpVihP1APXRxAyRszXgR4xop0WVP4
         OFgP90R8tvUiRO464FLeHeAhwD5TDkqtLxh8k5Ip8E9iNZRbu4HdoWdYSZw9N7thAN
         D7LMNWhZuD1R6HBZRQphw2T2vEY3Ykl3im7Vce1U0Jj+9KLo4qEA/ar+cpUlJl9Bq9
         RvkK9CaPGTZhdwu5H4o+HdGWEOaH1nLSpuUac84ee8rxOpY+7MJAYxEQUpDyccLaaH
         69bU0hObWOP7g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 6/9] habanalabs/gaudi: set the correct rc in case of err
Date:   Mon, 14 Jun 2021 15:50:57 +0300
Message-Id: <20210614125100.17627-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614125100.17627-1-ogabbay@kernel.org>
References: <20210614125100.17627-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

fix the following smatch warnings:
gaudi_internal_cb_pool_init() warn: missing error code 'rc'

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index a46ec601a635..e66433d05616 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8393,8 +8393,10 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 			HL_VA_RANGE_TYPE_HOST, HOST_SPACE_INTERNAL_CB_SZ,
 			HL_MMU_VA_ALIGNMENT_NOT_NEEDED);
 
-	if (!hdev->internal_cb_va_base)
+	if (!hdev->internal_cb_va_base) {
+		rc = -ENOMEM;
 		goto destroy_internal_cb_pool;
+	}
 
 	mutex_lock(&ctx->mmu_lock);
 	rc = hl_mmu_map_contiguous(ctx, hdev->internal_cb_va_base,
-- 
2.25.1

