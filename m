Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37AB3E26DC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbhHFJLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:11:53 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59861 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244085AbhHFJLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:11:49 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 04CD15C00D9;
        Fri,  6 Aug 2021 05:11:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 06 Aug 2021 05:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=tmsLsa/eRaufF
        J8jRKvAmHCUqfWGYVXTYZw+tCYDWos=; b=IFPrClOmDWtBDLGH/54BI3Y4lPbfe
        vYnovPVgUePLAq4UyXGtphNo7WrKc9QgIgZxVmkQ8UVJ2eU0QemZ13wP46Kl/ORT
        COmKKVzND5GZ9ZvkYBLoQ6FqrWbX0XDf5rpwf7e9HDy6GIo/+sng83+ygPcAddvQ
        74e7eayoZfKVEyM3VsMWkzvJ+epAXpusPzOzZnR/8ZybpF9wysDW92IwXour0JuP
        YcivRG2dMCeHhGM4gwFfQwUDIi7sEWCgjj8aoDU3C9y1dT7Rxu3G9MZDp1OlDj7b
        cP5rR/qa2noBl9W7sziPsdgHlDYWNaGAMcqACJLD4EWXW+JssuRkjyvbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=tmsLsa/eRaufFJ8jRKvAmHCUqfWGYVXTYZw+tCYDWos=; b=jZdDI3k8
        YdbDwL2oY5uIKQ4V4FRBlUH//21ZtmBfTP67WvyTRlI6f8KLxXcXA3azfcukvhOU
        Cwwt53Mm5erQUxnQy5aikD61Z7AA2HlBes6rqj0DNWpExnlZTCrwd7FmQMnKvONq
        DJEKSp9jVF4xj8GCd+mheHc95apk3lizOMcrPbVOvbV8EcbiM/jaqGsTi9P4Im1O
        6FBEFXORkUTExIh8s27M1+F8CVCpbmkJVRK6snV0Sl05CT3HL/6GtJrpJDXUcctY
        JQWlSc2ihYIipammOnvSzWVh3vE3xR30NilNoJK++9J90Bov4Q19PM2izOlDFss/
        EASK2pUL5kHCXw==
X-ME-Sender: <xms:xfwMYYw4tCTXhJ8C9t7RSLpE_pHv04q0GhBRbg4nUBq9C3XjM9KwzA>
    <xme:xfwMYcT3j1w9asXme6w-vghCOucEATU6t4rd7AkP0boTs8AFpeNltZgeDrIF7Eu36
    J6CsA3bobxM1GAsag0>
X-ME-Received: <xmr:xfwMYaXu9hmej2sMQfGhCwCJ7fw8WPVZdb5gVwdM04n7fhxIxa5VtcZn-pVm5bGf6pALQlkwZwM9iW9KTa-KzAV36f3S6No5EL04yrealWF8yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:xfwMYWhGi0PU4jD7BsthhSNFderGmDt3g87bX_v-blJw27ghtP9ifw>
    <xmx:xfwMYaAusjenuyTEUeHgME59wXm4DhBK5Xxnxt2LMrjfqVWkfoJN2g>
    <xmx:xfwMYXI2KAmj3fJnLjXbgb9krGlCZVdSHUM6K61a7Z-OmJd4S5LYlQ>
    <xmx:xvwMYQD7tlf1E4ih8gIr2wkkEmi-5GunIhZH4D-wgQshI9Hv0URTOw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:30 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 05/12] regulator: sy7636a: Use the regmap directly
Date:   Fri,  6 Aug 2021 19:10:51 +1000
Message-Id: <20210806091058.141-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806091058.141-1-alistair@alistair23.me>
References: <20210806091058.141-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/sy7636a-regulator.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index 37bf2a3c06b7..8360b3947ead 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -14,7 +14,7 @@
 #include <linux/mfd/sy7636a.h>
 
 struct sy7636a_data {
-	struct sy7636a *sy7636a;
+	struct regmap *regmap;
 	struct gpio_desc *pgood_gpio;
 };
 
@@ -70,14 +70,14 @@ static const struct regulator_desc desc = {
 
 static int sy7636a_regulator_probe(struct platform_device *pdev)
 {
-	struct sy7636a *sy7636a = dev_get_drvdata(pdev->dev.parent);
+	struct regmap *regmap = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	struct gpio_desc *gdp;
 	struct sy7636a_data *data;
 	int ret;
 
-	if (!sy7636a)
+	if (!regmap)
 		return -EPROBE_DEFER;
 
 	gdp = devm_gpiod_get(pdev->dev.parent, "epd-pwr-good", GPIOD_IN);
@@ -90,12 +90,12 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	data->sy7636a = sy7636a;
+	data->regmap = regmap;
 	data->pgood_gpio = gdp;
 
 	platform_set_drvdata(pdev, data);
 
-	ret = regmap_write(sy7636a->regmap, SY7636A_REG_POWER_ON_DELAY_TIME, 0x0);
+	ret = regmap_write(regmap, SY7636A_REG_POWER_ON_DELAY_TIME, 0x0);
 	if (ret) {
 		dev_err(pdev->dev.parent, "Failed to initialize regulator: %d\n", ret);
 		return ret;
@@ -103,8 +103,7 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 
 	config.dev = &pdev->dev;
 	config.dev->of_node = pdev->dev.parent->of_node;
-	config.driver_data = sy7636a;
-	config.regmap = sy7636a->regmap;
+	config.regmap = regmap;
 
 	rdev = devm_regulator_register(&pdev->dev, &desc, &config);
 	if (IS_ERR(rdev)) {
-- 
2.31.1

