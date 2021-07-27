Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B373D7F21
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 22:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhG0UVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbhG0UUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 16:20:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E94C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f18so23863117lfu.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DuXeupaKBu8fmjC2iX4mmn3Nc4vXMRr6696lO841Bo4=;
        b=S2GuFMTIX2//VO1fHeNp1wh37DqNiOvGOBfiDHnm5dhX4zNQElIpxDcErXZLKCWdzx
         zWKdPhG3Fh4RaLv6is+Q0otM0DsG2zK8GOwJN9JFdsXFqoU+iyTxgl+eivbDO/dLWNo9
         mv2b6AxdJxgh6vWaED6c1q67wo+Iw+JGofhIEyPRGLe4o2JRXesaSqcud2wgye9iDH+t
         CCNNq+qzDja8qRT83yIHSG3BmFE3CraWPA0hYGOPZq/eqCl7jzu8TJGN+2V084NpNwg0
         HJSShWxqR4zsiloObXArt2DXMKbMjfKWaZytvMaAn/p2ZUebHQJ2jFn3fUXSboceTH8B
         xO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DuXeupaKBu8fmjC2iX4mmn3Nc4vXMRr6696lO841Bo4=;
        b=ky36Q5N7n5J+pjs4uYca6xSwSjowKM9WxWHlMZRj0e92pLrau64JkRvXgtLgmu+uNV
         bqs+yrUxCGqFPn0I8c8It/zUeZNLnvfJA5y9OhWYoCpb17F1z5kb1WlSyEk50rb92saM
         Di17RTrNosM12G7Sg0CCqyxTdd0yhMK9pACimuAIsR0QbGKy8bTsrX+cyY7orGCtKhsU
         SZa9ZfM1dGD7kITwJKf5I3ckyGYiq9dPVucLk7aH946Nms1AvF9b+ghr2WZP18UzjCYE
         tuMYrv6X5NQxjxi0ZuxU00HRx3F1eidR7J0lYrWhfUKtqsdIicLCYkXZfxPoORugYxRV
         fVFQ==
X-Gm-Message-State: AOAM531tfqI85i3PvnTp42ABTfN0zLOuRJYXiUGo7KqjggIGsKsMikuJ
        4esUT0xdnySb1IXWP/0tvUGStg==
X-Google-Smtp-Source: ABdhPJxqbp1Zt6czhKQoQwAAgB8qtxD5NCfe5acPK1sZomvx9jIiJH04sUm3PUyZCeNrmWgVbwh7wA==
X-Received: by 2002:ac2:5e3c:: with SMTP id o28mr18544884lfg.592.1627417220528;
        Tue, 27 Jul 2021 13:20:20 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i11sm376502lfe.215.2021.07.27.13.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:20:20 -0700 (PDT)
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
Subject: [PATCH v6 4/8] clk: qcom: videocc-sm8250: use runtime PM for the clock controller
Date:   Tue, 27 Jul 2021 23:20:00 +0300
Message-Id: <20210727202004.712665-5-dmitry.baryshkov@linaro.org>
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
 drivers/clk/qcom/videocc-sm8250.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
index 7b435a1c2c4b..8617454e4a77 100644
--- a/drivers/clk/qcom/videocc-sm8250.c
+++ b/drivers/clk/qcom/videocc-sm8250.c
@@ -6,6 +6,7 @@
 #include <linux/clk-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,videocc-sm8250.h>
@@ -364,13 +365,31 @@ static const struct of_device_id video_cc_sm8250_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, video_cc_sm8250_match_table);
 
+static void video_cc_sm8250_pm_runtime_disable(void *data)
+{
+	pm_runtime_disable(data);
+}
+
 static int video_cc_sm8250_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
+	int ret;
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_add_action_or_reset(&pdev->dev, video_cc_sm8250_pm_runtime_disable, &pdev->dev);
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
@@ -379,7 +398,11 @@ static int video_cc_sm8250_probe(struct platform_device *pdev)
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

