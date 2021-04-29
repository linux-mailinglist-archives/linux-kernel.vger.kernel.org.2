Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766BE36EE83
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbhD2RCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhD2RCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:02:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB96C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:01:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g65so7136714wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xIJhQgvErzZ8YMPk+WYILQGnbeAVai9jg3fngQlpAFY=;
        b=C8R+f1fz5aqV1aulPZMLyBy7ioGqZPPUaP9lhWiP8PGwu6kzgShmo9w283OnMqawKP
         r0inAbP/0RMeenxINyC0o+RhuvvXRQxK0XDZz1QzwIi6S47nKiBOhWddaW/ijUvzQwZ4
         SZFOIyFy7ceWkqWtfUjSOtRyM949EqABmIp9kXGeri+a/h778ssHwE7hE4mue7GhcgBI
         1itvHPaY3CZCVXgrT440G/VMXt+yLzMB0LzvRKGaB1AjDW5cP1k7f5/K+24e/nsPzQVB
         H8S2MJ1Oy3IaX+SNk7ZepjZdPshgULUbyTLC7puWEigLoL0/kbF6cVje/eXOxE1VAvLz
         SlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xIJhQgvErzZ8YMPk+WYILQGnbeAVai9jg3fngQlpAFY=;
        b=rjW/hxD+fTDuFCJmD4vDjZQZVB1vD+9E9WZYZU2o7BGWH33G9j3mtE0SmPDQqC4OPb
         cFfj1IaCLU3r/IFuwFQqtR6JyvaUrtB00bODUEmLw9EVLE9Xro/Z9xXu/RM0H/oQF8j7
         RYiw0G0hTLAKmL3aFlt1B3m1+lBJJP7aasZA2s/KUXqHBM8iMvTU1DYuK0u1m5BBGxiZ
         5AJ4+ZAFJsDeuE/rW5NkIVcsbOFcL67ieBeX9jTGWlPpH/XCBoaB5fmO+dH6hoNjajQ7
         YvY3IDIyvfNS6rfj43VOqqNsjvGjONepPFqyxpXwUlHwnOaYxvdHWDKt856Ed0ySpimZ
         VdgA==
X-Gm-Message-State: AOAM532L3lXWlKbFL0aXfFVu9QPMi3POt8nd6dutjnZcmoqKzYnMMDU+
        hKsR2a9RZCi1+oNmptrqyFrirw==
X-Google-Smtp-Source: ABdhPJzn+h/p0FeOd3nf2UYBKZclZfjL/iW/fxdfxs84vUy7LiQ6oOuoxj4pZ+rH/LZ8wrpqQ6MI9g==
X-Received: by 2002:a1c:6606:: with SMTP id a6mr9009573wmc.160.1619715711326;
        Thu, 29 Apr 2021 10:01:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:c304:4b2b:4a79:1da9])
        by smtp.gmail.com with ESMTPSA id z6sm623856wmf.9.2021.04.29.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 10:01:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org, jbrunet@baylibre.com
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] ASoC: meson: g12a-toacodec: add support for SM1 TOACODEC
Date:   Thu, 29 Apr 2021 19:01:47 +0200
Message-Id: <20210429170147.3615883-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=vFgn4HeF6fYyIrfNSO2XBhPEbABG+KXl/lGRiyykmRg=; m=qGwWmF5o4d9qBXb6Klih2uuRcBA5bhVPUwJGlRovDlc=; p=vp2pFauRu8dJuiKftRhsEDtc6Q3vQLibGNeuvotvOGE=; g=4d0a05e4e909af8ccb1fe6c76a86ad52487fdcb2
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmCK5mIACgkQd9zb2sjISdEdvxAAw5d e2XqTkQnzlfJIn1tQmSYHoz81ZtVFGPP53ViZZH+67cXEkFR2+XmN73kN6KWEodFVcqppGeDhQSzu yJQjWC8/QBgTQtsr789LhO6+88w7J/xOLFQx1JZz5wu2Av+Lbqwt2GnqZqFYRt55w85tJa5cSJMkz IG7lHD4oaieUBWxFCrwQPCXBwjAcieHDutEvlh7BqFw80/rPpKvTtAWSSl2mWWSlggrFdgWOS+OQL 16zrk5aqIyhXDPbWenDupzNn7GzR5S7AVEUN82FDagfcLuXaTMbQMmsOaq01Lyqxg2kQRty/06GYo hrBQlSjsoBPHJ2iVAm3xTi5pN2LZhmPF/nCjgBL9cQ5AKzATSwruCrczQfVxD98AvGIxQ9PtjZQox RUiAG5MZFw2vb5hJU8WnFKQ/za+3uP1Tc7GBWxjQRtkWy+EbJb57VlWTCbIeXwT3yj9XDbMzuh5FF IV5aSp3FTa8riR2Sh28cs8ewMuVgreiA6rEt4Trbx9XXW0tGPXt9aM95YNhj8+Fsusj5xdqJMpZJ6 ZaTTJvDdgQWXGGs7N+P+34zAC+czNJegcSr+3MoHmoySVDwtESZ2Jbok/tmBzFD7n0TGXf/jqn2pO 2PdagjpqWq+SKlp2vmyYFtMlBlEz7U8vENnEQza3Ast8wTSi1rTSJEGJctA3CVHc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the TOACODEC found in Amlogic SM1 SoCs.

The bits are shifted for more selection of clock sources, so this only
maps the same support for G12A to the SM1 bits.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 sound/soc/meson/g12a-toacodec.c | 126 +++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
index 9339fabccb79..9c1c6b65baad 100644
--- a/sound/soc/meson/g12a-toacodec.c
+++ b/sound/soc/meson/g12a-toacodec.c
@@ -23,15 +23,27 @@
 #define  CTRL0_ENABLE_SHIFT		31
 #define  CTRL0_DAT_SEL_SHIFT		14
 #define  CTRL0_DAT_SEL			(0x3 << CTRL0_DAT_SEL_SHIFT)
+#define  CTRL0_DAT_SEL_SHIFT_SM1	18
+#define  CTRL0_DAT_SEL_SM1		(0x3 << CTRL0_DAT_SEL_SHIFT_SM1)
 #define  CTRL0_LANE_SEL			12
+#define  CTRL0_LANE_SEL_SM1		16
 #define  CTRL0_LRCLK_SEL		GENMASK(9, 8)
+#define  CTRL0_LRCLK_INV_SM1		BIT(10)
+#define  CTRL0_LRCLK_SEL_SM1		GENMASK(14, 12)
 #define  CTRL0_BLK_CAP_INV		BIT(7)
+#define  CTRL0_BLK_CAP_INV_SM1		BIT(9)
 #define  CTRL0_BCLK_O_INV		BIT(6)
+#define  CTRL0_BCLK_O_INV_SM1		BIT(8)
 #define  CTRL0_BCLK_SEL			GENMASK(5, 4)
+#define  CTRL0_BCLK_SEL_SM1		GENMASK(6, 4)
 #define  CTRL0_MCLK_SEL			GENMASK(2, 0)
 
 #define TOACODEC_OUT_CHMAX		2
 
+struct g12a_toacodec_match_data {
+	const struct snd_soc_component_driver *component_drv;
+};
+
 static const char * const g12a_toacodec_mux_texts[] = {
 	"I2S A", "I2S B", "I2S C",
 };
@@ -85,15 +97,73 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int sm1_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm =
+		snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int mux, changed;
+
+	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
+	changed = snd_soc_component_test_bits(component, e->reg,
+					      CTRL0_DAT_SEL_SM1,
+					      FIELD_PREP(CTRL0_DAT_SEL_SM1, mux));
+
+	if (!changed)
+		return 0;
+
+	/* Force disconnect of the mux while updating */
+	snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
+
+	snd_soc_component_update_bits(component, e->reg,
+				      CTRL0_DAT_SEL_SM1 |
+				      CTRL0_LRCLK_SEL_SM1 |
+				      CTRL0_BCLK_SEL_SM1,
+				      FIELD_PREP(CTRL0_DAT_SEL_SM1, mux) |
+				      FIELD_PREP(CTRL0_LRCLK_SEL_SM1, mux) |
+				      FIELD_PREP(CTRL0_BCLK_SEL_SM1, mux));
+
+	/*
+	 * FIXME:
+	 * On this soc, the glue gets the MCLK directly from the clock
+	 * controller instead of going the through the TDM interface.
+	 *
+	 * Here we assume interface A uses clock A, etc ... While it is
+	 * true for now, it could be different. Instead the glue should
+	 * find out the clock used by the interface and select the same
+	 * source. For that, we will need regmap backed clock mux which
+	 * is a work in progress
+	 */
+	snd_soc_component_update_bits(component, e->reg,
+				      CTRL0_MCLK_SEL,
+				      FIELD_PREP(CTRL0_MCLK_SEL, mux));
+
+	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
+
+	return 0;
+}
+
 static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,
 			    CTRL0_DAT_SEL_SHIFT,
 			    g12a_toacodec_mux_texts);
 
+static SOC_ENUM_SINGLE_DECL(sm1_toacodec_mux_enum, TOACODEC_CTRL0,
+			    CTRL0_DAT_SEL_SHIFT_SM1,
+			    g12a_toacodec_mux_texts);
+
 static const struct snd_kcontrol_new g12a_toacodec_mux =
 	SOC_DAPM_ENUM_EXT("Source", g12a_toacodec_mux_enum,
 			  snd_soc_dapm_get_enum_double,
 			  g12a_toacodec_mux_put_enum);
 
+static const struct snd_kcontrol_new sm1_toacodec_mux =
+	SOC_DAPM_ENUM_EXT("Source", sm1_toacodec_mux_enum,
+			  snd_soc_dapm_get_enum_double,
+			  sm1_toacodec_mux_put_enum);
+
 static const struct snd_kcontrol_new g12a_toacodec_out_enable =
 	SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
 				    CTRL0_ENABLE_SHIFT, 1, 0);
@@ -105,6 +175,13 @@ static const struct snd_soc_dapm_widget g12a_toacodec_widgets[] = {
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
@@ -175,6 +252,13 @@ static int g12a_toacodec_component_probe(struct snd_soc_component *c)
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
@@ -187,6 +271,10 @@ static const struct snd_kcontrol_new g12a_toacodec_controls[] = {
 	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL, 3, 0),
 };
 
+static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
+	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 3, 0),
+};
+
 static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
 	.probe			= g12a_toacodec_component_probe,
 	.controls		= g12a_toacodec_controls,
@@ -199,25 +287,59 @@ static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
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
 	.reg_stride	= 4,
 };
 
+static const struct g12a_toacodec_match_data g12a_toacodec_match_data = {
+	.component_drv          = &g12a_toacodec_component_drv,
+};
+
+static const struct g12a_toacodec_match_data sm1_toacodec_match_data = {
+	.component_drv          = &sm1_toacodec_component_drv,
+};
+
 static const struct of_device_id g12a_toacodec_of_match[] = {
-	{ .compatible = "amlogic,g12a-toacodec", },
+	{
+		.compatible = "amlogic,g12a-toacodec",
+		.data = &g12a_toacodec_match_data,
+	},
+	{
+		.compatible = "amlogic,sm1-toacodec",
+		.data = &sm1_toacodec_match_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, g12a_toacodec_of_match);
 
 static int g12a_toacodec_probe(struct platform_device *pdev)
 {
+	const struct g12a_toacodec_match_data *data;
 	struct device *dev = &pdev->dev;
 	void __iomem *regs;
 	struct regmap *map;
 	int ret;
 
+	data = device_get_match_data(dev);
+	if (!data) {
+		dev_err(dev, "failed to match device\n");
+		return -ENODEV;
+	}
+
 	ret = device_reset(dev);
 	if (ret)
 		return ret;
@@ -234,7 +356,7 @@ static int g12a_toacodec_probe(struct platform_device *pdev)
 	}
 
 	return devm_snd_soc_register_component(dev,
-			&g12a_toacodec_component_drv, g12a_toacodec_dai_drv,
+			data->component_drv, g12a_toacodec_dai_drv,
 			ARRAY_SIZE(g12a_toacodec_dai_drv));
 }
 
-- 
2.25.1

