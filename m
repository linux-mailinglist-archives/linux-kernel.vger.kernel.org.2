Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0163D7F18
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbhG0UUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbhG0UUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:20:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D37C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r23so282249lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNA9XwU+vnP7eUqrnZr8orLB3tT6dOo5v7UANVhsVwo=;
        b=iIOKxl3O8bDqaRuau8xjvmrsrZPwkWY9M/kWvlnmA/XY86NB183ykS8rVfIyMXxwMA
         R2y9DIJAXBBE4ztkGrjIXOYsBrbwce8IbmTiaSSQV2fpwFWLtzWMfYWtT2SO3usm94i9
         BUK35lzp3bKCmDtu6S2FYAmBjGkZMtnfUqwaJE3po7PUXrGmjaM4YSQmfPrYKADmnBj3
         uAGeJDpHS113sInDlmG2oJbikK1rEu5RG1WDea81//IhNpbQ5lgAd+wDLO8BVqJDcluT
         3piOE3hb0tBFhalwguIZ8tli2eBJUnSbTWFsN7Qr/t2J9Nhgo429xfy82RksYVDrAnOS
         VgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNA9XwU+vnP7eUqrnZr8orLB3tT6dOo5v7UANVhsVwo=;
        b=FVgKeYhr0UNI5WC0FPM4pB6/geAq4yQGSeCJA4RLeg4QoJxW8X6jzgFdwO7v5+HvcY
         yufcumANV1jIRvuR5xbxYEjTGXYC8arknYGECj9AvbwTy3E1QujNzgyXhXNoA5aUf/BY
         peFt6Nt92rTYhfdPC9L8stJVyJTUpf0e1nI9JlovYC6yrWZvSJUSnRXtORA84rYhsHCi
         4paOqBVmSnQlvdCbSsIaSwi59m215/sZsDZcpFYDL5NwyuAIKNrINTV7JAM1PWbXgPtx
         zKn8JkTmeqlR2rPqxWWhJuEjL28uRICa6wC+I6zSs3AElDmBIXxvvTt+PEY5tlsOvTP2
         tHvg==
X-Gm-Message-State: AOAM530RtWPBWJFpCHRwqp5BzrtDrI+5YjP6yc7ZNDJQsYFng/ZF7Q8d
        I7iUH4ejHZHDiaeY+9n6K2n3Ww==
X-Google-Smtp-Source: ABdhPJx3oL+BX/UqMJHrlFzeEFrMEimkxOICrv8xVjP5EmmbS6xveKadZqmYLwM80mu+3EJIACqFbw==
X-Received: by 2002:a05:651c:1069:: with SMTP id y9mr17500977ljm.18.1627417219794;
        Tue, 27 Jul 2021 13:20:19 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i11sm376502lfe.215.2021.07.27.13.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:20:19 -0700 (PDT)
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
Subject: [PATCH v6 3/8] clk: qcom: dispcc-sm8250: use runtime PM for the clock controller
Date:   Tue, 27 Jul 2021 23:19:59 +0300
Message-Id: <20210727202004.712665-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
References: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
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
 drivers/clk/qcom/dispcc-sm8250.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index 601c7c0ba483..108dd1249b6a 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -6,6 +6,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
@@ -1226,13 +1227,31 @@ static const struct of_device_id disp_cc_sm8250_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, disp_cc_sm8250_match_table);
 
+static void disp_cc_sm8250_pm_runtime_disable(void *data)
+{
+	pm_runtime_disable(data);
+}
+
 static int disp_cc_sm8250_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
+	int ret;
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_add_action_or_reset(&pdev->dev, disp_cc_sm8250_pm_runtime_disable, &pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
 
 	regmap = qcom_cc_map(pdev, &disp_cc_sm8250_desc);
-	if (IS_ERR(regmap))
+	if (IS_ERR(regmap)) {
+		pm_runtime_put(&pdev->dev);
 		return PTR_ERR(regmap);
+	}
 
 	/* note: trion == lucid, except for the prepare() op */
 	BUILD_BUG_ON(CLK_ALPHA_PLL_TYPE_TRION != CLK_ALPHA_PLL_TYPE_LUCID);
@@ -1257,7 +1276,11 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
 	/* DISP_CC_XO_CLK always-on */
 	regmap_update_bits(regmap, 0x605c, BIT(0), BIT(0));
 
-	return qcom_cc_really_probe(pdev, &disp_cc_sm8250_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &disp_cc_sm8250_desc, regmap);
+
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
 }
 
 static struct platform_driver disp_cc_sm8250_driver = {
-- 
2.30.2

