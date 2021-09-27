Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A2941A3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 01:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238181AbhI0X0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 19:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbhI0X0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:26:16 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F4C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:24:37 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s75so2750433pgs.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ly15VAemQnFv0oKVr/z7Q4soqSYUoye194ZW1HbvAvA=;
        b=IJ2s3pVRMmEGE3ltGp+WGmpMZngRiTKSlJJr/tNBtgDtT1Ko2KcQpIFDSlj/C7aVAQ
         JYEoZoRvdKH0zpC29MFiHm67rVnIvcKSIJiva2/w41ZJ1fLxQ3bzIFQQzU72p2G5NT7p
         12GSgz8Vo1fJBw8g/xtwFH9jBGSBq7Mj4Z/ImHKQ1/+Wz814ry0UXEtfejS+JIa66kU+
         8ZWSYhhHWwmqMAR9Lzy/k6aPfVHdO76GHyr3vZ2aXLuyQzgB97+dhS9CtFGmDBWGKhbn
         hvKTG1xm1JgoxprPaq04wjgc7RTO1hCHF+Xft36Y8Jdq1lrdZKoiQ7te1pDWJFv+zZMF
         uzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ly15VAemQnFv0oKVr/z7Q4soqSYUoye194ZW1HbvAvA=;
        b=MLYsmxjvAEisgKIqaurw0k5ho6TyaMh0vABp6+MklFavoSgjfw0stD4Xs8SQ6Uhyu8
         HyaQsnNcHojUg8j8aSafZUHBAFCiC6M0Nb5tRQ0Fxfs0dgrQjcBl111Hdnk6CLlWGen+
         9Ka0lvK1yQelMKdyaDoBZfApwZAdPpd9bjGOZjdaoC6vRCREY9CEw8fy7wbhcAi/kpC7
         NeOBl3AxqZRJKrfRKYCAM6GFMy9Iqqk0f4zmlL7z9dhNeYVAQMfLL4fjl9OX3vcUPKDD
         V0vF9CzLRKBnH7bXkbwQC2krLOyWUY8QEP2+M34gVb/aBqCNF7mIK6XmbTFzHoAzDY4i
         g4Zw==
X-Gm-Message-State: AOAM532U/0D6HOpqOGLs1uAcAGbu1zPsvHgWtg2srAmkvJk5R42BPk94
        G2cQODblD8btfpYzUNhcosI=
X-Google-Smtp-Source: ABdhPJyiSUOxQu0y3+oGMO4aOI3uwpQXfkfagXvCDGF+s29Fm2JVk+EuRHuAeab1ckQcPa58mQ1c1g==
X-Received: by 2002:aa7:9e49:0:b0:44b:2a06:715e with SMTP id z9-20020aa79e49000000b0044b2a06715emr2564611pfq.78.1632785077495;
        Mon, 27 Sep 2021 16:24:37 -0700 (PDT)
Received: from vultr.guest ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id q18sm18088353pfh.170.2021.09.27.16.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 16:24:37 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] mm/damon: needn't hold kdamond_lock to print pid of kdamond
Date:   Tue, 28 Sep 2021 07:24:32 +0800
Message-Id: <20210927232432.17750-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just get the pid by 'current->pid'. Meanwhile, to be symmetrical make
the 'starts' and 'finishes' logs both info level.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 mm/damon/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index bc5f74348649..3ef3e2bb091e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -652,9 +652,7 @@ static int kdamond_fn(void *data)
 	unsigned int max_nr_accesses = 0;
 	unsigned long sz_limit = 0;
 
-	mutex_lock(&ctx->kdamond_lock);
-	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
-	mutex_unlock(&ctx->kdamond_lock);
+	pr_info("kdamond (%d) starts\n", current->pid);
 
 	if (ctx->primitive.init)
 		ctx->primitive.init(ctx);
@@ -705,7 +703,7 @@ static int kdamond_fn(void *data)
 	if (ctx->primitive.cleanup)
 		ctx->primitive.cleanup(ctx);
 
-	pr_debug("kdamond (%d) finishes\n", ctx->kdamond->pid);
+	pr_info("kdamond (%d) finishes\n", current->pid);
 	mutex_lock(&ctx->kdamond_lock);
 	ctx->kdamond = NULL;
 	mutex_unlock(&ctx->kdamond_lock);
-- 
2.25.1

