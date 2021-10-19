Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4918D433E05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbhJSSHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbhJSSHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:07:43 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D5CC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 11:05:30 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id h4so1679370uaw.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=LZblGBEcV+z39zPvty7ihBI2lmiyKfXO/4oZiKDvD8w=;
        b=gp0TVVXFFXog++jexI6vf7H1kvoZqWtsZmSA4mni1+cC2qXCqxFV3vJQblzZD2+T7a
         54NPECLaj/CSKgQd72a1OGsel5GycK2NTFxbk25CJFWCmBME4ISIGuewTcTkYGvRwb7x
         y4ZHPNVKvPJNw9hfx7wRRmKykA6WmTjueg15qL54ExyftJW+sUk87g/gQBekd9Sn9ujK
         BqPvFXLiZ3wDVgzjiKUIQL+HgolSrfG8NqvfLOG86Rab/6EQ7cr9B5BZFBNt/Jsp/VV0
         2DiJEhAaYqvm9nvY1itt63w3UMO/kgcbMntWWgR8f1gVm2qZj3orS3qbo67SK/K62wyG
         uhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=LZblGBEcV+z39zPvty7ihBI2lmiyKfXO/4oZiKDvD8w=;
        b=oBPHrM/wwq2imEh3C2U4Y6zS7/4TcucAH33y2xfF2T2kTT6RcsXUNb7dCDfoMiC+gu
         vaZ2HvZLZlJrFrwrNqnbyJvtkD5igE/tPwFY4tEpxXlrGG1BTJVK2EQy2ZPjAEZDKRjD
         8uGHHlFSNaWbjFEHvzJsnbp2JNorGetNO8Ckql6VA7IOlXUigeegmyytdAJtj6oehSdG
         YYsaGDeseC6PM4aQ0ncJJQLtJFYTOGYU+9WcCf+35lINmVYuB48oC5+uFuFM/mjy7bHx
         DQUudo52GO1luBrxQN5czJRq9UeXlyX8IwqTFVGER5DBvBoc4GAg7lNfXmDxBJKYc9d4
         e57g==
X-Gm-Message-State: AOAM532OeIxx24Sy9wkILwb1m+geCK94mhIJMBOLxi9z32E5SToyeziR
        3RcExX1a2UxXmZDmJn0PEUdKog==
X-Google-Smtp-Source: ABdhPJyWRGxvI6n597Rj04qC2bD57q/4dCu6jcpuTCHt/0/QzTwvtQ3yQNIzN+7g6PfIW3DK3rUE/w==
X-Received: by 2002:ab0:684f:: with SMTP id a15mr1675535uas.142.1634666729645;
        Tue, 19 Oct 2021 11:05:29 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id u7sm11325989uaa.14.2021.10.19.11.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 11:05:29 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:05:24 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     broonie@kernel.org, radu_nicolae.pirea@upb.ro
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi-at91-usart: replacing legacy gpio interface for gpiod
Message-ID: <YW8I5Emdc3t0cqhz@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing dependency of linux/of_gpio.h and replacing it for
linux/gpio/consumer.h

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
 drivers/spi/spi-at91-usart.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 8c8352625d23..9cd738682aab 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -14,7 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -482,29 +482,12 @@ static void at91_usart_spi_init(struct at91_usart_spi *aus)
 
 static int at91_usart_gpio_setup(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.parent->of_node;
-	int i;
-	int ret;
-	int nb;
-
-	if (!np)
-		return -EINVAL;
-
-	nb = of_gpio_named_count(np, "cs-gpios");
-	for (i = 0; i < nb; i++) {
-		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
+	struct gpio_descs *cs_gpios;
 
-		if (cs_gpio < 0)
-			return cs_gpio;
+	cs_gpios = devm_gpiod_get_array_optional(&pdev->dev, "cs", GPIOD_OUT_LOW);
 
-		if (gpio_is_valid(cs_gpio)) {
-			ret = devm_gpio_request_one(&pdev->dev, cs_gpio,
-						    GPIOF_DIR_OUT,
-						    dev_name(&pdev->dev));
-			if (ret)
-				return ret;
-		}
-	}
+	if (IS_ERR(cs_gpios))
+		return PTR_ERR(cs_gpios);
 
 	return 0;
 }
-- 
2.31.1

