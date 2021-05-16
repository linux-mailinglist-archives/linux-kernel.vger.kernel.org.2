Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CC0381D18
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 08:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhEPGYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 02:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhEPGYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 02:24:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19C3C061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 23:23:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l1so4377140ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 23:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHvjWR+kmuxYq2yuVbEUcJld2/FdM44I/SPtdrt7wUA=;
        b=AKGBAzeMwRKHkNLlldb27cVKvfYnVwbpifQEO3EH20qUqqEF+jGSWJ+mEDClwONIwV
         OTZOoSS+XPybN8U3GmncC2vf9ZzXYDAXF+IjS92yVKoUSfuVfRpQ2kE1UO8O/5D1xwei
         J6Bu4EzCd4uQ2lFjblZrP9PObU8URJwhT9UW2DFivGJ1/v3rLURMtAsV+cPleub/i7j7
         t3ZmD9X3ntwForE5PMVwX7gCKYZa00lZJEJUyDAvW6ffcelSDNE39lfn1/kmOzw6Xipx
         vHJ0c6773IrWZ5O0/Kqe8s4t6EYrfcLI4UD323MuaNgeU2/aYrXXUfpvP5WhrrjJp1Ze
         wqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lHvjWR+kmuxYq2yuVbEUcJld2/FdM44I/SPtdrt7wUA=;
        b=C1/Br3ES0Hlbj4nGWJmu9tDR4GIjI1c/lqIPBi/pbZbfvpB4sD37RoKl6GBo1pmXUM
         5gofF8jMx79ShJpqxLzyQ0eaK29fDk8lZN6il8QD4qEgXP1mpWVim/qQdkmdop1WDTEs
         7jZBiRH/yEM+/4kWwxL19lENSXI19izclO+dE3htboBbLFnr+fKTYXfdjjUGNfBm+XxD
         UY8Mw0Q9u4wUKSeA9RHXlOB7SUzb5aqTN+QHJPXpAMj56IB91EipkMPFt0p72MgBdHIp
         PqFDDd3692oqwyoM4o48wLs9bLSVodKOOW2fpKdWeNqLTLANXnQ4B/paq62zr95F1lSz
         eUBQ==
X-Gm-Message-State: AOAM531brjfQ8y83xoxLCiblfWR9NNM1smUmz3SKftHIjtrPEEkN4H/C
        rrLF9W+iOFyew6TWN1aOnFJpu+xPYjTVIDRMvu4=
X-Google-Smtp-Source: ABdhPJyrvNWhtqcRCdPcWPeFZ4pdJAIi3BPoNU+0s+/0xqPoNVkSrJULgmFrVLGYyDcnEJYwB29Rlw==
X-Received: by 2002:a17:906:3712:: with SMTP id d18mr21429429ejc.155.1621146214559;
        Sat, 15 May 2021 23:23:34 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id ks10sm6612921ejb.41.2021.05.15.23.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 23:23:34 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-sta2x11: remove platform_set_drvdata() + cleanup probe
Date:   Sun, 16 May 2021 09:23:15 +0300
Message-Id: <20210516062315.10832-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_set_drvdata() call is only useful if we need to retrieve back
the private information.
Since the driver doesn't do that, it's not useful to have it.

If this is removed, we can also just do a direct return on
devm_gpiochip_add_data(). We don't need to print that this call failed as
there are other ways to log/see this during probe.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/gpio/gpio-sta2x11.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-sta2x11.c b/drivers/gpio/gpio-sta2x11.c
index a74bb97a41e2..392fcab06ab8 100644
--- a/drivers/gpio/gpio-sta2x11.c
+++ b/drivers/gpio/gpio-sta2x11.c
@@ -398,15 +398,7 @@ static int gsta_probe(struct platform_device *dev)
 		return err;
 	}
 
-	err = devm_gpiochip_add_data(&dev->dev, &chip->gpio, chip);
-	if (err < 0) {
-		dev_err(&dev->dev, "sta2x11 gpio: Can't register (%i)\n",
-			-err);
-		return err;
-	}
-
-	platform_set_drvdata(dev, chip);
-	return 0;
+	return devm_gpiochip_add_data(&dev->dev, &chip->gpio, chip);
 }
 
 static struct platform_driver sta2x11_gpio_platform_driver = {
-- 
2.31.1

