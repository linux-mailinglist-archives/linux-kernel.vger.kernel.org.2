Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73E38F1C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbhEXQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhEXQxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:53:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E20C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:51:43 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j14so27483826wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OfK3W2kSFwwGuWi4vFr85BfkbXEQ0phvVmMJ4aau6FI=;
        b=Q++a7kWPHrbd5Ig+lm9R4GaLDeuUBvYSF8CrEqh1qIzCKEC0IACB2VeZjXULd2/oqD
         SyqPf+BzdNeJmqc5H8a1yaul5o/9Ulfxu8u8VvfL2IYoiOMgaLy1mwCrmf+UqcvgGI2E
         jRJJf2pm2gJrGPwPYYSggBkCIl8by3qhj4Opny8AKoAHcQi02mz4o58EPNlUE/SoB4pP
         JEWcrvi+EsClL85BMJG8r9M2lslD3TOkxBHbsQMVXBf9Fw85R/oQx6leCnpSruP9W3X/
         yOt9RmBuHiq3Vo/60qod8D1BZfKuoZtBOFziEt+TwdKaTGhB43JU6xdbv+aOArXprOJk
         R8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OfK3W2kSFwwGuWi4vFr85BfkbXEQ0phvVmMJ4aau6FI=;
        b=FdOK9WtDjXBR3xuzq4jPqiXdccv1d17XxhpSA+L7Ye+MMkv09JfhkhvmsiA54FQ8x0
         OOJrM5fu064oTWf+ldxXK4lEbgfjqX3gTrqNiGEVewCfbqMW80CllbEEM+EUi9zXGj8S
         jhZB09P4p9w6lYAHTfw3S8uPuLOzzZynJ+9RH5vIA0wjav+DNWRqerGSyo7nJYnM1duv
         +Vz1W6rvor8otlycuXu4esW7u25WjcEq3gvw0FJEO2CizeOupaxeOQaL3G+DXt51TKDa
         d9IaOsv5lfbzZUg8SpCDaDgkllmJne+bUZsr0Z9utwyB0/niErbAtyFDrF6o4eAGXaKY
         Jk8A==
X-Gm-Message-State: AOAM532uYSG04eq3fyZrG8t4j2C86xv1aPSZF7Gi3L1MGHixvKwNXarU
        cRLak5hbHVqJiy3h5xuFwBJ4aMyuMAD4Iw==
X-Google-Smtp-Source: ABdhPJzM6JASMABcQAzPlI+JDMwyyF8NkvWxOMqCfPg9+TtaETgNe5w+4vrpdIhSbf3gARZwA+a+ZQ==
X-Received: by 2002:adf:d1ec:: with SMTP id g12mr23302827wrd.294.1621875101594;
        Mon, 24 May 2021 09:51:41 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id y20sm486908wmi.0.2021.05.24.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:51:41 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH] ASoC: meson: use dev_err_probe
Date:   Mon, 24 May 2021 18:51:36 +0200
Message-Id: <20210524165136.400702-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() helper function to handle probe deferral.
It removes the open coded test for -EPROBE_DEFER but more importantly, it
sets the deferral reason in debugfs which is great for debugging.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/aiu.c               | 17 +++++++----------
 sound/soc/meson/axg-fifo.c          | 11 +++++------
 sound/soc/meson/axg-pdm.c           |  9 +++------
 sound/soc/meson/axg-spdifin.c       |  6 ++----
 sound/soc/meson/axg-spdifout.c      |  6 ++----
 sound/soc/meson/axg-tdm-formatter.c | 18 ++++++------------
 sound/soc/meson/axg-tdm-interface.c | 10 ++++------
 sound/soc/meson/meson-card-utils.c  |  4 ++--
 sound/soc/meson/t9015.c             |  7 +++----
 9 files changed, 34 insertions(+), 54 deletions(-)

diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index ba15d5762b0b..37036adf14ce 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -219,31 +219,29 @@ static int aiu_clk_get(struct device *dev)
 
 	aiu->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(aiu->pclk)) {
-		if (PTR_ERR(aiu->pclk) != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the aiu pclk\n");
+		dev_err_probe(dev, PTR_ERR(aiu->pclk),
+			      "Can't get the aiu pclk\n");
 		return PTR_ERR(aiu->pclk);
 	}
 
 	aiu->spdif_mclk = devm_clk_get(dev, "spdif_mclk");
 	if (IS_ERR(aiu->spdif_mclk)) {
-		if (PTR_ERR(aiu->spdif_mclk) != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the aiu spdif master clock\n");
+		dev_err_probe(dev, PTR_ERR(aiu->spdif_mclk),
+			      "Can't get the aiu spdif master clock\n");
 		return PTR_ERR(aiu->spdif_mclk);
 	}
 
 	ret = aiu_clk_bulk_get(dev, aiu_i2s_ids, ARRAY_SIZE(aiu_i2s_ids),
 			       &aiu->i2s);
 	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the i2s clocks\n");
+		dev_err_probe(dev, ret, "Can't get the i2s clocks\n");
 		return ret;
 	}
 
 	ret = aiu_clk_bulk_get(dev, aiu_spdif_ids, ARRAY_SIZE(aiu_spdif_ids),
 			       &aiu->spdif);
 	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Can't get the spdif clocks\n");
+		dev_err_probe(dev, ret, "Can't get the spdif clocks\n");
 		return ret;
 	}
 
@@ -282,8 +280,7 @@ static int aiu_probe(struct platform_device *pdev)
 
 	ret = device_reset(dev);
 	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to reset device\n");
+		dev_err_probe(dev, ret, "Failed to reset device\n");
 		return ret;
 	}
 
diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index b9af2d513e09..d670a32d56ab 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -352,17 +352,16 @@ int axg_fifo_probe(struct platform_device *pdev)
 
 	fifo->pclk = devm_clk_get(dev, NULL);
 	if (IS_ERR(fifo->pclk)) {
-		if (PTR_ERR(fifo->pclk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %ld\n",
-				PTR_ERR(fifo->pclk));
+		dev_err_probe(dev, PTR_ERR(fifo->pclk),
+			      "failed to get pclk: %ld\n", PTR_ERR(fifo->pclk));
 		return PTR_ERR(fifo->pclk);
 	}
 
 	fifo->arb = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(fifo->arb)) {
-		if (PTR_ERR(fifo->arb) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get arb reset: %ld\n",
-				PTR_ERR(fifo->arb));
+		dev_err_probe(dev, PTR_ERR(fifo->arb),
+			      "failed to get arb reset: %ld\n",
+			      PTR_ERR(fifo->arb));
 		return PTR_ERR(fifo->arb);
 	}
 
diff --git a/sound/soc/meson/axg-pdm.c b/sound/soc/meson/axg-pdm.c
index bfd37d49a73e..f630311b5b29 100644
--- a/sound/soc/meson/axg-pdm.c
+++ b/sound/soc/meson/axg-pdm.c
@@ -613,24 +613,21 @@ static int axg_pdm_probe(struct platform_device *pdev)
 	priv->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(priv->pclk)) {
 		ret = PTR_ERR(priv->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get pclk: %d\n", ret);
 		return ret;
 	}
 
 	priv->dclk = devm_clk_get(dev, "dclk");
 	if (IS_ERR(priv->dclk)) {
 		ret = PTR_ERR(priv->dclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get dclk: %d\n", ret);
 		return ret;
 	}
 
 	priv->sysclk = devm_clk_get(dev, "sysclk");
 	if (IS_ERR(priv->sysclk)) {
 		ret = PTR_ERR(priv->sysclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get dclk: %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/meson/axg-spdifin.c b/sound/soc/meson/axg-spdifin.c
index d0d09f945b48..8f587c3bb5d7 100644
--- a/sound/soc/meson/axg-spdifin.c
+++ b/sound/soc/meson/axg-spdifin.c
@@ -481,16 +481,14 @@ static int axg_spdifin_probe(struct platform_device *pdev)
 	priv->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(priv->pclk)) {
 		ret = PTR_ERR(priv->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get pclk: %d\n", ret);
 		return ret;
 	}
 
 	priv->refclk = devm_clk_get(dev, "refclk");
 	if (IS_ERR(priv->refclk)) {
 		ret = PTR_ERR(priv->refclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get mclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get mclk: %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/meson/axg-spdifout.c b/sound/soc/meson/axg-spdifout.c
index e769a5ee6e27..58e02f6898b7 100644
--- a/sound/soc/meson/axg-spdifout.c
+++ b/sound/soc/meson/axg-spdifout.c
@@ -424,16 +424,14 @@ static int axg_spdifout_probe(struct platform_device *pdev)
 	priv->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(priv->pclk)) {
 		ret = PTR_ERR(priv->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get pclk: %d\n", ret);
 		return ret;
 	}
 
 	priv->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(priv->mclk)) {
 		ret = PTR_ERR(priv->mclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get mclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get mclk: %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index cab7fa2851aa..108f11e14006 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -284,8 +284,7 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	formatter->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(formatter->pclk)) {
 		ret = PTR_ERR(formatter->pclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get pclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get pclk: %d\n", ret);
 		return ret;
 	}
 
@@ -293,8 +292,7 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	formatter->sclk = devm_clk_get(dev, "sclk");
 	if (IS_ERR(formatter->sclk)) {
 		ret = PTR_ERR(formatter->sclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get sclk: %d\n", ret);
 		return ret;
 	}
 
@@ -302,8 +300,7 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	formatter->lrclk = devm_clk_get(dev, "lrclk");
 	if (IS_ERR(formatter->lrclk)) {
 		ret = PTR_ERR(formatter->lrclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get lrclk: %d\n", ret);
 		return ret;
 	}
 
@@ -311,8 +308,7 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	formatter->sclk_sel = devm_clk_get(dev, "sclk_sel");
 	if (IS_ERR(formatter->sclk_sel)) {
 		ret = PTR_ERR(formatter->sclk_sel);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk_sel: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get sclk_sel: %d\n", ret);
 		return ret;
 	}
 
@@ -320,8 +316,7 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	formatter->lrclk_sel = devm_clk_get(dev, "lrclk_sel");
 	if (IS_ERR(formatter->lrclk_sel)) {
 		ret = PTR_ERR(formatter->lrclk_sel);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk_sel: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get lrclk_sel: %d\n", ret);
 		return ret;
 	}
 
@@ -329,8 +324,7 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	formatter->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(formatter->reset)) {
 		ret = PTR_ERR(formatter->reset);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get reset: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get reset: %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 87cac440b369..a2c7f658f6b4 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -519,8 +519,7 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	iface->sclk = devm_clk_get(dev, "sclk");
 	if (IS_ERR(iface->sclk)) {
 		ret = PTR_ERR(iface->sclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get sclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get sclk: %d\n", ret);
 		return ret;
 	}
 
@@ -528,8 +527,7 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	iface->lrclk = devm_clk_get(dev, "lrclk");
 	if (IS_ERR(iface->lrclk)) {
 		ret = PTR_ERR(iface->lrclk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get lrclk: %d\n", ret);
+		dev_err_probe(dev, ret, "failed to get lrclk: %d\n", ret);
 		return ret;
 	}
 
@@ -545,8 +543,8 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 		if (ret == -ENOENT) {
 			iface->mclk = NULL;
 		} else {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to get mclk: %d\n", ret);
+			dev_err_probe(dev, ret, "failed to get mclk: %d\n",
+				      ret);
 			return ret;
 		}
 	}
diff --git a/sound/soc/meson/meson-card-utils.c b/sound/soc/meson/meson-card-utils.c
index 300ac8be46ef..ac062c03cf33 100644
--- a/sound/soc/meson/meson-card-utils.c
+++ b/sound/soc/meson/meson-card-utils.c
@@ -86,8 +86,8 @@ int meson_card_parse_dai(struct snd_soc_card *card,
 	ret = of_parse_phandle_with_args(node, "sound-dai",
 					 "#sound-dai-cells", 0, &args);
 	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(card->dev, "can't parse dai %d\n", ret);
+		dev_err_probe(card->dev, ret,
+			      "can't parse sound-dai at %pOFn\n", node);
 		return ret;
 	}
 	*dai_of_node = args.np;
diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
index 4c1349dd1e06..7ff16f51dbd4 100644
--- a/sound/soc/meson/t9015.c
+++ b/sound/soc/meson/t9015.c
@@ -259,15 +259,14 @@ static int t9015_probe(struct platform_device *pdev)
 
 	priv->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(priv->pclk)) {
-		if (PTR_ERR(priv->pclk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get core clock\n");
+		dev_err_probe(dev, PTR_ERR(priv->pclk),
+			      "failed to get core clock\n");
 		return PTR_ERR(priv->pclk);
 	}
 
 	priv->avdd = devm_regulator_get(dev, "AVDD");
 	if (IS_ERR(priv->avdd)) {
-		if (PTR_ERR(priv->avdd) != -EPROBE_DEFER)
-			dev_err(dev, "failed to AVDD\n");
+		dev_err_probe(dev, PTR_ERR(priv->avdd), "failed to AVDD\n");
 		return PTR_ERR(priv->avdd);
 	}
 
-- 
2.32.0.rc0

