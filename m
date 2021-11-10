Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E49D44BFA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhKJLEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhKJLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:04:33 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3731CC061227
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:01:03 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q126so1901041pgq.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zajz8wlcJ/lmsrGc+Bku0OSeAwVpyzSmtcytIJmQ1Lo=;
        b=Rl/9j+gVyJ49tf3n/+dMojXFkhnC4v0DXwaB0ozTMpSH5XBLHxac76ivFTKmJcCUpV
         1xZwL16K7gNbIyx+N4e5tENrdu7WD5dxr9/qwfBpb+1Re9eELaTp1/C38ey1rd+Fzz/3
         7867dycwCsInKyRM/qdCzVGXzutOmDbeTUcRRSN/PlIvVcYCji0ysxMHfA3ETYgMWA3K
         RlynN0vw17HB/udoO2JslImMWG0HqHeTogLiFXeAzxjZkHHs1HdlVzzDk12WI3NHbRHy
         umsRGwdv9vDNh4pHdovg4Ehi0Zshyx4VuLOEmAUWN6IfnXloLgaunpPol5SrR81DtOPn
         aGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zajz8wlcJ/lmsrGc+Bku0OSeAwVpyzSmtcytIJmQ1Lo=;
        b=TOFZhcsKM6fCriK7urGx08GSIBw6/Jbgw5mg/VewyadW3fEF6Xb5mfIV1tpkxSFBhy
         ugTiS3C0VgxePOa4XuMdNMe/fkZC0N50nYYh6JXMjd6XvY5TVECIrCH+URfJAWJWe+pX
         oRrBXFhH8HsetOOzYkpTunZ7up6USE0lqDmu3Ty1n0/wJMhohaHYXcVyKiDQo+FPheGI
         B8v9uBt4TBwHkGnn/wZX9M6gd6+7+OAYvuyW2uxZvPlTttwr9hGhLGEU6QsP23MdyTC4
         WxGY0GtHKitJJFZqX/CRThqizjyBT0pZiR5QKWXWM1MxFnKhq/9Ds9Carr/xu4ICnETo
         r24A==
X-Gm-Message-State: AOAM533kgZ6RUXIDuD+TfCe3ax6Tsy0TnwmyidkoGb+S3AT6Pp3eq7Bz
        iegczuEcmn9g2+tJam+F34l3Dw==
X-Google-Smtp-Source: ABdhPJwd7pZZQElvm6V1On9VHWVR8qHrrG6qVljBZ0zfBJeLZ4TAJLio9NR5kWfoi/eDpB8ctO6cIg==
X-Received: by 2002:a63:8bc3:: with SMTP id j186mr10954336pge.250.1636542062715;
        Wed, 10 Nov 2021 03:01:02 -0800 (PST)
Received: from localhost.name ([122.161.52.143])
        by smtp.gmail.com with ESMTPSA id e11sm5585282pjl.20.2021.11.10.03.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:01:02 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, stephan@gerhold.net,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v5 16/22] crypto: qce: core: Make clocks optional
Date:   Wed, 10 Nov 2021 16:29:16 +0530
Message-Id: <20211110105922.217895-17-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

On certain Snapdragon processors, the crypto engine clocks are enabled by
default by security firmware and the driver need not/ should not handle the
clocks. Make acquiring of all the clocks optional in crypto engine driver
so that the driver initializes properly even if no clocks are specified in
the dt.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
[Massage the commit log]
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index dd2604f5ce6a..98784d63d78c 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -213,19 +213,19 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (IS_ERR(qce->mem_path))
 		return PTR_ERR(qce->mem_path);
 
-	qce->core = devm_clk_get(qce->dev, "core");
+	qce->core = devm_clk_get_optional(qce->dev, "core");
 	if (IS_ERR(qce->core)) {
 		ret = PTR_ERR(qce->core);
 		goto err;
 	}
 
-	qce->iface = devm_clk_get(qce->dev, "iface");
+	qce->iface = devm_clk_get_optional(qce->dev, "iface");
 	if (IS_ERR(qce->iface)) {
 		ret = PTR_ERR(qce->iface);
 		goto err;
 	}
 
-	qce->bus = devm_clk_get(qce->dev, "bus");
+	qce->bus = devm_clk_get_optional(qce->dev, "bus");
 	if (IS_ERR(qce->bus)) {
 		ret = PTR_ERR(qce->bus);
 		goto err;
-- 
2.31.1

