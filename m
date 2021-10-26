Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C046D43AE17
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhJZIed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhJZIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:34:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E8C061224
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:31:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h11so5990998ljk.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDFhL54jBz3G05V/OraPaakr11gEhiPI9haVEV4Ys5E=;
        b=ZHi/y1ckyJDjwvb69REwPJQs4kGYBOXGfL3+pN25jVWAnTb2vKBp6jHF3eT3WtRHBM
         AUKxjjI9Y1MAMOa2cMBBmpQq1yWCcw5kPu6bxnNkHnVTvm6Od5nnp/Qz2Lw1il+AtgOJ
         UO2WlWEILwrTrxFEUQPtKcp2R3ZyKvGAktqwiJMEx+mlnbeavtRyiq4kUSBBiuVDRg5/
         jtoV5pnrzqYaHP/2Ex/cQB9QnIeN3zq2KOpSX4MR80M4kdxOVAWd4Tt5u4jtFajw5QWd
         v6MCweJFr7CAwUr2g1r4qe/og5hMaHzWypDTsintIjJTYWttSWDIHgqYrSKG841m/fnG
         zYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDFhL54jBz3G05V/OraPaakr11gEhiPI9haVEV4Ys5E=;
        b=CWbYWQPeu02NAeTZwc/qg+81txHIvX8D5LtXtIdWA76svlIEmAH5d2tGO0ts4Pkkl4
         PSj3aMwk42ba1/Wm0jtWFicsp/3FpBeOMGU4aW4ucNufmp/TnPSOXVT1izTd6YXbkqK8
         6R3q2ki/J/4SAqO2Vsoaswte9WP5d5a2T6jFBb+Jjnu1J3lJumhv6l8xugzxwhmMrvpV
         I6rwpnYIBp1T+2cqmupLWWa0DA+W653BFxIoSh+fa5KS/wGkoduzReNssnKNqTsFC1Id
         MHU2B8H+3A384Ut5SM5BosA9Bpf+Ko/jH3zCd3Tc/JlS9kvL3wStn6gLwIr/ppxBrrNP
         zbwQ==
X-Gm-Message-State: AOAM533oucMQDmc7RVb6kCw9A7neSMPWaWiIaiiRycSq7uM81FZ8vw4b
        LQ9iEnNgHXrhT51sgkb3N6zmYf9kb5/TODEU
X-Google-Smtp-Source: ABdhPJzBJhd2BrrH13cjClJSpD9eKt3Bq+FtJpQvAGc+zfqBSWAgY3ScNVoHesZAWSmLf0vhy2Fmnw==
X-Received: by 2002:a05:651c:327:: with SMTP id b7mr4963654ljp.85.1635237106519;
        Tue, 26 Oct 2021 01:31:46 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id e4sm1944598ljn.131.2021.10.26.01.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 01:31:46 -0700 (PDT)
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
        Marc Zyngier <maz@kernel.org>, jens.vankeirsbilck@kuleuven.be,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v7 3/6] tee: fix put order in teedev_close_context()
Date:   Tue, 26 Oct 2021 10:31:35 +0200
Message-Id: <20211026083138.1818705-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026083138.1818705-1-jens.wiklander@linaro.org>
References: <20211026083138.1818705-1-jens.wiklander@linaro.org>
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
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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

