Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540B9366A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 14:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhDUMG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 08:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239568AbhDUMGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:06:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA1BC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sd23so54490936ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4saZG/mBOFusi/3PnhTOED3xRGrc2E/DVPqnSP5N1B4=;
        b=tMGUqLts//zB8lVUZgdr7LIydq5ZvwLd5wA32lz8Yo+EJbTv8+Cr7Dfr7hG/1UatVP
         XGWHgeupRgOA2jANdmYFSgsNqZvTwYYu1R8pPvZBPsqfYZB7+uu7PymmaAxVUvuspXwQ
         yNLwj2lyMNyIvnKlYpR8yOZKqGvRg+QoBA9EZY6kg0ewtjCX5pgFWYEI+qc8hVnTldcG
         IRSomtgfm36I9+ccZVfUX/mNRRDS5hp84jbCl0KotEgiZ8mTqaon154bQ7ZoCneaZ1dR
         h2OSF45ajUGGoQlr2ooa1OkkFez8BwdBoZygjy0A+NpkryfDRtUleThg9eD48mL9+EsF
         flOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4saZG/mBOFusi/3PnhTOED3xRGrc2E/DVPqnSP5N1B4=;
        b=MNLfyr9RGzBdpPPW0lFi+tr9bhxvaLxpVDrvKN/klBt2o04Ga1ofQrHsMrBtInuEzr
         skW4tQE4WocbyofoALJIlbYRvWIOC6PGuRTBb/0ZzZhAPOW4clefsoWC3FpIfOCnPvgw
         ROSqGCzoysidt8VfyEwW6EodWsXkATS4lTKLAcH78pnqW4ryNioijl1Re7fYOHo4pt2m
         gXczOCwySZ9WxB6PIQQ9BxF/VEfmRutR63azK3Gesru0ugReSzxmQ/F1VGkfMq3Qljqe
         N+2EHSQxu9/EOlZR1L8shj23HPWtdfriwBPPvNJUO3VtrRHlSyDOAF053TK8QRIi/YRn
         YUNw==
X-Gm-Message-State: AOAM532M3HVKOO1vK7qMwEZ7Uv2WPl3mUga8Gt4TtEJHFQafuG/EWk8A
        45fUhUjC5Xc/CJgcnkp5Ca3IMQ==
X-Google-Smtp-Source: ABdhPJxwGk9Wjg5LehSvoZoZIWOwfhhtktCyjSV7rPgIolUcHr7yn1CofvWtPlVgcxdCTTfMWNbVVA==
X-Received: by 2002:a17:906:1c83:: with SMTP id g3mr12999618ejh.93.1619006739977;
        Wed, 21 Apr 2021 05:05:39 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n2sm3151431edi.32.2021.04.21.05.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 05:05:39 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/5] ASoC: lpass: use the clock provider API
Date:   Wed, 21 Apr 2021 14:05:11 +0200
Message-Id: <20210421120512.413057-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421120512.413057-1-jbrunet@baylibre.com>
References: <20210421120512.413057-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock providers should be registered using the clk_hw API.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/lpass-va-macro.c  |  7 ++-----
 sound/soc/codecs/lpass-wsa-macro.c | 11 +++--------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 5294c57b2cd4..56c93f4465c9 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1343,7 +1343,7 @@ static int va_macro_register_fsgen_output(struct va_macro *va)
 	if (ret)
 		return ret;
 
-	return of_clk_add_provider(np, of_clk_src_simple_get, va->hw.clk);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &va->hw);
 }
 
 static int va_macro_validate_dmic_sample_rate(u32 dmic_sample_rate,
@@ -1452,12 +1452,10 @@ static int va_macro_probe(struct platform_device *pdev)
 					      va_macro_dais,
 					      ARRAY_SIZE(va_macro_dais));
 	if (ret)
-		goto soc_err;
+		goto err;
 
 	return ret;
 
-soc_err:
-	of_clk_del_provider(pdev->dev.of_node);
 err:
 	clk_bulk_disable_unprepare(VA_NUM_CLKS_MAX, va->clks);
 
@@ -1468,7 +1466,6 @@ static int va_macro_remove(struct platform_device *pdev)
 {
 	struct va_macro *va = dev_get_drvdata(&pdev->dev);
 
-	of_clk_del_provider(pdev->dev.of_node);
 	clk_bulk_disable_unprepare(VA_NUM_CLKS_MAX, va->clks);
 
 	return 0;
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index e79a70386b4b..1a7fa5492f28 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2337,10 +2337,9 @@ static const struct clk_ops swclk_gate_ops = {
 	.recalc_rate = swclk_recalc_rate,
 };
 
-static struct clk *wsa_macro_register_mclk_output(struct wsa_macro *wsa)
+static int wsa_macro_register_mclk_output(struct wsa_macro *wsa)
 {
 	struct device *dev = wsa->dev;
-	struct device_node *np = dev->of_node;
 	const char *parent_clk_name;
 	const char *clk_name = "mclk";
 	struct clk_hw *hw;
@@ -2358,11 +2357,9 @@ static struct clk *wsa_macro_register_mclk_output(struct wsa_macro *wsa)
 	hw = &wsa->hw;
 	ret = clk_hw_register(wsa->dev, hw);
 	if (ret)
-		return ERR_PTR(ret);
-
-	of_clk_add_provider(np, of_clk_src_simple_get, hw->clk);
+		return ret;
 
-	return NULL;
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
 }
 
 static const struct snd_soc_component_driver wsa_macro_component_drv = {
@@ -2438,8 +2435,6 @@ static int wsa_macro_remove(struct platform_device *pdev)
 {
 	struct wsa_macro *wsa = dev_get_drvdata(&pdev->dev);
 
-	of_clk_del_provider(pdev->dev.of_node);
-
 	clk_bulk_disable_unprepare(WSA_NUM_CLKS_MAX, wsa->clks);
 
 	return 0;
-- 
2.31.1

