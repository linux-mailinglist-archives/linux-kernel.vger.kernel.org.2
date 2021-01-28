Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76713080FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhA1WN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhA1WNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:13:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B06CC061756;
        Thu, 28 Jan 2021 14:13:01 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u14so5457657wml.4;
        Thu, 28 Jan 2021 14:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n/P5FFcNzsxODKKP+5LfDWtJfLSg3Bh91nzVHSKL8Hk=;
        b=S159UZzewbvZojYVyWKpOxEj77wOhftlSnoIJvLJGft2Fhdifw8BYGugje58RwCx6a
         RcGP5+b8pZtz/Ej/uesQJ0vyy8DvDdxPJpXUmNFBCaDFi2xJdRB2L4VNSqWyFZ/Hid7w
         nLOCNdoKR5gUHcCG3KFV43icWFQCGfXy4jsPl3WU5vhRIuqSTnD6GyqNpRiJHthp8+lZ
         RVcylz1J4Om7BD4U4qKVDz0qzt9c+l9cZhEXJ/qnqzLy+VJ8SL4gbVvgR3ozopoRFJ+a
         6g5L8NC+fL4sM+rPPvmS4fK/umzvnAaplvl/8CN7CXb9HhFurpHUbS41e8qly+gPo2gP
         6H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n/P5FFcNzsxODKKP+5LfDWtJfLSg3Bh91nzVHSKL8Hk=;
        b=ovb/sxXC2b0SFUwW6sSr4BSdLwnWks3FDtKlXUuHz/VEA//BBQPQJZMtS+GoLOLlJc
         rH2XXrFWqDyLf2/RUnSif0wT1MlfH99q2t+OJllZx6NE2sebcV6BHpv+ZmbTb9zDD8Od
         9PVvjjzyauFe/0LMtHKqvAz+LAUDraEaUouBAD1zInEUhRdFscp5OXzGPmiketdd3067
         X4e0kUzsRSgTtUvFyNuSV+5RmgMAdajqAL8+pFe1fE68KEf8cbXuf9VBg6S644cS9K3d
         fq44TEHV3IIvR9AiruUbGXEdPOcqPMDO72Qauy5OcZ8bmiycfPl+2V0S8m9LlBKqIWUN
         8/pw==
X-Gm-Message-State: AOAM532UkAjLcgkVPtdRVcORoxjGHDygQeCK2VcdycKJjx/ODBxnYXYD
        dmUg/UbkStFvR3J3l8b99UI=
X-Google-Smtp-Source: ABdhPJyYurIKduQc35t/+KvVQixNBy2wBDo76yhICMq1Tnh7ocxmAFtdddQS8Gr3mm+i8EOrGB2cBw==
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr1171088wmg.42.1611871979942;
        Thu, 28 Jan 2021 14:12:59 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd27002d89afd37b57a164.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:2d89:afd3:7b57:a164])
        by smtp.gmail.com with ESMTPSA id c9sm5284110wrw.76.2021.01.28.14.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 14:12:59 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, rikard.falkeborn@gmail.com,
        peter.chen@nxp.com, jun.li@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 2/2] phy: fsl-imx8mq-usb: handle resettable hubs
Date:   Thu, 28 Jan 2021 23:12:55 +0100
Message-Id: <20210128221255.2673992-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210128221255.2673992-1-adrien.grassein@gmail.com>
References: <20210128221255.2673992-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional GPIO in the dtb description that will
be used to reset the connected hub (if any).

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index a29b4a6f7c24..00abf7814fe9 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -4,6 +4,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -36,6 +37,7 @@ struct imx8mq_usb_phy {
 	struct clk *clk;
 	void __iomem *base;
 	struct regulator *vbus;
+	struct gpio_desc *reset_gpio;
 };
 
 static int imx8mq_usb_phy_init(struct phy *phy)
@@ -111,6 +113,9 @@ static int imx8mq_phy_power_on(struct phy *phy)
 	if (ret)
 		return ret;
 
+	if (imx_phy->reset_gpio)
+		gpiod_set_value_cansleep(imx_phy->reset_gpio, 0);
+
 	return clk_prepare_enable(imx_phy->clk);
 }
 
@@ -120,6 +125,8 @@ static int imx8mq_phy_power_off(struct phy *phy)
 
 	clk_disable_unprepare(imx_phy->clk);
 	regulator_disable(imx_phy->vbus);
+	if (imx_phy->reset_gpio)
+		gpiod_set_value_cansleep(imx_phy->reset_gpio, 1);
 
 	return 0;
 }
@@ -153,6 +160,7 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct imx8mq_usb_phy *imx_phy;
 	const struct phy_ops *phy_ops;
+	int ret;
 
 	imx_phy = devm_kzalloc(dev, sizeof(*imx_phy), GFP_KERNEL);
 	if (!imx_phy)
@@ -180,6 +188,15 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(imx_phy->vbus))
 		return PTR_ERR(imx_phy->vbus);
 
+	imx_phy->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(imx_phy->reset_gpio)) {
+		ret = PTR_ERR(imx_phy->reset_gpio);
+		if (ret == -ENXIO || ret == -ENODEV)
+			imx_phy->reset_gpio = NULL;
+		else
+			return PTR_ERR(imx_phy->reset_gpio);
+	}
+
 	phy_set_drvdata(imx_phy->phy, imx_phy);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-- 
2.25.1

