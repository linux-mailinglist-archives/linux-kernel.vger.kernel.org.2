Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447C43E9316
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhHKNyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:54:03 -0400
Received: from mail.ispras.ru ([83.149.199.84]:41814 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231769AbhHKNyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:54:02 -0400
Received: from kleverstation.intra.ispras.ru (unknown [10.10.2.220])
        by mail.ispras.ru (Postfix) with ESMTPS id 0096940755FE;
        Wed, 11 Aug 2021 13:53:37 +0000 (UTC)
From:   Nadezda Lutovinova <lutovinova@ispras.ru>
To:     Bin Liu <b-liu@ti.com>
Cc:     Nadezda Lutovinova <lutovinova@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v2] usb: musb: musb_dsps: Change function call order in dsps_probe()
Date:   Wed, 11 Aug 2021 16:53:31 +0300
Message-Id: <20210811135331.11808-1-lutovinova@ispras.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811132927.10194-1-lutovinova@ispras.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IRQ occurs between calling  dsps_setup_optional_vbus_irq()
and  dsps_create_musb_pdev(), then null pointer dereference occurs
since glue->musb wasn't initialized yet.

The patch puts initializing of neccesery data before registration
of the interrupt handler.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Nadezda Lutovinova <lutovinova@ispras.ru>
---
v2: fix subject
---
 drivers/usb/musb/musb_dsps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 5892f3ce0cdc..ce9fc46c9266 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -890,23 +890,22 @@ static int dsps_probe(struct platform_device *pdev)
 	if (!glue->usbss_base)
 		return -ENXIO;
 
-	if (usb_get_dr_mode(&pdev->dev) == USB_DR_MODE_PERIPHERAL) {
-		ret = dsps_setup_optional_vbus_irq(pdev, glue);
-		if (ret)
-			goto err_iounmap;
-	}
-
 	platform_set_drvdata(pdev, glue);
 	pm_runtime_enable(&pdev->dev);
 	ret = dsps_create_musb_pdev(glue, pdev);
 	if (ret)
 		goto err;
 
+	if (usb_get_dr_mode(&pdev->dev) == USB_DR_MODE_PERIPHERAL) {
+		ret = dsps_setup_optional_vbus_irq(pdev, glue);
+		if (ret)
+			goto err;
+	}
+
 	return 0;
 
 err:
 	pm_runtime_disable(&pdev->dev);
-err_iounmap:
 	iounmap(glue->usbss_base);
 	return ret;
 }
-- 
2.17.1

