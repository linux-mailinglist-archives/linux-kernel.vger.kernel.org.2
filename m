Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F07443EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 10:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhKCJFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 05:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhKCJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 05:05:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A21C061205
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 02:03:05 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g3so2595273ljm.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDFhL54jBz3G05V/OraPaakr11gEhiPI9haVEV4Ys5E=;
        b=JrbkOJN0AVTm6aU03vDx3RA7J3nBQq4dZa143tOdEgrSo7btHpTOx99WIZ/Ux9cVAI
         P4y1XDNIgA+r0IulEXK4zuoXLG5PAPr5bc9n6widMRrpCG+vIrQIkNOlIimZgXPkgsZq
         tG7os6N3rCTTTlwnplk24JpP02zL/aP6hFgKgtJdb8kmF/yM/Qxx10WXQz4GSsXcuH76
         OXlNleVoGGpr1KaXJdrMvws8NoRfIoxTcPVYbHGHSkTZUC8Pt+WzWxi79zukB3Swp+SF
         1Ul/eZQRyUinBps9OsfaaQrMNS+AwOiskYcVb9gyowMOWDyGhF6wBIHTH6mjoehruamB
         zyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDFhL54jBz3G05V/OraPaakr11gEhiPI9haVEV4Ys5E=;
        b=2NEFP4e4ck5calaU1KJiW4iNeFzzAbA2IoN4nkpuMyMSG7TCfHnxlilI58XHheSDiM
         8dKT+HKbEYcTOEDgh10ZRnqmMjZXF1rHoQPixMfAkqICKyuwopOKUX/1sEtBMIV1ZUnt
         5D+YC436X1qf3t0m44vX618TpAXCX9fUVQf8WSyGmvA6qNhoZKasJf0P6vkWDp4Hllvi
         199DhLFDaYKZDUCEQwB8meCnoeSGuBO92WOAdbrDZ1vFPgKhb5rXkmH9/d/+f1PeOUri
         o5ZbczenZqTofQVcE49zKFI95uRVLmfsi8pTT6hJg9L600sfH4b+fHEOfBVK5UytQ/YU
         PbDw==
X-Gm-Message-State: AOAM533kEZQfEeLBEZN5MkAiUJgJpCiu38We5FK5pkuTWpsKihs2/5Xz
        gZmIKxeumT7XKhMn4+JuXlLQ7vf7DMxBu7zoc0M=
X-Google-Smtp-Source: ABdhPJy2IrqOF3ogwb+7EqZn1rFu3bhrk8vJtGRNZ5plknFzvRDWYEdyK53VxBLOuXPASCA5Skn+bQ==
X-Received: by 2002:a2e:9e13:: with SMTP id e19mr45531615ljk.494.1635930183843;
        Wed, 03 Nov 2021 02:03:03 -0700 (PDT)
Received: from jade.urgonet (h-94-254-48-165.A175.priv.bahnhof.se. [94.254.48.165])
        by smtp.gmail.com with ESMTPSA id w16sm124373lfr.233.2021.11.03.02.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 02:03:03 -0700 (PDT)
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
Subject: [PATCH v8 3/6] tee: fix put order in teedev_close_context()
Date:   Wed,  3 Nov 2021 10:02:52 +0100
Message-Id: <20211103090255.998070-4-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211103090255.998070-1-jens.wiklander@linaro.org>
References: <20211103090255.998070-1-jens.wiklander@linaro.org>
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

