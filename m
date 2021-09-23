Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C3541644C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242501AbhIWRYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242189AbhIWRY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:24:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C29EC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:22:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bn35so650139ljb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kqgy4XtrAnXd2pwfNj+EfVSyKbIEO/VB+6CmCbnUb58=;
        b=I0Kwhlf34TW1DuoQ+RwuO0yue27TE8Y7tMoc11qLpjk3yW+l4/DoYG5Xbpo3g5lny9
         EdX1P8Wl7quuPC1PpeLn3GTeLsg72juTpB+uK8w1y7xwPqRnpSX8/NrGWBXK78wLqLeG
         DuePTk38DGSo+FISTCPDNL2Ct/vKeicrYeT2Ye33scu7jMYTchYgrkThMGGxf+TGBVZy
         zb3iwKBNKBHCDr5rNz1YniOfyQAnGaNNj2/3agCZtiwX9yXuM0eZWivvwHb24mkMLTw0
         ioeDk4qPERuaQlcffNtk8/U6zVtRGTVJi+P44P34uwV47wzSqGy7G1uCwNoBVV2wfJhj
         yt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kqgy4XtrAnXd2pwfNj+EfVSyKbIEO/VB+6CmCbnUb58=;
        b=oHwcVj4mvfw+lq7QbL8lI73V/VZqCR8gjMS35uhF8ZSsZKUGSkUNLH+wK8DA1X2f1R
         JQ8N9O+g+cANSv6ZtCK0E8Flj6+z1JObs5V9t0GnnxuQ0XelwWprpCmEJcx+Z0834fmt
         reCN7mGP6nv53IOf35+QtsUkMj3oAg88W1+YP0ZRAacor3Z8IoKaB3EoymJ6DlDvYlnt
         PwkEIae2tkcnTpCPwOsP9YF1X9l9wnmY9DPVVcA+xX9ACto5JmLbzcLppikejjSuPJAA
         PCnhdZMtdkoF381euq43E0ReEmUIt2mFw6c7L4fokTa1de47LG8C5Es5wwOe6UnXBuOE
         ip0Q==
X-Gm-Message-State: AOAM531Wlk39NmO7ewWJZlLYqJZV56K1vpObwMszggPZPCEXKIpU/GdP
        zYg+lPiznYsj+DJ5WXdF+KuK0w==
X-Google-Smtp-Source: ABdhPJyVseVGMDpMEEMzWfb3vbFS/Cx90+7pdNZah6YXtDvtAQ/Ml0GNuMXYIGzuanIC4dHHeOF/fw==
X-Received: by 2002:a2e:944d:: with SMTP id o13mr6618922ljh.419.1632417775933;
        Thu, 23 Sep 2021 10:22:55 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id p23sm336660ljm.127.2021.09.23.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:22:55 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] gpio: pca953x: do not ignore i2c errors
Date:   Thu, 23 Sep 2021 20:22:16 +0300
Message-Id: <20210923172215.18376-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>

Per gpio_chip interface, error shall be proparated to the caller.

Attempt to silent diagnostics by returning zero (as written in the
comment) is plain wrong, because the zero return can be interpreted by
the caller as the gpio value.

Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/gpio/gpio-pca953x.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index f5cfc0698799..8ebf369b3ba0 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -468,15 +468,8 @@ static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
 	mutex_lock(&chip->i2c_lock);
 	ret = regmap_read(chip->regmap, inreg, &reg_val);
 	mutex_unlock(&chip->i2c_lock);
-	if (ret < 0) {
-		/*
-		 * NOTE:
-		 * diagnostic already emitted; that's all we should
-		 * do unless gpio_*_value_cansleep() calls become different
-		 * from their nonsleeping siblings (and report faults).
-		 */
-		return 0;
-	}
+	if (ret < 0)
+		return ret;
 
 	return !!(reg_val & bit);
 }
-- 
2.30.2

