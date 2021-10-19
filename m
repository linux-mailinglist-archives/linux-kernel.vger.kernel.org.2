Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FD1434257
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 01:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhJSX7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 19:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhJSX7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 19:59:08 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61173C061746
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 16:56:54 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id j8so3292271uak.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 16:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=Psadu57ENx7zSGlF7FXcnUH65xKVT0cShGyA5O0uuR0=;
        b=ODqOboJjNhOiXi81NalCiQ/twxF5ntHRKx/4pmyPa+DUDvNWPZnIUcbN3j7XTnTNQ2
         yj8sIQ7h+Wy0If3tAzoMnSETtUqyQDtYV+NiZw3VBFkhIMRZtnwqraKDHWGM9tyPQYfY
         K4BTFg3srrrjllX5xgEbhwnjuVlnZ2ZQqKxJmtYqbQr6a78vKNTJJa2dfwj5xyVOkpJQ
         1tpPpuffgcDUkk2X5d3wsUtffRCIqsDoMDMQu/hFmYnzRwR9J/crf03ML7sZXXJBwu+d
         E7RWh+E+eBA5wGaRkhjqjEiWmU030tL5K2mRunRpx2X7N8CGOS28ZNJl1fq+05Y3UYaZ
         /+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=Psadu57ENx7zSGlF7FXcnUH65xKVT0cShGyA5O0uuR0=;
        b=eLjfD8Py5T3yfUn7l63ptDJIluxyMRe41Q3G8amKDfV8r0lwuFhU0xH1oxim1dYYuz
         Dt0V2zd1dAZqlADBzdBCnnxoc7VIYVESBt4hzlbMjMsdLK0sw3UdO0VW5rDQl1tKeSdQ
         pIWBL8B5AmZy0OxJB4za9Cvwx1ei1rSrATw5lxJrY7uqdFkrKoPavLcVGZ08yRmhXlCB
         OVeGCGdz5fukZfpvHxkO3dmW+1avNTGOj9WXzf1St2wrJy7i6qnwAKoBUcsODX0VXfUH
         0K5Pv3hIGOBnEmYXLpyj3oc39xkpXOUXQpRjZvn8cmenbuy7CfZbNWZbTqIQmep6gVQA
         Y0wg==
X-Gm-Message-State: AOAM532r3XotEomiVKoWL9nJ9T2SlFA+EcjkxufVnYsP+EeZfKL7JbK6
        3G/v7urlbrqLkEr65Hv9DyzCzA==
X-Google-Smtp-Source: ABdhPJwlLA0sh0zRvKRqiCuIt3kikTSJXJ6xr4LhbZE4d6LdVlxFRUNKwXjavMBLiItZWWAv24aMlw==
X-Received: by 2002:a9f:29a5:: with SMTP id s34mr3998999uas.122.1634687813539;
        Tue, 19 Oct 2021 16:56:53 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id j11sm405367uaa.6.2021.10.19.16.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:56:53 -0700 (PDT)
Date:   Tue, 19 Oct 2021 20:56:47 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de
Cc:     lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, helgaas@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: imx6: Replace legacy gpio interface for gpiod
 interface
Message-ID: <YW9bPy5IHzuROhrl@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the current transition of the GPIO subsystem, remove all
dependencies of the legacy GPIO interface (linux/gpio.h and linux
/of_gpio.h) and replace it with the descriptor-based GPIO approach.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
V1 -> V2: Rewrite commit log and subject line to match PCI subsystem standard
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

