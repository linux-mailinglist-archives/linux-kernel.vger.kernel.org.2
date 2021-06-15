Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759283A7B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFOJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhFOJu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:50:58 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9572AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 02:48:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f17so13756733wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f5Ef4gTb6IG+2Rp0mfxvJGUVzw2jq0Fb0ytCRN/UGpA=;
        b=k6Io1xJWIKUJ/pf8bmL7BPSsKG15nKbO6LcBCCTsyC18dYvFU49kvKOO4Dc+OZLWq4
         aNEOSebC6lV/vQvjNW7zu8a1sJAOWhNgXZea/pfefRVX04A3AQL+PMiutACJjan4hCSG
         BOG77oPWqVWBNPLqcqpNlLzwqxFRWNWM5WZqFgeSqOIzHZsiZaT1WsGBzKJKeMtdfMxY
         DHNRjBAXjsWwzDwqur3mGTFHKDPqBLFOzJfm1yK7GbKTjpuq3zto1qoned05eF7eHN32
         YmGOaj3p6peNxu3fO4wQxraau0JsZGyOyNZNEpx+lYBrbOIotasUCGvOCGQVGw7FuCSh
         k5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f5Ef4gTb6IG+2Rp0mfxvJGUVzw2jq0Fb0ytCRN/UGpA=;
        b=rj3NSETqZarC3RtJWMwpieUp1dd5XX7Z6DRbMfBgIrVybm4CAU/D52xMGLNeX493+t
         7WGM7EdAGQXAEDzr0NgOfcZ/2AEK3ba+rn79tgGrswTiZZ5pSa8vr/Us/ISgDKwE8gw1
         ktw+w5ex1GQ037U1F6MXQyozSKXnRjeVH62Dk0VAu8+DlvLJgKkNcDkBuRcQgTmYBtSg
         DPYPPvJi2KTrcLBllTKMV7wCOC8tzdyJ69vXJ+bTKxuS14CM5Ic8B3sNJsD1+FXKBFGt
         R7px2MuZSJslBgMdb7eSqVdMouveoLXJzkBqzUl5GBgZpXswQ4l2BzoI9tbjD2EAN95l
         38TQ==
X-Gm-Message-State: AOAM532azCmtdXfZEI0CH8M2zUw3oOM59DOwlZTdjmdZzeI+o2aktJC6
        n0nwuQe3cZrdNZV5/h/h0lXqGg==
X-Google-Smtp-Source: ABdhPJzClcaiKxxGXqt7y/6C+JfdhJ7Om/lY0IBIb3XYwNo8AOQYlpz6A3rc44WL9tJ6sTmMRziV9g==
X-Received: by 2002:a7b:c192:: with SMTP id y18mr4274471wmi.65.1623750532170;
        Tue, 15 Jun 2021 02:48:52 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n6sm1648471wme.21.2021.06.15.02.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:48:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] ASoC: codecs: wcd938x: remove incorrect module interdependency
Date:   Tue, 15 Jun 2021 10:48:39 +0100
Message-Id: <20210615094839.27237-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason we ended up with cyclic dependency between snd_soc_wcd938x
and snd_soc_wcd938x_sdw modules.

Remove this cyclic dependency by handling them in respective modules.
Without this below error is reported during make modules_install

depmod: ERROR: Cycle detected: snd_soc_wcd938x -> snd_soc_wcd938x_sdw -> snd_soc_wcd938x
depmod: ERROR: Found 2 modules in dependency cycles!

Fixes: 045442228868 ("ASoC: codecs: wcd938x: add audio routing and Kconfig")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x-sdw.c | 19 ++++++++++++-------
 sound/soc/codecs/wcd938x.c     | 27 +++++----------------------
 sound/soc/codecs/wcd938x.h     |  4 +---
 3 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index d82c40ec6898..d1cabf300c36 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -176,8 +176,19 @@ static int wcd9380_interrupt_callback(struct sdw_slave *slave,
 				      struct sdw_slave_intr_status *status)
 {
 	struct wcd938x_sdw_priv *wcd = dev_get_drvdata(&slave->dev);
+	struct irq_domain *slave_irq = wcd->slave_irq;
+	struct regmap *regmap = dev_get_regmap(&slave->dev, NULL);
+	u32 sts1, sts2, sts3;
 
-	return wcd938x_handle_sdw_irq(wcd);
+	do {
+		handle_nested_irq(irq_find_mapping(slave_irq, 0));
+		regmap_read(regmap, WCD938X_DIGITAL_INTR_STATUS_0, &sts1);
+		regmap_read(regmap, WCD938X_DIGITAL_INTR_STATUS_1, &sts2);
+		regmap_read(regmap, WCD938X_DIGITAL_INTR_STATUS_2, &sts3);
+
+	} while (sts1 || sts2 || sts3);
+
+	return IRQ_HANDLED;
 }
 
 static struct sdw_slave_ops wcd9380_slave_ops = {
@@ -239,16 +250,10 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 					SDW_SCP_INT1_PARITY;
 	pdev->prop.lane_control_support = true;
 	if (wcd->is_tx) {
-		struct regmap *rm;
-
 		pdev->prop.source_ports = GENMASK(WCD938X_MAX_SWR_PORTS, 0);
 		pdev->prop.src_dpn_prop = wcd938x_dpn_prop;
 		wcd->ch_info = &wcd938x_sdw_tx_ch_info[0];
 		pdev->prop.wake_capable = true;
-
-		rm = devm_regmap_init_sdw(pdev, &wcd938x_regmap_config);
-		if (IS_ERR(rm))
-			return PTR_ERR(rm);
 	} else {
 		pdev->prop.sink_ports = GENMASK(WCD938X_MAX_SWR_PORTS, 0);
 		pdev->prop.sink_dpn_prop = wcd938x_dpn_prop;
diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index a2c76dc8fd89..24afe93830ce 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1198,7 +1198,7 @@ static bool wcd938x_volatile_register(struct device *dev, unsigned int reg)
 	return false;
 }
 
-struct regmap_config wcd938x_regmap_config = {
+static struct regmap_config wcd938x_regmap_config = {
 	.name = "wcd938x_csr",
 	.reg_bits = 32,
 	.val_bits = 8,
@@ -1211,7 +1211,6 @@ struct regmap_config wcd938x_regmap_config = {
 	.volatile_reg = wcd938x_volatile_register,
 	.can_multi_write = true,
 };
-EXPORT_SYMBOL_GPL(wcd938x_regmap_config);
 
 static const struct regmap_irq wcd938x_irqs[WCD938X_NUM_IRQS] = {
 	REGMAP_IRQ_REG(WCD938X_IRQ_MBHC_BUTTON_PRESS_DET, 0, 0x01),
@@ -3472,24 +3471,6 @@ static int wcd938x_reset(struct wcd938x_priv *wcd938x)
 	return 0;
 }
 
-int wcd938x_handle_sdw_irq(struct wcd938x_sdw_priv *wcd)
-{
-	struct wcd938x_priv *wcd938x = wcd->wcd938x;
-	struct irq_domain *slave_irq = wcd938x->virq;
-	u32 sts1, sts2, sts3;
-
-	do {
-		handle_nested_irq(irq_find_mapping(slave_irq, 0));
-		regmap_read(wcd938x->regmap, WCD938X_DIGITAL_INTR_STATUS_0, &sts1);
-		regmap_read(wcd938x->regmap, WCD938X_DIGITAL_INTR_STATUS_1, &sts2);
-		regmap_read(wcd938x->regmap, WCD938X_DIGITAL_INTR_STATUS_2, &sts3);
-
-	} while (sts1 || sts2 || sts3);
-
-	return IRQ_HANDLED;
-}
-EXPORT_SYMBOL_GPL(wcd938x_handle_sdw_irq);
-
 static int wcd938x_codec_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
@@ -3573,6 +3554,7 @@ static int wcd938x_bind(struct device *dev)
 	}
 	wcd938x->sdw_priv[AIF1_PB] = dev_get_drvdata(wcd938x->rxdev);
 	wcd938x->sdw_priv[AIF1_PB]->wcd938x = wcd938x;
+	wcd938x->sdw_priv[AIF1_PB]->slave_irq = wcd938x->virq;
 
 	wcd938x->txdev = wcd938x_sdw_device_get(wcd938x->txnode);
 	if (!wcd938x->txdev) {
@@ -3581,6 +3563,7 @@ static int wcd938x_bind(struct device *dev)
 	}
 	wcd938x->sdw_priv[AIF1_CAP] = dev_get_drvdata(wcd938x->txdev);
 	wcd938x->sdw_priv[AIF1_CAP]->wcd938x = wcd938x;
+	wcd938x->sdw_priv[AIF1_CAP]->slave_irq = wcd938x->virq;
 	wcd938x->tx_sdw_dev = dev_to_sdw_dev(wcd938x->txdev);
 	if (!wcd938x->tx_sdw_dev) {
 		dev_err(dev, "could not get txslave with matching of dev\n");
@@ -3607,8 +3590,8 @@ static int wcd938x_bind(struct device *dev)
 		return -EINVAL;
 	}
 
-	wcd938x->regmap = dev_get_regmap(wcd938x->txdev, NULL);
-	if (!wcd938x->regmap) {
+	wcd938x->regmap = devm_regmap_init_sdw(wcd938x->tx_sdw_dev, &wcd938x_regmap_config);
+	if (IS_ERR(wcd938x->regmap)) {
 		dev_err(dev, "%s: tx csr regmap not found\n", __func__);
 		return PTR_ERR(wcd938x->regmap);
 	}
diff --git a/sound/soc/codecs/wcd938x.h b/sound/soc/codecs/wcd938x.h
index 9db3ab6e47a6..07b08de4cebf 100644
--- a/sound/soc/codecs/wcd938x.h
+++ b/sound/soc/codecs/wcd938x.h
@@ -663,11 +663,9 @@ struct wcd938x_sdw_priv {
 	int num_ports;
 	bool is_tx;
 	struct wcd938x_priv *wcd938x;
+	struct irq_domain *slave_irq;
 };
 
-extern struct regmap_config wcd938x_regmap_config;
-int wcd938x_handle_sdw_irq(struct wcd938x_sdw_priv *priv);
-
 #if IS_ENABLED(CONFIG_SND_SOC_WCD938X_SDW)
 int wcd938x_sdw_free(struct wcd938x_sdw_priv *wcd,
 		     struct snd_pcm_substream *substream,
-- 
2.21.0

