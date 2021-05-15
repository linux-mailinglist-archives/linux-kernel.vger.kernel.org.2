Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3DF3816EC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 10:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhEOI1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 04:27:19 -0400
Received: from mx-relay84-hz1.antispameurope.com ([94.100.133.252]:50483 "EHLO
        mx-relay84-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhEOI1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 04:27:16 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 May 2021 04:27:15 EDT
Received: from smtp.eckelmann.de ([217.19.183.80]) by mx-relay84-hz1.antispameurope.com;
 Sat, 15 May 2021 10:20:48 +0200
Received: from EX-SRV1.eckelmann.group (2a00:1f08:4007:e030:172:18:30:60) by
 EX-SRV1.eckelmann.group (2a00:1f08:4007:e030:172:18:30:60) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sat, 15 May 2021 10:20:34 +0200
Received: from ws067.eckelmann.group (2a00:1f08:4007:e035:172:18:35:1a) by
 smtp.eckelmann.de (2a00:1f08:4007:e035:172:18:35:4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4 via Frontend Transport; Sat, 15 May 2021 10:20:34 +0200
From:   Thorsten Scherer <t.scherer@eckelmann.de>
To:     <u.kleine-koenig@pengutronix.de>, <gregkh@linuxfoundation.org>
CC:     <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <t.scherer@eckelmann.de>
Subject: [PATCH] siox: Simplify error handling via dev_err_probe()
Date:   Sat, 15 May 2021 10:20:17 +0200
Message-ID: <20210515082017.1127580-1-t.scherer@eckelmann.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-cloud-security-sender: t.scherer@eckelmann.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay84-hz1.antispameurope.com with 3172F172270A
X-cloud-security-connect: smtp.eckelmann.de[217.19.183.80], TLS=1, IP=217.19.183.80
X-cloud-security-Digest: ae5f8bfe5559abd0fbe6cf51802020d7
X-cloud-security: scantime:1.833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=eckelmann.de; h=from:to
        :cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=hse1; bh=yJgq9wZ+BTb+
        h/MLZC3FeJKWHUC78AJNVjrfLnHOWYk=; b=Kz2tzroiJ49ooBaLk9299Mh+5cpE
        E5DAGurPYFmC1ucFM6wN+dw+NYKt5kYHwsNdMettO91rnnYmgyBy/U7VWhB9Gcnp
        1DADkE3W2BcvavWXkEyAoKJq2sXUBjmobCU4kKgOuYSWYOwztVKxVuUCHDuuwAvO
        vl0bmieZQuDbF01fxKf5iSmhqAxsxkzTAF8X8u3zXGAEvFRMVtyUy+7Xweeultjn
        YONa2zR7f+Zqbq4aUKVp6GPPDDZSl3m/zo0TU8izV+V0eRa7hfkdbMPrQ4r5qQdL
        H1M2XnVghen+533Rd+RZFukdxN8jrP2VtWp3Dkufl6TUxk6VmFgH3+UMWQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

a787e5400a1c ("driver core: add device probe log helper") introduced a
helper for a common error checking pattern.  Use it.

Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
---
 drivers/siox/siox-bus-gpio.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/siox/siox-bus-gpio.c b/drivers/siox/siox-bus-gpio.c
index 46b4cda36bac..aeefeb725524 100644
--- a/drivers/siox/siox-bus-gpio.c
+++ b/drivers/siox/siox-bus-gpio.c
@@ -102,29 +102,29 @@ static int siox_gpio_probe(struct platform_device *pdev)
 
 	ddata->din = devm_gpiod_get(dev, "din", GPIOD_IN);
 	if (IS_ERR(ddata->din)) {
-		ret = PTR_ERR(ddata->din);
-		dev_err(dev, "Failed to get %s GPIO: %d\n", "din", ret);
+		ret = dev_err_probe(dev, PTR_ERR(ddata->din),
+				    "Failed to get din GPIO\n");
 		goto err;
 	}
 
 	ddata->dout = devm_gpiod_get(dev, "dout", GPIOD_OUT_LOW);
 	if (IS_ERR(ddata->dout)) {
-		ret = PTR_ERR(ddata->dout);
-		dev_err(dev, "Failed to get %s GPIO: %d\n", "dout", ret);
+		ret = dev_err_probe(dev, PTR_ERR(ddata->dout),
+				    "Failed to get dout GPIO\n");
 		goto err;
 	}
 
 	ddata->dclk = devm_gpiod_get(dev, "dclk", GPIOD_OUT_LOW);
 	if (IS_ERR(ddata->dclk)) {
-		ret = PTR_ERR(ddata->dclk);
-		dev_err(dev, "Failed to get %s GPIO: %d\n", "dclk", ret);
+		ret = dev_err_probe(dev, PTR_ERR(ddata->dclk),
+				    "Failed to get dclk GPIO\n");
 		goto err;
 	}
 
 	ddata->dld = devm_gpiod_get(dev, "dld", GPIOD_OUT_LOW);
 	if (IS_ERR(ddata->dld)) {
-		ret = PTR_ERR(ddata->dld);
-		dev_err(dev, "Failed to get %s GPIO: %d\n", "dld", ret);
+		ret = dev_err_probe(dev, PTR_ERR(ddata->dld),
+				    "Failed to get dld GPIO\n");
 		goto err;
 	}
 
@@ -134,7 +134,8 @@ static int siox_gpio_probe(struct platform_device *pdev)
 
 	ret = siox_master_register(smaster);
 	if (ret) {
-		dev_err(dev, "Failed to register siox master: %d\n", ret);
+		dev_err_probe(dev, ret,
+			      "Failed to register siox master\n");
 err:
 		siox_master_put(smaster);
 	}
-- 
2.29.2

