Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E547B42BE67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhJMLCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 07:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhJMLBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:01:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F0AC0613AE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:57:18 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so4111116pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmspT9v4sA/scFmja8QBhp8iujwCZQoVmVVy3lhUAPw=;
        b=GzaFZFELa5u5ICSJTCgBw25KydWG7aF9ucRHVeV27g18BGy45TJtjNp97c/wq9CJwn
         10h4ly/cYuxAUfENyX4RELnfsqzDXLdP33/jBp1GFLNon4519yy5PJqds3ukem36gMEn
         ZpsSITqxK1kEldtF/zg6UUJqYN2Smsulg/0+Qhka7M0caGo+GdGgKUQlX+ND45l4UsKP
         ahZz4CAOxNVXdzd/9nQa131A3Ql8jK6fZxQ6fcRMfGJ9cNB+FR8dCxseM5/oVmVbioau
         PsWNpRoeTgzuMp1W0ojfKaOj5bVSUalEfgx3cA/+ncpVRu6J4fsOWLsoUQQ7ECBM+s1x
         g1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmspT9v4sA/scFmja8QBhp8iujwCZQoVmVVy3lhUAPw=;
        b=Y2nDHgSdbZgerlrUZuLkr3a8w22ZH2DJ63JHV+MbSTMragkT+z1C7+e1JGGBWUmT6R
         9LWSNwvLsLhe4nleVjM1Fd2WHJd9yfVL/VSras6pWgqwm/76SWPS4lcAiE5M3RTKcRNV
         Byto/DNje8ewFZ36VnIsEqXxa1hV/pvPCP1pEzcDrEiRfuEzVm0LQreJmKAnpFzMws0S
         2CMoFSWjiwy5oCNYb7JWQn4E2qcpvhhPk4IL0WYNRud0k4XNEgw2/qJEReCuQA6YzF3L
         l0pG9615TfeD2tFp5VWHU5d2O6fqOKFGWbqdrFNf3hWH3tCwbSjm7kLJJ2ahvYzYOqjL
         CG3g==
X-Gm-Message-State: AOAM533fkyZDz6ZToi6eEW/La0kBgeDhbXflRdXVo8ZVuNmgcQOtmh5y
        Doh+bhZiG6BoNOlc/CMXUMxc/Q==
X-Google-Smtp-Source: ABdhPJzmSj2IalSjIh3ROQZUOOW9esrWa3UxvoxBfYyLPiGIK6oNIqQjChFfkhTVnJBpYE7NL6cM5A==
X-Received: by 2002:a17:90b:4b89:: with SMTP id lr9mr12677708pjb.11.1634122637643;
        Wed, 13 Oct 2021 03:57:17 -0700 (PDT)
Received: from localhost.name ([122.161.48.68])
        by smtp.gmail.com with ESMTPSA id b13sm6155351pjl.15.2021.10.13.03.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 03:57:17 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v4 18/20] crypto: qce: Defer probing if BAM dma channel is not yet initialized
Date:   Wed, 13 Oct 2021 16:25:39 +0530
Message-Id: <20211013105541.68045-19-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
References: <20211013105541.68045-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Qualcomm qce crypto driver needs the BAM dma driver to be
setup first (to allow crypto operations), it makes sense to defer
the qce crypto driver probing in case the BAM dma driver is not yet
probed.

Move the code leg requesting dma channels earlier in the
probe() flow. This fixes the qce probe failure issues when both qce
and BMA dma are compiled as static part of the kernel.

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index cb8c77709e1e..c6f686126fc9 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -209,9 +209,19 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	/* qce driver requires BAM dma driver to be setup first.
+	 * In case the dma channel are not set yet, this check
+	 * helps use to return -EPROBE_DEFER earlier.
+	 */
+	ret = qce_dma_request(qce->dev, &qce->dma);
+	if (ret)
+		return ret;
+
 	qce->mem_path = of_icc_get(qce->dev, "memory");
-	if (IS_ERR(qce->mem_path))
+	if (IS_ERR(qce->mem_path)) {
+		qce_dma_release(&qce->dma);
 		return PTR_ERR(qce->mem_path);
+	}
 
 	qce->core = devm_clk_get_optional(qce->dev, "core");
 	if (IS_ERR(qce->core)) {
@@ -247,10 +257,6 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clks_iface;
 
-	ret = qce_dma_request(qce->dev, &qce->dma);
-	if (ret)
-		goto err_clks;
-
 	ret = qce_check_version(qce);
 	if (ret)
 		goto err_clks;
@@ -265,12 +271,10 @@ static int qce_crypto_probe(struct platform_device *pdev)
 
 	ret = qce_register_algs(qce);
 	if (ret)
-		goto err_dma;
+		goto err_clks;
 
 	return 0;
 
-err_dma:
-	qce_dma_release(&qce->dma);
 err_clks:
 	clk_disable_unprepare(qce->bus);
 err_clks_iface:
-- 
2.31.1

