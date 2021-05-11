Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9F37A126
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 09:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhEKHtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 03:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhEKHto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 03:49:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A991C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:48:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s8so19099394wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7g8Gfa9xyHh47lvJTBT+tD4A12Y3UkIifRHEqnQaxPA=;
        b=VC7IKoZR1gWLfT/kJ5xgmt4z8ccPwAB5kHfQhD0wGQ1k1aGom8nkvprl2NOlYXY3GG
         oGQv5kpH0gMtMCiDIDJHAeNdwTuKBXVIBMzVZymaCLfniLXgyoEB7MGQ7yfioPpCeGdl
         xyYvRgPLS2Xz0rS8FE1RvU6Q4xfMi3v97TkKwz9n9v0ZE1zs4BKrnCL1xvGwIZXaBLmN
         q+mnWTgGQS1K/WGZM9e6E/1SKZNDJvgch/UT6MiumqY9EtzMwzVzp3bEWbENfBeFSF1P
         w7Mtm5tEe71HV90BrRDuHHxODhq0uP0YnKZwSlCI8d00P8hpjNdxvEepNXGkDJy7/78+
         dVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7g8Gfa9xyHh47lvJTBT+tD4A12Y3UkIifRHEqnQaxPA=;
        b=HrpZDL9rMZX3ae+YW4oWun6FZnqpTcE6hep4M8fTAxetpiZWaZIJK59ArqM0xkH6/Z
         VWZBA031lOKXgqhPcTlLblHzC+VJT8czra/q9jmCC5UQsE+IShX9NG9WqR5WS+7xsEEm
         QsMDcvyEVAjrD3QC6F9EiGI4zd1OhhDaDWrzJ8oE0pqVjow2GwwLy8OoNn8X0n4u0FhY
         AhEsG9rUHWT2Ya/h/uiBAGuh9z5zBSkGxGfSXyR9cYRjXqrPLZK4b4Ww0pcPruTGiXZS
         FVQaCksUmGUrx1vq2r4EfsG470L+o3FdRgPHorp6khkMXrbr49s3i8qnRE0peggyJhGl
         5Xzg==
X-Gm-Message-State: AOAM533jXeelf6z/nYzTMx2Hb3qSExME8d4aK0p3egHwjsGq8IDAtPLD
        cMhwjum71bbRFEvyqfxusD17TA==
X-Google-Smtp-Source: ABdhPJzPUGJ4AeCzmiz+5P1JzbY8N3JmNyynEe7cVhmxuvzHeL3pc70uoAtZ9hCGf3jMO5qYHvT2YA==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr35410372wrp.277.1620719316780;
        Tue, 11 May 2021 00:48:36 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:ce08:6145:b4e3:5a23])
        by smtp.gmail.com with ESMTPSA id f6sm28371111wru.72.2021.05.11.00.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:48:36 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 1/2] ASoC: meson: g12a-toacodec: use regmap fields to prepare SM1 support
Date:   Tue, 11 May 2021 09:48:28 +0200
Message-Id: <20210511074829.4110036-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511074829.4110036-1-narmstrong@baylibre.com>
References: <20210511074829.4110036-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=I7FeB/kn/TULPc5oGg/7hlGuQ11TOAQ3nRx0bxRBfG4=; m=tzmDLU+rHQtCMcIMtsgW9A9sxdNpO6W7CGIlLPGL8Z0=; p=eOH4X5jCe681BB9Ief0IhfFZZMY4HvzY78LSS74Ozko=; g=7f135e020f0ae15fd6641595a0d9a241dd65cfa2
X-Patch-Sig: m=pgp; i=narmstrong@baylibre.com; s=0xA4CFF8AE; b=iQIzBAABCgAdFiEEPVPGJshWBf4d9CyLd9zb2sjISdEFAmCaNrAACgkQd9zb2sjISdFhgw/+LId 9xw2+BgFAu038Ix0alJrhfPLIR6mYvH0z6/0huqIK0FQAijzk+dwOKjGzNoPrArDSk2rBI7SwK3ps WIHJlFoJAQIhjMTvPQwTuk/99KStMSiMm33WgbTNO0S0nxMT5mq6kfoPr9eKaDwv+3pxVT46xhZj8 TRMjdGMHGpsy4aGsNq8jYxq4Cn/SslH4mS8vilB3L7V+fA3W7RBrOOebNxgrcbdEH8HyEBLcdDnW+ +3m9wljDY3lDyKpPxCWw+mn5pK9pMFYypUFi33IYESwfi2YmOOyNiNK7woKDdXb2j6tVJdINQ+y9N i6vLQNvgDnMyORXOLybERiJBteMebmLqbZyjcsWlz9hY1jBXXh9hOga4YVGzF5K+uo3sjNNeJWEFu Tt4pXXdgDR9TZPdrlN28WKu75rgZ+VROP/653eeAEJMrU1AlqstnUu1edhIH5aCpgK7Djgy004nB1 +vc/Fsfq9R8wx5zjs4OMzXowAoFmDzTCc7bDEmmM415RBsMVGO3K6WNBvm9F7KtSK3Ipp0p1XrmZg u33fRNu6UsRXvzi7dvfAeWkmRsPJ4Uj2aOkDMY/UlV5fEjIYmTH6uhftA7+YmAyJFoDkxcDvkv8LU 5LQNggNO1IVvmbt9rpEEVQXvis0oQdDjy+yU/V3Rr6351P3lmExVA9W8ZVMY7Ql4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch usage to regmap field for bits handled by the g12a_toacodec_mux_put_enum()
function to avoid uselesss code duplication when adding SM1 variant support.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 sound/soc/meson/g12a-toacodec.c | 80 +++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
index 9339fabccb79..6317bd9c86f4 100644
--- a/sound/soc/meson/g12a-toacodec.c
+++ b/sound/soc/meson/g12a-toacodec.c
@@ -21,17 +21,31 @@
 
 #define TOACODEC_CTRL0			0x0
 #define  CTRL0_ENABLE_SHIFT		31
-#define  CTRL0_DAT_SEL_SHIFT		14
-#define  CTRL0_DAT_SEL			(0x3 << CTRL0_DAT_SEL_SHIFT)
+#define  CTRL0_DAT_SEL_MSB		15
+#define  CTRL0_DAT_SEL_LSB		14
 #define  CTRL0_LANE_SEL			12
-#define  CTRL0_LRCLK_SEL		GENMASK(9, 8)
+#define  CTRL0_LRCLK_SEL_MSB		9
+#define  CTRL0_LRCLK_SEL_LSB		8
 #define  CTRL0_BLK_CAP_INV		BIT(7)
 #define  CTRL0_BCLK_O_INV		BIT(6)
-#define  CTRL0_BCLK_SEL			GENMASK(5, 4)
+#define  CTRL0_BCLK_SEL_MSB		5
+#define  CTRL0_BCLK_SEL_LSB		4
 #define  CTRL0_MCLK_SEL			GENMASK(2, 0)
 
 #define TOACODEC_OUT_CHMAX		2
 
+struct g12a_toacodec {
+	struct regmap_field *field_dat_sel;
+	struct regmap_field *field_lrclk_sel;
+	struct regmap_field *field_bclk_sel;
+};
+
+struct g12a_toacodec_match_data {
+	struct reg_field field_dat_sel;
+	struct reg_field field_lrclk_sel;
+	struct reg_field field_bclk_sel;
+};
+
 static const char * const g12a_toacodec_mux_texts[] = {
 	"I2S A", "I2S B", "I2S C",
 };
@@ -41,29 +55,24 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *component =
 		snd_soc_dapm_kcontrol_component(kcontrol);
+	struct g12a_toacodec *priv = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_dapm_kcontrol_dapm(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int mux, changed;
+	unsigned int mux, reg;
 
 	mux = snd_soc_enum_item_to_val(e, ucontrol->value.enumerated.item[0]);
-	changed = snd_soc_component_test_bits(component, e->reg,
-					      CTRL0_DAT_SEL,
-					      FIELD_PREP(CTRL0_DAT_SEL, mux));
+	regmap_field_read(priv->field_dat_sel, &reg);
 
-	if (!changed)
+	if (mux == reg)
 		return 0;
 
 	/* Force disconnect of the mux while updating */
 	snd_soc_dapm_mux_update_power(dapm, kcontrol, 0, NULL, NULL);
 
-	snd_soc_component_update_bits(component, e->reg,
-				      CTRL0_DAT_SEL |
-				      CTRL0_LRCLK_SEL |
-				      CTRL0_BCLK_SEL,
-				      FIELD_PREP(CTRL0_DAT_SEL, mux) |
-				      FIELD_PREP(CTRL0_LRCLK_SEL, mux) |
-				      FIELD_PREP(CTRL0_BCLK_SEL, mux));
+	regmap_field_write(priv->field_dat_sel, mux);
+	regmap_field_write(priv->field_lrclk_sel, mux);
+	regmap_field_write(priv->field_bclk_sel, mux);
 
 	/*
 	 * FIXME:
@@ -86,7 +95,7 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 }
 
 static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,
-			    CTRL0_DAT_SEL_SHIFT,
+			    CTRL0_DAT_SEL_LSB,
 			    g12a_toacodec_mux_texts);
 
 static const struct snd_kcontrol_new g12a_toacodec_mux =
@@ -205,19 +214,42 @@ static const struct regmap_config g12a_toacodec_regmap_cfg = {
 	.reg_stride	= 4,
 };
 
+static const struct g12a_toacodec_match_data g12a_toacodec_match_data = {
+	.field_dat_sel	= REG_FIELD(TOACODEC_CTRL0, 14, 15),
+	.field_lrclk_sel = REG_FIELD(TOACODEC_CTRL0, 8, 9),
+	.field_bclk_sel	= REG_FIELD(TOACODEC_CTRL0, 4, 5),
+};
+
 static const struct of_device_id g12a_toacodec_of_match[] = {
-	{ .compatible = "amlogic,g12a-toacodec", },
+	{
+		.compatible = "amlogic,g12a-toacodec",
+		.data = &g12a_toacodec_match_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, g12a_toacodec_of_match);
 
 static int g12a_toacodec_probe(struct platform_device *pdev)
 {
+	const struct g12a_toacodec_match_data *data;
 	struct device *dev = &pdev->dev;
+	struct g12a_toacodec *priv;
 	void __iomem *regs;
 	struct regmap *map;
 	int ret;
 
+	data = device_get_match_data(dev);
+	if (!data) {
+		dev_err(dev, "failed to match device\n");
+		return -ENODEV;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
 	ret = device_reset(dev);
 	if (ret)
 		return ret;
@@ -233,6 +265,18 @@ static int g12a_toacodec_probe(struct platform_device *pdev)
 		return PTR_ERR(map);
 	}
 
+	priv->field_dat_sel = devm_regmap_field_alloc(dev, map, data->field_dat_sel);
+	if (IS_ERR(priv->field_dat_sel))
+		return PTR_ERR(priv->field_dat_sel);
+
+	priv->field_lrclk_sel = devm_regmap_field_alloc(dev, map, data->field_lrclk_sel);
+	if (IS_ERR(priv->field_lrclk_sel))
+		return PTR_ERR(priv->field_lrclk_sel);
+
+	priv->field_bclk_sel = devm_regmap_field_alloc(dev, map, data->field_bclk_sel);
+	if (IS_ERR(priv->field_bclk_sel))
+		return PTR_ERR(priv->field_bclk_sel);
+
 	return devm_snd_soc_register_component(dev,
 			&g12a_toacodec_component_drv, g12a_toacodec_dai_drv,
 			ARRAY_SIZE(g12a_toacodec_dai_drv));
-- 
2.25.1

