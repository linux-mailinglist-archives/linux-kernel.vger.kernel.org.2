Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4277037358C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 09:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhEEH15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 03:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhEEH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 03:27:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C39C061763
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 00:26:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a4so650420wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 00:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ryLo2gccvYnJFf6uz5T1OlY0Lzzgw8rSJB9vsnUHoqE=;
        b=mmaKgtabncuduXfLM9oT6YqrfkH0MJcr5ydzabdPW5tI3a2j/ZeavcxqROSnVPiP0y
         QWC83sreSiHFxO6TXwAtHPQ8Q6g+HusDKd5Z1BcCyQgL6zYfl2c7noq52MVVRuCpxlFm
         2Iv862euEaJp2K/LkYrbbXQwrGyG2SLfNLLWzPOy5vCkVrBCH0k5iQjs3dF9wlPxC+bq
         SXA5uRXkTzuQyo5dQY92rmHoDk0p4oZur5YxZUKjV7ZTa/tDvhvRJNdBaYSK1XsglXXF
         pl3dIyhyyTMK7vxgcYh/ZEaKtTXIdzlUAMYj7F3ftlNFFYkIjY906L1bLxAzL0T9a7Sn
         mQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ryLo2gccvYnJFf6uz5T1OlY0Lzzgw8rSJB9vsnUHoqE=;
        b=Bi892tipnIIGqhutB4iJLD1giwhN8gOrEAaXvJa0qI+6I9Wim8chDwht6c2HobZOKg
         /7d7USDl8sa1yWRv/UTYo5tK51AyCeHbW0O0Ah9H3VNQGwCqBJF17ru1W9rgMzvFiqed
         pVESFjS/1h/ofd+EBWxPdOWu3SwJr3R6lT1NoItUEM5scvy1ud8uMEjXeW3ci3/o6P1Q
         1bczczvmhy6w1aZgsQC32KPj0tFgZ7AVrwpyhyu5g9B0qXrzFa+DpopV0cpmOYyhLETF
         xdrf/urhuODCAX+xvWPbjQCQ4VW5bEtxlCu2Hrr6HLaRbbHgvI85sS4pCn995SayfwQ3
         xqRw==
X-Gm-Message-State: AOAM530roJ+Rqu+QengDPfqNZpJk4EqJKLgzXYT87UEHGUajA1hw+pyH
        oYIFCX2bvkqxMNxgIzTJnXCdQQ==
X-Google-Smtp-Source: ABdhPJx4DVSUJy6saY70ep/mXUrM9nHCdK7Z61aVTL6XBZMMC5IECfrDceM1fmjbMmcp4AqPb3mduA==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr17857048wrx.211.1620199575726;
        Wed, 05 May 2021 00:26:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:6eb3:66ab:cb1e:ef0])
        by smtp.gmail.com with ESMTPSA id f25sm19008991wrd.67.2021.05.05.00.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 00:26:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/2] sound: meson: g12a-toacodec: add support for SM1 TOACODEC
Date:   Wed,  5 May 2021 09:26:07 +0200
Message-Id: <20210505072607.3815442-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505072607.3815442-1-narmstrong@baylibre.com>
References: <20210505072607.3815442-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the TOACODEC found in Amlogic SM1 SoCs.

The bits are shifted for more selection of clock sources, so this only
maps the same support for G12A to the SM1 bits.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 sound/soc/meson/g12a-toacodec.c | 64 ++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
index 2084c9542c9c..5437ecba9c47 100644
--- a/sound/soc/meson/g12a-toacodec.c
+++ b/sound/soc/meson/g12a-toacodec.c
@@ -21,13 +21,22 @@
 
 #define TOACODEC_CTRL0			0x0
 #define  CTRL0_ENABLE_SHIFT		31
+#define  CTRL0_DAT_SEL_SM1_MSB		19
+#define  CTRL0_DAT_SEL_SM1_LSB		18
 #define  CTRL0_DAT_SEL_MSB		15
 #define  CTRL0_DAT_SEL_LSB		14
+#define  CTRL0_LANE_SEL_SM1		16
 #define  CTRL0_LANE_SEL			12
+#define  CTRL0_LRCLK_SEL_SM1_MSB	14
+#define  CTRL0_LRCLK_SEL_SM1_LSB	12
 #define  CTRL0_LRCLK_SEL_MSB		9
 #define  CTRL0_LRCLK_SEL_LSB		8
+#define  CTRL0_LRCLK_INV_SM1		BIT(10)
+#define  CTRL0_BLK_CAP_INV_SM1		BIT(9)
 #define  CTRL0_BLK_CAP_INV		BIT(7)
+#define  CTRL0_BCLK_O_INV_SM1		BIT(8)
 #define  CTRL0_BCLK_O_INV		BIT(6)
+#define  CTRL0_BCLK_SEL_SM1_MSB		6
 #define  CTRL0_BCLK_SEL_MSB		5
 #define  CTRL0_BCLK_SEL_LSB		4
 #define  CTRL0_MCLK_SEL			GENMASK(2, 0)
@@ -41,6 +50,7 @@ struct g12a_toacodec {
 };
 
 struct g12a_toacodec_match_data {
+	const struct snd_soc_component_driver *component_drv;
 	struct reg_field field_dat_sel;
 	struct reg_field field_lrclk_sel;
 	struct reg_field field_bclk_sel;
@@ -98,11 +108,20 @@ static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,
 			    CTRL0_DAT_SEL_LSB,
 			    g12a_toacodec_mux_texts);
 
+static SOC_ENUM_SINGLE_DECL(sm1_toacodec_mux_enum, TOACODEC_CTRL0,
+			    CTRL0_DAT_SEL_SM1_LSB,
+			    g12a_toacodec_mux_texts);
+
 static const struct snd_kcontrol_new g12a_toacodec_mux =
 	SOC_DAPM_ENUM_EXT("Source", g12a_toacodec_mux_enum,
 			  snd_soc_dapm_get_enum_double,
 			  g12a_toacodec_mux_put_enum);
 
+static const struct snd_kcontrol_new sm1_toacodec_mux =
+	SOC_DAPM_ENUM_EXT("Source", sm1_toacodec_mux_enum,
+			  snd_soc_dapm_get_enum_double,
+			  g12a_toacodec_mux_put_enum);
+
 static const struct snd_kcontrol_new g12a_toacodec_out_enable =
 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
 				    CTRL0_ENABLE_SHIFT, 1, 0);
@@ -114,6 +133,13 @@ static const struct snd_soc_dapm_widget g12a_toacodec_widgets[] = {
 			    &g12a_toacodec_out_enable),
 };
 
+static const struct snd_soc_dapm_widget sm1_toacodec_widgets[] = {
+	SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
+			 &sm1_toacodec_mux),
+	SND_SOC_DAPM_SWITCH("OUT EN", SND_SOC_NOPM, 0, 0,
+			    &g12a_toacodec_out_enable),
+};
+
 static int g12a_toacodec_input_hw_params(struct snd_pcm_substream *substream,
 					 struct snd_pcm_hw_params *params,
 					 struct snd_soc_dai *dai)
@@ -184,6 +210,13 @@ static int g12a_toacodec_component_probe(struct snd_soc_component *c)
 				       CTRL0_BLK_CAP_INV);
 }
 
+static int sm1_toacodec_component_probe(struct snd_soc_component *c)
+{
+	/* Initialize the static clock parameters */
+	return snd_soc_component_write(c, TOACODEC_CTRL0,
+				       CTRL0_BLK_CAP_INV_SM1);
+}
+
 static const struct snd_soc_dapm_route g12a_toacodec_routes[] = {
 	{ "SRC", "I2S A", "IN A Playback" },
 	{ "SRC", "I2S B", "IN B Playback" },
@@ -196,6 +229,10 @@ static const struct snd_kcontrol_new g12a_toacodec_controls[] = {
 	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL, 3, 0),
 };
 
+static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
+	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 3, 0),
+};
+
 static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
 	.probe			= g12a_toacodec_component_probe,
 	.controls		= g12a_toacodec_controls,
@@ -208,6 +245,18 @@ static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static const struct snd_soc_component_driver sm1_toacodec_component_drv = {
+	.probe			= sm1_toacodec_component_probe,
+	.controls		= sm1_toacodec_controls,
+	.num_controls		= ARRAY_SIZE(sm1_toacodec_controls),
+	.dapm_widgets		= sm1_toacodec_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sm1_toacodec_widgets),
+	.dapm_routes		= g12a_toacodec_routes,
+	.num_dapm_routes	= ARRAY_SIZE(g12a_toacodec_routes),
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
 static const struct regmap_config g12a_toacodec_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -215,16 +264,29 @@ static const struct regmap_config g12a_toacodec_regmap_cfg = {
 };
 
 static const struct g12a_toacodec_match_data g12a_toacodec_match_data = {
+	.component_drv	= &g12a_toacodec_component_drv,
 	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_DAT_SEL_LSB, CTRL0_DAT_SEL_MSB),
 	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, CTRL0_LRCLK_SEL_LSB, CTRL0_LRCLK_SEL_MSB),
 	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_BCLK_SEL_LSB, CTRL0_BCLK_SEL_MSB),
 };
 
+static const struct g12a_toacodec_match_data sm1_toacodec_match_data = {
+	.component_drv	= &sm1_toacodec_component_drv,
+	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_DAT_SEL_SM1_LSB, CTRL0_DAT_SEL_SM1_MSB),
+	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, CTRL0_LRCLK_SEL_SM1_LSB,
+				     CTRL0_LRCLK_SEL_SM1_MSB),
+	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, CTRL0_BCLK_SEL_LSB, CTRL0_BCLK_SEL_SM1_MSB),
+};
+
 static const struct of_device_id g12a_toacodec_of_match[] = {
 	{
 		.compatible = "amlogic,g12a-toacodec",
 		.data = &g12a_toacodec_match_data,
 	},
+	{
+		.compatible = "amlogic,sm1-toacodec",
+		.data = &sm1_toacodec_match_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, g12a_toacodec_of_match);
@@ -278,7 +340,7 @@ static int g12a_toacodec_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->field_bclk_sel);
 
 	return devm_snd_soc_register_component(dev,
-			&g12a_toacodec_component_drv, g12a_toacodec_dai_drv,
+			data->component_drv, g12a_toacodec_dai_drv,
 			ARRAY_SIZE(g12a_toacodec_dai_drv));
 }
 
-- 
2.25.1

