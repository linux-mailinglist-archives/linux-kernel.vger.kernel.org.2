Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F33F0BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhHRTd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:33:29 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:59794 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233314AbhHRTd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:33:26 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d76 with ME
        id j7Yq250033riaq2037YqsC; Wed, 18 Aug 2021 21:32:50 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 18 Aug 2021 21:32:50 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alcooperx@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com
Cc:     linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] usb: bdc: Fix a resource leak in the error handling path of 'bdc_probe()'
Date:   Wed, 18 Aug 2021 21:32:49 +0200
Message-Id: <f8a4a6897deb0c8cb2e576580790303550f15fcd.1629314734.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0c5910979f39225d5d8fe68c9ab1c147c68ddee1.1629314734.git.christophe.jaillet@wanadoo.fr>
References: <0c5910979f39225d5d8fe68c9ab1c147c68ddee1.1629314734.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful 'clk_prepare_enable()' call, it must
be undone by a corresponding 'clk_disable_unprepare()' call.
This call is already present in the remove function.

Add this call in the error handling path and reorder the code so that the
'clk_prepare_enable()' call happens later in the function.
The goal is to have as much managed resources functions as possible
before the 'clk_prepare_enable()' call in order to keep the error handling
path simple.

While at it, remove the now unneeded 'clk' variable.

Fixes: c87dca047849 ("usb: bdc: Add clock enable for new chips with a separate BDC clock")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Review with care.
I don't like shuffling code like that because of possible side effect.
Moving the code related to this clk looks fine to me, but who knows...
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 251db57e51fa..fa1a3908ec3b 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -488,27 +488,14 @@ static int bdc_probe(struct platform_device *pdev)
 	int irq;
 	u32 temp;
 	struct device *dev = &pdev->dev;
-	struct clk *clk;
 	int phy_num;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
-	clk = devm_clk_get_optional(dev, "sw_usbd");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "could not enable clock\n");
-		return ret;
-	}
-
 	bdc = devm_kzalloc(dev, sizeof(*bdc), GFP_KERNEL);
 	if (!bdc)
 		return -ENOMEM;
 
-	bdc->clk = clk;
-
 	bdc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bdc->regs))
 		return PTR_ERR(bdc->regs);
@@ -545,10 +532,20 @@ static int bdc_probe(struct platform_device *pdev)
 		}
 	}
 
+	bdc->clk = devm_clk_get_optional(dev, "sw_usbd");
+	if (IS_ERR(bdc->clk))
+		return PTR_ERR(bdc->clk);
+
+	ret = clk_prepare_enable(bdc->clk);
+	if (ret) {
+		dev_err(dev, "could not enable clock\n");
+		return ret;
+	}
+
 	ret = bdc_phy_init(bdc);
 	if (ret) {
 		dev_err(bdc->dev, "BDC phy init failure:%d\n", ret);
-		return ret;
+		goto disable_clk;
 	}
 
 	temp = bdc_readl(bdc->regs, BDC_BDCCAP1);
@@ -581,6 +578,8 @@ static int bdc_probe(struct platform_device *pdev)
 	bdc_hw_exit(bdc);
 phycleanup:
 	bdc_phy_exit(bdc);
+disable_clk:
+	clk_disable_unprepare(bdc->clk);
 	return ret;
 }
 
-- 
2.30.2

