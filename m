Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936DD3D3801
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhGWJE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhGWJEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:04:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF40C06179A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:44:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h11so933480ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JoodeoEbWA8KFPSDaqBt6HBmf+JeOe0hbWt7ocF/yag=;
        b=IQupQu096dOf2RXy1dTEeXIOMGbe6WjJhcaIEXhbvkmYHJXjdMb0znsum0XkoEfm0b
         oZAyT0no0mbv1QNkEJCIL8Ycp+A2wxAnySr21P6vwmTnbM0x54jAaRuSlsmJSsk9KvIc
         3+lzExnUxYmBgMM6D2awrRdlxwmCx0eFrn77sO8iolEDUBqktiTOwi+QBv6ve/3SK65f
         welVLkY/7gXxj/KGu52/SQBYzf7iXLxHHs5Ovc7izB3FaJhmLEwKcyT/7PTU41IsPpqu
         XvEPhAOHUMGRifagj7+ZhmEkZsJdF9rYyoUuXIHuqVnL/DUQ4h6w1oeymhdrXUOT6laJ
         6eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JoodeoEbWA8KFPSDaqBt6HBmf+JeOe0hbWt7ocF/yag=;
        b=otAJWy4gRNgyKFbqkQo9DvNkJKTw/sa0gt+Z8zYCB3cuICOLwuJRRWpvrSMhDZviDj
         zLCG760rBEYWABJ/jfFhu9t3NYZ+dlpKPWu0m90o/bqCtS6U7OtlTr54x20MiRfylL7+
         EfRZaxfFRRiZtAwpyq0FJZweQRjO7TY3aT4aj1uwVC0zDQdd9J31qXQLCVll9bCp9UhP
         T252RMYWawM0RhwLHDrIaxfP7c9zq7O7Uz/n53sTqag7q9gLG1yVj2+HM9exJsyoO9Nn
         0CNa+LiT+PNjmIElrwjn5ImVPE3JiPEy1aCnLKu+OZBd3c+7XWM3tRtau3QtXKk0AVZ6
         nIhg==
X-Gm-Message-State: AOAM533GMJlVoWhGCf+hivXe3cMQsKmO5J6MDq3n0QGd9dnm65OwSElb
        tBnwcGpziRm6ppxedA92Oxf9JCJylUhizFjU
X-Google-Smtp-Source: ABdhPJxthOMwVWH+D74X2QymqEcjwWIzgiPvVu2K8kpmy+fsoCGXSl6heRTr6xFDRTRKY7MJE5SvuA==
X-Received: by 2002:a2e:9b10:: with SMTP id u16mr2747522lji.228.1627033473706;
        Fri, 23 Jul 2021 02:44:33 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id f2sm403808ljq.131.2021.07.23.02.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 02:44:33 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v3 3/6] tee: fix put order in teedev_close_context()
Date:   Fri, 23 Jul 2021 11:44:19 +0200
Message-Id: <20210723094422.2150313-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210723094422.2150313-1-jens.wiklander@linaro.org>
References: <20210723094422.2150313-1-jens.wiklander@linaro.org>
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
index 2b37bc408fc3..85102d12d716 100644
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

