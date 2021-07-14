Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B03C8799
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbhGNPeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239892AbhGNPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:34:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E021C061765
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:31:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso3664280wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZEdZ+N0eteL07jx0I8YEw4d+MAwVooRKuXAZfHn0G4c=;
        b=o8OW1IjbQQi6PtfzBXMIEY4tiI0ap0Kt2MGwbR8boavQl52oeAP5UXZvaeWqaouKmD
         LtIfYmHledzcF5ZIZJfec+Vp4q4/jCUxWDg13hEcjltXz4oIVTEwxostfSpqfCtJeDDT
         TS2CJaTjHqIr3mNnNiVQeRBpIGQAsSGkTqhZ+mo5e8m2rXsF0ADLSLDr/zRWpESZlFaA
         AFcPtm/LzZMs4mc9MAnnR4HE5olfQ0m4oJhIi1OZdnd3DCnqCNhxt6NPYEA3dgCzNsJg
         3U82hCMZf6la8KXXJbcnUj9agzFhAVQutht5hmY3aXOaj/IcMpiSyo8MomJryKTMWbLe
         kRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZEdZ+N0eteL07jx0I8YEw4d+MAwVooRKuXAZfHn0G4c=;
        b=Y2RU+knxqHm39wNghPlk2k1VfSviw4lTGBQvOgSbm9I4es6YRFHvsF02JKThr/WSIS
         9FLxX4FG08Z7GKJN3jFLvR7cfFqVldTUngN9aKHlIYIFZ16gruofAhnOKiwzSZr/WvQO
         rWUBU7Yr8BY1uuHSmCkuhiuiEpc8mEIzLmIdWRFVidq4srxM/7DTWxoeT9dMsqCwCu5S
         Rg2xnHRcj1QWTdnwBaF7hEoLsBofi5bNONSyD+1Wh+vTjWx9ML3SRBXD/YLGTzGcg5+j
         C0JIgogbBPy6eiR07hbg2hXstDrnyNJZAJCLvDZHMiAsjnj3yGAWuoYLH7lyAOZEOTdz
         3WFQ==
X-Gm-Message-State: AOAM532sG0zZjOcvw6mjEWmyvnR52pDPEbPbqFUcoDSoX9/a3+vBUTRP
        EKswYCrTY6lSFOVi6STPR2S+5A==
X-Google-Smtp-Source: ABdhPJxMq5u6bp0AhaCau+hfSV80bZY1Xk5pC2hJLFrKZKsutCwD7Upe/TiV9izAmYHXf6hBb3CQDQ==
X-Received: by 2002:a05:600c:3b93:: with SMTP id n19mr4772987wms.3.1626276678690;
        Wed, 14 Jul 2021 08:31:18 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y6sm2465174wma.48.2021.07.14.08.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:31:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, broonie@kernel.org, robh@kernel.org
Cc:     plai@codeaurora.org, tiwai@suse.de, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 16/16] ASoC: qcom: sm8250: Add audioreach support
Date:   Wed, 14 Jul 2021 16:30:39 +0100
Message-Id: <20210714153039.28373-17-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
References: <20210714153039.28373-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for parsing dt for AudioReach based soundcards
which only have backend DAI links in DT.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sm8250.c | 144 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index fe8fd7367e21..421f9d1d2bed 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -20,6 +20,141 @@ struct sm8250_snd_data {
 	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
 };
 
+static int qcom_audioreach_snd_parse_of(struct snd_soc_card *card)
+{
+	struct device_node *np;
+	struct device_node *codec = NULL;
+	struct device_node *platform = NULL;
+	struct device_node *cpu = NULL;
+	struct device *dev = card->dev;
+	struct snd_soc_dai_link *link;
+	struct of_phandle_args args;
+	struct snd_soc_dai_link_component *dlc;
+	int ret, num_links;
+
+	ret = snd_soc_of_parse_card_name(card, "model");
+	if (ret) {
+		dev_err(dev, "Error parsing card name: %d\n", ret);
+		return ret;
+	}
+
+	/* DAPM routes */
+	if (of_property_read_bool(dev->of_node, "audio-routing")) {
+		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
+		if (ret)
+			return ret;
+	}
+
+	/* Populate links */
+	num_links = of_get_child_count(dev->of_node);
+
+	/* Allocate the DAI link array */
+	card->dai_link = devm_kcalloc(dev, num_links, sizeof(*link), GFP_KERNEL);
+	if (!card->dai_link)
+		return -ENOMEM;
+
+	card->num_links = num_links;
+	link = card->dai_link;
+
+	for_each_child_of_node(dev->of_node, np) {
+
+		dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
+		if (!dlc) {
+			ret = -ENOMEM;
+			goto err_put_np;
+		}
+
+		link->cpus	= &dlc[0];
+		link->platforms	= &dlc[1];
+
+		link->num_cpus		= 1;
+		link->num_platforms	= 1;
+
+
+		ret = of_property_read_string(np, "link-name", &link->name);
+		if (ret) {
+			dev_err(card->dev, "error getting codec dai_link name\n");
+			goto err_put_np;
+		}
+
+		cpu = of_get_child_by_name(np, "cpu");
+		platform = of_get_child_by_name(np, "platform");
+		codec = of_get_child_by_name(np, "codec");
+		if (!cpu) {
+			dev_err(dev, "%s: Can't find cpu DT node\n", link->name);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		if (!platform) {
+			dev_err(dev, "%s: Can't find platform DT node\n", link->name);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		if (!codec) {
+			dev_err(dev, "%s: Can't find codec DT node\n", link->name);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		ret = of_parse_phandle_with_args(cpu, "sound-dai", "#sound-dai-cells", 0, &args);
+		if (ret) {
+			dev_err(card->dev, "%s: error getting cpu phandle\n", link->name);
+			goto err;
+		}
+
+		link->cpus->of_node = args.np;
+		link->id = args.args[0];
+
+		ret = snd_soc_of_get_dai_name(cpu, &link->cpus->dai_name);
+		if (ret) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(card->dev, "%s: error getting cpu dai name: %d\n",
+					link->name, ret);
+			goto err;
+		}
+
+		link->platforms->of_node = of_parse_phandle(platform, "sound-dai", 0);
+		if (!link->platforms->of_node) {
+			dev_err(card->dev, "%s: platform dai not found\n", link->name);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
+		if (ret < 0) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(card->dev, "%s: codec dai not found: %d\n",
+					link->name, ret);
+			goto err;
+		}
+
+		/* DPCM backend */
+		link->no_pcm = 1;
+		link->ignore_pmdown_time = 1;
+		link->ignore_suspend = 1;
+
+		link->stream_name = link->name;
+		snd_soc_dai_link_set_capabilities(link);
+		link++;
+
+		of_node_put(cpu);
+		of_node_put(codec);
+		of_node_put(platform);
+
+	}
+
+	return 0;
+err:
+	of_node_put(cpu);
+	of_node_put(codec);
+	of_node_put(platform);
+err_put_np:
+	of_node_put(np);
+	return ret;
+}
+
 static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				     struct snd_pcm_hw_params *params)
 {
@@ -199,7 +334,12 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
 	snd_soc_card_set_drvdata(card, data);
-	ret = qcom_snd_parse_of(card);
+	if (of_device_is_compatible(dev->of_node, "qcom,sm8250-audioreach-sndcard") ||
+		of_device_is_compatible(dev->of_node, "qcom,qrb5165-rb5-audioreach-sndcard"))
+		ret = qcom_audioreach_snd_parse_of(card);
+	else
+		ret = qcom_snd_parse_of(card);
+
 	if (ret)
 		return ret;
 
@@ -211,6 +351,8 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 static const struct of_device_id snd_sm8250_dt_match[] = {
 	{.compatible = "qcom,sm8250-sndcard"},
 	{.compatible = "qcom,qrb5165-rb5-sndcard"},
+	{.compatible = "qcom,sm8250-audioreach-sndcard" },
+	{.compatible = "qcom,qrb5165-rb5-audioreach-sndcard" },
 	{}
 };
 
-- 
2.21.0

