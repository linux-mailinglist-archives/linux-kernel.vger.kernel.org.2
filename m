Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05973CC893
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 12:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhGRKwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 06:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbhGRKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 06:52:11 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C58CC061762
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g8so18443819lfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iaKylTHK8D5EzB/xiSIklLRQLkt7yfSNwyCfbc/j47o=;
        b=CumnnenME8Jyt67j9cGkgxVdCUPijZ3W406ZSjfKl+O2mNfMofR/47JrDLfV3KXUOE
         SzvReEkCSbbMj0r2eMR7Ddw/QFIoMRIamBtsMxGDLikqCmWRKs4QwMo6uvopIW92pcSg
         C0bLwqobwmgNWduQlpWgZWv7oxb7s3ll6UsjFf4nny6CfNdrZakatnGd5Z7Lee6+mdKq
         8RQNDtLJCb42v7dlSX35lSy2gEcCvcxcFtLL9oLzcQVdo+KC3gDf7pvCu86YOcO32tIq
         +D7XvmCae4PZNaxpwjhcEekYitsFQUUHvxwiopdIEf/qTCjOlARY1WNKR2No+6bLskbt
         t7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iaKylTHK8D5EzB/xiSIklLRQLkt7yfSNwyCfbc/j47o=;
        b=kw5hmIxs67LnRXd8cx6JLXqeyt63kiOhJCV/Z5NWGIgfd1XtyalHAa8wTHu04q55+/
         wztmc8v51lc14Xzx8KMttWEUwK3szrkRnCa/PB3hVGZonByAERbqUvRYN4xj4zwHjTX4
         fz/RQLkhxFQ7Wf4JOLGOWG1jb4Fur5j1j9669asEzxQ1bQoTMinTn84pfaNNaSoRw3LQ
         GQdXzh8re8m3keHUalHWzwNzNvMccngMGG3f1UVULwRfIMwhG0dfpp5R08KPfSc/ZDvn
         HaxuURgCdVSy4SOg4BtFZvxTlRhj9IRg3AdFY8FQjtnZ7LRgezqY6q/c1ZXvmHuaIsNS
         GZFw==
X-Gm-Message-State: AOAM533oupiJ4yi16TM1GIQvBE7R8tSgJVP32z5o0BW76tlkZbpNINKW
        xScKeQVs4+zvjLuxYQexEvkUuQ==
X-Google-Smtp-Source: ABdhPJw2lQkwNP5CbJWu7ZcteEgCd+uNashq+KVb6JiKvFbJBPytB7KVrkagT7MSOBFBaEcQ7Rl0rw==
X-Received: by 2002:a05:6512:322a:: with SMTP id f10mr3855591lfe.625.1626605350779;
        Sun, 18 Jul 2021 03:49:10 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y22sm1039528lfh.154.2021.07.18.03.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 03:49:10 -0700 (PDT)
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
Subject: [PATCH v5 4/9] clk: qcom: dispcc-sm8250: use runtime PM for the clock controller
Date:   Sun, 18 Jul 2021 13:48:56 +0300
Message-Id: <20210718104901.454843-5-dmitry.baryshkov@linaro.org>
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
 drivers/clk/qcom/dispcc-sm8250.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index 601c7c0ba483..0625fea6d7ba 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -6,6 +6,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
@@ -1229,10 +1230,21 @@ MODULE_DEVICE_TABLE(of, disp_cc_sm8250_match_table);
 static int disp_cc_sm8250_probe(struct platform_device *pdev)
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
 
 	regmap = qcom_cc_map(pdev, &disp_cc_sm8250_desc);
-	if (IS_ERR(regmap))
+	if (IS_ERR(regmap)) {
+		pm_runtime_put(&pdev->dev);
 		return PTR_ERR(regmap);
+	}
 
 	/* note: trion == lucid, except for the prepare() op */
 	BUILD_BUG_ON(CLK_ALPHA_PLL_TYPE_TRION != CLK_ALPHA_PLL_TYPE_LUCID);
@@ -1257,7 +1269,11 @@ static int disp_cc_sm8250_probe(struct platform_device *pdev)
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

