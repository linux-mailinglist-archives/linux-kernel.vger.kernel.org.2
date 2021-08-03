Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8D53DE8B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhHCIq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:46:28 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53079 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234731AbhHCIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:46:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 853515C00CC;
        Tue,  3 Aug 2021 04:46:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 03 Aug 2021 04:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=aPr6JcL4pftxw
        OS9Or0rSJmJSHuxufqjZPPreQpE5Hs=; b=Bmh7JD1tsIJDg95s8TmR9EPajSsE7
        oZQ7gR+/cQ04LGOWGCkxuWGw3aLKsM/nii6QFj7eQ20KOX/29Z0QLfRcRZRV6+6C
        cxYcqmixDohrKc+oTjGyDMS8eanZlYRKI3XfLsIjBEYmAEJYXmRtOv9aLd0IoP+n
        je4dMNv8NV5dX7i2Qrv6Np9vivwqNSJjQHUrliX9qYjoxzu9oJyP8/76kL5Hzpe0
        aO0/itnzoXgTaHFgLvG1VxfT/jxQsItjOwdC9dFKDdDnSgnDIeSecS8EtaKxjPRF
        3MMEVR/PYK0TJ65Vx9cc0sAaps3q0pBOMkwmohFCCSWztRaJo2zpmNqwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=aPr6JcL4pftxwOS9Or0rSJmJSHuxufqjZPPreQpE5Hs=; b=uesEnjKR
        hj2Dm+ICs4kaEojLZNAsPMLfZq51U//rs4JQ0ekyI9hzLSabDlv+br86GO1ZZ0ne
        ZU7iBbB1A/6JrndV5bP6xfbm/gq9vfTEaBCq+8kB8oK5wQkBVWOabPWfV76hRg4/
        aH7E/GtbCx7LKA4NT+XBy+Pp2wE+NyWbq3TACwBzJ9lUR2gpNhD/suQ9sE73dmUP
        wi1dMyloPetCRIgeQztqVIgEHXYYXGnTqG4ckmh5bYdNbM+75AcK8O/bFOrXBdBL
        dgn0+S0qMp3vJnH5SkzhX/8jnAU+4BXH5r0IBmvD21+83ywwxlnqOjuFdT8+KFxy
        aUCUe6wjprFodw==
X-ME-Sender: <xms:VAIJYU9RtitGB7lb6ZUY53IhXOALsQoJtba3nxYXFYQJ5FoXsvlz6Q>
    <xme:VAIJYcu0dygXcytN08kBjdWFYGgL82yF43wAKRz-9l2oM_67M3HK4KDoo3PiJgSZK
    DOe66PM1jNyzS9DUBo>
X-ME-Received: <xmr:VAIJYaC06nMu5fCTmF7ck7_1QYkX__pKYmBxeKtGqcBdXBR6OwT0hbykgewHW1F5l4ICTgS2PQBwAysOjBNBi13BHafp7xYEV15XFZ1IsjJdag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:VAIJYUcUmsGf4Ld1q0cnSlK-23cg5DtTD5Ph4ANUy4Mu1bESCk-kxQ>
    <xmx:VAIJYZMwilzqupkODm33uAiAiI_Cp2_8_cy8dy5PRwcpRQJxIRMZ8Q>
    <xmx:VAIJYelc5VBOMS52RuTBfU9TunZk540JouZzrBoHrlJorbxOGLACMQ>
    <xmx:VAIJYccHNDQIx8L2bNs5_A49JJSKVi7RSVaKTGXL3UJQdFFW03ZHEg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:46:08 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 06/11] regulator: sy7636a: Use the parent driver data
Date:   Tue,  3 Aug 2021 18:44:53 +1000
Message-Id: <20210803084456.198-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803084456.198-1-alistair@alistair23.me>
References: <20210803084456.198-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the parent's MFD data instead of our data.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/sy7636a-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index c3b34cac8c7f..0bd21c3ea24a 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -33,7 +33,7 @@ static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
 
 static int sy7636a_get_status(struct regulator_dev *rdev)
 {
-	struct sy7636a *sy7636a = rdev_get_drvdata(rdev);
+	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
 	int ret = 0;
 
 	ret = gpiod_get_value_cansleep(sy7636a->pgood_gpio);
@@ -76,9 +76,9 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sy7636a);
 
-	gdp = devm_gpiod_get(sy7636a->dev, "epd-pwr-good", GPIOD_IN);
+	gdp = devm_gpiod_get(pdev->dev.parent, "epd-pwr-good", GPIOD_IN);
 	if (IS_ERR(gdp)) {
-		dev_err(sy7636a->dev, "Power good GPIO fault %ld\n", PTR_ERR(gdp));
+		dev_err(pdev->dev.parent, "Power good GPIO fault %ld\n", PTR_ERR(gdp));
 		return PTR_ERR(gdp);
 	}
 
@@ -86,18 +86,18 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 
 	ret = regmap_write(sy7636a->regmap, SY7636A_REG_POWER_ON_DELAY_TIME, 0x0);
 	if (ret) {
-		dev_err(sy7636a->dev, "Failed to initialize regulator: %d\n", ret);
+		dev_err(pdev->dev.parent, "Failed to initialize regulator: %d\n", ret);
 		return ret;
 	}
 
 	config.dev = &pdev->dev;
-	config.dev->of_node = sy7636a->dev->of_node;
+	config.dev->of_node = pdev->dev.parent->of_node;
 	config.driver_data = sy7636a;
 	config.regmap = sy7636a->regmap;
 
 	rdev = devm_regulator_register(&pdev->dev, &desc, &config);
 	if (IS_ERR(rdev)) {
-		dev_err(sy7636a->dev, "Failed to register %s regulator\n",
+		dev_err(pdev->dev.parent, "Failed to register %s regulator\n",
 			pdev->name);
 		return PTR_ERR(rdev);
 	}
-- 
2.31.1

