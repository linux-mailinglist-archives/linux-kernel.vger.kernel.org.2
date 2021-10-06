Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC20E4238A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbhJFHSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbhJFHRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:17:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D823C06174E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 00:16:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m3so6425258lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JoodeoEbWA8KFPSDaqBt6HBmf+JeOe0hbWt7ocF/yag=;
        b=qLQ1B0XbhoR27QcdtLieBrU3iXl/MRVIKP5D+RBZ+zZI3rpJ4YAduePW5RAFnMwWtY
         IzEcaXV+jq4nTwZ+78yRdxll/2yB5fGI1CZm6guqkVNAAo8jFXzkSBjSIpEHgu9oxNmQ
         49tF/YrA8FI8qxxUZe5jfdLb+vOfb85XExNYT2CwvyQhMkTlSRNgATXtlzrgemmWMgPv
         n4Mio/t9meJCoefgGLDjvz6t+pm/4OmRhtUJFNLfxmVvZDZqzXjpKANqxeZZejuEgbqT
         vm8ulcvGC2myrRHg/oRsoPVz/A2MBngKMXxTI89DwAXP+fhpIYflXufqInSgXEJsG2Qb
         1t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JoodeoEbWA8KFPSDaqBt6HBmf+JeOe0hbWt7ocF/yag=;
        b=soXZqVPL9JkWJOAQH/125x8JAJkm93gIkT5YTbjIgiaVw2bDBdIJk/SUvtcdIsv5aY
         NsRe+3ySN2HZUXBQUiiBh+1CamhSKobApxnfTPFbpjmqQNJWHvHXBSnKFgzk5gIhhjO0
         2V9h7jS7A6HumXmk5c0MyuoO+NFtIXRultZHuzu50E2kYOIqzAU0u5SLVln3qAfu6HQb
         uA6zVb1yPyU8/fP9oVq+UPqKWV39le8VMgnihsB7Jkh5c/Q52q4MBHhSooDVi+QxmIB5
         DKjkuysQWP/IKlxoUrg9wS428gxb3ducyPlhrLPC/rDjSTQcUnrm/iW86bPeEYScm5+T
         jFVQ==
X-Gm-Message-State: AOAM533hXZvBLKPRaWBC+CG2OEpdVxu40R7M5XIFZkyMH0VBaXCX1bH+
        tJITtmoPUha50ljX2hqYOoTIFYuDfTIUhA==
X-Google-Smtp-Source: ABdhPJx8JCV8rcwVFwjsP9B+UkHcLTmCs0PuzEQqQFbB4E7Z32nm6qHW8yNbtzF1LVXtIqs45hUj4g==
X-Received: by 2002:ac2:4285:: with SMTP id m5mr7719567lfh.343.1633504559560;
        Wed, 06 Oct 2021 00:15:59 -0700 (PDT)
Received: from jade.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id y7sm960376lfk.143.2021.10.06.00.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 00:15:59 -0700 (PDT)
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
Subject: [PATCH v6 3/6] tee: fix put order in teedev_close_context()
Date:   Wed,  6 Oct 2021 09:15:43 +0200
Message-Id: <20211006071546.2540920-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006071546.2540920-1-jens.wiklander@linaro.org>
References: <20211006071546.2540920-1-jens.wiklander@linaro.org>
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

