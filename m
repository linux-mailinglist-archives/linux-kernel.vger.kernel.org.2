Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD91334B514
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 08:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhC0HjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 03:39:04 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:28665 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhC0Hi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 03:38:57 -0400
Received: from localhost.localdomain ([90.126.11.170])
        by mwinf5d29 with ME
        id lKev2400K3g7mfN03KevSj; Sat, 27 Mar 2021 08:38:56 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 Mar 2021 08:38:56 +0100
X-ME-IP: 90.126.11.170
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski@canonical.com, nathan@kernel.org,
        arnd@arndb.de, gustavoars@kernel.org, weiyongjun1@huawei.com
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v3 2/2] usb: gadget: s3c: Fix the error handling path in 's3c2410_udc_probe()'
Date:   Sat, 27 Mar 2021 08:38:53 +0100
Message-Id: <2bee52e4ce968f48b4c32545cf8f3b2ab825ba82.1616830026.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <b317638464f188159bd8eea44427dd359e480625.1616830026.git.christophe.jaillet@wanadoo.fr>
References: <b317638464f188159bd8eea44427dd359e480625.1616830026.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some 'clk_prepare_enable()' and 'clk_get()' must be undone in the error
handling path of the probe function, as already done in the remove
function.

Fixes: 3fc154b6b813 ("USB Gadget driver for Samsung s3c2410 ARM SoC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
v2: Fix a stupid error in the hash in Fixes:
v3: Add Reviewed-by:
---
 drivers/usb/gadget/udc/s3c2410_udc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/s3c2410_udc.c b/drivers/usb/gadget/udc/s3c2410_udc.c
index b81979b3bdb6..b154b62abefa 100644
--- a/drivers/usb/gadget/udc/s3c2410_udc.c
+++ b/drivers/usb/gadget/udc/s3c2410_udc.c
@@ -1750,7 +1750,8 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 	udc_clock = clk_get(NULL, "usb-device");
 	if (IS_ERR(udc_clock)) {
 		dev_err(dev, "failed to get udc clock source\n");
-		return PTR_ERR(udc_clock);
+		retval = PTR_ERR(udc_clock);
+		goto err_usb_bus_clk;
 	}
 
 	clk_prepare_enable(udc_clock);
@@ -1773,7 +1774,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 	base_addr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base_addr)) {
 		retval = PTR_ERR(base_addr);
-		goto err;
+		goto err_udc_clk;
 	}
 
 	the_controller = udc;
@@ -1791,7 +1792,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 	if (retval != 0) {
 		dev_err(dev, "cannot get irq %i, err %d\n", irq_usbd, retval);
 		retval = -EBUSY;
-		goto err;
+		goto err_udc_clk;
 	}
 
 	dev_dbg(dev, "got irq %i\n", irq_usbd);
@@ -1862,7 +1863,14 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 		gpio_free(udc_info->vbus_pin);
 err_int:
 	free_irq(irq_usbd, udc);
-err:
+err_udc_clk:
+	clk_disable_unprepare(udc_clock);
+	clk_put(udc_clock);
+	udc_clock = NULL;
+err_usb_bus_clk:
+	clk_disable_unprepare(usb_bus_clock);
+	clk_put(usb_bus_clock);
+	usb_bus_clock = NULL;
 
 	return retval;
 }
-- 
2.27.0

