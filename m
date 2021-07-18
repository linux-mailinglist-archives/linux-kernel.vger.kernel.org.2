Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD8D3CC89A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 12:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhGRKwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhGRKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 06:52:11 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAC0C0613DB
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h4so19956590ljo.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPnE4vurU9PkRVowEC7li0cxdIi4nYwl+uw77ku/+po=;
        b=djJXp5zRLDPGCdVtBXwbxLa9g+CRF8URjpJzVuHrCeN0dDkCiZoSerJVx6FFNQciyW
         VAMeVfkWR7+Yo5N5gu+go18RQAVzfzmfT1/RZDRTO2rr/BPrisQxjP8BXE/bHahdfdC0
         jfwy7LpLRmKF1NyPv7iGM5LyQ9d2BCwF0rtcpi2/SVkx60BAkLC//MHal2yPNSouAr4C
         02G5O1X+JBtxvwhE8aKYS/SvqVU/d9yP6gSm9klJtugOItiYZP106lGSKFcUW1mMMn3c
         Yt2dxCfEUQPTr08ofETmLVwAP+98wsSBJOAFbb4Js/JsSoa/U6r4Z5y3FgNneGsZQ25f
         dLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPnE4vurU9PkRVowEC7li0cxdIi4nYwl+uw77ku/+po=;
        b=suJTXfJVnaG+AzEva6813KgL4LrVTUYxV2vyQbww2pBwSkC3YBpxOafPq2UHz7QwLZ
         RlaHkybj3BsUPtKpb03jn6+pAzO0aB+dq+MkrLilNntGA3A9ScesaFpalt8hBnC4GoMR
         9WdeC6TJY2xSOQLXsjmhUUeSsan6+jnT4OQVzk6I0RLzF5xvr5DuVMzX1mEVxie+G2A5
         0I13th3hoRQwzrmI7T0hZZ4jzuTWDbruUDnL5MUDZDNfk6J5HtbjYOsCO6k2gAOQQjlo
         tv5J5aRp7HCM39oLAiDl864KfcmvNjibp9ylyG4+iCamuprLRBN/Aju0bwgwo5/ewaDF
         N5IQ==
X-Gm-Message-State: AOAM5314ye+eis1/GGVOR/QbS8rCwMzw+hQgus80KHdo/veHczcgRnCt
        aXaD7DeFN7zW02ZhFz8tKAPslw==
X-Google-Smtp-Source: ABdhPJxDmsddJ5kwioWxb3qwVxtqYqdE27le2Bym+Zke6QOXYJCSkwJVfWJTrcyMEXJ5orKASBH9eQ==
X-Received: by 2002:a05:651c:3d0:: with SMTP id f16mr18057204ljp.169.1626605351527;
        Sun, 18 Jul 2021 03:49:11 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y22sm1039528lfh.154.2021.07.18.03.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 03:49:11 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/9] clk: qcom: videocc-sm8250: use runtime PM for the clock controller
Date:   Sun, 18 Jul 2021 13:48:57 +0300
Message-Id: <20210718104901.454843-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210718104901.454843-1-dmitry.baryshkov@linaro.org>
References: <20210718104901.454843-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sm8250 dispcc and videocc registers are powered up by the MMCX power
domain. Use runtime PM calls to make sure that required power domain is
powered on while we access clock controller's registers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/videocc-sm8250.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index 7b435a1c2c4b..d996b76f4e30 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -6,6 +6,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,videocc-sm8250.h>
@@ -367,10 +368,21 @@ MODULE_DEVICE_TABLE(of, video_cc_sm8250_match_table);
 static int video_cc_sm8250_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
+	int ret;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
 
 	regmap = qcom_cc_map(pdev, &video_cc_sm8250_desc);
-	if (IS_ERR(regmap))
+	if (IS_ERR(regmap)) {
+		pm_runtime_put(&pdev->dev);
 		return PTR_ERR(regmap);
+	}
 
 	clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
 	clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
@@ -379,7 +391,11 @@ static int video_cc_sm8250_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
 
-	return qcom_cc_really_probe(pdev, &video_cc_sm8250_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &video_cc_sm8250_desc, regmap);
+
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
 }
 
 static struct platform_driver video_cc_sm8250_driver = {
-- 
2.30.2

