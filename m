Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFFE3BE90E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhGGNyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 09:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhGGNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:54:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D240C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 06:51:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k17so3512859edq.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Om6iSfTd+vuFEObQd4saIskSqlXiWy6xm+bnPnRsnvM=;
        b=EXIxVC/xqH5Wcgj8WWZ6dgpi/n/hdiuDu03kYBnxBuqOnoUZDwOPECWYwFA/1iXpul
         c8b5NQXmZ8yQ89HhVRgpzHEDpNkGl4I081emt8h8d/G8gfhjFlwLg/rkfMSfGgJjKx2h
         w0076oLkeaSEZet5HYXhInu9Zukcd1hNGvn6ayEs1jdJ5v4tEPEf82Mjo2goYa2uEvWN
         O9HEX2NDxJd65OQlCYD7r4JR3GElqdys5Q92y6THUyyRRzxT4A3KL6O8/lA91iUKAxBt
         ZHFriX0x+Kxe9Ee/aAGuwUWykaoEHeGZZ4q7T2cvnhjYnvL34rpkAbdh6X6DDWMTMw25
         9KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Om6iSfTd+vuFEObQd4saIskSqlXiWy6xm+bnPnRsnvM=;
        b=cigniTjXZvWKz3m3v7O05Py3xQbYw2anqFF4/+uHiDuGxx4z/knwH/voMRBdmZEVQj
         U1JQAjh6pQGpCq+JR/tp1ABn5wv0NzdhQFNFfjmsM55N04veBBR5kaSRIK7UKnlV8bjI
         znjikki8zDCy+XXl07IDCMW8lb6jXgGubvPKwswJsLwR0d/PMPLX+jgdi5Ti3OyMZhTR
         D6LwNBPwVMn+7d7ET1l3OD05qUWpQFIy8JWp0uSvRJoOeBIMuJcaX55ki0M9fbh/n48j
         Mcaq8JdbMZdhcnxcXuN8DfwVV/1JYEfdnoYxk2o81Pnrl9FRytQm+RlXJoJ8WWDp+xRD
         lCjA==
X-Gm-Message-State: AOAM530d76A2KN6BUHATeljg0rx9ZrhZAaL9XMFwD6hathSvhkk6Pjle
        P9epHdXJ+SaBsT10lGGUPrssoQ==
X-Google-Smtp-Source: ABdhPJx8otZSVijGppqQTHTQynIG1zWrQfSAUKbkmY5v8N9C+Vxt6c1RWJiTLgs4sS3kSPEHvkxcCA==
X-Received: by 2002:aa7:cb03:: with SMTP id s3mr30238346edt.189.1625665915179;
        Wed, 07 Jul 2021 06:51:55 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id jx1sm7036202ejc.101.2021.07.07.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:51:54 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bgolaszewski@baylibre.com, linus.walleij@linaro.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH] gpio: viperboard: remove platform_set_drvdata() call in probe
Date:   Wed,  7 Jul 2021 16:51:44 +0300
Message-Id: <20210707135144.191567-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_set_drvdata() call is only useful if we need to retrieve back
the private information.
Since the driver doesn't do that, it's not useful to have it.

This change removes it.

Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/gpio/gpio-viperboard.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-viperboard.c b/drivers/gpio/gpio-viperboard.c
index c301c1d56dd2..98ddd6590362 100644
--- a/drivers/gpio/gpio-viperboard.c
+++ b/drivers/gpio/gpio-viperboard.c
@@ -422,12 +422,8 @@ static int vprbrd_gpio_probe(struct platform_device *pdev)
 	vb_gpio->gpiob.direction_input = vprbrd_gpiob_direction_input;
 	vb_gpio->gpiob.direction_output = vprbrd_gpiob_direction_output;
 	ret = devm_gpiochip_add_data(&pdev->dev, &vb_gpio->gpiob, vb_gpio);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(vb_gpio->gpiob.parent, "could not add gpio b");
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, vb_gpio);
 
 	return ret;
 }
-- 
2.31.1

