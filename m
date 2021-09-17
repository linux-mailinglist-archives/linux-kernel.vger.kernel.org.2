Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14CA40F81D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244707AbhIQMmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244634AbhIQMmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:42:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1ED7B61212;
        Fri, 17 Sep 2021 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631882446;
        bh=2CIDCX6x1oa4sPUosrPEzBkEMFmr/pEDHd19Dz5rsho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pw3RNRPS9HFzowWpSft1GEM0fHx93pRQguP2iuHvQ1GA2qvcRNPNuoFoTgDO1Lnsq
         //tDEKZIHV3GpDA91n9gmNDZyjVmaTosLytMfrFGt8ozW1g4CXO+oHH73sAkP3OkPe
         cHhsI5fQI7TATvMX3o1eZB3Nmz9wzXrD3iluaWw5G4m4EHROebg1JtyvcupF1JqZye
         d46m2DcjJc5f7NHqOK1YY0CepgrzaxI+GVp/D7gsmCzZSLNcbsnJ//uOMW+pGvvNe0
         xBpnH2f1u+x7sVni3MAy/KdwWgTvhBcQlfaIO1PJp4Jxw0MyfXq+QZvG5eIAG4AX3N
         +z24RyYD2gwTg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, sj@kernel.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mm/damon/core: Print kdamond start log in debug mode only
Date:   Fri, 17 Sep 2021 12:39:58 +0000
Message-Id: <20210917123958.3819-6-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917123958.3819-1-sj@kernel.org>
References: <20210917123958.3819-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logging of kdamond startup is using 'pr_info()' unnecessarily.  This
commit makes it to use 'pr_debug()' instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 30e9211f494a..874558a790a0 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -653,7 +653,7 @@ static int kdamond_fn(void *data)
 	unsigned long sz_limit = 0;
 
 	mutex_lock(&ctx->kdamond_lock);
-	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
+	pr_debug("kdamond (%d) starts\n", ctx->kdamond->pid);
 	mutex_unlock(&ctx->kdamond_lock);
 
 	if (ctx->primitive.init)
-- 
2.17.1

