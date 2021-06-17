Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6453ABD08
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhFQTpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFQTpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:45:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967BBC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:43:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso5961913pjx.1;
        Thu, 17 Jun 2021 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ru7VYZQFM1VVEN15+QmGHBxSNzsOgYyzaqlXuO2dVxw=;
        b=Lw7iEBZ4GD3k2g+fSKiJqkf85PV7RM3V4AcTlkHE5CxPdrnHgXsvsxuqGq0RDe33cc
         uXNcINgRIEnA+CdK0wQphN7H3fTlGDe6qrFFTaROCmFtZh4Qxi8KQnf86KtaRN4Xc6cr
         0XUhUmpCpx2hWZmv9Cml21ppM2R6msZ+TrI+m5GWaQpy3o0cLh11y3+2F0aiC3Sik1ss
         xQnYIGhqlo38r6HMGmpCkGg72/bHRGYACDbGpqds5QboQHg95wXexwhhtTXK4aTVkqb3
         F5dbsdVhnlHIM73fLHOFmwWUDC/ktoK1e5xKgkLkcK2A/3F3BJrBa0e1J3MpMai/Y4Di
         p9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ru7VYZQFM1VVEN15+QmGHBxSNzsOgYyzaqlXuO2dVxw=;
        b=ZfESYN6eq4zk2KIFCSb54taTckZ0RcR9MwNUyC2ZFjjOaaE3Li3mLl5AAOvj1FhuPh
         p14BV06tyJXxqJ0c52vQ9tTUZr9t2HpQLP1QocIqo3Yfk9w5PcAyy7v0Rznuw3rr38kt
         DtIoiBtN1AqIyzqspB93tWh98eAdONWm4soNTE0kZFrV0tOXKPGqp8RmzIDVsxSokdB4
         5lvvIpPJnilq6KFJBdrg6Xvd2mwpbafX/Dg3vNLMszj+KRTp+N1BIp544lrJifJiQaM1
         w77vUBuMvc/2U7YJHzRg049d5CRkv8i2mkM+GDsLcxd2/G3P7Ze1sRXGmyXEV4zI4EvH
         SfWg==
X-Gm-Message-State: AOAM532uU+BcE70SXHZ3ubCGiAxmTSBaD58UDh40IHP/X3UB0aYAi+uC
        a0+jy2kbSohbt3K/OoNAtIo=
X-Google-Smtp-Source: ABdhPJy8kifTsQYkHADB3X/VjwWX4edCBRIlpmtaNoexFdNOuNYczcrBwE+yOodX+UnG3Bcu8rQXdQ==
X-Received: by 2002:a17:90b:197:: with SMTP id t23mr6968654pjs.61.1623959023215;
        Thu, 17 Jun 2021 12:43:43 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.75.27])
        by smtp.gmail.com with ESMTPSA id z9sm5987187pfa.2.2021.06.17.12.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:43:42 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     --to=linux-phy@lists.infradead.org,
        --to=linux-arm-kernel@lists.infradead.org,
        --to=linux-amlogic@lists.infradead.org,
        --to=linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 4/8] phy: amlogic: meson8b-usb2: Use phy set_mode callback function
Date:   Thu, 17 Jun 2021 19:41:39 +0000
Message-Id: <20210617194154.2397-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617194154.2397-1-linux.amoon@gmail.com>
References: <20210617194154.2397-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the code for phy set_mode in .set_mode callback function.
For now configure the phy in host mode.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 62 ++++++++++++++++++--------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 2b32a3eabccf..18e0986f6ed2 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -173,11 +173,43 @@ static int phy_meson8b_usb2_exit(struct phy *phy)
 	return 0;
 }
 
-static int phy_meson8b_usb2_power_on(struct phy *phy)
+static int phy_meson8b_usb2_setmode(struct phy *phy, enum phy_mode mode,
+				    int submode)
 {
 	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
 	u32 reg;
 
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+		if (priv->match->host_enable_aca) {
+			regmap_update_bits(priv->regmap, REG_ADP_BC,
+					   REG_ADP_BC_ACA_ENABLE,
+					   REG_ADP_BC_ACA_ENABLE);
+
+			udelay(ACA_ENABLE_COMPLETE_TIME);
+
+			regmap_read(priv->regmap, REG_ADP_BC, &reg);
+			if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
+				dev_warn(&phy->dev, "USB ID detect failed!\n");
+				return -EINVAL;
+			}
+		}
+		break;
+	default:
+		dev_warn(&phy->dev, "USB ID detect failed to setnode! %d\n", mode);
+		return -EINVAL;
+	}
+
+	priv->dr_mode = mode;
+
+	return 0;
+}
+
+static int phy_meson8b_usb2_power_on(struct phy *phy)
+{
+	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
 	regmap_update_bits(priv->regmap, REG_CONFIG, REG_CONFIG_CLK_32k_ALTSEL,
 			   REG_CONFIG_CLK_32k_ALTSEL);
 
@@ -197,24 +229,12 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_SOF_TOGGLE_OUT,
 			   REG_CTRL_SOF_TOGGLE_OUT);
 
-	if (priv->dr_mode == USB_DR_MODE_HOST) {
-		regmap_update_bits(priv->regmap, REG_DBG_UART,
-				   REG_DBG_UART_SET_IDDQ, 0);
-
-		if (priv->match->host_enable_aca) {
-			regmap_update_bits(priv->regmap, REG_ADP_BC,
-					   REG_ADP_BC_ACA_ENABLE,
-					   REG_ADP_BC_ACA_ENABLE);
-
-			udelay(ACA_ENABLE_COMPLETE_TIME);
-
-			regmap_read(priv->regmap, REG_ADP_BC, &reg);
-			if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
-				dev_warn(&phy->dev, "USB ID detect failed!\n");
-				clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
-				return -EINVAL;
-			}
-		}
+	ret = phy_meson8b_usb2_setmode(phy, priv->dr_mode, 0);
+	if (ret) {
+		phy_meson8b_usb2_power_off(phy);
+		dev_err(&phy->dev, "Failed to initialize PHY with mode %d\n",
+			priv->dr_mode);
+		return ret;
 	}
 
 	return 0;
@@ -238,6 +258,7 @@ static const struct phy_ops phy_meson8b_usb2_ops = {
 	.exit           = phy_meson8b_usb2_exit,
 	.power_on	= phy_meson8b_usb2_power_on,
 	.power_off	= phy_meson8b_usb2_power_off,
+	.set_mode	= phy_meson8b_usb2_setmode,
 	.owner		= THIS_MODULE,
 };
 
@@ -261,6 +282,9 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
 	if (!priv->match)
 		return -ENODEV;
 
+	/* start in host mode */
+	priv->dr_mode = PHY_MODE_USB_HOST;
+
 	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					     &phy_meson8b_usb2_regmap_conf);
 	if (IS_ERR(priv->regmap))
-- 
2.31.1

