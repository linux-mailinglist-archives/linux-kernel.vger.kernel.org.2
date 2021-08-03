Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2853DE8B7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbhHCIqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:46:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55745 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234732AbhHCIq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:46:27 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 668DF5C0130;
        Tue,  3 Aug 2021 04:46:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 03 Aug 2021 04:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=TDCSbK7YJOfXl
        9cQmNJpf3/HZMM/XCt3H0OXX1hhXp0=; b=HDt2HABqQv3Tbci9B9UfRw14V9Oen
        77gFUAQmQ9su4HvXV2ItPqF7cpMCQwPfYkTL1fXOVBBkcsMUx7SKnMnG6eYHQPaL
        8ndO8ldT7atdXuXoueZa+Qw54UvzExd8DkUc3WhFpRlvpZbPYxQBnU7Da9fjSccb
        ADWcSDnmIRgNkcMGfI+QbQToXoNF7PSruKcWENPcNbIwAvQLa0hcAI3iDt5FKUPy
        lhoAR6b+unkSnS5LuTkLx2H1QmD9CgIE713qeFch2bEvXScoXiEs+mLYuLuYUkTh
        hQy/3yDNL+nLDZKqcL4ZQyaJu2pAlpXYhrH/x+n63j3T8ywr6BSP4+83Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=TDCSbK7YJOfXl9cQmNJpf3/HZMM/XCt3H0OXX1hhXp0=; b=ax1g9bWu
        tzhOqnwzuXJGUy4Yyui4cYLEceYUVn/kibvkLLJ4rvfy19QMZLHS7p1VNq+8jE7A
        dWeIaVa3kq2oFAbJ2LxuAbn6qS+3c29xjHPhwXIKD0ygXOnEC/JQOXRYCPG9+arh
        oKHzJuP2Sof7TzrgMN2bAAeHpdjFxL/FYsXmVGqJhHNVtd83fQMazyYf+fteNK8E
        05JYSgtLK+I6kz4AY4kKwfSqEjWwB97epOrAiUScZ78J3UOkgHyEKMospdvOk5/r
        lb12oxshu7hOX4VsjX+9NC5YKtp9Aq/PzbBkCk6K0JbwJ+xORTu930MNiKah7QSx
        i0GgInqqG/9KDw==
X-ME-Sender: <xms:WAIJYRx_fYY5tzaXD87iyvS5ej3LptatoufWtwxzXEFdzJ1We3Lj2Q>
    <xme:WAIJYRRjaMHz13-7BQSsgbQoezO6Ih2f_A-O7Bhk5k6YasAkGNeFVGeEJ_LyMmwsA
    9ThNOPYgu-PXstPFos>
X-ME-Received: <xmr:WAIJYbV_RsgDpco8V3uVTozCd1XCm9eGE13uLjzQ1Xmrb68GKWS28fvvU4S_d_4yI2xs_xJ-iNfIqaeH3_YC-WtHS15f908t97X9XReMkji-jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:WAIJYThqgJLJMDrAL4-uLZjZ03NTL3_wXKUgaONjPz4EU-WNtYJanQ>
    <xmx:WAIJYTBO_3fTnSmF_k5f8_nQbsl_tueysIo5cnU-dERpHRKgx_pK5A>
    <xmx:WAIJYcIGGq2QpZ2pFKQugZWEjKRKgsd8cKxXKsCdwoFH7j8vCgqs_w>
    <xmx:WAIJYVDawENDFCC3vsRasW5V-MvA6TQcy4Mis9sBFFuj7Iej7Xsomw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:46:12 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 07/11] regulator: sy7636a: Store the epd-pwr-good GPIO locally
Date:   Tue,  3 Aug 2021 18:44:54 +1000
Message-Id: <20210803084456.198-7-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803084456.198-1-alistair@alistair23.me>
References: <20210803084456.198-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of storing the GPIO state in the mfd (where it isn't used) store
it in the regulator.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/sy7636a-regulator.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index 0bd21c3ea24a..37bf2a3c06b7 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -13,6 +13,11 @@
 #include <linux/gpio/consumer.h>
 #include <linux/mfd/sy7636a.h>
 
+struct sy7636a_data {
+	struct sy7636a *sy7636a;
+	struct gpio_desc *pgood_gpio;
+};
+
 static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
 {
 	int ret;
@@ -33,10 +38,10 @@ static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
 
 static int sy7636a_get_status(struct regulator_dev *rdev)
 {
-	struct sy7636a *sy7636a = dev_get_drvdata(rdev->dev.parent);
+	struct sy7636a_data *data = dev_get_drvdata(rdev->dev.parent);
 	int ret = 0;
 
-	ret = gpiod_get_value_cansleep(sy7636a->pgood_gpio);
+	ret = gpiod_get_value_cansleep(data->pgood_gpio);
 	if (ret < 0)
 		dev_err(&rdev->dev, "Failed to read pgood gpio: %d\n", ret);
 
@@ -69,20 +74,26 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
 	struct gpio_desc *gdp;
+	struct sy7636a_data *data;
 	int ret;
 
 	if (!sy7636a)
 		return -EPROBE_DEFER;
 
-	platform_set_drvdata(pdev, sy7636a);
-
 	gdp = devm_gpiod_get(pdev->dev.parent, "epd-pwr-good", GPIOD_IN);
 	if (IS_ERR(gdp)) {
 		dev_err(pdev->dev.parent, "Power good GPIO fault %ld\n", PTR_ERR(gdp));
 		return PTR_ERR(gdp);
 	}
 
-	sy7636a->pgood_gpio = gdp;
+	data = devm_kzalloc(&pdev->dev, sizeof(struct sy7636a_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->sy7636a = sy7636a;
+	data->pgood_gpio = gdp;
+
+	platform_set_drvdata(pdev, data);
 
 	ret = regmap_write(sy7636a->regmap, SY7636A_REG_POWER_ON_DELAY_TIME, 0x0);
 	if (ret) {
-- 
2.31.1

