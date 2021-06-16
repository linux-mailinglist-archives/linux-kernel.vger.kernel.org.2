Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6583A97B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhFPKjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhFPKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:39:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD9DC061767
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p7so3513897lfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 03:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/f1rY0k6EQWoltoVI239rx9YFVi0YDoyX+ARCpEzBL8=;
        b=llG26ISbSHMQx9SAWWK0Ew5GahaWNLFUKYF3eJzC4p33bRd9Be60A93cKFvJyK4UOz
         zPO06ptAc1p3sQr86nkEQV8CU+83twF95m4ySOp2qgCoovEzCa6CV7PO8ZkWDLhgPps1
         A+GHdG9jn2/J9PtUYjwcKSxCrFrp6ThpBnl0N9E2qlo00n53XZvUbugI9hIpCRlDBDg7
         12rNUWk/l1v9+geVlXECny1yce1nLA1zjK/tyvFZ/dspVr+VBcfQmO7KIxe/fc/iVTeq
         672zro9XoKRvv8/Q6nwkbWoNctEryLJwZW+t5S1qaS/IzciywYhp/zMpyQ4aduoFdfbc
         VQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/f1rY0k6EQWoltoVI239rx9YFVi0YDoyX+ARCpEzBL8=;
        b=a+gt0tlB3Bb+w8Ett/GPCN6ctI5agAutIbf/ei735MhRQcOd2JrdhOiSqBthsi5PzI
         evrV5OZ4e4WP9mWMQaWIYa0iFH1QfpeD3exzwayHccxh9evWIXTlyyM1oVPIK1BcDQ2k
         epaRzm8XUierQmCDG3AqwL1RCT6tgwlV+LMAjV+5lj1Bmsm6PblvaCtO9zePcV2OZgJ6
         W2oaP+PGtp4xOntneCEf+v0mSzCS9vkA6S2jxRqOm7BjodZ5TYc5ek9ZsBOwvX8b9a3I
         SCTrdp70X2T5vcjf7/wjxaiQJaM5hwyrQhlLRG8LQoz+PgNKvuNz1d3V/uvktHGWmniu
         zYgw==
X-Gm-Message-State: AOAM533x0Qcob/kAkJhsOy83nsZil/zGiprV9xiwzBWIGHrehge0oKwL
        Yrw6uatrBlC/vXJsab+MdaRwIVCGdUab5Q==
X-Google-Smtp-Source: ABdhPJysfxzlZ2ZCBCeU6Y2xQDldKhQEt20KJ5s961GMZJdmsWDBpqHYUiF3UpWheyplkOkqFfgg8Q==
X-Received: by 2002:a19:550f:: with SMTP id n15mr3209225lfe.660.1623839833192;
        Wed, 16 Jun 2021 03:37:13 -0700 (PDT)
Received: from jade.urgonet (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id m17sm205621lfh.288.2021.06.16.03.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 03:37:12 -0700 (PDT)
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
Subject: [PATCH v2 4/7] tee: fix put order in teedev_close_context()
Date:   Wed, 16 Jun 2021 12:36:46 +0200
Message-Id: <20210616103649.2662395-5-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616103649.2662395-1-jens.wiklander@linaro.org>
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
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

