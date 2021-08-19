Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134EF3F1D44
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbhHSPtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:49:25 -0400
Received: from mail.ispras.ru ([83.149.199.84]:47046 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240674AbhHSPtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:49:20 -0400
Received: from kleverstation.intra.ispras.ru (unknown [10.10.2.220])
        by mail.ispras.ru (Postfix) with ESMTPS id 42C2E4076273;
        Thu, 19 Aug 2021 15:48:36 +0000 (UTC)
From:   Nadezda Lutovinova <lutovinova@ispras.ru>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Nadezda Lutovinova <lutovinova@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] usb: dwc3: imx8mp: request irq after initializing dwc3
Date:   Thu, 19 Aug 2021 18:48:18 +0300
Message-Id: <20210819154818.18334-1-lutovinova@ispras.ru>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IRQ occurs between calling  devm_request_threaded_irq() and
initializing dwc3_imx->dwc3, then null pointer dereference occurs
since dwc3_imx->dwc3 is used in dwc3_imx8mp_interrupt().

The patch puts registration of the interrupt handler after
initializing of neccesery data.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 756faa46d33a..d328d20abfbc 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -152,13 +152,6 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 	}
 	dwc3_imx->irq = irq;
 
-	err = devm_request_threaded_irq(dev, irq, NULL, dwc3_imx8mp_interrupt,
-					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
-	if (err) {
-		dev_err(dev, "failed to request IRQ #%d --> %d\n", irq, err);
-		goto disable_clks;
-	}
-
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 	err = pm_runtime_get_sync(dev);
@@ -186,6 +179,13 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 	}
 	of_node_put(dwc3_np);
 
+	err = devm_request_threaded_irq(dev, irq, NULL, dwc3_imx8mp_interrupt,
+					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
+	if (err) {
+		dev_err(dev, "failed to request IRQ #%d --> %d\n", irq, err);
+		goto depopulate;
+	}
+
 	device_set_wakeup_capable(dev, true);
 	pm_runtime_put(dev);
 
-- 
2.17.1

