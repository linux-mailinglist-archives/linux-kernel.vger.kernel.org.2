Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677133A920B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhFPGZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:25:19 -0400
Received: from mx-relay34-hz1.antispameurope.com ([94.100.133.210]:43707 "EHLO
        mx-relay34-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231479AbhFPGZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:25:12 -0400
Received: from smtp.eckelmann.de ([217.19.183.80]) by mx-relay34-hz1.antispameurope.com;
 Wed, 16 Jun 2021 08:18:11 +0200
Received: from EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61) by
 EX-SRV1.eckelmann.group (2a00:1f08:4007:e030:172:18:30:60) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 16 Jun 2021 08:17:44 +0200
Received: from ws067.eckelmann.group (2a00:1f08:4007:e035:172:18:35:1a) by
 smtp.eckelmann.de (2a00:1f08:4007:e035:172:18:35:5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 16 Jun 2021 08:17:44 +0200
From:   Thorsten Scherer <t.scherer@eckelmann.de>
To:     <u.kleine-koenig@pengutronix.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>,
        <t.scherer@eckelmann.de>
Subject: [PATCH v2 1/1] siox: Simplify error handling via dev_err_probe()
Date:   Wed, 16 Jun 2021 08:17:36 +0200
Message-ID: <20210616061736.3786173-2-t.scherer@eckelmann.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210616061736.3786173-1-t.scherer@eckelmann.de>
References: <20210616061736.3786173-1-t.scherer@eckelmann.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-cloud-security-sender: t.scherer@eckelmann.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay34-hz1.antispameurope.com with 201E11C9560
X-cloud-security-connect: smtp.eckelmann.de[217.19.183.80], TLS=1, IP=217.19.183.80
X-cloud-security-Digest: fe38ef0684ae7b42199c80a160d77de6
X-cloud-security: scantime:1.607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=eckelmann.de; h=from:to
        :cc:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding:content-type; s=hse1; bh=TGJMU1NFy5+w
        8h1leIAL/QDGvnC5EtsjxiTmwCCCKak=; b=Q+OxGdWjazJ7mCbYHxICeglDyXVq
        VsGn1TZjkGMAVD5KfQMUPtI01KIuYfDuumDGvZYIlBml6WgxlJHuHzo5qRKezepv
        U76WvuqvbXNlZ96HNhkw39/BLrtQH3LiNHwz6TLw23h2XY8H3n41OgC6128o3riU
        ospkcuAwqIIwoJ6dMbkMxSAuT+smf2k00MTBlQBgsqEcexmQ3iXUXJ00PRhagOKt
        yNUpzPQ3j29GHa6kZ/lDPBIlRXSVlnHB0GXM5WNBB+Ufn5e33UKR7QFeHPdTwaLn
        jRXVNLLJY+RLpP87MvQ1cXoRBOkzfhiSwI/+uqSupvkPjB6XyBFHYdqJSQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a787e5400a1c ("driver core: add device probe log helper")
introduced a helper for a common error checking pattern.  Use it.

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

