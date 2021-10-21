Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA21C43584C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 03:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhJUBi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 21:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUBiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 21:38:23 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4BBC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 18:36:08 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id r22so10251910uat.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 18:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=qdChMmbZfJDWl4yWcpsKLvPiMhQ9rd3QyvpVzVaqkko=;
        b=sc1PRjPB1B4WP6kZc3NErgzYa2ONrOCQCFwNYjrXz1MsihsiKwqEwzHgjLN/3ONpR6
         uecjxWCE6iTHibU8sHtwOPhl+iq8PY4r8v73yMIpoPQeouVBj5kn9yMkU2G2nYL4X5Ae
         YqWiejPkuBPyEdy23bRnm++o3aooKsQN+JLFOKnPrr5XZbUmpyWNjBrvqGRVMcUmSn6l
         BAMFVCbViSX1wvzYyjkRL/Cteg3mhknxQXRZsrTR5Y62PoFVBTMMrJ26fDLxylTnTJtg
         nsXmPHSQSsDGrBbvqj+QrPcHx0Q2qGQH7D3p69L5RcSb7fXta4m2CPXS/BxmV/AkeJgU
         koWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=qdChMmbZfJDWl4yWcpsKLvPiMhQ9rd3QyvpVzVaqkko=;
        b=GjwZY9JOY4u1mXOZRCzWgQnTQ8et0KnvGxeX+8EHgWj9wg3vXAhaRKc5sYIxTk90wL
         sHbQdWyHNS2fI1NRM4yKUdjKOeceWEUM497kbDnmCYEvh+8XtGnjgM7LxhmNYF7RFGy/
         KZ7fGFDikOQWCNoGHoYA4njbkTtQXmtnAr3RQv3OfpkFgIWdcLAaSOaJyJKP+BXAf4rL
         VFB/yeAj/abDg11UDpaa4q/G05j3x0qcDss2ZG1NLlln1oJteAeAIb1tGj7XXF4LNF97
         5naxNd+YDmESZGzzXOarTX85TF7JORGAS8YvPzdO+Pr5UOKlwSTlk/vSr8KomOQBruli
         dquA==
X-Gm-Message-State: AOAM532ZjcG9arey9Mmp7pk8vemsHOzdyQq0FxdzLKM6Zrzkkhie1KGs
        2OXQ4tFJFmWTQUjlztWclxQdOg==
X-Google-Smtp-Source: ABdhPJxhkeprSV8OlMtKAn3jtgdkXsNZUvRTlkidf35uF11YDkSqOg/s+QDcIixAp2pEwP7S2GyzEw==
X-Received: by 2002:a05:6102:c4b:: with SMTP id y11mr3986123vss.45.1634780167721;
        Wed, 20 Oct 2021 18:36:07 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id g6sm2394421vsj.12.2021.10.20.18.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 18:36:07 -0700 (PDT)
Date:   Wed, 20 Oct 2021 22:36:04 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [PATCH] mfd: wcd934x: Replace legacy gpio interface for gpiod
Message-ID: <YXDEBCiSnXYRQPXt@fedora>
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
 drivers/mfd/wcd934x.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
index aa19a6a4fdbf..68e2fa2fda99 100644
--- a/drivers/mfd/wcd934x.c
+++ b/drivers/mfd/wcd934x.c
@@ -2,14 +2,13 @@
 // Copyright (c) 2019, Linaro Limited
 
 #include <linux/clk.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/wcd934x/registers.h>
 #include <linux/mfd/wcd934x/wcd934x.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
@@ -210,7 +209,8 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	struct wcd934x_ddata *ddata;
-	int reset_gpio, ret;
+	struct gpio_desc *reset_gpio;
+	int ret;
 
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
@@ -221,13 +221,6 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 		return dev_err_probe(ddata->dev, ddata->irq,
 				     "Failed to get IRQ\n");
 
-	reset_gpio = of_get_named_gpio(np, "reset-gpios", 0);
-	if (reset_gpio < 0) {
-		dev_err(dev, "Failed to get reset gpio: err = %d\n",
-			reset_gpio);
-		return reset_gpio;
-	}
-
 	ddata->extclk = devm_clk_get(dev, "extclk");
 	if (IS_ERR(ddata->extclk)) {
 		dev_err(dev, "Failed to get extclk");
@@ -258,9 +251,13 @@ static int wcd934x_slim_probe(struct slim_device *sdev)
 	 * SYS_RST_N shouldn't be pulled high during this time
 	 */
 	usleep_range(600, 650);
-	gpio_direction_output(reset_gpio, 0);
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio)) {
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				"Failed to get reset gpio: err = %ld\n", PTR_ERR(reset_gpio));
+	}
 	msleep(20);
-	gpio_set_value(reset_gpio, 1);
+	gpiod_set_value(reset_gpio, 1);
 	msleep(20);
 
 	ddata->dev = dev;
-- 
2.31.1

