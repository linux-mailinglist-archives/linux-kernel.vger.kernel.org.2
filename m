Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0113ABD04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbhFQTpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhFQTpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:45:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE4AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:42:53 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id h12so5872139pfe.2;
        Thu, 17 Jun 2021 12:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HgQ9eAiW96/ovGrHzecsI1VfEM+0/YBZu4OcH2CPvU=;
        b=IDSWM3vrjvw7MeiWIr15DCD+wCW8pjSkdRreLc5MeLbze+tu8Nh8QKvgpZssU2jVh+
         EMQCfONigNWK4SDSJ/Hw4tHIUeJBc9nrRMdXQo22qr2+R+URmi6vb6T/1TOssz/c/3IK
         eS5oGDLvCKwpthgHfrcJj4g0SKG5ZZRClREimHO1848jnbGediRxvFf61qDukJXFpd1h
         SzBCWnmdPDWqQo+KA1dJBHSG6GUv7To0iQ8M2XI0kWZhmbHCuLU2u8Qt+kMsKhGPdyWn
         Dg7Dn+CNiwz/MxDpXDkKaL2AGon9BTny6fi0WRb+pWbR6spNHihtCmD4S79nIpyFoZA+
         0ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HgQ9eAiW96/ovGrHzecsI1VfEM+0/YBZu4OcH2CPvU=;
        b=T5cm1EcHvOiE+i5ndfqBsPiwh1X17HcUfn+I5soV/0eJoWmo9ZMtMDQH8zv4B0giqS
         RWXIJTf7zeFtmeQAHNr+k68DlF9M0yxd/RfNPI0Bb97+wRTbL+XV/JsUreIAtedhzR9o
         uSb6Rgs1LkVmk02xYiXHfX1sAtuS/TvbxiRjNi4bNW90Q1Sh2HRMmvpeO2QdZvW50XSP
         YdKklze19wVMmKh1X7j3xoALGNFToHIdbp1OAD/zbPq5fGcpSqbvqlz33ppfro3dLjxI
         IfyxHJGdrnEPBhVQw7uoY1rShq/RqMxibRvOA7QEKqkic78KjIEJDvsKTar1Rya0HRZJ
         GazA==
X-Gm-Message-State: AOAM530AB3nA8dxQg9zz8BdOfo3tlJPB0q0TyN6XU0+vXi//QMwTQtUX
        gFH7naa6zEfUaR8wjiF0fTg=
X-Google-Smtp-Source: ABdhPJx5ZIxR9ySXUG7SX502EB68UiuFkiJPUuTxkOHSdD37m0SDC1zBokNef3WrEmJMyPMDImpLdw==
X-Received: by 2002:a63:5360:: with SMTP id t32mr6385187pgl.192.1623958973053;
        Thu, 17 Jun 2021 12:42:53 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.75.27])
        by smtp.gmail.com with ESMTPSA id z9sm5987187pfa.2.2021.06.17.12.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:42:52 -0700 (PDT)
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
Subject: [RFCv1 1/8] phy: amlogic: meson8b-usb2: Use clock bulk to get clocks for phy
Date:   Thu, 17 Jun 2021 19:41:36 +0000
Message-Id: <20210617194154.2397-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617194154.2397-1-linux.amoon@gmail.com>
References: <20210617194154.2397-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clock bulk helpers to get/enable/disable clocks,
it will be easier to handle clocks. No functional change intended.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 44 ++++++++++++++------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 03c061dd5f0d..771b73f3b44e 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -121,11 +121,16 @@ struct phy_meson8b_usb2_match_data {
 	bool			host_enable_aca;
 };
 
+static const char * const meson_phy_clks[] = {
+	"usb_general",
+	"usb",
+};
+
 struct phy_meson8b_usb2_priv {
 	struct regmap					*regmap;
 	enum usb_dr_mode				dr_mode;
-	struct clk					*clk_usb_general;
-	struct clk					*clk_usb;
+	int                                             num_clks;
+	struct clk_bulk_data                            *clks;
 	struct reset_control				*reset;
 	const struct phy_meson8b_usb2_match_data	*match;
 };
@@ -151,16 +156,9 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 		}
 	}
 
-	ret = clk_prepare_enable(priv->clk_usb_general);
+	ret = clk_bulk_prepare_enable(priv->num_clks, priv->clks);
 	if (ret) {
-		dev_err(&phy->dev, "Failed to enable USB general clock\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(priv->clk_usb);
-	if (ret) {
-		dev_err(&phy->dev, "Failed to enable USB DDR clock\n");
-		clk_disable_unprepare(priv->clk_usb_general);
+		dev_err(&phy->dev, "Failed to enable USB clock\n");
 		return ret;
 	}
 
@@ -197,8 +195,7 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 			regmap_read(priv->regmap, REG_ADP_BC, &reg);
 			if (reg & REG_ADP_BC_ACA_PIN_FLOAT) {
 				dev_warn(&phy->dev, "USB ID detect failed!\n");
-				clk_disable_unprepare(priv->clk_usb);
-				clk_disable_unprepare(priv->clk_usb_general);
+				clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
 				return -EINVAL;
 			}
 		}
@@ -216,8 +213,7 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
 				   REG_DBG_UART_SET_IDDQ,
 				   REG_DBG_UART_SET_IDDQ);
 
-	clk_disable_unprepare(priv->clk_usb);
-	clk_disable_unprepare(priv->clk_usb_general);
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
 
 	return 0;
 }
@@ -234,6 +230,7 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
 	struct phy *phy;
 	struct phy_provider *phy_provider;
 	void __iomem *base;
+	int i, ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -252,13 +249,18 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
-	priv->clk_usb_general = devm_clk_get(&pdev->dev, "usb_general");
-	if (IS_ERR(priv->clk_usb_general))
-		return PTR_ERR(priv->clk_usb_general);
+	priv->num_clks = ARRAY_SIZE(meson_phy_clks);
+	priv->clks = devm_kcalloc(&pdev->dev, priv->num_clks,
+				  sizeof(*priv->clks), GFP_KERNEL);
+	if (!priv->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < priv->num_clks; i++)
+		priv->clks[i].id = meson_phy_clks[i];
 
-	priv->clk_usb = devm_clk_get(&pdev->dev, "usb");
-	if (IS_ERR(priv->clk_usb))
-		return PTR_ERR(priv->clk_usb);
+	ret = devm_clk_bulk_get(&pdev->dev, priv->num_clks, priv->clks);
+	if (ret)
+		return ret;
 
 	priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (PTR_ERR(priv->reset) == -EPROBE_DEFER)
-- 
2.31.1

