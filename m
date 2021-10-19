Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C348B433A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhJSP3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhJSP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:29:17 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71957C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:27:04 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id e10so646756uab.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=x/s4SsehsStXzG2XyxMH+wRFLSyjieiFKLtaVhltnaA=;
        b=xVBFo5/+fO2Jz7eDOQ81t4yLJhNW/y5Yxokxk1PZibz+3NRkGp/IGlDejFhKlwCss0
         4ETKgV8Zd0TNX58rYC8R2JKxredPihNXWczMkulSHcLP6kgRHZvHbVp2+hZKXK5mgsRj
         f/jUopLySQRjFnPT5HQv1gBfII7Z3TjYu1QjkW3qDbso67Xk9EXN+OXmu9O3qmZ/9+4e
         9VyFIY/FP6iOXzGyx8Ih7e1H6EF/hjlq7ZFt7fWI4M+RkbiBDvHqFKQt9vlyNw2WVsCW
         lV0SdqSa3rH3oWl7YL+iZAxWkbKs6iZP7F8sjP7Gz7bmO9M6OGb9aAf7E8BtRjGW2E+D
         eyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=x/s4SsehsStXzG2XyxMH+wRFLSyjieiFKLtaVhltnaA=;
        b=lFShT0ELRSCJIiK1rQiH7XBr4/cF/xhPYKBK6wZ0dCWBdpr5acYnRI9axSGsQirZkU
         Q2/vIWMoaXWyC9j4FgWdD4Ra2bNyvdeZj9d56oIJmNKnvqwdumgmJiyu7zn/QZvMwqUc
         NKPMWTG2axvt/wck3nH6yZCv3P40eLbUfZRzwHo8PYivbUt/Rj53WkrElLSN9asMOQdW
         E1ELQtXb1b/qKhM9wm5P5piH+AIp/ual4fezs99rHtkTOghvE18OiP9j8OYD6pNs6vpO
         K9k6lEoZT3V+p8FFMho4lbz1E6ftUuK58qP50EVzUwE1A/6mwa8M2taycvAuGU8V4OZA
         I2wQ==
X-Gm-Message-State: AOAM533Yfjz/1R6QPEgYzIi1M87txREY2ZKujPncPgTUQrjbfzsYD/VM
        rVV5UNO6jX6FIVa4VjsDrvfQZA==
X-Google-Smtp-Source: ABdhPJzXNuFvi4nT8sfMd7TdSqYw9B9bqNf0S3yxbnepdEbewU/DnhvfXG2LYf9XBeWYec0SXORigQ==
X-Received: by 2002:a05:6102:a35:: with SMTP id 21mr35465813vsb.32.1634657221560;
        Tue, 19 Oct 2021 08:27:01 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id h13sm11535445vsj.20.2021.10.19.08.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 08:27:01 -0700 (PDT)
Date:   Tue, 19 Oct 2021 12:26:53 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        inux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci-imx6: replacing legacy gpio interface for gpiod
Message-ID: <YW7jvR/2jpAwSpvd@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing all dependencies of linux/gpio.h and linux/of_gpio.h and replacing
it with linux/gpio/consumer.h

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/pci/controller/dwc/pci-imx6.c | 31 ++++++++++-----------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80fc98acf097..e5ee54e37d05 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -11,13 +11,12 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/pci.h>
@@ -63,7 +62,7 @@ struct imx6_pcie_drvdata {
 
 struct imx6_pcie {
 	struct dw_pcie		*pci;
-	int			reset_gpio;
+	struct gpio_desc    *reset_gpio;
 	bool			gpio_active_high;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
@@ -526,11 +525,11 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	usleep_range(200, 500);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+	if (imx6_pcie->reset_gpio) {
+		gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
 					imx6_pcie->gpio_active_high);
 		msleep(100);
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+		gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
 					!imx6_pcie->gpio_active_high);
 	}
 
@@ -1025,22 +1024,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pci->dbi_base);
 
 	/* Fetch GPIOs */
-	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
 	imx6_pcie->gpio_active_high = of_property_read_bool(node,
 						"reset-gpio-active-high");
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		ret = devm_gpio_request_one(dev, imx6_pcie->reset_gpio,
-				imx6_pcie->gpio_active_high ?
-					GPIOF_OUT_INIT_HIGH :
-					GPIOF_OUT_INIT_LOW,
-				"PCIe reset");
-		if (ret) {
-			dev_err(dev, "unable to get reset gpio\n");
-			return ret;
-		}
-	} else if (imx6_pcie->reset_gpio == -EPROBE_DEFER) {
-		return imx6_pcie->reset_gpio;
-	}
+	imx6_pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+			imx6_pcie->gpio_active_high ?  GPIOD_OUT_HIGH :
+				GPIOD_OUT_LOW);
+	if (IS_ERR(imx6_pcie->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpio),
+					  "unable to get reset gpio\n");
 
 	/* Fetch clocks */
 	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
-- 
2.31.1

