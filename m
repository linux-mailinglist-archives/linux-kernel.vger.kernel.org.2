Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1209A381D4F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhEPHod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 03:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhEPHob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 03:44:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50768C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 00:43:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id s22so4300527ejv.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 00:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZuJlEKURtZeYc/J4s/VV0RuP15Zpc+Mo6mw6ORDISM=;
        b=e8fdGzwQKjeF8cC2wH91qxy76ulJvbcMS6oAVyDTtMYGwDlGtDNbZ8D0ScXbumkaJ9
         Gd6EBhPWpJo+Qzrym6O392fB2Oz45aZGnDlzBLfGrrTvTh/rT/NhSl7H1V3xoJBT/ive
         yQifuR02M8QcxYQa/mefzvcd5TnY2ROUAygTO7y4q7RbO9NDWzVFfopCLVCu37wnfQn8
         mPriGo5MYyOfJU78K/jTNCrm1spVTnAXkc9TtUVkoYwUovpfkjWakToWBx75l30BUMrq
         LRzJcSlszOsPwGY7sTczh4xx7Z1AnHx4A270PsfUnMtUj0Nxqh+qonCNXf4UcSClB9IB
         HR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZuJlEKURtZeYc/J4s/VV0RuP15Zpc+Mo6mw6ORDISM=;
        b=is5j17rJjOJPwUGicpEJPS/aeSCBsU0mRhftzYc0LrHOntEHadr5YOyZuLEcw+LRKF
         1DN4tpUNI+z0RLphXR7YxIMOj462ILllXEWlbr5AFGCPVpGIBrBBQbMEY7AeI+cRsW0G
         QwrI2fX/Tmyqin7W1nmkPLV+c8PtDCx7a1S/bhirnaLZf9rDqPwOgAtc9d+eZV55Jr5k
         lcGRFn//5TFs8WEwuwziYWOuBwFbmwx8grw92Aq0UuSb0L7ppiWgeNV/TcP96YsqO5Zi
         inmko7mc2XEGZR13mf+CB2VAclgYa/V5fZmL+5odru+Jt+DasxMPcAeTYpZ8qsb6csJK
         MDDw==
X-Gm-Message-State: AOAM530xtPXDcjWSQWM3FU32skv3Ovv6GwSmbl1ksCj0Ld+rqecctWuF
        Im9QCmtIusTkSBMu5rF5YVngww==
X-Google-Smtp-Source: ABdhPJxveh/3LrYGxpQr81LQY4wFuuW8KnJj+LU3aKZyyAVv1NlGuZJAxu4O/gg6QMCUmOVs+69bIA==
X-Received: by 2002:a17:906:1997:: with SMTP id g23mr16051490ejd.168.1621150995969;
        Sun, 16 May 2021 00:43:15 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id c10sm1180195eds.90.2021.05.16.00.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 00:43:15 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: gpio-spear-spics: remove platform_set_drvdata() + cleanup probe
Date:   Sun, 16 May 2021 10:43:11 +0300
Message-Id: <20210516074311.7485-1-aardelean@deviqon.com>
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

This change isn't removing the 'DT probe failed' message, as some may find
it useful as a reason for the failed probe. But that can be part of another
change if needed.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/gpio/gpio-spear-spics.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-spear-spics.c b/drivers/gpio/gpio-spear-spics.c
index 6eca531b7d96..49aac2bb8d2c 100644
--- a/drivers/gpio/gpio-spear-spics.c
+++ b/drivers/gpio/gpio-spear-spics.c
@@ -122,7 +122,6 @@ static int spics_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct spear_spics *spics;
-	int ret;
 
 	spics = devm_kzalloc(&pdev->dev, sizeof(*spics), GFP_KERNEL);
 	if (!spics)
@@ -148,8 +147,6 @@ static int spics_gpio_probe(struct platform_device *pdev)
 				&spics->cs_enable_shift))
 		goto err_dt_data;
 
-	platform_set_drvdata(pdev, spics);
-
 	spics->chip.ngpio = NUM_OF_GPIO;
 	spics->chip.base = -1;
 	spics->chip.request = spics_request;
@@ -163,14 +160,7 @@ static int spics_gpio_probe(struct platform_device *pdev)
 	spics->chip.owner = THIS_MODULE;
 	spics->last_off = -1;
 
-	ret = devm_gpiochip_add_data(&pdev->dev, &spics->chip, spics);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to add gpio chip\n");
-		return ret;
-	}
-
-	dev_info(&pdev->dev, "spear spics registered\n");
-	return 0;
+	return devm_gpiochip_add_data(&pdev->dev, &spics->chip, spics);
 
 err_dt_data:
 	dev_err(&pdev->dev, "DT probe failed\n");
-- 
2.31.1

