Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83ABF3E34E7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhHGKkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:40:32 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48927 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232057AbhHGKk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:27 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7AFE75C00C2;
        Sat,  7 Aug 2021 06:40:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 07 Aug 2021 06:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=tmsLsa/eRaufF
        J8jRKvAmHCUqfWGYVXTYZw+tCYDWos=; b=hwMQKj39aHvYJor4Hv0WxCr9YbpZA
        VCTmXQZ18ehWgIQrscHgliXLT6n54VyU75ZOBFOhVDHyXMQoNk12pyZbfWnZslVO
        +B/mHrxtbfeHI84gZHttJAJM707aFM/1q3a3ii7gMJz2Cbo6IZaCFjuz9PhoqQfo
        2SAZjRwguSz4kge1cnUEGDYFBXLAYKC/nAFMybgzWDA2VVOZwKVLMeJnnu8tsFy8
        +NeK4ZXVeiFFHSPOQI4dtn/H1rpqdDzFs9P63p/caaLtmrqkcZxcpleB/mK2WRv+
        SVmYoc4emISXw4eoPw25DoTJ8ve/+9buDF0jWU5NY2FGjtSgkq3dSd3Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=tmsLsa/eRaufFJ8jRKvAmHCUqfWGYVXTYZw+tCYDWos=; b=wxXRI6iL
        FwISmxM5Imiah6ghMNCTI0UyjHApIiS+CbWWI/AysIZ431yJJGL2Uj2tEX2G0ct5
        4kO8n31Cq47RzCAeORs3h7awz+qK9wxbOL7l/YhaBHyhvJeOt+k9hC0HDD6bV1jq
        Axq1NkPPNHjtYuTDhRug+Mw+/oblgJKIDGxwWACbKMNZaPSAWGZnCSbHTdV3iDxa
        jmufqI8R4/XrrmB5pz8whWJDG+krGWEnbRkLusmHsQo+xWe9Stz8rAZdgw08dcPi
        9C0TEdZqMl5MkBD/j2MbVvPmidPf4GsKgo19FIn+I19YGq4QW/a3g9kNlfeLeMzN
        Gcg2x8gv5TSsqQ==
X-ME-Sender: <xms:CmMOYdk4Ix4AFXuf48HVamPm_ETMy69lH8FO2Wr6MpTV70mcbD4rQA>
    <xme:CmMOYY1GFFizimsyKA3qiaynGhfBOKGZ5jYTwwcdcKoquKHCrWIfRtnzb7zdPRWlc
    o3gELAyOW-AZ2IlcsA>
X-ME-Received: <xmr:CmMOYToQYf_zYT6NuBcM5GYDZnkzvxHY7wvuBpk2IYmREdiJZ5_afyRvFuVu7vVrteHJuLSVnV7cTjFeXKBmtS2KGssmiKsuNQWaB6QUR2BuRZ3DRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:CmMOYdlwQ3chZgL-g9DYHobJE7V4HOrFBPNUBqWnonRM9MLWKujOQQ>
    <xmx:CmMOYb3GadFXCiQu6Wv-MyWmfOPMn5BSxy8JVKObhL42oe5KUbfVyA>
    <xmx:CmMOYcsIus_1887dfguNQyYDbILxEECrdIDB91QY8IXSv0kJZhbH3w>
    <xmx:CmMOYQmOAFCrTgzqWT3vW_XSwlOYlJJDNPY4b2hnx5B5UuiVgZQzGw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:40:06 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 04/11] regulator: sy7636a: Use the regmap directly
Date:   Sat,  7 Aug 2021 20:39:33 +1000
Message-Id: <20210807103940.152-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807103940.152-1-alistair@alistair23.me>
References: <20210807103940.152-1-alistair@alistair23.me>
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

