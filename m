Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9247B3ABD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhFQTq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFQTqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:46:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E9AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:44:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a127so5833181pfa.10;
        Thu, 17 Jun 2021 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=083k0zv8Ytg086lmX8X+TtAKRzXKvvth7IVx9plMtXg=;
        b=iuajfJilA0fwo4o/4oh4VDEAW6K9CA+mAVG1N73pVcpReCbdShNd7WB85LybfZQHjB
         Xby86N2VkOHbLyYxQhP0vKv//8KimP7qM2RAnzNuEewy84WGVtavZPyAfT0PMEevO3kh
         YaCKWXcZGDrqVekkPU+9J9+1Ei4tLb74yW5VYooD8DsMYNcE8WIgtr31HhazXJFoAoJ/
         hQs+rCZgYmqhhuNKGE8q7CaRprAt6+6XzW/O5CC6BAL4huoAdKKyxewif5XV+9HJ0lxb
         0lQhHy7HhGKhmK/hs8qUlRhJcBWJYce1ZjdCFMBc6WrmHw3Y9np3Oja+5GynM0VhzNmB
         bwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=083k0zv8Ytg086lmX8X+TtAKRzXKvvth7IVx9plMtXg=;
        b=P6m5ny36Aapdttl7nBksMi0u/8s4LOfPivnoCX8wNRx3i4NQULsBTbX8K/DvVfu4k/
         wGAI7kphfb46VlQ1wK61kMZLwBJlakIJCo8fewZhmtyvgj+5KycztIaRLzkY068BkiWn
         v9bkg671rMC99aVpfSm4o/AhHGv14kwUUEM3JeT2ysASjiH7IH4Mh2KonrVR/y2IRfh8
         8Gu86HZmZi6TXnIwtwn26cgHQGPD3kv+4GaHEEMztRkes/x1vBknMcXmIubfOb1NfBNB
         QDKk3Ee0gZP/YQEnjBrpA9Op20coh2jzPtoB+3pOxq5/Q8zhzrAYA3ymhRSeNslAxBkR
         Sa+w==
X-Gm-Message-State: AOAM532xlBeFOsX8UrMEezCc3v0YzzhkqogAQHw8nT6PRTRaHoMyJ/kR
        K04herp8ec1fKzNd55YnIxQ=
X-Google-Smtp-Source: ABdhPJxt9c7UvvRETV6duPF5gupqd/aXsSexrgfUjLHqotY9ZIoS1gjWqBegyutCZwZkYOgqDB/Dmw==
X-Received: by 2002:a65:4242:: with SMTP id d2mr6293256pgq.243.1623959056538;
        Thu, 17 Jun 2021 12:44:16 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.75.27])
        by smtp.gmail.com with ESMTPSA id z9sm5987187pfa.2.2021.06.17.12.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:44:16 -0700 (PDT)
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
Subject: [RFCv1 6/8] phy: amlogic: meson8b-usb2: Use phy reset callback function
Date:   Thu, 17 Jun 2021 19:41:41 +0000
Message-Id: <20210617194154.2397-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617194154.2397-1-linux.amoon@gmail.com>
References: <20210617194154.2397-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reoder the code for phy reset mode in .reset callback function.
Reset control is shared between two phy so use the phy name
as shared id.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 35 ++++++++++++++++++--------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index ab23a584d7b7..c1ed2e5c80d8 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -133,6 +133,7 @@ struct phy_meson8b_usb2_priv {
 	struct clk_bulk_data                            *clks;
 	struct reset_control				*reset;
 	const struct phy_meson8b_usb2_match_data	*match;
+	int						is_enabled;
 };
 
 static const struct regmap_config phy_meson8b_usb2_regmap_conf = {
@@ -147,14 +148,6 @@ static int phy_meson8b_usb2_init(struct phy *phy)
 	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
 	int ret;
 
-	if (!IS_ERR_OR_NULL(priv->reset)) {
-		ret = reset_control_reset(priv->reset);
-		if (ret) {
-			dev_err(&phy->dev, "Failed to trigger USB reset\n");
-			return ret;
-		}
-	}
-
 	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
 	if (ret) {
 		dev_err(&phy->dev, "Failed to enable USB clock\n");
@@ -173,6 +166,22 @@ static int phy_meson8b_usb2_exit(struct phy *phy)
 	return 0;
 }
 
+static int phy_meson8b_usb2_reset(struct phy *phy)
+{
+	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	if (priv->is_enabled) {
+		ret = reset_control_reset(priv->reset);
+		if (ret) {
+			dev_err(&phy->dev, "Failed to trigger USB reset\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int phy_meson8b_usb2_setmode(struct phy *phy, enum phy_mode mode,
 				    int submode)
 {
@@ -200,6 +209,8 @@ static int phy_meson8b_usb2_setmode(struct phy *phy, enum phy_mode mode,
 		return -EINVAL;
 	}
 
+	phy_meson8b_usb2_reset(phy);
+
 	priv->dr_mode = mode;
 
 	return 0;
@@ -209,6 +220,8 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
 {
 	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
 
+	priv->is_enabled = 0;
+
 	if (priv->dr_mode == USB_DR_MODE_HOST)
 		regmap_update_bits(priv->regmap, REG_DBG_UART,
 				   REG_DBG_UART_SET_IDDQ,
@@ -221,6 +234,8 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
 	int ret;
 
+	priv->is_enabled = 1;
+
 	regmap_update_bits(priv->regmap, REG_CONFIG, REG_CONFIG_CLK_32k_ALTSEL,
 			   REG_CONFIG_CLK_32k_ALTSEL);
 
@@ -229,7 +244,6 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 
 	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_FSEL_MASK,
 			   0x5 << REG_CTRL_FSEL_SHIFT);
-
 	/* reset the PHY */
 	regmap_update_bits(priv->regmap, REG_CTRL, REG_CTRL_POWER_ON_RESET,
 			   REG_CTRL_POWER_ON_RESET);
@@ -257,6 +271,7 @@ static const struct phy_ops phy_meson8b_usb2_ops = {
 	.power_on	= phy_meson8b_usb2_power_on,
 	.power_off	= phy_meson8b_usb2_power_off,
 	.set_mode	= phy_meson8b_usb2_setmode,
+	.reset		= phy_meson8b_usb2_reset,
 	.owner		= THIS_MODULE,
 };
 
@@ -301,7 +316,7 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
 	if (PTR_ERR(priv->reset) == -EPROBE_DEFER)
 		return PTR_ERR(priv->reset);
 
-- 
2.31.1

