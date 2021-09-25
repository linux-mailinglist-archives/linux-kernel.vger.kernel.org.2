Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7D4184CD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 23:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhIYWAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 18:00:48 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:34556
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229997AbhIYWAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 18:00:47 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 91AA23F070;
        Sat, 25 Sep 2021 21:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632607148;
        bh=X8bcr5IsgetMjo+uz2jNmTIyMflSWfgaoOmzS2irH7U=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=eXvfkiyt68V4JBa92l83AG/m0+VHiYqED7qIiVcRX4a+zW74yufVRCqzMVFP/CjyG
         CSyuwHwLvJbXxN7r0HrWYg8ZYp9vlmysFcgBaBG78LN9pNr+Pmkrqtm7xjYKwUSi0D
         VlZ7q5vfUUIeIuN4tfCuzKeuEix6JFbeOs2m+4Z6HfJsWO+aksRtp5hlh6MQCM5l09
         0fvkBhyG/6Vo3wOvUJgPM5UtXk+kLEPR4FlDhVf7bBwDe6SyR81VgkieKzvrVIZqWf
         8cT50xiIJMMSeLDBwE6zzwgve6OW+bVeGWX1QJRaf8riIVAKmlmwXO/mOuMc5P0pD+
         GOXMaK9jENseQ==
From:   Colin King <colin.king@canonical.com>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/core: nullify pointer ctx->kdamond with a NULL
Date:   Sat, 25 Sep 2021 22:59:08 +0100
Message-Id: <20210925215908.181226-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently a plain integer is being used to nullify the
pointer ctx->kdamond. Use NULL instead. Cleans up sparse
warning:

mm/damon/core.c:317:40: warning: Using plain integer as NULL pointer

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 874558a790a0..c8665c80577a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -314,7 +314,7 @@ static int __damon_start(struct damon_ctx *ctx)
 				nr_running_ctxs);
 		if (IS_ERR(ctx->kdamond)) {
 			err = PTR_ERR(ctx->kdamond);
-			ctx->kdamond = 0;
+			ctx->kdamond = NULL;
 		}
 	}
 	mutex_unlock(&ctx->kdamond_lock);
-- 
2.32.0

