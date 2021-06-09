Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BBF3A0C2E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 08:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhFIGLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 02:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbhFIGLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 02:11:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99A0C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 23:09:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w33so36168375lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 23:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/f1rY0k6EQWoltoVI239rx9YFVi0YDoyX+ARCpEzBL8=;
        b=Nr0mzq62bjXdj4oL45yRrqwFuW+HGvFzMbQMIzEFoUaSs+cxX+fpKa7AgBKhx3MiAm
         1uJ3/jC+BKZioL6fZ/Oc0TWauJHtvthu868NYnqT4v8xEbOJOCOwBZzbbmfCa9Ou6EWT
         IXXUbE5LNGnstLVBt/icT8AuhXmyT29B6OFf1MlIJWGQiS6YhMx3JvW4qv35/0m4U9nN
         8+L4iJWz+nve2IXifP8QOrywJzFI75m0kZtoQWfC9mNi6RtjRV1aV7Ach5Aaumz7EftU
         LECkiDxh1Wsa168PTiTCewCHwnbO6xERms9QkJkLjwWqcpO4vdPOr27fxeksBp0BFkN2
         +ddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/f1rY0k6EQWoltoVI239rx9YFVi0YDoyX+ARCpEzBL8=;
        b=OymQEuOEZGt6lj7qgRZFeoHZ7TDJfhlE/RjuNcvpsRRVJjzBTonlvAyQk9w6lZ2rU8
         rDRrWz7rS+OUkXVjhNsa+5i4sUHFW2Mkpq6G8GkFivKFo7pSPciXDT/Bkll1YzzyMxE/
         g3Uy/Y2T9zUsCfF291hWXtxb4/OQNjOCpIG1c8wBUN3hdn10mi70ENKTBWNK/m+WJOVt
         ee9fLLHCZw4jlCFMAgfjS4+js3D3xEz2LhN/ct+PpDXTxlggYM149BzsR9NXdFDpJtOq
         xigjiStwyh33sdgBzh2YaN0mg3p+KARQkXCL2vsGQysXqaypGe7UdWrOLX+13qQluhJN
         awyw==
X-Gm-Message-State: AOAM5312QK7m+ZrUBeijSjS04oyE28PelhZ/eLbW5sBp4EVlcXZhcB85
        VjHqWoqr891sgTVJrM/jKH/sTp2jDxNU9w==
X-Google-Smtp-Source: ABdhPJwot25EKkCKM4HEq641t4VhpqW7RwDZWfJJuawi81MP3DhszivYqKpP78Ecs8By3CaqdLjPVw==
X-Received: by 2002:a05:6512:3baa:: with SMTP id g42mr18023216lfv.195.1623218958910;
        Tue, 08 Jun 2021 23:09:18 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id l26sm213735ljg.87.2021.06.08.23.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 23:09:18 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 1/4] tee: fix put order in teedev_close_context()
Date:   Wed,  9 Jun 2021 08:09:07 +0200
Message-Id: <20210609060910.1500481-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609060910.1500481-1-jens.wiklander@linaro.org>
References: <20210609060910.1500481-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this patch was teedev_close_context() calling tee_device_put()
before teedev_ctx_put() leading to teedev_ctx_release() accessing
ctx->teedev just after the reference counter was decreased on the
teedev. Fix this by calling teedev_ctx_put() before tee_device_put().

Fixes: 217e0250cccb ("tee: use reference counting for tee_context")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 480d294a23ab..f97d95b50773 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -98,8 +98,10 @@ void teedev_ctx_put(struct tee_context *ctx)
 
 static void teedev_close_context(struct tee_context *ctx)
 {
-	tee_device_put(ctx->teedev);
+	struct tee_device *teedev = ctx->teedev;
+
 	teedev_ctx_put(ctx);
+	tee_device_put(teedev);
 }
 
 static int tee_open(struct inode *inode, struct file *filp)
-- 
2.31.1

