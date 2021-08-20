Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016453F253A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 05:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbhHTDWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 23:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbhHTDWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 23:22:11 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AFDC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 20:21:33 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id e15so6452832qtx.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 20:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+sJ+u/djA+XBJ3U0yapIkY+ojXYJJl4V8fhz0MLb2A=;
        b=a/UAlFYntqRemgO3V0zoIS10A+s9hehi7XjVf42TP0S1KAGUMmW4RizBib2hEWGPZ3
         ypowOxBJZORRA3ujSGxPyvyw43e5FHkF9P9RojAQrHXBIqTcJAQYPA2j/7HyQZfE9LIb
         3E2XQJKl5D6Eek94nTTRkAUJTw5VYANQ9FixS0yQSkya6ZHqcndy8s/UCB76D0UqNKNi
         e9rzIQDEmZowBqhnFjYIKLgpc6W2MHMQ5suh33ZC4OwHKSah/Cg/IgQ+zGp9g9q5KFcg
         nUbodUdTYJwOu+d69Aigl+TzpF2NyRJh3U+VtdLm26+RzIDXNXdi4sKYbYqzH2pLREol
         I8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f+sJ+u/djA+XBJ3U0yapIkY+ojXYJJl4V8fhz0MLb2A=;
        b=qNyPpZKl4T4+o1C2ai0rvQRV4qBKVjogIvfI5BhdnY2bfQ82+Kvj+Pgp0YwTKbXP6h
         SmP61i6CaJ0ntr24ObS0OOnUdUyqCJE83ZQbP8BX9qpuWDKsvn3wYJn+N9Htm4V+2Ygt
         aWwGCBmFn/MnU7woWf58xsci+2jgBXGoQo8Y7oMUIZQuCwORZ4hOZrSwE59z28mpuz8x
         jZuoVW/wIsEegsDPhpTx5HQ7PVXs2aV2BWHuz5bmGrPLPo81WUxEAw3/AGtrhtaTyLld
         QiyjyIJh3cV1xhaZ2zIr7SbVrOf1E2O41sXElksjbR7NOX/p9BnQJfnZqre6kE07ZDoQ
         tRXA==
X-Gm-Message-State: AOAM530xCagoTBNGChEHx7aMvzjxSdQGBaFKJg5qIolq4saGwZYep+e7
        VM5BYnJzWFxtBluTtihNfzc=
X-Google-Smtp-Source: ABdhPJxwQbuNGE6oftVEAH+hfgAXPWXkVhalrMOpHh1R7fIBmI5B8hTa1ENaRYrY0Oa94WqCPYQE7Q==
X-Received: by 2002:ac8:a0a:: with SMTP id b10mr15691200qti.164.1629429693126;
        Thu, 19 Aug 2021 20:21:33 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g2sm2437382qki.42.2021.08.19.20.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 20:21:32 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] tee/optee/shm_pool: fix application of sizeof to pointer
Date:   Thu, 19 Aug 2021 20:21:27 -0700
Message-Id: <c66fd6f831571b53b741350513e36405bba6c666.1629211976.git.jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

sizeof when applied to a pointer typed expression gives the size of
the pointer.

./drivers/tee/optee/shm_pool.c:38:28-34: ERROR application of sizeof to pointer

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 drivers/tee/optee/shm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index c41a9a5..d167039 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -35,7 +35,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 		unsigned int nr_pages = 1 << order, i;
 		struct page **pages;
 
-		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
+		pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 		if (!pages) {
 			rc = -ENOMEM;
 			goto err;
-- 
1.8.3.1


